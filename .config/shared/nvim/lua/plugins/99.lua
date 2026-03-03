return {
    'ThePrimeagen/99',
    version = '*',
    config = function()
        local _99 = require('99')

        -- For logging that is to a file if you wish to trace through requests
        -- for reporting bugs, i would not rely on this, but instead the provided
        -- logging mechanisms within 99.  This is for more debugging purposes
        local cwd = vim.uv.cwd()
        local basename = vim.fs.basename(cwd)
        _99.setup({
            provider = _99.Providers.ClaudeCodeProvider,
            logger = {
                level = _99.DEBUG,
                path = '/tmp/' .. basename .. '.99.debug',
                print_on_error = true,
            },

            completion = {
                files = {},
                source = 'blink',
            },

            md_files = {
                'AGENT.md',
            },
        })

        -- take extra note that i have visual selection only in v mode
        -- technically whatever your last visual selection is, will be used
        -- so i have this set to visual mode so i dont screw up and use an
        -- old visual selection
        --
        -- likely ill add a mode check and assert on required visual mode
        -- so just prepare for it now
        vim.keymap.set('v', '<leader>cc', function()
            _99.visual()
        end)

        --- if you have a request you dont want to make any changes, just cancel it
        vim.keymap.set('v', '<leader>cs', function()
            _99.stop_all_requests()
        end)
    end,
}
