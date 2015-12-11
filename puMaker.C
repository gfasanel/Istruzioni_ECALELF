{
  TTree* t0 = (TTree*)  _file0->Get("selected");
  t0->Draw("nPV+1>>pileup(60,0,60)");
  TH1F *h0 = (TH1F *) gROOT->FindObject("pileup");
  h0->SaveAs("puC.root");

  TTree* t1 = (TTree*)  _file1->Get("selected");
  t1->Draw("nPV+1>>pileup(60,0,60)");
  TH1F *h1 = (TH1F *) gROOT->FindObject("pileup");
  h1->SaveAs("puD1.root");

  TTree* t2 = (TTree*)  _file2->Get("selected");
  t2->Draw("nPV+1>>pileup(60,0,60)");
  TH1F *h2 = (TH1F *) gROOT->FindObject("pileup");
  h2->SaveAs("puD2.root");

  TH1F * h0 = (TH1F*) _file0->Get("pileup");
  TH1F * h1 = (TH1F*) _file1->Get("pileup");
  TH1F * h1 = (TH1F*) _file2->Get("pileup");
  TH1F *htot = new TH1F ("pileup","pileup",60,0,60);
  htot->Add(h0,1);
  if (h1){
    htot->Add(h1,1);
  }
  if (h2){
    htot->Add(h2,1);
  }
  htot->SaveAs("pufileData_tot.root")

}
