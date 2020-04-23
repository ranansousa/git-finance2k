unit uFrmEspelhoTP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameTP, uDMOrganizacao, udmConexao, uUtil,
  Vcl.StdCtrls, Vcl.Buttons, EEdBtn, ENumEd, cxGraphics, cxControls,uDMEspelhoTP,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxStatusBar, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,uTituloPagarModel, uTituloPagarDAO,
  FireDAC.Comp.Client, frxClass, frxDBSet, Vcl.ComCtrls, EMsgDlg, dxRibbonSkins,
  dxRibbonCustomizationForm, dxBar, cxClasses, dxRibbon, cxTextEdit,
  cxBarEditItem, Vcl.Grids, Vcl.DBGrids, System.DateUtils, FireDAC.UI.Intf,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,
  dxBarExtItems;

type
  TformEspelhoTP = class(TForm)
    qryBusca: TFDQuery;
    statStatusEsp: TStatusBar;
    PempecMsg: TEvMsgDlg;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar3: TdxBar;
    dxBarManager1Bar4: TdxBar;
    dxBtnFechar: TdxBarLargeButton;
    dxBtnImprimir: TdxBarLargeButton;
    dxBarEdit1: TdxBarEdit;
    cxbrdtmPesquisa: TcxBarEditItem;
    dbgrdMain: TDBGrid;
    qryPreencheGrid: TFDQuery;
    dsTitulos: TDataSource;
    cxBarPesquisaCedente: TcxBarEditItem;
    qryRelPagamentos: TFDQuery;
    sqlScriptContainer: TFDScript;
    dxBarManager1Bar2: TdxBar;
    dxBarDTINI: TdxBarDateCombo;
    dxBarDTFIN: TdxBarDateCombo;
    dxBarCbxOrdem: TdxBarCombo;
    dxBarCbxFornecedor: TdxBarCombo;
    dxBarCbxTipo: TdxBarCombo;
    dxBarBtnConsulta: TdxBarButton;
    dxBarCbxStatus: TdxBarCombo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxBtnFecharClick(Sender: TObject);
    procedure dxBtnImprimirClick(Sender: TObject);
    procedure cxbrdtmPesquisaCurChange(Sender: TObject);
    procedure dsTitulosDataChange(Sender: TObject; Field: TField);
    procedure cxBarPesquisaCedenteCurChange(Sender: TObject);
    procedure dbgrdMainTitleClick(Column: TColumn);
    procedure dxBarBtnConsultaClick(Sender: TObject);
  private
    { Private declarations }
    idOrganizacao : string;
    FsListaIdTP : TStringList;
    indexCombo :Integer;
    pNumeroDoc, pId :string;
    dtI, dtF :TDateTime;


    procedure limpaPanel;
    procedure preencheStatus(posicalPanel: Integer; msg: string);
    function obterTP(pIdOrganizacao, pidTP, pNumeroDoc: string): Boolean;
    function obterIndiceLista(pId: string; lista: TStringList): Integer;
    function preencheGrid(pIdOrganizacao: string; dataInicio, dataFim :TDateTime): Boolean;
    function obterTodosPagamentos(sql: TStringList; pIdOrganizacao: string;
      dtDataInicial, dtDataFinal: TDate): Boolean;
    function montarSQL: Boolean;
    function retornarCampoOrdenacao: string;
    function obterTodosTitulos(sql: TStringList; pIdOrganizacao: string;
      dtDataInicial, dtDataFinal: TDate): Boolean;
  public
    { Public declarations }

   constructor Create(AOwner: TComponent; nDoc :String);  overload;

  end;

var
  formEspelhoTP: TformEspelhoTP;

implementation

{$R *.dfm}


function TformEspelhoTP.obterIndiceLista(pId: string;  lista: TStringList): Integer;
var
  I: Integer;
begin
 Result :=0;

  for I := 0 to lista.Count-1 do begin
    if(lista[I].Equals(pId)) then begin
       Result := I;
       Break;
    end;

  end;

end;


constructor TformEspelhoTP.Create(AOwner: TComponent; nDoc: String);
var
tituloEntrada :TTituloPagarModel;

