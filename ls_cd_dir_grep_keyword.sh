#! /bin/bash

array=($(ls -rt /data/jenkins/jobs/))
for val in ${array[@]}; do
   cd /data/jenkins/jobs/$val
   grep -irn "xxx.sh" ./config.xml
   echo $val
done
