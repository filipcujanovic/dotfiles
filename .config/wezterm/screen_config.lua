local wezterm = require('wezterm')

-- I have switched to tmux so I do not need wezterm mux for now
-- Table can have two properties primary_screen and secondary_screen.
-- The properties are cwd, command, panes, tabs.
-- cwd - string - this it the directory that the pane/window/tab will open
-- command - string - what command to run after the pane/window/tab is created
-- panes - array of tables - one pane can have direction, size, cwd, command, and panes (if you need to split the pane again)
-- direction - string - how to split the pane
-- size - float - size of the split
-- tabs - array of tables - one tab can have cwd, command, panes

return {
	primary_screen = {},
	secondary_screen = {},
}
