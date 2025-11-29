{ config, pkgs, ... }:
let
  browser = "${pkgs.brave}/bin/brave";
  htmlConverter = "${pkgs.w3m}/bin/w3m -dump -T text/html";
  openHtml = pkgs.writeShellScriptBin "open-html" ''
    TMPFILE=$(mktemp --suffix=.html)
    cat > "$TMPFILE"
    # Open in background (nohup) so it doesn't block Neomutt
    nohup ${browser} "$TMPFILE" >/dev/null 2>&1 &
  '';
in
{
  home.file.".mailcap".text = ''
    text/html; ${htmlConverter} '%s'; nametemplate=%s.html; copiousoutput
  '';

  programs = {
    mbsync.enable = true;
    msmtp.enable = true;
    notmuch.enable = true;
    # aerc = {
    #   enable = true;
    #   extraConfig = {
    #     general.unsafe-accounts-conf = true;
    #
    #     openers = {
    #       "text/html" = "${pkgs.brave}/bin/brave";
    #     };
    #
    #     filters = {
    #       "text/html" = "!${pkgs.w3m}/bin/w3m -I UTF-8 -T text/html";
    #       "text/ical" = "${pkgs.bat}/bin/bat -fP --style=plain --language=ical";
    #       "text/*" = "${pkgs.bat}/bin/bat -fP --style=plain";
    #       "image/*" = "${pkgs.catimg}/bin/catimg -2 $(tput cols) -";
    #     };
    #   };
    # };
    #
    # astroid = {
    #   enable = true;
    #   pollScript = "mbsync -a && notmuch new";
    #   externalEditor = "nvim -c 'set ft=mail' +1";
    # };
    neomutt = {
      enable = true;

      vimKeys = true;

      sidebar = {
        enable = true;
        width = 25;
        shortPath = true;
        format = "%D %?N?%N?";
      };

      macros = [
        # Press 'V' to open the current email in Brave
        {
          action = "<view-attachments><search>html<enter><pipe-entry>${openHtml}/bin/open-html<enter><exit>";
          key = "V";
          map = [
            "index"
            "pager"
          ];
        }
        # Press 'b' to toggle the sidebar
        {
          action = "<enter-command>toggle sidebar_visible<enter>";
          key = "b";
          map = [
            "index"
            "pager"
          ];
        }
      ];

      binds = [
        {
          action = "sidebar-prev";
          key = "\\Ck";
          map = [
            "index"
            "pager"
          ];
        }
        {
          action = "sidebar-next";
          key = "\\Cj";
          map = [
            "index"
            "pager"
          ];
        }
        {
          action = "sidebar-open";
          key = "\\Cl";
          map = [
            "index"
            "pager"
          ];
        }
      ];

      extraConfig = ''
        # --- HTML & Attachment Handling ---
        # Tell NeoMutt to look for HTML and Text parts
        alternative_order text/plain text/html

        # Automatically convert HTML to text using the mailcap entry we made
        auto_view text/html

        # Do not automatically show other mime types (safety/cleanliness)
        # (Except those we auto_view'ed above)

        # --- Sleek UI Settings ---
        set help = no                   # Hide the top help bar (cleaner look)
        set status_on_top = yes         # Status bar at the top looks more modern
        set wait_key = no               # Don't wait for "Press any key" after commands
        set markers = no                # Hide the + markers at wrapped lines
        set mark_old = no               # Don't distinguish between 'New' and 'Old' messages
        set menu_scroll = yes           # Scroll the menu, don't jump pages
        set pager_context = 5           # Keep 5 lines of context when scrolling
        set pager_index_lines = 10      # Show the index (list) while reading an email (split view)

        # --- Index Format (The Email List) ---
        # A clean, modern format: Date | Author | Subject
        set index_format = "%4C %Z %D  %-20.20F  %s"

        # --- Colors (Dracula-inspired for a modern feel) ---
        color normal      white           default
        color attachment  magenta         default
        color hdrdefault  cyan            default
        color indicator   black           cyan
        color markers     brightblack     default
        color message     white           default
        color quoted      green           default
        color signature   brightblack     default
        color status      white           black
        color tilde       brightblack     default
        color tree        brightblack     default
        color error       brightred       default

        # Sidebar colors
        color sidebar_new brightgreen     default
      '';
    };
  };

  accounts.email.accounts = {
    main = {
      enable = true;
      address = "mail@jelles.net";
      imap = {
        authentication = "plain";
        host = "taylor.mxrouting.net";
        port = 993;
        tls.enable = true;
      };
      passwordCommand = "rbw get \"Main E-Mail\"";
      primary = true;
      realName = "Jelle Spreeuwenberg";
      smtp = {
        authentication = "plain";
        host = "taylor.mxrouting.net";
        port = 465;
        tls.enable = true;
      };
      userName = "mail@jelles.net";

      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        patterns = [ "*" ];
      };

      msmtp.enable = true;
      notmuch.enable = true;
      neomutt.enable = true;
      # astroid.enable = true;
      # aerc.enable = true;
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
      passwordCommand = "rbw get \"Old E-Mail\"";
      realName = "Jelle Spreeuwenberg";
      smtp = {
        authentication = "plain";
        host = "taylor.mxrouting.net";
        port = 465;
        tls.enable = true;
      };
      userName = "mail@jellespreeuwenberg.nl";

      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        patterns = [ "*" ];
      };

      msmtp.enable = true;
      notmuch.enable = true;
      neomutt.enable = true;
    };

    uni = {
      # TODO: Thunderbird automatically uses normal password authentication instead of oauth, you have to manually change it
      enable = true;
      flavor = "outlook.office365.com";
      address = "j.spreeuwenberg@student.tue.nl";
      realName = "Jelle Spreeuwenberg";
      userName = "j.spreeuwenberg@student.tue.nl";
    };

    work = {
      # TODO: Thunderbird automatically uses normal password authentication instead of oauth, you have to manually change it
      enable = true;
      flavor = "outlook.office365.com";
      address = "jelle.spreeuwenberg@yookr.org";
      realName = "Jelle Spreeuwenberg";
      userName = "jelle.spreeuwenberg@yookr.org";
    };
  };
  accounts.email.maildirBasePath = "${config.xdg.dataHome}/mail";
}
