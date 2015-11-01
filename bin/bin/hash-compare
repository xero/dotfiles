#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "please supply two files to diff"
else
	sum1=$(md5sum $1)
	sum2=$(md5sum $2)

	hash1="${sum1/$1/}"
	hash2="${sum2/$2/}"

	if [ "$hash1" == "$hash2" ]; then
		echo "identical"
	else
		echo "different"
	fi
fi
