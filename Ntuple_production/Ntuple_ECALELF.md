* da Calibration/EcalAlcarecoProducers/
* Per ora il branch giusto e' `mergeattempt` da Photon_regression

```
ATTENTO CHE NON DEVI FARE source ../initCmsEnv.sh
ma
source ../initCmsEnvCRAB2.sh, perche' e' CRAB2 che devi usare e NON crab3
#che fa sostanzialmente voms-proxy-init -voms cms. Va fatto altrimenti potresti non avere i permessi per aprire alcuni file
```

**Step0: trovarsi i file sulla DAS**
* **Per i dati**
* Per i dati devi cercare `dataset=/DoubleEG/*/*MINIAOD` 
* Qualcosa del genere `dataset=/DoubleEG/*Run2015D*/*MINIAOD`
* Per avere piu' informazioni `config dataset=xxxx`, per esempio per sapere se e' fatto in 74 o 76 eccetera
* **Per il MC**
* `dataset=/DYJetsToLL*/*76*/*MINIAODSIM` 76 specifica la versione di CMSSW
* `dataset=/DYToEE*/*76*/*MINIAODSIM`
* `dataset=/ZToEE*/*MiniAODv2*76*/*MINIAODSIM`

* Dopo che hai trovato il nome del sample, prenditi un paio di nomi, oppure da browser: download
```
##Prenditi un paio di nomi di file
das_client --query="file dataset=/DoubleEG/Run2015D-04Dec2015-v2/MINIAOD" --limit=5
Lui stampa:
/store/data/Run2015D/DoubleEG/MINIAOD/04Dec2015-v2/10000/0006F6FD-EE9D-E511-B3D4-00304865C426.root
#Al quali dovrai aggiungere il prefisso
root://xrootd.unl.edu//

##Qui, ad esempio, chiedi dove si trova il file
das_client --query="site dataset=/DoubleEG/Run2015D-04Dec2015-v2/MINIAOD"

##Qui chiedi il global tag (per ora vado su configs da browser, ma e' una scocciatura)
das_client --query="?? dataset=/DoubleEG/Run2015D-04Dec2015-v2/MINIAOD"
```
**Step0_bis**
* Trovarsi i global tag con i quali sono stati prodotti i sample: da DAS, cliccando su configs; 
* Esempio `Global Tag: 76X_dataRun2_v15`
* Copiati un config esistente e metti dentro il giusto global tag che hai preso dalla DAS
* `cp config/reRecoTags/74X_dataRun2_Prompt_v4.py config/reRecoTags/76X_dataRun2_v15.py`
* `cp config/reRecoTags/74X_mcRun2_asymptotic_v2.py config/reRecoTags/76X_mcRun2_v12.py`
* Adesso, apri i config.py e metti il giusto global tag dentro
```
# il config.py deve essere cosi' con il global tag GIUSTO!
import FWCore.ParameterSet.Config as cms

from CondCore.DBCommon.CondDBSetup_cfi import *

RerecoGlobalTag = cms.ESSource("PoolDBESSource",
                               CondDBSetup,
                               connect = cms.string('frontier://FrontierProd/CMS_CONDITIONS'),
                               globaltag = cms.string('74X_mcRun2_asymptotic_v2'),
                               )

```

**Step0+: girare in locale**
* Girare in locale, prima di sottomettere jobs
* Se funziona, alcareco_datasets.dat vanno messi i DAS name

