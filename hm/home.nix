let
  HMDIR = "/etc/nixos/hm";
in
{ config, pkgs, ... }:

{
  imports = [ 
    ./plasma.nix 
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "eric";
  home.homeDirectory = "/home/eric";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  
  xdg.configFile = {
    "Kvantum/KvGlass/kvGlass.colors".source = "${HMDIR}/KvGlass/kvGlass.colors";
    "Kvantum/KvGlass/KvGlass.kvconfig".source = "${HMDIR}/KvGlass/KvGlass.kvconfig";
    "Kvantum/KvGlass/KvGlass.svg".source = "${HMDIR}/KvGlass/KvGlass.svg";
    "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=KvGlass";
  };

  home.file = {
    ".local/share/applications/ClassicLogout.desktop".text = ''
      [Desktop Entry]
      Comment=
      Exec=/run/current-system/sw/bin/qdbus org.kde.LogoutPrompt /LogoutPrompt promptAll
      GenericName=Display the logout greeter with all options like KDE <6.1
      Icon=system-log-out
      Name=ClassicLogout
      NoDisplay=false
      Path=
      StartupNotify=false
      Terminal=false
      TerminalOptions=
      Type=Application
      X-KDE-SubstituteUID=false
      X-KDE-Username=
    '';

    ".local/share/applications/ScreenPortrait.desktop".text = ''
      [Desktop Entry]
      Comment=
      Exec=/home/eric/Documents/screen.sh portrait
      GenericName=Shortcut to rotate the secondary monitor
      Icon=rotation-locked-portrait
      Name=ScreenPortrait
      NoDisplay=false
      Path=
      StartupNotify=false
      Terminal=false
      TerminalOptions=
      Type=Application
      X-KDE-SubstituteUID=false
      X-KDE-Username=
    '';
    
    ".local/share/applications/ScreenLandscape.desktop".text = ''
      [Desktop Entry]
      Comment=
      Exec=/home/eric/Documents/screen.sh landscape
      GenericName=Shortcut to rotate the secondary monitor
      Icon=rotation-locked-landscape
      Name=ScreenPortrait
      NoDisplay=false
      Path=
      StartupNotify=false
      Terminal=false
      TerminalOptions=
      Type=Application
      X-KDE-SubstituteUID=false
      X-KDE-Username=
    '';
    
    ".scripts/screen.sh" = {
      text = ''
        #!/bin/bash

        # shortcut to switch between landscape or portrait on second monitor
        # get position and rotation values from kscreen-doctor -o
        
        PRIMARY="DP-2"
        SECONDARY="DVI-D-1"
        
        case "$1" in
        	"portrait")
        		kscreen-doctor output.$SECONDARY.position.0,0   output.$SECONDARY.rotation.left   output.$PRIMARY.position.1080,159
        		;;
        	"landscape")
        		kscreen-doctor output.$SECONDARY.position.0,266 output.$SECONDARY.rotation.normal output.$PRIMARY.position.1920,0
        		;;
        esac
      '';
      executable = true;
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    pkgs.bibata-cursors
    pkgs.whitesur-kde
    pkgs.kdePackages.qtstyleplugin-kvantum
    (pkgs.kdePackages.callPackage "${HMDIR}/derivations/LightlyShaders/default.nix" {})

    pkgs.firefox

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  # };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/eric/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
