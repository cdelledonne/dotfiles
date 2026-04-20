local M = {}

function M.toggle_autoformat()
    local fo = vim.opt_local.formatoptions:get()
    local has_a = vim.tbl_contains(fo, "a")

    if has_a then
        vim.opt_local.formatoptions:remove("a")
        vim.notify("Automatic formatting turned OFF")
    else
        vim.opt_local.formatoptions:append("a")
        vim.notify("Automatic formatting turned ON")
    end
end

function M.remove_trailing_spaces()
    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
    vim.notify("Trailing spaces removed")
end

function M.update_plugins()
    vim.pack.update()
    vim.notify("Started plugin update")
end

function M.delete_unused_plugins()
    local unused = vim.iter(vim.pack.get())
        :filter(function(plugin)
            return not plugin.active
        end)
        :map(function(plugin)
            return plugin.spec.name
        end)
        :totable()

    if vim.tbl_isempty(unused) then
        vim.notify("No unused plugins found")
        return
    end

    vim.pack.del(unused)
    vim.notify("Deleted unused plugins: " .. table.concat(unused, ", "))
end

vim.cmd([[
  if !exists('*ToggleAutoFormat')
  function! ToggleAutoFormat() abort
  lua require("config.utils").toggle_autoformat()
  endfunction
  endif

  if !exists('*RemoveTrailingSpaces')
  function! RemoveTrailingSpaces() abort
  lua require("config.utils").remove_trailing_spaces()
  endfunction
  endif

  if !exists('*UpdatePlugins')
  function! UpdatePlugins() abort
  lua require("config.utils").update_plugins()
  endfunction
  endif

  if !exists('*DeleteUnusedPlugins')
  function! DeleteUnusedPlugins() abort
  lua require("config.utils").delete_unused_plugins()
  endfunction
  endif
]])

return M
