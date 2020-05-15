unit uTRBaixaChequeModel;

{ //table :

CREATE TABLE TITULO_RECEBER_BAIXA_CHEQUE (
    ID_TITULO_RECEBER_BAIXA_CHEQUE  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO                  VARCHAR(36) NOT NULL,
    ID_TITULO_RECEBER_BAIXA         VARCHAR(36),
    ID_BANCO                        VARCHAR(36),
    ID_LOTE_DEPOSITO                VARCHAR(36),
    ID_TIPO_STATUS                  VARCHAR(36)
    VALOR                           NUMERIC(10,2) NOT NULL,
    NUMERO_CHEQUE                   VARCHAR(10),
    CONTA                           VARCHAR(20),
    AGENCIA                         VARCHAR(10),
    TITULAR                         VARCHAR(60),
    CPFCNPJ                         VARCHAR(20),
    PERSONALIDADE                   VARCHAR(2),
    LOTE_DEPOSITO                   VARCHAR(111),
    DATA_DEPOSITO                   DATE,
    DATA_DEVOLUCAO                  DATE,
    DATA_PROTOCOLO                  DATE,

);

   }
interface
uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel,uBancoModel, uTipoStatusModel;

type
  TTRBaixaChequeModel = class(TObject)
  private

    FFID: string;
    FFIDorganizacao: string;

    FFOrganizacao: TOrganizacaoModel;
    FFbanco :TBancoModel;
    FFstatus :TTipoStatusModel;

    FFIDbanco: string;
    FFIDTRBaixa: string;
    FFobservacao: string;
   // FFIDTOB: string;
    FFIDloteDeposito: string;
    FFIDtipoStatus: string;
    FFvalor: Currency;

    FFnumeroCheque: string;
    FFconta: string;
    FFagencia: string;
    FFtitular: string;
    FFcpfcnpj: string;
    FFpersonalidade: string;
    FFloteDeposito: string;
    FFdataDeposito: TDateTime;
    FFdataDevolucao: TDateTime;
    FFdataProtocolo: TDateTime;


    procedure SetFFagencia(const Value: string);
    procedure SetFFconta(const Value: string);
    procedure SetFFcpfcnpj(const Value: string);
    procedure SetFFdataDeposito(const Value: TDateTime);
    procedure SetFFdataDevolucao(const Value: TDateTime);
    procedure SetFFdataProtocolo(const Value: TDateTime);
    procedure SetFFID(const Value: string);
    procedure SetFFIDbanco(const Value: string);
    procedure SetFFIDloteDeposito(const Value: string);
    procedure SetFFIDorganizacao(const Value: string);
    procedure SetFFIDtipoStatus(const Value: string);
    procedure SetFFIDTRBaixa(const Value: string);
    procedure SetFFloteDeposito(const Value: string);
    procedure SetFFnumeroCheque(const Value: string);
    procedure SetFFobservacao(const Value: string);
    procedure SetFForganizacao(const Value: TOrganizacaoModel);
    procedure SetFFpersonalidade(const Value: string);
    procedure SetFFtitular(const Value: string);
    procedure setFFvalor(const Value: Currency);
    procedure SetFFbanco(const Value: TBancoModel);
    procedure SetFFstatus(const Value: TTipoStatusModel);



  public

    property FID: string read FFID write SetFFID;
    property FIDorganizacao: string read FFIDorganizacao write SetFFIDorganizacao;
    property Fbanco : TBancoModel read FFbanco write SetFFbanco;
    property Fstatus: TTipoStatusModel read FFstatus write SetFFstatus;

  //  property FIDTOB: string read FFIDTOB write SetFFIDTOB;
    property FIDTRBaixa: string read FFIDTRBaixa write SetFFIDTRBaixa;
    property FIDbanco: string read FFIDbanco write SetFFIDbanco;
    property FIDloteDeposito: string read FFIDloteDeposito write SetFFIDloteDeposito;
    property FIDtipoStatus: string read FFIDtipoStatus write SetFFIDtipoStatus;
    property Fobservacao: string read FFobservacao write SetFFobservacao;
    property FnumeroCheque : string read FFnumeroCheque write SetFFnumeroCheque;
    property Fconta: string read FFconta write SetFFconta;
    property Fagencia: string read FFagencia write SetFFagencia;
    property Ftitular: string read FFtitular write SetFFtitular;
    property Fcpfcnpj: string read FFcpfcnpj write SetFFcpfcnpj;
    property Fpersonalidade: string  read FFpersonalidade write SetFFpersonalidade;
    property FloteDeposito: string read FFloteDeposito write SetFFloteDeposito;
    property Fvalor: Currency read FFvalor write setFFvalor;
    property Forganizacao: TOrganizacaoModel read FFOrganizacao write SetFForganizacao;
    property FdataDeposito: TDateTime read FFdataDeposito write SetFFdataDeposito;
    property FdataDevolucao: TDateTime read FFdataDevolucao write SetFFdataDevolucao;
    property FdataProtocolo: TDateTime read FFdataProtocolo write SetFFdataProtocolo;


    Constructor Create;

  end;


