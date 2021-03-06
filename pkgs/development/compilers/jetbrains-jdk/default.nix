{ lib, openjdk11, fetchFromGitHub, jetbrains }:

openjdk11.overrideAttrs (oldAttrs: rec {
  pname = "jetbrains-jdk";
  version = "11.0.10-b1427";
  src = fetchFromGitHub {
    owner = "JetBrains";
    repo = "JetBrainsRuntime";
    rev = "jb${lib.replaceStrings ["."] ["_"] version}";
    sha256 = "sha256-2cn+FiFfGpp7CBeQMAASVZwTm6DOFaXaWxAL/nVC2Nk=";
  };
  patches = [];
  meta = with lib; {
    description = "An OpenJDK fork to better support Jetbrains's products.";
    longDescription = ''
     JetBrains Runtime is a runtime environment for running IntelliJ Platform
     based products on Windows, Mac OS X, and Linux. JetBrains Runtime is
     based on OpenJDK project with some modifications. These modifications
     include: Subpixel Anti-Aliasing, enhanced font rendering on Linux, HiDPI
     support, ligatures, some fixes for native crashes not presented in
     official build, and other small enhancements.

     JetBrains Runtime is not a certified build of OpenJDK. Please, use at
     your own risk.
    '';
    homepage = "https://bintray.com/jetbrains/intellij-jdk/";
    inherit (openjdk11.meta) license platforms mainProgram;
    maintainers = with maintainers; [ edwtjo petabyteboy ];
  };
  passthru = oldAttrs.passthru // {
    home = "${jetbrains.jdk}/lib/openjdk";
  };
})
