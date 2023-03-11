#!/bin/bash
tag=$(sed -n '19p' dep.yml | awk -F '"' '{print $2}' | awk -F ':' '{print $2}')
sed -i "19 s/$tag/$1/g" dep.yml
