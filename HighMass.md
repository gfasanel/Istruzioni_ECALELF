Parti da un file bare con dati e MC
```
./script/Init_HighMass_calibration_procedure.sh\
 data/validation/February2016_76_Rereco_HighMass.dat invMass_SC_pho_regrCorr

./script/calibration_highMass.sh\
 data/validation/February2016_76_Rereco_HighMass.dat invMass_SC_pho_regrCorr CatOnly

#######################Controlla da categorizzazione
./bin/ZFitter.exe -f data/validation/February2016_76_Rereco_HighMass.dat\
 --regionsFile=data/regions/scaleStep0.dat\
 --saveRootMacro --invMass_var=invMass_SC_pho_regrCorr
./script/hadder.sh
root -l tmp/d_chain.root tmp/s_chain.root macro/load_dataMC.C
data->Draw("invMass_SC_pho_regrCorr","smearerCat[0]>0")
# In questo caso smearerCat[0] ==0 (EBEB), 1 (EBEE), 2 (EEEE)
# smearerCat[1] serve solo a dire se ele1 ed ele2 sono swappati
#######################

#########Prima di lanciare 50 jobs, controlla che il minimo della likelihood sia ben preso
##Test_job
./script/calibration_highMass.sh data/validation/February2016_76_Rereco_HighMass.dat\
 invMass_SC_pho_regrCorr Test_job | tee debug.txt
 # troverai i fit e il data/MC in HighMass/temp

#####scala ampia (puoi farla con il mio metodo)
root -l -b
.L macro/fitOneProfile.C
fitOneProfile("test/dato/fitres/outProfile_ptRatio_pt2Sum_random_scaleStep0_Et_35_noPF.root","~/scratch1/www/RUN2_ECAL_Calibration/tmp/")
.q

##If you need initParameters
mv test/dato/img/outProfile_ptRatio_pt2Sum_random_scaleStep0_Et_35_noPF-FitResult-.config\
init_Parameters/highMass_RUN2.dat

E modifichi il dat file con i valori di inizializzazione che piu' ti soddisfano

####Rilancia Test_job con initParameters
./script/calibration_highMass.sh data/validation/February2016_76_Rereco_HighMass.dat\
 invMass_SC_pho_regrCorr Test_job --initFile=init_Parameters/highMass_RUN2.dat 

(e controlla che ora la likelihood trovi un bel minimo)

####Sottometti 50 job
./script/calibration_highMass.sh data/validation/February2016_76_Rereco_HighMass.dat\
 invMass_SC_pho_regrCorr jobs --initFile=init_Parameters/highMass_RUN2.dat 
 
 ####Likelihood plots, data_MC e dat file
./script/calibration_highMass.sh data/validation/February2016_76_Rereco_HighMass.dat\
 invMass_SC_pho_regrCorr finalize_plots
 
 ####Slides (not yet implemented)
./script/calibration_highMass.sh data/validation/February2016_76_Rereco_HighMass.dat\
 invMass_SC_pho_regrCorr slide
```
