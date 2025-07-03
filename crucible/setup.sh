#!/bin/bash

brewPackages=(
  neovim
  aerospace
  zoxide
  lazygit
  node
  sketchybar
  yazi
  powerlevel10k
  zsh-autosuggestions
  starship
  fzf
)

for package in ${brewPackages[@]}; do
  brew install ${package}
done

cp ~/.config/.spaceshiprc.zsh ~/.spaceshiprc.zsh
cp ~/.config/.p10k.zsh ~/.p10k.zsh

echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.config/.zshrc
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  
