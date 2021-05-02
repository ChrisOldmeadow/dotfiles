local g = vim.g
local exec = vim.api.nvim_exec

g.nvim_tree_side = "left"
g.nvim_tree_width = 35
g.nvim_tree_ignore = { ".git", "node_modules" }

-- 0 by default, opens the tree when typing `vim $DIR` or `vim`
-- g.nvim_tree_auto_open = 1

-- 0 by default, closes the tree when it's the last window
g.nvim_tree_auto_close = 1

-- 0 by default, this option allows the cursor to be updated when entering a buffer
g.nvim_tree_follow = 1

-- 0 by default, will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_git_hl = 1

--TODO:
exec([[highlight NvimTreeFolderName ctermfg=none guifg=none]],"")
-- "Setting nvim tree folders to not have any guibg
-- "hi Cursorline guibg=#424040 guifg=none

g.nvim_tree_icons = {
    default = '',
    -- symlink = '',
    git = {
        unstaged = "M",
        staged = "A",
        unmerged = "═",
        renamed = "R",
        untracked = "U"
    },
    folder = {
        default = "",
        open = ""
    }
}



exec(
    [[
        augroup NvimTreeOverride
          au!
          au FileType NvimTree setlocal nowrap
        augroup END
    ]],
    ""
)
