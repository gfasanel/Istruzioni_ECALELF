##Calibrazione al RUN2
0 (per essere veloce). Solo le 8 categorie eta*r9

L'organizzazione e': concetti (do this), definizione delle macro (do this == xxx) e caller
script/step2_only_caller.sh che chiama script/calibration_8_categories.sh.
Le funzioni sono definite in script/bash_functions_calibration_step2.sh

**Init**

Parti da un .dat file con dati e MC 

1-Aggiungi il branch r9

2-fai i pileupHist

3-dai pileupHist dai i pileupTrees

4-riscriviti il dat file con i friend trees appena creati

5-scrivi anche il file rundivide in data/runRanges/....

```
./script/Init_calibration_procedure.sh data/validation/my_test.dat
```

**Step1**

runRange * eta (fa sia step1 che step1 stability)
```
#da chiamare in una sessione screen perche' ci vogliono diverse ore
./script/step1_maker.sh data/validation/my_test.dat 100000 invMass_SC_corr
```
```
PUName: d_pileupHist_pu_data_my_test
mcName: 
con queste vengono costruiti i nomi delle cartelle
```
**Step2**

step2 e' fatto on top of step1
```
./script/step2_maker.sh data/validation/my_test.dat 100000 invMass_SC_corr Categorize
./script/step2_maker.sh data/validation/my_test.dat 100000 invMass_SC_corr Test_job
```

