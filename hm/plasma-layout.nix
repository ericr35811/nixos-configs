let 
  panel-spacer-config = {
    General = {
      doubleClickAction = "Disabled,Disabled";
      middleClickAction = "Disabled,Disabled";
      mouseDragDownAction = "kwin,Overview";
      mouseDragLeftAction = "kwin,Switch One Desktop to the Right";
      mouseDragRightAction = "kwin,Switch One Desktop to the Left";
      mouseDragUpAction = "Disabled,Disabled";
      mouseWheelDownAction = "kmix,decrease_volume";
      mouseWheelUpAction = "kmix,increase_volume";
      pressHoldAction = "kwin,Show Desktop";
      qdbusCommand = "qdbus";
      showHoverBg = false;
      singleClickAction = "Disabled,Disabled";
    };
  };

  # function to generate a custom icon on a panel. shortcutFile refers to a filename
  # created in ~/.local/share/applications (e.g. by home.nix)
  custom-shortcut-path = "/home/eric/.local/share/applications";
  customShortcut = shortcutFile: {
    name = "org.kde.plasma.icon";
    config = {
      localPath = "${custom-shortcut-path}/${shortcutFile}.desktop";
      url ="file://${custom-shortcut-path}/${shortcutFile}.desktop";
    };
  };

in

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (kdePackages.callPackage ./derivations/latte-separator/default.nix {})
    (kdePackages.callPackage ./derivations/panel-spacer-extended/default.nix {})
  ];
  programs.plasma = {
    panels = [
      {
        location = "top";
        height = 32;
        widgets = [
	  {
            name = "org.kde.plasma.lock_logout";
	    config = {
	      General = {
	        show_requestShutDown = false;
	      };
	    };
          }

	  (customShortcut "ClassicLogout") 

	  {
	    name = "org.kde.latte.separator";
	    config = {
	      General = {
	        lengthMargin = 8;
		thicknessMargin = 2;
              };
	    };
	  }

	  (customShortcut "ScreenPortrait")
	  (customShortcut "ScreenLandscape")

          {
            name = "luisbocanegra.panelspacer.extended";
            config = panel-spacer-config;
          }

          "org.kde.plasma.appmenu"

          {
            digitalClock = {
	      date.enable = false;
	      font = {
	        family = "Cantarell";
		style = "Regular";
		size = 16;
	      };
	      calendar = {
	        plugins = [ "astronomicalevents" "holidaysevents" ];
	      };
            };
	  }

          {
            name = "luisbocanegra.panelspacer.extended";
            config = panel-spacer-config;
          }

          "org.kde.plasma.systemtray"
        ];
      }

      {
        location = "bottom";
	height = 64;
	lengthMode = "fit";
	alignment = "center";
	hiding = "dodgewindows";
	floating = true;
	#screen = "all";

	widgets = [
	  "org.kde.plasma.kickoff"

	  {
	    iconTasks = {
	      launchers = [
	        "applications:org.kde.konsole.desktop"
		"applications:systemsettings.desktop"
                "applications:firefox.desktop"
	      ];
	    };
	  }
	];
      }
    ];
  };
}
