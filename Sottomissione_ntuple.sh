#!/bin/bash
json=/afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions15/13TeV/Cert_246908-260627_13TeV_PromptReco_Collisions15_25ns_JSON_Silver.txt
jsonName=246908-260627-Prompt_25ns-v1-golden_silver

datasets=`parseDatasetFile.sh alcareco_datasets.dat |grep 'MINIAOD\b'`
datasetsMC=`parseDatasetFile.sh alcareco_datasets.dat |grep 'MINIAODSIM\b' | grep -v highMass`
# set IFS to newline in order to divide using new line the datasets
IFS=$'\n'

CHECK=--check

for dataset in $datasets
  do
        echo $dataset
#       ./scripts/prodNtuples.sh  --type=MINIAOD --json=$json --json_name=$jsonName  -t config/reRecoTags/74X_dataRun2_Prompt_v4.py $CHECK  $dataset done



for dataset in $datasetsMC
  do
#       echo $dataset
        ./scripts/prodNtuples.sh  --type=MINIAOD --isMC  -t config/reRecoTags/74X_mcRun2_asymptotic_v2.py $CHECK $dataset done

