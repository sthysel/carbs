#!/usr/bin/env bash
set -e

HERE=$(cd $(dirname $0) && pwd) 

echo "Installing from "$HERE


for file in "${HERE}"/*
do
     name="$(basename "$file" .md)"
     echo $name
done