implementation

{ TTRBaixaChequeModel }

constructor TTRBaixaChequeModel.Create;
begin

end;

procedure TTRBaixaChequeModel.SetFFagencia(const Value: string);
begin
  FFagencia := Value;
end;

procedure TTRBaixaChequeModel.SetFFbanco(const Value: TBancoModel);
begin
  FFbanco := Value;
end;

procedure TTRBaixaChequeModel.SetFFconta(const Value: string);
begin
  FFconta := Value;
end;

procedure TTRBaixaChequeModel.SetFFcpfcnpj(const Value: string);
begin
  FFcpfcnpj := Value;
end;

procedure TTRBaixaChequeModel.SetFFdataDeposito(const Value: TDateTime);
begin
  FFdataDeposito := Value;
end;

procedure TTRBaixaChequeModel.SetFFdataDevolucao(const Value: TDateTime);
begin
  FFdataDevolucao := Value;
end;

procedure TTRBaixaChequeModel.SetFFdataProtocolo(const Value: TDateTime);
begin
  FFdataProtocolo := Value;
end;

procedure TTRBaixaChequeModel.SetFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTRBaixaChequeModel.SetFFIDbanco(const Value: string);
begin
  FFIDbanco := Value;
end;

procedure TTRBaixaChequeModel.SetFFIDloteDeposito(const Value: string);
begin
  FFIDloteDeposito := Value;
end;

procedure TTRBaixaChequeModel.SetFFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TTRBaixaChequeModel.SetFFIDtipoStatus(const Value: string);
begin
  FFIDtipoStatus := Value;
end;

procedure TTRBaixaChequeModel.SetFFIDTRBaixa(const Value: string);
begin
  FFIDTRBaixa := Value;
end;

procedure TTRBaixaChequeModel.SetFFloteDeposito(const Value: string);
begin
  FFloteDeposito := Value;
end;

procedure TTRBaixaChequeModel.SetFFnumeroCheque(const Value: string);
begin
  FFnumeroCheque := Value;
end;

procedure TTRBaixaChequeModel.SetFFobservacao(const Value: string);
begin
  FFobservacao := Value;
end;

procedure TTRBaixaChequeModel.SetFForganizacao(const Value: TOrganizacaoModel);
begin
  FFOrganizacao := Value;
end;

procedure TTRBaixaChequeModel.SetFFpersonalidade(const Value: string);
begin
  FFpersonalidade := Value;
end;

procedure TTRBaixaChequeModel.SetFFstatus(const Value: TTipoStatusModel);
begin
  FFstatus := Value;
end;

procedure TTRBaixaChequeModel.SetFFtitular(const Value: string);
begin
  FFtitular := Value;
end;

procedure TTRBaixaChequeModel.setFFvalor(const Value: Currency);
begin
  FFvalor := Value;
end;

end.
