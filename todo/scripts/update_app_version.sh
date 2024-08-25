#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <file_name> <new_value>"
  exit 1
fi

# Assign arguments to variables
file_name=$1
new_value=$2

# Use sed to replace the appVersion line with the new value
sed -i.bak "s/appVersion: \".*\"/appVersion: \"$new_value\"/" "$file_name"

# Check if the sed command was successful
if [ $? -eq 0 ]; then
  echo "appVersion updated successfully in $file_name"
else
  echo "An error occurred while updating appVersion in $file_name"
fi
