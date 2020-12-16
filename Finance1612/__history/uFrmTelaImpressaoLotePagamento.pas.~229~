unit uFrmTelaImpressaoLotePagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,UMostraErros,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uUtil,uLotePagamentoModel, uLotePagamentoDAO,
  udmConexao, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,  System.Generics.Collections, uTituloPagarModel, uTituloPagarDAO,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uDMOrganizacao,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,uTPBaixaDAO,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, frxClass, frxDBSet, uContaBancariaChequeModel, uContaBancariaChequeDAO,
  dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit, dxBar, cxBarEditItem, uLoteContabilModel, uLoteContabilDAO,
  cxClasses, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, uContaBancariaDBModel, uContaBancariaDebitoDAO,
  dxRibbonSkins, dxRibbonCustomizationForm, dxRibbon, EMsgDlg, dxStatusBar,
  Vcl.ExtCtrls;

type
  TfmTelaImpressaoLotePagamento = class(TForm)
    dbgrdMain: TDBGrid;
    dsDbGrid: TDataSource;
    qryPreencheDBGrid: TFDQuery;
    qryObterTitulos: TFDQuery;
    frxRelLotePagamento: TfrxReport;
    frxDBLote: TfrxDBDataset;
    frxDBTitulo: TfrxDBDataset;
    dxBarManager1: TdxBarManager;
    dxBtnEditar: TdxBarLargeButton;
    dxBtnSalvar: TdxBarLargeButton;
    dxBtnImprimir: TdxBarLargeButton;
    dxBtnFechar: TdxBarLargeButton;
    dxBtnDeletar: TdxBarLargeButton;
    cxbrdtmPesquisa: TcxBarEditItem;
    dxBtnImprime: TdxBarLargeButton;
    dxBtnImpimir: TdxBarLargeButton;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar4: TdxBar;
    dxBarManager1Bar6: TdxBar;
    dxBtnFechar1: TdxBarLargeButton;
    dxBarImprimir: TdxBarLargeButton;
    cxbrdtmLote: TcxBarEditItem;
    qryLote: TFDQuery;
    PempecMsg: TEvMsgDlg;
    dxStatusBar: TdxStatusBar;
    dxBarManager1Bar1: TdxBar;
    dxBtnCancelaLote: TdxBarLargeButton;
    qryObterPagos: TFDQuery;
    Panel1: TPanel;
    qryPreencheDBGridID_LOTE_PAGAMENTO: TStringField;
    qryPreencheDBGridLOTE: TStringField;
    qryPreencheDBGridID_ORGANIZACAO: TStringField;
    qryPreencheDBGridDATA_PAGAMENTO: TDateField;
    qryPreencheDBGridVALOR: TBCDField;
    qryPreencheDBGridSTATUS: TStringField;
    qryPreencheDBGridQTD: TIntegerField;
    qryPreencheDBGridID_FORMA_PAGAMENTO: TStringField;
    qryPreencheDBGridFP: TStringField;
    qryPreencheDBGridID_CONTA_BANCARIA_CHEQUE: TStringField;
    qryPreencheDBGridCHEQUE: TStringField;
    qryPreencheDBGridID_CONTA_BANCARIA: TStringField;
    qryPreencheDBGridID_CONTA_BANCARIA_1: TStringField;
    qryPreencheDBGridCONTA: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dsDbGridDataChange(Sender: TObject; Field: TField);
    procedure dxBtnFechar1Click(Sender: TObject);
    procedure dxBarImprimirClick(Sender: TObject);
    procedure dbgrdMainTitleClick(Column: TColumn);
    procedure cxbrdtmLoteCurChange(Sender: TObject);
    procedure dxBtnCancelaLoteClick(Sender: TObject);

  private
    { Private declarations }
    pIDlote, pIDorganizacao, pLote :string;
    lotePagamento : TLotePagamentoModel;
    function preencheGrid(pIdLote :string): Boolean;

    function obterTitulosPorLote(pLote :TLotePagamentoModel) : Boolean;
    procedure exibirRelatorio(tipo: Integer);
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    procedure limpaStatusBar;
    procedure limpaPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    function isExportado(var loMostraErros: TFMostraErros): Boolean;
    function obterTitulosPagosPorLote(pLote: TLotePagamentoModel): Boolean;


  public
    { Public declarations }

     constructor Create (AOwner :TComponent; pIdLote :String);

  end;

