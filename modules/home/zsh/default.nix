{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    fastSyntaxHighlighting.enable = true;

    shellAliases = {
      eza = "eza -lah";
      execute = "nix run github:thiagokokada/nix-alien --";
    };

    initExtra = ''
      switch() {
          if [ -z "$1" ]; then
              echo "Error: Commit message required."
              return 1
          fi

          z ~/moldy-nixos-config && \
          git add -A && \
          git commit -m "$1" && \
          git push && \
          nh os switch
      }
    '';

    zsh-abbr = {
      enable = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "colored-man-pages"
        "extract"
        "eza"
      ];
    };

    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
      }
      {
        name = "zsh-autopair";
        src = "${pkgs.zsh-autopair}/share/zsh/zsh-autopair";
        file = "autopair.zsh";
      }
    ];

    initContent = lib.mkMerge [
      # p10k instant prompt
      (lib.mkOrder 500 ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
        typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet;
      '')
      (lib.mkOrder 1500 ''
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '')
    ];

  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = {
    EDITOR = "emacs";
    VISUAL = "emacs";
  };

  home.sessionPath = [ "${config.home.homeDirectory}/.config/emacs/bin" ];

  #home.file.".p10k.zsh".source = ./.p10k.zsh;
}
