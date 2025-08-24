{ config, pkgs, ... }:

{
  home.username = "warren";
  home.homeDirectory = "/home/warren";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [

    # shells
    bash
    zsh
    fish

    # utilities
    neovim # https://neovim.io/

    # formatters
    nixfmt # htts://github.com/NixOS/nixfmt
    prettier # https://prettier.io/
    prettierd # https://github.com/fsouza/prettierd
    stylua # https://github.com/JohnnyMorganz/StyLua
    shellcheck # https://github.com/koalaman/shellcheck

    # for lazyvim
    fd # https://github.com/sharkdp/fd
    fzf # https://github.com/junegunn/fzf
    ripgrep # https://github.com/BurntSushi/ripgrep
    imagemagick # https://imagemagick.org/
    texliveMinimal # https://www.tug.org/texlive/
    ast-grep # https://github.com/ast-grep/ast-grep
    mermaid-cli

    tectonic # https://tectonic-typesetting.github.io/en-US/
    luarocks # https://luarocks.org/
    unzip

    lazygit # https://github.com/jesseduffield/lazygit

    # lazyvim - programming
    zig # https://github.com/ziglang/zig
    gcc # https://gcc.gnu.org/

    # github
    gh

    # programming languages
    python313
    nodejs_22
    go
    rustc
    cargo

  ];

  home.file = {

    ".hushlogin" = {
      text = "";
    };

    ".config/nvim/lua/plugins/theme.lua".source = ./.config/nvim/lua/plugins/theme.lua;
    ".config/nvim/lua/plugins/confirm.lua".source = ./.config/nvim/lua/plugins/conform.lua;
    ".config/ohmyposh/spaceship.omp.json".source = ./.config/ohmyposh/spaceship.omp.json;

  };

  home.shell.enableZshIntegration = true;

  programs.home-manager.enable = true;

  programs.zsh = {

    enable = true;

    initContent = ''
      ####
      # initContent
      ####

      autoload -Uz promptinit
      promptinit
      prompt adam1

      ### Added by Zinit's installer
      if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
          print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
          command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
          command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
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
        eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/spaceship.omp.json)"
      fi

      ####
      # initContent
      ####
    '';

    dotDir = "${config.xdg.configHome}/zsh";

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

    extraConfig = {
      init.defaultBranch = "main"; # Sets 'main' as the default branch for new repositories
    };
  };

  programs.vim = {
    enable = true;

    settings = {
      expandtab = true;
      tabstop = 2;
      shiftwidth = 2;
    };
  };

}
