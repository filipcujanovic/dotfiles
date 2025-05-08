local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
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

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

local servers = {
    harper_ls = {
        settings = {
            linters = {
                SentenceCapitalization = false,
            },
        },
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
        filetypes = {
            'php',
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
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = { disable = { 'missing-fields' } },
        },
    },
    pyright = {
        settings = {
            telemetry = {
                enabled = false,
            },
        },
    },
}

return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        'mason-org/mason.nvim',
        'mason-org/mason-lspconfig.nvim',
        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
    },
    config = function()
        local lsp_configurations = require('lspconfig.configs')

        local server_config = {
            ['doesItThrow'] = {
                throwStatementSeverity = 'Hint',
                functionThrowSeverity = 'Hint',
                callToThrowSeverity = 'Hint',
                callToImportedThrowSeverity = 'Hint',
                includeTryStatementThrows = 'Hint',
                maxNumberOfProblems = 10000,
            },
        }

        -- Setup doesItThrow
        if not lsp_configurations.does_it_throw_server then
            lsp_configurations.does_it_throw_server = {
                default_config = {
                    cmd = { 'does-it-throw-lsp', '--stdio' },
                    filetypes = { 'typescript', 'javascript' },
                    root_dir = function(fname)
                        return vim.fn.getcwd()
                    end,
                },
            }
        end

        require('lspconfig').does_it_throw_server.setup({
            on_init = function(client)
                client.config.settings = server_config
            end,
            -- important to set this up so that the server can find your desired settings
            handlers = {
                ['workspace/configuration'] = function(_, params, _, _)
                    local configurations = {}
                    for _, item in ipairs(params.items) do
                        if item.section then
                            table.insert(configurations, server_config[item.section])
                        end
                    end
                    return configurations
                end,
            },
        })
        --local capabilities = vim.lsp.protocol.make_client_capabilities()
        --capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        local mason_lspconfig = require('mason-lspconfig')
        require('mason').setup()
        local server_names = vim.tbl_keys(servers)
        mason_lspconfig.setup({
            ensure_installed = server_names,
        })
        for key, server_name in pairs(server_names) do
            vim.lsp.config(server_name, {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
                filetypes = (servers[server_name] or {}).filetypes,
            })
        end
    end,
}
