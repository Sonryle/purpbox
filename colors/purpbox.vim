" -----------------------------------------------------------------------------
" File: purpbox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/morhetz/purpbox
" Last Modified: 12 Aug 2017
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='purpbox'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:purpbox_bold')
  let g:purpbox_bold=1
endif
if !exists('g:purpbox_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:purpbox_italic=1
  else
    let g:purpbox_italic=0
  endif
endif
if !exists('g:purpbox_undercurl')
  let g:purpbox_undercurl=1
endif
if !exists('g:purpbox_underline')
  let g:purpbox_underline=1
endif
if !exists('g:purpbox_inverse')
  let g:purpbox_inverse=1
endif

if !exists('g:purpbox_guisp_fallback') || index(['fg', 'bg'], g:purpbox_guisp_fallback) == -1
  let g:purpbox_guisp_fallback='NONE'
endif

if !exists('g:purpbox_improved_strings')
  let g:purpbox_improved_strings=0
endif

if !exists('g:purpbox_improved_warnings')
  let g:purpbox_improved_warnings=0
endif

if !exists('g:purpbox_termcolors')
  let g:purpbox_termcolors=256
endif

if !exists('g:purpbox_invert_indent_guides')
  let g:purpbox_invert_indent_guides=0
endif

if exists('g:purpbox_contrast')
  echo 'g:purpbox_contrast is deprecated; use g:purpbox_contrast_light and g:purpbox_contrast_dark instead'
endif

if !exists('g:purpbox_contrast_dark')
  let g:purpbox_contrast_dark='medium'
endif

if !exists('g:purpbox_contrast_light')
  let g:purpbox_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:gb = {}

" fill it with absolute colors
let s:gb.dark0_hard  = ['#1a1423', 234]     " 29-32-33
let s:gb.dark0       = ['#2b213a', 235]     " 40-40-40
let s:gb.dark0_soft  = ['#281f36', 236]     " 50-48-47
let s:gb.dark1       = ['#2f2440', 237]     " 60-56-54
let s:gb.dark2       = ['#3e3054', 239]     " 80-73-69
let s:gb.dark3       = ['#665c54', 241]     " 102-92-84
let s:gb.dark4       = ['#7c6f64', 243]     " 124-111-100
let s:gb.dark4_256   = ['#7c6f64', 243]     " 124-111-100

let s:gb.gray_245    = ['#8a72af', 245]     " 146-131-116
let s:gb.gray_244    = ['#8a72af', 244]     " 146-131-116

let s:gb.light0_hard = ['#cec4dd', 230]     " 249-245-215
let s:gb.light0      = ['#cbc0db', 229]     " 253-244-193
let s:gb.light0_soft = ['#c1b4d4', 228]     " 242-229-188
let s:gb.light1      = ['#b8aace', 223]     " 235-219-178
let s:gb.light2      = ['#a491c0', 250]     " 213-196-161
let s:gb.light3      = ['#9079b3', 248]     " 189-174-147
let s:gb.light4      = ['#7e63a6', 246]     " 168-153-132
let s:gb.light4_256  = ['#7e63a6', 246]     " 168-153-132

let s:gb.bright_red     = ['#fb4934', 167]     " 251-73-52
let s:gb.bright_green   = ['#b8bb26', 142]     " 184-187-38
let s:gb.bright_yellow  = ['#fabd2f', 214]     " 250-189-47
let s:gb.bright_blue    = ['#83a598', 109]     " 131-165-152
let s:gb.bright_purple  = ['#d3869b', 175]     " 211-134-155
let s:gb.bright_aqua    = ['#8ec07c', 108]     " 142-192-124
let s:gb.bright_orange  = ['#fe8019', 208]     " 254-128-25

let s:gb.neutral_red    = ['#cc241d', 124]     " 204-36-29
let s:gb.neutral_green  = ['#98971a', 106]     " 152-151-26
let s:gb.neutral_yellow = ['#d79921', 172]     " 215-153-33
let s:gb.neutral_blue   = ['#458588', 66]      " 69-133-136
let s:gb.neutral_purple = ['#b16286', 132]     " 177-98-134
let s:gb.neutral_aqua   = ['#689d6a', 72]      " 104-157-106
let s:gb.neutral_orange = ['#d65d0e', 166]     " 214-93-14

let s:gb.faded_red      = ['#9d0006', 88]      " 157-0-6
let s:gb.faded_green    = ['#79740e', 100]     " 121-116-14
let s:gb.faded_yellow   = ['#b57614', 136]     " 181-118-20
let s:gb.faded_blue     = ['#076678', 24]      " 7-102-120
let s:gb.faded_purple   = ['#8f3f71', 96]      " 143-63-113
let s:gb.faded_aqua     = ['#427b58', 66]      " 66-123-88
let s:gb.faded_orange   = ['#af3a03', 130]     " 175-58-3

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:purpbox_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:purpbox_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:purpbox_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:purpbox_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:purpbox_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:purpbox_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:purpbox_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:purpbox_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:purpbox_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:purpbox_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.fg4_256 = s:fg4_256

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.blue   = s:blue
let s:gb.purple = s:purple
let s:gb.aqua   = s:aqua
let s:gb.orange = s:orange

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:bg0[0]
  let g:terminal_color_8 = s:gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:blue[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:purple[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:aqua[0]

  let g:terminal_color_7 = s:fg4[0]
  let g:terminal_color_15 = s:fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:purpbox_hls_cursor')
  let s:hls_cursor = get(s:gb, g:purpbox_hls_cursor)
endif

let s:number_column = s:none
if exists('g:purpbox_number_column')
  let s:number_column = get(s:gb, g:purpbox_number_column)
endif

let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:purpbox_sign_column')
    let s:sign_column = get(s:gb, g:purpbox_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:purpbox_color_column')
  let s:color_column = get(s:gb, g:purpbox_color_column)
endif

let s:vert_split = s:bg0
if exists('g:purpbox_vert_split')
  let s:vert_split = get(s:gb, g:purpbox_vert_split)
endif

let s:invert_signs = ''
if exists('g:purpbox_invert_signs')
  if g:purpbox_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:purpbox_invert_selection')
  if g:purpbox_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:purpbox_invert_tabline')
  if g:purpbox_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:purpbox_italicize_comments')
  if g:purpbox_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:purpbox_italicize_strings')
  if g:purpbox_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:purpbox_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:purpbox_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Purpbox Hi Groups: {{{

" memoize common hi groups
call s:HL('PurpboxFg0', s:fg0)
call s:HL('PurpboxFg1', s:fg1)
call s:HL('PurpboxFg2', s:fg2)
call s:HL('PurpboxFg3', s:fg3)
call s:HL('PurpboxFg4', s:fg4)
call s:HL('PurpboxGray', s:gray)
call s:HL('PurpboxBg0', s:bg0)
call s:HL('PurpboxBg1', s:bg1)
call s:HL('PurpboxBg2', s:bg2)
call s:HL('PurpboxBg3', s:bg3)
call s:HL('PurpboxBg4', s:bg4)

call s:HL('PurpboxRed', s:red)
call s:HL('PurpboxRedBold', s:red, s:none, s:bold)
call s:HL('PurpboxGreen', s:green)
call s:HL('PurpboxGreenBold', s:green, s:none, s:bold)
call s:HL('PurpboxYellow', s:yellow)
call s:HL('PurpboxYellowBold', s:yellow, s:none, s:bold)
call s:HL('PurpboxBlue', s:blue)
call s:HL('PurpboxBlueBold', s:blue, s:none, s:bold)
call s:HL('PurpboxPurple', s:purple)
call s:HL('PurpboxPurpleBold', s:purple, s:none, s:bold)
call s:HL('PurpboxAqua', s:aqua)
call s:HL('PurpboxAquaBold', s:aqua, s:none, s:bold)
call s:HL('PurpboxOrange', s:orange)
call s:HL('PurpboxOrangeBold', s:orange, s:none, s:bold)

call s:HL('PurpboxRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('PurpboxGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('PurpboxYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('PurpboxBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('PurpboxPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('PurpboxAquaSign', s:aqua, s:sign_column, s:invert_signs)
call s:HL('PurpboxOrangeSign', s:orange, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg1, s:bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/purpbox/issues/7
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:yellow, s:bg1)
endif

hi! link NonText PurpboxBg2
hi! link SpecialKey PurpboxBg2

call s:HL('Visual',    s:none,  s:bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search',    s:yellow, s:bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

call s:HL('Underlined', s:blue, s:none, s:underline)

call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory PurpboxGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title PurpboxGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg PurpboxYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg PurpboxYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question PurpboxOrangeBold
" Warning messages
hi! link WarningMsg PurpboxRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:purpbox_improved_strings == 0
  hi! link Special PurpboxOrange
else
  call s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement PurpboxRed
" if, then, else, endif, swicth, etc.
hi! link Conditional PurpboxRed
" for, do, while, etc.
hi! link Repeat PurpboxRed
" case, default, etc.
hi! link Label PurpboxRed
" try, catch, throw
hi! link Exception PurpboxRed
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
hi! link Keyword PurpboxRed

" Variable name
hi! link Identifier PurpboxBlue
" Function name
hi! link Function PurpboxGreenBold

" Generic preprocessor
hi! link PreProc PurpboxAqua
" Preprocessor #include
hi! link Include PurpboxAqua
" Preprocessor #define
hi! link Define PurpboxAqua
" Same as Define
hi! link Macro PurpboxAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit PurpboxAqua

" Generic constant
hi! link Constant PurpboxPurple
" Character constant: 'c', '/n'
hi! link Character PurpboxPurple
" String constant: "this is a string"
if g:purpbox_improved_strings == 0
  call s:HL('String',  s:green, s:none, s:italicize_strings)
else
  call s:HL('String',  s:fg1, s:bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean PurpboxPurple
" Number constant: 234, 0xff
hi! link Number PurpboxPurple
" Floating point constant: 2.3e10
hi! link Float PurpboxPurple

" Generic type
hi! link Type PurpboxYellow
" static, register, volatile, etc
hi! link StorageClass PurpboxOrange
" struct, union, enum, etc.
hi! link Structure PurpboxAqua
" typedef
hi! link Typedef PurpboxYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:purpbox_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:purpbox_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd PurpboxGreenSign
hi! link GitGutterChange PurpboxAquaSign
hi! link GitGutterDelete PurpboxRedSign
hi! link GitGutterChangeDelete PurpboxAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile PurpboxGreen
hi! link gitcommitDiscardedFile PurpboxRed

" }}}
" Signify: {{{

hi! link SignifySignAdd PurpboxGreenSign
hi! link SignifySignChange PurpboxAquaSign
hi! link SignifySignDelete PurpboxRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign PurpboxRedSign
hi! link SyntasticWarningSign PurpboxYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   PurpboxBlueSign
hi! link SignatureMarkerText PurpboxPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl PurpboxBlueSign
hi! link ShowMarksHLu PurpboxBlueSign
hi! link ShowMarksHLo PurpboxBlueSign
hi! link ShowMarksHLm PurpboxBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch PurpboxYellow
hi! link CtrlPNoEntries PurpboxRed
hi! link CtrlPPrtBase PurpboxBg2
hi! link CtrlPPrtCursor PurpboxBlue
hi! link CtrlPLinePre PurpboxBg2

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket PurpboxFg3
hi! link StartifyFile PurpboxFg1
hi! link StartifyNumber PurpboxBlue
hi! link StartifyPath PurpboxGray
hi! link StartifySlash PurpboxGray
hi! link StartifySection PurpboxYellow
hi! link StartifySpecial PurpboxBg2
hi! link StartifyHeader PurpboxOrange
hi! link StartifyFooter PurpboxBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
call s:HL('BufTabLineActive', s:fg4, s:bg2)
call s:HL('BufTabLineHidden', s:bg4, s:bg1)
call s:HL('BufTabLineFill', s:bg0, s:bg0)

" }}}
" Asynchronous Lint Engine: {{{

call s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
call s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
call s:HL('ALEInfo', s:none, s:none, s:undercurl, s:blue)

hi! link ALEErrorSign PurpboxRedSign
hi! link ALEWarningSign PurpboxYellowSign
hi! link ALEInfoSign PurpboxBlueSign

" }}}
" Dirvish: {{{

hi! link DirvishPathTail PurpboxAqua
hi! link DirvishArg PurpboxYellow

" }}}
" Netrw: {{{

hi! link netrwDir PurpboxAqua
hi! link netrwClassify PurpboxAqua
hi! link netrwLink PurpboxGray
hi! link netrwSymLink PurpboxFg1
hi! link netrwExe PurpboxYellow
hi! link netrwComment PurpboxGray
hi! link netrwList PurpboxBlue
hi! link netrwHelpCmd PurpboxAqua
hi! link netrwCmdSep PurpboxFg3
hi! link netrwVersion PurpboxGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir PurpboxAqua
hi! link NERDTreeDirSlash PurpboxAqua

hi! link NERDTreeOpenable PurpboxOrange
hi! link NERDTreeClosable PurpboxOrange

hi! link NERDTreeFile PurpboxFg1
hi! link NERDTreeExecFile PurpboxYellow

hi! link NERDTreeUp PurpboxGray
hi! link NERDTreeCWD PurpboxGreen
hi! link NERDTreeHelp PurpboxFg1

hi! link NERDTreeToggleOn PurpboxGreen
hi! link NERDTreeToggleOff PurpboxRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}
" coc.nvim: {{{

hi! link CocErrorSign PurpboxRedSign
hi! link CocWarningSign PurpboxOrangeSign
hi! link CocInfoSign PurpboxYellowSign
hi! link CocHintSign PurpboxBlueSign
hi! link CocErrorFloat PurpboxRed
hi! link CocWarningFloat PurpboxOrange
hi! link CocInfoFloat PurpboxYellow
hi! link CocHintFloat PurpboxBlue
hi! link CocDiagnosticsError PurpboxRed
hi! link CocDiagnosticsWarning PurpboxOrange
hi! link CocDiagnosticsInfo PurpboxYellow
hi! link CocDiagnosticsHint PurpboxBlue

hi! link CocSelectedText PurpboxRed
hi! link CocCodeLens PurpboxGray

call s:HL('CocErrorHighlight', s:none, s:none, s:undercurl, s:red)
call s:HL('CocWarningHighlight', s:none, s:none, s:undercurl, s:orange)
call s:HL('CocInfoHighlight', s:none, s:none, s:undercurl, s:yellow)
call s:HL('CocHintHighlight', s:none, s:none, s:undercurl, s:blue)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded PurpboxGreen
hi! link diffRemoved PurpboxRed
hi! link diffChanged PurpboxAqua

hi! link diffFile PurpboxOrange
hi! link diffNewFile PurpboxYellow

hi! link diffLine PurpboxBlue

" }}}
" Html: {{{

hi! link htmlTag PurpboxBlue
hi! link htmlEndTag PurpboxBlue

hi! link htmlTagName PurpboxAquaBold
hi! link htmlArg PurpboxAqua

hi! link htmlScriptTag PurpboxPurple
hi! link htmlTagN PurpboxFg1
hi! link htmlSpecialTagName PurpboxAquaBold

call s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar PurpboxOrange

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag PurpboxBlue
hi! link xmlEndTag PurpboxBlue
hi! link xmlTagName PurpboxBlue
hi! link xmlEqual PurpboxBlue
hi! link docbkKeyword PurpboxAquaBold

hi! link xmlDocTypeDecl PurpboxGray
hi! link xmlDocTypeKeyword PurpboxPurple
hi! link xmlCdataStart PurpboxGray
hi! link xmlCdataCdata PurpboxPurple
hi! link dtdFunction PurpboxGray
hi! link dtdTagName PurpboxPurple

hi! link xmlAttrib PurpboxAqua
hi! link xmlProcessingDelim PurpboxGray
hi! link dtdParamEntityPunct PurpboxGray
hi! link dtdParamEntityDPunct PurpboxGray
hi! link xmlAttribPunct PurpboxGray

hi! link xmlEntity PurpboxOrange
hi! link xmlEntityPunct PurpboxOrange
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation PurpboxOrange
hi! link vimBracket PurpboxOrange
hi! link vimMapModKey PurpboxOrange
hi! link vimFuncSID PurpboxFg3
hi! link vimSetSep PurpboxFg3
hi! link vimSep PurpboxFg3
hi! link vimContinue PurpboxFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword PurpboxBlue
hi! link clojureCond PurpboxOrange
hi! link clojureSpecial PurpboxOrange
hi! link clojureDefine PurpboxOrange

hi! link clojureFunc PurpboxYellow
hi! link clojureRepeat PurpboxYellow
hi! link clojureCharacter PurpboxAqua
hi! link clojureStringEscape PurpboxAqua
hi! link clojureException PurpboxRed

hi! link clojureRegexp PurpboxAqua
hi! link clojureRegexpEscape PurpboxAqua
call s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen PurpboxFg3
hi! link clojureAnonArg PurpboxYellow
hi! link clojureVariable PurpboxBlue
hi! link clojureMacro PurpboxOrange

hi! link clojureMeta PurpboxYellow
hi! link clojureDeref PurpboxYellow
hi! link clojureQuote PurpboxYellow
hi! link clojureUnquote PurpboxYellow

" }}}
" C: {{{

hi! link cOperator PurpboxPurple
hi! link cStructure PurpboxOrange

" }}}
" Python: {{{

hi! link pythonBuiltin PurpboxOrange
hi! link pythonBuiltinObj PurpboxOrange
hi! link pythonBuiltinFunc PurpboxOrange
hi! link pythonFunction PurpboxAqua
hi! link pythonDecorator PurpboxRed
hi! link pythonInclude PurpboxBlue
hi! link pythonImport PurpboxBlue
hi! link pythonRun PurpboxBlue
hi! link pythonCoding PurpboxBlue
hi! link pythonOperator PurpboxRed
hi! link pythonException PurpboxRed
hi! link pythonExceptions PurpboxPurple
hi! link pythonBoolean PurpboxPurple
hi! link pythonDot PurpboxFg3
hi! link pythonConditional PurpboxRed
hi! link pythonRepeat PurpboxRed
hi! link pythonDottedName PurpboxGreenBold

" }}}
" CSS: {{{

hi! link cssBraces PurpboxBlue
hi! link cssFunctionName PurpboxYellow
hi! link cssIdentifier PurpboxOrange
hi! link cssClassName PurpboxGreen
hi! link cssColor PurpboxBlue
hi! link cssSelectorOp PurpboxBlue
hi! link cssSelectorOp2 PurpboxBlue
hi! link cssImportant PurpboxGreen
hi! link cssVendor PurpboxFg1

hi! link cssTextProp PurpboxAqua
hi! link cssAnimationProp PurpboxAqua
hi! link cssUIProp PurpboxYellow
hi! link cssTransformProp PurpboxAqua
hi! link cssTransitionProp PurpboxAqua
hi! link cssPrintProp PurpboxAqua
hi! link cssPositioningProp PurpboxYellow
hi! link cssBoxProp PurpboxAqua
hi! link cssFontDescriptorProp PurpboxAqua
hi! link cssFlexibleBoxProp PurpboxAqua
hi! link cssBorderOutlineProp PurpboxAqua
hi! link cssBackgroundProp PurpboxAqua
hi! link cssMarginProp PurpboxAqua
hi! link cssListProp PurpboxAqua
hi! link cssTableProp PurpboxAqua
hi! link cssFontProp PurpboxAqua
hi! link cssPaddingProp PurpboxAqua
hi! link cssDimensionProp PurpboxAqua
hi! link cssRenderProp PurpboxAqua
hi! link cssColorProp PurpboxAqua
hi! link cssGeneratedContentProp PurpboxAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces PurpboxFg1
hi! link javaScriptFunction PurpboxAqua
hi! link javaScriptIdentifier PurpboxRed
hi! link javaScriptMember PurpboxBlue
hi! link javaScriptNumber PurpboxPurple
hi! link javaScriptNull PurpboxPurple
hi! link javaScriptParens PurpboxFg3

" }}}
" YAJS: {{{

hi! link javascriptImport PurpboxAqua
hi! link javascriptExport PurpboxAqua
hi! link javascriptClassKeyword PurpboxAqua
hi! link javascriptClassExtends PurpboxAqua
hi! link javascriptDefault PurpboxAqua

hi! link javascriptClassName PurpboxYellow
hi! link javascriptClassSuperName PurpboxYellow
hi! link javascriptGlobal PurpboxYellow

hi! link javascriptEndColons PurpboxFg1
hi! link javascriptFuncArg PurpboxFg1
hi! link javascriptGlobalMethod PurpboxFg1
hi! link javascriptNodeGlobal PurpboxFg1
hi! link javascriptBOMWindowProp PurpboxFg1
hi! link javascriptArrayMethod PurpboxFg1
hi! link javascriptArrayStaticMethod PurpboxFg1
hi! link javascriptCacheMethod PurpboxFg1
hi! link javascriptDateMethod PurpboxFg1
hi! link javascriptMathStaticMethod PurpboxFg1

" hi! link javascriptProp PurpboxFg1
hi! link javascriptURLUtilsProp PurpboxFg1
hi! link javascriptBOMNavigatorProp PurpboxFg1
hi! link javascriptDOMDocMethod PurpboxFg1
hi! link javascriptDOMDocProp PurpboxFg1
hi! link javascriptBOMLocationMethod PurpboxFg1
hi! link javascriptBOMWindowMethod PurpboxFg1
hi! link javascriptStringMethod PurpboxFg1

hi! link javascriptVariable PurpboxOrange
" hi! link javascriptVariable PurpboxRed
" hi! link javascriptIdentifier PurpboxOrange
" hi! link javascriptClassSuper PurpboxOrange
hi! link javascriptIdentifier PurpboxOrange
hi! link javascriptClassSuper PurpboxOrange

" hi! link javascriptFuncKeyword PurpboxOrange
" hi! link javascriptAsyncFunc PurpboxOrange
hi! link javascriptFuncKeyword PurpboxAqua
hi! link javascriptAsyncFunc PurpboxAqua
hi! link javascriptClassStatic PurpboxOrange

hi! link javascriptOperator PurpboxRed
hi! link javascriptForOperator PurpboxRed
hi! link javascriptYield PurpboxRed
hi! link javascriptExceptions PurpboxRed
hi! link javascriptMessage PurpboxRed

hi! link javascriptTemplateSB PurpboxAqua
hi! link javascriptTemplateSubstitution PurpboxFg1

" hi! link javascriptLabel PurpboxBlue
" hi! link javascriptObjectLabel PurpboxBlue
" hi! link javascriptPropertyName PurpboxBlue
hi! link javascriptLabel PurpboxFg1
hi! link javascriptObjectLabel PurpboxFg1
hi! link javascriptPropertyName PurpboxFg1

hi! link javascriptLogicSymbols PurpboxFg1
hi! link javascriptArrowFunc PurpboxYellow

hi! link javascriptDocParamName PurpboxFg4
hi! link javascriptDocTags PurpboxFg4
hi! link javascriptDocNotation PurpboxFg4
hi! link javascriptDocParamType PurpboxFg4
hi! link javascriptDocNamedParamType PurpboxFg4

hi! link javascriptBrackets PurpboxFg1
hi! link javascriptDOMElemAttrs PurpboxFg1
hi! link javascriptDOMEventMethod PurpboxFg1
hi! link javascriptDOMNodeMethod PurpboxFg1
hi! link javascriptDOMStorageMethod PurpboxFg1
hi! link javascriptHeadersMethod PurpboxFg1

hi! link javascriptAsyncFuncKeyword PurpboxRed
hi! link javascriptAwaitFuncKeyword PurpboxRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword PurpboxAqua
hi! link jsExtendsKeyword PurpboxAqua
hi! link jsExportDefault PurpboxAqua
hi! link jsTemplateBraces PurpboxAqua
hi! link jsGlobalNodeObjects PurpboxFg1
hi! link jsGlobalObjects PurpboxFg1
hi! link jsFunction PurpboxAqua
hi! link jsFuncParens PurpboxFg3
hi! link jsParens PurpboxFg3
hi! link jsNull PurpboxPurple
hi! link jsUndefined PurpboxPurple
hi! link jsClassDefinition PurpboxYellow

" }}}
" TypeScript: {{{

hi! link typeScriptReserved PurpboxAqua
hi! link typeScriptLabel PurpboxAqua
hi! link typeScriptFuncKeyword PurpboxAqua
hi! link typeScriptIdentifier PurpboxOrange
hi! link typeScriptBraces PurpboxFg1
hi! link typeScriptEndColons PurpboxFg1
hi! link typeScriptDOMObjects PurpboxFg1
hi! link typeScriptAjaxMethods PurpboxFg1
hi! link typeScriptLogicSymbols PurpboxFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects PurpboxFg1
hi! link typeScriptParens PurpboxFg3
hi! link typeScriptOpSymbols PurpboxFg3
hi! link typeScriptHtmlElemProperties PurpboxFg1
hi! link typeScriptNull PurpboxPurple
hi! link typeScriptInterpolationDelimiter PurpboxAqua

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword PurpboxAqua
hi! link purescriptModuleName PurpboxFg1
hi! link purescriptWhere PurpboxAqua
hi! link purescriptDelimiter PurpboxFg4
hi! link purescriptType PurpboxFg1
hi! link purescriptImportKeyword PurpboxAqua
hi! link purescriptHidingKeyword PurpboxAqua
hi! link purescriptAsKeyword PurpboxAqua
hi! link purescriptStructure PurpboxAqua
hi! link purescriptOperator PurpboxBlue

hi! link purescriptTypeVar PurpboxFg1
hi! link purescriptConstructor PurpboxFg1
hi! link purescriptFunction PurpboxFg1
hi! link purescriptConditional PurpboxOrange
hi! link purescriptBacktick PurpboxOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp PurpboxFg3
hi! link coffeeSpecialOp PurpboxFg3
hi! link coffeeCurly PurpboxOrange
hi! link coffeeParen PurpboxFg3
hi! link coffeeBracket PurpboxOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter PurpboxGreen
hi! link rubyInterpolationDelimiter PurpboxAqua

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier PurpboxRed
hi! link objcDirective PurpboxBlue

" }}}
" Go: {{{

hi! link goDirective PurpboxAqua
hi! link goConstants PurpboxPurple
hi! link goDeclaration PurpboxRed
hi! link goDeclType PurpboxBlue
hi! link goBuiltins PurpboxOrange

" }}}
" Lua: {{{

hi! link luaIn PurpboxRed
hi! link luaFunction PurpboxAqua
hi! link luaTable PurpboxOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp PurpboxFg3
hi! link moonExtendedOp PurpboxFg3
hi! link moonFunction PurpboxFg3
hi! link moonObject PurpboxYellow

" }}}
" Java: {{{

hi! link javaAnnotation PurpboxBlue
hi! link javaDocTags PurpboxAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen PurpboxFg3
hi! link javaParen1 PurpboxFg3
hi! link javaParen2 PurpboxFg3
hi! link javaParen3 PurpboxFg3
hi! link javaParen4 PurpboxFg3
hi! link javaParen5 PurpboxFg3
hi! link javaOperator PurpboxOrange

hi! link javaVarArg PurpboxGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter PurpboxGreen
hi! link elixirInterpolationDelimiter PurpboxAqua

hi! link elixirModuleDeclaration PurpboxYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition PurpboxFg1
hi! link scalaCaseFollowing PurpboxFg1
hi! link scalaCapitalWord PurpboxFg1
hi! link scalaTypeExtension PurpboxFg1

hi! link scalaKeyword PurpboxRed
hi! link scalaKeywordModifier PurpboxRed

hi! link scalaSpecial PurpboxAqua
hi! link scalaOperator PurpboxFg1

hi! link scalaTypeDeclaration PurpboxYellow
hi! link scalaTypeTypePostDeclaration PurpboxYellow

hi! link scalaInstanceDeclaration PurpboxFg1
hi! link scalaInterpolation PurpboxAqua

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)

hi! link markdownH1 PurpboxGreenBold
hi! link markdownH2 PurpboxGreenBold
hi! link markdownH3 PurpboxYellowBold
hi! link markdownH4 PurpboxYellowBold
hi! link markdownH5 PurpboxYellow
hi! link markdownH6 PurpboxYellow

hi! link markdownCode PurpboxAqua
hi! link markdownCodeBlock PurpboxAqua
hi! link markdownCodeDelimiter PurpboxAqua

hi! link markdownBlockquote PurpboxGray
hi! link markdownListMarker PurpboxGray
hi! link markdownOrderedListMarker PurpboxGray
hi! link markdownRule PurpboxGray
hi! link markdownHeadingRule PurpboxGray

hi! link markdownUrlDelimiter PurpboxFg3
hi! link markdownLinkDelimiter PurpboxFg3
hi! link markdownLinkTextDelimiter PurpboxFg3

hi! link markdownHeadingDelimiter PurpboxOrange
hi! link markdownUrl PurpboxPurple
hi! link markdownUrlTitleDelimiter PurpboxGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

" hi! link haskellType PurpboxYellow
" hi! link haskellOperators PurpboxOrange
" hi! link haskellConditional PurpboxAqua
" hi! link haskellLet PurpboxOrange
"
hi! link haskellType PurpboxFg1
hi! link haskellIdentifier PurpboxFg1
hi! link haskellSeparator PurpboxFg1
hi! link haskellDelimiter PurpboxFg4
hi! link haskellOperators PurpboxBlue
"
hi! link haskellBacktick PurpboxOrange
hi! link haskellStatement PurpboxOrange
hi! link haskellConditional PurpboxOrange

hi! link haskellLet PurpboxAqua
hi! link haskellDefault PurpboxAqua
hi! link haskellWhere PurpboxAqua
hi! link haskellBottom PurpboxAqua
hi! link haskellBlockKeywords PurpboxAqua
hi! link haskellImportKeywords PurpboxAqua
hi! link haskellDeclKeyword PurpboxAqua
hi! link haskellDeriving PurpboxAqua
hi! link haskellAssocType PurpboxAqua

hi! link haskellNumber PurpboxPurple
hi! link haskellPragma PurpboxPurple

hi! link haskellString PurpboxGreen
hi! link haskellChar PurpboxGreen

" }}}
" Json: {{{

hi! link jsonKeyword PurpboxGreen
hi! link jsonQuote PurpboxGreen
hi! link jsonBraces PurpboxFg1
hi! link jsonString PurpboxFg1

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! PurpboxHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! PurpboxHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
