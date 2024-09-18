function setup_ls_aliases
    switch $OS_TYPE
        case macos
            # Use the sudo-less installed tree and ls for macOS
            alias l="ls -1tGh --color=auto" # Long list, sorted by last modified (most recent first), human-readable sizes
            alias lt="tree -L 2 -C --noreport --sort=mtime -r" # Tree sorted by last modified (most recent first), directories first, 2 levels, color, and sizes
            alias la="ls -latGrh --color=auto" # List all (including hidden), sorted by last modified (most recent first), long with color and human-readable sizes
            alias lat="tree -a -L 2 -C -h --noreport --sort=mtime -r" # Tree with hidden files, sorted by last modified (most recent first), 2 levels, color, and sizes
        case fedora
            # Use eza if available on Fedora
            if type -q eza
                alias l="eza -l --icons -s modified -r"
                alias lt="eza -l --tree --level=2"
                alias la="eza -lah"
                alias lat="eza -la --tree --level=2"
            end
    end
end
