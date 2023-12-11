local lualine = require("lualine")

local vimcmake = {
    sections = {
        lualine_a = {
            function() return "CMake" end
        },
        lualine_b = {
            function()
                local project_dir = vim.fn["cmake#GetInfo"]().project_dir
                local project_name = vim.fn.fnamemodify(project_dir, ":t")
                return project_name
            end,
            function() return vim.fn["cmake#GetInfo"]().config end,
        },
        lualine_c = {
            function() return vim.fn["cmake#GetInfo"]().status end,
        },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    },
    inactive_sections = {
        lualine_c = {
            function() return "CMake" end,
            function() return vim.fn["cmake#GetInfo"]().config end,
            function() return vim.fn["cmake#GetInfo"]().status end,
        },
        lualine_x = { "location" },
    },
    filetypes = { "vimcmake" } ,
}

local nvimtree = {
    sections = {
        lualine_a = { function() return "Files" end },
    },
    inactive_sections = {
        lualine_c = { function() return "Files" end },
    },
    filetypes = { "NvimTree" } ,
}

lualine.setup({
    options = {
        -- section_separators = "",
        -- component_separators = "",
        -- section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        globalstatus = true,
    },
    sections = {
        lualine_b = { "diff", "diagnostics" },
        lualine_c = {
            {
                "filename",
                path = 1,  -- relative path
                symbols = {
                    modified = " ",
                    readonly = " ",
                    unnamed = "[No Name]",
                },
            },
        },
    },
    inactive_sections = {
        lualine_c = {
            {
                "filename",
                path = 1,  -- relative path
                symbols = {
                    modified = " ",
                    readonly = " ",
                    unnamed = "[No Name]",
                },
            },
        },
    },
    extensions = {
        "fugitive",
        "man",
        "quickfix",
        vimcmake,
        nvimtree,
    },
})
