#!/bin/bash

source ./helpers.sh
#source ./functions.sh
    echo "Welcome $USER!"
    read -p "Please enter file name: " input_file
     if [ ! -f "$input_file" ]; then
        echo "Error: The file does not exist. Creating $input_file"
        touch "$input_file"
    fi
main_menu() {
    echo "This is your personal record collection management app. How would you like to use it?"
    echo "1. Add Record"
    echo "2. Delete Record"
    echo "3. Search Records"
    echo "4. Update Record Name"
    echo "5. Update Record Quantity"
    echo "6. Display Total Record Quantity"
    echo "7. Display Records"
    echo "8. Exit"
    read -p "Enter your choice (1-8): " choice
}
###########################################################
# Function to add a record to a file
add_record() {
    local input_file="$1"
    local name="$2"
    local amount="$3"


    # Check if the name already exists in the file
    if grep -q "^$name," "$input_file"; then
        # If the name exists, update the amount by adding the new amount
        currentAmount=$(grep "^$name," "$input_file" | cut -d ',' -f 2)
        newAmount=$((currentAmount + amount))
        sed -i "s/^$name,.*/$name,$newAmount/" "$input_file"
        echo "Record updated successfully in '$input_file'."
    else
        # If the name doesn't exist, add it to the end of the file
        echo "$name,$amount" >> "$input_file"
        echo "Record added successfully to '$input_file'."
    fi

    # Log the event
    echo "$(date): Record operation performed on '$input_file' - Name: '$name', Amount: '$amount'" >> logfile.txt
}

# Example usage:
# Get input from the user for the name, and amount


#read -p "Enter the name of the record: " name
#read -p "Enter the amount: " amount

# Call the function to add or update the record
#addecord "$name" "$amount"
########################################################

search_main(){
   input_file
sort $file > sorted_file.db
read -p "search for string : " str
flag=0
while IFS=' ' read line; do
   if grep -q $str <<< $line; then
        echo $line 
        flag=1
   fi

   
done < sorted_file.db

rm sorted_file.db

write_to_log

}

write_to_log() {
    local timestamp=$(date +"%m/%d/%Y %T")
	if [[ $flag -eq 1 ]]; then
    echo "$timestamp PrintAmount" $total_records >> logfile.txt
	else
    echo "$timestamp PrintAll" $sorted_records >> logfile.txt
fi
}


#function to display line by line
display_records() {
    echo "Record Collection:"
    while IFS= read -r record; do
        echo "$record"
    done < "records.txt"
}

#function to display total records
display_records_sum() {
    flag=1
    total_records=$(awk -F, '{sum+=$2} END {print sum}' "records.txt")
    if [ -s "records.txt" ]; then
    	echo "Total records: $total_records"
    else
   	echo "No records to display, please add and try again."
    fi
    	write_to_log
}

#function to display content of file in abc sorting
print_sorted_records() {
    flag=0
    sorted_records=$(sort records.txt)
    if [ -s "records.txt" ]; then
        #sort records.txt
        echo "$sorted_records"
    else
        echo "No records to display, please add and try again."
    fi
        write_to_log
}

while true; do
    main_menu
    case $choice in
    	1)
    	read -p "Enter the name of the record: " name
        read -p "Enter the amount: " amount  
        add_record "$input_file" "$name" "$amount";;
        2) delete_record ;;
        3) search_main ;;
        4) update_name ;;
        5) update_quantity ;;
        6) display_records_sum ;;
        7) print_sorted_records ;; 
        8) exit ;;
        *) echo "Invalid choice. Please select 1-8." ;;
    esac
done
