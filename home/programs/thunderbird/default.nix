{
  accounts.email.accounts = {
    Main = {
      enable = true;
      address = "mail@jelles.net";
      imap = {
        authentication = "plain";
        host = "taylor.mxrouting.net";
        port = 993;
        tls.enable = true;
      };
      #passwordCommand = "rbw get \"Main E-Mail\""; #NOTE: Does not work for thunderbird
      primary = true;
      realName = "Jelle Spreeuwenberg";
      smtp = {
        authentication = "plain";
        host = "taylor.mxrouting.net";
        port = 465;
        tls.enable = true;
      };
      thunderbird = {
        enable = true;
      };
      userName = "mail@jelles.net";
    };

    Old = {
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
      thunderbird = {
        enable = true;
      };
      userName = "mail@jellespreeuwenberg.nl";
    };

    Uni = {
      # TODO: Thunderbird automatically uses normal password authentication instead of oauth, you have to manually change it
      enable = true;
      flavor = "outlook.office365.com";
      address = "j.spreeuwenberg@student.tue.nl";
      realName = "Jelle Spreeuwenberg";
      thunderbird = {
        enable = true;
      };
      userName = "j.spreeuwenberg@student.tue.nl";
    };

    Work = {
      # TODO: Thunderbird automatically uses normal password authentication instead of oauth, you have to manually change it
      enable = true;
      flavor = "outlook.office365.com";
      address = "jelle.spreeuwenberg@yookr.org";
      realName = "Jelle Spreeuwenberg";
      thunderbird = {
        enable = true;
      };
      userName = "jelle.spreeuwenberg@yookr.org";
    };
  };
  accounts.email.maildirBasePath = ".local/share/mail";

  programs.thunderbird = {
    enable = true;
    profiles.default = {
      accountsOrder = [
        "Main"
        "Old"
        "Uni"
        "Work"
      ];
      isDefault = true;
    };
  };
}
