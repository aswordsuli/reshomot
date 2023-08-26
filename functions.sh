#!/bin/bash
source ./helpers.sh

: '

search_main(){
input_file 
   if [[ -f $file ]]; then 

      sort $file > sorted_file.db
      read -p "search for string : " str
      flag=0
      counter=1
      
      while IFS=' ' read line ; do
         if grep -q $str <<< $line; then
            echo "$line " 
            flag=1
        
         fi

   
      done < sorted_file.db
   else  main 
   fi 

rm sorted_file.db

update_log

}
'
#search_main 

: '

update_name(){
searcher

read -p "Enter a string to replace: " replacement

rec_name=$(echo "$selected_line" | cut -d ',' -f 1)
sed -i "s/$rec_name/$replacement/g" "$file"
update_log 'update_name' "$replacement"
}


update_quantity(){
 searcher

read -p "Enter a string to replace: " replacement

rec_name=$(echo "$selected_line" | cut -d ',' -f 1)
sed -i "s/$rec_name,[0-9]*/$rec_name,$replacement/g" $file

update_log 'update_quantity' "$replacement"

}
'
#update_quantity