```
  KEY: TGraph    transformR90;1    Graph (EB)
  KEY: TGraph    transformR91;1    Graph (EE)
```
```
TFile* f = TFile::Open("~gfasanel/public/R9_transformation/transformation.root");
TGraph* gR9EB = (TGraph*) f->Get("transformR90");
TGraph* gR9EE = (TGraph*) f->Get("transformR91");
#e poi quando usi R9:
float r9prime = gR9EB->Eval(r9);
float r9prime = gR9EE->Eval(r9);

```
