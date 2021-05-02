require("opt")

local apply_options = function(opts)
  for k, v in pairs(opts) do
    vim.opt[k] = v
  end
end

local options = {
  autoindent     = true, -- enable autoindent
  backup         = false, -- disable backup
  cursorline     = true, -- enable cursorline
  expandtab      = true, -- use spaces instead of tabs
  autowrite      = true, -- autowrite buffer when it's not focused
  hidden         = true, -- keep hidden buffers
  hlsearch       = true, -- don't highlight matching search
  ignorecase     = true, -- case insensitive on search
  lazyredraw     = true, -- lazyredraw to make macro faster
  list           = true, -- display listchars
  number         = true, -- enable number
  relativenumber = true, -- enable relativenumber
  showmode       = false, -- don't show mode
  smartcase      = true, -- improve searching using '/'
  smartindent    = true, -- smarter indentation
  smarttab       = true, -- make tab behaviour smarter
  splitbelow     = true, -- split below instead of above
  splitright     = true, -- split right instead of left
  startofline    = false, -- don't go to the start of the line when moving to another file
  swapfile       = false, -- disable swapfile
  termguicolors  = true, -- truecolours for better experience
  wrap           = false, -- dont wrap lines
  writebackup    = false, -- disable backup
  backupcopy     = "yes", -- fix weirdness for postcss
  completeopt    = { "menu", "menuone", "noselect", "noinsert" }, -- better completion
  encoding       = "UTF-8", -- set encoding
  fillchars      = { vert = "│", eob = " " }, -- make vertical split sign better
  --foldmethod     = "marker", -- foldmethod using marker
  -- foldexpr       = "nvim_treesitter#foldexpr()",
  -- foldlevel      = 0, -- don't fold anything if I don't tell it to do so
  -- foldnestmax    = 2, -- only allow 2 nested folds, it can be confusing if I have too many
  -- foldopen       = {"percent", "search"}, -- don't open fold if I don't tell it to do so
  -- foldcolumn     = "auto", -- enable fold column for better visualisation
  inccommand     = "split", -- incrementally show result of command
  listchars      = { eol = "↲", tab= "» " }, -- set listchars
  mouse          = "a", -- enable mouse support
  shortmess      = "csa", -- disable some stuff on shortmess
  signcolumn     = "yes", -- enable sign column all the time, 4 column
  colorcolumn    = 80, -- 80 chars color column
  laststatus     = 2, -- always enable statusline
  pumheight      = 10, -- limit completion items
  re             = 0, -- set regexp engine to auto
  scrolloff      = 2, -- make scrolling better
  sidescroll     = 2, -- make scrolling better
  shiftwidth     = 2, -- set indentation width
  sidescrolloff  = 15, -- make scrolling better
  -- synmaxcol      = 300, -- set limit for syntax highlighting in a single line, probably gonna remove this since treesitter handles this very well
  tabstop        = 2, -- tabsize
  timeoutlen     = 400, -- faster timeout wait time
  updatetime     = 100, -- set faster update time
}

apply_options(options)


vim.cmd('let R_assign = 0')
-- autocommands
vim.cmd('autocmd FileType mail setlocal spell spelllang=en_au')
vim.cmd('autocmd FileType markdown setlocal spell spelllang=en_au')
-- disbale commenting on new lines
vim.cmd('autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o')

--
