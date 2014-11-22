#!/bin/bash

# git
git config --global user.email "josh.rubyist@gmail.com"
git config --global user.name "Josh Adams"

# vim
ln -sf `pwd`/vim/vimrc ~/.vimrc
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# bash
## prepare liquidprompt
pushd ~
git clone https://github.com/nojhan/liquidprompt.git
source liquidprompt/liquidprompt
## prepare the rest of the bash files
mkdir -p ~/.bash_files
popd
ln -sf `pwd`/bash/bashrc ~/.bashrc
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
ln -sf `pwd`/bin/subcount ~/bin/subcount
