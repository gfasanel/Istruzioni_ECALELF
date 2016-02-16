Ti scrivi il tuo file con dati e MC
```
./script/Init_HighMass_calibration_procedure.sh\
 data/validation/February2016_76_Rereco_HighMass.dat invMass_SC_pho_regrCorr

./script/calibration_highMass.sh\
 data/validation/February2016_76_Rereco_HighMass.dat invMass_SC_pho_regrCorr CatOnly

#######################Controlla da categorizzazione
./bin/ZFitter.exe -f data/validation/miniAOD_November2015.dat --regionsFile=data/regions/scaleStep0.dat\
 --saveRootMacro --invMass_var=invMass_SC_pho_regrCorr
./script/hadder.sh
root -l tmp/d_chain.root tmp/s_chain.root macro/load_dataMC.C
data->Draw("invMass_SC_pho_regrCorr","smearerCat[0]>0")
#######################

#########Prima di lanciare 50 jobs, controlla che il minimo della likelihood sia ben preso
##Test_job
./script/calibration_highMass.sh data/validation/February2016_76_Rereco_HighMass.dat\
 invMass_SC_pho_regrCorr Test_job

##Fit Test_job
#####scala ristretta
./script/fit.sh test/dato/fitres/outProfile_ptRatio_pt2Sum_random_scaleStep0_Et_35_noPF.root
mv test/dato/img/outProfile_ptRatio_pt2Sum_random_scaleStep0_Et_35_noPF*.png ~/scratch1/www/RUN2_ECAL_Calibration/tmp/
#####scala ampia
root -l -b
.L macro/fitOneProfile.C
fitOneProfile("test/dato/fitres/outProfile_ptRatio_pt2Sum_random_scaleStep0_Et_35_noPF.root","~/scratch1/www/RUN2_ECAL_Calibration/tmp/")
.q
#Data MC plots
root -l -b
.L macro/plot_data_mc.C+
PlotMeanHist("test/dato/fitres/histos_ptRatio_pt2Sum_random_scaleStep0_Et_35_noPF.root")
.q
mv test/dato/./img/histos_ptRatio_pt2Sum_random_scaleStep0_Et_35*.png ~/scratch1/www/RUN2_ECAL_Calibration/tmp/

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
