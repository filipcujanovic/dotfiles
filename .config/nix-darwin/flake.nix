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
            #pkgs.choose-gui
            #pkgs.intelephense
            #pkgs.marksman
            #pkgs.sketchybar
            pkgs.android-tools
            pkgs.bash-language-server
            pkgs.bat
            pkgs.btop
            pkgs.chafa
            pkgs.commitizen
            pkgs.coreutils
            pkgs.delta
            pkgs.docker-compose
            pkgs.espanso
            pkgs.eza
            pkgs.fd
            pkgs.ffmpeg
            pkgs.fzf
            pkgs.ghostty-bin
            pkgs.git
            pkgs.git-extras
            pkgs.gitmux
            pkgs.gopls
            pkgs.harper
            pkgs.htop
            pkgs.jankyborders
            pkgs.jq
            pkgs.kanata
            pkgs.keycastr
            pkgs.keymap-drawer
            pkgs.lazydocker
            pkgs.lazygit
            pkgs.lazysql
            pkgs.localtunnel
            pkgs.lua-language-server
            pkgs.lua5_4_compat
            pkgs.maccy
            pkgs.markdown-oxide
            pkgs.mkcert
            pkgs.mongosh
            pkgs.mpremote
            pkgs.mycli
            pkgs.mysql-shell
            pkgs.mysql84
            #pkgs.neovim
            pkgs.ngrok
            pkgs.nixfmt
            pkgs.php
            pkgs.prettier
            pkgs.pyright
            pkgs.rar
            pkgs.ripgrep
            pkgs.rust-analyzer
            pkgs.shfmt
            pkgs.sql-formatter
            pkgs.sqlitebrowser
            pkgs.sqls
            pkgs.stylua
            pkgs.switchaudio-osx
            pkgs.taplo
            pkgs.terminal-notifier
            pkgs.thonny
            pkgs.timewarrior
            pkgs.tmux
            pkgs.tree-sitter
            pkgs.typescript-go
            pkgs.typescript-language-server
            pkgs.visidata
            pkgs.vscode-extensions.xdebug.php-debug
            pkgs.vscode-langservers-extracted
            pkgs.watch
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
            pkgs.nerd-fonts.symbols-only
          ];

          homebrew = {
            enable = true;
            taps = [
              "FelixKratz/formulae"
              "acsandmann/tap"
              "chojs23/tap"
              "daipeihust/tap"
              "mikker/tap"
              "mongodb/brew"
              "nikitabobko/tap"
              "tonisives/tap"
            ];
            brews = [
              "acsandmann/tap/rift"
              "choose-gui"
              "ec"
              "gh"
              "im-select"
              "lua"
              "marksman"
              #"mas"
              "media-control"
              "mongodb-database-tools"
              "neovim"
              "newsboat"
              "nvm"
              "pipx"
              "sketchybar"
            ];
            casks = [
              "aerospace"
              "affinity"
              "balenaetcher"
              "betterdisplay"
              "calibre"
              "claude-code"
              "docker-desktop"
              "espanso"
              "font-sf-mono"
              "font-sf-mono-nerd-font-ligaturized"
              "font-sf-pro"
              "font-sketchybar-app-font"
              "hakuneko"
              "hammerspoon"
              "homerow"
              "kitty"
              "lulu"
              "macs-fan-control"
              "mongodb-compass"
              "mouseless@preview"
              "pearcleaner"
              "sf-symbols"
              "signal"
              "the-unarchiver"
              "viber"
              "vlc"
              #"helium-browser"
              #"mysql-shell"
              #"ovim"
            ];
            masApps = {
              #"Better Clipboard" = 6756281636;
              #"ScreenBrush" = 1233965871;
              #"AdBlock Pro" = 1018301773;
              #"AdGuard for Safari" = 1440147259;
              #"Adblock Plus" = 1432731683;
              #"Noko" = 879917538;
              #"Wipr" = 1662217862;
              #"WireGuard" = 1451685025;
              #"Xcode" = 497799835;
            };
            onActivation.cleanup = "zap";
            #onActivation.autoUpdate = true;
            onActivation.upgrade = true;
          };

          programs.zsh = {
            enable = true;
            enableAutosuggestions = true;
            enableSyntaxHighlighting = true;
            enableCompletion = true;
          };

          services = {
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
                expose-group-apps = true;
                largesize = 50;
                launchanim = false;
                magnification = true;
                orientation = "left";
                show-process-indicators = false;
                show-recents = false;
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
                ShowDate = 2;
              };
              trackpad = {
                Dragging = false;
                ActuationStrength = 0;
                TrackpadThreeFingerDrag = false;
              };
              universalaccess.reduceTransparency = false;

              NSGlobalDomain = {
                NSWindowShouldDragOnGesture = true;
                AppleInterfaceStyle = "Dark";
                _HIHideMenuBar = true;
                KeyRepeat = 2;
                InitialKeyRepeat = 12;
                ApplePressAndHoldEnabled = false;
                "com.apple.sound.beep.feedback" = 1;
                "com.apple.swipescrolldirection" = false;
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
      darwinConfigurations."macmini" = nix-darwin.lib.darwinSystem {
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
          { homebrew.casks = [ "obs" ]; }
        ];
      };

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
          {
            homebrew.casks = [
              "karabiner-elements"
              "hiddenbar"
            ];
          }
        ];
      };
    };
}
