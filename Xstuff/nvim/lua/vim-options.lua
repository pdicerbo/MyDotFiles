vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("au VimLeave,VimSuspend * set guicursor=n-ci:hor30-iCursor-blinkwait300-blinkon200-blinkoff150")


vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.relativenumber = true
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.number = true -- Print line number
vim.opt.showmode = false -- Dont show mode since we have a statusline
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.spelllang = { "en" }
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.termguicolors = true

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Shift visual selected lines down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Shift visual selected lines up

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
