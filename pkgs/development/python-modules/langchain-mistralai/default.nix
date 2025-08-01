{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  pdm-backend,

  # dependencies
  langchain-core,
  tokenizers,
  httpx,
  httpx-sse,
  pydantic,

  # tests
  langchain-tests,
  pytest-asyncio,
  pytestCheckHook,

  # passthru
  gitUpdater,
}:

buildPythonPackage rec {
  pname = "langchain-mistralai";
  version = "0.2.11";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "langchain-ai";
    repo = "langchain";
    tag = "langchain-mistralai==${version}";
    hash = "sha256-14mYvW7j2hxAFZanRhuuo1seX6E4+tAuEPExDbdwHKg=";
  };

  sourceRoot = "${src.name}/libs/partners/mistralai";

  build-system = [ pdm-backend ];

  dependencies = [
    langchain-core
    tokenizers
    httpx
    httpx-sse
    pydantic
  ];

  pythonRelaxDeps = [
    # Each component release requests the exact latest core.
    # That prevents us from updating individual components.
    "langchain-core"
  ];

  nativeCheckInputs = [
    langchain-tests
    pytest-asyncio
    pytestCheckHook
  ];

  enabledTestPaths = [ "tests/unit_tests" ];

  pythonImportsCheck = [ "langchain_mistralai" ];

  passthru.updateScript = gitUpdater {
    rev-prefix = "langchain-mistralai==";
  };

  meta = {
    changelog = "https://github.com/langchain-ai/langchain-mistralai/releases/tag/${src.tag}";
    description = "Build LangChain applications with mistralai";
    homepage = "https://github.com/langchain-ai/langchain/tree/master/libs/partners/mistralai";
    license = lib.licenses.mit;
    maintainers = [
      lib.maintainers.sarahec
    ];
  };
}
