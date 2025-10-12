{
  description = "Macbook nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
    }:
    let
      configuration =
        { pkgs, config, ... }:
        {
          nixpkgs.config.allowUnfree = true;

          environment.systemPackages = [
            pkgs.bash-language-server
            pkgs.bat
            pkgs.btop
            pkgs.chafa
            pkgs.choose-gui
            pkgs.espanso
            pkgs.eza
            pkgs.fd
            pkgs.ffmpeg
            pkgs.fzf
            pkgs.ghostty-bin
            pkgs.git
            pkgs.git-extras
            pkgs.gopls
            pkgs.harper
            pkgs.hostess
            pkgs.htop
            pkgs.intelephense
            pkgs.jankyborders
            pkgs.jq
            pkgs.kanata
            pkgs.keycastr
            pkgs.lazygit
            pkgs.lazysql
            pkgs.lua-language-server
            pkgs.lua5_4_compat
            pkgs.maccy
            pkgs.mariadb
            pkgs.marksman
            pkgs.mkcert
            pkgs.mycli
            pkgs.neovim
            pkgs.ngrok
            pkgs.nixfmt
            pkgs.php
            pkgs.pkgs.commitizen
            pkgs.pyright
            pkgs.rar
            pkgs.ripgrep
            pkgs.rust-analyzer
            pkgs.shfmt
            pkgs.spotify-player
            pkgs.sql-formatter
            pkgs.sqlitebrowser
            pkgs.sqls
            pkgs.stylua
            pkgs.switchaudio-osx
            pkgs.thonny
            pkgs.timewarrior
            pkgs.tmux
            pkgs.tree-sitter
            pkgs.typescript-language-server
            pkgs.visidata
            pkgs.vscode-extensions.xdebug.php-debug
            pkgs.vscode-langservers-extracted
            pkgs.wezterm
            pkgs.wireguard-tools
            pkgs.yazi
            pkgs.zoxide
            pkgs.zsh-autocomplete
            pkgs.zsh-autosuggestions
            pkgs.zsh-syntax-highlighting
          ];

          fonts.packages = [
            pkgs.nerd-fonts.victor-mono
            pkgs.nerd-fonts.caskaydia-cove
          ];

          homebrew = {
            enable = true;
            taps = [
              "FelixKratz/formulae"
              "nikitabobko/tap"
            ];
            brews = [
              "choose-gui"
              "nvm"
              "sketchybar"
            ];
            casks = [
              "nikitabobko/tap/aerospace"
              "hammerspoon"
              "font-sf-pro"
              "font-sf-mono-nerd-font-ligaturized"
              "font-sf-mono"
              "hiddenbar"
              "lulu"
              "mouseless"
              "pearcleaner"
              "sf-symbols"
            ];
            onActivation.cleanup = "zap";
          };

          programs.zsh = {
            enable = true;
            enableAutosuggestions = true;
            enableSyntaxHighlighting = true;
            enableCompletion = true;
          };

          nix.settings.experimental-features = "nix-command flakes";

          system.primaryUser = "cujanovic";

          system.configurationRevision = self.rev or self.dirtyRev or null;

          system.stateVersion = 6;

          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "cujanovic";
              autoMigrate = true;
            };
          }
        ];
      };
    };
}
