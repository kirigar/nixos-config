{ config, pkgs, ... }:
{
  programs.aerc = {
    enable = true;
    extraConfig = {
      general.unsafe-accounts-conf = true;
      filters = {
        "text/html" = "${pkgs.w3m}/bin/w3m -I UTF-8 -T text/html";
        "text/ical" = "${pkgs.bat}/bin/bat -fP --style=plain --language=ical";
        "text/*" = "${pkgs.bat}/bin/bat -fP --style=plain";
      };
    };
  };

  accounts.email.accounts = {
    main = {
      aerc.enable = true;
    };
    old = {
      aerc.enable = true;
    };
  };
}
