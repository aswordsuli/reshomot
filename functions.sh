#!/bin/bash
source ./helpers.sh


: '

search_main()
this function searches in a file for a list of records that
encludes the string   
prompt for a string and store it in a variable 
loop through the file and search for given string 
    if found
    print line 
    else
    show "failed search"
    write to log 
    go back to menu
 '

search_main(){
# input_file
sort records.txt > sorted_file.db
read -p "search for record : " str
flag=0
while IFS=' ' read line; do
   if grep -q $str <<< $line; then
        echo $line >> find.txt
        flag=1
   fi

   
done < sorted_file.db

rm sorted_file.db

update_log "search"

}

delete_record(){
search_main
file_to_array
read -p "enter number of records: " requested_amount
select opt in "${options[@]}"
do
  if [ "$opt" ];then
       #seperate record name and amount of records 
       local name=$(echo $opt | cut -d "," -f 1)
       local old_amount=$(echo $opt | cut -d "," -f 2)
       if [[ $requested_amount -gt $old_amount  ]];then
            echo "the number of records to substruct is bigger then the actual number of records"
            flag=0
       elif [[ $requested_amount -eq $old_amount ]];then
         sed -i "/$name/d" records.txt
         echo "the record was deleted since the amount is 0"
         flag=1
       else
            new_amount=$((old_amount-requested_amount))
            #replace the old amount with the new amount
            sed -i "s/$name,$old_amount/$name,$new_amount/g" records.txt
            echo "the record was updated"
            flag=1            
       fi
       break
  fi
done
update_log "Delete"
echo -n > find.txt
} 



add_record(){
search_main
file_to_array
is_file_empty
read -p "enter number of records: " requested_amount
select opt in "${options[@]}"
do
if [ "$opt" ];then
       #seperate record name and amount of records 
       local name=$(echo $opt | cut -d "," -f 1)
       local old_amount=$(echo $opt | cut -d "," -f 2)
       new_amount=$((old_amount+requested_amount))
       #replace the old amount with the new amount
       sed -i "s/$name,$old_amount/$name,$new_amount/g" records.txt
       echo "the record was updated"
       echo $name 

fi
break
done
update_log "Insert"
echo -n > find.txt   
}

update_name(){
search_main
file_to_array
select opt in "${options[@]}"
do
if [ "$opt" ];then
       #seperate record name and amount of records 
       local name=$(echo $opt | cut -d "," -f 1)
       local old_amount=$(echo $opt | cut -d "," -f 2)
       read -p "enter the new name of the record: " new_name
       sed -i "s/$name,$old_amount/$new_name,$old_amount/g" records.txt
       echo "the record was updated"

fi
break
done
update_log "updateName"
echo -n > find.txt  
}

update_quantity(){
search_main
file_to_array
select opt in "${options[@]}"
do
if [ "$opt" ];then
       #seperate record name and amount of records 
       local name=$(echo $opt | cut -d "," -f 1)
       local old_amount=$(echo $opt | cut -d "," -f 2)
       read -p "enter number of records: " requested_amount 
       if [[ requested_amount -lt 1 ]];then
          echo "the amount should be equal or greater then 1"
          break
       fi
       sed -i "s/$name,$old_amount/$name,$requested_amount/g" records.txt
       echo "the record was updated"

fi
break
done
update_log "updateAmount"
echo -n > find.txt
}

display_total_quantity(){
if ! [[ -s records.txt ]];then
     echo "the file of records is empty"
     flag=0
     return
fi
while IFS= read -r line; do
    amount_per_line=$(echo $line | cut -d "," -f 2)
    sum=$((sum+amount_per_line))
done < records.txt
if [[ $sum -gt 0  ]];then
     echo "sum of records is: $sum"
     flag=1
else
     echo "sum is less or equal to 0"
     flag=0
fi

update_log PrintAmount 
}
display_records(){
if ! [[ -s records.txt ]];then
     echo "the file of records is empty"
     return    
fi
sort records.txt > sorted.txt
while IFS= read -r line; do
    echo $line
done < sorted.txt
flag=1
update_log PrintAll
}



#delete_record
#add_record
#update_name
#update_quantity
#display_total_quantity
display_records