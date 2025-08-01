{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "kafkactl";
  version = "5.11.1";

  src = fetchFromGitHub {
    owner = "deviceinsight";
    repo = "kafkactl";
    tag = "v${version}";
    hash = "sha256-kemN4XJcXH3V7/RT9S2FLiUgS7tisK6wmHyUQnyBfhU=";
  };

  vendorHash = "sha256-rxQxNf3FBAGudgrE2wxHw4mVHxTEpQpQ+DX/nEVpoJY=";

  doCheck = false;

  meta = {
    homepage = "https://github.com/deviceinsight/kafkactl";
    changelog = "https://github.com/deviceinsight/kafkactl/blob/v${version}/CHANGELOG.md";
    description = "Command Line Tool for managing Apache Kafka";
    mainProgram = "kafkactl";
    longDescription = ''
      A command-line interface for interaction with Apache Kafka.
      Features:
      - command auto-completion for bash, zsh, fish shell including dynamic completion for e.g. topics or consumer groups
      - support for avro schemas
      - Configuration of different contexts
      - directly access kafka clusters inside your kubernetes cluster
    '';
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ grburst ];
  };
}
