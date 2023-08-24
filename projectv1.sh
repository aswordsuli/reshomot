#!/bin/bash

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

display_records() {
    echo "Record Collection:"
    while IFS= read -r record; do
        echo "$record"
    done < "records.txt"
}

display_records_sum() {
    total_records=$(awk -F, '{sum+=$2} END {print sum}' "records.txt")
    if [ -s "records.txt" ]; then
    	echo "Total records: $total_records"
    else
   	 echo "No records to display, please add and try again."
    fi
}

print_sorted_records() {
    if [ -s "records.txt" ]; then
        sort records.txt
    else
        echo "No records to display, please add and try again."
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

