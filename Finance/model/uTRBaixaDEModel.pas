unit uTRBaixaDEModel;

interface

{
CREATE TABLE TITULO_RECEBER_BAIXA_DE (
    ID_TITULO_RECEBER_BAIXA_DE  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO              VARCHAR(36) NOT NULL,
    ID_TITULO_RECEBER_BAIXA     VARCHAR(36),
    ID_TIPO_DEDUCAO             VARCHAR(36),
    VALOR                       NUMERIC(10,2) NOT NULL,
    CONTA_CONTABIL              VARCHAR(20),
    DIGITO_CONTA_CONTABIL       VARCHAR(1)
);



}
uses
  Windows, Messages, Classes, SysUtils, uTipoDeducaoModel;

type
  TTRBaixaDEModel = class(TObject)
  private
    FFID :string ;
    FFIDOrganizacao :string;
    FFIDtipoDeducao :string;
    FFIDtituloReceberBaixa: string;
    FFvalor :Currency;
    FFtipoDeducao :TTipoDeducaoModel;
    procedure SetFID(const Value: string);
    procedure SetFIdOrganizacao(const Value: string);
    procedure SetFIDtipoDeducao(const Value: string);
    procedure SetFIDtituloReceberBaixa(const Value: string);
    procedure SetFtipoDeducao(const Value: TTipoDeducaoModel);
    procedure SetFvalor(const Value: Currency);

   public

    property FID :string read FFID write SetFID;
    property FIDOrganizacao :string read FFIDOrganizacao write SetFIdOrganizacao;
    property FIDtipoDeducao: string read FFIDtipoDeducao write SetFIDtipoDeducao;
    property FIDtituloReceberBaixa: string read FFIDtituloReceberBaixa write SetFIDtituloReceberBaixa;
    property Fvalor: Currency read FFvalor write SetFvalor;
    property FtipoDeducao: TTipoDeducaoModel read FFtipoDeducao write SetFtipoDeducao;




    Constructor Create;


  end;
implementation

{ TTRBaixaDEModel }

constructor TTRBaixaDEModel.Create;
begin

end;

procedure TTRBaixaDEModel.SetFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTRBaixaDEModel.SetFIdOrganizacao(const Value: string);
begin
  FFIDOrganizacao := Value;
end;

procedure TTRBaixaDEModel.SetFIDtipoDeducao(const Value: string);
begin
  FFIDtipoDeducao := Value;
end;

procedure TTRBaixaDEModel.SetFIDtituloReceberBaixa(const Value: string);
begin
  FFIDtituloReceberBaixa := Value;
end;

procedure TTRBaixaDEModel.SetFtipoDeducao(const Value: TTipoDeducaoModel);
begin
  FFtipoDeducao := Value;
end;

procedure TTRBaixaDEModel.SetFvalor(const Value: Currency);
begin
  FFvalor := Value;
end;

end.
