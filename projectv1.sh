#!/bin/bash
source ./functions.sh

main_menu() {
    echo "Welcome $USER!"
    echo "This is your personal record collection management app. How would you like to use it?"
    echo "1. Add Record"
    echo "2. Delete Record"
    echo "3. Search Records"
    echo "4. Update Record Name"
    echo "5. Update Record Quantity"
    echo "6. Display Records"
    echo "7. Display Total Quantity"
    echo "8. Exit"
    read -p "Enter your choice (1-8): " choice
}




while true; do
    main_menu
    case $choice in
        1) add_record ;;
        2) delete_record ;;
        3) search_main ;;
        4) update_name ;;
        5) update_quantity ;;
        6) display_records ;;
        7) display_total_quantity ;;
        8) exit 0            ;;
        *) echo "Invalid choice. Please select 1-8." ;;
    esac
done