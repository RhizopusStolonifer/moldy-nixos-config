{ inputs, ... }:
{
  imports = [ ./default.nix ];

  networking.hostName = "fw12";

  xdg.configFile."niri/dms/binds.kdl".source = ../../modules/myco/niri/fw12_binds.kdl;
}
