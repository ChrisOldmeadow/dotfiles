vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '

--no hl search toggle
vim.api.nvim_set_keymap('n', '<leader>h', ':set hlsearch!<CR>', { noremap = true, silent = true })

-- File explorer
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Startify
vim.api.nvim_set_keymap('n', '<leader>s', ':Startify<CR>', { noremap = true, silent = true })



-- Window movements
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { silent = true })

-- Buffer switching
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprev<CR>', { silent = true })

-- Better nav for omnicomplete
vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')

-- telescope
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fo', ':Telescope oldfiles<CR>', { noremap = true, silent = true })


-- lsp 
--local opts = { noremap=true, silent=true }
--vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

-- vimwiki
vim.api.nvim_set_keymap('n', '<leader>ws', ':VimwikiUISelect<CR>', { noremap = true, silent = true })



-- Startify
vim.api.nvim_set_keymap('n', '<leader>s', ':Startify<CR>', { noremap = true, silent = true })

-- compe
--vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-Space>", 'compe#confirm()', {noremap = true, silent = true, expr = true})
--vim.api.nvim_set_keymap("i", "<C-TAB>", 'compe#complete()', {noremap = true, silent = true, expr = true})
