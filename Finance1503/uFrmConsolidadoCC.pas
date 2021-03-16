unit uFrmConsolidadoCC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.DateUtils, cxGraphics, cxControls, cxLookAndFeels, uFrmEnviaMail,
  cxLookAndFeelPainters, dxRibbonSkins, dxSkinsDefaultPainters, frxExportCSV, frxExportPDF,
  dxRibbonCustomizationForm, dxBar, EMsgDlg, cxClasses, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, dxStatusBar, dxRibbon, uDMOrganizacao, frxClass, MDDAO, uUtil,
  udmConexao, dxSkinsCore, frxExportBaseDialog, frxDBSet, cxMemo, cxBarEditItem;

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
    frxRelatorio: TfrxReport;
    qryAnosPagto: TFDQuery;
    btnGerar: TdxBarButton;
    PempecMsg: TEvMsgDlg;
    dxBarBtnEnviaEmail: TdxBarLargeButton;
    dxBarManager1Bar4: TdxBar;
    dxBarBtnExport: TdxBarLargeButton;
    frxDBDataset1: TfrxDBDataset;
    cxBarEditItem1: TcxBarEditItem;
    cxBarEditItem2: TcxBarEditItem;
    edtLocalExport: TdxBarEdit;
    procedure FormCreate(Sender: TObject);
    procedure dxBarFecharClick(Sender: TObject);
    procedure dxBarImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGerarClick(Sender: TObject);
    procedure dxBarBtnEnviaEmailClick(Sender: TObject);
    procedure dxBarBtnExportClick(Sender: TObject);
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
    function retornarCaminhoRelatorio(tipo: Integer): string;
    function validarFormulario: boolean;
    procedure exibirRelatorio(tipo: Integer);
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
  dxBarBtnExport.Enabled := False;
  dxBarBtnEnviaEmail.Enabled := False;
  dxBarImprimir.Enabled := False;

  if cbxAnosPagtos.Index > 0 then
  begin

    if obterDadosPagos(pIdOrganizacao, StrToInt(cbxAnosPagtos.Text)) then
    begin
      dxBarBtnExport.Enabled := True;
      dxBarBtnEnviaEmail.Enabled := True;
      dxBarImprimir.Enabled := True;

    end;

  end;

end;

procedure TfrmConsolidadoCC.dxBarBtnEnviaEmailClick(Sender: TObject);
var
localFile, assunto, arquivo :string;
begin
  //envia PDF por email

  if not (dsMain.DataSet.IsEmpty) then
  begin

    frxRelatorio.Clear;

    if not (frxRelatorio.LoadFromFile(retornarCaminhoRelatorio(0))) then

    begin
      PempecMsg.MsgError('N�o foi poss�vel imprimir. Informe ao suporte : FALTA FR3 ');
    end
    else
    begin

      //enviar por PDF
      arquivo := 'CENTRO_CUSTOS_' + FormatDateTime('dd.MM.yyyy_hh.mm.ss', now)  + '.PDF';
      localFile := GetCurrentDir + '\rel\'; //informa a pasta onde o arquivo ser� gravado
      dmConexao.frxPDFExport := TfrxPDFexport.Create(Self);

      dmConexao.frxPDFExport.FileName := arquivo;
      dmconexao.frxPDFExport.DefaultPath := localFile;
      dmconexao.frxPDFExport.ShowDialog := False;
      dmconexao.frxPDFExport.ShowProgress := False;
      dmconexao.frxPDFExport.OverwritePrompt := True;


      inicializarVariaveisRelatorio(Now,Now);

      frxRelatorio.OldStyleProgress := True;
      frxRelatorio.ShowProgress := True;
      frxRelatorio.PrepareReport(True);

      frxRelatorio.Export(dmconexao.frxPDFExport);

      if Assigned(dmConexao.frxPDFExport) then
      begin
        dmConexao.frxPDFExport.Free;
      end;


      assunto := arquivo;
      arquivo := localFile + arquivo;

     frmEnviaMail := TfrmEnviaMail.Create(Self, arquivo, assunto);
     frmEnviaMail.ShowModal;
     FreeAndNil(frmEnviaMail);

    end;

  end;


  msgStatusBar(1, 'Relat�rio  sendo enviado por e-mail.');




end;


procedure TfrmConsolidadoCC.dxBarBtnExportClick(Sender: TObject);
var
  linha, coluna: integer;
