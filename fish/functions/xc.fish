function xc
    switch $OS_TYPE
        case 'macos'
            pbcopy
        case 'fedora'
            xclip -selection clipboard
    end
end
