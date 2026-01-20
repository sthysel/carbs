#!/bin/sh

# flash iso to flash drive

infile=$1
disk=$2

if [ -z "${infile}" ]
then
    echo "Set the input iso"
    exit
fi

if [ -z "${disk}" ]
then
    echo "Set disk path"
    exit
fi

dd if="${infile}" of="${disk}" bs=4M status=progress conv=fsync