```
#dentro lo script specifica il file, il tag e il json
./script/local_run.sh data (MC) 
```
```
##Esempi a manina (quello che fa local_run.sh)
##DATI
##file="root://eoscms//eos/cms/store/data/Run2015D/DoubleEG/MINIAOD/PromptReco-v4/000/259/862/00000/389D079E-EA7B-E511-9506-02163E0141D8.root"
##Esempio
tag=config/reRecoTags/74X_dataRun2_Prompt_v4.py
json_File=/afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions15/13TeV/Cert_246908-260627_13TeV_PromptReco_Collisions15_25ns_JSON_Silver.txt
file="root://xrootd.unl.edu//store/user/emanuele/DoubleEG/ZElectron_Run2015D_v3_74X_dataRun2_Candidate_2015_12_04_11_16_06/151204_115447/0000/reRECO_RAW2DIGI_L1Reco_RECO_PAT_1.root"
cmsRun python/alcaSkimming.py type=MINIAODNTUPLE files=$file maxEvents=1000 isCrab=0 tagFile=${tag} jsonFile=${json_File}
#Ti trovi una ntupla in locale:
ls ntuple_numEvent1000.root

##MC
## A noi interessa miniAOD v2
##file="root://xrootd.unl.edu//store/mc/RunIISpring15MiniAODv2/DYJetsToLL_M-50_TuneCUETP8M1_13TeV-amcatnloFXFX-pythia8/MINAODSIM/74X_mcRun2_asymptotic_v2-v1/50000/041705A6-6F6F-E511-AC9C-001E6757F1D4.root"
##Esempio
tagMC=config/reRecoTags/74X_mcRun2_asymptotic_v2.py
file="root://xrootd.unl.edu//store/mc/RunIISpring15MiniAODv2/ZToEE_NNPDF30_13TeV-powheg_M_50_120/MINIAODSIM/74X_mcRun2_asymptotic_v2-v1/10000/005C8B52-D973-E511-B557-38EAA78D8F98.root"
cmsRun python/alcaSkimming.py type=MINIAODNTUPLE files=file:$file maxEvents=1000 isCrab=0 tagFile=${tagMC} MC=1
```

###Sottomettere su CRAB 2 (su CRAB3 non sono riuscito)

```
source ../initCmsEnvCRAB2.sh
```
 
* 1) Devi scrivere in alcareco_datasets.dat il dataset sul quale vuoi girare
```
256584-258158 /DoubleEG/emanuele-ZElectron_Run2015D_v3_74X_dataRun2_Candidate_2015_12_04_11_16_06-5f619c1c848e615f4f8041df1ac5e2bd/USER DoubleEG-emanuele-ZElectron_Run2015D_v3_74X caf database VALID RUN2015D

allRange        /DYJetsToLL_M-100to200_TuneCUETP8M1_13TeV-amcatnloFXFX-pythia8/RunIISpring15MiniAODv2-74X_mcRun2_asymptotic_v2-v1/MINIAODSIM          DYJets_amctnlo_M100to200-RunIISpring15MiniAODv2-Asym25ns-miniAOD-withPho caf database VALID highMass -
```
* 2) prova che parseDataFile capisca il file giusto da prendere
```
parseDatasetFile.sh alcareco_datasets.dat | grep emanuele-ZElectron_Run2015D_v3
```
* Ho modificato scripts/prodNtuples.sh in modo che:
* 1) use_dbs3 =1
* 2) lumis_per_job=12000 -> era troppo (job killed due to cpu limit usage reached)
* 3) non riesce a copiare l'output su eos. Sono riuscito a farlo scrivere su una mia cartella su /afs
* 4) il config file di crab scritto da scripts/prodNtuples appare cosi': 

https://github.com/GiuseppeFasanella/ECALELF/blob/miniAOD/EcalAlCaRecoProducers/tmp/ntuple_data.cfg
```
##DATI
source ../initCmsEnvCRAB2.sh
#where=lsf
where=remoteGlidein
json=/afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions15/13TeV/Cert_246908-260627_13TeV_PromptReco_Collisions15_25ns_JSON_Silver.txt
jsonName=246908-260627-Prompt_25ns-v1-golden_silver
tag=config/reRecoTags/74X_dataRun2_Prompt_v4.py
# --skim ZSkim (con lo skim NON Funziona)
./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep emanuele-ZElectron_Run2015D_v3` --type MINIAOD -t ${tag} --scheduler=${where} --json=${json} --json_name=${jsonName} --createOnly
#sottometti un job di prova
 crab -c prod_ntuples/MINIAODNTUPLE/74X_dataRun2_Prompt_v4/DoubleEG-emanuele-ZElectron_Run2015D_v3_74X/256584-258158/246908-260627-Prompt_25ns-v1-golden_silver/ -submit 1
 crab -c prod_ntuples/MINIAODNTUPLE/74X_dataRun2_Prompt_v4/DoubleEG-emanuele-ZElectron_Run2015D_v3_74X/256584-258158/246908-260627-Prompt_25ns-v1-golden_silver/ -status
 
 ./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep emanuele-ZElectron_Run2015D_v4` --type MINIAOD -t ${tag} --scheduler=${where} --json=${json} --json_name=${jsonName}
 
 ##Se un job fallisce o ha finito, prenditi l'output
 #getoutput
 crab -c prod_ntuples/MINIAODNTUPLE/74X_dataRun2_Prompt_v4/DoubleEG-emanuele-ZElectron_Run2015D_v3_74X/256584-258158/246908-260627-Prompt_25ns-v1-golden_silver/ -status -getoutput
 # E controlla il res
 /res/
```
```
root root://eoscms//eos/cms/store/group/dpg_ecal/alca_ecalcalib/ecalelf/ntuples/13TeV/MINIAODNTUPLE/74X_dataRun2_Prompt_v4/DoubleEG-emanuele-ZElectron_Run2015D_v3_74X/256584-258158/246908-260627-Prompt_25ns-v1-golden_silver/unmerged/ 
```

