Step2
start fresh (vedi cosa devi rimuovere per fargli fare questo step)

./script/MYenergyScale.sh --step=2 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat

++++++++++
Categorizza e scrive il giusto file con le categorizzazioni:
./script/energyScale.sh --step=2 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass_SC_corr --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat


++++++++++++++++++BASTA, MI SONO ROTTO I COGLIONI; STEP2 a modo mio

file=miniAOD_November2015
region1=scaleStep2smearing_1
region2=scaleStep2smearing_2

./bin/ZFitter.exe -f data/validation/${file}.dat --regionsFile=data/regions/scaleStep2smearing_1.dat --addBranch=smearerCat invMass_var=invMass_SC_corr --saveRootMacro
mv tmp/smearerCat_scaleStep2* friends/smearerCat/
region1=scaleStep2smearing_1
echo "s1      smearerCat_${region1}     friends/smearerCat/smearerCat_${region1}_s1-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "s2      smearerCat_${region1}     friends/smearerCat/smearerCat_${region1}_s2-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d1      smearerCat_${region1}     friends/smearerCat/smearerCat_${region1}_d1-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d2      smearerCat_${region1}     friends/smearerCat/smearerCat_${region1}_d2-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d3      smearerCat_${region1}     friends/smearerCat/smearerCat_${region1}_d3-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat

./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep2smearing_2.dat --addBranch=smearerCat invMass_var=invMass_SC_corr --saveRootMacro
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

scrive i numeretti
./script/energyScale.sh --step=2 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat
emacs tmp/res_corr.dat 
emacs tmp/res_corr_constTerm.dat

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

root -l -b 
.L macro/plot_data_mc.C+ 
PlotMeanHist("test/dato/miniAOD_November2015/loose/invMass_SC_corr/step2/1/fitres/histos-scaleStep2smearing_2-Et_20-noPF.root")
.q
cp test/dato/miniAOD_November2015/loose/invMass_SC_corr/step2/1/./img/histos*.png ~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_Z/histos_data_MC_corr_2/



#Fittare un solo profilo
root -l -b
.L macro/fitOneProfile.C
fitOneProfile("test/dato/miniAOD_November2015/loose/invMass/step2/2/fitres/outProfile-scaleStep2smearing_1-Et_20-noPF.root","~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_Z/")

./script/fit.sh test/dato/miniAOD_November2015/loose/invMass/step2/2/fitres/outProfile-scaleStep2smearing_1-Et_20-noPF
cp test/dato/miniAOD_November2015/loose/invMass/step2/2/img/outProfile*.png ~/scratch1/www/Temp
