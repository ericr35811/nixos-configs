# {
#   pkgs ? import <nixpkgs> {},
#   lib ? pkgs.lib,
#   stdenv ? pkgs.stdenv,
#   fetchFromGitHub ? pkgs.fetchFromGitHub,
#   cmake ? pkgs.cmake
# }:

{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  pname = "latte-separator";
  version = "v0.1.2";

  src = pkgs.fetchFromGitHub {
    owner = "psifidotos";
    repo = "applet-latte-separator";
    rev = "v0.1.2";
    sha256 = "sha256-wguheygXvLpeKmi92tnuj1Xe+JdcR3ZJL0Ihv59Zj18=";
  };

  nativeBuildInputs = [ 
    pkgs.libsForQt5.kservice
    pkgs.libsForQt5.wrapQtAppsHook
  ];
  
  buildPhase = ''
    desktoptojson -i metadata.desktop -o metadata.json
    rm metadata.desktop
  '';


  installPhase = ''
    pkgpath=$out/share/plasma/plasmoids/org.kde.latte.separator
    mkdir -p $pkgpath
    cp -r * $pkgpath/
  '';

  fixupPhase = ''
    echo no fixup required
  '';
}

