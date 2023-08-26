#!/bin/bash
source ./helpers.sh
xfile(){
    if [[ -e $1 ]]; then
    continue
    else 
    touch "$1"
    main
    fi
} 

search_main(){
 #input_file 
  

      sort $file > sorted_file.db
      read -p "search for string : " str
      flag=0
     
      
      while IFS=' ' read line ; do
         if grep -q $str <<< $line; then
            echo "$line " 
            flag=1
        
         fi
      done < sorted_file.db
    if [ $flag -eq 0 ]; then
            echo -e "no records found\n"
    fi
    rm sorted_file.db
    echo
    update_log

}

update_name(){
 
 searcher
 if [[ $flag -eq 1 ]]; then
 read -p "Enter a string to replace: " replacement

 rec_name=$(echo "$selected_line" | cut -d ',' -f 1)
 sed -i "s/$rec_name/$replacement/g" "$file"
 update_log 'update_name' "$replacement"

 else 
 flag=0
 update_log 'update_name' 
 fi
}

update_quantity(){
 searcher

  rec_quan=$(echo "$selected_line" | cut -d ',' -f 2)
 if [[ $rec_quan -ge 1 ]]; then 
   read -p "Enter number you want to update " replacement

   rec_name=$(echo "$selected_line" | cut -d ',' -f 1)
    
    sed -i "s/$rec_name,[0-9]*/$rec_name,$replacement/g" $file
    update_log 'update_quantity' $replacement
 

 else 
    echo "record amount is less than 1 !! "
    flag=0
    update_log 'update_quantity' 
    
 fi   
 

}

######main
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


main(){

 while true; do
     main_menu
     input_file
     case $choice in
        1) add_record ;;
        2) delete_record ;;
        3) search_main ;;
        4) update_name ;;
        5) update_quantity ;;
        6) display_records ;;
        7) display_total_quantity ;;
        8)
            # Save records to file and exit - check how to set files as same names syntax?
            ;;
        *) echo "Invalid choice. Please select 1-8." ;;
     esac
 done

}

main 