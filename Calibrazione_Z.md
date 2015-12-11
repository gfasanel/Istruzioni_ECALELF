### Calibrazione alla Z

* Scriviti un dat file che contenga dati e MC (vedi https://github.com/GiuseppeFasanella/Istruzioni_ECALELF/blob/master/File_partenza.dat)
* Ti fai gli istogrammi del pileup per dati e MC con puMaker.C e puHadder.C (dal branch miniAOD) {Fai i pileupHist, con un draw secco di nPV per dati e MC}
* Aggiungi al dat iniziale ha la lista dei dati, la lista dei MC e i pileUPHist
* Crea i tree del pileup e allo stesso tempo categorizza tramite ZFitter (vedi sotto)

```
##CATEGORIZZAZIONE E PILEUP TREE (LE 8 CATEGORIE ETA-R9 SONO INDIPENDENTI DALLA MASSA)
#file=miniAOD_November2015_Cal_Nov2015_ICcomb_v4 
file=Rereco_emanuele
file=miniAOD_November2015_withPho
region1=scaleStep2smearing_1 
region2=scaleStep2smearing_2 
invMass_type=invMass_SC_corr
./bin/ZFitter.exe -f data/validation/${file}.dat --regionsFile=data/regions/${region1}.dat --addBranch=smearerCat invMass_var=${invMass_type} --saveRootMacro
./bin/ZFitter.exe -f data/validation/${file}.dat --regionsFile=data/regions/${region2}.dat --addBranch=smearerCat invMass_var=${invMass_type} --saveRootMacro
```

Se sta leggendo i pileupHist 

```
********* runMin = 0	pufileMC_tot.root
[STATUS] Reading PU histograms from files: /afs/cern.ch/work/g/gfasanel/CMSSW_7_4_15/src/Calibration/ZFitter/pufileMC_tot.root	/afs/cern.ch/work/g/gfasanel/CMSSW_7_4_15/src/Calibration/ZFitter/pufileData_tot.root
```
Se sta categorizzando

```
[STATUS] Get smearerCat for tree: d1	with 7115179 entries
```
Sposta i file del pileup
```
mv tmp/mcPUtrees1.root  data/puTree/s1_${file}.root
mv tmp/mcPUtrees2.root  data/puTree/s2_${file}.root
echo "s1 pileup data/puTree/s1_${file}.root" >> data/validation/${file}.dat 
echo "s2 pileup data/puTree/s2_${file}.root" >> data/validation/${file}.dat
```

* Controlla la categorizzazione. L'indice di categoria e' data da smearerCat[0]
```
./script/hadder.sh
root -l tmp/d_chain.root macro/load_singleFile.C
data->Draw("etaEle[0]","smearerCat[0]==0")
```
* Sposta i file di categoria da tmp altrimenti li perdi e aggiungili al dat file
```
mv tmp/smearerCat_${region1}_*${file}* friends/smearerCat/ 
mv tmp/smearerCat_${region2}_*${file}* friends/smearerCat/ 
echo "s1 smearerCat_${region1} friends/smearerCat/smearerCat_${region1}_s1-${file}.root" >> data/validation/${file}.dat 
echo "s2 smearerCat_${region1} friends/smearerCat/smearerCat_${region1}_s2-${file}.root" >> data/validation/${file}.dat 
echo "d1 smearerCat_${region1} friends/smearerCat/smearerCat_${region1}_d1-${file}.root" >> data/validation/${file}.dat 
echo "d2 smearerCat_${region1} friends/smearerCat/smearerCat_${region1}_d2-${file}.root" >> data/validation/${file}.dat 
echo "s1 smearerCat_${region2} friends/smearerCat/smearerCat_${region2}_s1-${file}.root" >> data/validation/${file}.dat 
echo "s2 smearerCat_${region2} friends/smearerCat/smearerCat_${region2}_s2-${file}.root" >> data/validation/${file}.dat 
echo "d1 smearerCat_${region2} friends/smearerCat/smearerCat_${region2}_d1-${file}.root" >> data/validation/${file}.dat 
echo "d2 smearerCat_${region2} friends/smearerCat/smearerCat_${region2}_d2-${file}.root" >> data/validation/${file}.dat
```

* Controlla che sia tutto a posto nel file: emacs data/validation/${file}.dat

###Da qui in poi dipende dalla massa prescelta
* Lancia un profile, prima di lanciare i job, nel caso passa un initFile di imbeccata
```
./bin/ZFitter.exe -f data/validation/${file}.dat --regionsFile=data/regions/${region1}.dat --invMass_var=${invMass_type} --commonCut=Et_20-noPF --autoBin --smearerFit --plotOnly --profileOnly
./bin/ZFitter.exe -f data/validation/${file}.dat --regionsFile=data/regions/${region2}.dat --invMass_var=${invMass_type} --commonCut=Et_20-noPF --autoBin --smearerFit --plotOnly --profileOnly
```

source cleaner_step2.sh (non mi piace molto) ./submit_step2.sh ./submit_step2_corr.sh

(fa il plot della likelihood media) ./script/MYenergyScale.sh --step=2 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat

./script/MYenergyScale.sh --step=2 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass_SC_corr --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat cp test/dato/miniAOD_November2015/loose/invMass_SC_corr/step2/img/*.png ~/scratch1/www/RUN2_ECAL_Calibration/Temp_corr/

cp test/dato/miniAOD_November2015/loose/invMass/step2/img/.png ~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_Z/ cp test/dato/miniAOD_November2015/loose/invMass_SC_corr/step2/img/.png ~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_Z/

scrive i numeretti ./script/energyScale.sh --step=2 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat emacs tmp/res_corr.dat emacs tmp/res_corr_constTerm.dat

root -l -b .L macro/plot_data_mc.C+ PlotMeanHist("test/dato/miniAOD_November2015/loose/invMass/step2/2/fitres/histos-scaleStep2smearing_1-Et_20-noPF.root") .q cp test/dato/miniAOD_November2015/loose/invMass/step2/2/./img/histos*.png ~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_Z/histos_data_MC/

root -l -b .L macro/plot_data_mc.C+ PlotMeanHist("test/dato/miniAOD_November2015/loose/invMass_SC_corr/step2/1/fitres/histos-scaleStep2smearing_1-Et_20-noPF.root") .q cp test/dato/miniAOD_November2015/loose/invMass_SC_corr/step2/1/./img/histos*.png ~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_Z/histos_data_MC_corr/

root -l -b .L macro/plot_data_mc.C+ PlotMeanHist("test/dato/miniAOD_November2015/loose/invMass_SC_corr/step2/1/fitres/histos-scaleStep2smearing_2-Et_20-noPF.root") .q cp test/dato/miniAOD_November2015/loose/invMass_SC_corr/step2/1/./img/histos*.png ~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_Z/histos_data_MC_corr_2/
