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
    hostname = "altair";
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

    autoUpgrade = false;
    autoGarbageCollector = true;
    hyprland = {
      workspace = [
        "1, monitor:desc:California Institute of Technology 0x1410, persistent:true, default:true"
        "2, monitor:desc:California Institute of Technology 0x1410, persistent:true"
        "3, monitor:desc:California Institute of Technology 0x1410, persistent:true"

        "11, monitor:desc:California Institute of Technology 0x1410, persistent:true"
        "12, monitor:desc:California Institute of Technology 0x1410, persistent:true"
        "13, monitor:desc:California Institute of Technology 0x1410, persistent:true"
      ];

      monitor = [
        "desc:California Institute of Technology 0x1410,3072x1920@120,auto,1.6"
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
