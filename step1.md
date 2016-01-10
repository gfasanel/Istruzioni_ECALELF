Step1 si occupa della stabilita' della scala in funzione del tempo

Preliminarmente hai bisogno di:
* un file di *run limits*, ossia un file che fissi i paletti: a questo run comincia Bon, a questo BOff ecc...
* piazza il file coi paletti in `data/runRanges/runRangeLimits.dat`
* decidere le lumisection per run-range: es. 100.000 run per "calibrazione di scala"

A questo punto puoi produrre il file con i run limits, da usare per lo step1

```
./script/divider_run.sh data/validation/Rereco_December2015.dat 100000
# ti trovi quindi
emacs data/runRanges/Rereco_December2015_interval_100000.dat
```

