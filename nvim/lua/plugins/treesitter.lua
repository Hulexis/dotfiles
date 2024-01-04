return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "fish",
        "html",
        "javascript",
        "json",
        "hjson",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "dart",
        "rust",
        "css",
        "graphql",
        "go",
      },
      indent = {
        enable = true,
        disable = { "python", "dart" },
      },
    },
  },
}
