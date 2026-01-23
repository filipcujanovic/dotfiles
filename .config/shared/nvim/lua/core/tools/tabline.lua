local M = {}

function M.render()
    local s = ''
    local current = vim.fn.tabpagenr()
    local number_of_tabs = vim.fn.tabpagenr('$')

    for i = 1, number_of_tabs do
        local hl = (i == current) and '%#TabLineSel#' or '%#TabLine#'
        local name = vim.fn.fnamemodify(vim.fn.bufname(vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]), ':t')
        if name == '' then
            name = '[no name]'
        end
        local separator = i == number_of_tabs and '' or '%#TablineSeparator# | '
        s = string.format('%s%s%s:%s%s', s, hl, i, name, separator)
    end

    s = string.format('%s%%#TabLineFill#', s)
    return s
end

vim.o.tabline = '%!v:lua.require\'core.tools.tabline\'.render()'

return M
