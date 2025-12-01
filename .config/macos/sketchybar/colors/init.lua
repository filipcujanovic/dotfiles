local gruvbox = require('colors.gruvbox')

local themes = {
    ['gruvbox-dark'] = gruvbox.transform(gruvbox.dark),
}

local selected = 'gruvbox-dark'

return {
    current = themes[selected](),
}
