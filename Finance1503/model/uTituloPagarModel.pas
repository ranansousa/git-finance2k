unit uTituloPagarModel;

interface
 {table

 ID_TITULO_PAGAR                VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO                 VARCHAR(36) NOT NULL,
    ID_HISTORICO                   VARCHAR(36),
    ID_CEDENTE                     VARCHAR(36),
    ID_TIPO_COBRANCA               VARCHAR(36),
    ID_RESPONSAVEL                 VARCHAR(36),
    ID_LOCAL_PAGAMENTO             VARCHAR(36),
    ID_TIPO_STATUS                 VARCHAR(36),
    ID_CENTRO_CUSTO                VARCHAR(36),
    ID_TITULO_GERADOR              VARCHAR(36),
    ID_NOTA_FISCAL_ENTRADA         VARCHAR(36),
    ID_LOTE_CONTABIL               VARCHAR(36),
    ID_USUARIO                     NUMERIC(5,0),
    ID_LOTE_PAGAMENTO              VARCHAR(36),
    ID_CONTA_CONTABIL_CREDITO      VARCHAR(36),
    ID_CONTA_CONTABIL_DEBITO       VARCHAR(36),
    ID_CONTA_BANCARIA_CHEQUE       VARCHAR(36),
    ID_LOTE_TPB                    VARCHAR(36) CHARACTER SET ISO8859_1

    NUMERO_DOCUMENTO               VARCHAR(50),
    DESCRICAO                      VARCHAR(80),
    DATA_REGISTRO                  DATE,
    DATA_EMISSAO                   DATE,
    DATA_PROTOCOLO                 DATE,
    DATA_VENCIMENTO                DATE,
    DATA_PAGAMENTO                 DATE,
    PREVISAO_CARTORIO              DATE,
    VALOR_NOMINAL                  NUMERIC(10,2),
    MOEDA                          VARCHAR(5),
    CARTEIRA                       VARCHAR(30),
    CODIGO_BARRAS                  VARCHAR(60),
    CONTRATO                       VARCHAR(20),
    PARCELA                        VARCHAR(20) NOT NULL,
    OBSERVACAO                     VARCHAR(200),
    VALOR_ANTECIPADO               NUMERIC(10,2),
    DATA_ULTIMA_ATUALIZACAO        DATE,
    IS_PROVISAO                    SMALLINT
    REGISTRO_PROVISAO              VARCHAR(36),


);


 }

uses
  Windows, Messages, Classes, SysUtils,uContaContabilModel, uHistoricoModel,uTipoCobrancaModel,System.Generics.Collections,
   uFuncionarioModel, uLocalPagamentoModel,uLotePagamentoModel, uTipoStatusModel, uCentroCustoModel, uNotaFiscalEntradaModel,
   uLoteContabilModel,uUsuarioModel, uContaBancariaChequeModel,uCedenteModel, uOrganizacaoModel, uUtil,
     uTituloPagarHistoricoModel, uTituloPagarHistoricoDAO, uTituloPagarCentroCustoModel,uTituloPagarCentroCustoDAO;

