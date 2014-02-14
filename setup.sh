#!/bin/bash

# vim
ln -sf `pwd`/vim/vimrc ~/.vimrc
mkdir -p ~/.vim/ftplugin
ln -sf `pwd`/vim/ftplugin/ruby.vim ~/.vim/ftplugin/ruby.vim
ln -sf `pwd`/vim/ftplugin/erlang.vim ~/.vim/ftplugin/erlang.vim

# bash
mkdir -p ~/.bash_files
ln -sf `pwd`/bash/aliases ~/.bash_files/aliases
ln -sf `pwd`/bash/prompts ~/.bash_files/prompts
ln -sf `pwd`/bash/kerl.bash ~/.bash_files/kerl.bash

# ack
ln -sf `pwd`/ack/ackrc ~/.ackrc

# map caps to esc
ln -sf `pwd`/xmodmap/xmodmap-esc ~/.xmodmap-esc

# tmux
ln -sf `pwd`/tmux/tmux.conf ~/.tmux.conf
ln -sf `pwd`/tmux/teamocil ~/.teamocil

# synergy
ln -sf `pwd`/synergy/synergy.conf ~/.synergy.conf

# bins
ln -sf `pwd`/bin/tspace ~/bin/tspace
ln -sf `pwd`/bin/list-terminal-colors ~/bin/list-terminal-colors
