#!/bin/bash
source_path=$1
destination_path=$2
file_occurrence=$(find "$source_path" -type f | egrep "\.[a-z]*$" | rev | cut -d"." -f1 | rev | sort -u)
if [ -n "$file_occurrence" ]; then
    for extension in $file_occurrence; do
        folder_destination="$destination_path/$extension"
        find "$source_path" -type f | egrep "\."$extension"$" > /tmp/files.txt
        echo "*** Copying files with .$extension extensionto to $folder_destination folder"
        while read file; do 
            #echo $file;
            mkdir -p "$folder_destination"
            cp "$file" "$folder_destination" 
        done < /tmp/files.txt
    done
fi

file_occurrence=$(find "$source_path" -type f | egrep -v '\.[a-z]*$')
if [ -n "$file_occurrence" ]; then
    echo "$file_occurrence" > /tmp/files.txt
    folder_destination="$destination_path/files_without_extension"
    mkdir -p "$folder_destination"
    echo "*** Copying files without extension to $folder_destination folder"
    while read file; do 
        $echo "$file"
        cp "$file" $folder_destination 
    done < /tmp/files.txt
fi
rm /tmp/files.txt 2>/dev/null
