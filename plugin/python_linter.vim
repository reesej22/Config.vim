
function! LintCurrentPythonFile() abort
  if &filetype !=# 'python'
    echohl WarningMsg | echom "Not a Python file." | echohl None
    return
  endif

  " Get absolute path to the current file
  let l:filename = expand('%:p')

  " Run pylint and capture output
  let l:output = systemlist('pylint --output-format=text ' . shellescape(l:filename))

  " Clear existing quickfix list
  call setqflist([], 'r')

  " Pattern to match: file.py:line:col: CODE: message
  let l:pattern = '\v^(.*):(\d+):(\d+):\s([A-Z0-9]+):\s(.*)$'
  let l:qf = []

  for l:line in l:output
    if l:line =~# l:pattern
      let l:m = matchlist(l:line, l:pattern)
      call add(l:qf, {
            \ 'filename': l:m[1],
            \ 'lnum': str2nr(l:m[2]),
            \ 'col': str2nr(l:m[3]),
            \ 'text': printf('[%s] %s', l:m[4], l:m[5]),
            \ 'type': l:m[4][0],
            \ })
    endif
  endfor

  if len(l:qf)
    call setqflist(l:qf, 'r')
    copen
  else
    echo "No issues found by linter."
  endif
endfunction

command! LintPython call LintCurrentPythonFile()

