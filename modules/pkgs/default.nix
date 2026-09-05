{
  inputs,
  pkgs,
  system,
  ...
}:
{
  maple-mono-custom = pkgs.callPackage ./maple-mono { inherit inputs; };
  teto-cursor = pkgs.callPackage ./teto-cursor { };
}
