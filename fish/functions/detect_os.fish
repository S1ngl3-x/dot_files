function detect_os
    set -U OS_TYPE 'unknown' # set a default value

    switch (uname)
        case 'Darwin'
            set -U OS_TYPE 'macos'
        case 'Linux'
            if test -f /etc/fedora-release
                set -U OS_TYPE 'fedora'
            else
                set -U OS_TYPE 'linux'
            end
        case '*'
            echo "Unknown operating system."
    end
end
