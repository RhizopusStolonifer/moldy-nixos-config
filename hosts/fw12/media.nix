{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.syncthing = {
    enable = true;
    settings.gui = {
      user = "myco";
      password = "@Cq8TNBGh&CFjVArNjP#";
      devices = {
        "mycorrhiza" = {
          id = "QJUQ2KT-MVUK2Z2-QJLZGAI-JQ245J3-JJW3GZI-KMRIZVE-RLVBFFA-53OXFAA";
        };
      };
      folders = {
        "sync" = {
          path = "/home/myco/sync";
          devices = [ "mycorrhiza" ];
        };
      };
    };
    guiAddress = "0.0.0.0:8384";
  };
}
