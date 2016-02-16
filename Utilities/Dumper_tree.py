import ROOT
tree= ROOT.TChain("selected")
tree.Add('root://eoscms//eos/cms/store/group/dpg_ecal/alca_ecalcalib/ecalelf/ntuples/13TeV/MINIAODNTUPLE/74X_dataRun2_Prompt_v4/DoubleEG-ZSkim-Run2015C-rereco05Oct20\          
15-MINIAOD/254227-255031/246908-260627-Prompt_25ns-v1-golden_silver/unmerged-allRange-miniAOD.root')
tree.Print()
