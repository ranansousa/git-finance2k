unit uTRBaixaACModel;

interface

{

CREATE TABLE TITULO_RECEBER_BAIXA_AC (
    ID_TITULO_RECEBER_BAIXA_AC  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO              VARCHAR(36) NOT NULL,
    ID_TITULO_RECEBER_BAIXA     VARCHAR(36),
    ID_TIPO_ACRESCIMO           VARCHAR(36),
    VALOR                       NUMERIC(10,2) NOT NULL,
    CONTA_CONTABIL              VARCHAR(20),
    DIGITO_CONTA_CONTABIL       VARCHAR(1)
);



}
uses
  Windows, Messages, Classes, SysUtils, uTipoAcrescimoModel;

type
  TTRBaixaACModel = class(TObject)
  private
    FFID :string ;
    FFIDOrganizacao :string;
    FFIDtipoAcrescimo :string;
    FFIDtituloReceberBaixa: string;
    FFvalor :Currency;
    FFtipoAcrescimo :TTipoAcrescimoModel;
    procedure SetFID(const Value: string);
    procedure SetFIdOrganizacao(const Value: string);
    procedure SetFIDtipoAcrescimo(const Value: string);
    procedure SetFIDtituloReceberBaixa(const Value: string);
    procedure SetFtipoAcrescimo(const Value: TTipoAcrescimoModel);
    procedure SetFvalor(const Value: Currency);

   public

    property FID :string read FFID write SetFID;
    property FIDOrganizacao :string read FFIDOrganizacao write SetFIdOrganizacao;
    property FIDtipoAcrescimo: string read FFIDtipoAcrescimo write SetFIDtipoAcrescimo;
    property FIDtituloReceberBaixa: string read FFIDtituloReceberBaixa write SetFIDtituloReceberBaixa;
    property Fvalor: Currency read FFvalor write SetFvalor;

    property FtipoAcrescimo: TTipoAcrescimoModel read FFtipoAcrescimo write SetFtipoAcrescimo;

    Constructor Create;


  end;
implementation

{ TTRBaixaACModel }

constructor TTRBaixaACModel.Create;
begin

end;

procedure TTRBaixaACModel.SetFID(const Value: string);
begin

end;

procedure TTRBaixaACModel.SetFIdOrganizacao(const Value: string);
begin

end;

procedure TTRBaixaACModel.SetFIDtipoAcrescimo(const Value: string);
begin

end;

procedure TTRBaixaACModel.SetFIDtituloReceberBaixa(const Value: string);
begin

end;

procedure TTRBaixaACModel.SetFtipoAcrescimo(const Value: TTipoAcrescimoModel);
begin

end;

procedure TTRBaixaACModel.SetFvalor(const Value: Currency);
begin

end;

end.
