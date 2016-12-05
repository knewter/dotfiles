#!/bin/bash

# ack
ln -sf `pwd`/ack/ackrc ~/.ackrc

# synergy
ln -sf `pwd`/synergy/synergy.conf ~/.synergy.conf

# bins
mkdir -p ~/bin
ln -sf `pwd`/bin/tspace ~/bin/tspace
ln -sf `pwd`/bin/list-terminal-colors ~/bin/list-terminal-colors
ln -sf `pwd`/bin/subcount ~/bin/subcount

# hyper
ln -sf `pwd`/hyper/.hyper.js ~/.hyper.js

# Plug (to be used with nvim)
# https://github.com/junegunn/vim-plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# nvim
mkdir -p ~/.config/nvim
ln -sf `pwd`/nvim/init.vim ~/.config/nvim/

# oh-my-fish
mkdir -p ~/.config/omf
ln -sf `pwd`/omf/bundle ~/.config/omf/
ln -sf `pwd`/omf/channel ~/.config/omf/
ln -sf `pwd`/omf/fonts ~/.config/omf/
ln -sf `pwd`/omf/init.fish ~/.config/omf/
ln -sf `pwd`/omf/asdf.fish ~/.config/omf/
ln -sf `pwd`/omf/theme ~/.config/omf/

echo "# Now for some manual stuff, sorry!"
echo "## nvim"
echo "To install the nvim plugins, open up vim and type ':PlugInstall'\n"
echo "## git"
echo "Setup your git config like so:\ngit config --global user.email "josh.rubyist@gmail.com"\ngit config --global user.name "Josh Adams""

