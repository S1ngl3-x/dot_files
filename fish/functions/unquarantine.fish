function unquarantine
    if test (count $argv) -lt 1
        echo "Usage: unquarantine <directory>"
        return 1
    end

    set -l target_directory $argv[1]
    
    if not test -d $target_directory
        echo "The provided path is not a directory: $target_directory"
        return 1
    end

    echo "Removing quarantine attributes recursively from $target_directory"
    find $target_directory -type f -exec xattr -d com.apple.quarantine {} \;
end
