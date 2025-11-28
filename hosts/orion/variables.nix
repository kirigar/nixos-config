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
    hostname = "orion";
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
  };

  # Let this here
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };
}
