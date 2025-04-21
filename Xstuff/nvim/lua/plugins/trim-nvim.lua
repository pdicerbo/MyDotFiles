return {
    "cappyzawa/trim.nvim",
    config = function()
        require("trim").setup({
            ft_blocklist = {"markdown", "snacks-dashboard"},
            trim_on_write = true,
            trim_trailing = true,
            trim_last_line = true,
            trim_first_line = true,
            highlight = true,
            highlight_bg = '#ff0000', -- or 'red'
            highlight_ctermbg = 'red',
            notifications = true,
        })
        vim.keymap.set("n", "<C-k><C-x>", ":Trim<CR>", { desc = "Trim whitespace" })
    end,
}
