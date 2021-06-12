if status is-interactive
and not set -q TMUX
    exec tmux
end

set fish_greeting
set -gx EDITOR nvim

alias v=nvim
alias xc="xclip -selection clipboard"
alias turnOffScrlkLight="xset -led named \"Scroll Lock\""
alias r=ranger
alias update="sudo apt update; and apt list --upgradable; and sudo apt upgrade -y; flatpak update -y"
alias s="git status"
alias t="subl -a"
alias p="python"

# exa aliases
if type -q exa
  alias l "exa -l --icons -s modified -r"
  alias lt "l --tree --level=2"
  alias la "l -a"
  alias lat "la --tree --level=2"
  alias ll "exa --icons -s modified -r"
end

#gurobi
set --export GUROBI_HOME /home/adam/ownCloud/skola/ko/gurobi/gurobi911/linux64
set PATH /home/adam/.local/bin $PATH
set --export PATH $PATH:$GUROBI_HOME/bin
set --export LD_LIBRARY_PATH /user/local/bin
set --export LD_LIBRARY_PATH $LD_LIBRARY_PATH:$GUROBI_HOME/lib


# Powerline setup - just uncomment it
set fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
source /usr/share/powerline/bindings/fish/powerline-setup.fish
powerline-setup


#starship init fish | source
