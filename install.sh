# symlink .config dir
os=$(uname -s)

ln -s -f ~/projects/dotfiles/.config/shared/* ~/.config/

ln -s -f ~/projects/dotfiles/.config/shared/git/.gitconfig ~/.gitconfig
ln -s -f ~/projects/dotfiles/.config/shared/gitmux/.gitmux.conf ~/.gitmux.conf
ln -s -f ~/projects/dotfiles/.config/shared/tmux/.tmux.conf ~/.tmux.conf
ln -s -f ~/projects/dotfiles/.config/shared/visidata/.visidatarc ~/.visidatarc
ln -s -f ~/projects/dotfiles/.config/shared/zsh/.zshenv ~/.zshenv
ln -s -f ~/projects/dotfiles/.config/shared/zsh/.zshrc ~/.zshrc
ln -s -f ~/projects/dotfiles/bin/shared/* ~/bin/

if [[ $os == "Darwin" ]]; then
    defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
    ln -s -f ~/projects/dotfiles/bin/macos/* ~/bin/
    #ln -s -f ~/projects/dotfiles/.config/macos/finicky/.finicky.js ~/.finicky.js
    ln -s -f ~/projects/dotfiles/.config/macos/* ~/.config/
else
    ln -s -f ~/projects/dotfiles/.config/linux/* ~/.config/
    ln -s -f ~/projects/dotfiles/bin/linux/* ~/bin/
fi
