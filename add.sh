#!/bin/bash

# Function to add a record to a file
addRecord() {
    local fileName="$1"
    local name="$2"
    local amount="$3"

    # Check if the file exists
    if [ ! -f "$fileName" ]; then
        echo "Error: The file '$fileName' does not exist."
        return
    fi

    # Check if the name is valid (alphanumeric and spaces)
    if [[ ! "$name" =~ ^[a-zA-Z0-9]+$ ]]; then
        echo "Error: Invalid name. Name should only contain letters, numbers, and spaces."
        return
    fi

    # Check if the amount is a positive integer
    if [[ ! "$amount" =~ ^[1-9][0-9]*$ ]]; then
        echo "Error: Invalid amount. Amount should be a positive integer."
        return
    fi

    # Check if the name already exists in the file
    if grep -q "^$name," "$fileName"; then
        # If the name exists, update the amount by adding the new amount
        currentAmount=$(grep "^$name," "$fileName" | cut -d ',' -f 2)
        newAmount=$((currentAmount + amount))
        sed -i "s/^$name,.*/$name,$newAmount/" "$fileName"
        echo "Record updated successfully in '$fileName'."
    else
        # If the name doesn't exist, add it to the end of the file
        echo "$name,$amount" >> "$fileName"
        echo "Record added successfully to '$fileName'."
    fi

    # Log the event
    echo "$(date): Record operation performed on '$fileName' - Name: '$name', Amount: '$amount'" >> record_log.txt
}

# Example usage:
# Get input from the user for the filename, name, and amount
read -p "Enter the filename: " fileName
read -p "Enter the name of the record: " name
read -p "Enter the amount: " amount

# Call the function to add or update the record
addRecord "$fileName" "$name" "$amount"

