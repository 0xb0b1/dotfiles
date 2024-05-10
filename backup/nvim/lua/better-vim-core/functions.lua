function _G.reload_nvim_conf()
  for name,_ in pairs(package.loaded) do
    if name:match('^better\\-vim') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("BetterVim configuration reloaded", vim.log.levels.INFO)
end
