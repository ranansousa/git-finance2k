unit uFrmRelatoriosPagamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, uDMRelatoriosPagamentos,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, uDMOrganizacao,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands,  udmConexao, FireDAC.Stan.Util,
   FireDAC.Comp.Script, Vcl.Grids, Vcl.DBGrids, frxClass, frxDBSet, frxExportPDF, frxExportCSV, uUtil, Vcl.Buttons, ComObj,
  frxExportBaseDialog, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins, uFrmBaixaFP, uTituloPagarModel,
  dxRibbonCustomizationForm, cxClasses, dxRibbon, dxBar, EMsgDlg,
  dxDateTimeWheelPicker, cxBarEditItem, dxBarExtItems, Vcl.ExtCtrls, dxStatusBar;

  //uDM est� aqui temporariamente

type
  TfrmRelatorioPagamentos = class(TForm)
    DBGridMain: TDBGrid;
    frxRelContasPagar: TfrxReport;
    frxDBTitulos: TfrxDBDataset;
    frxDBCentroCusto: TfrxDBDataset;
    frxDBHistorico: TfrxDBDataset;
    frxDBTitulosExcel: TfrxDBDataset;
    frxReportExcel: TfrxReport;
    dsPreencheGrid: TDataSource;
    frxpdfxprt1: TfrxPDFExport;
    frxCSVExport1: TfrxCSVExport;
    PempecMsg: TEvMsgDlg;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar3: TdxBar;
    dxBarManager1Bar4: TdxBar;
    dxBarManager1Bar5: TdxBar;
    dxBarManager1Bar6: TdxBar;
    dxBarBtnFecha: TdxBarLargeButton;
    dxBarDataInicial: TdxBarDateCombo;
    cxBarEditItem1: TcxBarEditItem;
    cxBarEditItem2: TcxBarEditItem;
    dxBarDataFinal: TdxBarDateCombo;
    dxBarCbxStatus: TdxBarCombo;
    dxBarCbxCentroCusto: TdxBarCombo;
    dxBarCbxOrdem: TdxBarCombo;
    dxBarCbxTipoRel: TdxBarCombo;
    dxBarBtnConsultar: TdxBarLargeButton;
    dxBarBtnImprimir: TdxBarLargeButton;
    dxBarBtnExport: TdxBarLargeButton;
    Panel1: TPanel;
    dxBarManager1Bar7: TdxBar;
    dxBtnPagar: TdxBarLargeButton;
    dxStatusBar: TdxStatusBar;
    cxBarEditItem3: TcxBarEditItem;
    cxBarEditItem4: TcxBarEditItem;
    cxBarPesquisaDocumento: TcxBarEditItem;
    dxBarManager1Bar8: TdxBar;
    cxBarPesquisaCedente: TcxBarEditItem;
    dxBarDateCombo1: TdxBarDateCombo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure dsPreencheGridDataChange(Sender: TObject; Field: TField);
    procedure dxBarBtnFechaClick(Sender: TObject);
    procedure dxBarBtnConsultarClick(Sender: TObject);
    procedure dxBarBtnImprimirClick(Sender: TObject);
    procedure dxBarBtnExportClick(Sender: TObject);
    procedure cxBarPesquisaCedenteCurChange(Sender: TObject);
    procedure DBGridMainTitleClick(Column: TColumn);
    procedure dxBtnPagarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxBarPesquisaDocumentoCurChange(Sender: TObject);
  private
    { Private declarations }
    FsListaIdOrganizacoes: TStringList;
    FsListaIdCentrosCusto: TStringList;
    idOrgzanizacao: string;
    pTitulo : TTituloPagarModel;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    function carregarCentrosCusto: Boolean;
    procedure preencherListaCentrosCusto;
    function montarSQL: Boolean;
    function montarSQLForExcel: Boolean;

    function retornarCampoOrdenacao: string;
    procedure exibirRelatorio(tipo: Integer);
    procedure inicializarVariaveisRelatorio;
    function validarFormulario: boolean;
    function retornarCaminhoRelatorio(tipo: Integer): string;
    procedure exibirRelatorioExcel(tipo: Integer);
    procedure exibirValoresPanel;
    procedure limpaStatusBar;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
  public
    { Public declarations }
    function carregarDadosPagamentos: boolean;
  end;