type
  TTituloPagarModel = class(TObject)
  private

    FFID: string;
    FFIDorganizacao: string;
    FFparcela: string;
    FFobservacao: string;
    FFIDLoteTPB : string;
    FFIDHistorico: string;
    FFIDCedente: string;
    FFIDTipoCobranca: string;
    FFIDResponsavel: string;
    FFIDLocalPagamento: string;
    FFIDTipoStatus: string;
    FFIDCentroCusto: string;
    FFIDNotaFiscalEntrada: string;
    FFIDUsuario: string;
    FFIDTituloPagarAnterior: string;
    FFIDLoteContabil: string;
    FFIDLotePagamento: string;
    FFIDContaContabilDebito: string;
    FFIDContaContabilCredito: string;
    FFIDCBChequeVinculado: string; // ID do cheque vinculado ao titulo. nome da fun��o para vincular
    FFnumeroDocumento: string;
    FFregistroProvisao: string;
    FFregistroLoteDeletado: string; //ultimo lote em que o titulo foi vinculado. So registra qdo deleta o lote

    FFdescricao: string;
    FFmoeda: string;
    FFcarteira: string;
    FFcodigoBarras: string;
    FFcontrato: string;


    FFdataRegistro: TDateTime;
    FFdataVencimento: TDateTime;
    FFdataEmissao: TDateTime;
    FFdataProtocolo: TDateTime;
    FFdataUltimaAtualizacao: TDateTime;
    FFprevisaoCartorio: TDateTime;
    FFdataPagamento: TDateTime;

    FFvalorNominal: Currency;
    FFvalorAntecipado: Currency;
    FFisProvisao :Integer;
    FFnovo : Boolean;

    //objetos
     FFOrganizacao        : TOrganizacaoModel;
     FFHistorico          : THistoricoModel;
     FFCedente            : TCedenteModel;
     FFTipoCobranca       : TTipoCobrancaModel;
     FFResponsavel        : TFuncionarioModel;
     FFLocalPagamento     : TLocalPagamentoModel;
     FFLotePagamento      : TLotePagamentoModel;
     FFTipoStatus         : TTipoStatusModel;
     FFCentroCustos       : TCentroCustoModel;
     FFTituloPagar        : TTituloPagarModel; //titulo gerador
     FFNotaFiscalEntrada  : TNotaFiscalEntradaModel;
     FFLoteContabil       : TLoteContabilModel;
     FFUsuario            : TUsuarioModel;
     FFCheque             : TContaBancariaChequeModel;


     //cole�oes
    // exemplo FListaFormasPagto: TObjectList<TTPBaixaFPModel>; //rateio de formas
    FSlistaHistorico    : TObjectList<TTituloPagarHistoricoModel>;
    FSlistaCustos       : TObjectList<TTituloPagarCentroCustoModel>;


    function getFFID: string;
    function getFFIDLoteTPB: string;
    function getFFIDorganizacao: string;
    function getFFIDHistorico: string;
    function getFFIDCedente: string;
    function getFFIDTipoCobranca: string;
    function getFFIDResponsavel: string;
    function getFFIDLocalPagamento: string;
    function getFFIDTipoStatus: string;
    function getFFIDCentroCusto: string;
    function getFFIDNotaFiscalEntrada: string;
    function getFFIDUsuario: string;
    function getFFIDTituloPagarAnterior: string;
    function getFFIDLoteContabil: string;
    function getFFIDLotePagamento: string;
    function getFFIDContaContabilDebito: string;
    function getFFIDContaContabilCredito: string;
    function getFFIDCBChequeVinculado: string;
    function getFFnumeroDocumento: string;
    function getFFregistroProvisao: string;
    function getFFdescricao: string;
    function getFFmoeda: string;
    function getFFcarteira: string;
    function getFFcodigoBarras: string;
    function getFFcontrato: string;
    function getFFparcela: string;
    function getFFobservacao: string;
    function getFFOrganizacao :TOrganizacaoModel;

    function getFFvalorNominal: Currency;
    function getFFvalorAntecipado: Currency;

    function getFFdataRegistro: TDateTime;
    function getFFdataVencimento: TDateTime;
    function getFFdataEmissao: TDateTime;
    function getFFdataProtocolo: TDateTime;
    function getFFdataUltimaAtualizacao: TDateTime;
    function getFFprevisaoCartorio: TDateTime;
    function getFFdataPagamento: TDateTime;


    procedure setFFID(const Value: string);
    procedure setFFIDLoteTPB(const Value: string);
    procedure setFFIDorganizacao(const Value: string);
    procedure setFFIDHistorico(const Value: string);
    procedure setFFIDCedente(const Value: string);
    procedure setFFIDTipoCobranca(const Value: string);
    procedure setFFIDResponsavel(const Value: string);
    procedure setFFIDLocalPagamento(const Value: string);
    procedure setFFIDTipoStatus(const Value: string);
    procedure setFFIDCentroCusto(const Value: string);
    procedure setFFIDNotaFiscalEntrada(const Value: string);
    procedure setFFIDUsuario(const Value: string);
    procedure setFFIDTituloPagarAnterior(const Value: string);
    procedure setFFIDLoteContabil(const Value: string);
    procedure setFFIDLotePagamento(const Value: string);
    procedure setFFIDContaContabilDebito(const Value: string);
    procedure setFFIDContaContabilCredito(const Value: string);
    procedure setFFIDCBChequeVinculado(const Value: string);
    procedure setFFnumeroDocumento(const Value: string);
    procedure setFFregistroProvisao(const Value: string);
    procedure setFFdescricao(const Value: string);
    procedure setFFmoeda(const Value: string);
    procedure setFFcarteira(const Value: string);
    procedure setFFcodigoBarras(const Value: string);
    procedure setFFcontrato(const Value: string);
    procedure setFFparcela(const Value: string);
    procedure setFFobservacao(const Value: string);
    procedure SetFFOrganizacao(const Value : TOrganizacaoModel);

    procedure setFFdataRegistro(const Value: TDateTime);
    procedure setFFdataVencimento(const Value: TDateTime);
    procedure setFFdataEmissao(const Value: TDateTime);
    procedure setFFdataProtocolo(const Value: TDateTime);
    procedure setFFdataUltimaAtualizacao(const Value: TDateTime);
    procedure setFFprevisaoCartorio(const Value: TDateTime);
    procedure setFFdataPagamento(const Value: TDateTime);

    procedure setFFvalorNominal(const Value: Currency);
    procedure setFFvalorAntecipado(const Value: Currency);
    function getFFCedente: TCedenteModel;
    function getFFCentroCustos: TCentroCustoModel;
    function getFFCheque: TContaBancariaChequeModel;
    function getFFHistorico: THistoricoModel;
    function getFFLocalPagamento: TLocalPagamentoModel;
    function getFFLoteContabil: TLoteContabilModel;
    function getFFLotePagamento: TLotePagamentoModel;
    function getFFNotaFiscalEntrada: TNotaFiscalEntradaModel;
    function getFFResponsavel: TFuncionarioModel;
    function getFFTipoCobranca: TTipoCobrancaModel;
    function getFFTipoStatus: TTipoStatusModel;
    function getFFTituloPagar: TTituloPagarModel;
    function getFFUsuario: TUsuarioModel;
    procedure SetFFCedente(const Value: TCedenteModel);
    procedure SetFFCentroCustos(const Value: TCentroCustoModel);
    procedure SetFFCheque(const Value: TContaBancariaChequeModel);
    procedure SetFFHistorico(const Value: THistoricoModel);
    procedure SetFFLocalPagamento(const Value: TLocalPagamentoModel);
    procedure SetFFLoteContabil(const Value: TLoteContabilModel);
    procedure SetFFLotePagamento(const Value: TLotePagamentoModel);
    procedure SetFFNotaFiscalEntrada(const Value: TNotaFiscalEntradaModel);
    procedure SetFFResponsavel(const Value: TFuncionarioModel);
    procedure SetFFTipoCobranca(const Value: TTipoCobrancaModel);
    procedure SetFFTipoStatus(const Value: TTipoStatusModel);
    procedure SetFFTituloPagar(const Value: TTituloPagarModel);
    procedure SetFFUsuario(const Value: TUsuarioModel);
    function getFFisProvisao: Integer;
    procedure SetFFisProvisao(const Value: Integer);
    function getFFregistroLoteDeletado: string;
    procedure SetFFregistroLoteDeletado(const Value: string);


  public


 property FID:string read getFFID  write SetFFID ;
 property FIDLoteTPB:string read getFFIDLoteTPB  write SetFFIDLoteTPB ;
 property FIDorganizacao:string read getFFIDorganizacao  write SetFFIDorganizacao ;
  property Fparcela:string read getFFparcela  write SetFFparcela ;
 property Fobservacao:string read getFFobservacao  write SetFFobservacao ;
 property FIDHistorico:string read getFFIDHistorico  write SetFFIDHistorico ;
 property FIDCedente:string read getFFIDCedente  write SetFFIDCedente ;
 property FIDTipoCobranca:string read getFFIDTipoCobranca  write SetFFIDTipoCobranca ;
 property FIDResponsavel:string read getFFIDResponsavel  write SetFFIDResponsavel ;
 property FIDLocalPagamento:string read getFFIDLocalPagamento  write SetFFIDLocalPagamento ;
 property FIDTipoStatus:string read getFFIDTipoStatus  write SetFFIDTipoStatus ;
 property FIDCentroCusto:string read getFFIDCentroCusto  write SetFFIDCentroCusto ;
 property FIDNotaFiscalEntrada:string read getFFIDNotaFiscalEntrada  write SetFFIDNotaFiscalEntrada ;
 property FIDUsuario:string read getFFIDUsuario  write SetFFIDUsuario ;
 property FIDTituloPagarAnterior:string read getFFIDTituloPagarAnterior  write SetFFIDTituloPagarAnterior ;
 property FIDLoteContabil:string read getFFIDLoteContabil  write SetFFIDLoteContabil ;
 property FIDLotePagamento:string read getFFIDLotePagamento  write SetFFIDLotePagamento ;
 property FIDContaContabilDebito:string read getFFIDContaContabilDebito  write SetFFIDContaContabilDebito ;
 property FIDContaContabilCredito:string read getFFIDContaContabilCredito  write SetFFIDContaContabilCredito ;
 property FIDCBChequeVinculado:string read getFFIDCBChequeVinculado  write SetFFIDCBChequeVinculado ;
 property FnumeroDocumento:string read getFFnumeroDocumento  write SetFFnumeroDocumento ;
 property FregistroProvisao:string read getFFregistroProvisao  write SetFFregistroProvisao ;
 property FregistroLoteDeletado:string read getFFregistroLoteDeletado  write SetFFregistroLoteDeletado ;
 property Fdescricao:string read getFFdescricao  write SetFFdescricao ;
 property Fmoeda:string read getFFmoeda  write SetFFmoeda ;
 property Fcarteira:string read getFFcarteira  write SetFFcarteira ;
 property FcodigoBarras:string read getFFcodigoBarras  write SetFFcodigoBarras ;
 property Fcontrato:string read getFFcontrato  write SetFFcontrato ;
 property FdataRegistro:TDateTime read getFFdataRegistro  write SetFFdataRegistro ;
 property FdataVencimento:TDateTime read getFFdataVencimento  write SetFFdataVencimento ;
 property FdataEmissao:TDateTime read getFFdataEmissao  write SetFFdataEmissao ;
 property FdataProtocolo:TDateTime read getFFdataProtocolo  write SetFFdataProtocolo ;
 property FdataUltimaAtualizacao:TDateTime read getFFdataUltimaAtualizacao  write SetFFdataUltimaAtualizacao ;
 property FprevisaoCartorio:TDateTime read getFFprevisaoCartorio  write SetFFprevisaoCartorio ;
 property FdataPagamento:TDateTime read getFFdataPagamento  write SetFFdataPagamento ;

 property FvalorNominal:currency read getFFvalorNominal  write SetFFvalorNominal ;
 property FvalorAntecipado:currency read getFFvalorAntecipado  write SetFFvalorAntecipado ;
 property FisProvisao:Integer read getFFisProvisao  write SetFFisProvisao ;

  property Fnovo :Boolean                         read FFnovo                write FFnovo      ; //define se � novo ou j� existe.



 //objetos
    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetFForganizacao;

    property FCedente: TCedenteModel read getFFCedente write SetFFCedente;
    property FTipoCobranca: TTipoCobrancaModel read getFFTipoCobranca write SetFFTipoCobranca;
    property FResponsavel: TFuncionarioModel read getFFResponsavel write SetFFResponsavel;
    property FLocalPagamento: TLocalPagamentoModel read getFFLocalPagamento write SetFFLocalPagamento;
    property FLotePagamento: TLotePagamentoModel read getFFLotePagamento write SetFFLotePagamento;
    property FTipoStatus: TTipoStatusModel read getFFTipoStatus write SetFFTipoStatus;
    property FCentroCustos: TCentroCustoModel read getFFCentroCustos write SetFFCentroCustos;
    property FTituloPagar: TTituloPagarModel read getFFTituloPagar write SetFFTituloPagar;
    property FNotaFiscalEntrada: TNotaFiscalEntradaModel read getFFNotaFiscalEntrada write SetFFNotaFiscalEntrada;
    property FLoteContabil: TLoteContabilModel read getFFLoteContabil write SetFFLoteContabil;
    property FUsuario: TUsuarioModel read getFFUsuario write SetFFUsuario;
    property FCheque: TContaBancariaChequeModel read getFFCheque write SetFFCheque;

    property FHistorico: THistoricoModel read getFFHistorico write SetFFHistorico;


    property listaHistorico   : TObjectList<TTituloPagarHistoricoModel> read FSlistaHistorico  write FSlistaHistorico;
    property listaCustos      : TObjectList<TTituloPagarCentroCustoModel> read FSlistaCustos      write FSlistaCustos;

    procedure AdicionarHST(pHistorico: TTituloPagarHistoricoModel);
    procedure AdicionarCC (pCentroCusto: TTituloPagarCentroCustoModel);

    constructor Create;
    destructor Destroy; override;


  end;

