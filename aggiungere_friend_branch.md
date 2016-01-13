Aggiungere un certo friend branch: es branch ZPt, perche' ci categorizzi sopra, ad esempio:
```
./bin/ZFitter.exe -f data/validation/22Jan2012-runDepMCAll_checkMee.dat --regionsFile=data/regions/scaleStep0.dat --addBranch=ZPt --corrEleType=HggRunEtaR9Et --smearEleType=stochastic --saveRootMacro &> debug.txt 
./script/hadder.sh 
mv tmp/ZPt_* friends/other/
```
Aggiungi i branch di ZPt nel validation file
