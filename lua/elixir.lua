local function multiline(pattern, headline, lines, startPosition, errors)
  local modernEndingLineWithCol = "(%s+)└─ (.+):(%d+):(%d+):(.+)"
  local modernEndingLineWithoutCol = "(%s+)└─ (.+):(%d+):(.+)"
  local classicEndingLineWithCol = "(%s+)(.+):(%d+):(%d+):(.+)"
  local classicEndingLineWithoutCol = "(%s+)(.+):(%d+):(.+)"

  for i = startPosition, #lines do
    local line = lines[i]

    local _pre, file1, ln1, col1 = line:match(modernEndingLineWithCol)
    local _pre, file2, ln2 = line:match(modernEndingLineWithoutCol)
    local _blank, file3, ln3, col2 = line:match(classicEndingLineWithCol)
    local _blank, file4, ln4 = line:match(classicEndingLineWithoutCol)

    local file = file1 or file2 or file3 or file4
    local ln = ln1 or ln2 or ln3 or ln4
    local col = col1 or col2 or col3 or col4 or 0

    if file and ln then
      table.insert(errors, { kind = pattern.kind, file = file, line = ln, col = 0, message = headline })
      return
    end
  end
end


local function search_hint(lines, startPosition)
  local hintPattern = "(%s+)HINT: (.+)"
  for i = startPosition, #lines do
    local line = lines[i]
    local padding, hintText = line:match(hintPattern)
    if hintText then
      local hint = { message = hintText, ln = nil }
      local pre, newLineNum, post = hintText:match("(.+)line (%d+)(.+)")
      if newLineNum then
        hint.ln = newLineNum
      end
      return hint
    end
  end
end

local function missingToken(pattern, headline, lines, startPosition, errors)
  local file, ln, col, message = headline:match("(.+):(%d+):(%d+): (.+)")
  if file and ln and col and message then
    local hint = search_hint(lines, startPosition)
    if hint then
      message = hint.message
      ln = hint.ln or ln
    end

    table.insert(errors, { kind = pattern.kind, file = file, line = ln, col = col, message = message })
  end
end

local function compileError(pattern, headline, _lines, _startPosition, errors)
  local patternWithCol = "(.+):(%d+):(%d+): (.+)"
  local patternWithoutCol = "(.+):(%d+): (.+)"

  local file1, ln1, col1, message1 = headline:match(patternWithCol)
  local file2, ln2, message2 = headline:match(patternWithoutCol)

  local file = file1 or file2
  local ln = ln1 or ln2
  local message = message1 or message2
  local col = col1 or 0

  if file and ln and message then
    table.insert(errors, { kind = pattern.kind, file = file, line = ln, col = col, message = message })
  end
end


local patterns = {
  { pattern = "** %(TokenMissingError%) (.+)", handler = missingToken, kind = "error" },
  { pattern = "** %(CompileError%) (.+)",      handler = compileError, kind = "error" },
  { pattern = "** %(SyntaxError%) (.+)",       handler = compileError, kind = "error" },
  { pattern = "error: (.+)",                   handler = multiline,    kind = "error" },
  { pattern = "warning: (.+)",                 handler = multiline,    kind = "warning" }
}

local function parse(lines)
  local errors = {}

  for i, line in ipairs(lines) do
    for _, p in ipairs(patterns) do
      local matched = line:match(p.pattern)
      if matched then
        p.handler(p, matched, lines, i, errors)
      end
    end
  end

  return errors
end


local function run_async(cmd, result_table, on_complete)
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      for _, line in ipairs(data) do
        if line ~= "" then
          table.insert(result_table, line)
        end
      end
    end,
    on_stderr = function(_, data)
      for _, line in ipairs(data) do
        if line ~= "" then
          table.insert(result_table, line)
        end
      end
    end,
    on_exit = on_complete
  })
end

local function has_errors(text)
  local keywords = { "error", "warn" }
  local lower_text = text:lower()
  for _, keyword in ipairs(keywords) do
    if lower_text:find(keyword) then
      return true
    end
  end
  return false
end


local function show_in_quickfix(errors)
  local qflist = {}
  for _, error in ipairs(errors) do
    local lnum = error.line .. " col " .. error.col .. " " .. error.kind
    table.insert(qflist, { filename = error.file, lnum = lnum, text = error.message })
  end

  vim.fn.setqflist({}, 'r', { title = 'Build errors', items = qflist })
  vim.cmd('copen')
end

local function print_output(output)
  local errors = parse(output)
  local text = table.concat(output, "\n")
  if has_errors(text) then
    print("Found " .. #errors .. " error(s)")
    vim.api.nvim_err_write(text)
    show_in_quickfix(errors)
  else
    print("No errors found")
    vim.cmd('silent! edit')
    vim.cmd('cclose')
  end
end

local function compile_and_format_elixir()
  local combined_output = {}
  local completed_jobs = 0

  local function on_job_complete()
    vim.cmd('silent! edit')
    completed_jobs = completed_jobs + 1
    if completed_jobs == 2 then
      print_output(combined_output)
    end
  end

  vim.cmd('write')
  local file_path = vim.fn.expand('%')

  run_async('mix compile 2>&1', combined_output, on_job_complete)
  run_async('mix format ' .. file_path .. ' 2>&1', combined_output, on_job_complete)
end

vim.api.nvim_create_augroup('ElixirFormat', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.ex', '*.exs' },
  callback = compile_and_format_elixir,
  group = 'ElixirFormat',
})

-- vim.api.nvim_set_option('confirm', true)
