unit uFrmRelatoriosPagamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, uDMRelatoriosPagamentos,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, uDMOrganizacao,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands,  udmConexao, FireDAC.Stan.Util,
   FireDAC.Comp.Script, Vcl.Grids, Vcl.DBGrids, frxClass, frxDBSet, frxExportPDF, frxExportCSV, uUtil, Vcl.Buttons, ComObj,
  frxExportBaseDialog;

  //uDM está aqui temporariamente

type
  TfrmRelatorioPagamentos = class(TForm)
    dtDataInicial: TDateTimePicker;
    dtDataFinal: TDateTimePicker;
    cbxCentrosCusto: TComboBox;
    cbxStatus: TComboBox;
    cbxOrdem: TComboBox;
    btnConsultar: TButton;
    DBGridMain: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    frxRelContasPagar: TfrxReport;
    frxDBTitulos: TfrxDBDataset;
    frxDBCentroCusto: TfrxDBDataset;
    btnImprimir: TBitBtn;
    cbxTipoRelatorio: TComboBox;
    Label1: TLabel;
    frxDBHistorico: TfrxDBDataset;
    frxDBTitulosExcel: TfrxDBDataset;
    frxReportExcel: TfrxReport;
    btnExcel: TBitBtn;
    statusBar2: TStatusBar;
    dsPreencheGrid: TDataSource;
    btnFechar: TBitBtn;
    frxpdfxprt1: TfrxPDFExport;
    frxCSVExport1: TfrxCSVExport;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure dsPreencheGridDataChange(Sender: TObject; Field: TField);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
    FsListaIdOrganizacoes: TStringList;
    FsListaIdCentrosCusto: TStringList;
    idOrgzanizacao: string;
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
      btnExcel.Visible := false;
      btnImprimir.Enabled := false;
      ShowMessage('Consulta não retornou dados.');
      statusBar2.Panels[4].Text := 'Consulta retonou vazia.';
      exibirValoresPanel;
    end
    else
    begin
      exibirValoresPanel;
      btnImprimir.Enabled := True;
      btnExcel.Visible := True;
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
    ShowMessage('Não é possível gerar exportação.');
  end;

end;

procedure TfrmRelatorioPagamentos.btnFecharClick(Sender: TObject);
begin
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmRelatorioPagamentos.btnImprimirClick(Sender: TObject);
begin
  if validarFormulario then
  begin

    if (cbxTipoRelatorio.ItemIndex > (-1)) then
    begin
      if not (dsPreencheGrid.DataSet.IsEmpty) then
      begin
        btnExcel.Visible := true; //libera exporta excel
        exibirRelatorio(cbxTipoRelatorio.ItemIndex);
      end
      else
      begin
        btnExcel.Visible := false;
        ShowMessage('Consulta não retornou dados');
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

procedure TfrmRelatorioPagamentos.dsPreencheGridDataChange(Sender: TObject;
  Field: TField);
  var
  idTituloPagar :string;
begin
// carrega os historicos
    idTituloPagar :=  TFDQuery(DBGridMain.DataSource.DataSet).FieldByName('ID_TITULO_PAGAR').AsString;

    dmRelPagamentos.obterHistoricoPorTP(idOrgzanizacao, idTituloPagar);
    dmRelPagamentos.obterCentroCustoPorTP(idOrgzanizacao,idTituloPagar);

end;

procedure TfrmRelatorioPagamentos.exibirRelatorioExcel(tipo: Integer);
begin
// EXCEL TIPO 10

  frxReportExcel.Clear;
  if not (frxReportExcel.LoadFromFile(retornarCaminhoRelatorio(tipo))) then
  begin
    //Mensagem não encontrou o arquivo do relatorio. Fazer

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
  if (cbxStatus.ItemIndex > (-1)) then

  begin
    statusBar2.Panels[0].Text := 'Total devido : '+ (FormatCurr('R$ ###,##0.00',dmRelPagamentos.obterTotalPorStatus(TOrgAtual.getId, 'ABERTO', dtDataInicial.Date, dtDataFinal.Date)));
    statusBar2.Panels[1].Text := 'Total pago :  '  + (FormatCurr('R$ ###,##0.00',dmRelPagamentos.obterTotalPorStatus(TOrgAtual.getId, 'QUITADO', dtDataInicial.Date, dtDataFinal.Date)));
  end;

end;

procedure TfrmRelatorioPagamentos.exibirRelatorio(tipo: Integer);
begin

     frxRelContasPagar.Clear;
  if not (frxRelContasPagar.LoadFromFile(retornarCaminhoRelatorio(tipo))) then
  begin
    //Mensagem não encontrou o arquivo do relatorio. Fazer

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

  btnExcel.Visible := False;
  btnImprimir.Enabled := false;


end;

procedure TfrmRelatorioPagamentos.freeAndNilDM(Sender: TObject);
begin
  //nada

end;