```
##MC
#where=lsf
where=remoteGlidein
tagMC=config/reRecoTags/74X_mcRun2_asymptotic_v2.py
./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep withPho | head -n 1` --isMC --type MINIAOD --scheduler=${where} --tag=${tagMC} --createOnly
crab -c prod_ntuples/MINIAODNTUPLE/DYJets_amctnlo-RunIISpring15MiniAODv2-Asym25ns-miniAOD-withPho/allRange/ -submit 1

./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep withPho | head -n 2` --isMC --type MINIAOD --scheduler=${where} --tag=${tagMC}
```
```
./scripts/submit_ntuples.sh --createOnly
./scripts/submit_ntuples.sh --submitOnly
./scripts/submit_ntuples.sh --check
```

### Babysitting dei job

La procedura per risottomettere un job fallito e': crab -c bla bla -status e vedi quali sono falliti, -getoutput, -resubmit xx,yy

quando sei soddisfatto dei tuoi job devi mergiare

source hadder_ntuples.sh

### Se il tuo job e' riuscito, sottomettili tutti
```
exitCode 0 (vuol dire job riuscito)
#con 
./submit_ntuple.sh e ci metti --submitOnly (invece che --createOnly) 

dopo di che li segui tutti con --check (invece che --submitOnly). Lui li segue tutti e quando hanno finiti li mergia anche
source ../initCmsEnvCRAB2.sh
#where=lsf                                                                                                                                                                      
where=remoteGlidein
tag=config/reRecoTags/74X_dataRun2_Prompt_v4.py
json=/afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions15/13TeV/Cert_246908-260627_13TeV_PromptReco_Collisions15_25ns_JSON_Silver.txt
jsonName=246908-260627-Prompt_25ns-v1-golden_silver
./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep Run2015C | grep withPho` --type MINIAOD --scheduler=${where} --tag=${tag} --json=${json} --json_name\
=${jsonName} --submitOnly

#tagMC=config/reRecoTags/74X_mcRun2_asymptotic_v2.py                                                                                                                            
#./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep M200to400` --isMC --type MINIAOD --scheduler=${where} --tag=${tagMC} --check                        
#./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep M400to500` --isMC --type MINIAOD --scheduler=${where} --tag=${tagMC} --check                        
#./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep M500to700` --isMC --type MINIAOD --scheduler=${where} --tag=${tagMC} --check                        
#/scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep DYToEE_amcatnlo` --isMC --type MINIAOD --scheduler=${where} --tag=${tagMC} --check                   
#./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep DYToEE_powheg | grep MiniAODv2` --isMC --type MINIAOD --scheduler=${where} --tag=${tagMC} --check   
#./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep ZToEE | grep M_200_400` --isMC --type MINIAOD --scheduler=${where} --tag=${tagMC} --check           
#./scripts/prodNtuples.sh `parseDatasetFile.sh alcareco_datasets.dat | grep ZToEE | grep M_400_800` --isMC --type MINIAOD --scheduler=${where} --tag=${tagMC} --check           


```

