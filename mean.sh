#!/bin/bash
if [ $# -lt 1 ]; then
    echo "usage: ./mean.sh <column> [file.csv]" >&2
    exit 1
fi

column=$1

if [ $# -ge 2 ]; then
    file=$2
else
    file=/dev/stdin
fi

cut -d ',' -f "$column" "$file" | tail -n +2 |
{
    sum=0
    count=0

    while read value; do
        sum=$(echo "$sum + $value" | bc -l)
        count=$((count + 1))
    done

    if [ "$count" -gt 0 ]; then
        echo "scale=6; $sum / $count" | bc -l
    fi
}
