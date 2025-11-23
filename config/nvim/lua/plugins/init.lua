return {
  -- Colorschemes
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end,
  },
  { "folke/tokyonight.nvim", priority = 1000 },
  { "sainnhe/sonokai", priority = 1000 },

  -- Flash (quick navigation)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, false }, -- Disable default
      {
        "<leader>fs",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash Jump",
      },
      {
        "<leader>ft",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },

  -- Smear cursor
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = true,
      smear_insert_mode = false,
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      stiffness_insert_mode = 0.6,
      trailing_stiffness_insert_mode = 0.6,
      distance_stop_animating = 0.5,
    },
  },

  -- Tmux Navigator
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- Vim Wordmotion
  {
    "chaoren/vim-wordmotion",
    event = "VeryLazy",
  },

  -- Noice - Beautiful UI for messages, cmdline and popups
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup", -- Floating command line
        format = {
          cmdline = { icon = " " },
          search_down = { icon = " 󰄼" },
          search_up = { icon = " 󰄾" },
          filter = { icon = " $" },
          lua = { icon = " " },
          help = { icon = " 󰋖" },
        },
      },
      messages = {
        enabled = true,
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },
      popupmenu = {
        enabled = true,
        backend = "nui", -- Use nui for completion menu
      },
      notify = {
        enabled = true,
        view = "notify",
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          enabled = true,
        },
        hover = {
          enabled = true,
        },
        signature = {
          enabled = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    },
  },

  -- Nvim Notify for notifications
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#1e1e2e",
      fps = 60,
      level = 2,
      minimum_width = 50,
      render = "compact",
      stages = "fade_in_slide_out",
      timeout = 3000,
      top_down = false,
    },
  },
}
