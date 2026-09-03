{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ((emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: with epkgs; [
      vterm
    ]))

    ## Emacs itself
    binutils          # native-comp needs 'as'
    git
    ripgrep
    gnutls            # TLS connectivity

    ## Optional but recommended
    fd                          # faster projectile indexing
    imagemagick                  # image-dired
    pinentry-emacs                # in-emacs gnupg prompts (only useful if
                                   # programs.gnupg.agent.enable is set)
    zstd                          # undo-fu-session / undo-tree compression

    ## Doom module dependencies — trim/extend to match what you actually
    ## enable in init.el
    (aspellWithDicts (ds: with ds; [ en en-computers en-science ])) # :checkers spell
    ffmpegthumbnailer mediainfo vips              # :emacs dired +dirvish
    editorconfig editorconfig-core-c              # :tools editorconfig
    sqlite                                        # :tools lookup, :lang org +roam
    automake autoconf pkg-config libpng zlib poppler  # :tools pdf (pdf-tools build)
    clang-tools                                   # :lang cc
    texliveMedium                                 # :lang latex, org latex previews
    age                                           # :lang nix
  ];

  fonts.packages = [ pkgs.nerd-fonts.symbols-only ]; # Doom's icons
}
