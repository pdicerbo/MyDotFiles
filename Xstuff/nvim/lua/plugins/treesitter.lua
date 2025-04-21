return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "cpp", "bash", "cmake", "cuda", "dockerfile", "git_config", "gitignore", "ini", "json", "jsonc", "llvm", "markdown_inline", "proto", "python", "regex", "rust", "ssh_config", "strace", "tmux", "xresources", "yaml" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
        end
    }
