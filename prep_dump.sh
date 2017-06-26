#!/bin/bash

dump_file=$1

sorted_file=$(echo $dump_file | sed 's/.txt/_sorted.txt/')

echo "Creating $sorted_file..."
# do uniq too
# sort $dump_file -f > $sorted_file

sorted_file=$dump_file

base_section_file=$(echo $sorted_file | sed 's/dumps/output/')

echo "Creating files for each letter for '$sorted_file'"
for letter in {a..z} ; do
    echo $letter
    section_file=$(echo $base_section_file | sed "s/.txt/_$letter.txt/")
    cat $sorted_file | grep -ai "^$letter" >> $section_file
done

section_file=$(echo $base_section_file | sed "s/.txt/_0.txt/")
echo "Other"
cat $sorted_file | grep -ai "^[^a-zA-Z]" >> $section_file