var
  fmTelaImpressaoLotePagamento: TfmTelaImpressaoLotePagamento;

implementation

{$R *.dfm}

procedure TfmTelaImpressaoLotePagamento.btnSairClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

constructor TfmTelaImpressaoLotePagamento.Create(AOwner: TComponent;  pIdLote :String);
var
lotePagto : TLotePagamentoModel;
begin
 //chega com lote
 inherited Create(AOwner);

 dmConexao.conectarBanco;
 pIDorganizacao := uUtil.TOrgAtual.getId;


  lotePagto := TLotePagamentoModel.Create;
  lotePagto.FIDorganizacao := pIDorganizacao;
  lotePagto.FID := pIdLote;

  lotePagto :=TLotePagamentoDAO.obterPorID(lotePagto);

 if not uUtil.Empty(lotePagto.FID) then begin

   cxbrdtmLote.EditValue := lotePagto.Flote;
   preencheGrid(lotePagto.FID);
   dxBtnFechar.Enabled := False;
 end else begin preencheGrid(''); end;

  limpaPanel;

end;


procedure TfmTelaImpressaoLotePagamento.cxbrdtmLoteCurChange(Sender: TObject);
begin
dbgrdMain.DataSource.DataSet.Locate('LOTE',UpperCase(cxbrdtmLote.CurEditValue),[loPartialKey]);
end;

procedure TfmTelaImpressaoLotePagamento.dbgrdMainTitleClick(Column: TColumn);
begin

