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


local function print_output(output)
  local text = table.concat(output, "\n")
  if has_errors(text) then
    vim.api.nvim_err_write(text)
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
  local dot_formatter = string.format("%s/%s", vim.fn.getcwd(), "/.formatter.exs")

  run_async('MIX_ENV=test mix compile 2>&1', combined_output, on_job_complete)
  run_async(string.format('mix format --dot-formatter=%s %s 2>&1', dot_formatter, file_path), combined_output,
    on_job_complete)
end

vim.api.nvim_create_augroup('ElixirFormat', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.ex', '*.exs' },
  callback = compile_and_format_elixir,
  group = 'ElixirFormat',
})
