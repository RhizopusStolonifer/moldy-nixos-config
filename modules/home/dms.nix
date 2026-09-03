{ ... }:
{
  programs.dms-shell = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stenv.hostPlatform.system}.default;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };
  };
}
