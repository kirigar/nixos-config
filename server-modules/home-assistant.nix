{ config, ... }:
{
  services = {
    home-assistant = {
      enable = true;
      openFirewall = false;

      extraComponents = [
        "evohome" # The Honeywell TCC (Europe) component
        "met" # Default weather
        "radio_browser" # Default radio
      ];

      # Configuration for components that support YAML (like Evohome)
      config = {
        homeassistant = {
          name = "My Home";
          latitude = 51.5; # Update with your actual location
          longitude = 5.9; # Update with your actual location
          unit_system = "metric";
          time_zone = config.var.timeZone;
        };

        # Honeywell TCC (Europe) / Evohome configuration
        # https://www.home-assistant.io/integrations/evohome/
        evohome = {
          username = "!secret honeywell_username";
          password = "!secret honeywell_password";
        };

        # Basic default setup
        default_config = { };
        http = {
          server_port = 8123;
          server_host = "127.0.0.1";
          use_x_forwarded_for = true;
          trusted_proxies = [
            "127.0.0.1"
            "::1"
          ];
        };
      };
    };

    caddy.virtualHosts."home.jelles.net".extraConfig =
      "reverse_proxy :${toString config.services.home-assistant.config.http.server_port}";
  };
}
