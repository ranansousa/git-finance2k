unit uFrameTP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,udmConexao,uUtil,
  System.Variants, System.Classes,  Vcl.Graphics,uTituloPagarModel,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TframeTP = class(TFrame)
    redt1: TRichEdit;
    cbbTP: TComboBox;

  private
    { Private declarations }
    idOrganizacao : string;
    FsListaIdTP : TStringList;
    qryObterTodos: TFDQuery;

  public
    { Public declarations }

 function obterTodos(pIdValue: string; var combo: TComboBox;   var listaID: TStringList): boolean;
 function obterTitulo(titulo :TTituloPagarModel):TTituloPagarModel;
 function obterRateioContabil(titulo :TTituloPagarModel):TFDQuery;
  function obterRateioCustos(titulo :TTituloPagarModel):TFDQuery;

  end;

implementation

{$R *.dfm}

{ TframeTP }

function TframeTP.obterRateioContabil(titulo: TTituloPagarModel): TFDQuery;
var
cmd :string;
qryPesquisa :TFDQuery;
lista :TStringList;

begin
 dmConexao.conectarBanco;

 cmd := ' SELECT TP.ID_TITULO_PAGAR_HISTORICO,' +
        ' TP.ID_ORGANIZACAO,' +
        ' TP.ID_HISTORICO,' +
        ' H.DESCRICAO AS DSC_HIST,'+
        ' TP.ID_TITULO_PAGAR,' +
        ' TP.VALOR' +
        ' FROM TITULO_PAGAR_HISTORICO TP' +
        ' LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO) AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) '+
        ' WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
        '   AND (TP.ID_TITULO_PAGAR = :PID) ' +
        ' ORDER BY TP.VALOR DESC';

 lista :=TStringList.Create;
 lista.Clear;

 try
    qryPesquisa := TFDQuery.Create(Self);
    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add(cmd);
    qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
    qryPesquisa.ParamByName('PID').AsString := titulo.FID;
    qryPesquisa.Open;

     if not qryPesquisa.IsEmpty then begin
         qryPesquisa.First;
         while not qryPesquisa.Eof do begin
          lista.Add(qryPesquisa.FieldByName('ID').AsString);
          qryPesquisa.Next;
         end;

     end;

 except
 raise Exception.Create('Erro obter o rateio contábil.');

 end;

 Result := qryPesquisa;
end;


function TframeTP.obterRateioCustos(titulo: TTituloPagarModel): TFDQuery;
var
cmd :string;
qryPesquisa :TFDQuery;
lista :TStringList;

begin
 dmConexao.conectarBanco;

 cmd := ' SELECT TPRC.ID_TITULO_PAGAR_RATEIO_CC,' +
        ' TPRC.ID_ORGANIZACAO,' +
        ' TPRC.ID_CENTRO_CUSTO,' +
        ' CC.DESCRICAO AS DSC_CC,'+
        ' TPRC.ID_TITULO_PAGAR,' +
        ' TPRC.VALOR' +
        ' FROM TITULO_PAGAR_RATEIO_CC TPRC' +
        ' LEFT OUTER JOIN CENTRO_CUSTO CC ON (C.ID_CENTRO_CUSTO = TPRC.ID_CENTRO_CUSTO) AND (CC.ID_ORGANIZACAO = TPRC.ID_ORGANIZACAO) '+
        ' WHERE (TPRC.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
        '   AND (TPRC.ID_TITULO_PAGAR = :PID) ' +
        ' ORDER BY TPRC.VALOR DESC';

 lista :=TStringList.Create;
 lista.Clear;

 try
    qryPesquisa := TFDQuery.Create(Self);
    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add(cmd);
    qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
    qryPesquisa.ParamByName('PID').AsString := titulo.FID;
    qryPesquisa.Open;

     if not qryPesquisa.IsEmpty then begin
         qryPesquisa.First;
         while not qryPesquisa.Eof do begin
          lista.Add(qryPesquisa.FieldByName('ID').AsString);
          qryPesquisa.Next;
         end;

     end;

 except
 raise Exception.Create('Erro obter o rateio de custos.');

 end;

 Result := qryPesquisa;
end;


function TframeTP.obterTitulo(titulo: TTituloPagarModel): TTituloPagarModel;
var
auxTitulo :TTituloPagarModel;
qryObterPorID :TFDQuery;
 sqlCmd :string;
