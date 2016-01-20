##Calibrazione al RUN2

**Step 0: Farsi le ntuple**
https://github.com/GiuseppeFasanella/Istruzioni_ECALELF/blob/master/Ntuple_ECALELF.md
https://github.com/GiuseppeFasanella/Istruzioni_ECALELF/blob/master/Sottomissione_ntuple.sh

**0 (per essere veloce). Solo le 8 categorie eta*r9**

L'organizzazione e': concetti (do this), definizione delle macro (do this == xxx) e caller
script/step2_only_caller.sh che chiama script/calibration_8_categories.sh.
Le funzioni sono definite in script/bash_functions_calibration_step2.sh

**Init**

Parti da un .dat file con dati e MC 
```
./script/Init_calibration_procedure.sh data/validation/my_test.dat

#Si fanno queste cose
1-Aggiungi il branch r9
2-fai i pileupHist
3-dai pileupHist dai i pileupTrees
4-riscriviti il dat file con i friend trees appena creati
5-scrivi anche il file rundivide in data/runRanges/....
```
* Controlla che il branch aggiunto r9 sia sensato
```
 ./bin/ZFitter.exe -f data/validation/my_test.dat --addBranch=R9Eleprime --saveRootMacro --regionsFile=data/regions/scaleStep0.dat 
./script/hadder.sh
root -l tmp/d_chain.root tmp/s_chain.root macro/load_dataMC.C
data->Draw("R9Eleprime[0]")
signalA->Draw("R9Eleprime[0]")
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
./script/step2_maker.sh data/validation/my_test.dat 100000 invMass_SC_corr Submit_jobs
./script/step2_maker.sh data/validation/my_test.dat 100000 invMass_SC_corr Fit_and_plot
./script/step2_maker.sh data/validation/my_test.dat 100000 invMass_SC_corr write_down_corr_step1_step2
```