implementation




{ TTituloPagarModel }

procedure TTituloPagarModel.AdicionarCC(pCentroCusto: TTituloPagarCentroCustoModel);
// TITULO_PAGAR_RATEIO_CC
 var
 I: Integer;
 begin
  FSlistaCustos.Add(TTituloPagarCentroCustoModel.Create);
  I := FSlistaCustos.Count -1;
  FSlistaCustos[I].FID            := pCentroCusto.FID;
  FSlistaCustos[I].FIDorganizacao := pCentroCusto.FIDorganizacao;
  FSlistaCustos[I].FIDCentroCusto := pCentroCusto.FIDCentroCusto;
  FSlistaCustos[I].FIDTP          := pCentroCusto.FIDTP;
  FSlistaCustos[I].FValor         := pCentroCusto.FValor;
end;

procedure TTituloPagarModel.AdicionarHST( pHistorico: TTituloPagarHistoricoModel);
//TITULO_PAGAR_HISTORICO
var
 I: Integer;
 begin

  FSlistaHistorico.Add(TTituloPagarHistoricoModel.Create);
  I := FSlistaHistorico.Count -1;
  FSlistaHistorico[I].FID                     := pHistorico.FID;
  FSlistaHistorico[I].FIDorganizacao          := pHistorico.FIDorganizacao;
  FSlistaHistorico[I].FIDHistorico            := pHistorico.FIDHistorico;
  FSlistaHistorico[I].FIDTP                   := pHistorico.FIDTP;
  FSlistaHistorico[I].FIDContaContabilDebito  := pHistorico.FIDContaContabilDebito;
  FSlistaHistorico[I].FValor                  := pHistorico.FValor;

