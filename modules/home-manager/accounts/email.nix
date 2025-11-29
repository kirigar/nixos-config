{ config, ... }:
{
  # Global enablement
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.notmuch.enable = true;
  services.mbsync.enable = true;

  accounts.email.maildirBasePath = "${config.xdg.dataHome}/mail";

  accounts.email.accounts = {
    main = {
      enable = true;
      primary = true;
      address = "mail@jelles.net";
      imap = {
        authentication = "plain";
        host = "taylor.mxrouting.net";
        port = 993;
        tls.enable = true;
      };
      realName = "Jelle Spreeuwenberg";
      smtp = {
        authentication = "plain";
        host = "taylor.mxrouting.net";
        port = 465;
        tls.enable = true;
      };
      userName = "mail@jelles.net";
      passwordCommand = "rbw get \"Main E-Mail\"";

      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        patterns = [ "*" ];
      };
      msmtp.enable = true;
      notmuch.enable = true;
    };

    old = {
      enable = true;
      address = "mail@jellespreeuwenberg.nl";
      imap = {
        authentication = "plain";
        host = "taylor.mxrouting.net";
        port = 993;
        tls.enable = true;
      };
      realName = "Jelle Spreeuwenberg";
      smtp = {
        authentication = "plain";
        host = "taylor.mxrouting.net";
        port = 465;
        tls.enable = true;
      };
      userName = "mail@jellespreeuwenberg.nl";
      passwordCommand = "rbw get \"Old E-Mail\"";

      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        patterns = [ "*" ];
      };
      msmtp.enable = true;
      notmuch.enable = true;
    };

    uni = {
      enable = true;
      flavor = "outlook.office365.com";
      address = "j.spreeuwenberg@student.tue.nl";
      realName = "Jelle Spreeuwenberg";
      userName = "j.spreeuwenberg@student.tue.nl";
    };

    work = {
      enable = true;
      flavor = "outlook.office365.com";
      address = "jelle.spreeuwenberg@yookr.org";
      realName = "Jelle Spreeuwenberg";
      userName = "jelle.spreeuwenberg@yookr.org";
    };
  };
}
