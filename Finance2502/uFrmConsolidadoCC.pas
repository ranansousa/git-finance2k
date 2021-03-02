unit uFrmConsolidadoCC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.DateUtils, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxRibbonSkins, dxSkinsDefaultPainters,
  dxRibbonCustomizationForm, dxBar, EMsgDlg, cxClasses, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, dxStatusBar, dxRibbon, uDMOrganizacao, frxClass, MDDAO, uUtil,
  udmConexao, dxSkinsCore;

type
  TfrmConsolidadoCC = class(TForm)
    qryConsolidadoCC: TFDQuery;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dsMain: TDataSource;
    dxStatusBar: TdxStatusBar;
    Panel1: TPanel;
    dbgMain: TDBGrid;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar3: TdxBar;
    dxBarFechar: TdxBarLargeButton;
    dxBarImprimir: TdxBarLargeButton;
    cbxAnosPagtos: TdxBarCombo;
    relatorio: TfrxReport;
    qryAnosPagto: TFDQuery;
    btnGerar: TdxBarButton;
    PempecMsg: TEvMsgDlg;
    procedure FormCreate(Sender: TObject);
    procedure dxBarFecharClick(Sender: TObject);
    procedure dxBarImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
    pIdOrganizacao: string;
    procedure limpaTela(Sender: TObject);
    procedure limpaStatusBar;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure preencheComboAnos(pOrg: string);
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    function obterAnos(pIdOrganizacao: string): Boolean;
    function obterDadosPagos(pIdOrganizacao: string; pAno: Integer): Boolean;
    procedure registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
  public
    { Public declarations }

  end;

var
  frmConsolidadoCC: TfrmConsolidadoCC;

implementation

{$R *.dfm}

{ TfrmConsolidadoCCC }

procedure TfrmConsolidadoCC.btnGerarClick(Sender: TObject);
begin

  if cbxAnosPagtos.Index > 0 then
  begin

    obterDadosPagos(pIdOrganizacao, StrToInt(cbxAnosPagtos.Text));

  end;

end;

procedure TfrmConsolidadoCC.dxBarFecharClick(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmConsolidadoCC.dxBarImprimirClick(Sender: TObject);
begin

  msgStatusBar(3, 'Relatório enviado para impressão...');
 //exibirRelatorioExportacao(dtpDataInicial.Date, dtpDataFinal.Date);


  registraMovimentacao(pIdOrganizacao, 'CENTRO_CUSTO', 'DEMONSTRATIVO CONSOLIDADO RD', uutil.TUserAtual.getNameUser + ' solicitou DEMONSTRATIVO RD', 'SOLICITADO');

end;

procedure TfrmConsolidadoCC.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;
end;

procedure TfrmConsolidadoCC.FormCreate(Sender: TObject);
begin
  limpaTela(Self);
  pIdOrganizacao := uutil.TOrgAtual.getId;

  preencheComboAnos(pIdOrganizacao);

end;

procedure TfrmConsolidadoCC.limpaTela(Sender: TObject);
begin
  pIdOrganizacao := uutil.TOrgAtual.getId;

  cbxAnosPagtos.Items.Clear;

  if obterAnos(pIdOrganizacao) then
  begin
    preencheComboAnos(pIdOrganizacao);
  end
  else
  begin
    cbxAnosPagtos.Items.Add(IntToStr(YearOf(now)));

  end;

end;

procedure TfrmConsolidadoCC.msgStatusBar(pPosicao: Integer; msg: string);
begin
  dxStatusBar.Panels[pPosicao].Text := msg;
  Application.ProcessMessages;
end;

procedure TfrmConsolidadoCC.limpaStatusBar;
begin
  dxStatusBar.Panels[0].Text := 'Status ';
  dxStatusBar.Panels[1].Text := 'Ativo. ';
  dxStatusBar.Panels[2].Text := '  ';
  dxStatusBar.Panels[3].Text := '  ';

end;

procedure TfrmConsolidadoCC.preencheComboAnos(pOrg: string);
var
  menorAno, maiorAno: Integer;
begin

  menorAno := YearOf(now);
  maiorAno := YearOf(now);

  menorAno := qryAnosPagto.FieldByName('MENOR').AsInteger;
  maiorAno := qryAnosPagto.FieldByName('MAIOR').AsInteger;

  while menorAno <= maiorAno do
  begin

    cbxAnosPagtos.Items.Add(IntToStr(menorAno));
    Inc(menorAno);

  end;

  cbxAnosPagtos.ItemIndex := cbxAnosPagtos.Items.Count - 1;

end;

function TfrmConsolidadoCC.obterAnos(pIdOrganizacao: string): Boolean;
begin

  try
    qryAnosPagto.Connection := dmConexao.Conn;
    qryAnosPagto.Close;
    qryAnosPagto.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryAnosPagto.Open;

  except
    raise(Exception).Create('Problemas ao consultar dados de pagamentos ');
  end;

  Result := not qryAnosPagto.IsEmpty;

end;

function TfrmConsolidadoCC.obterDadosPagos(pIdOrganizacao: string; pAno: Integer): Boolean;
var
  sucesso: Boolean;
begin
  sucesso := False;

  qryConsolidadoCC.Close;
  qryConsolidadoCC.Connection := dmConexao.conn;
  qryConsolidadoCC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryConsolidadoCC.ParamByName('PANO').AsInteger := StrToInt(cbxAnosPagtos.Text);
  qryConsolidadoCC.Open();

  sucesso := not qryConsolidadoCC.IsEmpty;

  Result := sucesso;

end;

procedure TfrmConsolidadoCC.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
begin

  with relatorio do
  begin

    Variables['strRazaoSocial'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL').AsString);
    Variables['strCNPJ'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
    Variables['strEndereco'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('ENDERECO').AsString);
    Variables['strCEP'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CEP').AsString);
    Variables['strCidade'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CIDADE').AsString);
    Variables['strUF'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strPeriodo'] := QuotedStr(' de  ' + DateToStr(dtInicial) + '  até  ' + DateToStr(dtFinal));

  end;
end;

procedure TfrmConsolidadoCC.registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
begin
  TMDDAO.registroMD(pOrg, pTable, pAcao, pDsc, pStatus);

end;

end.