end;

constructor TTituloPagarModel.Create;
begin
//ver
FFnovo := True;


     FFOrganizacao        :=  TOrganizacaoModel.Create ;
     FFHistorico          :=  THistoricoModel.Create ;
     FFCedente            :=  TCedenteModel.Create ;
     FFTipoCobranca       :=  TTipoCobrancaModel.Create ;
     FFResponsavel        :=  TFuncionarioModel.Create ;
     FFLocalPagamento     :=  TLocalPagamentoModel.Create ;
     FFLotePagamento      :=  TLotePagamentoModel.Create ;
     FFTipoStatus         :=  TTipoStatusModel.Create ;
     FFCentroCustos       :=  TCentroCustoModel.Create ;
     FFNotaFiscalEntrada  :=  TNotaFiscalEntradaModel.Create ;
     FFLoteContabil       :=  TLoteContabilModel.Create ;
     FFUsuario            :=  TUsuarioModel.Create ;
     FFCheque             :=  TContaBancariaChequeModel.Create ;

end;

destructor TTituloPagarModel.Destroy;
begin
  inherited;
end;

function TTituloPagarModel.getFFcarteira: string;
begin
 Result := FFcarteira;
end;

function TTituloPagarModel.getFFCedente: TCedenteModel;
begin
  Result := FFCedente;
