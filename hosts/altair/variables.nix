{ config, ... }:
{
  config.var = {
    hostname = "altair";

    hyprsunset.temperature = 2000;

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
}