(dbgrdMain.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;

end;


procedure TfmTelaImpressaoLotePagamento.dsDbGridDataChange(Sender: TObject;   Field: TField);

begin
  pIDorganizacao   := (dbgrdMain.DataSource.DataSet as TFDQuery).FieldByName('ID_ORGANIZACAO').AsString;
  pIDlote          := (dbgrdMain.DataSource.DataSet as TFDQuery).FieldByName('ID_LOTE_PAGAMENTO').AsString;

 lotePagamento := TLotePagamentoModel.Create;
 lotePagamento.FIDorganizacao := pIDorganizacao;
 lotePagamento.FID := pIDlote;
 lotePagamento := TLotePagamentoDAO.obterPorID(lotePagamento)   ;

  qryLote.Close;
  qryLote.ParamByName('PID').AsString := pIDlote;
  qryLote.ParamByName('PIDORGANIZACAO').AsString := pIDorganizacao;
  qryLote.Open;

  obterTitulosPorLote(lotePagamento);

end;

procedure TfmTelaImpressaoLotePagamento.dxBarImprimirClick(Sender: TObject);
begin

  if not qryLote.IsEmpty then begin

     exibirRelatorio(1);

 end;

end;

procedure TfmTelaImpressaoLotePagamento.dxBtnCancelaLoteClick(Sender: TObject);
var
lotePagto : TLotePagamentoModel;
isCheque, continua, sucesso, exportado : Boolean;
loMostraErros : TFMostraErros;
cheque : TContaBancariaChequeModel;
lancamentoDB : TContaBancariaDBModel;

tituloPagar :TTituloPagarModel;

qtdTitulos :Integer;

begin
  qtdTitulos :=0;
  sucesso := False;
  isCheque := False;
  continua := True;
  exportado := False;
  loMostraErros := TFMostraErros.Create(Self);
  loMostraErros.Caption := 'Cancelamento de Lote Pagamento ';

  lotePagto := TLotePagamentoModel.Create;
  lotePagto.FIDorganizacao := (dbgrdMain.DataSource.DataSet as TFDQuery).FieldByName('ID_ORGANIZACAO').AsString;
  lotePagto.FID := (dbgrdMain.DataSource.DataSet as TFDQuery).FieldByName('ID_LOTE_PAGAMENTO').AsString;
  lotePagto := TLotePagamentoDAO.obterPorID(lotePagto);



  try
    if not uUtil.Empty(lotePagto.FID) then
    begin

      msgStatusBar(3, 'Consultando dados do lote  pagamento ' + lotePagto.Flote );

    //verificar se o lote foi pago em cheque e se o lancamento ja foi exportado
      if not uUtil.Empty(lotePagto.FIDcheque) then
      begin
        cheque := TContaBancariaChequeModel.Create;
        cheque.FIDorganizacao := pIDorganizacao;
        cheque.FID := lotePagto.FIDcheque;
        cheque := TContaBancariaChequeDAO.obterPorID(cheque);

        if cheque.FIDtipoStatus.Equals('COMPENSADO') then
        begin
          continua := False;
           isCheque := True;

          msgStatusBar(3, 'O cheque está compensado. Não podemos cancelar o lote de pagamento.');

          loMostraErros.Clear;
          loMostraErros.Add('Lote pago com cheque ' + #13);

          loMostraErros.Add('Banco            ' + cheque.FcontaBancaria.Fbanco.FCODIGO_BANCO);
          loMostraErros.Add('Conta            ' + cheque.FcontaBancaria.Fconta);
          loMostraErros.Add('Agencia          ' + cheque.FcontaBancaria.Fagencia);
          loMostraErros.Add('Cheque           ' + cheque.FNumero);
          loMostraErros.Add('Emitido em       ' + DateToStr(cheque.FdataEmissao));
          loMostraErros.Add('Compensando  em  ' + DateToStr(cheque.FdataCompensacao));
          loMostraErros.Add('----------------------------------------------------');
          loMostraErros.Add(' DADOS DO LANÇAMENTO ');
          loMostraErros.Add('----------------------------------------------------' + #13);

          lancamentoDB := TContaBancariaDBModel.Create;
          lancamentoDB.FIDorganizacao := pIDorganizacao;
          lancamentoDB.FIDCheque := cheque.FID;
          lancamentoDB.Fcheque := cheque;

          lancamentoDB := TContaBancariaDebitoDAO.obterPorCheque(lancamentoDB);

          if not uutil.Empty(lancamentoDB.FID) then
          begin

            loMostraErros.Add('Identificação do lançamento  ' + lancamentoDB.Fidentificacao);
            loMostraErros.Add('Descrição ' + lancamentoDB.Fdescricao);
            loMostraErros.Add('Observacao  ' + lancamentoDB.Fobservacao);
          end;

          loMostraErros.Add('----------------------------------------------------');

          PempecMsg.MsgError('Não é possível cancelar um lote pago com cheque. É preciso estornar a compensação do cheque. ');

        end else begin  isCheque := False; end;

      end;

 //obter os titulos pagos no lote
      if ( (continua) and (obterTitulosPorLote(lotePagto))) then
      begin
      //verificar se tem algum titulo pago já exportado
        exportado := isExportado(loMostraErros);

        if exportado then
        begin

          PempecMsg.MsgError('Não é possível cancelar um lote que contém títulos exportados. ');
          continua := False;
          msgStatusBar(3, ' Não é possível cancelar o lote  de pagamento ' + lotePagto.Flote );

          if loMostraErros.Count > 0 then
          begin
            loMostraErros.ShowModal;
          end;

        end
        else
        begin
          if not isCheque then begin
          continua := True;
          msgStatusBar(3, 'Todas as verificações foram feitas. O lote de pagamento está pronto para ser cancelado.');
          end;
        end;

        //se chegou aqui .. pode deletar o lote

        if continua then
        begin
            dbgrdMain.DataSource.DataSet.Close;
          qryObterTitulos.First;
          while not qryObterTitulos.Eof do
          begin
            msgStatusBar(3, 'O lote ' + lotePagto.Flote + ' está sendo cancelado. Aguarde. ');


            tituloPagar := TTituloPagarModel.Create;
            tituloPagar.FIDorganizacao := pIDorganizacao;
            tituloPagar.FID := qryObterTitulos.FieldByName('ID_TITULO_PAGAR').AsString;
            tituloPagar := TTituloPagarDAO.obterPorID(tituloPagar);

            if not uUtil.Empty(tituloPagar.FID) then
            begin
              tituloPagar.FIDLoteContabil := '';
              tituloPagar.FIDTipoStatus := 'ABERTO';
              tituloPagar.FIDLotePagamento := '';
              tituloPagar.FIDCBChequeVinculado :=''; //se o TP tiver com cheque vinculado, ele será removido

              if TTPBaixaDAO.cancelarBaixa(tituloPagar) then
              begin

                sucesso := True;
                Inc(qtdTitulos);

              end else begin

                loMostraErros.Clear;
                loMostraErros.Add(' Relação de títulos impossível cancelar a baixa' + #13);

                loMostraErros.Add('DOCUMENTO   ' + tituloPagar.FnumeroDocumento);
                loMostraErros.Add('-------------------------------');

                loMostraErros.Add(' Alguns títulos podem ter sido cancelados. ');
                loMostraErros.Add(' O lote não será cancelado. ');

              end;
            end;


            qryObterTitulos.Next;

          end;

          if loMostraErros.Count > 0 then
          begin
            sucesso := False;
            loMostraErros.ShowModal;
          end;

          if sucesso then
          begin
            if qtdTitulos = qryObterTitulos.RecordCount then
            begin
              if TLotePagamentoDAO.Delete(lotePagto) then
                PempecMsg.MsgInformation('O lote ' + lotePagto.Flote + ' foi deletado com sucesso');
                msgStatusBar(3, 'Ativo');
               // dbgrdMain.DataSource.DataSet.Open;
               limpaPanel;

            end;
          end;

        end;

      end
      else
      begin
        if  ((not isCheque) and (obterTitulosPagosPorLote(lotePagto))) then
        begin
          loMostraErros.Clear;
          loMostraErros.Add(' Existem lançamentos de baixa vinculados ao lote ' + #13);

          qryObterPagos.First;

          if not qryObterPagos.Eof then
          begin

            loMostraErros.Add('DOCUMENTO   ' + qryObterPagos.FieldByName('NUMERO_DOCUMENTO').AsString);
            loMostraErros.Add('-------------------------------');
            loMostraErros.Add(' O lote não será cancelado. Consulte o suporte.  ');

            qryObterPagos.Next;
          end;

        end
        else
        begin
          if not isCheque then
          begin

            if qryObterTitulos.RecordCount = 0 then
              PempecMsg.MsgError('Não foram encontrados títulos vinculados ao lote ' + lotePagto.Flote);

            if PempecMsg.MsgConfirmation('Você deseja tentar apagar o lote pagamento ' + lotePagto.Flote + ' ?') = 6 then
            begin

              if TLotePagamentoDAO.Delete(lotePagto) then
                PempecMsg.MsgInformation('O lote ' + lotePagto.Flote + ' foi deletado com sucesso');
              msgStatusBar(3, 'Ativo');
              limpaPanel;
            end;
          end;
        end;


        if loMostraErros.Count > 0 then
          begin
            sucesso := False;
            loMostraErros.ShowModal;
          end;


      end;

    end else begin PempecMsg.MsgError('Não foi possível localizar o lote de pagamento. ' + lotePagto.Flote); end;

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + ' Problemas ao tentar cancelar o lote : ' + lotePagto.Flote);

  end;

     dxBtnFechar.Enabled := True;
     limpaPanel;

end;

function TfmTelaImpressaoLotePagamento.isExportado (var loMostraErros: TFMostraErros) :Boolean;
var
sucesso : Boolean;
loteContabil : TLoteContabilModel;
dadosLote :string;
begin
 sucesso := False;
 dadosLote := '';
  loMostraErros.Clear;
  loMostraErros.Add('Títulos que já foram exportados. ' + #13);


  if qryObterTitulos.RecordCount > 0 then
  begin
      //verificar se tem algum titulo pago já exportado
    qryObterTitulos.First;

    while not qryObterTitulos.Eof do
    begin

      if not uutil.Empty(qryObterTitulos.FieldByName('ID_LOTE_CONTABIL').AsString) then
      begin

        loteContabil := TLoteContabilModel.Create;
        loteContabil.FIDorganizacao := pIDorganizacao;
        loteContabil.FID := qryObterTitulos.FieldByName('ID_LOTE_CONTABIL').AsString;
        loteContabil := TLoteContabilDAO.obterPorID(loteContabil);

        if not uUtil.Empty(loteContabil.FID) then
        begin

          dadosLote := 'LOTE  ' + loteContabil.Flote + ' DATA ' + DateToStr(loteContabil.FdataRegistro);

        end;


        loMostraErros.Add('Título exportado. DOC NUM  ' + qryObterTitulos.FieldByName('NUMERO_DOCUMENTO').AsString +  ' ' + dadosLote );

         sucesso := True;
      end;

      qryObterTitulos.Next;

    end;

  end;

   if not sucesso then begin   loMostraErros.Clear; end;
   

  Result := sucesso;

end;

procedure TfmTelaImpressaoLotePagamento.dxBtnFechar1Click(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfmTelaImpressaoLotePagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;
end;

procedure TfmTelaImpressaoLotePagamento.FormCreate(Sender: TObject);
begin
 dmConexao.conectarBanco;
 pIDorganizacao := uUtil.TOrgAtual.getId;
 limpaPanel;
end;

function TfmTelaImpressaoLotePagamento.obterTitulosPorLote(pLote :TLotePagamentoModel) : Boolean;
var
cmd :string;

begin

  dmConexao.conectarBanco;

try
   cmd := ' SELECT TP.ID_TITULO_PAGAR,'+
          ' TP.NUMERO_DOCUMENTO, '+
          ' TP.valor_nominal,  '+
          ' TP.DESCRICAO,    '+
          ' TP.id_lote_pagamento,    '+
          ' TP.ID_LOTE_CONTABIL, '+
          ' C.nome,  C.id_cedente    '+
          ' FROM TITULO_PAGAR TP    '+
          ' LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND (C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) '+
          ' WHERE TP.ID_ORGANIZACAO = :PIDORGANIZACAO  AND TP.ID_LOTE_PAGAMENTO = :PIDLOTE ' +
          ' ORDER BY TP.VALOR_NOMINAL ' ;


  qryObterTitulos.Close;
  qryObterTitulos.Connection := dmConexao.conn;
  qryObterTitulos.SQL.Clear;
  qryObterTitulos.SQL.Add(cmd);
  qryObterTitulos.ParamByName('PIDORGANIZACAO').AsString := pLote.FIDorganizacao;
  qryObterTitulos.ParamByName('PIDLOTE').AsString := pLote.FID;
  qryObterTitulos.Open;


  Result := not qryObterTitulos.IsEmpty;

except

raise Exception.Create('Erro ao tentar obter TITULO POR LOTE PAGTO');

end;
end;




function TfmTelaImpressaoLotePagamento.obterTitulosPagosPorLote(pLote :TLotePagamentoModel) : Boolean;
var
cmd :string;
begin
   dmConexao.conectarBanco;

try
   cmd :=' SELECT TP.ID_TITULO_PAGAR, '+
        ' TP.ID_ORGANIZACAO, '+
        ' TP.NUMERO_DOCUMENTO, '+
        ' TP.DESCRICAO,        '+
        ' TP.DATA_VENCIMENTO,  '+
        'TP.VALOR_NOMINAL    '+
' FROM TITULO_PAGAR TP     '+
' LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB  ON (TPB.id_titulo_pagar = TP.ID_TITULO_PAGAR) AND (TPB.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) '+
' WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
 '  AND (TP.ID_LOTE_PAGAMENTO = :PIDLOTE) ';


  qryObterPagos.Close;
  qryObterPagos.Connection := dmConexao.conn;
  qryObterPagos.SQL.Clear;
  qryObterPagos.SQL.Add(cmd);
  qryObterPagos.ParamByName('PIDORGANIZACAO').AsString := pLote.FIDorganizacao;
  qryObterPagos.ParamByName('PIDLOTE').AsString := pLote.FID;
  qryObterPagos.Open;


  Result := not qryObterPagos.IsEmpty;


except

raise Exception.Create('Erro ao tentar obter TITULOS PAGOS POR LOTE PAGTO');

end;
end;


function TfmTelaImpressaoLotePagamento.preencheGrid(pIdLote :string) : Boolean;
var
sqlCmd :string;
begin

dmConexao.conectarBanco;


 qryPreencheDBGrid.Close;
 qryPreencheDBGrid.Connection := dmConexao.conn;
 qryPreencheDBGrid.SQL.Clear;


 if uutil.Empty(pIdLote) then begin

 sqlCmd := ' SELECT LP.id_lote_pagamento, LP.LOTE as LOTE, LP.id_organizacao, LP.DATA_PAGAMENTO, LP.VALOR, LP.status, LP.QTD_TIT_PAG as QTD, '+
      ' FP.id_forma_pagamento, FP.descricao AS FP, '+
      ' CBC.id_conta_bancaria_cheque, CBC.numero_cheque AS CHEQUE, CBC.id_conta_bancaria, '+
      ' CB.id_conta_bancaria, CB.conta '+
      ' FROM lote_pagamento LP '+
      ' LEFT OUTER JOIN forma_pagamento FP ON (FP.id_forma_pagamento = LP.id_forma_pagamento)   AND (FP.ID_ORGANIZACAO = LP.ID_ORGANIZACAO) '+
      ' LEFT OUTER JOIN conta_bancaria_cheque CBC ON (CBC.id_conta_bancaria_cheque = LP.id_conta_bancaria_cheque) AND (CBC.ID_ORGANIZACAO = LP.ID_ORGANIZACAO)'+
      ' LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = LP.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = LP.ID_ORGANIZACAO) '+
      ' WHERE (LP.ID_ORGANIZACAO = :PIDORGANIZACAO)'+
      ' ORDER BY LP.DATA_PAGAMENTO DESC ';

 qryPreencheDBGrid.SQL.Add(sqlCmd);
 qryPreencheDBGrid.ParamByName('PIDORGANIZACAO').AsString :=  pIDorganizacao;


 end else


 begin
   sqlCmd := ' SELECT LP.id_lote_pagamento, LP.LOTE as LOTE, LP.id_organizacao, LP.DATA_PAGAMENTO, LP.VALOR, LP.status, LP.QTD_TIT_PAG as QTD, '+
      ' FP.id_forma_pagamento, FP.descricao AS FP, '+
      ' CBC.id_conta_bancaria_cheque, CBC.numero_cheque AS CHEQUE, CBC.id_conta_bancaria, '+
      ' CB.id_conta_bancaria, CB.conta '+
      ' FROM lote_pagamento LP '+
      ' LEFT OUTER JOIN forma_pagamento FP ON (FP.id_forma_pagamento = LP.id_forma_pagamento)   AND (FP.ID_ORGANIZACAO = LP.ID_ORGANIZACAO) '+
      ' LEFT OUTER JOIN conta_bancaria_cheque CBC ON (CBC.id_conta_bancaria_cheque = LP.id_conta_bancaria_cheque) AND (CBC.ID_ORGANIZACAO = LP.ID_ORGANIZACAO)'+
      ' LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = LP.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = LP.ID_ORGANIZACAO) '+
      ' WHERE (LP.ID_ORGANIZACAO = :PIDORGANIZACAO)'+
      ' AND (LP.ID_LOTE_PAGAMENTO = :PIDLOTE) ';


  qryPreencheDBGrid.SQL.Add(sqlCmd);
  qryPreencheDBGrid.ParamByName('PIDORGANIZACAO').AsString :=  pIDorganizacao;
  qryPreencheDBGrid.ParamByName('PIDLOTE').AsString :=  pIdLote;


 end;

 qryPreencheDBGrid.Open;

 Result := not qryPreencheDBGrid.IsEmpty;

end;

procedure TfmTelaImpressaoLotePagamento.exibirRelatorio(tipo: Integer);
var
 retornarCaminhoRelatorio :string;
begin

retornarCaminhoRelatorio := uUtil.TPathRelatorio.getRelatorioLotePagamento;
frxRelLotePagamento.Clear;
  if not(frxRelLotePagamento.LoadFromFile(retornarCaminhoRelatorio))
  then
  begin
     PempecMsg.MsgInformation('Não é possível imprimir.');

  end
  else
  begin
    inicializarVariaveisRelatorio(now, now);
    frxRelLotePagamento.OldStyleProgress := true;
    frxRelLotePagamento.ShowProgress := true;
    frxRelLotePagamento.ShowReport;

  end;
end;



procedure TfmTelaImpressaoLotePagamento.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate) ;
begin
  with frxRelLotePagamento.Variables do
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
    Variables['strUF'] :=    QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strPeriodo'] :=QuotedStr( ' de  ' + DateToStr(dtInicial) + '  até  ' + DateToStr(dtFinal));
    Variables['strTipoStatus'] := 'TODOS';
    Variables['strExtenso'] :=   QuotedStr('0');
    Variables['strValidate'] :=   QuotedStr('');

  end;
end;


procedure TfmTelaImpressaoLotePagamento.limpaPanel;
begin
  limpaStatusBar;
  preencheGrid('');
end;

procedure TfmTelaImpressaoLotePagamento.limpaStatusBar;
begin
msgStatusBar(0, 'Status ');
msgStatusBar(1, 'Ativo ');

//dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ';
end;

procedure TfmTelaImpressaoLotePagamento.msgStatusBar(pPosicao: Integer; msg: string);
begin

dxStatusBar.Panels[pPosicao].Text := msg;

end;



end.
