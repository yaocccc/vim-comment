# vim-comment

## usage

```comment
    command! NToggleComment call <SID>toggleLineComment(line("."), line("."))
    command! VToggleComment call <SID>toggleLineComment(line("'<"), line("'>"))
    command! CToggleComment call <SID>toggleCounkComment(line("'<"), line("'>"))

    NToggleComment: normal mode to toggleLineComment
    VToggleComment: visual or select mode to toggleLineComment
    CToggleComment: visual or select mode to toggleCounkComment
```

```comment
    command! NToggleComment call <SID>toggleLineComment(line("."), line("."))
    command! VToggleComment call <SID>toggleLineComment(line("'<"), line("'>"))
    command! CToggleComment call <SID>toggleCounkComment(line("'<"), line("'>"))

    NToggleComment: 普通模式下 切换 行注释状态
    VToggleComment: 选择模式(鼠标或键盘)模式下 切换行注释状态
    CToggleComment: 选择模式(鼠标或键盘)模式下 切换块注释状态
```

## options

```options
  you can set comment of suffix
  default:
    let vim_line_comments = {   'vim': '"', 'vimrc': '"',
                             \  'js': '//', 'ts': '//',
                             \  'java': '//', 'class': '//',
                             \  'c': '//', 'h': '//'}
                             \  'default: '#' }
    let g:vim_counk_comments = {'vim': ['"', '"', '"'],
                             \  'vimrc': ['"', '"', '"'],
                             \  'sh': [':<<!', '', '!'],
                             \  'md': ['```', '', '```']
                             \  'default': ['/* ', ' * ', ' */']}
  you can set some map to toggleComment
  example:
    nmap <silent> ?? :NToggleComment<CR>
    xmap <silent> /  :<c-u>VToggleComment<CR>
    smap <silent> /  <c-g>:<c-u>VToggleComment<CR>
    xmap <silent> ?  :<c-u>CToggleComment<CR>
    smap <silent> ?  <c-g>:<c-u>CToggleComment<CR>
```

```options
  你可以为不同的文件后缀设置注释
  默认:
    let vim_line_comments = {   'vim': '"', 'vimrc': '"',
                             \  'js': '//', 'ts': '//',
                             \  'java': '//', 'class': '//',
                             \  'c': '//', 'h': '//'}
                             \  'default: '#' }
    let g:vim_counk_comments = {'vim': ['"', '"', '"'],
                             \  'vimrc': ['"', '"', '"'],
                             \  'sh': [':<<!', '', '!'],
                             \  'md': ['```', '', '```']
                             \  'default': ['/* ', ' * ', ' */']}
  你可以自定义快捷键
  例如:
    nmap <silent> ?? :NToggleComment<CR>
    xmap <silent> /  :<c-u>VToggleComment<CR>
    smap <silent> /  <c-g>:<c-u>VToggleComment<CR>
    xmap <silent> ?  :<c-u>CToggleComment<CR>
    smap <silent> ?  <c-g>:<c-u>CToggleComment<CR>
```
