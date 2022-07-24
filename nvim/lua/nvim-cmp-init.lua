local plugin = require('cmp')
local lspkind = require('lspkind')

plugin.setup{
    preselect = plugin.PreselectMode.None,
    -- Configure completion sources
    sources = plugin.config.sources{
        { name = 'nvim_lsp', max_item_count = 20 },
        { name = 'path', max_item_count = 20 },
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    },
    -- Configure snippet engine
    snippet = {
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    -- Configure key mappings
    mapping = {
        ['<Tab>'] = plugin.mapping(plugin.mapping.select_next_item(), {'i', 'c'}),
        ['<S-Tab>'] = plugin.mapping(plugin.mapping.select_prev_item(), {'i', 'c'}),
        ['<C-C>'] = plugin.mapping(plugin.mapping.abort(), {'i'}),
        ['<C-Y>'] = plugin.mapping(plugin.mapping.complete(), {'i', 'c'}),
        -- Disable unused default mappings
        ['<C-E>'] = plugin.config.disable,
        ['<Up>'] = plugin.config.disable,
        ['<Down>'] = plugin.config.disable,
    },
    -- completion = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, scrollbar = "║" },
    -- documentation = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, scrollbar = "║" },
    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = lspkind.cmp_format({
            symbol_map = {
                Module = '',
            },
        }),
    },
    window = {
        completion = plugin.config.window.bordered(),
        documentation = plugin.config.window.bordered(),
    },
}

plugin.setup.cmdline(':', {
    mapping = plugin.mapping.preset.cmdline(),
    sources = plugin.config.sources{
        -- { name = 'path', max_item_count = 20 },
        { name = 'cmdline', max_item_count = 20 },
    },
})
