#!/bin/bash
for i in {1..3}
do
   echo "insert $(( i + 1 ))"
   sed -i "s#$i.xlsx#$(( i + 1 )).xlsx#g" test.py
   python test.py -e http://elk.com.:9200
done
