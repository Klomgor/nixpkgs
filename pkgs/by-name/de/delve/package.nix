{
  lib,
  buildGoModule,
  fetchFromGitHub,
  stdenv,
}:

buildGoModule rec {
  pname = "delve";
  version = "1.25.1";

  src = fetchFromGitHub {
    owner = "go-delve";
    repo = "delve";
    rev = "v${version}";
    hash = "sha256-I7GGpLGhOp29+2V3CSSGnItSwhyrM+2yZxQsGRN812U=";
  };

  patches = [
    ./disable-fortify.diff
  ];

  vendorHash = null;

  subPackages = [ "cmd/dlv" ];

  hardeningDisable = [ "fortify" ];

  preCheck = ''
    XDG_CONFIG_HOME=$(mktemp -d)
  '';

  # Disable tests on Darwin as they require various workarounds.
  #
  # - Tests requiring local networking fail with or without sandbox,
  #   even with __darwinAllowLocalNetworking allowed.
  # - CGO_FLAGS warnings break tests' expected stdout/stderr outputs.
  # - DAP test binaries exit prematurely.
  doCheck = !stdenv.hostPlatform.isDarwin;

  postInstall = ''
    # add symlink for vscode golang extension
    # https://github.com/golang/vscode-go/blob/master/docs/debugging.md#manually-installing-dlv-dap
    ln $out/bin/dlv $out/bin/dlv-dap
  '';

  meta = with lib; {
    description = "Debugger for the Go programming language";
    homepage = "https://github.com/go-delve/delve";
    maintainers = with maintainers; [ vdemeester ];
    license = licenses.mit;
    mainProgram = "dlv";
  };
}
