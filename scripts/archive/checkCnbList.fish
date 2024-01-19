#!/usr/bin/env fish

set url "https://www.cnb.cz/export/sites/cnb/cs/platebni-styk/.galleries/certis/download/seznam_okamzite_platby.pdf"
set filename_storage "last_date.txt"

# Download the PDF
set -l pdf_path "downloaded_file.pdf"
curl -s -o $pdf_path $url

# Extract text content (assuming the PDF is not password-protected or encrypted)
set -l text_path "extracted_text.txt"
pdftotext $pdf_path $text_path

# Extract the date from the 3rd row
# Note: You may need to adapt this line depending on the actual format/content of the text.
set -l extracted_date (sed -n '3p' $text_path)

# Check against the stored date
if test -e $filename_storage
    set last_date (cat $filename_storage)
else
    set last_date ""
end

if test "$extracted_date" != "$last_date"
    echo "The document has changed!"
    echo "New date: $extracted_date"
    
    # Save the new date
    echo $extracted_date >$filename_storage
else
    echo "No change detected."
end

# Clean up: Remove downloaded PDF and extracted text (optional)
rm $pdf_path $text_path
