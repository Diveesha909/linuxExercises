#!/bin/bash

cat Property_Tax_Roll.csv |
grep "MADISON SCHOOLS" |
cut -d ',' -f 7 |
{
    sum=0
    count=0

    while IFS= read -r value || [[ -n $value ]]; do
        sum=$(awk -v s="$sum" -v x="$value" 'BEGIN { printf "%.15g", s + x }')
        count=$((count + 1))
    done

    if [[ $count -eq 0 ]]; then
        echo "No matching data to average." 1>&2
        exit 1
    fi

    mean=$(awk -v s="$sum" -v n="$count" 'BEGIN { printf "%.10g", s / n }')
    echo "$mean"
}
