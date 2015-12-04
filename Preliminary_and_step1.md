import ROOT
tree= ROOT.TChain("selected")
tree.Add('root://eoscms//eos/cms/store/group/dpg_ecal/alca_ecalcalib/ecalelf/ntuples/13TeV/MINIAODNTUPLE/phiSym_materialCorrection_ref/DoubleEG-ZSkim-Run2015B-PromptReco-v1-miniAOD/251022-251883/246908-259891-Prompt_25ns-v1/unmerged/ntuple_1_1_IvA.root')
tree.Print()


{    
//root -l -b plot_ntuple.C	              
  vector<TString> variables;
  variables.push_back("etaSCEle");
  variables.push_back("etaEle");
  for(int i=0; i<variables.size();i++){
    selected->Draw(variables[i]);
    TString name="~/scratch1/www/Pt1Pt2/ntuples_13TeV/"+variables[i]+".png";//Se glielo vuoi far fare al volo dentro SaveAs non capisce                                         
    c1->SaveAs(name);
  }
}

La eleID map e' definita qui:
https://github.com/ECALELFS/ECALELF/blob/miniAOD/ZNtupleDumper/interface/eleIDMap.h#L31

TString cut="((((eleID[0] & 131072)==131072)&&((eleID[1] & 131072)==131072))&&((energySCEle[0]/cosh(etaSCEle[0]) >= 25)&&(energySCEle[1]/cosh(etaSCEle[1]) >= 25)))&&(recoFlagsEle[0] > 1 && recoFlagsEle[1] > 1)";

root -l tmp/d_chain.root macro/load_singleFile.C 
ElectronCategory_class cutter
TString commonCut=cutter.GetCut("Et_25-noPF-eleID_cutBasedElectronID|Spring15|25ns|V1|standalone|loose",0).GetTitle();
TString ELEID_LOOSE=j.GetCut("eleID_cutBasedElectronID|Spring15|25ns|V1|standalone|loose",false,1,false).GetTitle()
TString ELEID_MEDIUM=j.GetCut("eleID_cutBasedElectronID_Spring15_25ns_V1_standalone_medium",false,1,false).GetTitle()
TString ELEID_TIGHT=j.GetCut("eleID_cutBasedElectronID_Spring15_25ns_V1_standalone_tight",false,1,false).GetTitle()
TString ET=j.GetCut("Et_25-noPF",1).GetTitle();
TString Charge="(chargeEle[0]==1 || chargeEle[0]==-1) && (chargeEle[1]==1 || chargeEle[1]==-1)";
TString cut_loose=ELEID_LOOSE+"&&"+ET+"&&"+Charge;
TString cut_medium=ELEID_MEDIUM+"&&"+ET+"&&"+Charge;
TString cut_tight=ELEID_TIGHT+"&&"+ET+"&&"+Charge;
data->Draw("pModeGsfEle[0]",cut_loose);
c1->SaveAs("~/scratch1/www/Pt1Pt2/ntuples_13TeV/pModeGsfEle0_loose.png");
data->Draw("trackMomentumErrorEle[0]",cut_loose);
c1->SaveAs("~/scratch1/www/Pt1Pt2/ntuples_13TeV/trackMomentumErrorEle0_loose.png");
data->Draw("seedEnergySCEle[0]",cut_loose);
c1->SaveAs("~/scratch1/www/Pt1Pt2/ntuples_13TeV/seedEnergySCEle0_loose.png");
data->Draw("phiSCEle[0]",cut_loose);
c1->SaveAs("~/scratch1/www/Pt1Pt2/ntuples_13TeV/phiSCEle0_loose.png");
data->Draw("PtEle[0]",cut_loose);
c1->SaveAs("~/scratch1/www/Pt1Pt2/ntuples_13TeV/PtEle0_loose.png");
data->Draw("rawEnergySCEle[0]",cut_loose);
c1->SaveAs("~/scratch1/www/Pt1Pt2/ntuples_13TeV/rawEnergySCEle0_loose.png");
data->Draw("etaSCEle[0]",cut_loose);
c1->SaveAs("~/scratch1/www/Pt1Pt2/ntuples_13TeV/etaSCEle0_loose.png");
data->Draw("etaSCEle[0]",cut_medium);
c1->SaveAs("~/scratch1/www/Pt1Pt2/ntuples_13TeV/etaSCEle0_medium.png");
data->Draw("etaSCEle[0]",cut_tight);
c1->SaveAs("~/scratch1/www/Pt1Pt2/ntuples_13TeV/etaSCEle0_tight.png");
data->Draw("R9Ele[0]");
c1->SaveAs("~/scratch1/www/Pt1Pt2/ntuples_13TeV/R90.png");
data->Draw("R9Ele[0]",cut_loose);
c1->SaveAs("~/scratch1/www/Pt1Pt2/ntuples_13TeV/R90_loose.png");
data->Draw("invMass_rawSC") 
data->Draw("invMass_rawSC",cut_loose);
c1->SaveAs("~/scratch1/www/Pt1Pt2/ntuples_13TeV/invMass_rawSC.png");
data->Draw("recoFlagsEle[0]");
data->Draw("HLTfire");

./script/dataPU.sh -p /afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions15/13TeV/PileUp/pileup_latest.txt -j /afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions15/13TeV/Cert_246908-260627_13TeV_PromptReco_Collisions15_25ns_JSON_Silver.txt

./script/dataPU.sh -a

./script/dataPU.sh -p /afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions15/13TeV/PileUp/pileup_latest.txt -j /afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions15/13TeV/Cert_246908-260627_13TeV_PromptReco_Collisions15_25ns_JSON_Silver.txt

e ti trovi un root file in data/puFiles

Con Gli STEP!

 ~lcorpe/public/Guiseppe/
here you find 3 things
1. my runRanges file (25ns, interval of ~50k runs)
2.the personal macro i use to generate that (lcrundivide.sh)
--> usage lcrundivide $yourDatfile (from data/validation...) $interval  (eg 50000)
will create your file here : data/runRanges/monitoringRun2015-25ns-interval_${interval}.dat
3. run limits, to be placed in data/runRanges/. : tells the script where the different (eg 2015C, D, bOn, bOff) start and begin
rm -r test/MC/pufileData_tot/
rm -r test/dato/miniAOD_November2015/
./script/energyScale.sh --step=1 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass_SC --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat







