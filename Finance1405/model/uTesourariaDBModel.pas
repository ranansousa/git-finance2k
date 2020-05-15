unit uTesourariaDBModel;

interface
{
CREATE TABLE TESOURARIA_DEBITO (
    ID_TESOURARIA_DEBITO           VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO                 VARCHAR(36) NOT NULL,
    ID_HISTORICO                   VARCHAR(36),
    ID_RESPONSAVEL                 VARCHAR(36),
    ID_CEDENTE                     VARCHAR(36),
    ID_TITULO_PAGAR_BAIXA          VARCHAR(36),
    ID_USUARIO                     NUMERIC(5,0),
    ID_LOTE_CONTABIL               VARCHAR(36),
    ID_LOTE_DEPOSITO               VARCHAR(36),
    ID_CONTA_BANCARIA_CREDITO      VARCHAR(36),
    OBSERVACAO                     VARCHAR(200),
    NUMERO_DOCUMENTO               VARCHAR(40),
    DESCRICAO                      VARCHAR(120),
    TIPO_LANCAMENTO                VARCHAR(1) NOT NULL
    VALOR_NOMINAL                  NUMERIC(10,2) NOT NULL,
    DATA_REGISTRO                  DATE,
    DATA_CONTABIL                  DATE,
    DATA_MOVIMENTO                 DATE NOT NULL,
);

}



uses
  Windows, Messages, Classes, SysUtils,uContaBancariaCRModel, uHistoricoModel,System.Generics.Collections,
   uFuncionarioModel, uLocalPagamentoModel,uLotePagamentoModel, uTipoStatusModel,
   uLoteContabilModel,uUsuarioModel,uTPBaixaModel, uCedenteModel, uOrganizacaoModel;

type
  TTesourariaDBModel = class(TObject)
  private

    FFID: string;
    FFIDorganizacao: string;
    FFIDHistorico: string;
    FFIDResponsavel: string;
    FFIDCedente: string;
    FFIDTPB: string; //ID_TITULO_PAGAR_BAIXA
    FFIDUsuario: Integer;
    FFIDloteContabil: string;
    FFIDloteDeposito: string;
    FFIDContaBancariaCredito: string;
    FFnumeroDocumento: string;
    FFdescricao: string;
    FFobservacao: string;
    FFtipoLancamento: string;
    FFvalorNominal: Currency;
    FFdataRegistro: TDateTime;
    FFdataContabil: TDateTime;
    FFdataMovimento: TDateTime;

    FFnovo      : Boolean;
    //objetos
     FFOrganizacao        : TOrganizacaoModel;
     FFHistorico          : THistoricoModel;
     FFCedente            : TCedenteModel;
     FFResponsavel        : TFuncionarioModel;
     FFTipoStatus         : TTipoStatusModel;
     FFTituloPagarBaixa   : TTPBaixaModel;
     FFLoteContabil       : TLoteContabilModel;
     FFUsuario            : TUsuarioModel;
     FFContaBancariaCredito : TContaBancariaCRModel;


    procedure SetFFCedente(const Value: TCedenteModel);
    procedure SetFFContaBancariaCredito(const Value: TContaBancariaCRModel);
    procedure SetFFdataContabil(const Value: TDateTime);
    procedure SetFFdataMovimento(const Value: TDateTime);
    procedure SetFFdataRegistro(const Value: TDateTime);
    procedure SetFFdescricao(const Value: string);
    procedure SetFFHistorico(const Value: THistoricoModel);
    procedure SetFFID(const Value: string);
    procedure SetFFIDCedente(const Value: string);
    procedure SetFFIDHistorico(const Value: string);
    procedure SetFFIDLoteContabil(const Value: string);
    procedure SetFFIDloteDeposito(const Value: string);
    procedure SetFFIDorganizacao(const Value: string);
    procedure SetFFIDResponsavel(const Value: string);
    procedure SetFFIDTPB(const Value: string);
    procedure SetFFLoteContabil(const Value: TLoteContabilModel);
    procedure SetFFnumeroDocumento(const Value: string);
    procedure SetFFobservacao(const Value: string);
    procedure SetFForganizacao(const Value: TOrganizacaoModel);
    procedure SetFFResponsavel(const Value: TFuncionarioModel);
    procedure SetFFtipoLancamento(const Value: string);
    procedure SetFFTipoStatus(const Value: TTipoStatusModel);
    procedure SetFFTituloPagarBaixa(const Value: TTPBaixaModel);
    procedure SetFFUsuario(const Value: TUsuarioModel);
    procedure SetFFvalorNominal(const Value: currency);
    procedure SetFIDContaBancariaCredito(const Value: string);
    procedure SetFFIDUsuario(const Value: Integer);


         //cole�oes
    // exemplo FListaFormasPagto: TObjectList<TTPBaixaFPModel>; //rateio de formas

  public

    property FID: string read FFID write SetFFID;
    property FIDorganizacao: string read FFIDorganizacao write SetFFIDorganizacao;
    property FIDHistorico: string read FFIDHistorico write SetFFIDHistorico;
    property FIDResponsavel: string read FFIDResponsavel write SetFFIDResponsavel;
    property FIDUsuario: Integer read FFIDUsuario write SetFFIDUsuario;
    property FIDCedente: string read FFIDCedente write SetFFIDCedente;
    property FIDTPB: string read FFIDTPB write SetFFIDTPB;
    property FIDLoteContabil: string read FFIDLoteContabil write SetFFIDLoteContabil;
    property FIDcontaBancariaCredito: string read FFIDContaBancariaCredito write SetFIDContaBancariaCredito;
    property FnumeroDocumento: string read FFnumeroDocumento write SetFFnumeroDocumento;
    property Fdescricao: string read FFdescricao write SetFFdescricao;
    property FIDloteDeposito: string read FFIDloteDeposito write SetFFIDloteDeposito;
    property FtipoLancamento: string read FFtipoLancamento write SetFFtipoLancamento;
    property Fobservacao: string read FFobservacao write SetFFobservacao;
    property FdataRegistro: TDateTime read FFdataRegistro write SetFFdataRegistro;
    property FdataContabil: TDateTime read FFdataContabil write SetFFdataContabil;
    property FdataMovimento: TDateTime read FFdataMovimento write SetFFdataMovimento;
    property FvalorNominal: currency read FFvalorNominal write SetFFvalorNominal;

 //objetos
    property Forganizacao: TOrganizacaoModel read FFOrganizacao write SetFForganizacao;
    property FHistorico: THistoricoModel read FFHistorico write SetFFHistorico;
    property FCedente: TCedenteModel read FFCedente write SetFFCedente;
    property FResponsavel: TFuncionarioModel read FFResponsavel write SetFFResponsavel;
    property FTipoStatus: TTipoStatusModel read FFTipoStatus write SetFFTipoStatus;
    property FLoteContabil: TLoteContabilModel read FFLoteContabil write SetFFLoteContabil;
    property FUsuario: TUsuarioModel read FFUsuario write SetFFUsuario;
    property FTituloPagarBaixa: TTPBaixaModel read FFTituloPagarBaixa write SetFFTituloPagarBaixa;
    property FContaBancariaCredito : TContaBancariaCRModel read FFContaBancariaCredito write SetFFContaBancariaCredito;
     property Fnovo :Boolean        read FFnovo       write FFnovo;

    constructor Create;
    destructor Destroy; override;


  end;

implementation

{ TTesourariaDBModel }

constructor TTesourariaDBModel.Create;
begin
FFnovo := True;
end;

destructor TTesourariaDBModel.Destroy;
begin
  inherited;
end;

procedure TTesourariaDBModel.SetFFCedente(const Value: TCedenteModel);
begin
  FFCedente := Value;
end;

procedure TTesourariaDBModel.SetFFContaBancariaCredito(
  const Value: TContaBancariaCRModel);
begin
  FFContaBancariaCredito := Value;
end;

procedure TTesourariaDBModel.SetFFdataContabil(const Value: TDateTime);
begin
  FFdataContabil := Value;
end;

procedure TTesourariaDBModel.SetFFdataMovimento(const Value: TDateTime);
begin
  FFdataMovimento := Value;
end;

procedure TTesourariaDBModel.SetFFdataRegistro(const Value: TDateTime);
begin
  FFdataRegistro := Value;
end;

procedure TTesourariaDBModel.SetFFdescricao(const Value: string);
begin
  FFdescricao := Value;
end;

procedure TTesourariaDBModel.SetFFHistorico(const Value: THistoricoModel);
begin
  FFHistorico := Value;
end;

procedure TTesourariaDBModel.SetFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTesourariaDBModel.SetFFIDCedente(const Value: string);
begin
  FFIDCedente := Value;
end;

procedure TTesourariaDBModel.SetFFIDHistorico(const Value: string);
begin
  FFIDHistorico := Value;
end;

procedure TTesourariaDBModel.SetFFIDLoteContabil(const Value: string);
begin
  FFIDLoteContabil := Value;
end;

procedure TTesourariaDBModel.SetFFIDloteDeposito(const Value: string);
begin
  FFIDloteDeposito := Value;
end;

procedure TTesourariaDBModel.SetFFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TTesourariaDBModel.SetFFIDResponsavel(const Value: string);
begin
  FFIDResponsavel := Value;
end;

procedure TTesourariaDBModel.SetFFIDTPB(const Value: string);
begin
  FFIDTPB := Value;
end;


procedure TTesourariaDBModel.SetFFIDUsuario(const Value: Integer);
begin
  FFIDUsuario := Value;
end;

procedure TTesourariaDBModel.SetFFLoteContabil(const Value: TLoteContabilModel);
begin
  FFLoteContabil := Value;
end;

procedure TTesourariaDBModel.SetFFnumeroDocumento(const Value: string);
begin
  FFnumeroDocumento := Value;
end;

procedure TTesourariaDBModel.SetFFobservacao(const Value: string);
begin
  FFobservacao := Value;
end;

procedure TTesourariaDBModel.SetFForganizacao(const Value: TOrganizacaoModel);
begin
  FFOrganizacao := Value;
end;

procedure TTesourariaDBModel.SetFFResponsavel(const Value: TFuncionarioModel);
begin
  FFResponsavel := Value;
end;

procedure TTesourariaDBModel.SetFFtipoLancamento(const Value: string);
begin
  FFtipoLancamento := Value;
end;

procedure TTesourariaDBModel.SetFFTipoStatus(const Value: TTipoStatusModel);
begin
  FFTipoStatus := Value;
end;

procedure TTesourariaDBModel.SetFFTituloPagarBaixa(const Value: TTPBaixaModel);
begin
  FFTituloPagarBaixa := Value;
end;

procedure TTesourariaDBModel.SetFFUsuario(const Value: TUsuarioModel);
begin
  FFUsuario := Value;
end;

procedure TTesourariaDBModel.SetFFvalorNominal(const Value: currency);
begin
  FFvalorNominal := Value;
end;

procedure TTesourariaDBModel.SetFIDContaBancariaCredito(const Value: string);
begin
  FFIDContaBancariaCredito := Value;
end;

end.
