Step1 si occupa della stabilita' della scala in funzione del tempo

Preliminarmente hai bisogno di:
* un file di *run limits*, ossia un file che fissi i paletti: a questo run comincia Bon, a questo BOff ecc...
* piazza il file coi paletti in `data/runRanges/runRangeLimits.dat`
* decidere il run range: es. 100.000 run per "calibrazione di scala"

A questo punto puoi produrre il file con i run limits, da usare per lo step1

```
./script/divider_run.sh data/validation/Rereco_December2015.dat 100000
```

```
~lcorpe/public/Guiseppe/ here you find 3 things 
1. my runRanges file (25ns, interval of ~50k runs) 
2.the personal macro i use to generate that (lcrundivide.sh)
--> usage lcrundivide $yourDatfile (from data/validation...) $interval (eg 50000) will create your file here 
: data/runRanges/monitoringRun2015-25ns-interval_${interval}.dat 
3. run limits, to be placed in data/runRanges/. : 
tells the script where the different (eg 2015C, D, bOn, bOff) start and begin 
./script/energyScale.sh --step=1 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass_SC --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat
```


