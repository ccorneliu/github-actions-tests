# /bin/bash

# This script will take two commit hashes as input and check if all modified files are from a list of ignored files
# The list of ignored files are defined in this script.
# Usage: ./check-if-only-modified-ignored-files.sh <commit-hash-1> <commit-hash-2>

# List of ignored files, for now including only the README.md file
ignored_files=("README.md")

# Check if the number of arguments is correct
if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "Usage: ./check-if-only-modified-ignored-files.sh <commit-hash-1> <commit-hash-2>"
    exit 1
fi

# Get the list of modified files between the two commits
modified_files=$(git diff --name-only $1 $2)

# Check if all modified files are from the list of ignored files
for file in $modified_files; do
    if [[ ! " ${ignored_files[@]} " =~ " ${file} " ]]; then
        echo false
        exit 1
    fi
done

echo true
exit 0
