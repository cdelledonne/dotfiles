local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local tab_mapping = function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif luasnip.jumpable(1) then
        luasnip.jump(1)
    else
        fallback()
    end
end

local shift_tab_mapping = function(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
    end
end

cmp.setup({
    preselect = cmp.PreselectMode.None,
    -- Configure completion sources
    sources = cmp.config.sources{
        { name = "nvim_lsp", max_item_count = 20 },
        { name = "path", max_item_count = 20 },
        { name = "luasnip" },
    },
    -- Configure snippet engine
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    -- Configure key mappings
    mapping = {
        ["<Tab>"] = cmp.mapping(tab_mapping, { "i", "c", "s" }),
        ["<S-Tab>"] = cmp.mapping(shift_tab_mapping, { "i", "c", "s" }),
        ["<C-C>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),
        ["<C-Y>"] = cmp.mapping(cmp.mapping.confirm(), { "i" }),
        -- Disable unused default mappings
        ["<C-E>"] = cmp.config.disable,
    },
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = lspkind.cmp_format({
            symbol_map = {
                Module = "󰏗",
            },
        }),
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources{
        { name = "cmdline", max_item_count = 20 },
    },
})
