{ config, pkgs, ... }:
let
  # Define standard colors/icons for consistency
  domain = "jelles.net";
in
{
  # Enable the Homepage Dashboard service
  services.homepage-dashboard = {
    enable = true;
    listenPort = 8082; # Different from Glance (8101)
    allowedHosts = "dashboard.${domain}";

    # 1. Service Discovery & API Secrets
    # For live stats (widgets), Homepage needs API keys.
    # You can reference sops secrets here if you map them to a file readable by the homepage user.
    # For now, I have set them to placeholders or disabled the API widgets where secrets are required.

    services = [
      {
        "Personal" = [
          {
            "Home Assistant" = {
              href = "https://home.${domain}";
              description = "Smart Home Control";
              icon = "home-assistant.png";
              # To enable live stats (lights on, etc), un-comment and add a Long Lived Access Token:
              # widget = {
              #   type = "homeassistant";
              #   url = "http://127.0.0.1:8123";
              #   key = "YOUR_LONG_LIVED_TOKEN";
              # };
            };
          }
          {
            "Actual Budget" = {
              href = "https://finance.${domain}";
              description = "Finance Tracking";
              icon = "actual-budget.png";
            };
          }
          {
            "Vaultwarden" = {
              href = "https://vault.${domain}";
              description = "Password Manager";
              icon = "bitwarden.png";
              # Widget to show status
              widget = {
                type = "vaultwarden";
                url = "https://vault.${domain}";
              };
            };
          }
          {
            "Radicale" = {
              href = "https://radicale.${domain}";
              description = "Calendar & Contacts";
              icon = "radicale.png";
            };
          }
        ];
      }
      {
        "Code & Files" = [
          {
            "Gitea" = {
              href = "https://git.${domain}";
              description = "Git Server";
              icon = "gitea.png";
            };
          }
          {
            "FileBrowser" = {
              href = "https://files.${domain}";
              description = "Web File Manager";
              icon = "filebrowser.png";
            };
          }
        ];
      }
      {
        "Websites" = [
          {
            "Community" = {
              href = "https://community.${domain}";
              icon = "globe.png";
              description = "Community Site";
            };
          }
          {
            "Zentire" = {
              href = "https://zentire.${domain}";
              icon = "globe.png";
              description = "Zentire Site";
            };
          }
        ];
      }
    ];

    # 2. Widgets (Calendar, Search, Resources)
    widgets = [
      {
        search = {
          provider = "google";
          target = "_blank";
        };
      }
      {
        # Shows system stats. Requires 'glances' or similar installed,
        # but Homepage can also just show simple resources if running locally.
        resources = {
          cpu = true;
          memory = true;
          disk = "/";
        };
      }
      {
        # Calendar Widget linked to Radicale
        # You need the "Private Export URL" for your calendar from Radicale.
        calendar = {
          showTime = true;
          maxEvents = 10;
          integrations = [
            {
              type = "ical";
              url = "https://radicale.${domain}/kiri/personal.ics"; # Verify this path in your Radicale
              name = "Personal";
              color = "blue";
              # If your Radicale is private, you might need to pass auth in the URL
              # e.g. https://user:pass@radicale.jelles.net/...
            }
          ];
        };
      }
    ];

    settings = {
      title = "Orion Dashboard";
      background = {
        # Using the wallpaper from your config if accessible, or a hex color
        image = "https://raw.githubusercontent.com/anotherhadi/awesome-wallpapers/refs/heads/main/app/static/wallpapers/leef_dark_purple_minimalist.png";
        opacity = 50;
      };
      layout = {
        "Personal" = {
          style = "row";
          columns = 4;
        };
        "Code & Files" = {
          style = "row";
          columns = 2;
        };
        "Websites" = {
          style = "row";
          columns = 2;
        };
      };
    };
  };

  # Expose Homepage via Caddy
  services.caddy.virtualHosts."dashboard.${domain}".extraConfig = ''
    reverse_proxy :8082
  '';
}
