unit uTPBaixaChequeModel;
{ //table :
CREATE TABLE TITULO_PAGAR_BAIXA_CHEQUE (
    ID_TITULO_PAGAR_BAIXA_CHEQUE  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO                VARCHAR(36) NOT NULL,
    ID_TITULO_PAGAR_BAIXA         VARCHAR(36),
    VALOR                         NUMERIC(10,2) NOT NULL,
    ID_TIPO_OPERACAO_BANCARIA     VARCHAR(36),
    ID_CONTA_BANCARIA_CHEQUE      VARCHAR(36),
    OBSERVACAO                    VARCHAR(60)

);    }
interface
uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel,uContaBancariaChequeModel;

type
  TTPBaixaChequeModel = class(TObject)
  private
    FFID: string;
    FFIDorganizacao: string;
    FFOrganizacao: TOrganizacaoModel;

    FFIDTPBaixa: string;// n trazer  o objeto. Apenas setar o ID
    FFobservacao :string;
    FFIDTOB: string;
    FFIDCheque :string;
    FFCheque :TContaBancariaChequeModel;
    FFvalor: Currency;

    function getFFOrganizacao : TOrganizacaoModel;
    function getFFIDorganizacao: string;
    function getFFID: string;
    function getFFIDTPBaixa: string;
    function getFFIDTOB: string;
    function getFFCheque: TContaBancariaChequeModel;
    function getFFvalor: Currency;


    procedure SetFForganizacao(const Value: TOrganizacaoModel);
    procedure setFFID(const Value: string);
    procedure setFFIDorganizacao(const Value: string);

    procedure setFFIDTOB(const Value: string);
    procedure setFFIDTPBaixa(const Value: string);
    procedure setFFCheque(const Value: TContaBancariaChequeModel);

    procedure setFFvalor(const Value: Currency);
    function getFFobservacao: string;
    procedure SetFFobservacao(const Value: string);
    function getFFIDCheque: string;
    procedure setFFIDCheque(const Value: string);



  public

    property FID: string read getFFID write SetFFID;
    property FIDorganizacao: string read getFFIDorganizacao write SetFFIDorganizacao;
    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetFForganizacao;
    property Fobservacao: string read getFFobservacao write SetFFobservacao;
    property FIDCheque: string read getFFIDCheque write setFFIDCheque;

    property FIDTOB: string read getFFIDTOB write SetFFIDTOB;
    property FIDTPBaixa: string read getFFIDTPBaixa write setFFIDTPBaixa;
    property FCheque: TContaBancariaChequeModel read getFFCheque write setFFCheque;

    property Fvalor: Currency read getFFvalor write setFFvalor;

    Constructor Create;

  end;


implementation


{ TTPBaixaChequeModel }

constructor TTPBaixaChequeModel.Create;
begin
//ver
end;

function TTPBaixaChequeModel.getFFCheque: TContaBancariaChequeModel;
begin
  Result :=FFCheque;
end;

function TTPBaixaChequeModel.getFFID: string;
begin
  Result :=FFID;
end;

function TTPBaixaChequeModel.getFFIDCheque: string;
begin
Result := FFIDCheque;
end;

function TTPBaixaChequeModel.getFFIDorganizacao: string;
begin
    Result :=FFIDorganizacao;
end;

function TTPBaixaChequeModel.getFFIDTOB: string;
begin
   Result :=FFIDTOB;
end;

function TTPBaixaChequeModel.getFFIDTPBaixa: string;
begin
  Result :=FFIDTPBaixa;
end;

function TTPBaixaChequeModel.getFFobservacao: string;
begin
  Result := FFobservacao;
end;

function TTPBaixaChequeModel.getFFOrganizacao: TOrganizacaoModel;
begin
    Result :=FFOrganizacao;
end;

function TTPBaixaChequeModel.getFFvalor: Currency;
begin
    Result :=FFvalor;
end;

procedure TTPBaixaChequeModel.setFFCheque(const Value: TContaBancariaChequeModel);
begin
  FFCheque := Value;
end;

procedure TTPBaixaChequeModel.setFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTPBaixaChequeModel.setFFIDCheque(const Value: string);
begin
  FFIDCheque := Value;
end;

procedure TTPBaixaChequeModel.setFFIDorganizacao(const Value: string);
begin
    FFIDorganizacao := Value;
end;

procedure TTPBaixaChequeModel.setFFIDTOB(const Value: string);
begin
     FFIDTOB := Value;
end;

procedure TTPBaixaChequeModel.setFFIDTPBaixa(const Value: string);
begin
    FFIDTPBaixa := Value;
end;

procedure TTPBaixaChequeModel.SetFFobservacao(const Value: string);
begin
 FFobservacao := Value;
end;

procedure TTPBaixaChequeModel.SetFForganizacao(const Value: TOrganizacaoModel);
begin
     FFOrganizacao := Value;
end;

procedure TTPBaixaChequeModel.setFFvalor(const Value: Currency);
begin
    FFvalor := Value;
end;

end.
