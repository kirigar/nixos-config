{ pkgs, config, ... }:
{
  programs.rbw = {
    enable = true;
    settings = {
      base_url = "https://vault.jelles.net";
      email = config.var.email;
      pinentry = pkgs.pinentry-gnome3;
    };
  };
}
