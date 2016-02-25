in src/EnergyScaleCorrection_class.cc

ReadSmearingFromFile (per gli smearing)

ReadFromFile (per la scala)

e' lui il responsabile: si aspetta un file di scala, smearing in un certo formato e se non sono scritti bene, impazzisce, filla a caso le correzioni: quindi stai attento

Se ti stampa a schermo
```
[ERROR] Category not found:
256003 256003 1.30085 1.30085 11.5027 11.5027 9.24192 9.24192
```

Ti sta stampando:
```
runMin runMax etaMin etaMax r9Min r9Max etMin etMax
```

cosi' dovresti capire se e' giusto oppure no che non trovi la categoria
