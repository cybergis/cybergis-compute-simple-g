#!/bin/bash
# AUTHOR: Alexander Michels
# Checks for user input and if not, copies our default files to the location.
# We then read in all of the provided CMF files and run the simple-g model for each.
DATA_FOLDER=$data_folder
CONFIG_FOLDER=$executable_folder/configs
mkdir -p $CONFIG_FOLDER
[ -f $DATA_FOLDER ] && cp -r $DATA_FOLDER/* $CONFIG_FOLDER/

cd $CONFIG_FOLDER
# check for user-provided CMF files
cmf_files_array=($(find . -name "*.cmf" -print0 | xargs -0))
if [[ ${#cmf_files_array[@]} -eq 0 ]]; then
  echo "No CMF file found in ${CONFIG_FOLDER}, copying default..."
  cp /job/executable/config/cmf/sgmc3_t150_r3g3c3.cmf ${CONFIG_FOLDER}/
  cmf_files_array=($(find . -name "*.cmf" -print0 | xargs -0))
else
  echo "Will analyze  ${#cmf_files_array[@]} CMF files: ${cmf_files_array[@]}..."
fi

# check for user-provided HAR files
har_files_array=($(find . -name "*.har" -print0 | xargs -0))
if [[ ${#har_files_array[@]} -eq 0 ]]; then
  echo "No HAR file found in ${CONFIG_FOLDER}, copying default..."
  cp /job/executable/config/har/config_r3g3c3.har ${CONFIG_FOLDER}/
  har_files_array=($(find . -name "*.har" -print0 | xargs -0))
else
  echo "Will analyze ${#har_files_array[@]} HAR files: ${har_files_array[@]}..."
fi  

# show the contents of config folder for debugging
echo "Contents of the config folder:"
ls $CONFIG_FOLDER

# before we execute need to be in the directory with the input files
echo "Changing directories and running SIMPLE-G"
cd /simple-g/
for CMF_FILE in "${cmf_files_array[@]}"; do
  echo "Running ${CMF_FILE}..."
  /simpleg/bin/sgmc3_2504/simpleg.exe -cmf $CONFIG_FOLDER/$CMF_FILE
done
