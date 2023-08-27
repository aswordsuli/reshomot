
#this function asks the user to enter file name 
#if file exist then it returns file name 
#if file not exist then the function return error message and recursevly call itself again

input_file() {
    read -p "Enter file name: " file
    if [ -f "$file" ]; then
        echo "$file"
    else
        echo "file not found."
        touch "$file"
    fi
}


update_log(){
operation=$1
formatted_date=$(date +'%d/%m/%Y %H:%M:%S')
if [[ $flag -eq 1 && $operation == "PrintAll" ]]; then
    while IFS= read -r line; do
    echo "$formatted_date $operation $line"  >> logfile.txt
done < records.txt
elif [[ $flag -eq 1 && $operation == "PrintAmount" ]]; then
    echo "$formatted_date $operation $sum" >> logfile.txt
elif [[ $flag -eq 1 ]];then
        echo "$formatted_date $operation success" >> logfile.txt
else       
    echo "failed $operation"
    echo "$formatted_date $operation failed " >> logfile.txt  
fi
}

searcher(){

  #input_file
sort records.txt > sorted_file.db
read -p "search for string : " str
flag=0
while IFS=' ' read line; do
   if grep -q $str <<< $line; then
        echo $line >> currfile.txt 
        line_count=$(wc -l < "currfile.txt")
    
        flag=1
   fi

   
done < sorted_file.db

rm sorted_file.db
echo $line_count

}

file_to_array(){
#convert every line in the file to elment in the array  
options=()
while IFS= read -r option; do
    options+=("$option")
done < find.txt
}

is_file_empty(){
#if find.txt is empty add the name of the new record to the end of the file
if ! [[ -s find.txt ]];then
      echo $str,$requested_amount >> records.txt
      echo "the record was updated"
      flag=1
fi


}



