

./script/energyScale.sh --step=1 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat

[INFO] What you did in step1 is:

******************************************************************************
	./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile data/regions/scaleStep1.dat  --runRangesFile data/runRanges/monitoringRun2015-25ns-interval_50000.dat  	     --updateOnly --fit_type_value=1 --selection=loose  --invMass_var invMass --commonCut Et_20-noPF 	    --outDirFitResMC=test/MC/allRange_DYJets_madgraph-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD_DYJets_amctnlo-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD/pufileData_tot/loose/invMass/fitres --outDirFitResData=test/dato/miniAOD_November2015/loose/invMass/fitres 	    --outDirImgMC=test/MC/allRange_DYJets_madgraph-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD_DYJets_amctnlo-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD/pufileData_tot/loose/invMass/img    --outDirImgData=test/dato/miniAOD_November2015/loose/invMass/img 	    > test/dato/miniAOD_November2015/loose/invMass/log/step1-invMass-loose-Et_20-noPF-HggRunEta.log || exit 1
	
	./script/makeTable.sh --regionsFile data/regions/scaleStep1.dat  --runRangesFile data/runRanges/monitoringRun2015-25ns-interval_50000.dat --commonCut Et_20-noPF 	    --outDirFitResMC=test/MC/allRange_DYJets_madgraph-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD_DYJets_amctnlo-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD/pufileData_tot/loose/invMass/fitres --outDirFitResData=test/dato/miniAOD_November2015/loose/invMass/fitres 	    >  test/dato/miniAOD_November2015/loose/invMass/table/step1-invMass-loose-Et_20-noPF-HggRunEta.tex
	
	./script/tex2txt.sh test/dato/miniAOD_November2015/loose/invMass/table/step1-invMass-loose-Et_20-noPF-HggRunEta.tex | awk -F t -f awk/recalibOutput.awk |grep -v '^%' > test/dato/miniAOD_November2015/loose/invMass/table/step1-invMass-loose-Et_20-noPF-HggRunEta.dat
	
	#save root files with step1 corrections
	./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile data/regions/scaleStep1.dat   	    --saveRootMacro --corrEleType HggRunEta 	    --corrEleFile test/dato/miniAOD_November2015/loose/invMass/table/step1-invMass-loose-Et_20-noPF-HggRunEta.dat || exit 1
	
	mv tmp/scaleEle_HggRunEta_[s,d][1-9]-miniAOD_November2015.root test/dato/miniAOD_November2015/loose/invMass/step1/
******************************************************************************
e questo sarebbe lo step di stability

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




./bin/ZFitter.exe -f ~gfasanel/public/4shervin/miniAOD_November2015.dat --regionsFile data/regions/scaleStep1.dat   	    --saveRootMacro --corrEleType HggRunEta 	    --corrEleFile ~gfasanel/public/4shervin/step1-invMass-loose-Et_20-noPF-HggRunEta.dat 


start fresh
leva i signal smearer dal .dat
rm -r test/dato/miniAOD_November2015/loose/invMass/step2/
rm -r test/dato/miniAOD_November2015/loose/invMass/table/outFile-step2-invMass-loose-Et_20-noPF-HggRunEtaR9.dat

./script/MYenergyScale.sh --step=2 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat

++++++++++
Categorizza e scrive il giusto file con le categorizzazioni:
./script/energyScale.sh --step=2 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat


