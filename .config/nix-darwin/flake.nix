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
            pkgs.android-tools
            pkgs.aerospace
            pkgs.bash-language-server
            pkgs.bat
            pkgs.btop
            pkgs.chafa
            pkgs.choose-gui
            pkgs.coreutils
            pkgs.delta
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
            pkgs.marksman
            pkgs.mkcert
            pkgs.mpremote
            pkgs.mycli
            pkgs.mysql84
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
            pkgs.sketchybar
            pkgs.spotify-player
            pkgs.sql-formatter
            pkgs.sqlitebrowser
            pkgs.sqls
            pkgs.stylua
            pkgs.switchaudio-osx
            pkgs.thonny
            pkgs.timewarrior
            pkgs.tmux
            pkgs.gitmux
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
              "acsandmann/tap"
            ];
            brews = [
              "choose-gui"
              "lua"
              "newsboat"
              "nvm"
              "pipx"
            ];
            casks = [
              "espanso"
              "font-sf-mono"
              "font-sf-mono-nerd-font-ligaturized"
              "font-sf-pro"
              "hammerspoon"
              "hiddenbar"
              "lulu"
              "mouseless@preview"
              "mysql-shell"
              "pearcleaner"
              "sf-symbols"
            ];
            masApps = {
              "AdBlock Pro" = 1018301773;
              "AdGuard for Safari" = 1440147259;
              "Adblock Plus" = 1432731683;
              "Noko" = 879917538;
              "Numbers" = 409203825;
              "Pages" = 409201541;
              "The Unarchiver" = 425424353;
              "Wipr" = 1662217862;
              "WireGuard" = 1451685025;
              "Xcode" = 497799835;
            };
            onActivation.cleanup = "zap";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;
          };

          programs.zsh = {
            enable = true;
            enableAutosuggestions = true;
            enableSyntaxHighlighting = true;
            enableCompletion = true;
          };

          services = {
            aerospace = {
              enable = true;
              settings = pkgs.lib.importTOML ../macos/aerospace/aerospace.toml;
            };
            sketchybar = {
              enable = true;
            };
            jankyborders = {
              enable = false;
              style = "round";
              width = 6.0;
              hidpi = true;
              active_color = "0xffb8bb26";
              inactive_color = "0x00000000";
            };
          };

          system = {
            defaults = {
              dock = {
                autohide = true;
                orientation = "left";
                show-process-indicators = false;
                show-recents = false;
                launchanim = false;
                static-only = true;
                tilesize = 10;
                wvous-bl-corner = 1;
                wvous-br-corner = 1;
                wvous-tl-corner = 1;
                wvous-tr-corner = 1;
              };
              finder = {
                AppleShowAllExtensions = true;
                CreateDesktop = true;
                FXEnableExtensionChangeWarning = false;
                FXPreferredViewStyle = "Nlsv";
                QuitMenuItem = true;
                ShowPathbar = true;
                ShowStatusBar = true;
              };
              loginwindow.GuestEnabled = false;
              menuExtraClock = {
                Show24Hour = true;
                ShowSeconds = true;
              };
              trackpad = {
                ActuationStrength = 0;
              };
              universalaccess.reduceTransparency = false;
              NSGlobalDomain = {
                AppleInterfaceStyle = "Dark";
                _HIHideMenuBar = true;
                KeyRepeat = 2;
                InitialKeyRepeat = 12;
                ApplePressAndHoldEnabled = false;
              };
            };
            configurationRevision = self.rev or self.dirtyRev or null;
            primaryUser = "cujanovic";
            stateVersion = 6;
            startup.chime = false;
          };
          environment.etc."pkgs-version".text = pkgs.lib.version;

          nix.settings.experimental-features = "nix-command flakes";

          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
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
