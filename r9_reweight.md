TFile* f = TFile::Open("transformation.root");
TGraph* gR9EB = (TGraph*) f->Get("transformR90");

e poi quando usi R9:
float r9prime = gR9EB->Eval(r9);


  KEY: TGraph    transformR90;1    Graph (EB)
  KEY: TGraph    transformR91;1    Graph (EE)

Per applicarla devi fare cosi`:

TFile* f = TFile::Open("transformation.root");
TGraph* gR9EB = (TGraph*) f->Get("transformR90");

e poi quando usi R9:
float r9prime = gR9EB->Eval(r9);
