#!/bin/bash
#convert input word to lowercase, replace ё with e
word=$(echo $1  | sed -e 's/\(.*\)/\L\1/' | sed -s 's/ё/е/g');
vowels='аеиоуыэюя';
RV=$(echo $word | sed -r 's/^[^аеиоуыэюя]*.(.*)/\1/');
R1=$(echo $word | sed -r 's/^[^аеиоуыэюя]*[аеиоуыэюя]*[^аеиоуыэюя](.*)/\1/');
R2=$(echo $R1 | sed -r 's/^[^аеиоуыэюя]*[аеиоуыэюя]*[^аеиоуыэюя](.*)/\1/');
echo $RV;
echo $R1;
echo $R2;
