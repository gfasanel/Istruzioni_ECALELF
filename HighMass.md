Ti scrivi il tuo file con dati e MC
```
./script/Init_HighMass_calibration_procedure.sh data/validation/February2016_76_Rereco_HighMass.dat invMass_SC_pho_regrCorr
./script/calibration_highMass.sh data/validation/February2016_76_Rereco_HighMass.dat invMass_SC_pho_regrCorr CatOnly
./script/calibration_highMass.sh data/validation/February2016_76_Rereco_HighMass.dat invMass_SC_pho_regrCorr Test_job

root root://eoscms.cern.ch//eos/cms/store/group/dpg_ecal/alca_ecalcalib/ecalelf/ntuples/13TeV/MINIAODNTUPLE/74X_mcRun2_0T_v0/DYToEE_NNPDF30_13TeV-powheg-pyt\
> hia8_0T_74/allRange/DYToEE_NNPDF30_13TeV-powheg-pythia8_0T_74-allRange.root
```



```
Attenzione che con saveRootMacro ci sono s1-scale e scale_blabla
#mv tmp/d*_scaleEle_EtaR9_chain.root friends/others/ ++> NOOO, questi ad esempio sono MERDA, considerali come file temporanei del cazzo
```

```
#Parti dal dat file con solo signale e dati e aggiungi il pileup
./script/Init_calibration_procedure.sh data/validation/HighMass_study_2016_74.dat
```
```
#Categorizza 
con script/calibration_highMass.sh --scenario=CatOnly #(qualcosa del genere) 
```
```
#Controlla da categorizzazione
./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep0.dat --saveRootMacro --invMass_var=invMass_SC_corr
./script/hadder.sh
root -l tmp/d_chain.root tmp/s_chain.root macro/load_dataMC.C
data->Draw("invMass_SC_corr","smearerCat[0]>0")
```
```
./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep0.dat --smearEleType=stochastic --smearEleFile=/afs/cern.ch/work/g/gfasanel/CMSSW_7_4_15/src/Calibration/ZFitter/mc_smear/smearing_corrections_RUN2.dat --saveRootMacro --invMass_var=invMass_SC_corr

mv tmp/scaleEle_EtaR9*.root friends/others/
mv tmp/smearEle_stochastic*.root friends/others/
```
PlotOnly
```
./bin/ZFitter.exe -f data/validation/HighMass_study_2016_74.dat --regionsFile=data/regions/scaleStep0.dat --invMass_var=invMass_SC_corr --commonCut=Et_35-noPF --autoBin --smearerFit --plotOnly --profileOnly --targetVariable=ptRatio*pt2Sum --targetVariable_min=0.5*0 --targetVariable_max=2*300 --targetVariable_binWidth=0.02*6 --configuration=random
#--corrEleType=EtaR9 --smearEleType=stochastic --initFile=init_RUN2.txt
```
root -l -b
.L macro/fitOneProfile.C
fitOneProfile("test/dato/fitres/outProfile_ptRatio_pt2Sum_random_scaleStep0_mediumMass_Et_35_noPF.root","~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_highMass/")

