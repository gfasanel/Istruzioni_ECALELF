##Calibrazione al RUN2

**Step 0: Farsi le ntuple**
https://github.com/GiuseppeFasanella/Istruzioni_ECALELF/blob/master/Ntuple_production/Ntuple_ECALELF.md
https://github.com/GiuseppeFasanella/Istruzioni_ECALELF/blob/master/Ntuple_production/Sottomissione_ntuple.sh

**Init**

!!Assicurati che il branch di massa sia specificato SIA in bin/ZFitter.cpp SIA in src/ZFit_class.cc altrimenti gli istogrammi dei fit o delle likelihood sono vuoti!!
Parti da un .dat file con dati e MC, qualcosa cosi'
```
#nota i tab!!
d1      selected     root://eoscms//eos/cms/store/group/dpg_ecal/alca_ecalcalib/ecalelf/ntuples/13TeV/MINIAODNTUPLE/74X_dataRun2_Prompt_v4/DoubleEG-ZSkim-Run2\
015C-rereco05Oct2015-MINIAOD/254227-255031/246908-260627-Prompt_25ns-v1-golden_silver/unmerged-allRange-miniAOD.root

s1      selected    root:://eoscms//eos/cms/store/group/dpg_ecal/alca_ecalcalib/ecalelf/ntuples/13TeV/MINIAODNTUPLE/74X_mcRun2_asymptotic_v2/DYJets_amctnlo-Ru\
nIISpring15MiniAODv2-Asym25ns-miniAOD-withPho/allRange/merged.root
```
```
./script/Init_calibration_procedure.sh\
 data/validation/my_test.dat 100000 invMass_SC_corr

#Si fanno queste cose
1-Aggiungi il branch r9
2-fai i pileupHist
3-dai pileupHist dai i pileupTrees
4-riscriviti il dat file con i friend trees appena creati
5-scrivi anche il file rundivide in data/runRanges/....
```
* Controlla che il branch aggiunto r9 sia sensato
```
 ./bin/ZFitter.exe -f data/validation/my_test.dat\
  --addBranch=R9Eleprime --saveRootMacro --regionsFile=data/regions/scaleStep0.dat 
./script/hadder.sh
root -l tmp/d_chain.root tmp/s_chain.root macro/load_dataMC.C
data->Draw("R9Eleprime[0]")
signalA->Draw("R9Eleprime[0]")
#ho scritto una macro stupida di confronto macro/R9comp.C
```

*Controlla anche che i nomi delle cartelle che saranno creati in step1 siano sensati
```
./script/step0_maker.sh data/validation/my_test.dat 100000 invMass_SC_corr
```
Se, ad esempio qualche variabile e' vuota/strana vuol dire che functions.sh -> mcName, ad esempio, si sta confondendo con i tab --> provvedi!

**Apri screen e fagli fare gli step in cascata**
```
./script/steps_maker.sh\
 data/validation/December2015_Rereco_C_D_withPho.dat 100000 invMass_SC_pho_regrCorr
```

*****Vediamo ora in dettaglio cosa fanno i vari step********

**Step1**

runRange * eta (fa sia step1 che step1 stability)
```
#da chiamare in una sessione screen perche' ci vogliono diverse ore
./script/step1_maker.sh data/validation/my_test.dat 100000 invMass_SC_corr
```
```
PUName: d_pileupHist_pu_data_my_test
mcName: 
con queste vengono costruiti i nomi delle cartelle
```
**Step2**

step2 e' fatto on top of step1
```
./script/step2_maker.sh data/validation/my_test.dat 100000 invMass_SC_corr Categorize
./script/step2_maker.sh data/validation/my_test.dat 100000 invMass_SC_corr Test_job
./script/step2_maker.sh data/validation/my_test.dat 100000 invMass_SC_corr Submit_jobs
./script/step2_maker.sh data/validation/my_test.dat 100000 invMass_SC_corr Fit_and_plot
./script/step2_maker.sh data/validation/my_test.dat 100000 invMass_SC_corr write_down_corr_step1_step2
```

(in realta' con scripts/steps_maker.sh hai gia' fatto tutto: pubblicato i plot sulla web page e tutto)

**Scrivere le tabelle**
```
1) Scrivere una tabella dal dat file del fit:
./script/latex_table_writer.sh $file $commonCut (file e' cio' che ti sputa fuori la procedura di fitting)

2) ./script/write_all_syst.sh che sostanzialmente si fa la lista e poi compare (vedi sotto)
Nom_file="test/dato/December2015_Rereco_C_D/loose/invMass_SC_corr/table/outFile-step2-invMass_SC_corr-loose-Et_20-noPF-HggRunEtaR9.dat"
Syst_files="test/dato/December2015_Rereco_C_D_withPho/loose/invMass_SC_pho_regrCorr/table/outFile-step2-invMass_SC_pho_regrCorr-loose-Et_20-noPF-HggRunEtaR9.dat"
./script/compare_datFiles.sh $Nom_file $Syst_files

3) Edita, scegliendo i max, cosa mettere e cosa no

4) ./script/add_quadrature_syst_table.sh tmp/syst_scale.dat
```