var
  planilha: variant;
var
arquivo ,  valorcampo: string;
begin
   arquivo := '';
   if uutil.Empty( edtLocalExport.Text ) then begin

     edtLocalExport.Text := ExtractFilePath(Application.ExeName);
   end;

  if (1=1) then begin

  //  exibirRelatorioExcel(10); //10 inddica ser EXCEL

   arquivo := uutil.ExpDataSetForTXT(dsMain.DataSet, edtLocalExport.Text+ 'RELATORIOS\CENTRO_CUSTOS_ '+ SoNumeros(DateToStr(Now)) + '.CSV');

   PempecMsg.MsgInformation('Arquivo criado com sucesso '+#13#13 + arquivo );
   msgStatusBar(0, 'Arquivo :' );
   msgStatusBar(1, arquivo );

  end
  else
  begin
    PempecMsg.MsgError('N�o � poss�vel gerar exporta��o.');
  end;

end;

function TfrmConsolidadoCC.retornarCaminhoRelatorio(tipo: Integer): string;
begin


  case tipo of
    0:
      Result := uUtil.TPathRelatorio.getDemontrativoRDConsolidado;
    10:
      Result :=  uUtil.TPathRelatorio.getDemontrativoRDConsXLS;

  end;

end;

procedure TfrmConsolidadoCC.dxBarFecharClick(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;


function TfrmConsolidadoCC.validarFormulario: boolean;
begin
  Result := true;
end;

procedure TfrmConsolidadoCC.dxBarImprimirClick(Sender: TObject);
begin


 if validarFormulario then
  begin

      if not (dsMain.DataSet.IsEmpty) then
      begin
        dxBarBtnExport.Enabled := true; //libera exporta excel
        exibirRelatorio(0);  // consolidado PDF
        registraMovimentacao(pIdOrganizacao, 'CENTRO_CUSTO', 'DEMONSTRATIVO CONSOLIDADO RD', uutil.TUserAtual.getNameUser + ' solicitou DEMONSTRATIVO RD', 'SOLICITADO');
      end
      else
      begin
        dxBarBtnExport.Enabled := false;
        PempecMsg.MsgWarning('Consulta n�o retornou dados');
      end;

  end;



  msgStatusBar(3, 'Relat�rio enviado para impress�o...');
 //exibirRelatorioExportacao(dtpDataInicial.Date, dtpDataFinal.Date);



end;

procedure TfrmConsolidadoCC.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;
end;

procedure TfrmConsolidadoCC.FormCreate(Sender: TObject);
begin

  pIdOrganizacao := uutil.TOrgAtual.getId;

  limpaTela(Self);


end;

procedure TfrmConsolidadoCC.limpaTela(Sender: TObject);
begin
  pIdOrganizacao := uutil.TOrgAtual.getId;
  dxBarBtnExport.Enabled := False;
  dxBarBtnEnviaEmail.Enabled := False;
  dxBarImprimir.Enabled := False;
  edtLocalExport.Text := ExtractFilePath(Application.ExeName);

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



procedure TfrmConsolidadoCC.exibirRelatorio(tipo: Integer);
begin

     frxRelatorio.Clear;
  if not (frxRelatorio.LoadFromFile(retornarCaminhoRelatorio(tipo))) then
  begin
    //Mensagem n�o encontrou o arquivo do relatorio. Fazer

  end
  else
  begin
    inicializarVariaveisRelatorio(now, Now);
    frxRelatorio.OldStyleProgress := True;
    frxRelatorio.ShowProgress := True;
    frxRelatorio.ShowReport;
  end;
end;

procedure TfrmConsolidadoCC.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
var
pAno : string;
begin
        pAno :=    IntToStr(YearOf(dtInicial));

  with frxRelatorio do
  begin

    Variables['strRazaoSocial'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL').AsString);
    Variables['strCNPJ'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
    Variables['strEndereco'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('ENDERECO').AsString);
    Variables['strCEP'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CEP').AsString);
    Variables['strCidade'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CIDADE').AsString);
    Variables['strUF'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strPeriodo'] := QuotedStr(' ANO ' +  pAno  );








  end;
end;

procedure TfrmConsolidadoCC.registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
begin
  TMDDAO.registroMD(pOrg, pTable, pAcao, pDsc, pStatus);

end;

end.

