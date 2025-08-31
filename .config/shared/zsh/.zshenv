#. "$HOME/.cargo/env"

function git_stash_show() {
	git stash show stash@{"$1"}
}

function git_stash_show_m() {
	git stash show -m stash@{"$1"}
}

function git_stash_apply() {
	git stash apply stash@{"$1"}
}

function git_stash_drop() {
	git stash drop stash@{"$1"}
}

function tmux_start() {
  tmuxifier ls | while IFS= read -r layout; do
    tmux has-session -t "$layout" 2>/dev/null || tmux new-session -d -s "$layout" "tmuxifier load-session $layout"
  done
}

function zvm_vi_yank() {
	zvm_yank
	echo ${CUTBUFFER} | pbcopy
	zvm_exit_visual_mode
}
