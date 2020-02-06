unit uFrmDemonstrativoRD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,uUtil,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, udmConexao,uDMRD, uFramePeriodo, uDMOrganizacao,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, frxClass, frxExportCSV,
  frxExportPDF, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, Vcl.ExtCtrls, VCLTee.TeeProcs,
  VCLTee.Chart, VCLTee.DBChart, VCLTee.Series, VCLTee.ArrowCha;

type
  TfrmDemonstrativoRD = class(TForm)
    frmPeriodo1: TfrmPeriodo;
    dbgrdReceitas: TDBGrid;
    dbgrdDespesas: TDBGrid;
    lbl1: TLabel;
    lbl2: TLabel;
    btnConfirma: TButton;
    dsReceitas: TDataSource;
    dsDespesas: TDataSource;
    btnImprimir: TButton;
    edtValorDespesa: TEdit;
    edtValorReceita: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  idOrganizacao :String;
  vlrReceitas, vlrDespesas : Currency;

    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM;
    procedure exibirRelatorioExportacao(dtInicial, dtFinal: TDate);
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    function retornarCaminhoRelatorio: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDemonstrativoRD: TfrmDemonstrativoRD;

implementation

{$R *.dfm}


procedure TfrmDemonstrativoRD.inicializarDM(Sender: TObject);
begin


  idOrganizacao := uutil.TOrgAtual.getId;

  if not(Assigned(dmRD)) then
  begin
    dmRD := TdmRD.Create(Self);
  end;

end;


procedure TfrmDemonstrativoRD.freeAndNilDM();
begin

  if (Assigned(dmRD)) then
  begin
       FreeAndNil(dmRD);
  end;

end;


procedure TfrmDemonstrativoRD.btnConfirmaClick(Sender: TObject);
begin
vlrDespesas :=0; vlrReceitas :=0;
edtValorDespesa.Text :=  FormatFloat('#,.##',vlrDespesas);
edtValorReceita.Text :=  FormatFloat('#,.##',vlrReceitas);
 if uutil.Empty(idOrganizacao) then begin
    idOrganizacao := uUtil.TOrgAtual.getId;
 end;



   if frmPeriodo1.validarPeriodo then begin

      if (dmRD.obterDespesas(idOrganizacao,frmPeriodo1.getDataInicial, frmPeriodo1.getDataFinal)) then begin
           TFDQuery(dbgrdDespesas.DataSource.DataSet).First;
           while not TFDQuery(dbgrdDespesas.DataSource.DataSet).Eof do begin
                   vlrDespesas := vlrDespesas + TFDQuery(dbgrdDespesas.DataSource.DataSet).FieldByName('VALOR_DESPESA').AsCurrency;
                 TFDQuery(dbgrdDespesas.DataSource.DataSet).Next;
           end;

          edtValorDespesa.Text :=  FormatFloat('#,.##',vlrDespesas);

      end;

      if (dmRD.obterReceitas(idOrganizacao,frmPeriodo1.getDataInicial, frmPeriodo1.getDataFinal)) then begin

            TFDQuery(dbgrdReceitas.DataSource.DataSet).First;
           while not TFDQuery(dbgrdReceitas.DataSource.DataSet).Eof do begin
                   vlrReceitas := vlrReceitas + TFDQuery(dbgrdReceitas.DataSource.DataSet).FieldByName('VALOR_RECEITA').AsCurrency;
                 TFDQuery(dbgrdReceitas.DataSource.DataSet).Next;
           end;

          edtValorReceita.Text :=  FormatFloat('#,.##',vlrReceitas);
      end;
       btnImprimir.Enabled := True;
   end else begin
       ShowMessage('O período parece estar incorreto... Verifique e tente novamente. ');
   end;


end;

procedure TfrmDemonstrativoRD.btnImprimirClick(Sender: TObject);
begin

 exibirRelatorioExportacao(frmPeriodo1.getDataInicial, frmPeriodo1.getDataFinal);

end;

procedure TfrmDemonstrativoRD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
freeAndNilDM;
Action := caFree;
end;

procedure TfrmDemonstrativoRD.FormCreate(Sender: TObject);
begin

 frmPeriodo1.inicializa(uUtil.getDataServer,uUtil.getDataServer);
  btnImprimir.Enabled := False;
  inicializarDM(Self);
end;

procedure TfrmDemonstrativoRD.exibirRelatorioExportacao ( dtInicial, dtFinal: TDate);
begin

      dmRD.frxReportRD.Clear;
  if (dmRD.frxReportRD.LoadFromFile(retornarCaminhoRelatorio)) then
  begin
    inicializarVariaveisRelatorio(dtInicial, dtFinal);
    dmRD.frxReportRD.OldStyleProgress := True;
    dmRD.frxReportRD.ShowProgress := True;
    dmRD.frxReportRD.ShowReport;
  end;

   btnImprimir.Enabled := False;
end;

function TfrmDemonstrativoRD.retornarCaminhoRelatorio: string;
begin
   // Result := ExtractFilePath(Application.ExeName) + '\relDemonstrativoRDSintetico.fr3';
    Result := uUtil.TPathRelatorio.getDemontrativoRDSintetico;



end;


procedure TfrmDemonstrativoRD.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
begin

  with dmRD.frxReportRD.Variables do
  begin

    Variables['strRazaoSocial'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL')
      .AsString);
    Variables['strCNPJ'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
    Variables['strEndereco'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('ENDERECO').AsString);
    Variables['strCEP'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CEP').AsString);
    Variables['strCidade'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CIDADE').AsString);
    Variables['strUF'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strPeriodo'] :=QuotedStr( ' de  ' + DateToStr(dtInicial) + '  até  ' + DateToStr(dtFinal));

  end;
end;

end.
