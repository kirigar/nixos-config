{ config, ... }:
{
  config.var = {
    hostname = "polaris";

    hyprsunset.temperature = 3500;

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
}
