{ config, lib, pkgs, ... }:

{
  networking.hostName = "nixos-desktop";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    xkb.layout = "us";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