procedure TfrmRelatorioPagamentos.inicializarDM(Sender: TObject);
begin
     dmConexao.conectarBanco;

    idOrgzanizacao              :=uUtil.TOrgAtual.getId;
    dtDataInicial.Date          := now;
    dtDataFinal.Date            := now;
    cbxStatus.ItemIndex         := 0;
    cbxCentrosCusto.ItemIndex   :=0;
    cbxOrdem.ItemIndex          :=0;
    cbxTipoRelatorio.ItemIndex  :=0;


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
    Variables['strTipoStatus'] := QuotedStr(cbxStatus.Items[cbxStatus.ItemIndex]);

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

   if (cbxStatus.ItemIndex = 0) then BEGIN //TODOS OS TITULOS COM DATA VENCIMENTO NO PERIODO
        lsSQL.Add(Format('  (TP.DATA_VENCIMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataFinal.Date))]));
        lsSQL.Add('OR');
        lsSQL.Add(Format('  (TP.DATA_PAGAMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataFinal.Date))]));
        lsSQL.Add('AND');
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS <> %s)', [QuotedStr('EXCLUIDO')]));
        lsSQL.Add('AND');
   END;

   if (cbxStatus.ItemIndex = 1) then BEGIN //TODOS OS TITULOS COM DATA VENCIMENTO NO PERIODO
        lsSQL.Add(Format('  (TP.DATA_VENCIMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataFinal.Date))]));
        lsSQL.Add('AND');
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS = %s)', [QuotedStr(cbxStatus.Items[cbxStatus.ItemIndex])]));
        lsSQL.Add('AND');

   END;

    if (cbxStatus.ItemIndex = 2) then BEGIN //TODOS OS TITULOS EXCLUIDOS NO PERIODO
        tpStatus := '(''EXCLUIDO'')';
        lsSQL.Add(Format('  (TP.DATA_EMISSAO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataFinal.Date))]));
        lsSQL.Add('AND');
        //lsSQL.Add(Format('  (TP.ID_TIPO_STATUS IN %s)', [tpStatus]));
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS = %s)', [QuotedStr(cbxStatus.Items[cbxStatus.ItemIndex])]));
        lsSQL.Add('AND');

   END;

    if (cbxStatus.ItemIndex = 3) then BEGIN //TODOS OS TITULOS COM DATA PAGAMENTO NO PERIODO
        tpStatus := '(''QUITADO'',''PARCIAL'')';
        lsSQL.Add(Format('  (TP.DATA_PAGAMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataFinal.Date))]));
        lsSQL.Add('AND');
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS IN %s)', [tpStatus]));
        lsSQL.Add('AND');

   END;



  lsSQL.Add(Format('  (TP.ID_ORGANIZACAO = %s)', [QuotedStr(idOrgzanizacao)]));

  if (cbxCentrosCusto.ItemIndex > 0) then
  begin
    lsSQL.Add('AND');
    lsSQL.Add(Format('  (TPC.ID_CENTRO_CUSTO = %s)', [QuotedStr(FsListaIdCentrosCusto[cbxCentrosCusto.ItemIndex])]));
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

  Result := dmRelPagamentos.obterTodosPagamentos(lsSQL,idOrgzanizacao,dtDataInicial.Date, dtDataFinal.Date );
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

   if (cbxStatus.ItemIndex = 0) then BEGIN //TODOS OS TITULOS COM DATA VENCIMENTO NO PERIODO
        lsSQL.Add(Format('  (TP.DATA_VENCIMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataFinal.Date))]));
        lsSQL.Add('AND');
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS <> %s)', [QuotedStr('EXCLUIDO')]));
        lsSQL.Add('AND');
   END;

   if (cbxStatus.ItemIndex = 1) then BEGIN //TODOS OS TITULOS COM DATA VENCIMENTO NO PERIODO
        lsSQL.Add(Format('  (TP.DATA_VENCIMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataFinal.Date))]));
        lsSQL.Add('AND');
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS = %s)', [QuotedStr(cbxStatus.Items[cbxStatus.ItemIndex])]));
        lsSQL.Add('AND');

   END;

    if (cbxStatus.ItemIndex = 3) then BEGIN //TODOS OS TITULOS COM DATA PAGAMENTO NO PERIODO
         tpStatus := '(''QUITADO'',''PARCIAL'')';
        lsSQL.Add(Format('  (TP.DATA_PAGAMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataFinal.Date))]));
        lsSQL.Add('AND');
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS IN %s)', [tpStatus]));
        lsSQL.Add('AND');

   END;

  lsSQL.Add(Format('  (TP.ID_ORGANIZACAO = %s)', [QuotedStr(idOrgzanizacao)]));

  if (cbxCentrosCusto.ItemIndex > 0) then
  begin
    lsSQL.Add('AND');
    lsSQL.Add(Format('  (TPC.ID_CENTRO_CUSTO = %s)', [QuotedStr(FsListaIdCentrosCusto[cbxCentrosCusto.ItemIndex])]));
  end;

  lsSQL.Add('ORDER BY');
  lsSQL.Add('  ' + retornarCampoOrdenacao);

  Result := dmRelPagamentos.obterTitulosExcel(lsSQL,idOrgzanizacao,dtDataInicial.Date, dtDataFinal.Date );
  //Result := (lsSQL.Count > 0);
  lsSql := nil;
end;

procedure TfrmRelatorioPagamentos.preencherListaCentrosCusto;
begin
  FsListaIdCentrosCusto := TStringList.Create;
  FsListaIdCentrosCusto.Clear;
  FsListaIdCentrosCusto.Add('Sem ID'); //Linha adicionada somente para combatibilizar com os itens do ComboBox cbxCentrosCusto
  cbxCentrosCusto.Clear;
  cbxCentrosCusto.Items.Add('TODOS');
  dmRelPagamentos.qryCentroCusto.First;
  while not dmRelPagamentos.qryCentroCusto.Eof do
  begin
    cbxCentrosCusto.Items.Add(dmRelPagamentos.qryCentroCusto.FieldByName('DESCRICAO').AsString);
    FsListaIdCentrosCusto.Add(dmRelPagamentos.qryCentroCusto.FieldByName('ID_CENTRO_CUSTO').AsString);
    dmRelPagamentos.qryCentroCusto.Next;
  end;
  dmRelPagamentos.qryCentroCusto.Close;
  cbxCentrosCusto.ItemIndex := 0;
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
  case cbxOrdem.ItemIndex of
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

end.


