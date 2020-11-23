#! /bin/bash

stop_gitlab_service(){
   result=$(sudo gitlab-ctl stop unicorn && sudo gitlab-ctl stop sidekiq && sudo gitlab-ctl stop nginx)
   if [[ $result =~ "down" ]]
   then
    echo "stopped service"
    return 0
   else
    echo "failed to stop service"
    return 1
   fi
}


backup_data(){
    sudo gitlab-rake gitlab:backup:create
    result=$(echo $?)
    if [[ $result == 0 ]]
    then
     echo "complete backup data"
     return 0
    else
     echo "failed to complete backup data"
     return 1
   fi
}

upgrade_gitlab(){
    result=$(sudo rpm -Uvh $1)
    echo "-------"
    echo $result
    echo "-------"
    if [[ $result =~ "Upgrade complete" ]]
   then
    echo "complete upgrade"
    return 0
   else
    echo "failed to complete upgrade"
    return 1
   fi
    
}

package_list=("gitlab-ce-9.5.10-ce.0.el7.x86_64.rpm" "gitlab-ce-10.8.7-ce.0.el7.x86_64.rpm" "gitlab-ce-11.11.8-ce.0.el7.x86_64.rpm" "gitlab-ce-12.0.12-ce.0.el7.x86_64.rpm" "gitlab-ce-12.2.5-ce.0.el7.x86_64.rpm")
for val in ${package_list[@]}; do
   sudo chmod 777 /data/$val
   stop_gitlab_service
   echo "stop_gitlab_service result $?"
   sleep 60
   backup_data
   echo "backup_data result $?"
   sleep 60
   upgrade_gitlab /data/$val
   echo "upgrade_gitlab result $?"
   sleep 60
   sudo gitlab-ctl reconfigure
   sleep 60
   sudo gitlab-rake gitlab:check SANITIZE=true
   sleep 60
   sudo gitlab-ctl restart
   sleep 120
   sudo sudo gitlab-ctl status
   sleep 120
   sudo cat /opt/gitlab/embedded/service/gitlab-rails/VERSION
done
