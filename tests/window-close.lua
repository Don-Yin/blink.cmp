-- Run with blink.cmp and blink.lib on runtimepath:
-- nvim --headless -u NONE --cmd 'set rtp+=.,../blink-lib' -l tests/window-close.lua
local win = require('blink.cmp.lib.window').new('documentation', {
  filetype = 'blink-cmp-documentation',
  min_width = 20,
  max_height = 2,
  border = 'none',
  scrollbar = true,
})
vim.api.nvim_buf_set_lines(win:get_buf(), 0, -1, false, { 'one', 'two', 'three', 'four' })
win:open()
assert(win:is_open(), 'documentation window should open')
assert(win.scrollbar:is_visible(), 'scrollbar should be visible')

-- A user or another plugin can close the float without going through win:close().
vim.api.nvim_win_close(win.id, true)
win:close()
assert(win.id == nil, 'closed window handle should be cleared')
assert(not win.scrollbar:is_visible(), 'scrollbar should be closed too')

win:open()
assert(win:is_open(), 'documentation window should reopen')
win:close()
win:close()
assert(win.id == nil and not win.scrollbar:is_visible(), 'closing twice should leave no windows')
print('PASS: closing an already-closed documentation window cleans up and can reopen')
