local M = {}

-- Cache file for storing user-defined commands
local db_dir = vim.fn.expand('%:p:h')
local db_commands = db_dir .. '/commands.json'

if string.match(db_dir, 'db%-collection') then
    -- Load commands from cache
    local function load_commands()
        if vim.fn.filereadable(db_commands) == 0 then
            return {}
        end

        local file = io.open(db_commands, 'r')
        if not file then
            return {}
        end

        local content = file:read('*a')
        file:close()

        local ok, commands = pcall(vim.json.decode, content)
        if ok and commands then
            return commands
        end

        return {}
    end

    -- Find an existing window showing the given absolute path
    local function find_win_by_path(abs_path)
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local name = vim.api.nvim_buf_get_name(buf)
            if name == abs_path then
                return win
            end
        end
        return nil
    end

    -- Common function to run queries with any backend
    local function run_query(name, cmd)
        local outfile = db_dir .. '/sql.out'
        local abs_out = vim.fn.fnamemodify(outfile, ':p')

        -- Status: running
        vim.api.nvim_echo({ { '[sql-runner] Running ' .. name .. ' query…', 'ModeMsg' } }, false, {})
        local t0 = vim.loop.hrtime()

        -- Run the command
        local full_cmd = cmd .. ' > ' .. vim.fn.shellescape(outfile)
        local start_visual_selection = vim.fn.line('\'<')
        local end_visial_selection = vim.fn.line('\'>')

        local lines = vim.api.nvim_buf_get_lines(0, start_visual_selection - 1, end_visial_selection, false)
        local text = table.concat(lines, ' ')
        local processed = text:gsub(';', '\\G')

        local vim_cmd = string.format('!echo "%s" | %s', processed, full_cmd)

        -- Debug: show exact command being run
        -- vim.api.nvim_echo({ { '[sql-runner] Executing: ' .. vim_cmd, 'Comment' } }, false, {})

        vim.cmd(vim_cmd)

        -- Open or focus existing results split, then reload contents
        local win = find_win_by_path(abs_out)
        if win then
            vim.api.nvim_set_current_win(win)
            vim.cmd('noautocmd edit') -- reload file without flicker
        else
            vim.cmd('rightbelow vsplit ' .. vim.fn.fnameescape(outfile))
        end

        -- Done message with timing
        local ms = math.floor((vim.loop.hrtime() - t0) / 1e6)
        vim.api.nvim_echo({ { string.format('[sql-runner] %s query done in %d ms', name, ms), 'ModeMsg' } }, false, {})
    end

    -- Run SQL with the selected command based on file name
    function M.run_sql()
        local file_name = vim.fn.expand('%:r')
        run_query(file_name, load_commands()[file_name])
    end

    -- Register commands
    --vim.api.nvim_create_user_command('AddSqlCmd', M.add_command, {})
    --vim.api.nvim_create_user_command('RemoveSqlCmd', M.remove_command, {})
    --vim.api.nvim_create_user_command('SelectSqlCmd', M.select_command, {})
    vim.api.nvim_create_user_command('RunSQL', M.run_sql, { range = true })

    -- Set up keymaps
    vim.keymap.set('v', '<leader>rq', ':RunSQL<CR>', { silent = true, desc = 'Run SQL with selected backend' })
    --vim.keymap.set('n', '<leader>ps', ':SelectSqlCmd<CR>', { silent = true, desc = 'Select SQL backend' })
    --vim.keymap.set('n', '<leader>pa', ':AddSqlCmd<CR>', { silent = true, desc = 'Add SQL command' })
    --vim.keymap.set('n', '<leader>px', ':RemoveSqlCmd<CR>', { silent = true, desc = 'Remove SQL command' })
end

return M
