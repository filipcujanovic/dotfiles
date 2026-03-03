local M = {}

M.is_netrw_open = false

function M.open_netrw()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_get_option_value('filetype', { buf = buf }) == 'netrw' then
            M.is_netrw_open = true
        end
    end

    if M.is_netrw_open then
        vim.cmd('Lexplore')
    else
        vim.cmd('Lexplore %:p:h')
    end
end

function M.open_file_from_yazi(yazi_current_file)
    if vim.fn.filereadable(yazi_current_file) == 1 then
        local selection = vim.fn.readfile(yazi_current_file)
        vim.fn.delete(yazi_current_file)
        if selection and #selection > 0 and selection[1] ~= '' then
            local file_to_open = vim.fn.fnameescape(selection[1])
            vim.cmd(string.format('edit %s', file_to_open))
        end
    end
end

function M.yazi_in_tmux()
    local yazi_current_file = '/tmp/current-yazi-file'
    local current_file_path = vim.fn.expand('%')
    vim.fn.delete(yazi_current_file)
    vim.fn.system(
        string.format(
            'tmux display-popup -w 90%% -h 90%% -E "tmux new-session -d -s yazi \\"yazi --chooser-file=%s %s\\"; tmux set-option -t yazi detach-on-destroy on; tmux a -t yazi"',
            yazi_current_file,
            current_file_path
        )
    )
    M.open_file_from_yazi(yazi_current_file)
end

function M.yazi_in_nvim_terminal(split)
    local yazi_current_file = '/tmp/current-yazi-file'
    local current_file_path = vim.fn.expand('%')
    current_file_path = string.gsub(current_file_path, ' ', '\\ ')
    vim.fn.delete(yazi_current_file)
    local width = math.floor(vim.o.columns * 0.9)
    local height = math.floor(vim.o.lines * 0.9)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)
    local buf = vim.api.nvim_create_buf(false, true)
    local win
    if split then
        --win = vim.api.nvim_open_win(buf, true, { split = 'left', win = 0, width = 70 })
        --work in progress
    else
        win = vim.api.nvim_open_win(buf, true, {
            relative = 'editor',
            width = width,
            height = height,
            row = row,
            col = col,
            style = 'minimal',
            border = 'rounded',
        })
    end
    vim.fn.jobstart(string.format('yazi --chooser-file=%s %s', yazi_current_file, current_file_path), {
        term = true,
        on_exit = function()
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end
            if vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end
            M.open_file_from_yazi(yazi_current_file)
        end,
    })
    vim.cmd('startinsert')
end

function M.open_file_explorer(type, use_terminal, split)
    if type == 'yazi' then
        if use_terminal then
            M.yazi_in_nvim_terminal(split)
        else
            M.yazi_in_tmux()
        end
    else
        M.open_netrw()
    end
end

return M
