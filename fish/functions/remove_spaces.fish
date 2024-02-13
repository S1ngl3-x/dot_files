function remove_spaces
    if test (count $argv) -lt 1
        echo "Usage: remove_spaces <directory>"
        return 1
    end

    set -l target_directory $argv[1]
    
    if not test -d $target_directory
        echo "The provided path is not a directory: $target_directory"
        return 1
    end

    echo "Renaming files in $target_directory to remove spaces..."

    find $target_directory -name "* *" -type f | while read -l file
        set -l new_name (string replace -ar " " "-" -- $file)
        if not test -e "$new_name"
            echo "Renaming '$file' to '$new_name'"
            mv -- "$file" "$new_name"
        else
            echo "Skipping '$file' because '$new_name' already exists."
        end
    end
end
