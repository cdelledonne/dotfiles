local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    preselect = cmp.PreselectMode.None,
    -- Configure completion sources
    sources = cmp.config.sources{
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
        ['<Tab>'] = cmp.mapping(cmp.select_next_item, { 'i', 'c' }),
        ['<S-Tab>'] = cmp.mapping(cmp.select_prev_item, { 'i', 'c' }),
        ['<C-C>'] = cmp.mapping(cmp.abort, { 'i' }),
        ['<C-Y>'] = cmp.mapping(cmp.complete, { 'i', 'c' }),
        -- Disable unused default mappings
        ['<C-E>'] = cmp.config.disable,
    },
    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = lspkind.cmp_format({
            symbol_map = {
                Module = '',
            },
        }),
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources{
        -- { name = 'path', max_item_count = 20 },
        { name = 'cmdline', max_item_count = 20 },
    },
})
