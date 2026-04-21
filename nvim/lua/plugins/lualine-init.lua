local lualine = require("lualine")

-- Definition of customized sections
local lualine_b = {
    function()
        local configs = vim.fn["cmake#GetInfo"]().configs
        if #configs == 0 then
            return ""
        else
            return " " .. vim.fn["cmake#GetInfo"]().config
        end
    end,
    "diff",
    "diagnostics",
}
local lualine_c = {
    {
        "filename",
        path = 1,  -- relative path
        symbols = {
            modified = " ",
            readonly = " ",
            unnamed = "[No Name]",
        },
    },
}
local inactive_lualine_c = {
    {
        "filename",
        path = 1,  -- relative path
        symbols = {
            modified = " ",
            readonly = " ",
            unnamed = "[No Name]",
        },
    },
}

-- Definition of customized Vim-CMake extension
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

-- Definition of customized Neo-tree extension
local neotree_sections = vim.deepcopy(lualine.get_config().sections)
local neotree_sources_manager = require("neo-tree.sources.manager")
neotree_sections.lualine_a = {
    function() return "Neo-tree" end,
}
neotree_sections.lualine_c = {
    function()
        local source_name = neotree_sources_manager.get_state_for_window().name
        return source_name:gsub("_", " "):gsub("^%l", string.upper)
    end,
}
neotree_sections.lualine_b = lualine_b  -- Same as our default custom B section
local neotree = {
    sections = neotree_sections,
    filetypes = { "neo-tree" },
}

lualine.setup({
    options = {
        globalstatus = true,
        always_show_tabline = false,
    },
    sections = {
        lualine_b = lualine_b,
        lualine_c = lualine_c,
    },
    inactive_sections = {
        lualine_c = inactive_lualine_c,
    },
    extensions = {
        "man",
        "quickfix",
        "trouble",
        vimcmake,
        neotree,
    },
    tabline = {
        lualine_a = {{ "tabs", mode = 2 }},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
})

-- Set this here because the setup() function overrides it
vim.o.showtabline = 1
