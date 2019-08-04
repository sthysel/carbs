#!/usr/bin/env sh

target=${1:-localhost}

ansible-playbook -v -i $target, site.yml -K
