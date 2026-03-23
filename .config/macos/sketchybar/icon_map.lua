local opts = require('opts')
local icons = require('icons')
M = {}

M.get_icon = function(app, is_front_app)
    local icons_map = {
        --WezTerm = '􀩼',
        --Ghostty = '􀩼',
        --kitty = '􀩼',
        ['activity monitor'] = ':activity_monitor:',
        ['app store'] = ':app_store:',
        ['brave browser'] = ':brave_browser:',
        ['default'] = ':default:',
        ['docker desktop'] = ':docker:',
        ['rakuten viber'] = icons.viber,
        ['system preferences'] = ':gear:',
        ['system settings'] = ':gear:',
        ['whatsapp web'] = ':whats_app:',
        affinity = ':affinity:',
        calendar = ':calendar:',
        calibre = ':book:',
        choose = ':gear:',
        discord = ':discord:',
        docker = ':docker:',
        facetime = ':face_time:',
        finder = ':finder:',
        ghostty = ':ghostty:',
        kitty = ':terminal:',
        lulu = ':lulu:',
        messages = ':messages:',
        messenger = ':messenger:',
        numbers = ':numbers:',
        pages = ':pages:',
        preview = ':pdf:',
        qutebrowser = ':qute_browser:',
        reminders = ':reminders:',
        safari = ':safari:',
        signal = ':signal:',
        slack = ':slack:',
        spotify = ':spotify:',
        spotlight = ':spotlight:',
        transmission = ':transmit:',
        vlc = ':vlc:',
        wezterm = ':wezterm:',
    }
    local fonts = {
        viber = is_front_app and opts.font.icon_font_normal or opts.font.icon_font_small,
        other = is_front_app and opts.font.front_app_icon or opts.font.front_app_icon_small,
    }
    return {
        string = icons_map[app] ~= nil and icons_map[app] or ':default:',
        font = app == 'rakuten viber' and fonts.viber or fonts.other,
    }
end

return M
