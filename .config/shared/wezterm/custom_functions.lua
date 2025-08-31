local config = require('screen_config')
local wezterm = require('wezterm')
local mux = wezterm.mux
local functions = {}

-- custom functions for createing a default session for working. In order to use it check the screen_config file to see what you need

function create_split_pane(pane, direction, size, working_dir, send_text)
	local new_pane = pane:split({
		direction = direction,
		size = size,
		cwd = working_dir,
	})
	if send_text ~= nil then
		new_pane:send_text(send_text)
	end
	return new_pane
end
function create_window(working_dir, position)
	return mux.spawn_window({
		cwd = working_dir,
		position = position,
	})
end
function create_tab(current_window, working_dir, tab_title, send_text)
	local tab, pane, window = current_window:spawn_tab({
		cwd = working_dir,
	})
	if tab_title ~= nil then
		tab:set_title(tab_title)
	end
	if send_text ~= nil then
		pane:send_text(send_text)
	end
	return pane, tab
end
function create_workspace(config)
	local tab, pane, window = create_window(config.cwd, config.position)
	if config.title ~= nil then
		window:set_title(config.title)
	end
	if config.tab_title ~= nil then
		tab:set_title(config.tab_title)
	end
	if config.command ~= nil then
		pane:send_text(config.command)
	end
	if config.panes ~= nil then
		for key, pane_config in pairs(config.panes) do
			create_split_pane(pane, pane_config.direction, pane_config.size, pane_config.cwd, pane_config.command)
		end
	end
	if config.tabs ~= nil then
		for screen, tab in pairs(config.tabs) do
			local pane, currnet_tab = create_tab(window, tab.cwd, tab.title, tab.command)
			if tab.panes ~= nil then
				for key, pane_config in pairs(tab.panes) do
					new_pane = create_split_pane(pane, pane_config.direction, pane_config.size, pane_config.cwd, pane_config.command)
					if pane_config.panes ~= nil then
						for key, sub_pane_config in pairs(pane_config.panes) do
							create_split_pane(new_pane, sub_pane_config.direction, sub_pane_config.size, sub_pane_config.cwd, sub_pane_config.command)
						end
					end
				end
			end
		end
	end
	return pane, window
end

function functions.startup(cmd)
	local args = {}
	if cmd then
		args = cmd.args
	end
	local focused = {}
	for key, screen in pairs(config) do
		if screen.active then
			local pane, window = create_workspace(screen)
			if screen.focus then
				focused.pane = pane
				focused.window = window
			end
		end
	end
	focused.pane:activate()
	focused.window:gui_window():focus()
end

function functions.format_title(tab, pane, tabs, panes, config)
	local zoomed = ''
	if tab.active_pane.is_zoomed then
		zoomed = '[Z] '
	end

	local index = ''
	if #tabs > 1 then
		index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
	end

	local addtional_info = tab.tab_title ~= '' and tab.tab_title or ''

	-- return zoomed .. index .. tab.active_pane.title .. " " .. addtional_info
	return zoomed .. index .. tab.active_pane.title .. ' ' .. tab.window_title
end

wezterm.on('gui-startup', functions.startup)
wezterm.on('format-window-title', functions.format_title)
