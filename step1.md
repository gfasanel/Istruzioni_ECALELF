Step1 si occupa della stabilita' della scala in funzione del tempo e di eta

Lo step1 fitta i dati con una Breit-Wigner convoluta con una Crystal Ball e anche il MC con la stessa funzione di fit;
e lo fa in funzione del runRange, quindi del tempo.

--> L'idea dello step1 e' quella di riportare ad ogni tempo la scala dei dati a quella del MC

Preliminarmente hai bisogno di:
* un file di *run limits*, ossia un file che fissi i paletti: a questo run comincia Bon, a questo BOff ecc...
* piazza il file coi paletti in `data/runRanges/runRangeLimits.dat`
* decidere le lumisection per run-range: es. 100.000 run per "calibrazione di scala"
* creare i pileupHist per i dati

A questo punto puoi produrre il file con i run limits, da usare per lo step1

```
./script/divider_run.sh data/validation/Rereco_December2015.dat 100000
# ti trovi quindi
emacs data/runRanges/Rereco_December2015_interval_100000.dat
```
Una volta ottenuto il file con i run ranges puoi lanciare lo step1 (da una sessione screen perche' impiega molto tempo)

`Screen_init step1 011`
, chiamando kinit 2 volte e cmsenv basta una volta sola alla fine
```
./script/step1_maker.sh file runrage.dat
```

```
./script/energyScale.sh --step=1 -f data/validation/Rereco_December2015.dat --invMass_var=invMass_SC_corr --runRangesFile=data/runRanges/data/runRanges/Rereco_December2015_interval_100000.dat
./script/energyScale.sh --step=1stability -f data/validation/Rereco_December2015.dat --invMass_var=invMass_SC_corr --runRangesFile=data/runRanges/data/runRanges/Rereco_December2015_interval_100000.dat
```



step1_2.md va mergiato con questo
