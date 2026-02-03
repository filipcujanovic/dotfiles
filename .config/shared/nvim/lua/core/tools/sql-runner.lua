local M = {}

-- Cache file for storing user-defined commands
local db_dir = vim.fn.expand('%:p:h')
local db_commands = db_dir .. '/commands.json'
local visual_selection_namespace = vim.api.nvim_create_namespace('sql_preview')

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

    local function get_query_under_current_line(bufnr)
        if vim.bo.filetype == 'javascript' then
            return vim.api.nvim_get_current_line()
        end

        local node = vim.treesitter.get_node()
        while node do
            if node:type() == 'statement' then
                vim.api.nvim_buf_clear_namespace(bufnr, visual_selection_namespace, 0, -1)
                local sr, _, er, _ = node:range()
                for line = sr, er do
                    vim.api.nvim_buf_add_highlight(bufnr, visual_selection_namespace, 'Visual', line, 0, -1)
                end
                return vim.treesitter.get_node_text(node, bufnr):gsub('\n', ' '):gsub('%s+', ' ') .. '\\G'
            end
            node = node:parent()
        end
    end

    local function get_query_from_visual_selection()
        local start_visual_selection = vim.fn.line('\'<')
        local end_visial_selection = vim.fn.line('\'>')

        local lines = vim.api.nvim_buf_get_lines(0, start_visual_selection - 1, end_visial_selection, false)
        local text = table.concat(lines, ' ')
        return text:gsub(';', '\\G')
    end

    local function get_query_string(bufnr)
        local mode = vim.fn.mode()
        if mode == 'n' then
            return get_query_under_current_line(bufnr)
        elseif mode == 'v' then
            return get_query_from_visual_selection()
        end
    end

    local function run_query(cmd)
        local bufnr = vim.api.nvim_get_current_buf()
        local filetype = vim.bo.filetype
        local outfile = db_dir .. '/sql.out'
        --local t0 = vim.loop.hrtime()

        local processed = get_query_string(bufnr)
        local full_cmd = cmd .. ' > ' .. vim.fn.shellescape(outfile)
        local vim_cmd = string.format('silent !echo "%s" | %s', processed, full_cmd)

        if filetype == 'javascript' then
            outfile = db_dir .. '/output.json'
            processed = processed:gsub('\'', '"')
            full_cmd = string.format('%s | jq > %s ', cmd, vim.fn.shellescape(outfile))
            processed = string.format('JSON.stringify(%s)', processed)
            vim_cmd = string.format(string.format('silent !%s | jq', full_cmd), processed)
        end
        local abs_out = vim.fn.fnamemodify(outfile, ':p')

        --vim.api.nvim_echo({ { '[sql-runner] Executing: ' .. vim_cmd, 'Comment' } }, false, {})

        vim.cmd(vim_cmd)

        --Open or focus existing results split, then reload contents
        local win = find_win_by_path(abs_out)
        if win then
            vim.api.nvim_set_current_win(win)
            vim.cmd('noautocmd edit') -- reload file without flicker
            vim.cmd('wincmd p') -- move focus back file with queries
        else
            vim.cmd('rightbelow vsplit ' .. vim.fn.fnameescape(outfile))
            vim.cmd('wincmd p') -- move focus back file with queries
        end

        --Done message with timing
        --local ms = math.floor((vim.loop.hrtime() - t0) / 1e6)
        --vim.api.nvim_echo({ { string.format('[db-runner] %s query done in %d ms', name, ms), 'ModeMsg' } }, false, {})
    end

    -- Run SQL with the selected command based on file name
    function M.run_query()
        local file_name = vim.fn.expand('%:r')
        run_query(load_commands()[file_name])
    end

    vim.api.nvim_create_user_command('RunQuery', M.run_query, { range = true })
end

return M