begin
  inherited Create(AOwner);
  dtI := Now;
  dtF := Now;


  tituloEntrada := TTituloPagarModel.Create;
  if uUtil.Empty(idOrganizacao) then begin idOrganizacao := uutil.TOrgAtual.getId;end;

  FsListaIdTP := TStringList.Create;
  FsListaIdTP.Clear;

  if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;
  if not (Assigned(dmEspelhoTP)) then
  begin
    dmEspelhoTP := TdmEspelhoTP.Create(Self);
  end;

  limpaPanel;


    if not (uutil.Empty(nDoc)) then
    begin

      tituloEntrada.FIDorganizacao := idOrganizacao;
      tituloEntrada.FnumeroDocumento := nDoc;
      tituloEntrada := TTituloPagarDAO.obterPorNumeroDocumento(tituloEntrada);

    end;

    if not uutil.Empty(tituloEntrada.FID) then begin

         pNumeroDoc := tituloEntrada.FnumeroDocumento;
         pId  := tituloEntrada.FID;
       //seta para impressao


         FsListaIdTP.Add(pId);



         dxBtnImprimir.Click;

    end else begin

       limpaPanel;


    end;

end;



procedure TformEspelhoTP.cxBarPesquisaCedenteCurChange(Sender: TObject);
begin
 dbgrdMain.DataSource.DataSet.Locate('FORNECEDOR',UpperCase(cxBarPesquisaCedente.CurEditValue),[loPartialKey]);
end;

procedure TformEspelhoTP.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
 dbgrdMain.DataSource.DataSet.Locate('NUMERO_DOCUMENTO',UpperCase(cxbrdtmPesquisa.CurEditValue),[loPartialKey]);
end;

