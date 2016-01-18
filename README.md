##Calibrazione al RUN2
0 (per essere veloce). Solo le 8 categorie eta*r9

L'organizzazione e': concetti (do this), definizione delle macro (do this == xxx) e caller
script/step2_only_caller.sh che chiama script/calibration_8_categories.sh.
Le funzioni sono definite in script/bash_functions_calibration_step2.sh

**Init**
Parti da un .dat file con dati e MC e poi aggiungi i branch di categoria, fai i pileupHist e poi i pileupTrees e riscriviti il dat file con tutte queste modifiche

```
./script/Init_calibration_procedure.sh data/validation/my_test.dat
```

**Step1**
```
./script/addBranch.sh per aggiungere il branch R9Eleprime
./script/step1_maker.sh
```

**Step2**
2 step2 on top of step1
```
./script/step2_maker.sh aggiungere SCENARIO come variabile, per spezzare la cosa in piu' parti
```

