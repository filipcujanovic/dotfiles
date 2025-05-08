session_root "/Users/cujanovic/Library/Mobile Documents/iCloud~md~obsidian/Documents/the never ending hole"

if initialize_session "notes"; then
  new_window "notes"
  run_cmd "nvim"
fi

finalize_and_go_to_session
