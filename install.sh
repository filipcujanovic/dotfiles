# symlink .config dir
os=$(uname -S)

ln -s -f ~/dotfiles/.config/shared/* ~/.config/
if [[ os == "Darwin" ]]; then
    #brew bundle --file=~/dotfiles/Brewfile
    ln -s -f ~/dotfiles/.config/macos/* ~/.config/
    ln -s -f ~/dotfiles/.config/macos/zsh/.zshenv ~/.zshenv
    ln -s -f ~/dotfiles/.config/macos/zsh/.zshrc ~/.zshrc
    ln -s -f ~/dotfiles/.config/shared/lazygit/config.yaml ~/Library/Application\ Support/lazygit/config.yml
    ln -s -f ~/dotfiles/.config/macos/hammerspoon/init.lua ~/.hammerspoon/init.lua
    curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/latest/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
    ln -s -f ~/dotfiles/bin/macos* ~/bin/
fi

ln -s -f ~/dotfiles/.config/shared/git/.gitconfig ~/.gitconfig
ln -s -f ~/dotfiles/.config/shared/gitmux/.gitmux.conf ~/.gitmux.conf
ln -s -f ~/dotfiles/.config/shared/mycli/.myclirc ~/.myclirc
ln -s -f ~/dotfiles/.config/tmux/.tmux.conf ~/.tmux.conf
#ln -s -f ~/dotfiles/.config/shared/tmuxifier/* ~/.tmuxifier/layouts/
ln -s -f ~/dotfiles/.config/shared/tmux/.tmux.conf ~/.tmux.conf
ln -s -f ~/dotfiles/.config/shared/visidata/.visidatarc ~/.visidatarc
ln -s -f ~/dotfiles/.config/shared/zsh/.zshenv ~/.zshenv
ln -s -f ~/dotfiles/.config/shared/zsh/.zshrc ~/.zshrc


ln -s -f ~/dotfiles/bin/shared* ~/bin/
