local dap = require("dap")

-- C/C++ adapter - LLDB
dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
    id = "lldb",
}

-- C/C++ adapter - GDB
dap.adapters.gdb = {
    type = "executable",
    -- command = "/home/cdelledonne/.local/opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-gdb",
    command = "gdb",
    args = {
        "--interpreter=dap",
        -- "--interpreter=mi",
        "--eval-command", "set print pretty on",
    },
}

-- C/C++ adapter configurations
dap.configurations.cpp = {
    {
        name = "Attach to LinkServer GDB server",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        miDebuggerServerAddress = "localhost:10989",
        miDebuggerPath = "arm-none-eabi-gdb",
        stopOnEntry = true,
        stopAtBeginningOfMainSubprogram = true,
    },
    {
        name = "Attach to gdbserver :10989",
        type = "gdb",
        request = "launch",
        target = "localhost:10989",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        stopAtBeginningOfMainSubprogram = true,
    },
    {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        args = {},
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        runInTerminal = true,
    },
    {
        name = "Attach to target",
        type = "lldb",
        request = "attach",
        cwd = "${workspaceFolder}",
        attachCommands = {
            "",
        },
    },
}
dap.configurations.c = dap.configurations.cpp

-- Python adapter
dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
    id = "debugpy",
}

-- Python adapter configurations
dap.configurations.python = {
    {
        name = "Launch file",
        type = "python",
        request = "launch",
        program = "${file}",
        pythonPath = function()
            -- Are we in a virtual environment already?
            local venv = os.getenv("VIRTUAL_ENV") 
            if venv then
                return string.format("%s/bin/python", venv) 
            -- Otherwise, is there a Pipenv environment in the project?
            else
                local pipenv_py = io.popen("pipenv --py 2>/dev/null"):read("l")
                if pipenv_py then
                    return pipenv_py
                end
            end
            -- Otherwise, default to global Python
            return "/usr/bin/python"
        end,
        console = "integratedTerminal",
    },
}