end;

function TTituloPagarModel.getFFCentroCustos: TCentroCustoModel;
begin

Result := FFCentroCustos;

end;

function TTituloPagarModel.getFFCheque: TContaBancariaChequeModel;
begin
Result := FFCheque;
end;

function TTituloPagarModel.getFFcodigoBarras: string;
begin
 Result := FFcodigoBarras;

end;

function TTituloPagarModel.getFFcontrato: string;
begin
 Result := FFcontrato;

end;

function TTituloPagarModel.getFFdataEmissao: TDateTime;
begin
 Result := FFdataEmissao;
end;

function TTituloPagarModel.getFFdataPagamento: TDateTime;
begin
 Result := FFdataPagamento;

end;

function TTituloPagarModel.getFFdataProtocolo: TDateTime;
begin

 Result := FFdataProtocolo;

end;

function TTituloPagarModel.getFFdataRegistro: TDateTime;
begin

 Result := FFdataRegistro;

end;

function TTituloPagarModel.getFFdataUltimaAtualizacao: TDateTime;
begin
 Result := FFdataUltimaAtualizacao;
end;

function TTituloPagarModel.getFFdataVencimento: TDateTime;
begin

 Result := FFdataVencimento;

end;

function TTituloPagarModel.getFFdescricao: string;
begin

 Result := FFdescricao;

