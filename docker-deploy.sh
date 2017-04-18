#!/bin/bash
## docker-deploy.sh /opt/paas/T-CLOUD/horizon/target/horizon.war tcloud v0.0.1 192.168.4.55:5000

deploy_war=$1
deploy_name=$2
deploy_version=$3
docker_registry="192.168.4.55:5000"
cd /opt/docker/T-CLOUD/
cp $deploy_war /opt/docker/T-CLOUD/
deploy_filename=echo "$deploy_war" | awk -F '/' '{print $NF}'
sed -i 's/Deploy.war/$deploy_filename/1' Dockerfile

docker build -t $docker_registry/deploy_name:deploy_version .
docker push $docker_registry/deploy_name:deploy_version
