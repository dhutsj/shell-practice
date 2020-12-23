#! /bin/bash

array=($(ls -rt /data/jenkins/jobs/))
for val in ${array[@]}; do
    if [ -d /data/jenkins/jobs/$val ]; then
        cd /data/jenkins/jobs/$val
        grep -irn "xxx.py" ./config.xml
        if [ $? == 0 ]; then
            echo $val
        fi
    fi
done

