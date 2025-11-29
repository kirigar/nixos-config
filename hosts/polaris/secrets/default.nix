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

  home.file.".config/nixos/.sops.yaml".text = ''
    keys:
      - &primary age122w85pqj508ukv0rd388mahecgfckmpgnsgz0zcyec37ljae2epsdnvxpl
    creation_rules:
      - path_regex: hosts/polaris/secrets/secrets.yaml$
        key_groups:
          - age:
            - *primary
  '';

  home.packages = with pkgs; [
    sops
    age
  ];
}
