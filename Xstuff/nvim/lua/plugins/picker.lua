return {
    {
        "folke/snacks.nvim",
        opts = {
            explorer = {},
            picker = {
                hidden = true,
                ignored = true,
                sources = {
                    files = {
                        hidden = true,
                        ignored = true,
                    },
                    explorer = {
                        git_status_open = true,

                    },
                    git_files = {
                        untracked = true,
                        submodules = true,
                    },
                },
            },
        },
    }
}
