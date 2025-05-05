#!/bin/bash
export TMP_LOCATION="./tmp"
export CMF_LIST="${TMP_LOCATION}/cmf_list.txt"
export CMF_FILE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $CMF_LIST)
/simpleg/bin/sgmc3_2504/simpleg.exe -cmf $CMF_FILE