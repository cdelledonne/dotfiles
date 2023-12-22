local function fname_to_hguard(args, parent)
    local fname = vim.fs.normalize(vim.api.nvim_buf_get_name(0))
    local rel_fname = vim.fn.fnamemodify(fname, ":p:.")
    local hguard = string.upper(string.gsub(rel_fname, "[%/%-%.]", "_")) .. "_"
    return sn(nil, { i(1, hguard) })
end

local main = s(
    { trig = "main", desc = "main(int argc, char* argv[])" },
    fmt("main(int argc, char* argv[])", {})
)

local hguard = s(
    { trig = "hguard", desc = "#ifndef … #define … #endif", name = "Header guard" },
    fmt([[
        #ifndef {}
        #define {}

        {}

        #endif  // {}
    ]], { d(1, fname_to_hguard, nil), rep(1), i(0), rep(1) }
    )
)

return {
    main,
    hguard,
}
