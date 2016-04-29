```
rm tmp/*.root
#./bin/ZFitter.exe -f data/validation/test_ICHEP.dat --regions=data/regions/scaleStep2smearing_1_R9prime.dat --saveRootMacro
./bin/ZFitter.exe -f data/validation/test_ICHEP.dat --regions=data/regions/scaleStep2smearing_2_R9prime.dat --saveRootMacro
./script/hadder.sh
root -l -b tmp/d_chain.root tmp/s_chain.root macro/load_dataMC.C ~/rootlogon.C
```
