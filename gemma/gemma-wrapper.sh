#!/bin/bash


dataset=$1
dataset_dir=./input/dataset_$dataset/
names=$(cat $dataset_dir/fam-col-order.txt)
type=$(find $dataset_dir -name "*.bed" -type f -exec basename {} \; | head -1 | sed 's/.bed//')
i=1
out_dir=Dataset_${dataset}-$type

mkdir -p ./output
mkdir -p ./output/$out_dir

if [ ! -f output/$type.cXX.txt ]; then
    ./gemma -bfile $dataset_dir/$type -gk 1 -o $type
fi

for name in $names; do
	dir_prefix=$out_dir/$name
	mkdir -p ./output/$dir_prefix
	./gemma -bfile $dataset_dir/$type -k output/$type.cXX.txt -lmm 4 -o $dir_prefix/$name-lmm.c -n $i
	i=$((i + 1))
done