local tmux_directions = { ['h'] = 'L', ['j'] = 'D', ['k'] = 'U', ['l'] = 'R' }

local function vim_navigate_windows(direction)
    vim.cmd(string.format('wincmd %s', direction))
end

local function vim_navigate_tab(direction)
    vim.cmd(string.format('tab%s', direction))
end

local function tmux_command(command)
    local tmux_socket = vim.fn.split(vim.env.TMUX, ',')[1]
    return vim.fn.system(string.format('tmux -S %s %s', tmux_socket, command))
end

local function tmux_navigate_pane(direction)
    tmux_command(string.format('select-pane -%s', tmux_directions[direction]))
end

local function tmux_navigate_window(direction)
    tmux_command(string.format('select-window  -%s', direction))
end

local function navigate(direction)
    if direction == 'n' or direction == 'p' then
        local tabnr = vim.fn.tabpagenr()
        local last_tab_number = vim.fn.tabpagenr('$')
        if tabnr == last_tab_number and direction == 'n' then
            tmux_navigate_window(direction)
        elseif tabnr == 1 and direction == 'p' then
            tmux_navigate_window(direction)
        else
            vim_navigate_tab(direction)
        end
    else
        local winnr = vim.fn.winnr()
        vim_navigate_windows(direction)
        local is_same_winnr = (winnr == vim.fn.winnr())

        if is_same_winnr then
            tmux_navigate_pane(direction)
        end
    end
end

local navigate_right = function()
    navigate('l')
end
local navigate_left = function()
    navigate('h')
end
local navigate_up = function()
    navigate('k')
end
local navigate_down = function()
    navigate('j')
end
local navigate_next_tab = function()
    navigate('n')
end
local navigate_previous_tab = function()
    navigate('p')
end

vim.keymap.set('n', '<C-s>l', navigate_right, { silent = true })
vim.keymap.set('n', '<C-s>h', navigate_left, { silent = true })
vim.keymap.set('n', '<C-s>k', navigate_up, { silent = true })
vim.keymap.set('n', '<C-s>j', navigate_down, { silent = true })
--vim.keymap.set('n', '<C-s>n', navigate_next_tab, { silent = true })
--vim.keymap.set('n', '<C-s>p', navigate_previous_tab, { silent = true })
