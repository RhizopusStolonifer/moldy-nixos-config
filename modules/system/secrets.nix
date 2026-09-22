{ inputs, config, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets = {
      acoustid_apikey = {
        owner = "myco";
      };
      syncthing_gui_password = {
        owner = "myco";
      };
      protonmail_bridge_password = {
        owner = "myco";
      };
    };

    templates."mu4e-authinfo" = {
      owner = "myco";
      path = "/run/secrets-rendered/mu4e-authinfo";
      content = ''
        machine 127.0.0.1 login raskpaul@protonmail.com password ${config.sops.placeholder.protonmail_bridge_password} port 1025
      '';
    };
  };
}
