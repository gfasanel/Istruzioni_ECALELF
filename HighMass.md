PILEUP
Devi avere dei puHist da cui partire che fai brutalmente plottando nPV per data e MC (in modo da avere la distribuzione dei)
un pileUPHist per i dati con tag d e un pileupHist per il MC con tag s

INVMASS=invMass_SC_corr
REGION=_mediumMass
./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep0${REGION}.dat invMass_var=${INVMASS} --saveRootMacro

mv tmp/mcPUtrees*.root data/pu/mc/
A questo punto i pileup Hist per data e MC NON ti servono piu' e li puoi quindi commentare


Attenzione che con saveRootMacro ci sono s1-scale e scale=blabal
#mv tmp/d*_scaleEle_EtaR9_chain.root friends/others/ ++> NOOO, questi ad esempio sono MERDA, considerali come file temporanei del cazzo


Ok, quindi so come leggere anche le correzioni: dai che forse ci sono (qui il regionsFile e' solo formale, non viene usata ma e' una opzione Mandatory)

Da curare il fatto che src/Energy... per lo smearing: sbagliava il format (il format di ECALELF e' 2) 
Importante definire l'energia quando prendi le categorie, altrimenti puo' fillare con NAN ed e' un casino

./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep0.dat --saveRootMacro --corrEleType=EtaR9 --corrEleFile=/afs/cern.ch/work/g/gfasanel/CMSSW_7_4_15/src/Calibration/ZFitter/data_scale/scale_corrections_RUN2.dat --invMass_var=invMass_SC_corr
./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep0.dat --smearEleType=stochastic --smearEleFile=/afs/cern.ch/work/g/gfasanel/CMSSW_7_4_15/src/Calibration/ZFitter/mc_smear/smearing_corrections_RUN2.dat --saveRootMacro --invMass_var=invMass_SC_corr
mv tmp/scaleEle_EtaR9*.root friends/others/
mv tmp/smearEle_stochastic*.root friends/others/

echo "s1      smearEle_stochastic     friends/others/smearEle_stochastic_s1-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "s2      smearEle_stochastic     friends/others/smearEle_stochastic_s2-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d1      scaleEle_EtaR9            friends/others/scaleEle_EtaR9_d1-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d2      scaleEle_EtaR9            friends/others/scaleEle_EtaR9_d2-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d3      scaleEle_EtaR9            friends/others/scaleEle_EtaR9_d3-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat

echo "s3      smearEle_stochastic     friends/others/smearEle_stochastic_s3-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat

Fai le categorie:
INVMASS=invMass_SC_corr
REGION=_mediumMass
REGION=_highMass
./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep0${REGION}.dat --addBranch=smearerCat invMass_var=${INVMASS} --saveRootMacro
./script/hadder.sh
root -l tmp/d_chain.root macro/load_singleFile.C
data->Draw("invMass_SC_corr","smearerCat[0]>=0")

CONTROLLA LE CATEGORIE

mv tmp/smearerCat_scaleStep0${REGION}* friends/smearerCat/ 

echo "s1      smearerCat_scaleStep0${REGION}     friends/smearerCat/smearerCat_scaleStep0${REGION}_s1-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "s2      smearerCat_scaleStep0${REGION}    friends/smearerCat/smearerCat_scaleStep0${REGION}_s2-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "s3      smearerCat_scaleStep0${REGION}    friends/smearerCat/smearerCat_scaleStep0${REGION}_s3-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "s4      smearerCat_scaleStep0${REGION}    friends/smearerCat/smearerCat_scaleStep0${REGION}_s4-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d1      smearerCat_scaleStep0${REGION}    friends/smearerCat/smearerCat_scaleStep0${REGION}_d1-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d2      smearerCat_scaleStep0${REGION}    friends/smearerCat/smearerCat_scaleStep0${REGION}_d2-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat
echo "d3      smearerCat_scaleStep0${REGION}    friends/smearerCat/smearerCat_scaleStep0${REGION}_d3-miniAOD_November2015.root" >> data/validation/miniAOD_November2015.dat


TEST PRELIMINARI: (puoi farli con e senza correzioni, con e senza initFile)
REGION=_mediumMass
./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep0${REGION}.dat --invMass_var=invMass_SC_corr --commonCut=Et_35-noPF --autoBin --smearerFit --plotOnly --profileOnly --targetVariable=ptRatio*pt2Sum --targetVariable_min=0.5*0 --targetVariable_max=2*300 --targetVariable_binWidth=0.02*6 --configuration=random --corrEleType=EtaR9 --smearEleType=stochastic --initFile=init_RUN2.txt | tee withCorr.txt

REGION=_mediumMass
./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep0${REGION}.dat --invMass_var=invMass_SC_corr --commonCut=Et_35-noPF --autoBin --smearerFit --plotOnly --profileOnly --targetVariable=ptRatio*pt2Sum --targetVariable_min=0.5*0 --targetVariable_max=2*300 --targetVariable_binWidth=0.02*6 --configuration=random --initFile=init_RUN2_noCorr.txt --outDirFitResData=test/dato/fitres/NOCorr/ | tee NOCorr.txt

##HIGH MASS WITH CORR
REGION=_highMass   
./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep0${REGION}.dat --invMass_var=invMass_SC_corr --commonCut=Et_35-noPF-DeltaEta_3 --autoBin --smearerFit --targetVariable=ptRatio*pt2Sum --targetVariable_min=0.5*0 --targetVariable_max=2*300 --targetVariable_binWidth=0.02*6 --configuration=random --initFile=init_RUN2_highMass_Corr.txt --corrEleType=EtaR9 --smearEleType=stochastic --plotOnly --profileOnly


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
