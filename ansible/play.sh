#!/usr/bin/env sh

target=${1:-localhost}

ansible-playbook -i $target, carbs.yml -K 
