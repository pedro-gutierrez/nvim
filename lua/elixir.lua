local function multiline(pattern, headline, lines, startPosition, errors)
  local modernEndingLineWithCol = "(%s+)└─ (.+):(%d+):(%d+):(.+)"
  local modernEndingLineWithoutCol = "(%s+)└─ (.+):(%d+):(.+)"
  local classicEndingLineWithCol = "(%s+)(.+):(%d+):(%d+):(.+)"
  local classicEndingLineWithoutCol = "(%s+)(.+):(%d+):(.+)"

  for i = startPosition, #lines do
    local line = lines[i]

    local _, file1, ln1, col1 = line:match(modernEndingLineWithCol)
    local _, file2, ln2 = line:match(modernEndingLineWithoutCol)
    local _, file3, ln3, col2 = line:match(classicEndingLineWithCol)
    local _, file4, ln4 = line:match(classicEndingLineWithoutCol)

    local file = file1 or file2 or file3 or file4
    local ln = ln1 or ln2 or ln3 or ln4
    local col = col1 or col2 or 0

    if file and ln then
      table.insert(errors, { kind = pattern.kind, file = file, line = ln, col = col, message = headline })
      return
    end
  end
end


local function search_hint(lines, startPosition)
  local hintPattern = "(%s+)HINT: (.+)"
  for i = startPosition, #lines do
    local line = lines[i]
    local _, hintText = line:match(hintPattern)
    if hintText then
      local hint = { message = hintText, ln = nil }
      local _, newLineNum, _ = hintText:match("(.+)line (%d+)(.+)")
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

local function compileError(pattern, headline, _, _, errors)
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
    vim.api.nvim_err_write(text)
    if #errors > 0 then
      print("Found " .. #errors .. " error(s)")
      show_in_quickfix(errors)
    end
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

  run_async('MIX_ENV=test mix compile 2>&1', combined_output, on_job_complete)
  run_async('mix format ' .. file_path .. ' 2>&1', combined_output, on_job_complete)
end

vim.api.nvim_create_augroup('ElixirFormat', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.ex', '*.exs' },
  callback = compile_and_format_elixir,
  group = 'ElixirFormat',
})


local function get_word_under_cursor()
  local word = vim.fn.expand("<cword>") -- gets the word under the cursor
  return word
end

local function trim(s)
  return s:match("^%s*(.-)%s*$")
end

-- Function to search for the module definition using `ag` Lua API
local function find_module_definition(module_name, callback)
  local cmd = string.format("ag '%s' | grep 'defmodule'", module_name)


  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      local lines = {}
      if data and #data > 0 then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(lines, line)
          end
        end
      end
      callback(lines)
    end,
    on_stderr = function(_, data)
      if data and #data > 0 then
        local message = trim(table.concat(data, "\n"))
        if #message > 0 then
          print("Error running ag: " .. #message)
        end
      end
    end,
    on_exit = function(_, exit_code)
      if exit_code ~= 0 then
        print("ag command failed with exit code:", exit_code)
      end
    end,
  })
end

-- Main function to go to the definition
local function goto_definition()
  local module_name = get_word_under_cursor()
  if not module_name or module_name == "" then
    print("No module name found under the cursor.")
    return
  end

  -- Use the find_module_definition function with a callback
  find_module_definition(module_name, function(lines)
    if not lines or #lines ~= 1 then
      print("Module definition not found or multiple matches exist.")
      return
    end

    -- Extract the file path and line number from the match
    local file_path, line_number = lines[1]:match("([^:]+):(%d+):")
    if file_path and line_number then
      -- Open the file and go to the line number where the module is defined
      vim.cmd("edit " .. file_path)
      vim.cmd(line_number)
    else
      print("Could not parse the result.")
    end
  end)
end


vim.api.nvim_create_user_command("OpenDefinition", goto_definition, {})

local function set_key_mappings()
  vim.api.nvim_set_keymap('n', '<leader>d', ':OpenDefinition<CR>', { noremap = true, silent = true })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'elixir',
  callback = function()
    set_key_mappings()
  end,
})


-- vim.api.nvim_set_option('confirm', true)
