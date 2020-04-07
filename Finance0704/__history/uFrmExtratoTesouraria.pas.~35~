unit uFrmExtratoTesouraria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFramePeriodo, frxExportCSV, frxClass,udmConexao,uDMExtratoTesouraria, uUtil,uDMOrganizacao,
  frxExportBaseDialog, frxExportPDF, frxDBSet, Vcl.Buttons, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmExtratoTesouraria = class(TForm)
    frmPeriodo1: TfrmPeriodo;
    frxExtratoTesouraria: TfrxReport;
    frxDBDExtrato: TfrxDBDataset;
    frxpdfxprt1: TfrxPDFExport;
    frxCSVExport1: TfrxCSVExport;
    btnImprimir: TButton;
    btnFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
     pIdUsuario, pIdOrganizancao :string;
    procedure limparPanel;
    procedure exibirRelatorio(dtInicial, dtFinal: TDate);
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
  public
    { Public declarations }
  end;

var
  frmExtratoTesouraria: TfrmExtratoTesouraria;

implementation

{$R *.dfm}

procedure TfrmExtratoTesouraria.btnFecharClick(Sender: TObject);
begin
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmExtratoTesouraria.btnImprimirClick(Sender: TObject);
var vlrSaldoAnterior, vlrCr, vlrDb : Currency;
pDataInicial, pDataFinal :TDate;

begin
  if frmPeriodo1.validarPeriodo then
  begin
    pDataInicial := frmPeriodo1.getDataInicial;
    pDataFinal := frmPeriodo1.getDataFinal;

    if dmExtratoTesouraria.obterExtrato(pIdOrganizancao, pDataInicial, pDataFinal) then
    begin
      exibirRelatorio(pDataInicial, pDataFinal);

    end
    else
    begin
      ShowMessage('Não existem dados para imprimir.');
    end;

  end;

end;


procedure TfrmExtratoTesouraria.exibirRelatorio(dtInicial, dtFinal: TDate);
var
pathRelatorio :string;

begin
 pathRelatorio := uUtil.TPathRelatorio.getExtratoTesouraria;

  frxExtratoTesouraria.Clear;

  if not(frxExtratoTesouraria.LoadFromFile(pathRelatorio)) then
  begin
      ShowMessage('Relatório interno não localizado...');
  end
  else
  begin
    inicializarVariaveisRelatorio(dtInicial, dtFinal);
    frxExtratoTesouraria.OldStyleProgress := True;
    frxExtratoTesouraria.ShowProgress := True;
    frxExtratoTesouraria.ShowReport;
  end;

 limparPanel;

end;


procedure TfrmExtratoTesouraria.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

 if Assigned(dmExtratoTesouraria) then begin
    FreeAndNil(dmExtratoTesouraria);
 end;

 Action :=caFree;
end;

procedure TfrmExtratoTesouraria.FormCreate(Sender: TObject);
begin
  if not (Assigned(dmExtratoTesouraria)) then
  begin
    dmExtratoTesouraria := TdmExtratoTesouraria.Create(Self);
  end;

   if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;

    limparPanel;
end;

procedure TfrmExtratoTesouraria.limparPanel();
begin

 pIdOrganizancao := UUtil.TOrgAtual.getId;
 pIdUsuario :=uutil.TUserAtual.getUserId;
 frmPeriodo1.inicializa(IncDay(Now, -1), Now);


end;



procedure TfrmExtratoTesouraria.inicializarVariaveisRelatorio(dtInicial,  dtFinal: TDate);
begin

  with frxExtratoTesouraria.Variables do
  begin

    if dmOrganizacao.qryDadosEmpresa.RecordCount < 1 then begin

       dmOrganizacao.carregarDadosOrganizacao(pIdOrganizancao);

    end;

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
