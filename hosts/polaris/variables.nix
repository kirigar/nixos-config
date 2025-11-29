{
  config,
  lib,
  ...
}:
{
  imports = [
    # Choose your theme here:
    ../../themes/catppuccin.nix
  ];

  config.var = {
    hostname = "polaris";
    username = "kiri";
    configDirectory = "/home/" + config.var.username + "/.config/nixos"; # The path of the nixos configuration directory

    keyboardLayout = "us";

    location = "Meterik";
    timeZone = "Europe/Amsterdam";
    defaultLocale = "en_US.UTF-8";
    timeLocale = "en_DK.UTF-8";
    numericLocale = "en_IE.UTF-8";
    otherLocale = "nl_NL.UTF-8";

    git = {
      username = "kiri";
      email = "mail@jelles.net";
    };

    preferred = {
      editor = "nvim";
      terminal = "kitty";
      browser = "brave";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;

    hyprland = {
      workspace = [
        "1, monitor:desc:LG Electronics LG ULTRAGEAR 103NTYT8R290, persistent:true, default:true"
        "2, monitor:desc:LG Electronics LG ULTRAGEAR 103NTYT8R290, persistent:true"
        "3, monitor:desc:LG Electronics LG ULTRAGEAR 103NTYT8R290, persistent:true"

        "11, monitor:desc:LG Electronics LG ULTRAGEAR 103NTJJ8R332, persistent:true, default:true"
        "12, monitor:desc:LG Electronics LG ULTRAGEAR 103NTJJ8R332, persistent:true"
        "13, monitor:desc:LG Electronics LG ULTRAGEAR 103NTJJ8R332, persistent:true"
      ];

      monitor = [
        "desc:LG Electronics LG ULTRAGEAR 103NTYT8R290,2560x1440@144,0x0,1"
        "desc:LG Electronics LG ULTRAGEAR 103NTJJ8R332,2560x1440@144,2560x0,1"
      ];
    };
  };

  # Let this here
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };
}
