# {
#   pkgs ? import <nixpkgs> {},
#   lib ? pkgs.lib,
#   stdenv ? pkgs.stdenv,
#   fetchFromGitHub ? pkgs.fetchFromGitHub,
#   cmake ? pkgs.cmake
# }:

{
  pkgs, lib, stdenv, fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "latte-spacer";
  version = "v0.1.2";

  src = fetchFromGitHub {
    owner = "psifidotos";
    repo = "applet-latte-spacer";
    rev = "v0.1.2";
    sha256 = "";
  };

  buildPhase = "";

  installPhase = ''
    kpackagetool6 -i applet-latte-spacer/
  '';
}

