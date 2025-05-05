#!/bin/sh
CURR_CMF_PATH="/simple-g/"
TMP_LOCATION="./tmp"
# export result_folder="/anvil/projects/x-ees220011/Iman/SIMPLEG_cyberGIS/output/"
echo $result_folder

mkdir -p $TMP_LOCATION/cmf/

readarray -t cmf_files < /simple-g/cmf_list.txt
touch $TMP_LOCATION/cmf_list.txt

# do the weird double // thing to the path
CMF_OUT_PATH=$(sed 's#/#//#g' <<<"$result_folder")
echo "Writing to ${CMF_OUT_PATH}..."

# need to account for full path to the cmf_file later
for cmf_file in "${cmf_files[@]}"; do
  echo $cmf_file
  cp "${CURR_CMF_PATH}/${cmf_file}" "${TMP_LOCATION}/${cmf_file}"
  sed -i "s#//anvil//scratch//x-ihaqiqi//sgm//out//#$CMF_OUT_PATH#g" tmp/$cmf_file
  echo "${TMP_LOCATION}/${cmf_file}" >> "${TMP_LOCATION}/cmf_list.txt"
done
