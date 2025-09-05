# symlink .config dir
os=$(uname -s)

ln -s -f ~/projects/dotfiles/.config/shared/* ~/.config/

ln -s -f ~/projects/dotfiles/.config/shared/git/.gitconfig ~/.gitconfig
ln -s -f ~/projects/dotfiles/.config/shared/gitmux/.gitmux.conf ~/.gitmux.conf
ln -s -f ~/projects/dotfiles/.config/shared/mycli/.myclirc ~/.myclirc
ln -s -f ~/projects/dotfiles/.config/tmux/.tmux.conf ~/.tmux.conf
#ln -s -f ~/projects/dotfiles/.config/shared/tmuxifier/* ~/.tmuxifier/layouts/
ln -s -f ~/projects/dotfiles/.config/shared/tmux/.tmux.conf ~/.tmux.conf
ln -s -f ~/projects/dotfiles/.config/shared/visidata/.visidatarc ~/.visidatarc
ln -s -f ~/projects/dotfiles/.config/shared/zsh/.zshenv ~/.zshenv
ln -s -f ~/projects/dotfiles/.config/shared/zsh/.zshrc ~/.zshrc
ln -s -f ~/projects/dotfiles/bin/shared/* ~/bin/

if [[ os == "Darwin" ]]; then
    #brew bundle --file=~/projects/dotfiles/Brewfile
    ln -s -f ~/projects/dotfiles/bin/macos/* ~/bin/
    ln -s -f ~/projects/dotfiles/.config/macos/* ~/.config/
    ln -s -f ~/projects/dotfiles/.config/macos/zsh/.zshenv ~/.zshenv
    ln -s -f ~/projects/dotfiles/.config/macos/zsh/.zshrc ~/.zshrc
    ln -s -f ~/projects/dotfiles/.config/shared/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml
    ln -s -f ~/projects/dotfiles/.config/macos/hammerspoon/init.lua ~/.hammerspoon/init.lua
    curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/latest/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
    ln -s -f ~/projects/dotfiles/.config/aerospace ~/.config/
    ln -s -f ~/projects/dotfiles/.config/borders ~/.config/
    ln -s -f ~/projects/dotfiles/.config/hammerspoon/init.lua ~/.hammerspoon/init.lua
    ln -s -f ~/projects/dotfiles/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
    ln -s -f ~/projects/dotfiles/.config/lazysql/config.yaml ~/Library/Application\ Support/lazysql/config.toml
    ln -s -f ~/projects/dotfiles/.config/sketchybar ~/.config/
    ln -s -f ~/projects/dotfiles/.config/skhd ~/.config/
else
    ln -s -f ~/projects/dotfiles/.config/linux/* ~/.config/
    ln -s -f ~/projects/dotfiles/bin/linux/* ~/bin/
fi
