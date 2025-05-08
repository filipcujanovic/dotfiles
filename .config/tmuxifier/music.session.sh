session_root "~/"

if initialize_session "music"; then
  new_window "music"
  run_cmd "spotify_player"
fi

finalize_and_go_to_session
