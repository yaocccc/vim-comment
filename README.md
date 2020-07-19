# vim-comment

## usage

```comment
    command! NToggleComment call <SID>toggleComment(line("."), line("."))
    command! VToggleComment call <SID>toggleComment(line("'<"), line("'>"))

    NToggleComment: normal mode to toggleComment
    VToggleComment: visual or select mode to toggleComment
```

```comment
    command! NToggleComment call <SID>toggleComment(line("."), line("."))
    command! VToggleComment call <SID>toggleComment(line("'<"), line("'>"))

    NToggleComment: 普通模式下 切换 注释状态
    VToggleComment: 选择模式(鼠标或键盘)模式下 切换注释状态
```

## options

```options
  you can set comment of suffix
  default:
    let g:vim_comments = {'vim': '"', 'vimrc': '"',
                       \  'zsh': '#', 'zsrc': '#',
                       \  'bash': '#', 'bashrc': '#',
                       \  'js': '//', 'ts': '//'}
  you can set some map to toggleComment
  example:
    nmap <silent> ?? :NToggleComment<CR>
    xmap <silent> /  :<c-u>VToggleComment<CR>
    smap <silent> /  <c-g>:<c-u>VToggleComment<CR>
```

```options
  你可以为不同的文件后缀设置注释
  默认:
    let g:vim_comments = {'vim': '"', 'vimrc': '"',
                       \  'zsh': '#', 'zsrc': '#',
                       \  'bash': '#', 'bashrc': '#',
                       \  'js': '//', 'ts': '//'}
  你可以自定义快捷键
  例如:
    nmap <silent> ?? :NToggleComment<CR>
    xmap <silent> /  :<c-u>VToggleComment<CR>
    smap <silent> /  <c-g>:<c-u>VToggleComment<CR>
```
