{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
    user = "myco";
    group = "users";
    guiPasswordFile = config.sops.secrets.syncthing_gui_password.path;
    settings = {
      gui = {
        user = "myco";
      };
      devices = {
        "mycorrhiza" = {
          id = "NZUYUSU-2E24EHV-OC4RH3K-I7AY33O-VXI3LJH-IWA7YRS-A72XJN7-T6LXUA3";
        };
      };
      folders = {
        "sync" = {
          path = "/home/myco/sync";
          devices = [ "mycorrhiza" ];
        };
      };
    };
  };
}
