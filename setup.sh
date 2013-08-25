#!/bin/bash

ln -sf `pwd`/vim/vimrc ~/.vimrc
mkdir -p ~/.vim/ftplugin
ln -sf `pwd`/vim/ftplugin/ruby.vim ~/.vim/ftplugin/ruby.vim
ln -sf `pwd`/vim/ftplugin/erlang.vim ~/.vim/ftplugin/erlang.vim
mkdir -p ~/.bash_files
ln -sf `pwd`/bash/aliases ~/.bash_files/aliases
ln -sf `pwd`/ack/ackrc ~/.ackrc
ln -sf `pwd`/xmodmap/xmodmap-esc ~/.xmodmap-esc
ln -sf `pwd`/tmux/tmux.conf ~/.tmux.conf
ln -sf `pwd`/synergy/synergy.conf ~/.synergy.conf
