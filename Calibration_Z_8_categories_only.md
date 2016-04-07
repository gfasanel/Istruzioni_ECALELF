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
 
 ./script/Corrections_maker.sh\
 data/validation/February2016_Rereco_76.dat invMass_SC_pho_regrCorr no_scale_corr Zcorr_76_stoc
#Categorizza nelle regioni di Et
./script/calibration_8_categories.sh\
 data/validation/February2016_Rereco_76.dat invMass_SC_pho_regrCorr CatOnly
#Controlla lo scarto nelle correzioni in funzione dei bin di Et
./script/calibration_8_categories.sh\
 data/validation/February2016_Rereco_76.dat invMass_SC_pho_regrCorr Closure_Et
./script/calibration_8_categories.sh\
 data/validation/February2016_Rereco_76.dat invMass_SC_pho_regrCorr Closure_Et_stoc


./script/fit.sh test/dato/fitres/stochastic_smearing_applied/outProfile-${region1}-${CommonCuts}.root EE-Et_0_50-Et_20-noPF

./script/fit.sh test/dato/fitres/stochastic_smearing_applied/outProfile-scaleStep0_et_2-Et_20-noPF.root EE-Et_85_120-Et_20-noPF scale

./script/fit.sh test/dato/fitres/stochastic_smearing_applied/outProfile-scaleStep0_et_2-Et_20-noPF.root EE-Et_85_120-Et_20-noPF scale 3 5


./script/fit.sh test/dato/fitres/stochastic_smearing_applied/outProfile-scaleStep0_et_2-Et_20-noPF.root All scale
mv test/dato/img/stochastic_smearing_applied/outProfile-scaleStep0_et_2-Et_20-noPF-*.png ~/scratch1/www/RUN2_ECAL_Calibration/February2016_Rereco_76_invMass_SC_pho_regrCorr/temp_stoc/

./script/Closure_et_wrapper.sh
```
