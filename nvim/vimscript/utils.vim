function! ToggleAutoFormat() abort
    " Search for 'a' in formatoptions
    let l:autoformat_active = match(&l:formatoptions, '\m\Ca') > 0
    if l:autoformat_active
        set formatoptions-=a
        echo 'Automatic formatting turned OFF'
    else
        set formatoptions+=a
        echo 'Automatic formatting turned ON'
    endif
endfunction

function! RemoveTrailingSpaces() abort
    execute '%s/\s\+$//g'
endfunction
