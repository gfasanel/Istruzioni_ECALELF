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
