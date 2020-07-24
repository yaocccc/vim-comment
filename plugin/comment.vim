" 快速注释
    command! NSetComment call <SID>setComment(line("."), line("."))
    command! VSetComment call <SID>setComment(line("'<"), line("'>"))

    func! s:setComment(num1, num2)
        let com = s:getComment()
        let [commented, col] = s:checkComment(a:num1, a:num2, com)
        let com = com . '  '
        for num in range(a:num1, a:num2)
            let line = getline(num)
            if line =~ '^\s*$'
                continue
            endif
            let left = col > 0 ? line[:col-1] : ''
            let right = commented ? line[col+len(com):] : line[col:]
            let center = commented ? '' : com
            call setline(num, left . center . right)
        endfor
    endf

    func! s:getComment()
        let defaultComments = {'vim': '"', 'vimrc': '"',
                            \  'zsh': '#', 'zshrc': '#', 
                            \  'bash': '#', 'bashrc': '#',
                            \  'js': '//', 'ts': '//'}
        let comments = get(g:, 'vim_comments', defaultComments)
        return get(comments, expand('%:e'), '//')
    endf

    func! s:checkComment(num1, num2, com)
        let commented = 1
        let col = 999
        for num in range(a:num1, a:num2)
            let line = getline(num)
            if line =~ '^\s*$'
                continue
            endif
            let line2 = substitute(line, '^\s*', '', 'g')
            let col = min([col, len(line) - len(line2)])
            let commented = commented && line2[:len(a:com) - 1] ==# a:com
        endfor
        return [commented, col]
    endf
