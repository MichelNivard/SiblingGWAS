#!/bin/bash

set -e
source ./config

batch_number=${1}
re='^[0-9]+$'

if ! [[ $batch_number =~ $re ]] ; then
	echo "error: Batch variable is not a number"
	echo "Usage: ${0} [batch number]"
	exit 1
fi

j=$(echo "$((batch_number-1))")
k=`printf "%02d" $j`

echo "Running analysis"
#Run analysis on partitioned files

#Convert to .raw
plink \
--bfile /mnt/storage/home/lh14833/Test/input_data/example \
--extract extract${k} \
--recodeA \
--out temp.${i}

#Run regression script in R
Rscript resources/regression/unified_regression.R \
temp.${i}.raw \
extract${k} \
output.${i}

#Remove .raw file
rm temp.${i}*
rm extract${k}
)
done

echo "Completed analysis"
