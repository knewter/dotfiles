#!/bin/bash

ln -sf `pwd`/vim/vimrc ~/.vimrc
mkdir -p ~/vim/ftplugin
ln -sf `pwd`/vim/ftplugin/ruby.vim ~/vim/ftplugin/ruby.vim
ln -sf `pwd`/bash/aliases ~/.bash_files/aliases
ln -sf `pwd`/ack/ackrc ~/.ackrc