var
  frmRelatorioPagamentos: TfrmRelatorioPagamentos;

implementation

{$R *.dfm}

procedure TfrmRelatorioPagamentos.btnConsultarClick(Sender: TObject);
begin
  if validarFormulario then
//  idStatus := QuotedStr(cbxStatus.Items[cbxStatus.ItemIndex]);

  begin
    dmOrganizacao.carregarDadosOrganizacao(idOrgzanizacao);
    if not (carregarDadosPagamentos) then
    begin
      dxBarBtnExport.Enabled := false;
      dxBarBtnImprimir.Enabled := false;
      PempecMsg.MsgInformation('Consulta n�o retornou dados.');
       msgStatusBar(4, 'Consulta n�o retornou resultados');
       exibirValoresPanel;
    end
    else
    begin
      exibirValoresPanel;
      dxBarBtnImprimir.Enabled := True;
      dxBarBtnExport.Enabled := True;
    end;
  end;
end;

procedure TfrmRelatorioPagamentos.btnExcelClick(Sender: TObject);
var
  linha, coluna: integer;
var
  planilha: variant;
var
  valorcampo: string;
begin
  //para excel foi informado que seriam todos os titulos. Considerando apenas periodo.
  if (montarSQLForExcel) then begin

    exibirRelatorioExcel(10); //10 inddica ser EXCEL
  end
  else
  begin
    ShowMessage('N�o � poss�vel gerar exporta��o.');
  end;

end;

procedure TfrmRelatorioPagamentos.btnImprimirClick(Sender: TObject);
begin
  if validarFormulario then
  begin

    if (dxBarCbxTipoRel.ItemIndex > (-1)) then
    begin
      if not (dsPreencheGrid.DataSet.IsEmpty) then
      begin
        dxBarBtnExport.Enabled := true; //libera exporta excel
        exibirRelatorio(dxBarCbxTipoRel.ItemIndex);
      end
      else
      begin
        dxBarBtnExport.Enabled := false;
        PempecMsg.MsgWarning('Consulta n�o retornou dados');
      end;
    end;
  end;
end;

function TfrmRelatorioPagamentos.carregarCentrosCusto: Boolean;
begin
  Result := dmRelPagamentos.obterTodosCentroCustos(idOrgzanizacao);
end;


function TfrmRelatorioPagamentos.carregarDadosPagamentos: Boolean;
begin
  Result := false;

  Result := montarSQL;

end;

procedure TfrmRelatorioPagamentos.cxBarPesquisaCedenteCurChange(Sender: TObject);
begin
 DBGridMain.DataSource.DataSet.Locate('NOME_CEDENTE',UpperCase(cxBarPesquisaCedente.CurEditValue),[loPartialKey]);
end;

procedure TfrmRelatorioPagamentos.cxBarPesquisaDocumentoCurChange(
  Sender: TObject);
begin
DBGridMain.DataSource.DataSet.Locate('NUMERO_DOCUMENTO',UpperCase(cxBarPesquisaDocumento.CurEditValue),[loPartialKey]);
end;

