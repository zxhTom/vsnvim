copilot = require("copilot")
local function debug_log(msg)
  local log_file = vim.fn.stdpath("log") .. "/copilot-lua.log"
  local fd = vim.loop.fs_open(log_file, "a", 438) -- 438 = 0o666
  if fd then
    vim.loop.fs_write(fd, string.format("[DEBUG] %s\n", msg))
    vim.loop.fs_close(fd)
  end
end

copilot.setup({
  panel = {
    enabled = false,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right | horizontal | vertical
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<C-l>",
      next = "<C-j>",
      prev = "<C-k>",
      dismiss = "<C-h>",
    },
  },
  filetypes = {
    yaml = true,
    markdown = true,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
  logger = {
    file = vim.fn.stdpath("log") .. "/copilot-lua.log",
    file_log_level = vim.log.levels.OFF,
    print_log_level = vim.log.levels.WARN,
    trace_lsp = "off", -- "off" | "messages" | "verbose"
    trace_lsp_progress = false,
    log_lsp_messages = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 20
  workspace_folders = {},
  copilot_model = "",
  root_dir = function()
    return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
  end,
  should_attach = function(_, _)
    if not vim.bo.buflisted then
      debug_log("not attaching, buffer is not 'buflisted'")
      return false
    end

    if vim.bo.buftype ~= "" then
      logger.debug("not attaching, buffer 'buftype' is " .. vim.bo.buftype)
      return false
    end

    return true
  end,
  server = {
    type = "nodejs", -- "nodejs" | "binary"
    custom_server_filepath = nil,
  },
  server_opts_overrides = {},
})
