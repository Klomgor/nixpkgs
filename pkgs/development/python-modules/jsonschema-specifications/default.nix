{
  lib,
  buildPythonPackage,
  fetchPypi,
  hatch-vcs,
  hatchling,
  importlib-resources,
  pytestCheckHook,
  pythonOlder,
  referencing,
}:

buildPythonPackage rec {
  pname = "jsonschema-specifications";
  version = "2025.4.1";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchPypi {
    pname = "jsonschema_specifications";
    inherit version;
    hash = "sha256-YwFZyfTb6hYaaiIFwwEcxPGP84Gxif/0i7Obm/Jq5gg=";
  };

  nativeBuildInputs = [
    hatch-vcs
    hatchling
  ];

  propagatedBuildInputs = [
    referencing
  ]
  ++ lib.optionals (pythonOlder "3.9") [ importlib-resources ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "jsonschema_specifications" ];

  meta = with lib; {
    description = "Support files exposing JSON from the JSON Schema specifications";
    homepage = "https://github.com/python-jsonschema/jsonschema-specifications";
    license = licenses.mit;
    maintainers = with maintainers; [ SuperSandro2000 ];
  };
}