end;

function TTituloPagarModel.getFFHistorico: THistoricoModel;
begin
  Result := FFHistorico;
end;

function TTituloPagarModel.getFFID: string;
begin
 Result := FFID;
end;

function TTituloPagarModel.getFFIDCBChequeVinculado: string;
begin
 Result := FFIDCBChequeVinculado;

end;

function TTituloPagarModel.getFFIDCedente: string;
begin
 Result := FFIDCedente;

end;

function TTituloPagarModel.getFFIDCentroCusto: string;
begin
 Result := FFIDCentroCusto;

end;

function TTituloPagarModel.getFFIDContaContabilCredito: string;
begin
 Result := FFIDContaContabilCredito;

end;

function TTituloPagarModel.getFFIDContaContabilDebito: string;
begin

 Result := FFIDContaContabilDebito;

end;

function TTituloPagarModel.getFFIDHistorico: string;
begin
 Result := FFIDHistorico;

end;

function TTituloPagarModel.getFFIDLocalPagamento: string;
begin
 Result := FFIDLocalPagamento;

end;

function TTituloPagarModel.getFFIDLoteContabil: string;
begin
 Result := FFIDLoteContabil;

end;

function TTituloPagarModel.getFFIDLotePagamento: string;
begin
 Result := FFIDLotePagamento;

end;

function TTituloPagarModel.getFFIDLoteTPB: string;
begin
Result := FFIDLoteTPB;
end;

function TTituloPagarModel.getFFIDNotaFiscalEntrada: string;
begin
 Result := FFIDNotaFiscalEntrada;

end;

function TTituloPagarModel.getFFIDorganizacao: string;
begin
 Result := FFIDorganizacao;

end;

function TTituloPagarModel.getFFIDResponsavel: string;
begin

 Result := FFIDResponsavel;

end;

function TTituloPagarModel.getFFIDTipoCobranca: string;
begin

 Result := FFIDTipoCobranca;

end;

function TTituloPagarModel.getFFIDTipoStatus: string;
begin
 Result := FFIDTipoStatus;

end;

function TTituloPagarModel.getFFIDTituloPagarAnterior: string;
begin

 Result := FFIDTituloPagarAnterior;

end;

function TTituloPagarModel.getFFIDUsuario: string;
begin

 Result := FFIDUsuario;

end;

function TTituloPagarModel.getFFisProvisao: Integer;
begin
 Result := FFisProvisao;
end;

function TTituloPagarModel.getFFLocalPagamento: TLocalPagamentoModel;
begin
  Result := FFLocalPagamento;
end;

function TTituloPagarModel.getFFLoteContabil: TLoteContabilModel;
begin
Result := FFLoteContabil;

end;

function TTituloPagarModel.getFFLotePagamento: TLotePagamentoModel;
begin
   Result := FFLotePagamento;
end;

function TTituloPagarModel.getFFmoeda: string;
begin
 Result := FFmoeda;

end;

function TTituloPagarModel.getFFNotaFiscalEntrada: TNotaFiscalEntradaModel;
begin
   Result := FFNotaFiscalEntrada;
end;

function TTituloPagarModel.getFFnumeroDocumento: string;
begin
 Result := FFnumeroDocumento;

end;

function TTituloPagarModel.getFFobservacao: string;
begin
  Result := FFobservacao;

end;

function TTituloPagarModel.getFFOrganizacao: TOrganizacaoModel;
begin

 Result := FFOrganizacao;

end;

function TTituloPagarModel.getFFparcela: string;
begin
 Result := FFparcela;

end;

function TTituloPagarModel.getFFprevisaoCartorio: TDateTime;
begin
 Result := FFprevisaoCartorio;

end;

function TTituloPagarModel.getFFregistroLoteDeletado: string;
begin
Result := FFregistroLoteDeletado;
end;

