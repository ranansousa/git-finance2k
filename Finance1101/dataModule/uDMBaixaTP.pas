unit uDMBaixaTP;

interface

uses
  System.SysUtils, System.Classes, uUtil, udmConexao, uDMOrganizacao,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uTituloPagarModel,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdmBaixaTP = class(TDataModule)
    qryPreencheGrid: TFDQuery;
    qryObterIDTPB: TFDQuery;
  private
    { Private declarations }
    pIdOrganizacao, pIdUsuario :string;


  public
    { Public declarations }
    function obterTitulo(titulo: TTituloPagarModel): TTituloPagarModel;
    function preencheGrid(pIdOrganizacao: string): Boolean;
    function obterIDTPB(pIdOrganizacao, pIdtituloPagar: string): string;
    constructor Create(AOwner: TComponent; pIdOrganizacao: string);
  end;

var
  dmBaixaTP: TdmBaixaTP;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmBaixaTP }

constructor TdmBaixaTP.Create(AOwner: TComponent; pIdOrganizacao: string);
begin
  inherited Create(AOwner);
  pIdOrganizacao := pIdOrganizacao;


end;


function TdmBaixaTP.preencheGrid(pIdOrganizacao: string) :Boolean;
var
sqlCmd :string;
begin

dmConexao.conectarBanco;
 try
    qryPreencheGrid.Close;
    qryPreencheGrid.Connection := dmConexao.conn;
   // qryPreencheGrid.SQL.Clear;
    //qryPreencheGrid.SQL.Add(sqlCmd);
    qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryPreencheGrid.Open;

   // (dbgrd1.DataSource.DataSet as TFDQuery).Last;
   // (dbgrd1.DataSource.DataSet as TFDQuery).First;

 except
 raise Exception.Create('Erro ao obter lista de títulos...' );

 end;

 Result := not qryPreencheGrid.IsEmpty;

end;



function TdmBaixaTP.obterIDTPB(pIdOrganizacao, pIdtituloPagar: String): string;
var
idTPB : string;
begin
  idTPB :='';
 Result := '';
 dmConexao.conectarBanco;

  qryObterIDTPB.Close;
  qryObterIDTPB.Connection := dmConexao.Conn;

  qryObterIDTPB.ParamByName('PIDORGANIZACAO').AsString :=  pIdOrganizacao;
  qryObterIDTPB.ParamByName('pIdtituloPagar').AsString :=  pIdtituloPagar;
  qryObterIDTPB.Open;

   if not qryObterIDTPB.IsEmpty then
          idTPB := qryObterIDTPB.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString;


  Result := idTPB;

end;


function TdmBaixaTP.obterTitulo(titulo: TTituloPagarModel): TTituloPagarModel;
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


end.
