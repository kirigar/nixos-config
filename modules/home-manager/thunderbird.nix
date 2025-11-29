{ config, ... }:
{
  programs.thunderbird = {
    enable = true;
    profiles.${config.var.username} = {
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

  # Enable Thunderbird for specific accounts
  accounts.email.accounts = {
    main = {
      thunderbird.enable = true;
    };
    old = {
      thunderbird.enable = true;
    };
    uni = {
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
          "mail.server.server_${id}.authMethod" = 10;
        };
      };
    };
    work = {
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
          "mail.server.server_${id}.authMethod" = 10;
        };
      };
    };
  };
}
