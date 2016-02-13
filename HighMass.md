Ti scrivi il tuo file con dati e MC
```
./script/Init_calibration_procedure.sh data/validation/February2016_76_Rereco_HighMass.dat 100000 invMass_SC_pho_regrCorr
./script/calibration_highMass.sh data/validation/February2016_76_Rereco_HighMass.dat invMass_SC_pho_regrCorr CatOnly
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
rm ~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_highMass/*.png
root -l -b
.L macro/fitOneProfile.C
fitOneProfile("test/dato/fitres/outProfile_ptRatio_pt2Sum_random_scaleStep0_mediumMass_Et_35_noPF.root","~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_highMass/")

rm ~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_highMass_NOCorr/*.png
root -l -b
.L macro/fitOneProfile.C
fitOneProfile("test/dato/fitres/outProfile_ptRatio_pt2Sum_random_scaleStep0_mediumMass_Et_35_noPF.root","~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_highMass_NOCorr/")


root -l -b 
.L macro/plot_data_mc.C+ 
PlotMeanHist("test/dato/fitres/histos_ptRatio_pt2Sum_random_scaleStep0_mediumMass_Et_35_noPF.root")
.q
cp test/dato/img/histos*mediumMass*_150_2000*.png ~/scratch1/www/RUN2_ECAL_Calibration/scale_smearing_highMass_NOCorr/histos_data_MC/

Quando sei soddisfatto
./script/run50Minizations.sh RUN2_NOCorr

./script/run50Minizations.sh RUN2_corr

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Controlla che le scale e gli smearing matchino
INVMASS=invMass_SC_corr
REGION=_mediumMass
./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep0${REGION}.dat --addBranch=smearerCat invMass_var=${INVMASS} --saveRootMacro --corrEleType=EtaR9 --smearEleType=stochastic
./script/hadder.sh
root tmp/d_chain.root macro/load_singleFile.C
TString commonCut="((((eleID[0] & 0x20000)==0x20000)&&((eleID[1] & 0x20000)==0x20000))&&((energySCEle_corr[0]/cosh(etaSCEle[0]) >= 35)&&(energySCEle_corr[1]/cosh(etaSCEle[1]) >= 35)))&&(recoFlagsEle[0] > 1 && recoFlagsEle[1] > 1)";
ElectronCategory_class cutter;
TString BB=cutter.GetCut("EB",0).GetTitle(); //both electron in EB
TString EE=cutter.GetCut("EE",0).GetTitle(); //both electron in EE
data->Draw("scaleEle[0]>>h0(1000,0.95,1.05)",commonCut+"&&"+BB)
data->Draw("scaleEle[1]>>h1(1000,0.95,1.05)",commonCut+"&&"+BB,"same")
h0->GetMean()
data->Draw("scaleEle[0]>>h3(1000,0.95,1.05)",commonCut+"&&"+EE)
data->Draw("scaleEle[1]>>h4(1000,0.95,1.05)",commonCut+"&&"+EE,"same")

root -l tmp/s_chain.root macro/load_singleFile.C
TString commonCut="((((eleID[0] & 0x20000)==0x20000)&&((eleID[1] & 0x20000)==0x20000))&&((energySCEle_corr[0]/cosh(etaSCEle[0]) >= 35)&&(energySCEle_corr[1]/cosh(etaSCEle[1]) >= 35)))&&(recoFlagsEle[0] > 1 && recoFlagsEle[1] > 1)";
ElectronCategory_class cutter;
TString BB=cutter.GetCut("EB",0).GetTitle(); //both electron in EB
TString EE=cutter.GetCut("EE",0).GetTitle(); //both electron in EE
data->Draw("smearSigmaEle[0]>>h5",commonCut+"&&"+EE)
h5->GetMean();
data->Draw("smearSigmaEle[0]>>h6",commonCut+"&&"+BB)
h6->GetMean();