procedure TfrmRelatorioPagamentos.DBGridMainTitleClick(Column: TColumn);
begin
(DBGridMain.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

procedure TfrmRelatorioPagamentos.dsPreencheGridDataChange(Sender: TObject;
  Field: TField);
  var
  idTituloPagar :string;
begin
// carrega os historicos
    idTituloPagar :=  TFDQuery(DBGridMain.DataSource.DataSet).FieldByName('ID_TITULO_PAGAR').AsString;
    dmRelPagamentos.obterHistoricoPorTP(idOrgzanizacao, idTituloPagar);
    dmRelPagamentos.obterCentroCustoPorTP(idOrgzanizacao,idTituloPagar);
    pTitulo := TTituloPagarModel.Create;
    pTitulo.FIDorganizacao := idOrgzanizacao;
    pTitulo.FID := idTituloPagar;
    pTitulo.FIDTipoStatus := TFDQuery(DBGridMain.DataSource.DataSet).FieldByName('STATUS').AsString;
    pTitulo.FnumeroDocumento := TFDQuery(DBGridMain.DataSource.DataSet).FieldByName('NUMERO_DOCUMENTO').AsString;

end;

procedure TfrmRelatorioPagamentos.dxBarBtnConsultarClick(Sender: TObject);
begin
 if validarFormulario then
//  idStatus := QuotedStr(cbxStatus.Items[cbxStatus.ItemIndex]);

  begin
    dmOrganizacao.carregarDadosOrganizacao(idOrgzanizacao);
    if not (carregarDadosPagamentos) then
    begin
      dxBarBtnExport.Enabled := false;
      dxBarBtnImprimir.Enabled := false;
      cxBarPesquisaCedente.Enabled := False;
      cxBarPesquisaDocumento.Enabled := False;
      PempecMsg.MsgWarning('Consulta n�o retornou dados.');
      msgStatusBar(4, 'Consulta retonou vazia.');
      exibirValoresPanel;
    end
    else
    begin
      exibirValoresPanel;
      dxBarBtnImprimir.Enabled := True;
      dxBarBtnExport.Enabled := True;
      cxBarPesquisaCedente.Enabled := True;
        cxBarPesquisaDocumento.Enabled := True;
    end;
  end;


end;

procedure TfrmRelatorioPagamentos.dxBarBtnExportClick(Sender: TObject);
var
  linha, coluna: integer;
var
  planilha: variant;
var
  valorcampo: string;
begin
  //para excel foi informado que seriam todos os titulos. Considerando apenas periodo.
  if (montarSQLForExcel) then begin

    exibirRelatorioExcel(10); //10 inddica ser EXCEL
  end
  else
  begin
    PempecMsg.MsgError('N�o � poss�vel gerar exporta��o.');
  end;

    cxBarPesquisaCedente.Enabled := False;
    cxBarPesquisaDocumento.Enabled := False;

end;

procedure TfrmRelatorioPagamentos.dxBarBtnFechaClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmRelatorioPagamentos.dxBarBtnImprimirClick(Sender: TObject);
begin
 if validarFormulario then
  begin

    if (dxBarCbxTipoRel.ItemIndex > (-1)) then
    begin
      if not (dsPreencheGrid.DataSet.IsEmpty) then
      begin
        dxBarBtnExport.Enabled := true; //libera exporta excel
        exibirRelatorio(dxBarCbxTipoRel.ItemIndex);
      end
      else
      begin
        dxBarBtnExport.Enabled := false;
        PempecMsg.MsgWarning('Consulta n�o retornou dados');
      end;
    end;
  end;
    cxBarPesquisaCedente.Enabled := False;
    cxBarPesquisaDocumento.Enabled := False;
end;

procedure TfrmRelatorioPagamentos.dxBtnPagarClick(Sender: TObject);
begin
 DBGridMain.DataSource.DataSet.Close;

 try

   if pTitulo.FIDTipoStatus.Equals('ABERTO') then begin


    frmBaixa := TFrmBaixaFP.Create(Self,pTitulo);
    frmBaixa.ShowModal;
    FreeAndNil(frmBaixa);

   end else begin PempecMsg.MsgError('N�o � poss�vel efetuar a baixa do t�tulo ' + pTitulo.FnumeroDocumento); end;

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + ' TfrmBaixaFP ' );
  end;

    dxBarBtnConsultar.Click;

end;

procedure TfrmRelatorioPagamentos.exibirRelatorioExcel(tipo: Integer);
begin
// EXCEL TIPO 10

  frxReportExcel.Clear;
  if not (frxReportExcel.LoadFromFile(retornarCaminhoRelatorio(tipo))) then
  begin
    //Mensagem n�o encontrou o arquivo do relatorio. Fazer

  end
  else
  begin
    frxReportExcel.OldStyleProgress := True;
    frxReportExcel.ShowProgress := True;
    frxReportExcel.ShowReport;
  end;
end;

procedure TfrmRelatorioPagamentos.exibirValoresPanel;

