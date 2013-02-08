#!/bin/bash

ln -s `pwd`/vimrc ~/.vimrc
mkdir -p ~/vim/ftplugin
ln -s `pwd`/vim/ftplugin/ruby.vim ~/vim/ftplugin/ruby.vim
