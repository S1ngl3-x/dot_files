# overrides the default prompt, fish_prompt is a special fish function name
function fish_prompt
    powerline-go -error $status -modules "user,cwd" -modules-right "git" -git-mode "simple" -cwd-max-depth 3
end
