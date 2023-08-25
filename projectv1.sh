#!/bin/bash

source ./helpers.sh
#source ./functions.sh

main_menu() {
    echo "Welcome $USER!"
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

input_file() {
    read -p "Enter file name: " file
    if [ -f "$file" ]; then
        echo "$file"
    else
        echo "file not found."
        touch "$file"
    fi
}

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
    local event="$1"
    local result="$2"
    local timestamp=$(date +"%m/%d/%Y %T")
    echo "$timestamp $event $result" >> logfile.txt
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
    total_records=$(awk -F, '{sum+=$2} END {print sum}' "records.txt")
    if [ -s "records.txt" ]; then
    	echo "Total records: $total_records"
    	write_to_log "PrintAmount" $total_records
    else
   	echo "No records to display, please add and try again."
   	write_to_log "PrintAmount" $total_records
    fi
}

#function to display content of file in abc sorting
print_sorted_records() {
    sorted_content=$(sort "records.txt")
    if [ -s "records.txt" ]; then
        sort records.txt
        write_to_log "PrintAll" $sorted_content
    else
        echo "No records to display, please add and try again."
        write_to_log "PrintAll" $sorted_content
    fi
}

while true; do
    main_menu
    case $choice in
        1) add_record ;;
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

