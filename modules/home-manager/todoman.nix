{ config, pkgs, ... }:
{
  home.packages = [ pkgs.todoman ];

  xdg.configFile."todoman/config.py".text = ''
    path = "${config.xdg.dataHome}/calendars/*/*"
    date_format = "%d-%m-%Y"
    time_format = "%H:%M"
    default_list = "personal"
    default_due = 48
  '';
}