function TTituloPagarModel.getFFregistroProvisao: string;
begin
 Result := FFregistroProvisao;

end;

function TTituloPagarModel.getFFResponsavel: TFuncionarioModel;
begin
 Result := FFResponsavel;
end;

function TTituloPagarModel.getFFTipoCobranca: TTipoCobrancaModel;
begin
  Result := FFTipoCobranca;
end;

function TTituloPagarModel.getFFTipoStatus: TTipoStatusModel;
begin
   Result := FFTipoStatus;
end;

function TTituloPagarModel.getFFTituloPagar: TTituloPagarModel;
begin
  Result := FFTituloPagar;
end;

function TTituloPagarModel.getFFUsuario: TUsuarioModel;
begin
  Result := FFUsuario;
end;

function TTituloPagarModel.getFFvalorAntecipado: Currency;
begin
 Result := FFvalorAntecipado;

end;

function TTituloPagarModel.getFFvalorNominal: Currency;
begin
 Result := FFvalorNominal;

end;

procedure TTituloPagarModel.setFFcarteira(const Value: string);
begin
  FFcarteira :=Value;
end;

procedure TTituloPagarModel.SetFFCedente(const Value: TCedenteModel);
begin
 FFCedente := Value;
end;

procedure TTituloPagarModel.SetFFCentroCustos(const Value: TCentroCustoModel);
begin
  FFCentroCustos := Value;
end;

procedure TTituloPagarModel.SetFFCheque(const Value: TContaBancariaChequeModel);
begin
    FFCheque := Value;
end;

procedure TTituloPagarModel.setFFcodigoBarras(const Value: string);
begin
    FFcodigoBarras :=Value;
end;

procedure TTituloPagarModel.setFFcontrato(const Value: string);
begin
    FFcontrato :=Value;
end;

procedure TTituloPagarModel.setFFdataEmissao(const Value: TDateTime);
begin
     FFdataEmissao :=Value;
end;

procedure TTituloPagarModel.setFFdataPagamento(const Value: TDateTime);
begin
   FFdataPagamento :=Value;
end;

procedure TTituloPagarModel.setFFdataProtocolo(const Value: TDateTime);
begin
    FFdataProtocolo :=Value;
end;

procedure TTituloPagarModel.setFFdataRegistro(const Value: TDateTime);
begin
    FFdataRegistro :=Value;
end;

procedure TTituloPagarModel.setFFdataUltimaAtualizacao(const Value: TDateTime);
begin
    FFdataUltimaAtualizacao :=Value;
end;

procedure TTituloPagarModel.setFFdataVencimento(const Value: TDateTime);
begin
   FFdataVencimento :=Value;
end;

procedure TTituloPagarModel.setFFdescricao(const Value: string);
begin
    FFdescricao :=Value;
end;

procedure TTituloPagarModel.SetFFHistorico(const Value: THistoricoModel);
begin
 FFHistorico := Value;
end;

procedure TTituloPagarModel.setFFID(const Value: string);
begin
    FFID :=Value;
end;

procedure TTituloPagarModel.setFFIDCBChequeVinculado(const Value: string);
begin
     FFIDCBChequeVinculado :=Value;
end;

procedure TTituloPagarModel.setFFIDCedente(const Value: string);
begin
    FFIDCedente :=Value;
end;

procedure TTituloPagarModel.setFFIDCentroCusto(const Value: string);
begin
     FFIDCentroCusto :=Value;
end;

procedure TTituloPagarModel.setFFIDContaContabilCredito(const Value: string);
begin
     FFIDContaContabilCredito :=Value;
end;

procedure TTituloPagarModel.setFFIDContaContabilDebito(const Value: string);
begin
      FFIDContaContabilDebito :=Value;
end;

procedure TTituloPagarModel.setFFIDHistorico(const Value: string);
begin
   FFIDHistorico :=Value;
end;

procedure TTituloPagarModel.setFFIDLocalPagamento(const Value: string);
begin
    FFIDLocalPagamento :=Value;
end;

procedure TTituloPagarModel.setFFIDLoteContabil(const Value: string);
begin
     FFIDLoteContabil :=Value;
end;

procedure TTituloPagarModel.setFFIDLotePagamento(const Value: string);
begin
     FFIDLotePagamento :=Value;
