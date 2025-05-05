#!/bin/bash
export TMP_LOCATION="./tmp"
export CMF_LIST="${TMP_LOCATION}/cmf_list.txt"
export CMF_FILE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $CMF_LIST)
echo "Running Simple-G with following CMF_FILE: ${CMF_FILE}..."

/simpleg/bin/sgmc3_2504/simpleg.exe -cmf $CMF_FILE
