{ config, pkgs, ... }:

{
  home.username = "warren";
  home.homeDirectory = "/home/warren";
  home.stateVersion = "25.05";

  home.packages = [

    # shells
    pkgs.bash
    pkgs.zsh
    pkgs.fish

    # utilities
    pkgs.neovim # https://neovim.io/

    # formatters
    pkgs.nixfmt # htts://github.com/NixOS/nixfmt
    pkgs.prettier # https://prettier.io/
    pkgs.prettierd # https://github.com/fsouza/prettierd
    pkgs.stylua # https://github.com/JohnnyMorganz/StyLua
    pkgs.shellcheck # https://github.com/koalaman/shellcheck

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

    ".config/nvim/lua/plugins/theme.lua" = {
      text = ''
        return {
          {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000
          },
          {
            "LazyVim/LazyVim",
            opts = {
              colorscheme = "catppuccin-frappe",
            },
          },
        }
      '';
    };

    ".config/nvim/lua/plugins/confirm.lua" = {
      text = ''
        return {
          {
            "stevearc/conform.nvim",

            event = { "BufWritePre" },
            cmd = { "ConformInfo" },
            keys = {
              {
                -- Customize or remove this keymap to your liking
                "<leader>f",
                function()
                  require("conform").format({ async = true })
                end,
                mode = "",
                desc = "Format buffer",
              },
            },

            opts = {
              nix = { "nixfmt" },
              lua = { "stylua" },
              json = { "prettierd", "prettier" },
            },

            default_format_opts = {
              lsp_format = "fallback",
            },

            format_on_save = { timeout_ms = 500 },

            formatters = {
              shfmt = {
                prepend_args = { "-i", "2" },
              },
            },
          },
        }
      '';
    };

    ".config/ohmyposh/spaceship.omp.json" = {
      text = ''
        {
          "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
          "shell_integration": true,
          "blocks": [
            {
              "alignment": "left",
              "segments": [
                {
                  "foreground": "#8CAAEE",
                  "style": "plain",
                  "template": "{{ .UserName }} ",
                  "type": "session"
                },
                {
                  "foreground": "#81C8BE",
                  "properties": {
                    "style": "folder"
                  },
                  "style": "plain",
                  "template": "<#B5BFE2>in</> {{ .Path }} ",
                  "type": "path"
                },
                {
                  "foreground": "#F4B8E4",
                  "properties": {
                    "branch_icon": " <#ff94df><b>\ue0a0 </b></>"
                  },
                  "style": "plain",
                  "template": "<#ffffff>on</> {{ .HEAD }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }} ",
                  "type": "git"
                }
              ],
              "type": "prompt"
            },
            {
              "alignment": "left",
              "newline": true,
              "segments": [
                {
                  "foreground": "lightGreen",
                  "style": "plain",
                  "template": "\u276f",
                  "type": "text"
                }
              ],
              "type": "prompt"
            }
          ],
          "final_space": true,
          "version": 3
        }
      '';
    };

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
