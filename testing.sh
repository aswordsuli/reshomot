#!/bin/bash 


################################################################
#____1_____




################################################################
#____2_____
#!/bin/bash
echo "Hey! how would you like to manage your recored?" #shenhav: user menu
select action in add delete search update_name update_num print_sum print_sorted
do
   case $action in
      add) 
         echo -e "\nThe more the merrier! Please enter the record name:"
         ;;
      delete)
         echo -e "\nYou wish to remove a record. Please enter the record name:"
      ;;
      search) 
         echo -e "\nEnter the record name you wish to search for:"
      ;;
      update_name) 
         echo -e "\nYou wish to update a record name. Please enter the record name:"
      ;;
      update_num) 
         echo -e "\nYou wish to update a record amount. Please enter the record name:"
      ;;
      print_sum) 
         echo -e "\nSure! listing the quantity of your entire collection now:"
      ;;
      print_sorted) 
         echo -e "\nNo problem! listing the quantity of your collection by lexicographic:"
      ;;
      *) 
         echo -e "\nError: Invalid input"
      ;;
   esac
done



################################################################
#____3_____





################################################################
<<<<<<< HEAD
#____4
=======
#____4_____
echo "nadin"
>>>>>>> nadin
