local function vim_mode()
  local mode_map = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    c = "COMMAND",
    R = "REPLACE",
    t = "TERMINAL",
  }
  return mode_map[vim.fn.mode()] or vim.fn.mode()
end

local function git_branch()
  -- Try to get the branch name from git command
  local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
  local branch = handle:read("*a") or ""
  handle:close()

  -- Trim any extra whitespace
  branch = branch:gsub("\n", "")

  -- Return formatted branch if available
  return branch ~= "" and ("[" .. branch .. "]") or ""
end

_G.vim_mode = vim_mode
_G.git_branch = git_branch

vim.opt.statusline = "%!v:lua.vim_mode() .. ' ' .. v:lua.git_branch() .. ' %<%f %h%m%r%=%-14.(%l,%c%V%) %P'"

