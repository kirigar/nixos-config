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

      neovim = {
        plugin = pkgs.vimPlugins.kanagawa-nvim;
        setup = ''
          require("kanagawa").setup({

            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none"
                        }
                    }
                }
            },

            overrides = function(colors)
              local theme = colors.theme

              local makeDiagnosticColor = function(color)
                local c = require("kanagawa.lib.color")
                return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
              end

              return {
                  NormalFloat = { bg = "none" },
                  FloatBorder = { bg = "none" },
                  FloatTitle = { bg = "none" },

                  -- Save an hlgroup with dark background and dimmed foreground
                  -- so that you can use it where your still want darker windows.
                  -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                  NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                  TelescopeTitle = { fg = theme.ui.special, bold = true },
                  TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                  TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                  TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                  TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                  TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                  TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

                  Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
                  PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                  PmenuSbar = { bg = theme.ui.bg_m1 },
                  PmenuThumb = { bg = theme.ui.bg_p2 },

                  DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
                  DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
                  DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
                  DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
              }
            end,
          })

          vim.cmd.colorscheme("kanagawa-dragon")
        '';
      };
    };
    description = "Theme configuration options";
  };

  config.stylix = {
    enable = true;

    # Tokyo Night Dark
    # See https://tinted-theming.github.io/tinted-gallery/ for more schemes
    base16Scheme = {
      base00 = "#181616";
      base01 = "#0d0c0c";
      base02 = "#2d4f67";
      base03 = "#a6a69c";
      base04 = "#7fb4ca";
      base05 = "#c5c9c5";
      base06 = "#938aa9";
      base07 = "#c5c9c5";
      base08 = "#c4746e";
      base09 = "#e46876";
      base0A = "#c4b28a";
      base0B = "#8a9a7b";
      base0C = "#8ea4a2";
      base0D = "#8ba4b0";
      base0E = "#a292a3";
      base0F = "#7aa89f";
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
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/anotherhadi/awesome-wallpapers/refs/heads/main/app/static/wallpapers/leef_dark_purple_minimalist.png";
      sha256 = "sha256-q6ufFdC/tMSb+mllw7XhilkAObemXXyps2SBlnMt7mY=";
    };

    # image = pkgs.fetchurl {
    #   url = "https://raw.githubusercontent.com/anotherhadi/awesome-wallpapers/refs/heads/main/app/static/wallpapers/alone-cloud_dark.png";
    #   sha256 = "sha256-L4Esjo6LEwhBEN29WX445F+54rlnvOtAMKsQz8Qpyuc=";
    # };

    # image = pkgs.fetchurl {
    #   url = "https://raw.githubusercontent.com/anotherhadi/awesome-wallpapers/refs/heads/main/app/static/wallpapers/the-cloud-is-hidding-the-moon_dark.png";
    #   sha256 = "sha256-EEH2cHsVromD+X5VFF3YObNuSSRbDnpfqEN6fjCztbc=";
    # };
  };
}
