{ inputs, pkgs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

    image = ../../Wallpapers/dracula-cat-282a36.png;

    fonts = {
      #monospace = {
      #  package = pkgs.maple-mono-custom;
      #  name = "Maple Mono";
      #};
      monospace = {
        package = pkgs.kode-mono;
        name = "Maple Mono";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    opacity.terminal = 0.8;

    targets = {
    };
  };
}