begin
  if (dxBarCbxStatus.ItemIndex > (-1)) then

  begin

   msgStatusBar(2,'Total a pagar : ');
   msgStatusBar(3,(FormatCurr('R$ ###,##0.00',dmRelPagamentos.obterTotalPorStatus(TOrgAtual.getId, 'ABERTO', dxBarDataInicial.Date, dxBarDataFinal.Date))));
   msgStatusBar(4,'Total pago : ');
   msgStatusBar(5,(FormatCurr('R$ ###,##0.00',dmRelPagamentos.obterTotalPorStatus(TOrgAtual.getId, 'QUITADO', dxBarDataInicial.Date, dxBarDataFinal.Date))));

  end;

end;

procedure TfrmRelatorioPagamentos.exibirRelatorio(tipo: Integer);
begin

     frxRelContasPagar.Clear;
  if not (frxRelContasPagar.LoadFromFile(retornarCaminhoRelatorio(tipo))) then
  begin
    //Mensagem n�o encontrou o arquivo do relatorio. Fazer

  end
  else
  begin
    inicializarVariaveisRelatorio;
    frxRelContasPagar.OldStyleProgress := True;
    frxRelContasPagar.ShowProgress := True;
    frxRelContasPagar.ShowReport;
  end;
end;

procedure TfrmRelatorioPagamentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if Assigned(dmRelPagamentos) then
  begin
    FreeAndNil(dmRelPagamentos);
  end;

  Action := cafree;

end;

procedure TfrmRelatorioPagamentos.FormCreate(Sender: TObject);
begin
  inicializarDM(Self);

  dxBarBtnExport.Enabled := False;
  dxBarBtnImprimir.Enabled := false;
  dxRibbon1Tab1.Caption := 'Consulta de contas a pagar';
  cxBarPesquisaCedente.Enabled := False;
  cxBarPesquisaDocumento.Enabled := False;
  limpaStatusBar;
end;

procedure TfrmRelatorioPagamentos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F10: dxBtnPagar.Click;
  end;
end;

procedure TfrmRelatorioPagamentos.freeAndNilDM(Sender: TObject);
begin
  //nada

end;

procedure TfrmRelatorioPagamentos.inicializarDM(Sender: TObject);
begin
     dmConexao.conectarBanco;

    idOrgzanizacao              :=uUtil.TOrgAtual.getId;
    dxBarDataInicial.Date          := now;
    dxBarDataFinal.Date            := now;
    dxBarCbxStatus.ItemIndex         := 0;
    dxBarCbxCentroCusto.ItemIndex   :=0;
    dxBarCbxOrdem.ItemIndex          :=0;
    dxBarCbxTipoRel.ItemIndex  :=0;


  if not (Assigned(dmRelPagamentos)) then
  begin
    dmRelPagamentos := TdmRelPagamentos.Create(Self);
  end;

  if carregarCentrosCusto then
  begin
    preencherListaCentrosCusto;
  end;




end;

