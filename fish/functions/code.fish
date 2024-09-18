function code
    switch $OS_TYPE
        case macos
            /usr/local/bin/code
        case fedora
            codium --ozone-platform-hint=auto
    end
end
