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
read -p "search for string : " str
flag=0
while IFS=' ' read line; do
   if grep -q $str <<< $line; then
        echo $line | tee -a find.txt
        flag=1
   fi

   
done < sorted_file.db

rm sorted_file.db

update_log "search"

}

delete_record(){
search_main
#convert find.txt file to array
options=()
while IFS= read -r option; do
    options+=("$option")
done < find.txt
read -p "enter number of records: " substruct_amount
select opt in "${options[@]}"
do
  if [ "$opt" ];then
       #seperate record name and amount of records 
       local name=$(echo $opt | cut -d "," -f 1)
       local old_amount=$(echo $opt | cut -d "," -f 2)
       if [[ $substruct_amount -gt $old_amount  ]];then
            echo "the number of records to substruct is bigger then the actual number of records"
            flag=0
       elif [[ $substruct_amount -eq $old_amount ]];then
         sed -i "/$name/d" records.txt
         echo "the record was deleted since the amount is 0"
         flag=1
       else
            new_amount=$((old_amount-substruct_amount))
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
delete_record
