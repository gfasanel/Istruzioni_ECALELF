Ci sono due modi

```
##Fit Test_job
#####scala ristretta
./script/fit.sh test/dato/fitres/outProfile_ptRatio_pt2Sum_random_scaleStep0_Et_35_noPF.root
mv test/dato/img/outProfile_ptRatio_pt2Sum_random_scaleStep0_Et_35_noPF*.png ~/scratch1/www/RUN2_ECAL_Calibration/tmp/
#####scala ampia
root -l -b
.L macro/fitOneProfile.C
fitOneProfile("test/dato/fitres/outProfile_ptRatio_pt2Sum_random_scaleStep0_Et_35_noPF.root","~/scratch1/www/RUN2_ECAL_Calibration/tmp/")
.q
```
