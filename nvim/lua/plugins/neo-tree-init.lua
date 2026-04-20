local neotree = require("neo-tree")
local lspkind = require("lspkind")

neotree.setup({
    sources = {
        "filesystem",
        "document_symbols",
    },
    enable_diagnostics = false,
    enable_opened_markers = false,
    hide_root_node = true,
    retain_hidden_root_indent = true,
    popup_border_style = "", -- use Neovim's native 'winborder' on 0.11+
    use_popups_for_input = true,
    source_selector = {
        winbar = true,
        sources = {
            { source = "filesystem",       display_name = "  Files " },
            { source = "document_symbols", display_name = " 󰠱 Symbols " },
        },
        tabs_layout = "equal",
        content_layout = "center",
        separator = { left = "", right = "" },
        separator_active = { left = "", right = "" },
        highlight_tab = "lualine_a_tabs_inactive",
        highlight_tab_active = "lualine_a_tabs_active",
        highlight_background = "lualine_a_tabs_inactive",
    },
    default_component_configs = {
        container = {
            right_padding = 1,
        },
        indent = {
            padding = 0,
            with_expanders = true,
        },
        icon = {
            use_filtered_colors = false,
        },
        modified = {
            symbol = " ",
        },
        name = {
            use_filtered_colors = false,
        },
        git_status = {
            symbols = {
                modified  = "",
            },
        },
    },
    window = {
        mappings = {
            -- Focus node without leaving Neo-tree window
            ["F"] = function (state)
                local node = state.tree:get_node()
                local utils = require("neo-tree.utils")
                local command = require("neo-tree.command")
                local function refocus_tree()
                    command.execute({
                        action = "focus",
                        source = state.name,
                        position = state.current_position or state.position,
                    })
                end
                if state.name == "filesystem" and utils.is_expandable(node) then
                    state.commands.toggle_node(state)
                    return
                end
                state.commands.open(state)
                refocus_tree()
            end,
        },
    },
    filesystem = {
        filtered_items = {
            hide_gitignored = false,
        },
    },
    document_symbols = {
        follow_cursor = true,
        window = {
            mappings = {
                ["Z"] = "expand_all_subnodes",
                -- Disable buggy mapping "clear_clipboard"
                ["<C-r>"] = "",
            },
        },
        kinds = {
            File          = { icon = lspkind.symbol_map.File },
            Module        = { icon = lspkind.symbol_map.Module },
            Namespace     = { icon = lspkind.symbol_map.Namespace },
            Package       = { icon = lspkind.symbol_map.Package },
            Class         = { icon = lspkind.symbol_map.Class },
            Method        = { icon = lspkind.symbol_map.Method },
            Property      = { icon = lspkind.symbol_map.Property },
            Field         = { icon = lspkind.symbol_map.Field },
            Constructor   = { icon = lspkind.symbol_map.Constructor },
            Enum          = { icon = lspkind.symbol_map.Enum },
            Interface     = { icon = lspkind.symbol_map.Interface },
            Function      = { icon = lspkind.symbol_map.Function },
            Variable      = { icon = lspkind.symbol_map.Variable },
            Constant      = { icon = lspkind.symbol_map.Constant },
            String        = { icon = lspkind.symbol_map.String },
            Number        = { icon = lspkind.symbol_map.Number },
            Boolean       = { icon = lspkind.symbol_map.Boolean },
            Array         = { icon = lspkind.symbol_map.Array },
            Object        = { icon = lspkind.symbol_map.Object },
            Key           = { icon = lspkind.symbol_map.Key },
            Null          = { icon = lspkind.symbol_map.Null },
            EnumMember    = { icon = lspkind.symbol_map.EnumMember },
            Struct        = { icon = lspkind.symbol_map.Struct },
            Event         = { icon = lspkind.symbol_map.Event },
            Operator      = { icon = lspkind.symbol_map.Operator },
            TypeParameter = { icon = lspkind.symbol_map.TypeParameter },
        },
    },
})
