{ config, ... }:
{
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
      thunderbird = {
        enable = true;
      };
      userName = "mail@jelles.net";
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
      thunderbird = {
        enable = true;
      };
      userName = "mail@jellespreeuwenberg.nl";
    };

    uni = {
      # TODO: Thunderbird automatically uses normal password authentication instead of oauth, you have to manually change it
      enable = true;
      flavor = "outlook.office365.com";
      address = "j.spreeuwenberg@student.tue.nl";
      realName = "Jelle Spreeuwenberg";
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
          "mail.server.server_${id}.authMethod" = 10;
        };
      };
      userName = "j.spreeuwenberg@student.tue.nl";
    };

    work = {
      # TODO: Thunderbird automatically uses normal password authentication instead of oauth, you have to manually change it
      enable = true;
      flavor = "outlook.office365.com";
      address = "jelle.spreeuwenberg@yookr.org";
      realName = "Jelle Spreeuwenberg";
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
          "mail.server.server_${id}.authMethod" = 10;
        };
      };
      userName = "jelle.spreeuwenberg@yookr.org";
    };
  };

  programs.thunderbird = {
    enable = true;
    profiles.kiri = {
      isDefault = true;
      withExternalGnupg = true;
      settings = {
        # LAYOUT: Force 3-Pane Vertical View (Folders | List | Message)
        "mail.ui.display.message_pane_vertical" = true;

        # APPEARANCE: Enable "Cards View" (modern multi-line list)
        # Note: 'cards' is the value for the new view
        "mail.ui.display.thread_pane_view_type" = "cards";

        # DENSITY: "Compact" is usually cleaner for tech-savvy users
        "mail.uidensity" = 1; # 0=Default, 1=Compact, 2=Touch

        # PRIVACY & CLEANUP
        "privacy.donottrackheader.enabled" = true;
        "mail.server.server2.hidden" = true; # Hide "Local Folders"

        # Start page disable for faster boot
        "mailnews.start_page.enabled" = false;

        # Disable the "Get a new email address" feature in account manager
        "mail.provider.enabled" = false;
      };
    };
  };
}