begin
 dmConexao.conectarBanco;

 try
  qryObterPorID := TFDQuery.Create(Self);

   sqlCmd :=  ' SELECT ' +
               ' TP.ID_TITULO_PAGAR, ' +
               ' TP.ID_ORGANIZACAO, ' +
               ' TP.ID_HISTORICO, ' +
               ' TP.ID_CEDENTE, ' +
               ' TP.ID_TIPO_COBRANCA, ' +
               ' TP.ID_RESPONSAVEL, ' +
               ' TP.ID_LOCAL_PAGAMENTO, ' +
               ' TP.ID_TIPO_STATUS, ' +
               ' TP.ID_CENTRO_CUSTO, ' +
               ' TP.ID_TITULO_GERADOR, ' +
               ' TP.ID_NOTA_FISCAL_ENTRADA, ' +
               ' TP.ID_LOTE_CONTABIL, ' +
               ' TP.ID_USUARIO, ' +
               ' TP.ID_LOTE_PAGAMENTO, ' +
               ' TP.ID_CONTA_CONTABIL_CREDITO, ' +
               ' TP.ID_CONTA_CONTABIL_DEBITO, ' +
               ' TP.ID_CONTA_BANCARIA_CHEQUE, ' +
               ' TP.ID_LOTE_TPB, ' +
               ' TP.NUMERO_DOCUMENTO, ' +
               ' TP.DESCRICAO, ' +
               ' TP.DATA_REGISTRO, ' +
               ' TP.DATA_EMISSAO, ' +
               ' TP.DATA_PROTOCOLO, ' +
               ' TP.DATA_VENCIMENTO, ' +
               ' TP.DATA_PAGAMENTO, ' +
               ' TP.DATA_ULTIMA_ATUALIZACAO, ' +
               ' TP.PREVISAO_CARTORIO, ' +
               ' TP.VALOR_NOMINAL, ' +
               ' TP.MOEDA, ' +
               ' TP.CARTEIRA, ' +
               ' TP.CODIGO_BARRAS, ' +
               ' TP.CONTRATO, ' +
               ' TP.PARCELA, ' +
               ' TP.OBSERVACAO, ' +
               ' TP.VALOR_ANTECIPADO, ' +
               ' TP.IS_PROVISAO, ' +
               ' TP.REGISTRO_PROVISAO ' +
               ' FROM TITULO_PAGAR TP '+
               ' WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)'+
               ' AND (TP.ID_TITULO_PAGAR = :PID) ';


    qryObterPorID.Close;
    qryObterPorID.Connection := dmConexao.conn;
    qryObterPorID.SQL.Clear;
    qryObterPorID.SQL.Add(sqlCmd);

    qryObterPorID.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
    qryObterPorID.ParamByName('PID').AsString := titulo.FID;
    qryObterPorID.Open;

   if not qryObterPorID.IsEmpty then begin

      auxTitulo := TTituloPagarModel.Create;
      auxTitulo.FID                     := qryObterPorID.FieldByName('ID_TITULO_PAGAR').AsString;
      auxTitulo.FIDorganizacao          := qryObterPorID.FieldByName('ID_ORGANIZACAO').AsString;
      auxTitulo.FIDHistorico            := qryObterPorID.FieldByName('ID_HISTORICO').AsString;
      auxTitulo.FIDCedente              := qryObterPorID.FieldByName('ID_CEDENTE').AsString;
      auxTitulo.FIDTipoCobranca         := qryObterPorID.FieldByName('ID_TIPO_COBRANCA').AsString;
      auxTitulo.FIDResponsavel          := qryObterPorID.FieldByName('ID_RESPONSAVEL').AsString;
      auxTitulo.FIDLocalPagamento       := qryObterPorID.FieldByName('ID_LOCAL_PAGAMENTO').AsString;
      auxTitulo.FIDTipoStatus           := qryObterPorID.FieldByName('ID_TIPO_STATUS').AsString;
      auxTitulo.FIDCentroCusto          := qryObterPorID.FieldByName('ID_CENTRO_CUSTO').AsString;
      auxTitulo.FIDNotaFiscalEntrada    := qryObterPorID.FieldByName('ID_NOTA_FISCAL_ENTRADA').AsString;
      auxTitulo.FIDUsuario              := qryObterPorID.FieldByName('ID_USUARIO').AsString;
      auxTitulo.FIDTituloPagarAnterior  := qryObterPorID.FieldByName('ID_TITULO_GERADOR').AsString;
      auxTitulo.FIDLoteContabil         := qryObterPorID.FieldByName('ID_LOTE_CONTABIL').AsString;
      auxTitulo.FIDLoteTPB              := qryObterPorID.FieldByName('ID_LOTE_TPB').AsString;
      auxTitulo.FIDLotePagamento        := qryObterPorID.FieldByName('ID_LOTE_PAGAMENTO').AsString;
      auxTitulo.FIDContaContabilDebito  := qryObterPorID.FieldByName('ID_CONTA_CONTABIL_DEBITO').AsString;
      auxTitulo.FIDContaContabilCredito := qryObterPorID.FieldByName('ID_CONTA_CONTABIL_CREDITO').AsString;
      auxTitulo.FIDCBChequeVinculado    := qryObterPorID.FieldByName('ID_CONTA_BANCARIA_CHEQUE').AsString;
      auxTitulo.FregistroProvisao       := qryObterPorID.FieldByName('REGISTRO_PROVISAO').AsString;

      auxTitulo.FdataRegistro           := qryObterPorID.FieldByName('DATA_REGISTRO').AsDateTime;
      auxTitulo.FdataVencimento         := qryObterPorID.FieldByName('DATA_VENCIMENTO').AsDateTime;
      auxTitulo.FdataEmissao            := qryObterPorID.FieldByName('DATA_EMISSAO').AsDateTime;
      auxTitulo.FdataProtocolo          := qryObterPorID.FieldByName('DATA_PROTOCOLO').AsDateTime;
      auxTitulo.FdataPagamento          := qryObterPorID.FieldByName('DATA_PAGAMENTO').AsDateTime;
      auxTitulo.FdataUltimaAtualizacao  := qryObterPorID.FieldByName('DATA_ULTIMA_ATUALIZACAO').AsDateTime;
      auxTitulo.FprevisaoCartorio       := qryObterPorID.FieldByName('PREVISAO_CARTORIO').AsDateTime;

      auxTitulo.FnumeroDocumento        := qryObterPorID.FieldByName('NUMERO_DOCUMENTO').AsString;
      auxTitulo.Fdescricao              := qryObterPorID.FieldByName('DESCRICAO').AsString;

      auxTitulo.FvalorNominal           := qryObterPorID.FieldByName('VALOR_NOMINAL').AsCurrency;
      auxTitulo.FvalorAntecipado        := qryObterPorID.FieldByName('VALOR_ANTECIPADO').AsCurrency;

      auxTitulo.Fmoeda                  := qryObterPorID.FieldByName('MOEDA').AsString;
      auxTitulo.Fcarteira               := qryObterPorID.FieldByName('CARTEIRA').AsString;
      auxTitulo.FcodigoBarras           := qryObterPorID.FieldByName('CODIGO_BARRAS').AsString;
      auxTitulo.Fcontrato               := qryObterPorID.FieldByName('CONTRATO').AsString;
      auxTitulo.Fparcela                := qryObterPorID.FieldByName('PARCELA').AsString;
      auxTitulo.Fobservacao             := qryObterPorID.FieldByName('OBSERVACAO').AsString;

   end;

 except
 raise Exception.Create('Erro ao tentar obter o titulo. ');

 end;

 Result := auxTitulo;
