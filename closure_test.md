https://github.com/gfasanel/cmssw/blob/my_understanding/Calibration/ZFitter/Instructions/closure_test.md

In estrema sintesi e' questo che devi fare:
```
./script/calibration_8_categories.sh\
 data/validation/test_ICHEP.dat invMass_SC_pho_regrCorr CatOnly

./bin/ZFitter.exe -f data/validation/test_ICHEP.dat --regionsFile=data/regions/scaleStep2smearing_1_R9prime_et.dat --invMass_var=invMass_SC_pho_regrCorr --commonCut=Et_20-noPF --autoBin --smearerFit --noPU --runToy --initFile=init_test_ICHEP_toy.dat --onlyScale
```
