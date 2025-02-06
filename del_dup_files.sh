#!/bin/bash

# This script uses md5 checksums to detect and then delete duplicate files;

# Specify the directory to search for duplicates;
drctry="/path/to/directory"

# Create an associative array to store checksums and file paths;
declare -a checksums

# Function to calculate the MD5 checksum of a file;
calc_chksm() {
  md5 -q < "$1"
}

# Loop through files in the directory;
for file in "$drctry"/*; do

  # Check if the file is a regular file (not a directory or symlink);
  if [ -f "$file" ]; then

    # Calculate the checksum of the file;
    checksum=$(calc_chksm "$file")

    # Verify whether the checksum is already in the array;
    if [[ " ${checksums[@]} " =~ " $checksum " ]]; then

      # Print confirmation to terminal;
      echo "Deleting duplicate file: $file"

      # Delete file;
      rm "$file"

    else
      
      # Store the checksum and file path in the array;
      checksums+=("$checksum")
    fi
  fi
done