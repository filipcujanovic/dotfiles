local opts = require('opts')
local icons = require('icons')
M = {}

M.get_icon = function(app, is_front_app)
    local icons_map = {
        --WezTerm = '􀩼',
        --Ghostty = '􀩼',
        WezTerm = ':wezterm:',
        Ghostty = ':ghostty:',
        qutebrowser = ':qute_browser:',
        Calendar = ':calendar:',
        Signal = ':signal:',
        Spotlight = ':spotlight:',
        Transmission = ':transmit:',
        Docker = ':docker:',
        VLC = ':vlc:',
        Pages = ':pages:',
        Finder = ':finder:',
        Spotify = ':spotify:',
        Calibre = ':book:',
        Telegram = ':telegram:',
        Insomnia = ':insomnia:',
        FaceTime = ':face_time:',
        Safari = ':safari:',
        Numbers = ':numbers:',
        Reminders = ':reminders:',
        Messages = ':messages:',
        Preview = ':pdf:',
        Obsidian = ':obsidian:',
        Firefox = ':firefox:',
        Vivaldi = ':vivaldi:',
        ['Rakuten Viber'] = icons.viber,
        ['Brave Browser'] = ':brave_browser:',
        ['Google Chrome'] = ':google_chrome:',
        ['System Preferences'] = ':gear:',
        ['System Settings'] = ':gear:',
        ['‎WhatsApp'] = ':whats_app:',
        ['WhatsApp Web'] = ':whats_app:',
        ['Docker Desktop'] = ':docker:',
        ['Sequel Ace'] = ':sequel_ace:',
        ['App Store'] = ':app_store:',
        ['Default'] = ':default:',
    }
    local fonts = {
        viber = is_front_app and opts.font.icon_font_normal or opts.font.icon_font_small,
        other = is_front_app and opts.font.front_app_icon or opts.font.front_app_icon_small,
    }
    return {
        string = icons_map[app] ~= nil and icons_map[app] or ':default:',
        font = app == 'Rakuten Viber' and fonts.viber or fonts.other,
    }
end

return M
