#!/bin/bash

# Print the logo
print_logo() {
  cat << "EOF"
    ______                _ __    __     
   / ____/______  _______(_) /_  / /__   
  / /   / ___/ / / / ___/ / __ \/ / _ \  
 / /___/ /  / /_/ / /__/ / /_/ / /  __/  macOS System Crafting Tool
 \____/_/   \__,_/\___/_/_.___/_/\___/   by: typecraft (macOS port)

EOF
}

# Parse command line arguments
DEV_ONLY=false
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --dev-only) DEV_ONLY=true; shift ;;
    *) echo "Unknown parameter: $1"; exit 1 ;;
  esac
done

# Clear screen and show logo
clear
print_logo

# Exit on any error
set -e

# Source utility functions
source utils.sh

# Source the package list
if [ ! -f "packages.conf" ]; then
  echo "Error: packages.conf not found!"
  exit 1
fi

source packages.conf

if [[ "$DEV_ONLY" == true ]]; then
  echo "Starting development-only setup..."
else
  echo "Starting full system setup..."
fi

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add Homebrew to PATH for Apple Silicon Macs
  if [[ $(uname -m) == "arm64" ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "Homebrew is already installed"
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Install packages by category
if [[ "$DEV_ONLY" == true ]]; then
  # Only install essential development packages
  echo "Installing system utilities..."
  install_packages "${SYSTEM_UTILS[@]}"
  
  echo "Installing development tools..."
  install_packages "${DEV_TOOLS[@]}"
else
  # Install all packages
  echo "Installing system utilities..."
  install_packages "${SYSTEM_UTILS[@]}"
  
  echo "Installing development tools..."
  install_packages "${DEV_TOOLS[@]}"
  
  echo "Installing GUI applications..."
  install_casks "${GUI_APPS[@]}"
  
  echo "Installing fonts..."
  install_fonts "${FONTS[@]}"
fi

# macOS-specific configurations
echo "Configuring macOS settings..."

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show file extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Set a faster key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Show the ~/Library folder
chflags nohidden ~/Library

# Restart Finder to apply changes
killall Finder

echo "Setup complete! You may want to restart your system to ensure all changes take effect."
echo ""
echo "Additional manual steps you might want to consider:"
echo "1. Configure your shell (zsh is default on macOS)"
echo "2. Set up your SSH keys"
echo "3. Configure git with your credentials"
echo "4. Install additional development tools specific to your needs"
echo "5. Configure your terminal/kitty preferences"