procedure TformEspelhoTP.dbgrdMainTitleClick(Column: TColumn);
begin
(dbgrdMain.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

procedure TformEspelhoTP.dsTitulosDataChange(Sender: TObject; Field: TField);
var
tituloPagar : TTituloPagarModel;
begin

  if qryPreencheGrid.RecordCount > 0 then
  begin

    tituloPagar := TTituloPagarModel.Create;
    tituloPagar.FIDorganizacao := qryPreencheGrid.FieldByName('ID_ORGANIZACAO').AsString;
    tituloPagar.FID := qryPreencheGrid.FieldByName('ID').AsString;
    tituloPagar := TTituloPagarDAO.obterPorID(tituloPagar);

    if not uUtil.Empty(tituloPagar.FID) then
    begin
      pNumeroDoc := tituloPagar.FnumeroDocumento;
      pId := tituloPagar.FID;
      obterTP(idOrganizacao, tituloPagar.FID, tituloPagar.FnumeroDocumento);
      preencheStatus(1, 'Espelho pronto para ser impresso.');
      dxBtnImprimir.Enabled := True;

    end
    else
    begin
      preencheStatus(1, 'Precisa selecionar um número de documento..');
      PempecMsg.MsgWarning('Selecione um título ');
    end;

  end;


end;

procedure TformEspelhoTP.dxBarBtnConsultaClick(Sender: TObject);
begin

  if montarSQL then
  begin

  { (dbgrdMain.DataSource.DataSet as TFDQuery).Close;
    dbgrdMain.DataSource.DataSet := qryRelPagamentos;  }
    if qryPreencheGrid.RecordCount > 0 then
    begin
    dbgrdMain.DataSource.DataSet := qryPreencheGrid;
    dbgrdMain.Refresh;
    end;


  end
  else
  begin
    PempecMsg.MsgWarning('A consulta não retornou resultados.' + #13 + ' Serão mostrados os titulos com vencimento/pagamento do mês corrente ');
    limpaPanel;
  end;


end;

procedure TformEspelhoTP.dxBtnFecharClick(Sender: TObject);
begin
  limpaPanel;
  PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TformEspelhoTP.dxBtnImprimirClick(Sender: TObject);
begin

if (dmEspelhoTP.obterPorNumeroDocumento(idOrganizacao, pNumeroDoc)) then begin

     if (qryBusca.RecordCount > 0) then  begin
              preencheStatus(1,'Espelho pronto para ser impresso.');
              dmEspelhoTP.exibirRelatorio(uutil.getDataServer, uutil.getDataServer);
              limpaPanel;
      end
      else
      begin
        dxBtnImprimir.Enabled := false;
        limpaPanel;
        preencheStatus(1,'Não foi possível imprmir.');
        PempecMsg.MsgWarning('Não existem dados para imprimir.');
      end

  end;
end;

 procedure TformEspelhoTP.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if  (Assigned(dmEspelhoTP)) then
  begin
    FreeAndNil(dmEspelhoTP);
  end;



end;

procedure TformEspelhoTP.FormCreate(Sender: TObject);
begin

 if uUtil.Empty(idOrganizacao) then begin idOrganizacao := uutil.TOrgAtual.getId;end;

 //frameTP1.obterTodos(idOrganizacao,frameTP1.cbbTP,FsListaIdTP);


 if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;


  if not(Assigned(dmEspelhoTP)) then
  begin
    dmEspelhoTP := TdmEspelhoTP.Create(Self);
  end  ;



  limpaPanel;

end;

procedure TformEspelhoTP.preencheStatus(posicalPanel :Integer; msg :string);
 begin
  statStatusEsp.Panels[posicalPanel].Text := msg;
 end;


 function TformEspelhoTP.obterTP(pIdOrganizacao, pidTP, pNumeroDoc :string) :Boolean;
 var
  cmdSql :string;
  begin

    dmConexao.conectarBanco;

    try
      if uUtil.Empty(pIdOrganizacao) then begin
          pIdOrganizacao := uutil.TOrgAtual.getId;
      end;


    if not uUtil.Empty(pidTP) then
    begin
      try
        qryBusca.Close;
        qryBusca.Connection := dmConexao.conn;
        qryBusca.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryBusca.ParamByName('PIDTP').AsString := pidTP;
        qryBusca.ParamByName('PNUMDOC').AsString := pNumeroDoc;
        qryBusca.Open;
      except
        raise Exception.Create('Erro ao tentar consultar dados dos títulos.');
      end;
    end;
    except
    raise Exception.Create('Erro ao consultar o título :' + pNumeroDoc);
    end;
    preencheStatus(1,'A consulta retornou ' + IntToStr(qryBusca.RecordCount) + ' registros. ');
    Result := not qryBusca.IsEmpty;

  end;

procedure TformEspelhoTP.limpaPanel;

begin

 preencheStatus(0,' Status : ');
 preencheStatus(1,'Pronto');

 dxBtnImprimir.Enabled := false;

 if  (Assigned(dmEspelhoTP)) then
  begin
    FreeAndNil(dmEspelhoTP);
  end;

  if not (Assigned(dmEspelhoTP)) then
  begin
    dmEspelhoTP := TdmEspelhoTP.Create(Self);
  end;

  dtI := StartOfTheMonth(now);
  dtF := EndOfTheMonth(Now);

  dxBarDTINI.Date := dtI;
  dxBarDTFIN.Date := dtF;
  dxBarCbxStatus.ItemIndex :=0;
  dxBarCbxTipo.ItemIndex :=0;
  dxBarCbxOrdem.ItemIndex :=0;


  dbgrdMain.Enabled := True;
  preencheGrid(idOrganizacao,dtI, dtF);

  //limpaStatusBar;


end;


function TformEspelhoTP.preencheGrid(pIdOrganizacao: string; dataInicio, dataFim :TDateTime): Boolean;
var
sqlCmd :string;
begin

 dmConexao.conectarBanco;

 try

    if uUtil.Empty(pIdOrganizacao) then begin
       pIdOrganizacao := Uutil.TOrgAtual.getId;
    end;

  {
    if Assigned(qryPreencheGrid) then
    begin
      FreeAndNil(qryPreencheGrid);
    end;

    qryPreencheGrid := TFDQuery.Create(Self);    }


    sqlCmd :=' SELECT TP.ID_TITULO_PAGAR as ID, '+
       'TP.ID_ORGANIZACAO,  '+
       'TP.ID_CEDENTE,     '+
       'TP.ID_HISTORICO,    '+
       'TP.NUMERO_DOCUMENTO, '+
       'TP.VALOR_NOMINAL,     '+
       'TP.DESCRICAO as dsc_tp,'+
       'TP.DATA_VENCIMENTO, '+
       'TP.DATA_PAGAMENTO,   '+
       'C.NOME as fornecedor, '+
       'H.DESCRICAO as dsc_hst '+
      ' FROM TITULO_PAGAR TP '+
      ' LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND (C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)    '+
      ' LEFT OUTER JOIN HISTORICO H ON (TP.ID_HISTORICO = H.ID_HISTORICO) AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'+
      ' WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)      '+
      ' AND (TP.DATA_VENCIMENTO BETWEEN :DTI AND :DTF) '+
      ' AND   (TP.ID_TIPO_STATUS <> ''EXCLUIDO'') '+
      ' ORDER BY TP.DATA_PAGAMENTO DESC ';

    qryPreencheGrid.Close;
    qryPreencheGrid.Connection := dmConexao.conn;
    qryPreencheGrid.SQL.Clear;
    qryPreencheGrid.SQL.Add(sqlCmd);
    qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryPreencheGrid.ParamByName('DTI').AsDate := dataInicio;
    qryPreencheGrid.ParamByName('DTF').AsDate := dataFim;

    qryPreencheGrid.Open;

    dbgrdMain.DataSource.DataSet := qryPreencheGrid;
    dbgrdMain.Refresh;


 except
 raise Exception.Create('Erro ao obter lista de títulos...' );

 end;

 Result := not qryPreencheGrid.IsEmpty;

end;




function TformEspelhoTP.obterTodosPagamentos(sql :TStringList; pIdOrganizacao : string; dtDataInicial, dtDataFinal: TDate): Boolean;
var
aux :Integer;
begin

  aux := 0;

  if sql.Count >0  then begin

      try

      qryRelPagamentos.Close;
      qryRelPagamentos.Connection := dmConexao.Conn;
      qryRelPagamentos.SQL.Clear;
      qryRelPagamentos.SQL.Assign(sql);
      qryRelPagamentos.Open;
      qryRelPagamentos.Last;

      except
      raise(Exception).Create('Erro ao tentar  consultar os Titulos ' + ' obterTodosPagamentos ' );
      end;
  end;

   aux :=qryRelPagamentos.RecordCount;

  Result := not qryRelPagamentos.IsEmpty;

end;


function TformEspelhoTP.obterTodosTitulos(sql :TStringList; pIdOrganizacao : string; dtDataInicial, dtDataFinal: TDate): Boolean;
var
aux :Integer;
begin
aux := 0;
              {
  if Assigned(qryPreencheGrid) then begin
  FreeAndNil(qryPreencheGrid);
  end;

  qryPreencheGrid := TFDQuery.Create(Self);    }


  if sql.Count >0  then begin

      try



      qryPreencheGrid.Close;
      qryPreencheGrid.Connection := dmConexao.Conn;
      qryPreencheGrid.SQL.Clear;
      qryPreencheGrid.SQL.Assign(sql);
      qryPreencheGrid.Open;


      except
      raise(Exception).Create('Erro ao tentar  consultar os Titulos ' + ' Preenche o Grid ' );
      end;
  end;

   aux :=qryPreencheGrid.RecordCount;

  Result := not qryPreencheGrid.IsEmpty;

end;

function TformEspelhoTP.montarSQL: Boolean;
var
  lsSQL: TStringList;
  tpStatus,  x: string;
  pDataIn, pDataFim :TDateTime;

begin
  dmConexao.conectarBanco;

  pDataIn := dxBarDTINI.Date;
  pDataFim := dxBarDTFIN.Date;


  lsSQL := TStringList.Create;
  lsSQL.AddStrings(sqlScriptContainer.SQLScripts.FindScript('sqlRelPagamentos').SQL);
  lsSQL.Add('WHERE');


   // consulta por campo de data

   if (dxBarCbxTipo.ItemIndex = 0) then BEGIN //TODOS OS TITULOS COM DATA VENCIMENTO NO PERIODO
        lsSQL.Add(Format('  (TP.DATA_VENCIMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', pDataIn)), QuotedStr(FormatDateTime('dd.mm.yyyy', pDataFim))]));
        lsSQL.Add('AND');
   END else begin  lsSQL.Add(Format('  (TP.DATA_PAGAMENTO BETWEEN %s AND %s)', [QuotedStr(FormatDateTime('dd.mm.yyyy', pDataIn)), QuotedStr(FormatDateTime('dd.mm.yyyy', pDataFim))]));
        lsSQL.Add('AND'); end;


   //  ID_TIPO_STATUS

    if (dxBarCbxStatus.ItemIndex = 0) then BEGIN //TODOS OS TITULOS
        tpStatus := ' (''QUITADO'',''PARCIAL'',''ABERTO'' )';
    END;

    if (dxBarCbxStatus.ItemIndex = 1) then BEGIN //TODOS OS TITULOS QUITADOS
        tpStatus := ' (''QUITADO'',''PARCIAL'' )';
    END;

      if (dxBarCbxStatus.ItemIndex = 2) then BEGIN //TODOS OS TITULOS ABERTOS
        tpStatus := ' (''ABERTO'' )';
    END;

    lsSQL.Add(Format('  (TP.ID_TIPO_STATUS IN %s)', [tpStatus]));
    lsSQL.Add('AND');

   //organizacao
    lsSQL.Add(Format('  (TP.ID_ORGANIZACAO = %s)', [QuotedStr(idOrganizacao)]));

  lsSQL.Add(' ORDER BY');
  lsSQL.Add('  ' + retornarCampoOrdenacao);

  Result := obterTodosTitulos(lsSQL,idOrganizacao,pDataIn, pDataFim );

  lsSql := nil;
end;

function TformEspelhoTP.retornarCampoOrdenacao: string;
begin
  case dxBarCbxOrdem.ItemIndex of
    0:
      Result := 'TP.DATA_VENCIMENTO';
    1:
      Result :=  'TP.DATA_PAGAMENTO';
    2:
      Result := 'TP.VALOR_NOMINAL';

  end;
end;


end.
