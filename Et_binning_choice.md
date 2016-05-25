```
rm tmp/*.root
./bin/ZFitter.exe -f data/validation/test_ICHEP.dat --regions=data/regions/scaleStep2smearing_1_R9prime.dat --saveRootMacro
#./bin/ZFitter.exe -f data/validation/test_ICHEP.dat --regions=data/regions/scaleStep2smearing_2_R9prime.dat --saveRootMacro
./script/hadder.sh
root -l -b tmp/d_chain.root tmp/s_chain.root macro/load_dataMC.C ~/rootlogon.C

.x macro/Cat_histos.C
.x macro/scalerHistos.C 
python macro/quantile.py
```

```
root
.L Loop_friend.C++
Ht_study(double Ht_min, double Ht_max)
```

```
Bin  0  Stat:  20158.1996975
Bin  1  Stat:  26708.3999023
Bin  2  Stat:  56343.6003418
Bin  3  Stat:  20692.8007812
Bin  4  Stat:  40192.1992188
Bin  5  Stat:  40192.1992188
Bin  6  Stat:  30277.8007812
Bin  7  Stat:  30277.8007812
Bin  8  Stat:  16453.8002663
Bin  9  Stat:  16156.8000007
Bin  10  Stat:  12301.2002206


Et_min_list  [2.5, 37.5, 40.0, 42.5, 45.0, 45.0, 47.5, 47.5, 50.0, 55.0, 77.5]
Et_max_list  [37.5, 40.0, 42.5, 42.5, 45.0, 45.0, 47.5, 47.5, 55.0, 77.5, 502.5]

Ht_study(0,75)
5.48823e+06
75,80
2.04922e+06
80-85
2.63956e+06
170078
85-90
3.03363e+06
320387
90-95
2.25686e+06
333153
95-100
1.04966e+06
142333
100-200
2.19343e+06
277900
200-400
127327
21913.2
400-800
9255.6
800-1000
275.4
```



