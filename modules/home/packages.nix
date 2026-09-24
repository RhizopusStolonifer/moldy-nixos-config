{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # utilities
    eza
    fd
    ripgrep
    gtrash
    tldr
    mpv
    ffmpeg
    unzip
    wget
    wl-clipboard
    xdg-utils
    winetricks

    nixd

    pavucontrol
    obs-studio
    vlc

    libreoffice
    vesktop

    prismlauncher

    # emacs
    gcc
    cmake
    libtool
    sqlite
    universal-ctags
    aspell
    aspellDicts.en
    languagetool
    pyright
    bash-language-server
    shellcheck
    shfmt
    vscode-langservers-extracted
    marksman
    lua-language-server
    texlab
    texliveMedium
    ledger
    gnumake
    pandoc
    nixfmt
    graphviz
    black
    pipenv
    python3Packages.pytest
    zeromq
    autoconf
    automake
    libtool
    pkg-config
    hledger
    hledger-ui
    hledger-web

    # neovim
    yaml-language-server
    stylua
    lazygit
  ];

  programs = {
    pay-respects = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    plover = {
      enable = true;
      package = inputs.plover-flake.packages.${pkgs.stdenv.hostPlatform.system}.plover.withPlugins (
        ps: with ps; [
          plover-lapwing-aio
          plover-clippy-2
          plover-console-ui
          # plover-excel-dictionary
          # plover-listening-lookup
          # plover-next-stroke
          plover-ninja
          plover-python-dictionary
          plover-uinput
          plover-run-shell
        ]
      );
    };
  };
}
