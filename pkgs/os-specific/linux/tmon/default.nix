{
  lib,
  stdenv,
  kernel,
  kernelModuleMakeFlags,
  ncurses,
}:

stdenv.mkDerivation {
  pname = "tmon";
  version = kernel.version;

  inherit (kernel) src;

  buildInputs = [ ncurses ];

  configurePhase = ''
    cd tools/thermal/tmon
  '';

  makeFlags = kernelModuleMakeFlags ++ [
    "INSTALL_ROOT=\"$(out)\""
    "BINDIR=bin"
  ];
  NIX_CFLAGS_LINK = "-lgcc_s";

  enableParallelBuilding = true;

  meta = with lib; {
    description = "Monitoring and Testing Tool for Linux kernel thermal subsystem";
    mainProgram = "tmon";
    homepage = "https://www.kernel.org/";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
  };
}
