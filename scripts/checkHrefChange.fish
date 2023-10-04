#!/usr/bin/env fish

set url "https://www.ebaclearing.eu/services/rt1/participants/"
set filename_storage "last_sepa_inst_record_filename.txt"

# Try to read the last filename from a file
if test -e $filename_storage
    set last_version (cat $filename_storage)
else
    set last_version ""
end

# Fetch the new href from the webpage
set new_href (curl -s $url | grep -oP 'href="/media/azure/production/[0-9]+/\K[0-9]+-rt1-sct-inst-reachable-psp-list_cug.xlsx')

# Check if href is different from the last known version
if test "$new_href" != "$last_version"
    echo "The href has changed!"
    echo "New version: $new_href"
    
    # Save the new href as the last known version
    echo $new_href >$filename_storage
else
    echo "No change detected."
end
