unit uLoteDepositoModel;

interface
 {


CREATE TABLE LOTE_DEPOSITO (
    ID_LOTE_DEPOSITO   VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO     VARCHAR(36) NOT NULL,
    LOTE               VARCHAR(30) NOT NULL,
    DATA_REGISTRO      DATE NOT NULL,
    DATA_ATUALIZACAO   DATE,
    STATUS             VARCHAR(30) NOT NULL,
    ID_USUARIO         NUMERIC(5,0) NOT NULL,
    QTD_CHQ            NUMERIC(5,0) NOT NULL,
    ID_CONTA_BANCARIA  VARCHAR(36),
    TOTAL_DEPOSITO     NUMERIC(10,2)
);

}

uses
  Windows, Messages, Classes, SysUtils,uContaBancariaModel,uOrganizacaoModel;

type
  TLoteDepositoModel = class(TObject)
  private
    FFID: string;
    FFlote :string;
    FFIDorganizacao :string;
    FFIDusuario :Integer;
    FFStatus :string;
    FFIDcontaBancaria: string;
    FFdataRegistro: TDateTime;
    FFdataAtualizacao: TDateTime;
    FFqtdCheque :Integer;
    FFtotalDeposito :Currency;
    FFOrganizacao :TOrganizacaoModel;
    FFContaBancaria :TContaBancariaModel;
    FFnovo      : Boolean;
    procedure SetFFContaBancaria(const Value: TContaBancariaModel);
    procedure SetFFDataAtualizacao(const Value: TDateTime);
    procedure SetFFDataRegistro(const Value: TDateTime);
    procedure SetFFID(const Value: string);
    procedure SetFFIDcontaBancaria(const Value: string);
    procedure SetFFIDorganizacao(const Value: string);
    procedure SetFFIDusuario(const Value: Integer);
    procedure SetFFlote(const Value: string);
    procedure SetFForganizacao(const Value: TOrganizacaoModel);
    procedure SetFFqtdCheque(const Value: Integer);
    procedure SetFFStatus(const Value: string);
    procedure SetFFtotalDeposito(const Value: Currency);




  public
    property FDataRegistro: TDateTime read FFDataRegistro write SetFFDataRegistro;
    property FDataAtualizacao: TDateTime read FFDataAtualizacao write SetFFDataAtualizacao;
    property FID: string read FFID write SetFFID;
    property Flote: string read FFlote write SetFFlote;
    property FStatus: string read FFStatus write SetFFStatus;
    property FIDcontaBancaria: string read FFIDcontaBancaria write SetFFIDcontaBancaria;
    property FIDusuario: Integer read FFIDusuario write SetFFIDusuario;
    property FqtdCheque: Integer read FFqtdCheque write SetFFqtdCheque;
    property FtotalDeposito: Currency read FFtotalDeposito write SetFFtotalDeposito;
    property FIDorganizacao: string read FFIDorganizacao write SetFFIDorganizacao;
    property Forganizacao: TOrganizacaoModel read FFOrganizacao write SetFForganizacao;
    property FContaBancaria: TContaBancariaModel read FFContaBancaria write SetFFContaBancaria;
    property Fnovo: Boolean read FFnovo write FFnovo; //define se � novo ou j� existe.


      Constructor Create;

  end;


implementation


{ TLoteDepositoModel }

constructor TLoteDepositoModel.Create;
begin
FFnovo := True;
end;

procedure TLoteDepositoModel.SetFFContaBancaria(const Value: TContaBancariaModel);
begin
  FFContaBancaria := Value;
end;

procedure TLoteDepositoModel.SetFFDataAtualizacao(const Value: TDateTime);
begin
  FFDataAtualizacao := Value;
end;

procedure TLoteDepositoModel.SetFFDataRegistro(const Value: TDateTime);
begin
  FFDataRegistro := Value;
end;

procedure TLoteDepositoModel.SetFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TLoteDepositoModel.SetFFIDcontaBancaria(const Value: string);
begin
  FFIDcontaBancaria := Value;
end;

procedure TLoteDepositoModel.SetFFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TLoteDepositoModel.SetFFIDusuario(const Value: Integer);
begin
  FFIDusuario := Value;
end;

procedure TLoteDepositoModel.SetFFlote(const Value: string);
begin
  FFlote := Value;
end;

procedure TLoteDepositoModel.SetFForganizacao(const Value: TOrganizacaoModel);
begin
  FFOrganizacao := Value;
end;

procedure TLoteDepositoModel.SetFFqtdCheque(const Value: Integer);
begin
  FFqtdCheque := Value;
end;

procedure TLoteDepositoModel.SetFFStatus(const Value: string);
begin
  FFStatus := Value;
end;

procedure TLoteDepositoModel.SetFFtotalDeposito(const Value: Currency);
begin
  FFtotalDeposito := Value;
end;

end.
