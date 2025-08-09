eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=25'
if [ -f ~/dotfiles-private/.config/zsh/.zshrc-private ]; then
  source ~/dotfiles-private/.config/zsh/.zshrc-private
fi

alias jsonencode="awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' $0"
alias fastfetch="fastfetch; printf '\n\n'"
alias cat="bat"
alias gdf="git diff"
alias gc="git checkout"
alias gs="git status"
alias ga="git add"
alias gp="git push origin"
alias gpl="git pull origin"
alias gsp="git stash pop"
alias gst="git stash"
alias gsts="git_stash_show"
alias gstsm="git_stash_show_m"
alias gstd="git_stash_drop"
alias gstl="git stash list"
alias gsta="git_stash_apply"
alias dup="docker-compose up -d"
alias dbuild="docker-compose build"
alias dstop="docker stop"
alias ls="eza --color=always --git --icons=always"

# use vi mode
#set -o vi
bindkey -e

export VISUAL=nvim
export EDITOR=nvim
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE

setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt CHASE_LINKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

export PATH=$PATH":$HOME/bin"
export PATH="/Users/cujanovic/.local/bin:$PATH"
export PATH="$HOME/.tmuxifier/bin:$PATH"
#export PATH=$PATH":$HOME/go/bin"
export PATH=$PATH":$HOME/.config/zfunc"
export PATH="$(brew --prefix)/opt/curl/bin:$PATH"
export PATH="$(brew --prefix)/opt/mysql-client/bin:$PATH"
export PATH="/$PATH:$HOME/.cargo/bin"
export PATH=$PATH:"$HOME/Library/Python/3.10/bin"
export PATH="/Applications/flameshot.app/Contents/MacOS/:$PATH"
export NVM_DIR="$HOME/.nvm"
export LESS="-XRFS"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#a89984"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --style=numbers {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
# catppuccin
#export FZF_DEFAULT_OPTS=" \
#--color=spinner:#f5e0dc,hl:#f38ba8 \
#--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
#--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
#--multi"
# gruvbox
export FZF_DEFAULT_OPTS=" \
 --color=spinner:#8ec07c,hl:#83a598 \
 --color=fg:#bdae93,header:#83a598,info:#fabd2f,pointer:#8ec07c \
 --color=marker:#8ec07c,fg+:#ebdbb2,prompt:#fabd2f,hl+:#83a598
 --multi"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bindkey "ç" fzf-cd-widget # atl + c
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

source $(brew --prefix nvm)/nvm.sh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#export ZVM_INIT_MODE=sourcing
#source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# Check that the function `starship_zle-keymap-select()` is defined.
# xref: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null || \
  {
    echo "Load starship"
    eval "$(/usr/local/bin/starship init zsh)"
  }
autoload -Uz compinit && compinit
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(tmuxifier init -)"
zvm_after_init_commands+=('[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh')
