local dap = require('dap')
local dapui = require('dapui')

-- Sign symbols
vim.fn.sign_define('DapBreakpoint',
    { text = 'ﭦ', texthl = 'GruvboxBlue', culhl = 'GruvboxBlueSign' })
vim.fn.sign_define('DapBreakpointCondition',
    { text = '', texthl = 'GruvboxBlue', culhl = 'GruvboxBlueSign' })
vim.fn.sign_define('DapBreakpointRejected',
    { text = '', texthl = 'GruvboxRed', culhl = 'GruvboxRedSign' })
vim.fn.sign_define('DapStopped',
    { text = 'ﲒ', texthl = 'GruvboxGreenSign', linehl = 'CursorLine', numhl = 'GruvboxGreenSign' })

-- Callbacks
dap.listeners.after.event_initialized['dapui'] = function() dapui.open() end
dap.listeners.before.event_terminated['dapui'] = function() dapui.close() end
dap.listeners.before.event_exited['dapui'] = function() dapui.close() end

-- UI
dapui.setup({
    expand_lines = false,
    layouts = {
        {
            elements = { 'stacks', 'breakpoints', 'scopes', 'watches' },
            size = 40,
            position = 'left',
        },
        {
            elements = { 'repl', 'console' },
            size = 0.25,
            position = 'bottom',
        },
    },
    floating = {
        border = 'rounded',
    },
    windows = { indent = 2 },
})

-- Debug adapters and configurations
require('plugins/dap-adapters')
