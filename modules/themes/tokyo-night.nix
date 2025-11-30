{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.theme = lib.mkOption {
    type = lib.types.attrs;
    default = {
      rounding = 17;
      gaps-in = 5;
      gaps-out = 10;
      active-opacity = 1;
      inactive-opacity = 1;
      blur = true;
      border-size = 3;
      animation-speed = "fast"; # "fast" | "medium" | "slow"
      fetch = "none"; # "nerdfetch" | "neofetch" | "pfetch" | "none"
      textColorOnWallpaper = config.lib.stylix.colors.base01; # Color of the text displayed on the wallpaper (Lockscreen, display manager, ...)

      bar = {
        # Hyprpanel
        position = "top"; # "top" | "bottom"
        transparent = true;
        transparentButtons = false;
        floating = true;
      };
    };
    description = "Theme configuration options";
  };

  config.stylix = {
    enable = true;

    # Tokyo Night Dark
    # See https://tinted-theming.github.io/tinted-gallery/ for more schemes
    base16Scheme = {
      base00 = "#1A1B26";
      base01 = "#16161E";
      base02 = "#2F3549";
      base03 = "#444B6A";
      base04 = "#787C99";
      base05 = "#A9B1D6";
      base06 = "#CBCCD1";
      base07 = "#D5D6DB";
      base08 = "#C0CAF5";
      base09 = "#A9B1D6";
      base0A = "#0DB9D7";
      base0B = "#9ECE6A";
      base0C = "#B4F9F8";
      base0D = "#2AC3DE";
      base0E = "#BB9AF7";
      base0F = "#F7768E";
    };

    cursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 28;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };

      sansSerif = {
        package = pkgs.source-sans-pro;
        name = "Source Sans Pro";
      };

      serif = config.stylix.fonts.sansSerif;

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 13;
        desktop = 13;
        popups = 15;
        terminal = 11.5;
      };
    };

    polarity = "dark";
    # image = pkgs.fetchurl {
    #   url = "https://raw.githubusercontent.com/anotherhadi/awesome-wallpapers/refs/heads/main/app/static/wallpapers/leef_dark_purple_minimalist.png";
    #   sha256 = "sha256-q6ufFdC/tMSb+mllw7XhilkAObemXXyps2SBlnMt7mY=";
    # };

    # image = pkgs.fetchurl {
    #   url = "https://raw.githubusercontent.com/anotherhadi/awesome-wallpapers/refs/heads/main/app/static/wallpapers/alone-cloud_dark.png";
    #   sha256 = "sha256-L4Esjo6LEwhBEN29WX445F+54rlnvOtAMKsQz8Qpyuc=";
    # };

    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/anotherhadi/awesome-wallpapers/refs/heads/main/app/static/wallpapers/the-cloud-is-hidding-the-moon_dark.png";
      sha256 = "sha256-EEH2cHsVromD+X5VFF3YObNuSSRbDnpfqEN6fjCztbc=";
    };
  };
}