procedure TfrmRelatorioPagamentos.inicializarVariaveisRelatorio;
begin
  with frxRelContasPagar.Variables do
  begin
    Variables['strRazaoSocial'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL').AsString);
    Variables['strCNPJ'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
    Variables['strEndereco'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('ENDERECO').AsString);
    Variables['strCEP'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CEP').AsString);
    Variables['strCidade'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CIDADE').AsString);
    Variables['strUF'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strTipoStatus'] := QuotedStr(dxBarCbxStatus.Items[dxBarCbxStatus.ItemIndex]);

  end;
end;

function TfrmRelatorioPagamentos.montarSQL: Boolean;
var
  lsSQL: TStringList;
  tpStatus,  x: string;


begin
  dmConexao.conectarBanco;

  lsSQL := TStringList.Create;
  lsSQL.AddStrings(dmRelPagamentos.sqlScriptContainer.SQLScripts.FindScript('sqlRelPagamentos').SQL);
  lsSQL.Add('WHERE');

   if (dxBarCbxStatus.ItemIndex = 0) then BEGIN //TODOS OS TITULOS COM DATA VENCIMENTO NO PERIODO
        lsSQL.Add(Format('  (TP.DATA_VENCIMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataFinal.Date))]));
        lsSQL.Add('OR');
        lsSQL.Add(Format('  (TP.DATA_PAGAMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataFinal.Date))]));
        lsSQL.Add('AND');
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS <> %s)', [QuotedStr('EXCLUIDO')]));
        lsSQL.Add('AND');
   END;

   if (dxBarCbxStatus.ItemIndex = 1) then BEGIN //TODOS OS TITULOS COM DATA VENCIMENTO NO PERIODO
        lsSQL.Add(Format('  (TP.DATA_VENCIMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataFinal.Date))]));
        lsSQL.Add('AND');
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS = %s)', [QuotedStr(dxBarCbxStatus.Items[dxBarCbxStatus.ItemIndex])]));
        lsSQL.Add('AND');

   END;

    if (dxBarCbxStatus.ItemIndex = 2) then BEGIN //TODOS OS TITULOS EXCLUIDOS NO PERIODO
        tpStatus := '(''EXCLUIDO'')';
        lsSQL.Add(Format('  (TP.DATA_EMISSAO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataFinal.Date))]));
        lsSQL.Add('AND');
        //lsSQL.Add(Format('  (TP.ID_TIPO_STATUS IN %s)', [tpStatus]));
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS = %s)', [QuotedStr(dxBarCbxStatus.Items[dxBarCbxStatus.ItemIndex])]));
        lsSQL.Add('AND');

   END;

    if (dxBarCbxStatus.ItemIndex = 3) then BEGIN //TODOS OS TITULOS COM DATA PAGAMENTO NO PERIODO
        tpStatus := '(''QUITADO'',''PARCIAL'')';
        lsSQL.Add(Format('  (TP.DATA_PAGAMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataFinal.Date))]));
        lsSQL.Add('AND');
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS IN %s)', [tpStatus]));
        lsSQL.Add('AND');

   END;



  lsSQL.Add(Format('  (TP.ID_ORGANIZACAO = %s)', [QuotedStr(idOrgzanizacao)]));

  if (dxBarCbxCentroCusto.ItemIndex > 0) then
  begin
    lsSQL.Add('AND');
    lsSQL.Add(Format('  (TPC.ID_CENTRO_CUSTO = %s)', [QuotedStr(FsListaIdCentrosCusto[dxBarCbxCentroCusto.ItemIndex])]));
  end;

 { if (cbxStatus.ItemIndex > 0) then
  begin
    lsSQL.Add('AND');
    lsSQL.Add(Format('  (TP.ID_TIPO_STATUS = %s)', [QuotedStr(cbxStatus.Items[cbxStatus.ItemIndex])]));
  end; }

  lsSQL.Add('ORDER BY');
  lsSQL.Add('  ' + retornarCampoOrdenacao);

{  dmRelPagamentos.qryRelPagamentos.Close;
  dmRelPagamentos.qryRelPagamentos.SQL.Clear;
  dmRelPagamentos.qryRelPagamentos.SQL.Assign(lsSQL); }

  Result := dmRelPagamentos.obterTodosPagamentos(lsSQL,idOrgzanizacao,dxBarDataInicial.Date, dxBarDataFinal.Date );
  //Result := (lsSQL.Count > 0);
  lsSql := nil;
end;




function TfrmRelatorioPagamentos.montarSQLForExcel: Boolean;
var
  lsSQL: TStringList;
  tpStatus,  x: string;


begin
  dmConexao.conectarBanco;

  lsSQL := TStringList.Create;
  lsSQL.AddStrings(dmRelPagamentos.sqlScriptExcel.SQLScripts.FindScript('sqlTitulosExcel').SQL);
  lsSQL.Add('WHERE');

   if (dxBarCbxStatus.ItemIndex = 0) then BEGIN //TODOS OS TITULOS COM DATA VENCIMENTO NO PERIODO
        lsSQL.Add(Format('  (TP.DATA_VENCIMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataFinal.Date))]));
        lsSQL.Add('AND');
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS <> %s)', [QuotedStr('EXCLUIDO')]));
        lsSQL.Add('AND');
   END;

   if (dxBarCbxStatus.ItemIndex = 1) then BEGIN //TODOS OS TITULOS COM DATA VENCIMENTO NO PERIODO
        lsSQL.Add(Format('  (TP.DATA_VENCIMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataFinal.Date))]));
        lsSQL.Add('AND');
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS = %s)', [QuotedStr(dxBarCbxStatus.Items[dxBarCbxStatus.ItemIndex])]));
        lsSQL.Add('AND');

   END;

    if (dxBarCbxStatus.ItemIndex = 3) then BEGIN //TODOS OS TITULOS COM DATA PAGAMENTO NO PERIODO
         tpStatus := '(''QUITADO'',''PARCIAL'')';
        lsSQL.Add(Format('  (TP.DATA_PAGAMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataFinal.Date))]));
        lsSQL.Add('AND');
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS IN %s)', [tpStatus]));
        lsSQL.Add('AND');

   END;

  lsSQL.Add(Format('  (TP.ID_ORGANIZACAO = %s)', [QuotedStr(idOrgzanizacao)]));

  if (dxBarCbxCentroCusto.ItemIndex > 0) then
  begin
    lsSQL.Add('AND');
    lsSQL.Add(Format('  (TPC.ID_CENTRO_CUSTO = %s)', [QuotedStr(FsListaIdCentrosCusto[dxBarCbxCentroCusto.ItemIndex])]));
  end;

  lsSQL.Add('ORDER BY');
  lsSQL.Add('  ' + retornarCampoOrdenacao);

  Result := dmRelPagamentos.obterTitulosExcel(lsSQL,idOrgzanizacao,dxBarDataInicial.Date, dxBarDataFinal.Date );
  //Result := (lsSQL.Count > 0);
  lsSql := nil;
end;

procedure TfrmRelatorioPagamentos.preencherListaCentrosCusto;
begin
  FsListaIdCentrosCusto := TStringList.Create;
  FsListaIdCentrosCusto.Clear;
  FsListaIdCentrosCusto.Add('Sem ID'); //Linha adicionada somente para combatibilizar com os itens do ComboBox cbxCentrosCusto
  dxBarCbxCentroCusto.Items.Clear;
  dxBarCbxCentroCusto.Items.Add('TODOS');
  dmRelPagamentos.qryCentroCusto.First;
  while not dmRelPagamentos.qryCentroCusto.Eof do
  begin
    dxBarCbxCentroCusto.Items.Add(dmRelPagamentos.qryCentroCusto.FieldByName('DESCRICAO').AsString);
    FsListaIdCentrosCusto.Add(dmRelPagamentos.qryCentroCusto.FieldByName('ID_CENTRO_CUSTO').AsString);
    dmRelPagamentos.qryCentroCusto.Next;
  end;
  dmRelPagamentos.qryCentroCusto.Close;
  dxBarCbxCentroCusto.ItemIndex := 0;
end;

function TfrmRelatorioPagamentos.retornarCaminhoRelatorio(tipo: Integer): string;
begin


  case tipo of
    0:
      Result := uUtil.TPathRelatorio.getContasPagarFiltro;  // ExtractFilePath(Application.ExeName) + 'relContasPagarPorFiltro.fr3';
    1:
      Result :=  uUtil.TPathRelatorio.getContasPagarFiltroAnalitico ; //ExtractFilePath(Application.ExeName) + 'relContasPagarPorFiltroAnalitico.fr3';
    10:
      Result :=  uUtil.TPathRelatorio.getContasPagarFiltroExcel; // ExtractFilePath(Application.ExeName) + 'relContasPagarPorFiltroExcel.fr3';

  end;

end;

function TfrmRelatorioPagamentos.retornarCampoOrdenacao: string;
begin
  case dxBarCbxOrdem.ItemIndex of
    0:
      Result := 'TP.VALOR_NOMINAL';
    1:
      Result := 'C.NOME';
    2:
      Result := 'CC.DESCRICAO';
    3:
      Result := 'TP.DATA_PAGAMENTO';
    4:
      Result := 'TP.DATA_VENCIMENTO';
    5:
      Result := 'H.DESCRICAO';
    6:
      Result := 'T.DESCRICAO';
  end;
end;

function TfrmRelatorioPagamentos.validarFormulario: boolean;
begin
  Result := true;
end;



procedure TfrmRelatorioPagamentos.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmRelatorioPagamentos.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F10] = Pagar ';
end;

end.

