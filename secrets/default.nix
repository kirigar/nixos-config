{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      radicale_pass = { };
      university_calendar_url = { };
      ssh_config_orion = {
        mode = "0600";
      };
    };
  };

  home.file.".config/nixos/secrets/.sops.yaml".text = ''
    keys:
      - &polaris age122w85pqj508ukv0rd388mahecgfckmpgnsgz0zcyec37ljae2epsdnvxpl
      - &altair age15mg7k37mc3ll60rfzx4zpzp50xjefzwy0ayjpstq5ce7raem3a7sef57w7
    creation_rules:
      - path_regex: secrets.yaml$
        key_groups:
          - age:
            - *polaris
            - *altair
  '';

  home.packages = with pkgs; [
    sops
    age
  ];
}
