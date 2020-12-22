#! /bin/bash

docker login -u$User -p$Password docker.com

cd jenkins/
echo $WORKSPACE

echo ${Tag}

array=($(ls -rt base))
for val in ${array[@]}; do
   sed -i "s/IMAGEVERSION/${Tag}/g" $WORKSPACE/jenkins/base/$val
done

podCount=`kubectl get pod -n aaa | grep -E 'bbb-|ccc-|ddd-|' | wc -l`
echo ${podCount}

if [ ${podCount} -gt 1 ]; then
echo "Clean up the current Pod in Namespace aaa..."
kubectl delete -k ./base
sleep 1m
fi

echo "Deploy Pod to Namespace aaa..."
kubectl apply -k ./base --record
docker logout docker.com