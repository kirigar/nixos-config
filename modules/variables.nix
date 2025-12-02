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

    syncthing = {
      devices = {
        "altair" = {
          id = "HDHWROJ-ZLNQKCL-PN6WGHA-IGJHIRI-3UHDYUU-LUJHYK4-UMKWLAZ-VFISJQF";
        };
        "orion" = {
          id = "7ESQ3BX-FEW7656-ZPT3CKF-FLXON26-HXRNTDW-THSJBNF-LFWCHFB-ASP4WAG";
        };
      };
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
