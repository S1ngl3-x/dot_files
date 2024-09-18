set fish_greeting
set -gx EDITOR nvim

# Call the OS detection function to set up the environment for other functions
detect_os

# Paths
fish_add_path ~/.local/bin/ # for python libraries installed with pip
fish_add_path /opt/homebrew/bin/ # for brew binaries
fish_add_path /Users/adam.lipowski/Applications/tree-2.1.3 # eza alternative for sudo-less mac

# Aliases
alias v="nvim"
alias r="ranger"
alias s="git status"
alias t="subl"
alias p="python3"

setup_ls_aliases
