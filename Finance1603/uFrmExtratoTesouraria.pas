unit uFrmExtratoTesouraria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFramePeriodo,  frxClass,udmConexao,uDMExtratoTesouraria, uUtil,uDMOrganizacao,
  frxExportBaseDialog,  frxDBSet, Vcl.Buttons, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, MDDAO,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, EMsgDlg, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters, dxStatusBar,
  dxRibbonSkins, dxRibbonCustomizationForm, dxBar, cxClasses, dxRibbon,
  cxCalendar, dxBarExtItems, cxBarEditItem;

type
  TfrmExtratoTesouraria = class(TForm)
    frxExtratoTesouraria: TfrxReport;
    frxDBDExtrato: TfrxDBDataset;
    PempecMsg: TEvMsgDlg;
    dxStatusBar: TdxStatusBar;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBtnSair: TdxBarLargeButton;
    dxBtnImprime: TdxBarLargeButton;
    dxBarManager1Bar3: TdxBar;
    cxBarEditItem1: TcxBarEditItem;
    cxBarEditItem2: TcxBarEditItem;
    dxBarDataIn: TdxBarDateCombo;
    dxBarDataFim: TdxBarDateCombo;
    procedure FormCreate(Sender: TObject);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxBtnSairClick(Sender: TObject);
    procedure dxBtnImprimeClick(Sender: TObject);
  private
    { Private declarations }
     pIdUsuario, pIdOrganizancao :string;
    procedure limparPanel;
    procedure exibirRelatorio(dtInicial, dtFinal: TDate);
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    procedure registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);


  public
    { Public declarations }
  end;

var
  frmExtratoTesouraria: TfrmExtratoTesouraria;

implementation

{$R *.dfm}


procedure TfrmExtratoTesouraria.dxBtnImprimeClick(Sender: TObject);
var vlrSaldoAnterior, vlrCr, vlrDb : Currency;
pDataInicial, pDataFinal :TDate;

begin


      pDataInicial := dxBarDataIn.Date;
      pDataFinal := dxBarDataFim.Date;

      if dmExtratoTesouraria.obterExtrato(pIdOrganizancao, pDataInicial, pDataFinal) then
      begin
        registraMovimentacao(pIdOrganizancao, 'TESOURARIA', 'EXTRATO TESOURARIA', uutil.TUserAtual.getNameUser + ' solicitou EXTRATO DA TESOURARIA', 'SOLICITADO');
        exibirRelatorio(pDataInicial, pDataFinal);

      end
      else
      begin
        PempecMsg.MsgWarning('N�o existem dados para imprimir.');
      end;




end;

procedure TfrmExtratoTesouraria.dxBtnSairClick(Sender: TObject);
begin
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmExtratoTesouraria.exibirRelatorio(dtInicial, dtFinal: TDate);
var
pathRelatorio :string;

begin
  pathRelatorio := uUtil.TPathRelatorio.getExtratoTesouraria;
  frxExtratoTesouraria.Clear;

  try

    if not (frxExtratoTesouraria.LoadFromFile(pathRelatorio)) then
    begin
      PempecMsg.MsgInformation('Relat�rio interno n�o localizado...');
    end
    else
    begin
      inicializarVariaveisRelatorio(dtInicial, dtFinal);
      frxExtratoTesouraria.OldStyleProgress := True;
      frxExtratoTesouraria.ShowProgress := True;
      frxExtratoTesouraria.ShowReport;
    end;

  finally
    FreeAndNil(dmExtratoTesouraria.qryDeletaTemp);
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
 pIdUsuario := IntToStr(uutil.TUserAtual.getUserId);
 dxBarDataIn.Date := StartOfTheWeek(Now);
 dxBarDataFim.Date := EndOfTheWeek(Now);


end;



procedure TfrmExtratoTesouraria.inicializarVariaveisRelatorio(dtInicial,  dtFinal: TDate);
begin

  with frxExtratoTesouraria.Variables do
  begin

    if dmOrganizacao.qryDadosEmpresa.RecordCount < 1 then begin

       dmOrganizacao.carregarDadosOrganizacaoFNC(pIdOrganizancao);

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
    Variables['strPeriodo'] :=QuotedStr( ' de  ' + DateToStr(dtInicial) + '  at�  ' + DateToStr(dtFinal));
  end;
end;


procedure TfrmExtratoTesouraria.registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
begin
  TMDDAO.registroMD(pOrg, pTable, pAcao, pDsc, pStatus);

end;


end.
