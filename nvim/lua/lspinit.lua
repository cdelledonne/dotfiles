local nvim_lsp = require 'nvim_lsp'

local os = vim.loop.os_uname().sysname

if os == "Linux" then
    nvim_lsp.ccls.setup{
        cmd = { "ccls", "-v=1", "-log-file=/tmp/ccls.log" };
        init_options = {
            cache = { directory = "/tmp/ccls-cache" },
            compilationDatabaseDirectory = "build",
            client = { snippetSupport = true },
            clang = { extraArgs = { "-Wno-extra", "-Wno-empty-body" } },
            completion = { detailedLabel = false, caseSensitivity = 1 },
        };
    }
elseif os == "Darwin" then
    nvim_lsp.ccls.setup{
        cmd = { "/Users/carlo/builds/ccls/Release/ccls", "-v=2", "-log-file=/tmp/ccls.log" };
        init_options = {
            cache = { directory = "/tmp/ccls-cache" },
            compilationDatabaseDirectory = "build",
            clang = {
                extraArgs = {
                    "-Wno-extra",
                    "-Wno-empty-body",
                    "-isystem/usr/local/include",
                    "-isystem/Library/Developer/CommandLineTools/usr/bin/../include/c++/v1",
                    "-isystem/Library/Developer/CommandLineTools/usr/lib/clang/11.0.0/include",
                    "-isystem/Library/Developer/CommandLineTools/usr/include",
                    "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include",
                    "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks"
                },
                resourceDir = "/Library/Developer/CommandLineTools/usr/lib/clang/11.0.0"
            },
            completion = { detailedLabel = false, caseSensitivity = 1 },
            diagnostics = { onChange = -1 }
        };
    }
end

nvim_lsp.texlab.setup{

}

nvim_lsp.pyls.setup{
    -- cmd = { "pyls", "-v", "--log-file", "/tmp/pyls.log" };
}
