function update
    echo "Running update script for $OS_TYPE..."

    switch $OS_TYPE
        case 'macos'
            brew update
            brew upgrade
            brew_upgrade_casks
            brew cleanup
        case 'fedora'
            sudo dnf upgrade --refresh
            flatpak update
    end
end
