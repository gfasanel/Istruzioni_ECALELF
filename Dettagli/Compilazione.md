[19:42:58] Paolo Meridiani: dentro Calibration
 ora devi fare git remote add paolo ......
[19:43:17] Paolo Meridiani: e poi git checkout paolo/eleNew...
[19:43:26] Paolo Meridiani: e poi torni indietro (a src)
[19:43:35] Paolo Meridiani: e git-cms-merge-topic pmeridian:regression_74X
[19:43:42] Paolo Meridiani: e poi da src
[19:43:45] Paolo Meridiani: scram b -j 8

[19:43:48] Giuseppe Fasanella: torno indietro dove?
[19:43:52] Paolo Meridiani: a src
[19:44:03] Paolo Meridiani: visto che Calibration
[19:44:09] Paolo Meridiani: e` scaricato da ECALELF
[19:44:12] Paolo Meridiani: mentre il resto di cmssw
[19:44:17] Paolo Meridiani: ha un altro repository
[19:44:24] Paolo Meridiani: e ogni volta che devi compilare tutto
[19:44:28] Paolo Meridiani: devi essere in src
[19:44:43] Paolo Meridiani: visto che scram b compila diversamente
[19:44:47] Paolo Meridiani: a seconda di dove sei
