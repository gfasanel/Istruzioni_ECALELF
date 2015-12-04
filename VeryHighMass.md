./bin/ZFitter.exe -f data/validation/miniAOD_highMass.dat --regionsFile=data/regions/scaleStep0_VeryhighMass.dat --smearEleType=stochastic --smearEleFile=/afs/cern.ch/work/g/gfasanel/CMSSW_7_4_15/src/Calibration/ZFitter/mc_smear/smearing_corrections_RUN2.dat --saveRootMacro --invMass_var=invMass_SC_corr
mv tmp/smearEle_stochastic*miniAOD_highMass.root friends/others/

echo "s1      smearEle_stochastic     friends/others/smearEle_stochastic_s1-miniAOD_highMass.root" >> data/validation/miniAOD_highMass.dat
echo "s2      smearEle_stochastic     friends/others/smearEle_stochastic_s2-miniAOD_highMass.root" >> data/validation/miniAOD_highMass.dat
echo "s3      smearEle_stochastic     friends/others/smearEle_stochastic_s3-miniAOD_highMass.root" >> data/validation/miniAOD_highMass.dat
echo "s4      smearEle_stochastic     friends/others/smearEle_stochastic_s4-miniAOD_highMass.root" >> data/validation/miniAOD_highMass.dat

Fai le categorie:
./bin/ZFitter.exe -f data/validation/miniAOD_highMass.dat --regionsFile=data/regions/scaleStep0_VeryhighMass.dat --addBranch=smearerCat invMass_var=invMass_SC_corr --saveRootMacro
./script/hadder.sh
root -l tmp/d_chain.root macro/load_singleFile.C
root -l tmp/s_chain.root macro/load_singleFile.C
data->Draw("invMass_SC_corr","smearerCat[0]>=0")

mv tmp/smearerCat_scaleStep0_VeryhighMass* friends/smearerCat/ 

echo "s1      smearerCat_scaleStep0_VeryhighMass     friends/smearerCat/smearerCat_scaleStep0_VeryhighMass_s1-miniAOD_highMass.root" >> data/validation/miniAOD_highMass.dat
echo "s2      smearerCat_scaleStep0_VeryhighMass     friends/smearerCat/smearerCat_scaleStep0_VeryhighMass_s2-miniAOD_highMass.root" >> data/validation/miniAOD_highMass.dat
echo "s3      smearerCat_scaleStep0_VeryhighMass     friends/smearerCat/smearerCat_scaleStep0_VeryhighMass_s3-miniAOD_highMass.root" >> data/validation/miniAOD_highMass.dat
echo "s4      smearerCat_scaleStep0_VeryhighMass     friends/smearerCat/smearerCat_scaleStep0_VeryhighMass_s4-miniAOD_highMass.root" >> data/validation/miniAOD_highMass.dat
echo "d1      smearerCat_scaleStep0_VeryhighMass     friends/smearerCat/smearerCat_scaleStep0_VeryhighMass_d1-miniAOD_highMass.root" >> data/validation/miniAOD_highMass.dat
echo "d2      smearerCat_scaleStep0_VeryhighMass     friends/smearerCat/smearerCat_scaleStep0_VeryhighMass_d2-miniAOD_highMass.root" >> data/validation/miniAOD_highMass.dat
echo "d3      smearerCat_scaleStep0_VeryhighMass     friends/smearerCat/smearerCat_scaleStep0_VeryhighMass_d3-miniAOD_highMass.root" >> data/validation/miniAOD_highMass.dat

./bin/ZFitter.exe -f data/validation/miniAOD_highMass.dat --regionsFile=data/regions/scaleStep0_VeryhighMass.dat --invMass_var=invMass_SC_corr --commonCut=Et_35-noPF-DeltaEta_2 --autoBin --smearerFit --plotOnly --targetVariable=ptRatio*pt2Sum --targetVariable_min=0.5*0 --targetVariable_max=2*900 --targetVariable_binWidth=0.001*6 --configuration=random --corrEleType=EtaR9 --smearEleType=stochastic 

root -l -b
.L macro/plot_data_mc.C+
PlotMeanHist("test/dato/fitres/histos_ptRatio_pt2Sum_random_scaleStep0_VeryhighMass_Et_35_noPF_DeltaEta_2.root")
.q
mv test/dato/img/histos_ptRatio_pt2Sum_random_scaleStep0_VeryhighMass_Et_35_no*.png ~/scratch1/www/M_500
