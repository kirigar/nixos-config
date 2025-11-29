{ config, ... }:
{
  services = {
    hyprsunset = {
      enable = true;
      settings = {
        max-gamma = 150;

        profile = [
          {
            time = "7:30";
            identity = true;
          }
          {
            time = "23:00";
            temperature = config.var.hyprsunset.temperature;
            gamma = 0.8;
          }
        ];
      };
    };
  };
}
