set fish_greeting
set -gx EDITOR nvim

alias v=nvim
alias xc="xclip -selection clipboard"
alias r=ranger
alias s="git status"
alias t="subl -a"
alias p="python"
alias update="sudo dnf upgrade; flatpak update"

# exa aliases
if type -q exa
  alias l "exa -l --icons -s modified -r"
  alias lt "l --tree --level=2"
  alias la "l -lah"
  alias lat "la --tree --level=2"
  alias ll "exa --icons -s modified -r"
end

# Powerline setup - just uncomment it
set fish_function_path $fish_function_path "/usr/share/powerline/fish"
source /usr/share/powerline/fish/powerline-setup.fish
powerline-setup
