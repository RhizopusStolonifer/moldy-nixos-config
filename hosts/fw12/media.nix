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
    settings = {
      gui = {
        user = "myco";
        password = "@Cq8TNBGh&CFjVArNjP#";
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
