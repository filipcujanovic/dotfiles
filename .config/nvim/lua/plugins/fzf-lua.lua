local parse_entry = function(messages, entry_str)
    local id = tonumber(entry_str:match('^%d+'))
    local entry = messages[id]
    return entry
end
local previewer = function(messages)
    local previewer = require('fzf-lua.previewer.builtin').buffer_or_file:extend()
    function previewer:new(o, opts, fzf_win)
        previewer.super.new(self, o, opts, fzf_win)
        self.title = 'Message'
        setmetatable(self, previewer)
        return self
    end

    function previewer:populate_preview_buf(entry_str)
        local buf = self:get_tmp_buffer()
        local entry = parse_entry(messages, entry_str)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { entry.original })

        self:set_preview_buf(buf)
        self.win:update_preview_title(' Message ')
        self.win:update_preview_scrollbar()
        self.win:set_winopts(self.win.preview_winid, { wrap = true })
    end

    return previewer
end
local format_message = function(message, message_id)
    local hl_group = message.hl_group
    local time = vim.fn.strftime('%H:%M:%S', math.floor(message.ts_update))
    local level = require('fzf-lua.utils').ansi_from_hl(hl_group, message.level)

    return {
        message = message,
        original = message.msg:gsub('[\n\r]', ' '),
        display = string.format('%s %s %s %s', message_id, time, level, message.msg):gsub('[\n\r]', ' '),
    }
end
local format_messages = function(messages)
    local ret = {}
    for message_id, message in ipairs(messages) do
        ret[message_id] = format_message(message, message_id)
    end
    return ret
end

local get_message_history_picker = function()
    local messages = format_messages(require('mini.notify').get_all())
    local opts = {
        prompt = false,
        winopts = {
            title = ' Filter Notifications ',
            title_pos = 'center',
            preview = {
                title = ' Message ',
                title_pos = 'center',
            },
        },
        previewer = previewer(messages),
        fzf_opts = {
            ['--no-multi'] = '',
            ['--with-nth'] = '2..',
        },
        actions = {
            default = function(selected)
                print(vim.inspect(selected))
            end,
        },
    }
    local lines = vim.tbl_map(function(entry)
        return entry.display
    end, vim.tbl_values(messages))
    return require('fzf-lua').fzf_exec(lines, opts)
end

return {
    'ibhagwan/fzf-lua',
    config = function()
        local fzf = require('fzf-lua')
        local actions = fzf.actions
        require('fzf-lua').setup({
            'max-perf',
            winopts = {
                preview = {
                    layout = 'vertical',
                },
            },
            keymap = {
                fzf = {
                    ['ctrl-q'] = 'select-all+accept',
                },
            },
            files = {
                cwd_prompt = false,
            },
            file_ignore_patterns = {
                '.obsidian/',
                'node_modules',
                --'vendor',
                '^adminrebuild',
                -- '^admin/',
                'v/1.*',
                'v/0.*',
                --'^.git/',
                -- '.git*',
            },
            defaults = {
                git_icons = false,
                file_icons = false,
                color_icons = false,
                actions = {
                    ['ctrl-x'] = actions.file_split,
                    ['ctrl-s'] = false,
                },
            },
            grep = {
                hidden = true,
                rg_glob = true,
            },
            buffers = {
                actions = {
                    ['ctrl-d'] = {
                        fn = function(selected)
                            local bufnr = tonumber(selected[1]:match('%d+'))
                            bufnr = bufnr == nil and 0 or bufnr + 0
                            vim.api.nvim_buf_delete(bufnr, { force = true })
                        end,
                        reload = true,
                    },
                },
            },
        })
        vim.keymap.set('n', '<leader>k', fzf.keymaps, { desc = 'Find [K]eymaps' })
        vim.keymap.set('n', '<leader><space>', fzf.buffers, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>?', fzf.oldfiles, { desc = '[?] Find recently opened files' })
        vim.keymap.set('n', '<leader>gf', fzf.git_files, { desc = 'Search [G]it [F]iles' })
        vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>ss', fzf.spell_suggest, { desc = '[S]ell [S]suggest' })
        vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>/', function()
            require('fzf-lua').grep_curbuf({ previewer = false })
        end, { desc = '[/] Fuzzily search in current buffer' })
        vim.keymap.set('n', '<leader>fn', function()
            return get_message_history_picker()
        end, { desc = 'Find Notifications' })
    end,
}
