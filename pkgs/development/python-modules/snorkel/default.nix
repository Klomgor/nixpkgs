{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,
  tensorboard,
  scipy,
  tqdm,
  scikit-learn,
  munkres,
  networkx,
  torch,
  pandas,
  # test dependencies
  pytestCheckHook,
  spacy,
  pyspark,
  dill,
  dask,
  spacy-models,
}:
let
  pname = "snorkel";
  version = "0.10.0";
in
buildPythonPackage {
  inherit pname version;
  format = "setuptools";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "snorkel-team";
    repo = "snorkel";
    tag = "v${version}";
    hash = "sha256-1DgkMHYToiI3266yCND1bXiui80x8AaBttxM83kJImw=";
  };

  propagatedBuildInputs = [
    tensorboard
    scipy
    tqdm
    scikit-learn
    munkres
    networkx
    torch
    pandas
  ];

  # test fail because of some wrong path references
  # things like No such file or directory: '/nix/store/8r9x7xv9nfwmd36ca28a39xaharcjdzj-python3.10-pyspark-3.4.0/lib/python3.10/site-packages/pyspark/./bin/spark-submit'
  doCheck = false;

  nativeCheckInputs = [
    pytestCheckHook
    spacy
    pyspark
    dill
    dask
    spacy-models.en_core_web_sm
  ]
  ++ dask.optional-dependencies.distributed;

  meta = with lib; {
    description = "System for quickly generating training data with weak supervision";
    homepage = "https://github.com/snorkel-team/snorkel";
    changelog = "https://github.com/snorkel/snorkel/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ happysalada ];
  };
}
