{ config, pkgs, ... }:

{
  home.username = "warren";

  home.homeDirectory = "/home/warren";

  home.stateVersion = "25.05";

  home.packages = [

    # shells
    pkgs.zsh

    # utilities

    pkgs.neovim
    pkgs.starship

    # for lazyvim

    pkgs.fd
    pkgs.fzf
    pkgs.ripgrep
    pkgs.imagemagick
    pkgs.texliveMinimal
    pkgs.ast-grep
    pkgs.mermaid-cli
    pkgs.fish
    pkgs.zig
    pkgs.tectonic
    pkgs.luarocks
    pkgs.unzip
    pkgs.lazygit

    # github

    pkgs.gh

    # programming languages
    
    pkgs.gcc
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

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;

  # programs.bash = {
    
  #   enable = true;
    
  #   bashrcExtra = ''
  #       eval "$(starship init bash)"
  #     '';
    
  #   sessionVariables = {
  #     EDITOR = "nvim";
  #   };
    
  #   shellAliases = {
  #     vi = "nvim";
  #   };
  
  # };

  programs.git = {
      
      enable = true;
      userEmail = "warren@dubelyoo.com";
      userName = "Warren";
  };

  programs.starship = {
    
    enable = true;

    enableBashIntegration = true;
  
    settings = {

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

  #programs.neovim = {

    #enable = true;

    #defaultEditor = true;

  #};

}
