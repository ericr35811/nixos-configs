{ config, pkgs, ... }: {
  home.file = {
    # Panel shortcut to show the old KDE logout menu with all the options
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

    # Panel shortcut to rotate the secondary screen to portrait mode
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
    
    # Panel shortcut to rotate the secondary screen to landscape mode
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
    
    # Helper script for the above two shortcuts
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

}
