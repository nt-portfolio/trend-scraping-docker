#!/bin/bash

cd ~/

if [ -e '.vimrc' ]; then
    rm .vimrc
fi

touch ~/.vimrc

echo "autocmd ColorScheme * highlight LineNr ctermfg=239" > ~/.vimrc
echo "colorscheme desert" >> ~/.vimrc
echo "syntax on" >> ~/.vimrc
echo "set all&" >> ~/.vimrc
echo "autocmd!" >> ~/.vimrc
echo "set title" >> ~/.vimrc
echo "set number" >> ~/.vimrc
echo "set cursorline" >> ~/.vimrc
echo "set showmatch" >> ~/.vimrc
echo "set statusline=%F" >> ~/.vimrc
echo "set statusline+=%m" >> ~/.vimrc
echo "set statusline+=%r" >> ~/.vimrc
echo "set statusline+=%h" >> ~/.vimrc
echo "set statusline+=%w" >> ~/.vimrc
echo "set statusline+=%=" >> ~/.vimrc
echo "set statusline+=[ENC=%{&fileencoding}]" >> ~/.vimrc
echo "set statusline+=[LOW=%l/%L]" >> ~/.vimrc
echo "set laststatus=2" >> ~/.vimrc
echo "set ambiwidth=double" >> ~/.vimrc
echo "set tabstop=4" >> ~/.vimrc
echo "set expandtab" >> ~/.vimrc
echo "set shiftwidth=4" >> ~/.vimrc
echo "set smartindent" >> ~/.vimrc
echo "set nrformats-=octal" >> ~/.vimrc
echo "set history=50" >> ~/.vimrc
echo "set virtualedit=block" >> ~/.vimrc
echo "set whichwrap=b,s,[,],<,>" >> ~/.vimrc
echo "set backspace=indent,eol,start" >> ~/.vimrc
echo "set wildmenu" >> ~/.vimrc
echo "set hlsearch" >> ~/.vimrc
echo "set ignorecase" >> ~/.vimrc
echo "set smartcase" >> ~/.vimrc
echo "set wrapscan" >> ~/.vimrc
echo "set encoding=utf-8" >> ~/.vimrc
echo "set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis" >> ~/.vimrc
echo "set fileformats=unix,dos,mac" >> ~/.vimrc

echo "augroup source-vimrc" >> ~/.vimrc
echo "autocmd!" >> ~/.vimrc
echo "autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker" >> ~/.vimrc
echo "autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC" >> ~/.vimrc
echo "augroup END" >> ~/.vimrc

# 自己消滅
NAME=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/$(basename ${BASH_SOURCE:-$0})
rm $NAME