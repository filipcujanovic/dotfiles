local gruvbox = require('colors.gruvbox')
local ember = require('colors.ember')

local themes = {
    ['gruvbox-dark'] = gruvbox.transform(gruvbox.dark),
    ['ember'] = ember.transform(ember.ember),
}

local selected = 'gruvbox-dark'

return {
    current = themes[selected](),
}
