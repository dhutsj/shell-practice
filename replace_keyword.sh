#! /bin/bash

array=($(ls /data/jenkins/workspace/xxx/xxx*))
array_length=${#array[@]}
for i in $(seq 1 $array_length)
do
     current_string=$(ls ${array[i]} | grep -Eo "[0-9]{8}")
     previous_string=$(ls ${array[i-1]} | grep -Eo "[0-9]{8}")
     sed -i "s#$previous_string#$current_string#g" xxx.py
     python xxx.py -e http://elk.com:9200
done
