# symlink .dotfiles
# run brew install from Brewfile

# brew bundle --file=~/dotfiles/Brewfile

# symlink .config dir
ln -s -f ~/dotfiles/.config/aerospace ~/.config/
ln -s -f ~/dotfiles/.config/bat ~/.config/
ln -s -f ~/dotfiles/.config/borders ~/.config/
ln -s -f ~/dotfiles/.config/btop ~/.config/
ln -s -f ~/dotfiles/.config/delta ~/.config/
ln -s -f ~/dotfiles/.config/ghostty ~/.config/
ln -s -f ~/dotfiles/.config/nvim/ ~/.config/
ln -s -f ~/dotfiles/.config/sketchybar ~/.config/
ln -s -f ~/dotfiles/.config/skhd ~/.config/
ln -s -f ~/dotfiles/.config/starship ~/.config/
ln -s -f ~/dotfiles/.config/tmux/ ~/.config/
ln -s -f ~/dotfiles/.config/wezterm ~/.config/

ln -s -f ~/dotfiles/.config/git/.gitconfig ~/.gitconfig
ln -s -f ~/dotfiles/.config/gitmux/.gitmux.conf ~/.gitmux.conf
ln -s -f ~/dotfiles/.config/tmux/.tmux.conf ~/.tmux.conf
ln -s -f ~/dotfiles/.config/tmux/layouts ~/.tmuxifier/
ln -s -f ~/dotfiles/.config/hammerspoon/init.lua ~/.hammerspoon/init.lua
ln -s -f ~/dotfiles/.config/mycli/.myclirc ~/.myclirc
ln -s -f ~/dotfiles/.config/zsh/.zshenv ~/.zshenv
ln -s -f ~/dotfiles/.config/zsh/.zshrc ~/.zshrc
ln -s -f ~/dotfiles/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
ln -s -f ~/dotfiles/.config/lazygit/config.yaml ~/Library/Application\ Support/lazygit/config.yml

# symlink bin dir
ln -s -f ~/dotfiles/bin/tmux-sessionizer ~/bin/tmux-sessionizer
