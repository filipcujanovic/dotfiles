local opts = require("opts")
local sbar = require("sketchybar")
local icons = require("icons")

local media_icon = sbar.add("item", "media_icon", {
	position = "e",
	scroll_texts = true,
	updates = true,
	padding_left = 5,
	update_freq = 1,
	icon = {
		string = icons.media_icon,
		align = "center",
		padding_right = 10,
	},
	label = {
		color = opts.color.green,
		max_chars = 24,
		string = "-",
	},
	background = {
		color = opts.color.transparent,
	},
	popup = {
		align = "center",
		horizontal = true,
	},
})

--menu
sbar.add("item", {
	position = "popup." .. media_icon.name,
	icon = {
		string = icons.previous,
		padding_left = 10,
		padding_right = 10,
	},
	background = { color = opts.color.transparent },
}):subscribe("mouse.clicked", function()
	sbar.exec("spotify_player playback previous")
	media_icon:set({ popup = { drawing = false } })
end)
local playpause = sbar.add("item", {
	position = "popup." .. media_icon.name,
	icon = {
		string = icons.play,
		padding_left = 10,
		padding_right = 10,
	},
	background = { color = opts.color.transparent },
})
playpause:subscribe("mouse.clicked", function()
	sbar.exec("spotify_player playback play-pause")
	media_icon:set({ popup = { drawing = false } })
end)

sbar.add("item", {
	position = "popup." .. media_icon.name,
	icon = {
		string = icons.next,
		padding_left = 10,
		padding_right = 10,
	},
	background = { color = opts.color.transparent },
}):subscribe("mouse.clicked", function()
	sbar.exec("spotify_player playback next")
	media_icon:set({ popup = { drawing = false } })
end)

media_icon:subscribe("mouse.clicked", function()
	media_icon:set({ popup = { drawing = "toggle" } })
end)

media_icon:subscribe("mouse.exited.global", function()
	media_icon:set({ popup = { drawing = false } })
end)

sbar.exec("spotify_player get key playback | jq", function(result, exit_code)
	local current_volume = 100
	if type(result) == "table" then
		current_volume = result.device.volume_percent
	end
	local spotify_volume_slider = sbar.add("slider", "spotify_volume_slider", 100, {
		position = "popup." .. media_icon.name,
		updates = true,
		slider = {
			percentage = current_volume,
		},
	})
	spotify_volume_slider:subscribe("mouse.clicked", function(env)
		sbar.exec("spotify_player playback volume " .. env.PERCENTAGE)
	end)
end)
local function update_media_playing()
	sbar.exec("spotify_player get key playback | jq", function(result, exit_code)
		local label = ""
		playpause:set({ icon = { string = icons.play } })
		if result.is_playing then
			local artists = ""
			for key, value in pairs(result.item.artists) do
				local concat_string = key == 1 and "" or ", "
				artists = artists .. concat_string .. value.name
			end

			label = artists .. " - " .. result.item.name
			playpause:set({ icon = { string = icons.pause } })
		end
		media_icon:set({ label = { string = string.lower(label) } })
	end)
end

media_icon:subscribe("routine", update_media_playing)

return {
	media_icon = media_icon,
}
