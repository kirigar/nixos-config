{ config, ... }:
{
  programs.khal = {
    enable = true;
    locale = {
      timeformat = "%H:%M";
      dateformat = "%m-%d";
    };
  };

  accounts.calendar.accounts = {
    "radicale" = {
      khal = {
        enable = true;
        type = "discover";
        color = "light blue";
      };
    };
    "university" = {
      khal = {
        enable = true;
        color = "#c72125";
      };
    };
  };
}
