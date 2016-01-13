```
validation_file=data/validation/Rereco_December2015.dat
region_file=data/regions/scaleStep2smearing_1.dat #questo e' giusto per dare una region, visto che e' opzione mandatory
corr_type=EtaR9_reReco_Ele_regrCorr
smear_type=stochastic_reReco_Ele_regrCorr
invMass=invMass_SC_corr
```
```
./bin/ZFitter.exe -f $validation_file --regionsFile=$region_file --corrEleType=$corr_type --smearEleType=$smear_type invMass_var=$invMass --saveRootMacro
./script/hadder.sh
root -l -b tmp/d_chain.root tmp/s_chain.root tmp/load_dataMC.C macro/massPlotter.C
# per ora massPlotter non va
```

```
#A manina
root -l tmp/d_chain.root tmp/s_chain.root macro/load_dataMC.C
//Filling Data histos
data->Draw("invMass_SC_corr*sqrt(scaleEle[0]*scaleEle[1])>>h_data(40,80,100)","(((((eleID[0] & 0x20000)==0x20000)&&((eleID[1] & 0x20000)==0x20000))&&((abs(etaEle[0]) < 1.4442)&&(abs(etaEle[1]) < 1.4442)))&&((energySCEle_corr[0] * scaleEle[0]/cosh(etaSCEle[0]) >= 25)&&(energySCEle_corr[1] * scaleEle[1]/cosh(etaSCEle[1]) >= 25)))&&(recoFlagsEle[0] > 1 && recoFlagsEle[1] > 1)");
//Filling MC histograms 
signalA->Draw("invMass_SC_corr*sqrt(smearEle[0]*smearEle[1])>>h_MC(40,80,100)","(((((eleID[0] & 0x20000)==0x20000)&&((eleID[1] & 0x20000)==0x20000))&&((abs(etaEle[0]) < 1.4442)&&(abs(etaEle[1]) < 1.4442)))&&((energySCEle_corr[0]/cosh(etaSCEle[0]) >= 25)&&(energySCEle_corr[1]/cosh(etaSCEle[1]) >= 25)))&&(recoFlagsEle[0] > 1 && recoFlagsEle[1] > 1)","same");
h_data->DrawNormalized();
h_MC->SetLineColor(kRed);
h_MC->DrawNormalized("same");
```
