##Calibrazione al RUN2

Ti fai la ricettina per fare il draw di nPV e ti fai gli istogrammi
e metti pileupHist, pileupHist per data e MC
Poi, 

```
./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep0.dat --saveRootMacro
```
e in tmp/ ti ritrovi dei trees da spostare in data/puTree/ per esempio li aggiungi al dat file 

lascia pileupHist per i dati e per il MC metti il root file

2)
parti da un certo runRangeLimits.dat che serve a identificare i punti di interesse

ti scrivi i tuoi punti di interesse con

./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --runDivide --noPU (ti conviene passare da script)

rm -r test/MC/allRange_DYJets_madgraph-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD.root_DYJets_amctnlo-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD.root/
rm -r test/dato/miniAOD_November2015/

./script/energyScale.sh --step=1 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass_SC_corr --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat

./script/energyScale.sh --step=1 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass_SC_corr --runRangesFile=data/runRanges/giuseppe-interval_100000.dat

[INFO] What you did in step1 is:

******************************************************************************
	./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile data/regions/scaleStep1.dat  --runRangesFile data/runRanges/monitoringRun2015-25ns-interval_50000.dat  	     --updateOnly --fit_type_value=1 --selection=loose  --invMass_var invMass --commonCut Et_20-noPF 	    --outDirFitResMC=test/MC/allRange_DYJets_madgraph-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD_DYJets_amctnlo-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD/pufileData_tot/loose/invMass/fitres --outDirFitResData=test/dato/miniAOD_November2015/loose/invMass/fitres 	    --outDirImgMC=test/MC/allRange_DYJets_madgraph-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD_DYJets_amctnlo-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD/pufileData_tot/loose/invMass/img    --outDirImgData=test/dato/miniAOD_November2015/loose/invMass/img 	    > test/dato/miniAOD_November2015/loose/invMass/log/step1-invMass-loose-Et_20-noPF-HggRunEta.log || exit 1
	
	./script/makeTable.sh --regionsFile data/regions/scaleStep1.dat  --runRangesFile data/runRanges/monitoringRun2015-25ns-interval_50000.dat --commonCut Et_20-noPF 	    --outDirFitResMC=test/MC/allRange_DYJets_madgraph-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD_DYJets_amctnlo-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD/pufileData_tot/loose/invMass/fitres --outDirFitResData=test/dato/miniAOD_November2015/loose/invMass/fitres 	    >  test/dato/miniAOD_November2015/loose/invMass/table/step1-invMass-loose-Et_20-noPF-HggRunEta.tex
	
	./script/tex2txt.sh test/dato/miniAOD_November2015/loose/invMass/table/step1-invMass-loose-Et_20-noPF-HggRunEta.tex | awk -F t -f awk/recalibOutput.awk |grep -v '^%' > test/dato/miniAOD_November2015/loose/invMass/table/step1-invMass-loose-Et_20-noPF-HggRunEta.dat
	
	#save root files with step1 corrections
	./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile data/regions/scaleStep1.dat   	    --saveRootMacro --corrEleType HggRunEta 	    --corrEleFile test/dato/miniAOD_November2015/loose/invMass/table/step1-invMass-loose-Et_20-noPF-HggRunEta.dat || exit 1
	
	mv tmp/scaleEle_HggRunEta_[s,d][1-9]-miniAOD_November2015.root test/dato/miniAOD_November2015/loose/invMass/step1/
******************************************************************************
Il MC dello step 1 viene salvato qui:
```
test/MC/allRange_DYJets_madgraph-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD_DYJets_amctnlo-RunIISpring15MiniAODv2-Asym25ns-miniAOD-allRange-miniAOD/pufileData_tot/loose/invMass_SC_corr/img/
```

I dati fittati con la coda del MC vengono salvati qui:
```
test/dato/miniAOD_November2015/loose/invMass_SC_corr/img/
```
./bin/ZFitter.exe -f ~gfasanel/public/4shervin/miniAOD_November2015.dat --regionsFile data/regions/scaleStep1.dat   	    --saveRootMacro --corrEleType HggRunEta 	    --corrEleFile ~gfasanel/public/4shervin/step1-invMass-loose-Et_20-noPF-HggRunEta.dat 

./script/energyScale.sh --step=1stability -f data/validation/miniAOD_November2015.dat --invMass_var=invMass_SC_corr --runRangesFile=data/runRanges/giuseppe-interval_100000.dat

Che chi sa cosa fa (dopo aver scritto una latex table)
./script/stability.sh -t  test/dato/miniAOD_November2015/loose/invMass_SC_corr/table/step1_stability-invMass_SC_corr-loose.tex --outDirImgData test/dato/miniAOD_November2015/loose/invMass_SC_corr/step1/img/stability// -x runNumber -y peak --allRegions

./script/stability.sh -t  test/dato/miniAOD_November2015/loose/invMass_SC_corr/table/step1-invMass_SC_corr-loose-Et_20-noPF-HggRunEta.tex -invMass_SC_corr-loose.tex --outDirImgData test/dato/miniAOD_November2015/loose/invMass_SC_corr/step1/img/stability// -x runNumber -y peak --allRegions
