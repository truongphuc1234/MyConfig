#!/bin/bash
#
cp -r ./zathura ./alacritty ./helix ~/.config 

cd ./xmonad && stack install
cd ../
cd ./xmobar && stack install
cd ../

sudo ln -s ~/.local/bin/my-xmonad /usr/bin
sudo ln -s ~/.local/bin/my-xmobar /usr/bin

sudo cp xmonad.desktop /usr/share/xsessions
