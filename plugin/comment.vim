if exists('s:loaded') | finish | endif
let s:loaded = 1

command! NToggleComment call <SID>toggleLineComment(line("."), line("."))
command! VToggleComment call <SID>toggleLineComment(line("'<"), line("'>"))
command! CToggleComment call <SID>toggleCounkComment(line("'<"), line("'>"))

func! s:toggleLineComment(num1, num2)
    let com = s:getLineComment()
    let [commented, col] = s:checkLineComment(a:num1, a:num2, com)
    let com = com . '  '
    if commented
        for num in range(a:num1, a:num2)
            let line = getline(num)
            if  line =~ '^\s*$' | continue | endif
            call setline(num, s:getEmptyStr(col) . line[col+len(com):])
        endfor
    else
        for num in range(a:num1, a:num2)
            let line = getline(num)
            if  line =~ '^\s*$' | continue | endif
            call setline(num, s:getEmptyStr(col) . com . line[col:])
        endfor
    endif
endf

func! s:getLineComment()
    let defaultComments = {'vim': '"', 'vimrc': '"',
                        \  'js': '//', 'ts': '//',
                        \  'java': '//', 'class': '//',
                        \  'c': '//', 'h': '//'}
    let comments = get(g:, 'vim_line_comments', defaultComments)
    return get(comments, expand('%:e'), '#')
endf

func! s:checkLineComment(num1, num2, com)
    let commented = 1
    let col = 999
    for num in range(a:num1, a:num2)
        let line = getline(num)
        if  line =~ '^\s*$' | continue | endif
        let line2 = substitute(line, '^\s*', '', '')
        let col = min([col, len(line) - len(line2)])
        let commented = commented && line2[:len(a:com) - 1] ==# a:com
    endfor
    return [commented, col]
endf

func! s:toggleCounkComment(num1, num2)
    let coms = s:getCounkComment()
    let [commented, col] = s:checkCounkComment(a:num1, a:num2, coms)
    if commented
        for num in range(a:num1 + 1, a:num2 - 1)
            let line = getline(num)
            call setline(num, substitute(line, coms[1] . '  ', '', ''))
        endfor
        call deletebufline('%', a:num2)
        call deletebufline('%', a:num1)
    else
        for num in range(a:num1, a:num2)
            let line = getline(num)
            call setline(num, s:getEmptyStr(col) . coms[1] . '  ' . line[col:])
        endfor
        call appendbufline('%', a:num1 - 1, s:getEmptyStr(col) . coms[0])
        call appendbufline('%', a:num2 + 1, s:getEmptyStr(col) . coms[2])
    endif
endf

func! s:getCounkComment()
    let defaultComments = {'vim': ['"', '"', '"'],
                         \ 'vimrc': ['"', '"', '"'],
                         \ 'sh': [':<<!', '', '!'],
                         \ 'md': ['```', '', '```']
                         \}
    let comments = get(g:, 'vim_counk_comments', defaultComments)
    return get(comments, expand('%:e'), ['/* ', ' * ', ' */'])
endf

func! s:checkCounkComment(num1, num2, coms)
    let commented = 1
    let col = 999
    for num in range(a:num1, a:num2)
        let com = num == a:num1 ? trim(a:coms[0]) :
                \ num == a:num2 ? trim(a:coms[2]) :
                \ trim(a:coms[1])
        let line = getline(num)
        let line2 = substitute(line, '^\s*', '', '')
        let col = trim(line) ==# '' ? col : min([col, len(line) - len(line2)])
        if  com ==# '' | continue | endif
        let commented = commented && line2[:len(com) - 1] ==# com
        if num == a:num1 || num == a:num2
            let commented = commented && trim(line) ==# com
        endif
    endfor
    return [commented, col]
endf

func! s:getEmptyStr(len)
    let str = ''
    for i in range(1, a:len)
        let str = str . ' '
    endfor
    return str
endf
