{ config, lib, ... }:
{
  imports = [
    ./themes/kanagawa-wave.nix
  ];

  config.var = {
    username = "kiri";
    configDirectory = "/home/" + config.var.username + "/.config/nixos";

    keyboardLayout = "us";

    location = "Meterik";
    timeZone = "Europe/Amsterdam";
    defaultLocale = "en_US.UTF-8";
    timeLocale = "en_DK.UTF-8";
    numericLocale = "en_IE.UTF-8";
    otherLocale = "nl_NL.UTF-8";

    email = "mail@jelles.net";

    preferred = {
      editor = "nvim";
      terminal = "kitty";
      browser = "brave";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };
}
