#!/bin/bash
directory="./100GOPRO"
dir2="./100GOPRO_sandisk"

# Loop through each file in the directory
for file in "$directory"/*; do
    if [ -f "$file" ]; then
        modified_date=$(GetFileInfo -m "$file")
        creation_date=$(GetFileInfo -d "$file")
        modified_date_2023="${modified_date/2021/2023}"
        creation_date_2023="${creation_date/2021/2023}"

        file2="$dir2/$(basename "$file")"
        sandisk_modified_date=$(GetFileInfo -m "$file2")
        sandisk_creation_date=$(GetFileInfo -d "$file2")
        sandisk_modified_date_2023="${sandisk_modified_date/2021/2023}"
        sandisk_creation_date_2023="${sandisk_creation_date/2021/2023}"

        #modified_date_no_sec="${modified_date_2023%:*}"
        #creation_date_no_sec="${creation_date_2023%:*}"
        modified_date_day="${modified_date_2023% *}"
        creation_date_day="${creation_date_2023% *}"
        sandisk_modified_date_day="${sandisk_modified_date_2023% *}"
        sandisk_creation_date_day="${sandisk_creation_date_2023% *}"

        if [ "$modified_date_day" != "$sandisk_modified_date_day" ]; then
            echo $(basename $file)
            echo "1 $modified_date_2023 | $creation_date_2023"
            echo "2 $sandisk_modified_date_2023 | $sandisk_creation_date_2023"
        fi

        #if [ "$modified_date_day" != "$creation_date_day" ]; then
            #echo "$file MODIFIED DATE $modified_date >>> $creation_date_2023 CREATION DATE $creation_date >>> $creation_date_2023"
            #SetFile -m "$creation_date_2023" -d "$creation_date_2023" "$file"
        #else
            #echo "$file MODIFIED DATE $modified_date >>> $modified_date_2023 CREATION DATE $creation_date >>> $creation_date_2023"
            #SetFile -m "$modified_date_2023" -d "$creation_date_2023" "$file"
        #fi
    fi
done

