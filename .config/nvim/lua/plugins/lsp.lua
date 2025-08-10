local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', function()
        require('fzf-lua').lsp_definitions({ jump1 = true })
    end, '[G]oto [D]efinition')
    nmap('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')
    nmap('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('fzf-lua').lsp_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

local servers = {
    harper_ls = {
        settings = {
            ['harper-ls'] = {
                userDictPath = '~/dotfiles/.config/nvim/spell/harper_dict.txt',
                linters = {
                    SentenceCapitalization = false,
                },
            },
        },
        filetypes = { 'markdown' },
    },
    gopls = {
        settings = {
            telemetry = {
                enabled = false,
            },
        },
    },
    html = {
        settings = {
            telemetry = {
                enabled = false,
            },
        },
        filetypes = { 'html', 'twig', 'hbs' },
    },
    intelephense = {
        settings = {
            telemetry = {
                enabled = false,
            },
        },
    },
    ts_ls = {
        settings = {
            telemetry = {
                enabled = false,
            },
        },
    },
    lua_ls = {
        settings = {
            Lua = {
                workspace = {
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
                diagnostics = {
                    globals = { 'vim' },
                    disable = { 'missing-fields' },
                },
            },
        },
    },
    pyright = {
        settings = {
            telemetry = {
                enabled = false,
            },
        },
    },
    jdtls = {
        settings = {
            telemetry = {
                enabled = false,
            },
        },
    },
}

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'mason-org/mason-lspconfig.nvim',
        'mason-org/mason.nvim',
        {
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = {
                library = {
                    { path = 'luvit-meta/library', words = { 'vim%.uv' } },
                },
            },
        },
        { 'Bilal2453/luvit-meta', lazy = true },
    },
    config = function()
        --local capabilities = vim.lsp.protocol.make_client_capabilities()
        --capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        local mason_lspconfig = require('mason-lspconfig')
        require('mason').setup()
        local server_names = vim.tbl_keys(servers)
        mason_lspconfig.setup({
            ensure_installed = server_names,
        })
        for _, server_name in pairs(server_names) do
            vim.lsp.config(server_name, {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name].settings,
                init_options = (servers[server_name] or {}).init_options,
                filetypes = (servers[server_name] or {}).filetypes,
            })
        end
    end,
}
