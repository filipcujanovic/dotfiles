if [ -f ~/projects/dotfiles-private/.config/zsh/.zshrc-private ]; then
  source ~/projects/dotfiles-private/.config/zsh/.zshrc-private
fi

if [ -f ~/projects/dotfiles/.config/shared/zsh/alias ]; then
  source ~/projects/dotfiles/.config/shared/zsh/alias
fi

source $NVM_DIR/nvm.sh

# use vi mode
#set -o vi
bindkey -e

setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt CHASE_LINKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b'

setopt PROMPT_SUBST

NEWLINE=$'\n'
#PROMPT='${NEWLINE}%F{#5a633a}%f%K{#5a633a}%~ %f%k%K{#b57614}%F{#5a633a}%f%k%F{#b57614}%f%K{#b57614}${vcs_info_msg_0_}%k%F{#b57614}%f %F{#b8bb26} %f'
PROMPT='${NEWLINE}%F{#5a633a}%f%K{#5a633a} %~ %f%k%K{#b57614}%F{#5a633a}%f%k%F{#b57614}%f%K{#b57614} ${vcs_info_msg_0_} %k%F{#b57614}%f %F{#b8bb26} %f'

autoload -Uz compinit && compinit
autoload -U colors && colors
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
