Ti scrivi il tuo file con dati e MC
```
./script/Init_HighMass_calibration_procedure.sh data/validation/February2016_76_Rereco_HighMass.dat invMass_SC_pho_regrCorr
./script/calibration_highMass.sh data/validation/February2016_76_Rereco_HighMass.dat invMass_SC_pho_regrCorr CatOnly

#######################Controlla da categorizzazione
./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep0.dat --saveRootMacro --invMass_var=invMass_SC_corr
./script/hadder.sh
root -l tmp/d_chain.root tmp/s_chain.root macro/load_dataMC.C
data->Draw("invMass_SC_corr","smearerCat[0]>0")
#######################Controlla da categorizzazione

##Test_job
./script/calibration_highMass.sh data/validation/February2016_76_Rereco_HighMass.dat invMass_SC_pho_regrCorr Test_job

##Fit Test_job
##scala ampia
root -l -b
.L macro/fitOneProfile.C
fitOneProfile("test/dato/fitres/outProfile_ptRatio_pt2Sum_random_scaleStep0_Et_35_noPF.root","~/scratch1/www/RUN2_ECAL_Calibration/tmp/")
##scala ristretta
./script/fit.sh test/dato/fitres/outProfile_ptRatio_pt2Sum_random_scaleStep0_Et_35_noPF.root
e va in test/dato/img
 mv test/dato/img/outProfile_ptRatio_pt2Sum_random_scaleStep0_Et_35_noPF*.png ~/scratch1/www/RUN2_ECAL_Calibration/tmp/

##If you need initParameters
FITTA CON IL COSO GIUSTO, NON IL MIO RAPIDO RAPIDO, in MODO DA AVERE params
scale_EE-invMass_200_2000-DeltaEta_3-Et_35-noPF =  1.0000 +/- 0.0050000 L(0.95 - 1.05) // [GeV]
scale_EB-invMass_200_2000-DeltaEta_3-Et_35-noPF =  1.0050 +/- 0.0050000 L(0.95 - 1.05) // [GeV]
constTerm_EE-invMass_200_2000-DeltaEta_3-Et_35-noPF =  0.010000 +/- 0.030000 L(0 - 0.05)
constTerm_EB-invMass_200_2000-DeltaEta_3-Et_35-noPF =  0.0050000 +/- 0.030000 L(0 - 0.05)
alpha_EE-invMass_200_2000-DeltaEta_3-Et_35-noPF =  0.0000 +/- 0.010000 C L(0 - 0.2)
alpha_EB-invMass_200_2000-DeltaEta_3-Et_35-noPF =  0.0000 +/- 0.010000 C L(0 - 0.2)

#Data MC plots
root -l -b
.L macro/plot_data_mc.C+
PlotMeanHist("test/dato/fitres/histos_ptRatio_pt2Sum_random_scaleStep0_Et_35_noPF.root")
.q
mv test/dato/./img/histos_ptRatio_pt2Sum_random_scaleStep0_Et_35*.png ~/scratch1/www/RUN2_ECAL_Calibration/tmp/

#Rilancia Test_job con initParameters

root root://eoscms.cern.ch//eos/cms/store/group/dpg_ecal/alca_ecalcalib/ecalelf/ntuples/13TeV/MINIAODNTUPLE/74X_mcRun2_0T_v0/DYToEE_NNPDF30_13TeV-powheg-pyt\
> hia8_0T_74/allRange/DYToEE_NNPDF30_13TeV-powheg-pythia8_0T_74-allRange.root
```

```
Attenzione che con saveRootMacro ci sono s1-scale e scale_blabla
#mv tmp/d*_scaleEle_EtaR9_chain.root friends/others/ ++> NOOO, questi ad esempio sono MERDA, considerali come file temporanei del cazzo
```
