Step1 si occupa della stabilita' della scala in funzione del tempo

```
~lcorpe/public/Guiseppe/ here you find 3 things 
1. my runRanges file (25ns, interval of ~50k runs) 
2.the personal macro i use to generate that (lcrundivide.sh) --> usage lcrundivide $yourDatfile (from data/validation...) $interval (eg 50000) will create your file here 
: data/runRanges/monitoringRun2015-25ns-interval_${interval}.dat 
3. run limits, to be placed in data/runRanges/. : tells the script where the different (eg 2015C, D, bOn, bOff) start and begin 
rm -r test/MC/pufileData_tot/ rm -r test/dato/miniAOD_November2015/ 
./script/energyScale.sh --step=1 -f data/validation/miniAOD_November2015.dat --invMass_var=invMass_SC --runRangesFile=data/runRanges/monitoringRun2015-25ns-interval_50000.dat
```
