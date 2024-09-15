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
  imports = [
    <plasma-manager/modules>
  ];

  programs.plasma = {
    enable = true;

    workspace = {
      # equivalent to Global Theme
      lookAndFeel = "org.kde.breezedark.desktop";

      # equivalent to Plasma Style
      theme = "WhiteSur-dark";

      # equivalent to Colors
      colorScheme = "BreezeDark";

      # iconTheme = 

      # windowDecorations = {
      #   library =
      #   theme =
      # };

      cursor = {
        theme = "Bibata-Original-Ice";
	size = 32;
      };
    };

    configFile = {
      # equivalent to Application Style
      kdeglobals.KDE.widgetStyle = "kvantum";
      
      kwinrc = {
        Plugins = {
	  # disable the stock blur effect
          blurEnabled = false;
	  # enable LightlyShaders blur (installed in home.nix)
          lightlyshaders_blurEnabled = true;
	  # enable LightlyShaders window rounding
	  kwin_effect_lightlyshadersEnabled = true;
        };
	
	# configure LightlyShaders blur
	Effect-blur = {
	  BlurStrength = 9;
	  NoiseStrength = 4;
	};
	
	# configure window decorations
	"org.kde.kdecoration2" = {
	  BorderSize = "None";
          BorderSizeAuto = false;
          ButtonsOnLeft = "MF";
          library = "org.kde.breeze";
          theme = "Breeze";
	};
      };
      
      # configure outline and shadow for window decorations
      breezerc.Common = {
        OutlineCloseButton = true;
        OutlineIntensity = "OutlineOff";
        ShadowSize = "ShadowSmall";
        ShadowStrength = 153;
      };
      
      # configure LightlyShaders window rounding
      "lightlyshaders.conf".General = {
        DisabledForMaximized = true;
        InnerOutline = false;
        OuterOutline = false;
        OuterOutlineColor = "85,85,85";
        Roundness = 10;
      };
    };

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
