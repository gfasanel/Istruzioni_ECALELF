A questo punto, per sottometter su CRAB2 (non CRAB3) devi fare in modo che scripts/prodNtuples.sh passi le opzioni giuste a python/alcaSkimming.py 
(le stesse che gli passi in locale e che hai testato funzionare)

* Sottomettere su CRAB2
```
##DATI
cd /afs/cern.ch/work/g/gfasanel/CMSSW_7_4_15/src/Calibration/EcalAlCaRecoProducers
source ../initCmsEnvCRAB2.sh
# --skim ZSkim
./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep miniAOD| grep DoubleEG` --type MINIAOD -t config/reRecoTags/phiSym_materialCorrection_ref.py --scheduler=lsf --createOnly

Crab config file is tmp/ntuple.cfg

io l'ho modificato in tmp/ntuple_data.cfg (funziona perfettamente)

```
rm -r prod_ntuples/MINIAODNTUPLE/DoubleEG-ZSkim-Run2015B-PromptReco-v1-miniAOD_test/
cd /afs/cern.ch/work/g/gfasanel/CMSSW_7_4_15/src/Calibration/EcalAlCaRecoProducers
source ../initCmsEnvCRAB2.sh
crab -cfg tmp/ntuple_giuseppe.cfg -create
crab -c prod_ntuples/MINIAODNTUPLE/DoubleEG-ZSkim-Run2015B-PromptReco-v1-miniAOD_test/251022-251883/ -submit 1 #sottomette 1 job; submit 2 ne sottomette 2
crab -c prod_ntuples/MINIAODNTUPLE/DoubleEG-ZSkim-Run2015B-PromptReco-v1-miniAOD_test/251022-251883/ -status

crab -c prod_ntuples/MINIAODNTUPLE/DoubleEG-ZSkim-Run2015B-PromptReco-v1-miniAOD/251022-251883/ -submit
crab -c prod_ntuples/MINIAODNTUPLE/DoubleEG-ZSkim-Run2015B-PromptReco-v1-miniAOD/251022-251883/ -status

Abbi pazienza: non fare il getoutput a mano altrimenti fallisce qualche cosa nella copia
crab -c prod_ntuples/MINIAODNTUPLE/DoubleEG-ZSkim-Run2015B-PromptReco-v1-miniAOD/251022-251883/ -status -getoutput #va in res/
crab -c prod_ntuples/MINIAODNTUPLE/DoubleEG-ZSkim-Run2015B-PromptReco-v1-miniAOD/251022-251883/ -resubmit #,#,#
eos ls /eos/cms/store/group/dpg_ecal/alca_ecalcalib/ecalelf/ntuples/13TeV/MINIAODNTUPLE/
alcareco/Energy/DatasetName/RunRange
```

##MC
--isMC serve solo per creare la cartella con "MC" (MAH)
cd /afs/cern.ch/work/g/gfasanel/CMSSW_7_4_15/src/Calibration/EcalAlCaRecoProducers
source ../initCmsEnvCRAB2.sh
./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep miniAODSIM_test` --isMC --type MINIAOD -t config/reRecoTags/phiSym_materialCorrection_ref.py --scheduler=remoteGlidein --createOnly 

crab -cfg tmp/ntuple_giuseppe_MC.cfg -create
crab -c prod_ntuples/MINIAODNTUPLE/miniAODSIM_test/allRange/ -submit 1
crab -c prod_ntuples/MINIAODNTUPLE/miniAODSIM_test/allRange/ -status


in scripts/dataPU.sh

https://twiki.cern.ch/twiki/bin/view/CMS/PileupJSONFileforData#2015_Pileup_JSON_Files


da Calibration: (per fargli fare le ntuple, aggiungere variabili ecc)
ZNtupleDumper/
plugins and python
