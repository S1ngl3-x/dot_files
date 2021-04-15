alias v=nvim
alias xc="xclip -selection clipboard"
alias turnOffScrlkLight="xset -led named \"Scroll Lock\""
alias r=ranger
alias update="sudo apt update; and apt list --upgradable; and sudo apt upgrade -y; flatpak update -y"
alias s="git status"
# alias t="/home/adam/Apps/sublime_text_3/sublime_text -a"
alias t="subl -a"
alias l="ls -t"
set fish_greeting
set -gx EDITOR nvim
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showupstream informative
set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_cleanstate '✔'
set -g __fish_git_prompt_char_dirtystate '✚'
set -g __fish_git_prompt_char_invalidstate '✖'
set -g __fish_git_prompt_char_stagedstate '●'
set -g __fish_git_prompt_char_stashstate '⚑'
set -g __fish_git_prompt_char_untrackedfiles '?'
set -g __fish_git_prompt_char_upstream_ahead ''
set -g __fish_git_prompt_char_upstream_behind ''
set -g __fish_git_prompt_char_upstream_diverged 'ﱟ'
set -g __fish_git_prompt_char_upstream_equal ''
set -g __fish_git_prompt_char_upstream_prefix ''''

set --export GUROBI_HOME /home/adam/ownCloud/skola/ko/gurobi/gurobi911/linux64

set PATH /home/adam/.local/bin $PATH
set --export PATH $PATH:$GUROBI_HOME/bin
set --export LD_LIBRARY_PATH /user/local/bin
set --export LD_LIBRARY_PATH $LD_LIBRARY_PATH:$GUROBI_HOME/lib


# Powerline setup - just uncomment it
set fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
source /usr/share/powerline/bindings/fish/powerline-setup.fish
powerline-setup
