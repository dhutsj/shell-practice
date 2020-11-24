#! /bin/bash

array=($(ls -rt /data/jenkins/workspace/))
# echo ${#array[@]}
# for val in ${array[@]}; do
#   echo $val
# done

array_length=${#array[@]}
for i in $(seq 1 $array_length)
do
   if [[ $i == 1 ]]
   then
     string=$(echo ${array[i]} | cut -d "." -f 1)
     echo $string
     sed -i "s#old#$string#g" aaa.py
     python aaa.py -e http://elk.com:9200
   else
     previous_string=$(echo ${array[i-1]} | cut -d "." -f 1)
     # echo $previous_string
     string=$(echo ${array[i]} | cut -d "." -f 1)
     echo $string
     sed -i "s#$previous_string#$string#g" aaa.py
     python aaa.py -e http://elk.com:9200
   fi 
done
