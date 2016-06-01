```
rm tmp/*.root
./bin/ZFitter.exe -f data/validation/test_ICHEP.dat --regions=data/regions/x.dat --saveRootMacro
#./bin/ZFitter.exe -f data/validation/test_ICHEP.dat --regions=data/regions/x.dat --saveRootMacro
./script/hadder.sh
root -l -b tmp/d_chain.root tmp/s_chain.root macro/load_dataMC.C ~/rootlogon.C

#if you want to add 2 MCS
root -l -b tmp/d_chain.root tmp/s1_chain.root tmp/s2_chain.root macro/load_data_2MCs.C ~/rootlogon.C
```
