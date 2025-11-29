{ pkgs, ... }:
{
  programs.rbw = {
    enable = true;
    settings = {
      base_url = "https://vault.jelles.net";
      email = "mail@jelles.net";
      pinentry = pkgs.pinentry-gnome3;
    };
  };
}
