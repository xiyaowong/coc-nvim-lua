function! coc#source#coc_nvim_lua#init() abort
  return {
        \ 'priority': 99,
        \ 'shortcut': 'NvimLua',
        \ 'triggerCharacters': ['.'],
        \ 'filetypes': ['lua', 'lua.luapad']
        \}
endfunction

function! coc#source#coc_nvim_lua#complete(opt, cb) abort
  return a:cb(luaeval("require('coc_nvim_lua').complete(_A)", a:opt))
endfunction
