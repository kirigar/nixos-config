{ config, ... }:
let
  monitor = "desc:California Institute of Technology 0x1410";
in
{
  config.var = {
    hostname = "altair";

    has_battery = true;

    hyprsunset.temperature = 2000;

    hyprland = {
      workspace = [
        "1, monitor:${monitor}, persistent:true, default:true"
        "2, monitor:${monitor}, persistent:true"
        "3, monitor:${monitor}, persistent:true"

        "11, monitor:${monitor}, persistent:true"
        "12, monitor:${monitor}, persistent:true"
        "13, monitor:${monitor}, persistent:true"
      ];

      monitor = [
        "${monitor},3072x1920@120,auto,1.6"
      ];
    };
  };
}
