[INFO] What you did in step1 is:
```
#Fai i fit
	./bin/ZFitter.exe -f validation_file --regionsFile data/regions/scaleStep1.dat  --runRangesFile xx  	     --updateOnly --fit_type_value=1 --selection=loose  --invMass_var invMassYY --commonCut Et_20-noPF 	    --outDirFitResMC=test/MC/**/fitres --outDirFitResData=test/dato/*/fitres 	    

#Fai il tex dei risultati	
	./script/makeTable.sh --regionsFile data/regions/scaleStep1.dat  --runRangesFile xx --commonCut Et_20-noPF 	    --outDirFitResMC=test/MC/*/fitres --outDirFitResData=test/dato/*/fitres 	    >  test/dato/*/table/step1-*-Et_20-noPF-HggRunEta.tex

#Fai il dat file dei risultati	
	./script/tex2txt.sh test/dato/*/table/step1-invMass-loose-Et_20-noPF-HggRunEta.tex | awk -F t -f awk/recalibOutput.awk |grep -v '^%' > test/dato/miniAOD_November2015/loose/invMass/table/step1-invMass-loose-Et_20-noPF-HggRunEta.dat
	
#save root files with step1 corrections
./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile data/regions/scaleStep1.dat   	    --saveRootMacro --corrEleType HggRunEta --corrEleFile test/dato/miniAOD_November2015/loose/invMass/table/step1-invMass-loose-Et_20-noPF-HggRunEta.dat

#Metti i root file delle correzioni in luogo sicuro
mv tmp/scaleEle_HggRunEta_[s,d][1-9]-miniAOD_November2015.root test/dato/*/step1/
```

**Step1 Stability**

```
xVar=runNumber

./script/stability.sh -t  ${outDirTable}/step1_stability-${invMass_var}-${selection}.tex \
        --outDirImgData ${outDirData}/step1/img/stability/$xVar/ -x $xVar -y peak
        
./script/stability.sh -t  ${outDirTable}/step1_stability-${invMass_var}-${selection}.tex \
        --outDirImgData ${outDirData}/step1/img/stability/$xVar/ -x $xVar -y scaledWidth
        
./script/stability.sh -t  ${outDirTable}/step1_stability-${invMass_var}-${selection}.tex \
        --outDirImgData ${outDirData}/step1/img/stability/$xVar/ -x $xVar -y peak --allRegions
```

```
    xVar=runNumber
    if [ ! -d ${outDirData}/step1/img/stability/before_run_corr/$xVar ];then
        mkdir -p ${outDirData}/step1/img/stability/before_run_corr/$xVar
    fi

    ./script/stability.sh -t  ${outDirTable}/step1-${invMass_var}-${selection}-${commonCut}-HggRunEta.tex \
        --outDirImgData ${outDirData}/step1/img/stability/before_run_corr/$xVar/ -x $xVar -y peak || exit 1
    ./script/stability.sh -t  ${outDirTable}/step1-${invMass_var}-${selection}-${commonCut}-HggRunEta.tex \
        --outDirImgData ${outDirData}/step1/img/stability/before_run_corr/$xVar/ -x $xVar -y scaledWidth || exit 1
    ./script/stability.sh -t  ${outDirTable}/step1-${invMass_var}-${selection}-${commonCut}-HggRunEta.tex \
        --outDirImgData ${outDirData}/step1/img/stability/before_run_corr/$xVar/ -x $xVar -y peak --allRegions || exit 1
    ./script/stability.sh -t  ${outDirTable}/step1-${invMass_var}-${selection}-${commonCut}-HggRunEta.tex \
	--outDirImgData ${outDirData}/step1/img/stability/before_run_corr/$xVar/ -x $xVar -y scaledWidth --allRegions || exit 1

echo "Initial scale vs run plots in ${outDirData}/step1/img/stability/before_run_corr/$xVar/"

##What you have after corr, i.e. now, at the end of step1stability                                                                                                              
    xVar=runNumber
    if [ ! -d ${outDirData}/step1/img/stability/$xVar ];then
        mkdir -p ${outDirData}/step1/img/stability/$xVar
    fi

    ./script/stability.sh -t  ${outDirTable}/step1_stability-${invMass_var}-${selection}.tex \
        --outDirImgData ${outDirData}/step1/img/stability/$xVar/ -x $xVar -y peak || exit 1
    ./script/stability.sh -t  ${outDirTable}/step1_stability-${invMass_var}-${selection}.tex \
        --outDirImgData ${outDirData}/step1/img/stability/$xVar/ -x $xVar -y scaledWidth || exit 1
    ./script/stability.sh -t  ${outDirTable}/step1_stability-${invMass_var}-${selection}.tex \
        --outDirImgData ${outDirData}/step1/img/stability/$xVar/ -x $xVar -y peak --allRegions || exit 1
    ./script/stability.sh -t  ${outDirTable}/step1_stability-${invMass_var}-${selection}.tex \
        --outDirImgData ${outDirData}/step1/img/stability/$xVar/ -x $xVar -y scaledWidth --allRegions || exit 1

```

