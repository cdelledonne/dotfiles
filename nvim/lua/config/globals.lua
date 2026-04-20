-- From :help provider-nodejs
-- By default, Nvim searches for 'neovim-node-host' using 'npm root -g', which
-- can be slow. To avoid this, set g:node_host_prog to the host path:
vim.g.node_host_prog = "/usr/local/bin/neovim-node-host"

-- Open .tex files as LaTeX files
vim.g.tex_flavor = "latex"

-- Redefine leader to be ';'
vim.g.mapleader = ";"

-- Set tab behaviour
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Set folding method but do not fold on start-up
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Fold specific files based on indent (should work with treesitter?)
-- vim.api.nvim_create_autocmd("FileType", {
--     group = augroup,
--     pattern = { "python", "basic", "yaml", "toml", "vim" },
--     callback = function()
--         vim.opt_local.foldmethod = "indent"
--     end,
-- })

-- Soft-wrapped lines will continue visually indented
vim.opt.breakindent = true

-- Show line number
vim.opt.number = true

-- Display keystrokes in the command line in normal mode
vim.opt.showcmd = true

-- Hide mode from command line
vim.opt.showmode = false

-- Hide buffers when abandoned
vim.opt.hidden = true

-- Highlight cursor line
vim.opt.cursorline = true

-- Case-sensitive search ONLY when capital letters appear in the search string
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Case-insensitive path completion in commands
vim.opt.wildignorecase = true

-- Show diff in vertical mode
vim.opt.diffopt:append("vertical")

-- Put new window to the right when using a vertical split
vim.opt.splitright = true

-- Show effects of some commands incrementally in a preview window
vim.opt.inccommand = "split"

-- Set minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 3

-- Do not wrap text except for textual files
vim.opt.wrap = false

-- Set default look for borders
vim.opt.winborder = "rounded"

local augroup = vim.api.nvim_create_augroup("ConfigGlobals", { clear = true })

-- Tab behaviour for some config files
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "yaml", "toml", "markdown" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end,
})

-- Soft-wrap textual files
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "tex", "text", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
    end,
})

-- Enable spell checking for textual files
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "tex", "text", "markdown", "rst", "gitcommit" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
    end,
})

-- Set text width for line breaks for some filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "tex", "text", "markdown", "rst", "gitcommit", "vim" },
    callback = function()
        vim.opt_local.textwidth = 80
    end,
})

-- Open .clangd, .clang-format and .clang-uml files as YAML files
vim.api.nvim_create_autocmd("BufRead", {
    group = augroup,
    pattern = { "*.clangd", "*.clang-format", "*.clang-uml" },
    callback = function()
        vim.bo.filetype = "yaml"
    end,
})

-- Mouse support in normal and visual mode
vim.opt.mouse = "nv"
