#!/bin/bash

mkdir five

for i in {1..5}; do
    mkdir five/dir$i

    for j in {1..4}; do
        > five/dir$i/file$j

        k=1
        while [[ $k -le $j ]]; do
            echo "$j" >> five/dir$i/file$j
            k=$((k+1))
        done
    done
done

