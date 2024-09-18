function fish_prompt
    switch $OS_TYPE
        case macos
            echo -n (whoami)(prompt_pwd) '> '
        case fedora
            powerline-go -error $status -modules "user,cwd" -modules-right "git" -git-mode "simple" -cwd-max-depth 3
    end
end
