unit uFrmRelatoriosPagamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, uDMRelatoriosPagamentos,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, uOrganizacaoDAO,uOrganizacaoModel,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands,  udmConexao, FireDAC.Stan.Util,
   FireDAC.Comp.Script, Vcl.Grids, Vcl.DBGrids, frxClass, frxDBSet, frxExportPDF, frxExportCSV, uUtil, Vcl.Buttons, ComObj,
  frxExportBaseDialog, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,uHistoricoDAO,uHistoricoModel,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins, uFrmBaixaFP, uTituloPagarModel,
  dxRibbonCustomizationForm, cxClasses, dxRibbon, dxBar, EMsgDlg, uFrmEnviaMail,
  dxDateTimeWheelPicker, cxBarEditItem, dxBarExtItems, Vcl.ExtCtrls, dxStatusBar,
  frxExportXLSX;

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
    dxBarCbxHistorico: TdxBarCombo;
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
    dxBarBtnEnviarEmail: TdxBarLargeButton;
    frxXLSXExport1: TfrxXLSXExport;
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
    procedure dxBarBtnEnviarEmailClick(Sender: TObject);
  private
    { Private declarations }
    FsListaIdOrganizacoes: TStringList;
    FsListaIdHistorico: TStringList;
    idOrgzanizacao: string;
    organizacaoModel :TOrganizacaoModel;
    pTitulo : TTituloPagarModel;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
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
    procedure preencherListaHistorico;
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
    //dmOrganizacao.carregarDadosOrganizacao(idOrgzanizacao);

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
    pTitulo.Forganizacao := organizacaoModel;

end;

procedure TfrmRelatorioPagamentos.dxBarBtnConsultarClick(Sender: TObject);
begin
limpaStatusBar;

 if validarFormulario then
//  idStatus := QuotedStr(cbxStatus.Items[cbxStatus.ItemIndex]);

  begin

    if not uUtil.Empty(organizacaoModel.FID) then
    begin

  //  dmOrganizacao.carregarDadosOrganizacao(idOrgzanizacao);


      if not (carregarDadosPagamentos) then
      begin
        dxBarBtnExport.Enabled := false;
        dxBarBtnImprimir.Enabled := false;
        dxBarBtnEnviarEmail.Enabled := False;
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
        dxBarBtnEnviarEmail.Enabled := True;
        dxBarBtnExport.Enabled := True;
        cxBarPesquisaCedente.Enabled := True;
        cxBarPesquisaDocumento.Enabled := True;
      end;
    end;
  end;


end;

procedure TfrmRelatorioPagamentos.dxBarBtnEnviarEmailClick(Sender: TObject);
var
localFile, assunto, arquivo :string;
begin



  if not (dsPreencheGrid.DataSet.IsEmpty) then
  begin

    frxRelContasPagar.Clear;
    if not (frxRelContasPagar.LoadFromFile(retornarCaminhoRelatorio(dxBarCbxTipoRel.ItemIndex))) then

    begin
      PempecMsg.MsgError('N�o foi poss�vel imprimir. Informe ao suporte : FALTA FR3 ');
    end
    else
    begin

      //enviar por PDF
      arquivo := 'REL_CONTAS_PAGAR' + FormatDateTime('dd.MM.yyyy_hh.mm.ss', now)  + '.PDF';
      localFile := GetCurrentDir + '\rel\tp\'; //informa a pasta onde o arquivo ser� gravado
      dmConexao.frxPDFExport := TfrxPDFexport.Create(Self);

      dmConexao.frxPDFExport.FileName := arquivo;
      dmconexao.frxPDFExport.DefaultPath := localFile;
      dmconexao.frxPDFExport.ShowDialog := False;
      dmconexao.frxPDFExport.ShowProgress := False;
      dmconexao.frxPDFExport.OverwritePrompt := True;


      inicializarVariaveisRelatorio;

      frxRelContasPagar.OldStyleProgress := True;
      frxRelContasPagar.ShowProgress := True;
      frxRelContasPagar.PrepareReport(True);

      frxRelContasPagar.Export(dmconexao.frxPDFExport);

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

