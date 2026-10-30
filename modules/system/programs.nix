{ pkgs, inputs, ... }:
{
  programs = {
    zsh.enable = true;
    gpu-screen-recorder.enable = true;
  };
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      glib
      gdk-pixbuf
      gtk3
      pango
      cairo
      atk
      at-spi2-atk
      at-spi2-core
      nss
      nspr
      cups
      dbus
      expat
      libdrm
      libgbm
      mesa
      libGL
      libxkbcommon
      alsa-lib
      systemd
      libnotify
      libsecret
      libuuid
      fontconfig
      freetype
      libX11
      libXcomposite
      libXdamage
      libXext
      libXfixes
      libXrandr
      libxcb
      libxshmfence
      libXcursor
      libXi
      libXrender
      libXtst
      libXScrnSaver
    ];
  };

  environment.systemPackages = with pkgs; [
    smartmontools
    #fluxer-canary
    transmission_4-gtk
    icu
    openssl
    jdk
    maven
    wine-wayland
    python314Packages.beautifulsoup4 # for dms anime schedule widget
    brave
    fzf
    fd
    librewolf
    protonup-qt
    proton-vpn-cli
    ani-cli
    gnused
    curl
    yt-dlp
    songrec
    python314Packages.libpulse
    fastfetch
    hyfetch
    pokeget-rs
    dracula-icon-theme
    p7zip
    picard
    songrec
    puddletag
    umu-launcher
    nix-search
    feishin
    supersonic
    libqalculate
    unrar
    dialog
    libnotify
    freerdp
    termsonic
    karere
    nchat
    whatsie
    usbutils
    heroic
    linecast
    scrcpy
    bottom
    btop
    zoom-us
    r2modman
    proton-pass
    moonlight
    rstudio
    eden

    (python3.withPackages (
      python-pkgs: with python-pkgs; [
        numpy
        scipy
        sympy
        matplotlib
        adb-shell
      ]
    ))

    (rWrapper.override {
      packages = with rPackages; [
        tidyverse
        languageserver
      ];
    })
  ];

  nixpkgs.overlays = [
    inputs.fluxer.overlays.default
    (final: prev: {
      fluxer-canary = prev.fluxer-canary.overrideAttrs (old: {
        installPhase =
          builtins.replaceStrings [ "opt/Fluxer Canary" ] [ "opt/fluxer-canary" ]
            old.installPhase;
      });
    })
  ];

  nix.settings = {
  };
}
