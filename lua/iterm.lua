if os.getenv("TERM_PROGRAM") == "iTerm.app" then
  vim.cmd [[hi SignColumn ctermbg=none guibg=none]]
  vim.cmd [[hi IlluminatedWordRead cterm=bold ctermbg=none gui=underline]]
end