procedure TfrmRelatorioPagamentos.dxBarBtnExportClick(Sender: TObject);
var
  linha, coluna: integer;
var
  planilha: variant;
var
arquivo ,  valorcampo: string;
begin
   arquivo := '';

  //para excel foi informado que seriam todos os titulos. Considerando apenas periodo.
  if (montarSQLForExcel) then begin

  //  exibirRelatorioExcel(10); //10 inddica ser EXCEL

   arquivo := uutil.ExpDataSetForTXT(dmRelPagamentos.qryRelPagamentos, ExtractFilePath(Application.ExeName)+ 'REL\TP\FNC_REL_TP_ '+ SoNumeros(DateToStr(Now)) + '.CSV');

   PempecMsg.MsgInformation('Arquivo criado com sucesso '+#13#13 + arquivo );
   msgStatusBar(4, 'Arquivo :' );
   msgStatusBar(5, arquivo );

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
      //carregarDadosPagamentos;

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
    PempecMsg.MsgInformation('Arquivo n�o encontrado. Informe o erro ao suporte. EXP_EXCEL_FILE');

  end
  else
  begin

    frxReportExcel.OldStyleProgress := True;
    frxReportExcel.ShowProgress := True;
    frxReportExcel.ShowReport;

   // frxReportExcel.Export(frxCSVExport1);

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
  dxBarBtnEnviarEmail.Enabled := False;
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

    idOrgzanizacao   :=uUtil.TOrgAtual.getId;
    organizacaoModel := TOrganizacaoModel.Create;
    organizacaoModel.FID := idOrgzanizacao;
    organizacaoModel := TOrganizacaoDAO.obterPorID(organizacaoModel);


    dxBarDataInicial.Date          := now;
    dxBarDataFinal.Date            := now;
    dxBarCbxStatus.ItemIndex         := 0;
    dxBarCbxHistorico.ItemIndex   :=0;
    dxBarCbxOrdem.ItemIndex          :=0;
    dxBarCbxTipoRel.ItemIndex  :=0;


  if not (Assigned(dmRelPagamentos)) then
  begin
    dmRelPagamentos := TdmRelPagamentos.Create(Self);
  end;


  preencherListaHistorico;




end;

procedure TfrmRelatorioPagamentos.inicializarVariaveisRelatorio;
var
sucesso : Boolean;
begin
  sucesso := False;

  if (organizacaoModel.Fvinculada) then
  begin
    sucesso := True;
  end
  else
  begin
    sucesso := False;
    organizacaoModel.FID := uutil.TOrgAtual.getId;
    organizacaoModel := TOrganizacaoDAO.obterPorID(organizacaoModel);
    sucesso := organizacaoModel.Fvinculada;

  end;



  if sucesso then
  begin

   { with frxRelContasPagar.Variables do
    begin
      Variables['strRazaoSocial'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL').AsString);
      Variables['strCNPJ'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
      Variables['strEndereco'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('ENDERECO').AsString);
      Variables['strCEP'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CEP').AsString);
      Variables['strCidade'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CIDADE').AsString);
      Variables['strUF'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
      Variables['strTipoStatus'] := QuotedStr(dxBarCbxStatus.Items[dxBarCbxStatus.ItemIndex]);

    end;   }

     with frxRelContasPagar.Variables do
    begin
      Variables['strRazaoSocial'] := QuotedStr(organizacaoModel.FRazaoSocial);
      Variables['strCNPJ'] := QuotedStr(organizacaoModel.FCNPJ);
      Variables['strEndereco'] := QuotedStr(organizacaoModel.FLOGRADOURO +' '+ organizacaoModel.FCOMPLEMENTO + ' ' + organizacaoModel.FBairro.Fbairro);
      Variables['strCEP'] := QuotedStr(organizacaoModel.FCEP);
      Variables['strCidade'] := QuotedStr(organizacaoModel.FCidade.Fcidade);
      Variables['strUF'] := QuotedStr(organizacaoModel.FIDESTADO);
      Variables['strTipoStatus'] := QuotedStr(dxBarCbxStatus.Items[dxBarCbxStatus.ItemIndex]);

    end;




  end;
end;

function TfrmRelatorioPagamentos.montarSQL: Boolean;
var
  lsSQL: TStringList;
  tpStatus,  x: string;


begin
  dmConexao.conectarBanco;
  tpStatus :='';
  lsSQL := TStringList.Create;
  lsSQL.AddStrings(dmRelPagamentos.sqlScriptContainer.SQLScripts.FindScript('sqlRelPagamentos').SQL);
  lsSQL.Add('WHERE');

  if (dxBarCbxHistorico.ItemIndex > 0) then
  begin
    lsSQL.Add(Format('  (TP.ID_HISTORICO = %s)', [QuotedStr(FsListaIdHistorico[dxBarCbxHistorico.ItemIndex])]));
    lsSQL.Add('AND');
  end;


   if (dxBarCbxStatus.ItemIndex = 0) then BEGIN //TODOS OS TITULOS COM DATA VENCIMENTO NO PERIODO
        lsSQL.Add(Format(' ( (TP.DATA_VENCIMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataFinal.Date))]));
       // lsSQL.Add('OR');
       // lsSQL.Add(Format('  (TP.DATA_PAGAMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataFinal.Date))]));
        lsSQL.Add(' ) AND');
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS <> %s)', [QuotedStr('EXCLUIDO')]));
        lsSQL.Add(' AND');
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
        lsSQL.Add(Format(' ( (TP.DATA_VENCIMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataFinal.Date))]));
        lsSQL.Add('OR');
        lsSQL.Add(Format('  (TP.DATA_PAGAMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataFinal.Date))]));
        lsSQL.Add(') AND');

        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS <> %s)', [QuotedStr('EXCLUIDO')]));
        lsSQL.Add('AND');
   END;

   if (dxBarCbxStatus.ItemIndex = 1) then BEGIN //TODOS OS TITULOS COM DATA VENCIMENTO NO PERIODO
        lsSQL.Add(Format(' (TP.DATA_VENCIMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataFinal.Date))]));
        lsSQL.Add('AND');
        lsSQL.Add(Format('  (TP.ID_TIPO_STATUS = %s)', [QuotedStr(dxBarCbxStatus.Items[dxBarCbxStatus.ItemIndex])]));
        lsSQL.Add('AND');

   END;

   if (dxBarCbxStatus.ItemIndex = 2) then BEGIN //TODOS OS TITULOS EXCLUIDOS NO PERIODO
        tpStatus := '(''EXCLUIDO'')';
        lsSQL.Add(Format('  (TP.DATA_EMISSAO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dxBarDataFinal.Date))]));
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

   if (dxBarCbxHistorico.ItemIndex > 0) then
  begin

    lsSQL.Add(Format('  (TPH.ID_HISTORICO = %s)', [QuotedStr(FsListaIdHistorico[dxBarCbxHistorico.ItemIndex])]));
        lsSQL.Add('AND');
  end;


  lsSQL.Add(Format('  (TP.ID_ORGANIZACAO = %s)', [QuotedStr(idOrgzanizacao)]));


  lsSQL.Add('ORDER BY');
  lsSQL.Add('  ' + retornarCampoOrdenacao);

  Result := dmRelPagamentos.obterTitulosExcel(lsSQL,idOrgzanizacao,dxBarDataInicial.Date, dxBarDataFinal.Date );
  //Result := (lsSQL.Count > 0);
  lsSql := nil;
end;


procedure TfrmRelatorioPagamentos.preencherListaHistorico;
var
historico : THistoricoModel;
begin
  FsListaIdHistorico := TStringList.Create;

  {
  FsListaIdHistorico.Clear;
  FsListaIdHistorico.Add('Sem ID'); //Linha adicionada somente para combatibilizar com os itens do ComboBox cbxCentrosCusto
  dxBarCbxHistorico.Items.Clear;
  dxBarCbxHistorico.Items.Add('TODOS');    }

  historico := THistoricoModel.Create;
  historico.FIdOrganizacao := idOrgzanizacao;
  historico.FTipo := 'P'; //tipo pagamento e geral

  THistoricoDAO.comboDxBar(historico,dxBarCbxHistorico, FsListaIdHistorico );

  dxBarCbxHistorico.ItemIndex := 0;

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