end;

function TframeTP.obterTodos(pIdValue: string; var combo: TComboBox;  var listaID: TStringList): boolean;
var
cmdSql :string;
pSigla,pTable, pCampoSelecao, pCampoID :string;
begin
dmConexao.conectarBanco;
idOrganizacao := pIdValue;
pTable :='TITULO_PAGAR';
pSigla := 'TP';
pCampoSelecao :='NUMERO_DOCUMENTO';
pCampoID := 'ID_'+ pTable;

 cmdSql := 'SELECT ' + pCampoSelecao +',' + pCampoID  +
           ' FROM ' + pTable + ' '+ pSigla +
           ' WHERE ( ' + pSigla + '.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
           ' AND   ( ' + pSigla + '.ID_TIPO_STATUS  <> ''EXCLUIDO'' ) ' +
           ' ORDER BY '+ pSigla + '.DATA_EMISSAO DESC' ;


  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< Selecione um título  >>>');
 try
   qryObterTodos := TFDQuery.Create(Self);
   qryObterTodos.Close;
   qryObterTodos.Connection := dmConexao.conn;
   qryObterTodos.SQL.Clear;
   qryObterTodos.SQL.Add(cmdSql);
   qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
   qryObterTodos.Open;
   qryObterTodos.Last;
   qryObterTodos.First;

 except
  raise Exception.Create('Erro ao tentar consultar dados dos títulos.');


 end;

   if not qryObterTodos.IsEmpty then begin
          qryObterTodos.First;

      while not qryObterTodos.Eof do
        begin
          combo.Items.Add(qryObterTodos.FieldByName('NUMERO_DOCUMENTO').AsString);
          listaID.Add(qryObterTodos.FieldByName(pCampoID).AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      combo.ItemIndex := 0;

   end;

end;

end.
