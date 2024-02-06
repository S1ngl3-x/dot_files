set fish_greeting
set -gx EDITOR nvim

# Call the OS detection function to set up the environment for other functions
detect_os

# Paths
fish_add_path ~/.local/bin/ # for python libraries installed with pip
fish_add_path /opt/homebrew/bin/ # for brew binaries

alias v="nvim"
alias r="ranger"
alias s="git status"
alias t="subl"
alias p="python3"


# eza aliases
if type -q eza
  alias l "eza -l --icons -s modified -r"
  alias lt "l --tree --level=2"
  alias la "l -lah"
  alias lat "la --tree --level=2"
  alias ll "eza --icons -s modified -r"
end
