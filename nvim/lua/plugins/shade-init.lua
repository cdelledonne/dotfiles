local shade = require('shade')

shade.setup({
    exclude_filetypes = {
        'dap-repl',
        'dapui_breakpoints',
        'dapui_console',
        'dapui_scopes',
        'dapui_stacks',
        'dapui_watches',
        'vimcmake',
    },
})
