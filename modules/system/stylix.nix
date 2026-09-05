{ inputs, pkgs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

    # you already have the perfect wallpaper sitting right there
    image = ../../Wallpapers/dracula-cat-282a36.png;

    fonts = {
      monospace = {
        package = pkgs.maple-mono-custom;
        name = "Maple Mono";
      };
      sansSerif = {
        package = pkgs.public-sans;
        name = "Public Sans";
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

    opacity.terminal = 0.8; # matches the Ghostty setting you already had

    targets = {
      # Doom Emacs already loads `doom-dracula` itself — let Stylix leave it alone
      emacs.enable = false;
    };
  };
}
