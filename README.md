# desktop
![desktop](./assets/images/desktop.png)

# neovim
![dotfiles](./assets/images/dotfiles.png)

# description
## tools
### clis
- [bat](https://github.com/sharkdp/bat) - cat replacement with syntax highlighting
- [brew](https://github.com/Homebrew/brew) - macOS package manager
- [delta](https://github.com/dandavison/delta) - syntax highlighting pager for git, diff, grep and blame
- [eza](https://github.com/eza-community/eza) - alternative for ls
- [figlet](https://github.com/cmatsuoka/figlet) - used for generating ASCII art from text input
- [fzf](https://github.com/junegunn/fzf) - command-line fuzzy finder
- [git](https://github.com/git/git) - version control
- [gitleaks](https://github.com/gitleaks/gitleaks) - find secrets in git commits
- [gitmux](https://github.com/arl/gitmux) - git status for tmux status bar
- [gowall](https://github.com/Achno/gowall) - convert wallpapaer color scheme/palette
- [jq](https://github.com/jqlang/jq) - command line json parser
- [mycli](https://github.com/dbcli/mycli) - terminal client for MySQL
- [nvim](https://github.com/neovim/neovim) - text editor
- [skhd](https://github.com/koekeishiya/skhd) - hotkey daemon for macOS
- [starship](https://github.com/starship/starship) - prompt for zsh (or any other shell)
- [switchaudio-osx](https://github.com/deweller/switchaudio-osx) - change audio output via command line
- [tldr](https://github.com/tldr-pages/tldr) - cheatsheet for console commands
- [tmux](https://github.com/tmux/tmux) - terminal multiplexer
- [tmuxifier](https://github.com/jimeh/tmuxifier) - tmux session, window, and pane management tool
- [zoxide](https://github.com/ajeetdsouza/zoxide) - smart cd command
- [zsh](https://github.com/zsh-users/zsh) - z shell
    * plugins
        + [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete) - autocomplete for terminal commands
        + [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - fish-like autosuggestions for zsh
        + [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - syntax highlighting for zsh
        + [zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode) - better vim mode for zsh

### tuis
- [btop](https://github.com/aristocratos/btop) - monitor resources
- [lazygit](https://github.com/jesseduffield/lazygit) - git TUI
- [lazysql](https://github.com/jorgerojas26/lazysql) - tui database manager
- [spotify-player](https://github.com/aome510/spotify-player) - TUI for Spotify
- [visidata](https://github.com/saulpw/visidata) - terminal spreadsheet tool
- [yazi](https://github.com/sxyazi/yazi) - terminal file manager

### tiling manager
- [aerospace](https://github.com/nikitabobko/AeroSpace) - tiling manager
- [borders](https://github.com/FelixKratz/JankyBorders) - creating colored border around focused window

### guis
- [choose](https://github.com/chipsenkbeil/choose) - cli fuzzy matcher that has native macOS GUI - using this as app launcher
- [maccy](https://github.com/p0deje/Maccy) - clipboard history manager
- [sketchybar](https://github.com/FelixKratz/SketchyBar) - customizable macOS status bar replacement - using [SbarLua](https://github.com/FelixKratz/SbarLua)

### automation/scripting
- [hammerspoon](https://github.com/Hammerspoon/hammerspoon) - tool for automation of macOS, uses Lua
- [karabiner](https://github.com/pqrs-org/Karabiner-Elements) - keyboard customization for macOS
- [mouseless](https://mouseless.click/) - mouse control via keyboard - paid app

### terminals
- [ghostty](https://github.com/ghostty-org/ghostty) - terminal emulator
- [wezterm](https://github.com/wezterm/wezterm) - terminal emulator

### other
- [lulu](https://github.com/objective-see/LuLu) - macOS firewall
- [pearcleaner](https://github.com/alienator88/Pearcleaner) - mac app cleaner

### fonts
- [caskaydia-cove-nerd-font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode) - install with `brew install --cask font-caskaydia-cove-nerd-font`
- [caskaydia-mono-nerd-font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaMono) - install with `brew install --cask font-caskaydia-mono-nerd-font`
- [fira-mono-nerd-font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraMono) - install with `brew install --cask font-fira-mono-nerd-font`
- [iosevka-nerd-font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Iosevka) - install with `brew install --cask font-iosevka-nerd-font`
- [sf-mono-nerd-font-ligaturized](https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized) - install with `brew install --cask font-sf-mono-nerd-font-ligaturized`
- [sf-mono](https://developer.apple.com/fonts/) - install with ```brew install --cask font-sf-mono```
- [sf-pro](https://developer.apple.com/fonts/) - install with `brew install --cask font-sf-pro`
- [victor-mono-nerd-font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/VictorMono) - install with `brew install --cask font-victor-mono-nerd-font`

### symbol only fonts
- [symbols-only-nerd-font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/NerdFontsSymbolsOnly) - install with `brew install --cask font-symbols-only-nerd-font`
- [sf-symbols](https://developer.apple.com/sf-symbols/) - install with `brew install --cask sf-symbols`

## custom scripts
- [app-launcher](bin/app-launcher) - using [choose](https://github.com/chipsenkbeil/choose) I created a simple app launcher, you can also search macOS settings and open them
- [tmux-session-picker](bin/tmux-session-picker) - simple [fzf](https://github.com/junegunn/fzf) picker for tmux sessions
- [tmuxifier-run-all](bin/tmuxifier-run-all) - a simple script to start all tmux sessions created with [tmuxifier](https://github.com/jimeh/tmuxifier)

### [wallpapers](wallpapers)

# Installation

- I would not suggest installing everything since this is a config that I personally use and many things here are tailored to my needs. You can check the code and use whatever you find here in your dotfiles. But if you really want to install them here are the steps:

- go to `.config/brew` dir and run `brew bundle install`
- run the `install.sh` script that should install everything that's needed.
