#!/bin/bash

# Function to check if a package is installed
is_installed() {
  brew list "$1" &> /dev/null
}

# Function to check if a cask is installed
is_cask_installed() {
  brew list --cask "$1" &> /dev/null
}

# Function to install packages if not already installed
install_packages() {
  local packages=("$@")
  local to_install=()

  for pkg in "${packages[@]}"; do
    if ! is_installed "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    echo "Installing: ${to_install[*]}"
    brew install "${to_install[@]}"
  fi
}

# Function to install cask packages if not already installed
install_casks() {
  local casks=("$@")
  local to_install=()

  for cask in "${casks[@]}"; do
    if ! is_cask_installed "$cask"; then
      to_install+=("$cask")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    echo "Installing casks: ${to_install[*]}"
    brew install --cask "${to_install[@]}"
  fi
}

# Function to install fonts
install_fonts() {
  local fonts=("$@")
  local to_install=()

  for font in "${fonts[@]}"; do
    if ! is_cask_installed "$font"; then
      to_install+=("$font")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    echo "Installing fonts: ${to_install[*]}"
    brew install --cask "${to_install[@]}"
  fi
}
