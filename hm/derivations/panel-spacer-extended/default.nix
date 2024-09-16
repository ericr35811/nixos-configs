# {
#   pkgs ? import <nixpkgs> {},
#   lib ? pkgs.lib,
#   stdenv ? pkgs.stdenv,
#   fetchFromGitHub ? pkgs.fetchFromGitHub,
#   cmake ? pkgs.cmake
# }:

{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  pname = "panel-spacer-extended";
  version = "1.9.0";

  src = pkgs.fetchFromGitHub {
    owner = "luisbocanegra";
    repo = "plasma-panel-spacer-extended";
    rev = "v1.9.0";
    sha256 = "sha256-3ediynClboG6/dBQTih6jJPGjsTBZhZKOPQAjGLRNmk=";
  };

  buildPhase = ''
    echo no build required
  '';

  installPhase = ''
    pkgpath=$out/share/plasma/plasmoids/luisbocanegra.panelspacer.extended
    mkdir -p $pkgpath/
    cp -r package/* $pkgpath/
  '';

  fixupPhase = ''
    echo no fixup required
  '';
}

