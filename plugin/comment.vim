if exists('s:loaded') | finish | endif
let s:loaded = 1

let s:line_comments  = get(g:, 'vim_line_comments',  { 'vim': '"', 'vimrc': '"', 'js': '//', 'ts': '//', 'java': '//', 'class': '//', 'c': '//', 'h': '//' })
let s:chunk_comments = get(g:, 'vim_chunk_comments', { 'vim': ['"', '"', '"'], 'vimrc': ['"', '"', '"'], 'sh': [':<<!', '', '!'], 'md': ['```', '', '```'] })
let s:vim_comment_gap = get(g:, 'vim_comment_gap', 1)

command! NToggleComment call <SID>toggleLineComment(line("."), line("."))
command! VToggleComment call <SID>toggleLineComment(line("'<"), line("'>"))
command! CToggleComment call <SID>toggleChunkComment(line("'<"), line("'>"))

func! s:toggleLineComment(num1, num2)
    let com = get(s:line_comments, expand('%:t'), 0) || get(s:line_comments, expand('%:e'), '#')
    let [commented, col] = s:checkLineComment(a:num1, a:num2, com)
    let com = com . printf('%'.s:vim_comment_gap.'s', '')
    if commented
        for num in range(a:num1, a:num2)
            let line = getline(num)
            if  line =~ '^\s*$' | continue | endif
            call setline(num, printf('%'.col.'s', '') . line[col+len(com):])
        endfor
    else
        for num in range(a:num1, a:num2)
            let line = getline(num)
            if  line =~ '^\s*$' | continue | endif
            call setline(num, printf('%'.col.'s', '') . com . line[col:])
        endfor
    endif
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

func! s:toggleChunkComment(num1, num2)
    let coms = get(s:chunk_comments, expand('%:t'), 0) || get(s:chunk_comments, expand('%:e'), ['/* ', ' * ', ' */'])
    let [commented, col] = s:checkChunkComment(a:num1, a:num2, coms)
    if commented
        for num in range(a:num1 + 1, a:num2 - 1)
            let line = getline(num)
            call setline(num, substitute(line, '\M' . coms[1] . printf('%'.s:vim_comment_gap.'s', ''), '', ''))
        endfor
        call deletebufline('%', a:num2)
        call deletebufline('%', a:num1)
    else
        for num in range(a:num1, a:num2)
            let line = getline(num)
            call setline(num, printf('%'.col.'s', '') . coms[1] . printf('%'.s:vim_comment_gap.'s', '') . line[col:])
        endfor
        call appendbufline('%', a:num1 - 1, printf('%'.col.'s', '') . coms[0])
        call appendbufline('%', a:num2 + 1, printf('%'.col.'s', '') . coms[2])
    endif
endf

func! s:checkChunkComment(num1, num2, coms)
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
