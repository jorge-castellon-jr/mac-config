#!/bin/bash

brewPackages=(
  neovim
  aerospace
  zoxide
  lazygit
  node
  sketchybar
  yazi
)

for package in ${brewPackages[@]}; do
  brew install ${package}
done
