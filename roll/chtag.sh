#!/bin/bash
tag=$(sed -n '19p' /var/lib/jenkins/workspace/EKS-rollback/roll/dep.yml | awk -F '"' '{print $2}' | awk -F ':' '{print $2}')
sed -i "19 s/$tag/$1/g" /var/lib/jenkins/workspace/EKS-rollback/roll/dep.yml
