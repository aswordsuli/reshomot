
#this function asks the user to enter file name 
#if file exist then it returns file name 
#if file not exist then the function return error message and recursevly call itself again
: '
xfile(){
    if [[ -e $1 ]]; then
    continue
    else 
    touch $1
    main
    fi
}    
'
input_file() {
    read -p "Enter file name: " file
    if [ -f "$file" ]; then
        echo "$file"
    else
        echo "file not found."
        main
    fi
}


update_log(){
    f=$(echo "$file" | cut -d '.' -f 1)
    formatted_date=$(date +'%d/%m/%Y %H:%M:%S')
    if [[ $flag -ge 1 ]]; then
        echo "$formatted_date  success $1 $2 " >> "records"$f"_log.txt"   
    
    else 
        
        echo "$formatted_date" failed $1 $2 >> "records"$f"_log.txt" 
    fi
}


searcher(){

    #input_file
    sort $file > sorted_file.db
    read -p "search for string : " str
    flag=0
    counter=0
   
    while IFS=' ' read line; do
        if grep -q $str <<< $line ; then
            ((counter++))
            flag=1
            echo "$counter : $line " >> tmpnfile.txt
            echo $line >> tmpfile.txt
       
            
        fi
       
    done < sorted_file.db

    if [[ $counter -eq 0 ]]; then 
        echo "no records found"
        rm sorted_file.db
        main
    elif [[ $counter -eq 1 ]]; then 
        selected_line=$(sed -n '1p' tmpfile.txt)
        echo $selected_line 
    else 
        cat tmpnfile.txt
        read -p "pick by number record you want to modify " pick
           selected_line=$(sed -n "${pick}p" tmpfile.txt)
           # echo $selected_line
            rm sorted_file.db
            rm tmpfile.txt
            rm tmpnfile.txt
    fi

}
#searcher

