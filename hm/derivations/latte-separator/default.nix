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
  version = "9999";

  src = pkgs.fetchFromGitHub {
    owner = "doncsugar";
    repo = "applet-latte-separator";
    rev = "0340401";
    sha256 = "sha256-nKPHL03w49xkuCDQUEpcRr2bo7V+o6s28yruIz3RRhQ=";
  };

  #nativeBuildInputs = [ 
  #  pkgs.libsForQt5.kservice
  #  pkgs.libsForQt5.wrapQtAppsHook
  #];
  
  #buildPhase = ''
  #  desktoptojson -i metadata.desktop -o metadata.json
  #  rm metadata.desktop
  #'';

  buildPhase = ''
    echo no build required
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

