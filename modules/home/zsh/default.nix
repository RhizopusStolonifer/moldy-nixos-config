{
  config,
  lib,
  pkgs,
  host,
  ...
}:
{
  xdg.configFile."fastfetch/config.jsonc".source = ./config.jsonc;

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    fastSyntaxHighlighting.enable = true;

    shellAliases = {
      eza = "eza -lah";
      execute = "nix run github:thiagokokada/nix-alien --";
    };

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
      (lib.mkOrder 500 ''
        eval "$(pay-respects zsh)"
        ${lib.optionalString (host == "mycorrhiza") "bash ${./pokemon.sh}"}
      '')
      (lib.mkOrder 1500 ''
        ${lib.optionalString (host != "mycorrhiza") "bindkey -v"}
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
      '')
    ];

  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$os$directory$git_branch$git_status\n$character";
      right_format = "$status$cmd_duration$jobs$direnv$nix_shell$python$aws$gcloud$kubernetes$terraform";
      os.disabled = false;
      status.disabled = false;
      cmd_duration.min_time = 3000;
    };
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
}
