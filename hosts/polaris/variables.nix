{ config, ... }:
let
  monitor1 = "desc:LG Electronics LG ULTRAGEAR 103NTYT8R290";
  monitor2 = "desc:LG Electronics LG ULTRAGEAR 103NTJJ8R332";
in
{
  config.var = {
    hostname = "polaris";

    has_battery = false;

    hyprsunset.temperature = 3500;

    hyprland = {
      workspace = [
        "1, monitor:${monitor1}, persistent:true, default:true"
        "2, monitor:${monitor1}, persistent:true"
        "3, monitor:${monitor1}, persistent:true"

        "11, monitor:${monitor2}, persistent:true, default:true"
        "12, monitor:${monitor2}, persistent:true"
        "13, monitor:${monitor2}, persistent:true"
      ];

      monitor = [
        "${monitor1},2560x1440@144,0x0,1"
        "${monitor2},2560x1440@144,2560x0,1"
      ];
    };
  };
}
