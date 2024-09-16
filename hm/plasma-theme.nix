{ pkgs, ... }:

{
  # Required packages for the theming
  home.packages = with pkgs; [
    bibata-cursors
    whitesur-kde
    kdePackages.qtstyleplugin-kvantum
    (kdePackages.callPackage ./derivations/LightlyShaders/default.nix {})
  ];
  
  # Set the Kvantum theme
  xdg.configFile = {
    "Kvantum/KvGlass/kvGlass.colors".source = ./KvGlass/kvGlass.colors;
    "Kvantum/KvGlass/KvGlass.kvconfig".source = ./KvGlass/KvGlass.kvconfig;
    "Kvantum/KvGlass/KvGlass.svg".source = ./KvGlass/KvGlass.svg;
    "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=KvGlass";
  };

  programs.plasma = {
    workspace = {
      # equivalent to Global Theme
      lookAndFeel = "org.kde.breezedark.desktop";

      # equivalent to Plasma Style
      theme = "WhiteSur-dark";

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
  };
}
