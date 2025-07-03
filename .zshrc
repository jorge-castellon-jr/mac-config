# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export COPYFILE_DISABLE=1

export BUN_INSTALL="$HOME/.bun" 
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PKG_CONFIG_PATH=/opt/homebrew/lib/pkgconfig
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

alias y="yarn"
alias b="bun run"
alias bb="bun --bun run"
alias p="pnpm"

alias sail="./vendor/bin/sail"
# bun completions
[ -s "/Users/jorgecastellonjr./.bun/_bun" ] && source "/Users/jorgecastellonjr./.bun/_bun"

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Function to set terminal title
function set_terminal_title() {
  # Split the current directory path
  local dirs=(${(s:/:)PWD})
  
  # Get the length of the array
  local num_dirs=${#dirs}
  
  # Extract the last two directory names
  local last_two_dirs
  if (( num_dirs >= 2 )); then
    last_two_dirs="${dirs[-2]}/${dirs[-1]}"
  else
    last_two_dirs="${dirs[-1]}"
  fi
  
  # Set the terminal title to the last two directories
  print -Pn "\e]0;$last_two_dirs\a"
}

# Pre-command hook to update the terminal title before each command
function preexec() {
  # Update the terminal title with the running command and the current directory
  set_terminal_title "$1"
}

# Post-command hook to reset the terminal title after each command
function precmd() {
  # Reset the terminal title to the current directory
  set_terminal_title
}

# Call the function to set the initial title when the shell starts
set_terminal_title

# ---- Eza (better ls) -----
alias ls="eza --icons=always --color=always --long --no-filesize --no-time"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"
alias n="nvim"
alias v="nvim"
alias lg="lazygit"

alias llama="ollama run llama3:8b"

# Created by `pipx` on 2024-09-11 17:17:09
export PATH="$PATH:/Users/jorgecastellonjr./.local/bin"

alias calibre-customize='/Applications/calibre.app/Contents/MacOS/calibre-customize'
alias calibre-debug='/Applications/calibre.app/Contents/MacOS/calibre-debug'
