```
FILE=data/validation/0T_February2016_data_76_photonlikeID.dat
INTERVAL=200000
./script/Init_calibration_procedure.sh ${FILE} ${INTERVAL} #r9eleprime, pileupHist and trees

./script/calibration_8_categories.sh\
${FILE} invMass_SC_pho_regrCorr Init (--selection=medium25nsRun2Boff --initFile=xxx)
 
 ######Init e' equivalente a CatOnly e poi Test_job
 
 ```
