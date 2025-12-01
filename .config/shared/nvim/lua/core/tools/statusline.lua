local M = {}

-- Don't show the command that produced the quickfix list.
vim.g.qf_disable_statusline = 1

-- Show the mode in my custom component instead.
vim.o.showmode = false

--- Current mode.
---@return string
function M.mode_component()
    -- Note that: \19 = ^S and \22 = ^V.
    local mode_to_str = {
        ['n'] = 'NORMAL',
        ['no'] = 'OP-PENDING',
        ['nov'] = 'OP-PENDING',
        ['noV'] = 'OP-PENDING',
        ['no\22'] = 'OP-PENDING',
        ['niI'] = 'NORMAL',
        ['niR'] = 'NORMAL',
        ['niV'] = 'NORMAL',
        ['nt'] = 'NORMAL',
        ['ntT'] = 'NORMAL',
        ['v'] = 'VISUAL',
        ['vs'] = 'VISUAL',
        ['V'] = 'VISUAL',
        ['Vs'] = 'VISUAL',
        ['\22'] = 'VISUAL',
        ['\22s'] = 'VISUAL',
        ['s'] = 'SELECT',
        ['S'] = 'SELECT',
        ['\19'] = 'SELECT',
        ['i'] = 'INSERT',
        ['ic'] = 'INSERT',
        ['ix'] = 'INSERT',
        ['R'] = 'REPLACE',
        ['Rc'] = 'REPLACE',
        ['Rx'] = 'REPLACE',
        ['Rv'] = 'VIRT REPLACE',
        ['Rvc'] = 'VIRT REPLACE',
        ['Rvx'] = 'VIRT REPLACE',
        ['c'] = 'COMMAND',
        ['cv'] = 'VIM EX',
        ['ce'] = 'EX',
        ['r'] = 'PROMPT',
        ['rm'] = 'MORE',
        ['r?'] = 'CONFIRM',
        ['!'] = 'SHELL',
        ['t'] = 'TERMINAL',
    }

    -- Get the respective string to display.
    local mode = mode_to_str[vim.api.nvim_get_mode().mode] or 'UNKNOWN'

    -- Set the highlight group.
    local hl = 'Other'
    if mode:find('NORMAL') then
        hl = 'Normal'
    elseif mode:find('PENDING') then
        hl = 'Pending'
    elseif mode:find('VISUAL') then
        hl = 'Visual'
    elseif mode:find('INSERT') or mode:find('SELECT') then
        hl = 'Insert'
    elseif mode:find('COMMAND') or mode:find('TERMINAL') or mode:find('EX') then
        hl = 'Command'
    end

    -- Construct the bubble-like component.
    return table.concat({
        string.format('%%#StatuslineModeSeparator%s# ', hl),
        string.format('%%#StatuslineMode%s#%s', hl, mode),
        string.format('%%#StatuslineModeSeparator%s# ', hl),
    })
end

function M.kulala_component()
    local current_filetype = vim.bo.filetype
    if current_filetype == 'http' then
        local conf = require('kulala.config')
        return vim.g.kulala_selected_env or conf.get().default_env
    end
    return ''
end

---@type table<string, string?>
local progress_status = {
    client = nil,
    kind = nil,
    title = nil,
}

vim.api.nvim_create_autocmd('LspProgress', {
    group = vim.api.nvim_create_augroup('statusline', { clear = true }),
    desc = 'Update LSP progress in statusline',
    pattern = { 'begin', 'end' },
    callback = function(args)
        if not args.data then
            return
        end

        progress_status = {
            client = vim.lsp.get_client_by_id(args.data.client_id).name,
            kind = args.data.params.value.kind,
            title = args.data.params.value.title,
        }

        if progress_status.kind == 'end' then
            progress_status.title = nil
            -- Wait a bit before clearing the status.
            vim.defer_fn(function()
                vim.cmd.redrawstatus()
            end, 3000)
        else
            vim.cmd.redrawstatus()
        end
    end,
})

--- The latest LSP progress message.
---@return string
function M.lsp_progress_component()
    if not progress_status.client or not progress_status.title then
        return ''
    end

    -- Avoid noisy messages while typing.
    if vim.startswith(vim.api.nvim_get_mode().mode, 'i') then
        return ''
    end

    return table.concat({
        '%#StatuslineSpinner#󱥸 ',
        string.format('%%#StatuslineTitle#%s  ', progress_status.client),
        string.format('%%#StatuslineItalic#%s...', progress_status.title),
    })
end

--- The buffer's filetype.
---@return string
function M.filetype_component()
    local buf_name = vim.api.nvim_buf_get_name(0)
    local name, ext = vim.fn.fnamemodify(buf_name, ':t'), vim.fn.fnamemodify(buf_name, ':e')

    return string.format('%%#StatuslineTitle#%s', name)
end

--- File-content encoding for the current buffer.
---@return string
function M.encoding_component()
    local encoding = vim.opt.fileencoding:get()
    return encoding ~= '' and string.format('%%#StatuslineModeSeparatorOther# %s', encoding) or ''
end

--- The current line, total line count, and column position.
---@return string
function M.position_component()
    local line = vim.fn.line('.')
    local line_count = vim.api.nvim_buf_line_count(0)
    local col = vim.fn.virtcol('.')

    return table.concat({
        '%#StatuslineItalic#l: ',
        string.format('%%#StatuslineItalic#%d', line),
        string.format('%%#StatuslineItalic#/%d c: %d', line_count, col),
    })
end

--- Renders the statusline.
---@return string
function M.render()
    ---@param components string[]
    ---@return string
    local function concat_components(components)
        return vim.iter(components):skip(1):fold(components[1], function(acc, component)
            return #component > 0 and string.format('%s    %s', acc, component) or acc
        end)
    end

    return table.concat({
        concat_components({
            M.mode_component(),
            M.lsp_progress_component(),
        }),
        '%#StatusLine#%=',
        concat_components({
            M.kulala_component(),
            M.filetype_component(),
            M.position_component(),
        }),
        ' ',
    })
end
vim.o.statusline = '%!v:lua.require\'core.tools.statusline\'.render()'

return M
