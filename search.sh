#!/bin/bash
source ./funcs.sh


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

update_log

}

search_main 