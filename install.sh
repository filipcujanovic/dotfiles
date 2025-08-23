# symlink .dotfiles
# run brew install from Brewfile

# brew bundle --file=~/dotfiles/Brewfile

os_name=$(uname -s)

# symlink .config dir
ln -s -f ~/dotfiles/.config/bat ~/.config/
ln -s -f ~/dotfiles/.config/btop ~/.config/
ln -s -f ~/dotfiles/.config/delta ~/.config/
ln -s -f ~/dotfiles/.config/figlet ~/.config/
ln -s -f ~/dotfiles/.config/ghostty ~/.config/
ln -s -f ~/dotfiles/.config/kitty/ ~/.config/
ln -s -f ~/dotfiles/.config/nvim/ ~/.config/
ln -s -f ~/dotfiles/.config/starship ~/.config/
ln -s -f ~/dotfiles/.config/tmux/ ~/.config/
ln -s -f ~/dotfiles/.config/wezterm ~/.config/

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
