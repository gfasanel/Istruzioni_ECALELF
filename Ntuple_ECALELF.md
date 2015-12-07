da Calibration/EcalAlcarecoProducers/ (qualcosa del genere)

* Girare in locale (funziona)
```
##DATI
file="root://eoscms//eos/cms/store/data/Run2015D/DoubleEG/MINIAOD/PromptReco-v4/000/259/862/00000/389D079E-EA7B-E511-9506-02163E0141D8.root"
cmsRun python/alcaSkimming.py type=MINIAODNTUPLE files=$file maxEvents=1000 isCrab=0 tagFile=config/reRecoTags/phiSym_materialCorrection_ref.py
#Ti trovi una ntupla in locale:
ls ntuple_numEvent1000.root
##MC
file="/afs/cern.ch/work/g/gfasanel/CMSSW_7_4_15/src/Calibration/EcalAlCaRecoProducers/ZToEE_13TeV_powheg_M_120_200_miniAOD.root"
cmsRun python/alcaSkimming.py type=MINIAODNTUPLE files=file:$file maxEvents=1000 isCrab=0 tagFile=config/reRecoTags/phiSym_materialCorrection_ref.py
#Ti trovi una ntupla in locale:
ls ntuple_numEvent1000.root
file="root://xrootd.unl.edu//store/mc/RunIISpring15MiniAODv2/DYJetsToLL_M-50_TuneCUETP8M1_13TeV-amcatnloFXFX-pythia8/MINIAODSIM/74X_mcRun2_asymptotic_v2-v1/50000/041705A6-6F6F-E511-AC9C-001E6757F1D4.root"
file="root://xrootd.unl.edu//store/mc/RunIISpring15DR74/ZToEE_NNPDF30_13TeV-powheg_M_200_400/MINIAODSIM/Asympt25ns_MCRUN2_74_V9-v1/40000/EE92B9F5-934F-E511-85F2-0025905B85D6.root"
cmsRun python/alcaSkimming.py type=MINIAODNTUPLE files=file:$file maxEvents=1000 isCrab=0 tagFile=config/reRecoTags/phiSym_materialCorrection_ref.py
```
 
* Per sottomettere su crab2 (NON crab3), ho modificato scripts/prodNtuples.sh in modo che:
* 1) use_dbs3 =1
* 2) lumis_per_job=12000 -> era troppo (job killed due to cpu limit usage reached)
* 3) non riesce a copiare l'output su eos. Sono riuscito a farlo scrivere su una mia cartella su /afs
* 4) il config file di crab scritto da scripts/prodNtuples appare cosi': 

https://github.com/GiuseppeFasanella/ECALELF/blob/miniAOD/EcalAlCaRecoProducers/tmp/ntuple_data.cfg
```
##DATI
cd /afs/cern.ch/work/g/gfasanel/CMSSW_7_4_15/src/Calibration/EcalAlCaRecoProducers
source ../initCmsEnvCRAB2.sh
# --skim ZSkim
./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep miniAOD| grep DoubleEG` --type MINIAOD -t config/reRecoTags/phiSym_materialCorrection_ref.py --scheduler=lsf --createOnly
crab -c prod_ntuples/MINIAODNTUPLE/DoubleEG-ZSkim-Run2015B-PromptReco-v1-miniAOD_test/251022-251883/ -submit 1
```

* Tecnicamente funziona ma non riesce a copiare l'output su eos.
* Quando creo il job mi dice
```
crab:  output files will be staged at caf.cern.ch
       with LFN's starting with = group/dpg_ecal/alca_ecalcalib/ecalelf/ntuples/13TeV/MINIAODNTUPLE/DoubleEG-ZSkim-Run2015B-PromptReco-v1-miniAOD/251022-251883/unmerged/
endpoint =  root://eoscms//eos/cms/store/group/dpg_ecal/alca_ecalcalib/ecalelf/ntuples/13TeV/MINIAODNTUPLE/DoubleEG-ZSkim-Run2015B-PromptReco-v1-miniAOD/251022-251883/unmerged/
crab:  Checking remote location
crab:  WARNING: Problems trying remote dir check: 
	Failure while checking remote dir: list assignment index out of range
WARNING: Stage out of output files may fail
crab:  Creating 29 jobs, please wait...
crab:  Total of 29 jobs created.
```

* dirottando l'output su una mia cartella locale, funziona tutto


```
##MC
./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep miniAODSIM_test` --isMC --type MINIAOD -t config/reRecoTags/phiSym_materialCorrection_ref.py --scheduler=remoteGlidein --createOnly
```

* Tranne che non riesco a scrivere nemmeno su una cartella locale (penso che quel remoteGlidein lo confonda)

```
crab:  output files will be staged at caf.cern.ch
       with LFN's starting with = /afs/cern.ch/work/g/gfasanel/CMSSW_7_4_15/src/Calibration/EcalAlCaRecoProducers/Test_miniAOD_SIM/
crab:  Checking remote location
crab:  WARNING: Problems trying remote dir check: 
	Failure while checking remote dir: 'Error checking []'
WARNING: Stage out of output files may fail
crab:  Creating 3 jobs, please wait...
crab:  Total of 3 jobs created.
```
