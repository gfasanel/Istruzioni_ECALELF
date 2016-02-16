src/ElectronCategory_class.cc
va modificato per inserire il tuo taglio
```
make
 ./bin/ZFitter.exe -f data/validation/December2015_Rereco_C_D.dat --regionsFile=data/regions/scaleStep0.dat --saveRootMacro
 ./script/hadder.sh
 root -l tmp/d_chain.root tmp/s_chain.root macro/load_dataMC.C
 ###Ora, e solo ora, puoi usare i metodi di GetCut
 TCut c=GetCut("r9primep_97")
 c.Print()
 ```
