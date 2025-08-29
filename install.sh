# symlink .dotfiles
# run brew install from Brewfile

# brew bundle --file=~/dotfiles/Brewfile

ln -s -f ~/dotfiles/.config/* ~/.config/

ln -s -f ~/dotfiles/.config/git/.gitconfig ~/.gitconfig
ln -s -f ~/dotfiles/.config/gitmux/.gitmux.conf ~/.gitmux.conf
ln -s -f ~/dotfiles/.config/mycli/.myclirc ~/.myclirc
ln -s -f ~/dotfiles/.config/tmux/.tmux.conf ~/.tmux.conf
ln -s -f ~/dotfiles/.config/tmuxifier/* ~/.tmuxifier/layouts/
ln -s -f ~/dotfiles/.config/visidata/.visidatarc ~/.visidatarc
ln -s -f ~/dotfiles/.config/yazi/theme.toml ~/.config/yazi/theme.toml
ln -s -f ~/dotfiles/.config/zsh/.zshenv ~/.zshenv
ln -s -f ~/dotfiles/.config/zsh/.zshrc ~/.zshrc

# symlink bin dir
ln -s -f ~/dotfiles/bin/* ~/bin/
