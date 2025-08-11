return {
  {
    "stevearc/conform.nvim",

    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>f",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },

    opts = {
      nix = { "nixfmt" },
      lua = { "stylua" },
      json = { "prettierd", "prettier" },
    },

    default_format_opts = {
      lsp_format = "fallback",
    },

    format_on_save = { timeout_ms = 500 },

    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
}
