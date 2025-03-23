local opts = require('opts')
local sbar = require('sketchybar')
local utils = require('utils')
local icons = require('icons')

local whitelist = { ['Spotify'] = true, ['Music'] = false }

local media_icon = sbar.add('item', 'media_icon', {
	position = 'e',
	scroll_texts = true,
	updates = true,
	padding_left = 5,
	icon = {
		string = icons.media_icon,
		align = 'center',
		padding_right = 10,
	},
	label = {
		color = opts.color.green,
		max_chars = 24,
		string = '-',
	},
	background = {
		color = opts.color.transparent,
	},
	popup = {
		align = 'center',
		horizontal = true,
	},
})

-- media:subscribe("builtin_display_change", function(env)
-- 	if env.is_builtin == "true" then
-- 		media:set({ position = "e", background = { padding_right = 0 } })
-- 		media_icon:set({ position = "e", background = { padding_left = 22 } })
-- 		sbar.exec("sketchybar --move " .. media_icon.name .. " before " .. media.name)
-- 	else
-- 		media:set({ position = "right", background = { padding_right = 12 } })
-- 		media_icon:set({ position = "right", background = { padding_left = 0 } })
-- 		sbar.exec("sketchybar --move " .. media_icon.name .. " after " .. media.name)
-- 	end
-- end)

--menu
sbar.add('item', {
	position = 'popup.' .. media_icon.name,
	icon = {
		string = icons.previous,
		padding_left = 10,
		padding_right = 10,
	},
	background = { color = opts.color.transparent },
}):subscribe('mouse.clicked', function()
	sbar.exec('osascript -e \'tell application "Spotify" to previous track\'')
	--sbar.exec('spotify_player playback previous')
	media_icon:set({ popup = { drawing = false } })
end)
local playpause = sbar.add('item', {
	position = 'popup.' .. media_icon.name,
	icon = {
		string = icons.play,
		padding_left = 10,
		padding_right = 10,
	},
	background = { color = opts.color.transparent },
})
playpause:subscribe('mouse.clicked', function()
	sbar.exec('osascript -e \'tell application "Spotify" to playpause\'')
	--sbar.exec('spotify_player playback play-pause')
	media_icon:set({ popup = { drawing = false } })
end)

sbar.add('item', {
	position = 'popup.' .. media_icon.name,
	icon = {
		string = icons.next,
		padding_left = 10,
		padding_right = 10,
	},
	background = { color = opts.color.transparent },
}):subscribe('mouse.clicked', function()
	sbar.exec('osascript -e \'tell application "Spotify" to next track\'')
	--sbar.exec('spotify_player playback next')
	media_icon:set({ popup = { drawing = false } })
end)

media_icon:subscribe('mouse.clicked', function()
	media_icon:set({ popup = { drawing = 'toggle' } })
end)

media_icon:subscribe('mouse.exited.global', function()
	media_icon:set({ popup = { drawing = false } })
end)

--local playback_data = utils.json.decode(io.popen('spotify_player get key playback'):read('*a'))
local current_volume = io.popen('osascript -e \'tell application "Spotify" to get sound volume\''):read('*a')
local spotify_volume_slider = sbar.add('slider', 'spotify_volume_slider', 100, {
	position = 'popup.' .. media_icon.name,
	updates = true,
	slider = {
		percentage = current_volume,
	},
})
spotify_volume_slider:subscribe('mouse.clicked', function(env)
	sbar.exec('osascript -e \'tell application "Spotify" to set sound volume to ' .. env.PERCENTAGE .. '\'')
	--sbar.exec('spotify_player playback volume ' .. env.PERCENTAGE)
end)

media_icon:subscribe('media_change', function(env)
	-- if whitelist[env.INFO.app] == true then
	local label = env.INFO.artist .. ' - ' .. env.INFO.title

	if env.INFO.state == 'playing' then
		playpause:set({ icon = { string = icons.pause } })
	elseif env.INFO.state == 'paused' then
		label = ''
		playpause:set({ icon = { string = icons.play } })
	end

	--media:set({ label = { string = label } })
	media_icon:set({ label = { string = string.lower(label) } })
	-- end
end)

return {
	media_icon = media_icon,
}
