local dap = require('dap')

-- C/C++ adapter
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode',
    id = 'lldb',
}

-- C/C++ adapter configurations
dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = {},
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        runInTerminal = true,
    },
    {
        name = 'Attach to target',
        type = 'lldb',
        request = 'attach',
        cwd = '${workspaceFolder}',
        attachCommands = {
            '',
        },
    },
}
dap.configurations.c = dap.configurations.cpp

-- Python adapter
dap.adapters.python = {
    type = 'executable',
    command = 'python',
    args = { '-m', 'debugpy.adapter' },
    id = 'debugpy',
}

-- Python adapter configurations
dap.configurations.python = {
    {
        name = 'Launch file',
        type = 'python',
        request = 'launch',
        program = '${file}',
        pythonPath = function()
            -- Are we in a virtual environment already?
            local venv = os.getenv('VIRTUAL_ENV') 
            if venv then
                return string.format('%s/bin/python', venv) 
            -- Otherwise, is there a Pipenv environment in the project?
            else
                local pipenv_py = io.popen('pipenv --py 2>/dev/null'):read('l')
                if pipenv_py then
                    return pipenv_py
                end
            end
            -- Otherwise, default to global Python
            return '/usr/bin/python'
        end,
        console = 'integratedTerminal',
    },
}

