session_root "~/projects/the-never-ending-hole/"

if initialize_session "the-never-ending-hole"; then
  new_window "notes"
  run_cmd "nvim"
fi

finalize_and_go_to_session
