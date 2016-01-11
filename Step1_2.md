

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


./bin/ZFitter.exe -f ~gfasanel/public/4shervin/miniAOD_November2015.dat --regionsFile data/regions/scaleStep1.dat   	    --saveRootMacro --corrEleType HggRunEta 	    --corrEleFile ~gfasanel/public/4shervin/step1-invMass-loose-Et_20-noPF-HggRunEta.dat 


start fresh
leva i signal smearer dal .dat
rm -r test/dato/miniAOD_November2015/loose/invMass/step2/
rm -r test/dato/miniAOD_November2015/loose/invMass/table/outFile-step2-invMass-loose-Et_20-noPF-HggRunEtaR9.dat

./script/MYenergyScale.sh --step=2 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat

++++++++++
Categorizza e scrive il giusto file con le categorizzazioni:
./script/energyScale.sh --step=2 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat


++++++++++++++++++BASTA, MI SONO ROTTO I COGLIONI; STEP2 a modo mio

file=miniAOD_November2015
region1=scaleStep2smearing_1
region2=scaleStep2smearing_2

./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep2smearing_1.dat --addBranch=smearerCat invMass_var=invMass --saveRootMacro
mv tmp/smearerCat_scaleStep2* friends/smearerCat/
region1=scaleStep2smearing_1
echo "s1      smearerCat_${region1}     friends/smearerCat/smearerCat_${region1}_s1-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "s2      smearerCat_${region1}     friends/smearerCat/smearerCat_${region1}_s2-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d1      smearerCat_${region1}     friends/smearerCat/smearerCat_${region1}_d1-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d2      smearerCat_${region1}     friends/smearerCat/smearerCat_${region1}_d2-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d3      smearerCat_${region1}     friends/smearerCat/smearerCat_${region1}_d3-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat

./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep2smearing_2.dat --addBranch=smearerCat invMass_var=invMass --saveRootMacro
mv tmp/smearerCat_scaleStep2* friends/smearerCat/
region2=scaleStep2smearing_2 
echo "s1      smearerCat_${region2}     friends/smearerCat/smearerCat_${region2}_s1-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "s2      smearerCat_${region2}     friends/smearerCat/smearerCat_${region2}_s2-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d1      smearerCat_${region2}     friends/smearerCat/smearerCat_${region2}_d1-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d2      smearerCat_${region2}     friends/smearerCat/smearerCat_${region2}_d2-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d3      smearerCat_${region2}     friends/smearerCat/smearerCat_${region2}_d3-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat

controlla che sia tutto a posto
emacs data/validation/miniAOD_November2015.dat

cp test/dato/miniAOD_November2015/loose/invMass/step2/1/fitres/params-scaleStep2smearing_1-Et_20-noPF.txt step2/init_1.txt
cp test/dato/miniAOD_November2015/loose/invMass/step2/1/fitres/params-scaleStep2smearing_2-Et_20-noPF.txt step2/init_2.txt

source cleaner_step2.sh (non mi piace molto)
./submit_step2.sh
./submit_step2_corr.sh

(fa il plot della likelihood media)
./script/MYenergyScale.sh --step=2 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat

./script/MYenergyScale.sh --step=2 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass_SC_corr --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat
cp test/dato/miniAOD_November2015/loose/invMass_SC_corr/step2/img/*.png ~/scratch1/www/RUN2_ECAL_Calibration/Temp_corr/

cp test/dato/miniAOD_November2015/loose/invMass/step2/img/*.png ~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_Z/
cp test/dato/miniAOD_November2015/loose/invMass_SC_corr/step2/img/*.png ~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_Z/


root -l -b 
.L macro/plot_data_mc.C+ 
PlotMeanHist("test/dato/miniAOD_November2015/loose/invMass/step2/2/fitres/histos-scaleStep2smearing_1-Et_20-noPF.root")
.q
cp test/dato/miniAOD_November2015/loose/invMass/step2/2/./img/histos*.png ~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_Z/histos_data_MC/

root -l -b 
.L macro/plot_data_mc.C+ 
PlotMeanHist("test/dato/miniAOD_November2015/loose/invMass_SC_corr/step2/1/fitres/histos-scaleStep2smearing_1-Et_20-noPF.root")
.q
cp test/dato/miniAOD_November2015/loose/invMass_SC_corr/step2/1/./img/histos*.png ~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_Z/histos_data_MC_corr/


Saving corrections (questo per il momento scrive solo le correzioni su un file)
./script/energyScale.sh --step=2 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass_SC_corr --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat

root -l -b 
.L macro/plot_data_mc.C+ 
PlotMeanHist("test/dato/miniAOD_November2015/loose/invMass_SC_corr/step2/1/fitres/histos-scaleStep2smearing_2-Et_20-noPF.root")
.q
cp test/dato/miniAOD_November2015/loose/invMass_SC_corr/step2/1/./img/histos*.png ~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_Z/histos_data_MC_corr_2/
