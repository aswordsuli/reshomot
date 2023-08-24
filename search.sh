#!/bin/bash

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
sort $1 > sorted_file.db
read -p "search for string : " str
flag=0
while IFS=' ' read line; do
   if grep -q $str <<< $line; then
        echo $line 
        flag=1
   fi

   
done < sorted_file.db

rm sorted_file.db




#Update log file 
 formatted_date=$(date +'%d/%m/%Y %H:%M:%S')
if [[ $flag -eq 1 ]]; then
    echo "$formatted_date search success " >> logfile.txt   
else 
    echo "failed search"
    echo "$formatted_date search failed " >> logfile.txt  
fi

}