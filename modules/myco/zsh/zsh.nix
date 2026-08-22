{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;

    antidote = {
      enable = true;
      plugins = [''
        romkatv/powerlevel10k kind:fpath
        getantidote/use-omz
        ohmyzsh/ohmyzsh path:lib
        ohmyzsh/ohmyzsh path:plugins/colored-man-pages
        ohmyzsh/ohmyzsh path:plugins/extract
        ohmyzsh/ohmyzsh path:plugins/git
        ohmyzsh/ohmyzsh path:plugins/eza
        ohmyzsh/ohmyzsh path:plugins/archlinux
        zsh-users/zsh-autosuggestions
        zdharma-continuum/fast-syntax-highlighting kind:defer
        zsh-users/zsh-history-substring-search
        olets/zsh-abbr    kind:defer
        mattmc3/ez-compinit
        zsh-users/zsh-completions kind:fpath path:src
        hlissner/zsh-autopair
      ''];
    };

    shellAliases = {
      cd = "echo USE Z";
      ls = "echo USE EZA";
      cat = "echo USE BAT";
      eza = "eza -lah";
    };

    sessionVariables = {
      EDITOR = "emacs";
      VISUAL = "emacs";
    };

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        [ -t 1 ] && ~/.local/bin/pokemon.sh

        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '')
      (lib.mkOrder 1000 ''
        autoload -Uz promptinit && promptinit && prompt powerlevel10k
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '')
    ];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza.enable = true;
  home.packages = [ pkgs.bat ];

  home.sessionPath = [ "$HOME/.local/bin" ];
}
