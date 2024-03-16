local neogen = require("neogen")

local i = require("neogen.types.template").item
annotation = {
    { nil, "///", { no_results = true, type = { "func", "file", "class" } } },
    { nil, "/// @file", { no_results = true, type = { "file" } } },
    { nil, "/// @brief $1", { no_results = true, type = { "func", "file", "class" } } },
    { nil, "///", { no_results = true, type = { "func", "file", "class" } } },
    { nil, "", { no_results = true, type = { "file" } } },

    { nil, "///", { type = { "func", "class", "type" } } },
    { i.ClassName, "/// @class %s", { type = { "class" } } },
    { i.Type, "/// @typedef %s", { type = { "type" } } },
    { nil, "/// @brief $1", { type = { "func", "class", "type" } } },
    { nil, "///", { type = { "func", "class", "type" } } },
    { i.Tparam, "/// @tparam %s $1" },
    { i.Parameter, "/// @param %s $1" },
    { i.Return, "/// @return $1" },
    { nil, "///", { type = { "func", "class", "type" } } },
}

neogen.setup({
    snippet_engine = "luasnip",
    languages = {
        cpp = {
            template = {
                annotation_convention = "doxygen_custom",
                doxygen_custom = annotation,
            },
        },
    },
})
