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
      darwinConfigurations.macbook = {
        modules = [
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
      configuration =
        { pkgs, config, ... }:
        {
          nixpkgs.config.allowUnfree = true;

          environment.systemPackages = [
            pkgs.aerospace
            pkgs.bash-language-server
            pkgs.bat
            pkgs.btop
            pkgs.chafa
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
            taps = [ "FelixKratz/formulae" ];
            brews = [
              "choose-gui"
              "sketchybar"
              "nvm"
            ];
            casks = [
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

          services.aerospace.enable = true;

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          system.primaryUser = "cujanovic";

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };
    };
}
