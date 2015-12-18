sample_eos_path="eos/cms/store/group/dpg_ecal/alca_ecalcalib/ecalelf/ntuples/13TeV/MINIAODNTUPLE/74X_mcRun2_asymptotic_v2/DYJets_madgraph-RunIISpring15MiniAODv2-Asym25ns-miniAOD-withPho/allRange/"
tail_list=`eos ls ${sample_eos_path}/unmerged/ntuple*.root`
root_prefix="root://eoscms//"
echo ${root_prefix}${sample_eos_path}merged.root
list=`for f in ${tail_list};do f=${root_prefix}${sample_eos_path}unmerged/${f}; echo $f; done`
echo $list
hadd -f ${root_prefix}${sample_eos_path}merged.root ${list}
