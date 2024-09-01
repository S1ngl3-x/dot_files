function code
    switch $OS_TYPE
        case 'macos'
            code
        case 'fedora'
            codium --ozone-platform-hint=auto
    end
end
