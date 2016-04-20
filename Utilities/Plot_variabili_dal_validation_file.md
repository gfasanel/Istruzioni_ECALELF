Plottare le variabili del validation file
```
./bin/ZFitter.exe -f $validation_file\
 --regionsFile=$region_file --corrEleType=$corr_type --smearEleType=$smear_type invMass_var=$invMass --saveRootMacro
./script/hadder.sh
root -l -b tmp/d_chain.root tmp/s_chain.root macro/load_dataMC.C macro/massPlotter.C
```
