local wezterm = require('wezterm')
local wallpapers = {
	['beserk-mocha'] = 'berserk-mocha.png',
	['berserk'] = 'berserk.png',
	['city'] = 'city.png',
	['eclipse-mocha'] = 'eclipse-mocha.png',
	['eclipse'] = 'eclipse.png',
	['forest-road'] = 'forest-road.jpg',
	['greencity'] = 'greencity.gif',
	['guts-gray'] = 'guts-gray.png',
	['guts-mocha'] = 'guts-mocha.png',
	['guts-rest-mocha'] = 'guts-rest-mocha.png',
	['guts2-mocha'] = 'guts2-mocha.png',
	['moon'] = 'moon.png',
	['mountain'] = 'mountain.jpg',
	['orb'] = 'orb.png',
	['stars'] = 'stars.png',
	['starstwo'] = 'starstwo.png',
	['storm-road'] = 'storm-road.jpg',
	['storm'] = 'storm.jpg',
	['storm-animated'] = 'storm.webp',
	['village-road'] = 'village-road.jpg',
}

local schemes = {}
for name, scheme in pairs(wallpapers) do
	table.insert(schemes, name)
end
local random_wallpaper = wallpapers[schemes[math.random(#schemes)]]

return {
	{
		source = { File = wezterm.home_dir .. '/.config/wezterm/wallpapers/' .. wallpapers['storm-animated'] },
		-- source = { File = wezterm.home_dir .. "/.config/wezterm/wallpapers/" .. random_wallpaper },
		opacity = 0.20,
	},
}
