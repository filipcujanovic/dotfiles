local home = vim.loop.os_homedir()
local cwd = vim.fn.getcwd()
local has_args = #vim.fn.argv() ~= 0
local excluded_dirs = {
    home,
    home .. '/projects',
    home .. '/Downloads',
    '/',
}

local function is_excluded_dir(dir)
    for _, excluded_dir in ipairs(excluded_dirs) do
        if dir == excluded_dir then
            return true
        end
    end
    return false
end

if has_args or is_excluded_dir(cwd) then
    return
end

local local_dir = cwd:gsub('[\\/:]+', '%%')
local session_path = string.format('%s/sessions/%s.vim', vim.fn.stdpath('data'), local_dir)

vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
        vim.cmd('mks! ' .. vim.fn.fnameescape(session_path))
    end,
})

if session_path and vim.fn.filereadable(session_path) ~= 0 then
    vim.cmd('silent! source ' .. vim.fn.fnameescape(session_path))
end
