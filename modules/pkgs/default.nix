{
  inputs,
  pkgs,
  system,
  ...
}:
{
  maple-mono-custom = pkgs.callPackage ./maple-mono { inherit inputs; };
  teto-cursor = pkgs.callPackage ./teto-cursor { };
  miku-cursor-pink = pkgs.callPackage ./miku-cursor-pink { };
  miku-cursor-miku-coloured = pkgs.callPackage ./miku-cursor-miku-coloured { };
}
