
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
#Update log file 
 formatted_date=$(date +'%d/%m/%Y %H:%M:%S')
if [[ $flag -eq 1 ]]; then
    echo "$formatted_date search success " >> logfile.txt   
    search_main
else 
    echo "failed search"
    echo "$formatted_date search failed " >> logfile.txt  
fi
}

searcher(){

  input_file
sort $file > sorted_file.db
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

searcher

