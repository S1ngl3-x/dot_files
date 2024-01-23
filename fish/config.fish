set fish_greeting
set -gx EDITOR nvim

# Paths
# for python libraries installed with pip
fish_add_path ~/.local/bin/
fish_add_path /opt/homebrew/bin/

alias v=nvim
alias xc="xclip -selection clipboard"
alias r=ranger
alias s="git status"
alias t="subl"
alias p="python3"
alias update="sudo dnf upgrade; flatpak update"

# eza aliases
if type -q eza
  alias l "eza -l --icons -s modified -r"
  alias lt "l --tree --level=2"
  alias la "l -lah"
  alias lat "la --tree --level=2"
  alias ll "eza --icons -s modified -r"
end

# Powerline setup - just uncomment it
# set fish_function_path $fish_function_path "/usr/share/powerline/fish"
# source /usr/share/powerline/fish/powerline-setup.fish
# powerline-setup

# function fish_prompt
#     /usr/local/bin/powerline-go -error $status
# end


function fish_prompt
    powerline-go -error $status -modules "user,cwd" -modules-right "git" -git-mode "simple" -cwd-max-depth 3
end

