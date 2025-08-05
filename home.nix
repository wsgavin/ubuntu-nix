{ config, pkgs, ... }:

{
  home.username = "warren";
  home.homeDirectory = "/home/warren";
  home.stateVersion = "25.05";

  home.packages = [

    # shells
    pkgs.zsh
    pkgs.fish

    # utilities
    pkgs.neovim

    # for lazyvim
    pkgs.fd # https://github.com/sharkdp/fd
    pkgs.fzf # https://github.com/junegunn/fzf
    pkgs.ripgrep # https://github.com/BurntSushi/ripgrep
    pkgs.imagemagick # https://imagemagick.org/
    pkgs.texliveMinimal # https://www.tug.org/texlive/
    pkgs.ast-grep # https://github.com/ast-grep/ast-grep
    pkgs.mermaid-cli
    
    pkgs.tectonic # https://tectonic-typesetting.github.io/en-US/
    pkgs.luarocks # https://luarocks.org/
    pkgs.unzip
    
    pkgs.lazygit # https://github.com/jesseduffield/lazygit

    # lazyvim - programming
    pkgs.zig # https://github.com/ziglang/zig
    pkgs.gcc # https://gcc.gnu.org/

    # github
    pkgs.gh

    # programming languages
    pkgs.python313
    pkgs.nodejs_22
    pkgs.go
    pkgs.rustc
    pkgs.cargo

  ];

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;

    ".hushlogin" = {
      text = "";
    };

  };

  programs.home-manager.enable = true;

  programs.zsh = {
    
    enable = true;

    initContent = ''
      ####
      # home-manager - initContent
      ####
      
      autoload -Uz promptinit
      promptinit
      prompt adam1
      
      zstyle ':completion:*' auto-description 'specify: %d'
      zstyle ':completion:*' completer _expand _complete _correct _approximate
      zstyle ':completion:*' format 'Completing %d'
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' menu select=2
      eval "$(dircolors -b)"
      zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' list-colors '''
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ':completion:*' matcher-list ''' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|      =*'
      zstyle ':completion:*' menu select=long
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion:*' use-compctl false
      zstyle ':completion:*' verbose true
      
      zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
      zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
      
      
      ### Added by Zinit's installer
      if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
          print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F      {33}zdharma-continuum/zinit%F{220})…%f"
          command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
          command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.      git" && \
              print -P "%F{33} %F{34}Installation successful.%f%b" || \
              print -P "%F{160} The clone has failed.%f%b"
      fi
      
      source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
      autoload -Uz _zinit
      (( ''${+_comps} )) && _comps[zinit]=_zinit
      
      # Load a few important annexes, without Turbo
      # (this is currently required for annexes)
      zinit light-mode for \
          zdharma-continuum/zinit-annex-as-monitor \
          zdharma-continuum/zinit-annex-bin-gem-node \
          zdharma-continuum/zinit-annex-patch-dl \
          zdharma-continuum/zinit-annex-rust
      
      ### End of Zinit's installer chunk
      
      export PATH=$PATH:/home/warren/.local/bin
      
      if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
        eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.toml)"
      fi
      
      ####
      # home-manager - initContent done.
      ####
    '';

    sessionVariables = {
      EDITOR = "nvim";
    };
    
    shellAliases = {
      ls = "ls --color";
      vi = "nvim";
    };

    history = {
      ignoreAllDups = true;
      share = true;
      size = 10000;
      save = 10000;
    };
  
  };

  programs.git = {  
    enable = true;
    userEmail = "warren@dubelyoo.com";
    userName = "Warren";
  };

  programs.vim = {
    enable = true;

    settings = {
      expandtab = true;
      tabstop = 2;
      shiftwidth = 2;
    };
  };

  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  # };

}
