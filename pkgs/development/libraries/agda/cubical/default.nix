{
  lib,
  mkDerivation,
  fetchFromGitHub,
  ghc,
}:

mkDerivation rec {
  pname = "cubical";
  version = "0.8";

  src = fetchFromGitHub {
    repo = pname;
    owner = "agda";
    rev = "v${version}";
    hash = "sha256-KwwN2g2naEo4/rKTz2L/0Guh5LxymEYP53XQzJ6eMjM=";
  };

  # The cubical library has several `Everything.agda` files, which are
  # compiled through the make file they provide.
  nativeBuildInputs = [ ghc ];
  buildPhase = ''
    runHook preBuild
    make
    runHook postBuild
  '';

  meta = with lib; {
    description = "Cubical type theory library for use with the Agda compiler";
    homepage = src.meta.homepage;
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [
      alexarice
      ryanorendorff
      ncfavier
      phijor
    ];
  };
}
