session_root "~/projects/dotfiles"

if initialize_session "dotfiles"; then
  new_window "dotfiles"
  run_cmd "nvim"
  new_window "dotfiles-private"
  run_cmd "z dotfiles-private"
  run_cmd "nvim"
fi

finalize_and_go_to_session
