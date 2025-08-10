return {
    enabled = false,
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
        'nvim-neotest/nvim-nio',
    },
    config = function()
        local dap = require('dap')
        local ui = require('dapui')

        ui.setup()

        require('nvim-dap-virtual-text').setup({
            commented = true,
        })
        package.path = package.path .. ';../?.lua'
        local work_settings = require('work-settings')

        dap.adapters.php = {
            type = 'executable',
            command = 'node',
            args = { table.concat(work_settings.phpDebugAdapter) .. 'extension/out/phpDebug.js' },
        }

        dap.configurations.php = {
            {
                type = 'php',
                request = 'launch',
                name = 'Listen for Xdebug',
                port = 9003,
                pathMappings = work_settings.pathMappings,
            },
        }

        vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
        vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
        vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = '' })

        vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint)
        vim.keymap.set('n', '<leader>bc', dap.run_to_cursor)

        ---- Eval var under cursor
        --vim.keymap.set("n", "<space>?", function()
        --    ui.eval(nil, { enter = true })
        --end)

        vim.keymap.set('n', '<F6>', dap.continue)
        vim.keymap.set('n', '<F7>', dap.step_into)
        vim.keymap.set('n', '<F8>', dap.step_over)
        vim.keymap.set('n', '<F9>', dap.step_out)
        vim.keymap.set('n', '<F10>', dap.disconnect)
        vim.keymap.set('n', '<F11>', dap.restart)
        vim.keymap.set('n', '<F12>', ui.toggle)

        dap.listeners.before.attach.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end
    end,
}
