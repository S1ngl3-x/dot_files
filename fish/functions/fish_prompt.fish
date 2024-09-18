# overrides the default prompt, fish_prompt is a special fish function name
#function fish_prompt
#    powerline-go -error $status -modules "user,cwd" -modules-right "git" -git-mode "simple" -cwd-max-depth 3
#end

function fish_prompt
    switch $OS_TYPE
        case macos
            echo -n (whoami)(prompt_pwd) '> '
        case fedora
            codium --ozone-platform-hint=auto
    end
end
