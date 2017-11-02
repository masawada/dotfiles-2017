let g:plugins_dir = expand($HOME.'/.vim/plugins')

call plug#begin(g:plugins_dir)

Plug 'cohama/lexima.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-surround'
Plug 'tyru/current-func-info.vim'
Plug 'maralla/completor.vim',        { 'do': 'make js' }
Plug 'nanotech/jellybeans.vim'
Plug 'SirVer/ultisnips'
Plug 'w0rp/ale'

Plug 'mattn/emmet-vim',              { 'for': 'html' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'js' }
Plug 'mxw/vim-jsx',                  { 'for': 'js' }
Plug 'elzr/vim-json',                { 'for': 'json' }
Plug 'plasticboy/vim-markdown',      { 'for': 'markdown' }

call plug#end()

function! s:is_installed(plugin_name)
  let plugins = expand(g:plugins_dir.'/'.a:plugin_name)

  if isdirectory(plugins)
    return 1
  endif

  return 0
endfunction

if s:is_installed('lexima.vim')
  inoremap [ []<LEFT>
  inoremap ( ()<LEFT>
  inoremap " ""<LEFT>
  inoremap ' ''<LEFT>
  inoremap ` ``<LEFT>
endif

if s:is_installed('vim-quickrun')
  let g:quickrun_config = {}
  nnoremap <Leader>q :<C-u>bw! \[quickrun\ output\]<CR>
endif

if s:is_installed('vim-quickrun') && s:is_installed('current-func-info.vim')
  "Test helper for Perl"
  "http://this.aereal.org/entry/2014/04/05/221218"

  let g:quickrun_config['prove/carton'] = {
    \ 'exec'    : 'carton exec -- %c %o %s',
    \ 'command' : 'prove',
    \ }
  let g:quickrun_config['prove/carton/contextual'] = extend(g:quickrun_config['prove/carton'], {
    \ 'exec' : 'TEST_METHOD=%a ' . g:quickrun_config['prove/carton'].exec,
    \ })
  command! ProveThis call s:prove_this()

  function! s:prove_this()
    let func_name = cfi#format('%s', '')
    if func_name == ''
      QuickRun prove/carton
    else
      execute 'QuickRun prove/carton/contextual -args ' . func_name
    endif
  endfunction

  nnoremap <silent> ,t :update<CR>:call <SID>prove_this()<CR>
endif

if s:is_installed('ale')
  let g:ale_linters = { 'javascript': ['eslint', 'flow'] }
  let g:ale_statusline_format = ['E%d', 'W%d', '']
  let g:ale_perl_perl_executable = 'env PERL5LIB="./local/lib/perl5" perl'

  nnoremap <silent> <C-k> :ALEPreviousWrap<CR>
  nnoremap <silent> <C-j> :ALENextWrap<CR>
endif

if s:is_installed('ultisnips')
  let g:UltiSnipsExpandTrigger="<C-k>"

  "Since ultisnips overwrites some mappings by default, kill them"
  let g:UltiSnipsJumpForwardTrigger="<nop>"
  let g:UltiSnipsJumpBackwardTrigger="<nop>"

  let g:UltiSnipsSnippetsDir = expand($HOME.'/.vim/snippets')
endif

if s:is_installed('completor.vim')
  inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
  inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<CR>"
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
endif

if s:is_installed('jellybeans.vim')
  let g:jellybeans_background_color_256='NONE'
  colorscheme jellybeans
endif

if s:is_installed('jellybeans.vim') && s:is_installed('lightline.vim')
  let g:lightline = {
    \ 'colorscheme': 'jellybeans',
    \ }
endif
