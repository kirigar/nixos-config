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

          vim.cmd.colorscheme("kanagawa-wave")
        '';
      };
    };
    description = "Theme configuration options";
  };

  config.stylix = {
    enable = true;

    # See https =//tinted-theming.github.io/tinted-gallery/ for more schemes
    base16Scheme = {
      base00 = "#1F1F28";
      base01 = "#16161D";
      base02 = "#223249";
      base03 = "#54546D";
      base04 = "#727169";
      base05 = "#DCD7BA";
      base06 = "#C8C093";
      base07 = "#717C7C";
      base08 = "#C34043";
      base09 = "#FFA066";
      base0A = "#C0A36E";
      base0B = "#76946A";
      base0C = "#6A9589";
      base0D = "#7E9CD8";
      base0E = "#957FB8";
      base0F = "#D27E99";
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
    image = ./wallpapers/green_leaves_minimalist.png;
  };
}
