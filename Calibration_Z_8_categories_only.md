```
L'organizzazione e': concetti (do this), definizione delle macro (do this == xxx) e caller
script/step2_only_caller.sh che chiama script/calibration_8_categories.sh.
Le funzioni sono definite in script/bash_functions_calibration.sh
```

* Specifica la regione in script/calibration_8_categories.sh

```
FILE=data/validation/0T_February2016_data_76_photonlikeID.dat
INTERVAL=100000
./script/Init_calibration_procedure.sh ${FILE} ${INTERVAL} #r9eleprime, pileupHist and trees

./script/calibration_8_categories.sh\
 ${FILE} invMass_SC_pho_regrCorr Init --selection=diphotonIso25nsRun2Boff (--selection=medium25nsRun2Boff --initFile=xxx)
 
 ######Init e' equivalente a CatOnly e poi Test_job
 Tipicamente vorrai fare piu' Test_job per controllare varie cose
 ./script/calibration_8_categories.sh\
 ${FILE} invMass_SC_pho_regrCorr Test_job --selection=diphotonIso25nsRun2Boff
 
 ```
### Closure test in Et

Apri script/calibration_8_categories.sh e specifica le regioni e i commonCuts
scaleStep0_et
scaleStep0_et_2
Et_20-noPF 

```
#Carica le correzioni che hai
./script/Corrections_maker.sh\
 data/validation/February2016_Rereco_76.dat invMass_SC_pho_regrCorr Zcorr_76 Zcorr_76
#Categorizza nelle regioni di Et
./script/calibration_8_categories.sh\
 data/validation/February2016_Rereco_76.dat invMass_SC_pho_regrCorr CatOnly
#Controlla lo scarto nelle correzioni in funzione dei bin di Et
./script/calibration_8_categories.sh data/validation/February2016_Rereco_76.dat invMass_SC_pho_regrCorr Closure_Et

./script/Closure_et_wrapper.sh
```