end;

procedure TTituloPagarModel.setFFIDLoteTPB(const Value: string);
begin
FFIDLoteTPB := Value;
end;

procedure TTituloPagarModel.setFFIDNotaFiscalEntrada(const Value: string);
begin
   FFIDNotaFiscalEntrada :=Value;
end;

procedure TTituloPagarModel.setFFIDorganizacao(const Value: string);
begin
    FFIDorganizacao :=Value;
end;

procedure TTituloPagarModel.setFFIDResponsavel(const Value: string);
begin
     FFIDResponsavel :=Value;
end;

procedure TTituloPagarModel.setFFIDTipoCobranca(const Value: string);
begin
     FFIDTipoCobranca :=Value;
end;

procedure TTituloPagarModel.setFFIDTipoStatus(const Value: string);
begin
    FFIDTipoStatus :=Value;
end;

procedure TTituloPagarModel.setFFIDTituloPagarAnterior(const Value: string);
begin
   FFIDTituloPagarAnterior :=Value;
end;

procedure TTituloPagarModel.setFFIDUsuario(const Value: string);
begin
    FFIDUsuario :=Value;
end;

procedure TTituloPagarModel.SetFFisProvisao(const Value: Integer);
begin
 FFisProvisao := Value;
end;

procedure TTituloPagarModel.SetFFLocalPagamento( const Value: TLocalPagamentoModel);
begin
    FFLocalPagamento := Value;
end;

procedure TTituloPagarModel.SetFFLoteContabil(const Value: TLoteContabilModel);
begin
  FFLoteContabil := Value;
end;

procedure TTituloPagarModel.SetFFLotePagamento(  const Value: TLotePagamentoModel);
begin
   FFLotePagamento := Value;
end;

procedure TTituloPagarModel.setFFmoeda(const Value: string);
begin
  FFmoeda :=Value;
 if uutil.Empty(FFmoeda) then begin
    FFmoeda := 'Real';
 end;

end;

procedure TTituloPagarModel.SetFFNotaFiscalEntrada( const Value: TNotaFiscalEntradaModel);
begin
   FFNotaFiscalEntrada := Value;
end;

procedure TTituloPagarModel.setFFnumeroDocumento(const Value: string);
begin
  FFnumeroDocumento :=Value;

end;

procedure TTituloPagarModel.setFFobservacao(const Value: string);
begin

FFobservacao := Value;

end;

procedure TTituloPagarModel.SetFFOrganizacao(const Value: TOrganizacaoModel);
begin

   FFOrganizacao :=Value;
end;

procedure TTituloPagarModel.setFFparcela(const Value: string);
begin
 FFparcela :=Value;

 if uutil.Empty(FFparcela) then begin
   FFparcela := '1';
 end;

end;

procedure TTituloPagarModel.setFFprevisaoCartorio(const Value: TDateTime);
begin
  FFprevisaoCartorio :=Value;
end;

procedure TTituloPagarModel.SetFFregistroLoteDeletado(const Value: string);
begin
   FFregistroLoteDeletado := Value;
end;

procedure TTituloPagarModel.setFFregistroProvisao(const Value: string);
begin
 FFregistroProvisao :=Value;

end;

procedure TTituloPagarModel.SetFFResponsavel(const Value: TFuncionarioModel);
begin
  FFResponsavel := Value;
end;

procedure TTituloPagarModel.SetFFTipoCobranca(const Value: TTipoCobrancaModel);
begin
   FFTipoCobranca := Value;
end;

procedure TTituloPagarModel.SetFFTipoStatus(const Value: TTipoStatusModel);
begin
   FFTipoStatus := Value;
end;

procedure TTituloPagarModel.SetFFTituloPagar(const Value: TTituloPagarModel);
begin
  FFTituloPagar := Value;
end;

procedure TTituloPagarModel.SetFFUsuario(const Value: TUsuarioModel);
begin
 FFUsuario :=  Value ;
end;

procedure TTituloPagarModel.setFFvalorAntecipado(const Value: Currency);
begin
  FFvalorAntecipado :=Value;
end;

procedure TTituloPagarModel.setFFvalorNominal(const Value: Currency);
begin
  FFvalorNominal :=Value;
end;

end.
