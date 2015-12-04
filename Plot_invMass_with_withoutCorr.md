./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep0_highMass.dat --corrEleType=EtaR9 --smearEleType=stochastic invMass_var=invMass_SC_corr --saveRootMacro
./script/hadder.sh
root -l -b tmp/d_chain.root tmp/s1_chain.root tmp/load_dataMC.C macro/massPlotter.C

root -l tmp/d_chain.root tmp/s1_chain.root tmp/load_dataMC.C
//Filling Data histos
data->Draw("invMass_SC_corr*sqrt(scaleEle[0]*scaleEle[1])>>h(40,80,100)","(((((eleID[0] & 0x20000)==0x20000)&&((eleID[1] & 0x20000)==0x20000))&&((abs(etaEle[0]) < 1.4442)&&(abs(etaEle[1]) < 1.4442)))&&((energySCEle_corr[0] * scaleEle[0]/cosh(etaSCEle[0]) >= 25)&&(energySCEle_corr[1] * scaleEle[1]/cosh(etaSCEle[1]) >= 25)))&&(recoFlagsEle[0] > 1 && recoFlagsEle[1] > 1)");
//Filling MC histograms 
signalA->Draw("invMass_SC_corr*sqrt(smearEle[0]*smearEle[1])>>h2(40,80,100)","(((((eleID[0] & 0x20000)==0x20000)&&((eleID[1] & 0x20000)==0x20000))&&((abs(etaEle[0]) < 1.4442)&&(abs(etaEle[1]) < 1.4442)))&&((energySCEle_corr[0]/cosh(etaSCEle[0]) >= 25)&&(energySCEle_corr[1]/cosh(etaSCEle[1]) >= 25)))&&(recoFlagsEle[0] > 1 && recoFlagsEle[1] > 1)","same");
h->DrawNormalized();
h2->SetLineColor(kRed);
h2->DrawNormalized("same");
