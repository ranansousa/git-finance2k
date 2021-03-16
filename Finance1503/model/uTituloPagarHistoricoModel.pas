unit uTituloPagarHistoricoModel;

interface
{


CREATE TABLE TITULO_PAGAR_HISTORICO (
    ID_TITULO_PAGAR_HISTORICO  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO             VARCHAR(36) NOT NULL,
    ID_HISTORICO               VARCHAR(36) NOT NULL,
    ID_TITULO_PAGAR            VARCHAR(36) NOT NULL,
    VALOR                      NUMERIC(10,2) NOT NULL,
    ID_CONTA_CONTABIL_DEBITO   VARCHAR(36)
);

}

uses
  Windows, Dialogs, Messages, Classes, SysUtils, uHistoricoModel,uContaContabilModel;

type
  TTituloPagarHistoricoModel = class(TObject)
  private

    FFID: string;
    FFIDorganizacao: string;
    FFIDHistorico: string;
    FFIDContaContabilDebito: string;
    FFIDTP: string;
    FFvalor : Currency;
    FFHistorico : THistoricoModel;
    FFContaContabil : TContaContabilModel;


    procedure SetFFID(const Value: string);
    procedure SetFFIDContaContabilDebito(const Value: string);
    procedure SetFFIDHistorico(const Value: string);
    procedure SetFFIDorganizacao(const Value: string);
    procedure SetFFIDTP(const Value: string);
    procedure SetFFvalor(const Value: Currency);
    procedure SetFFContaContabil(const Value: TContaContabilModel);
    procedure SetFFHistorico(const Value: THistoricoModel);


    public


    property FID: string                          read FFID                     write SetFFID  ;
    property FIDorganizacao: string               read FFIDorganizacao          write SetFFIDorganizacao  ;
    property FIDHistorico: string                 read FFIDHistorico            write SetFFIDHistorico  ;
    property FIDContaContabilDebito: string       read FFIDContaContabilDebito  write SetFFIDContaContabilDebito  ;
    property FIDTP: string                        read FFIDTP                   write SetFFIDTP  ;
    property Fvalor : Currency                    read FFvalor                  write SetFFvalor  ;
    property FHistorico: THistoricoModel          read  FFHistorico             write SetFFHistorico;
    property FContaContabil: TContaContabilModel  read  FFContaContabil         write SetFFContaContabil;

   constructor Create;

  end;

implementation

{ TTituloPagarHistoricoModel }

constructor TTituloPagarHistoricoModel.Create;
begin
//
end;

procedure TTituloPagarHistoricoModel.SetFFContaContabil(
  const Value: TContaContabilModel);
begin
  FFContaContabil := Value;
end;

procedure TTituloPagarHistoricoModel.SetFFHistorico(
  const Value: THistoricoModel);
begin
  FFHistorico := Value;
end;

procedure TTituloPagarHistoricoModel.SetFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTituloPagarHistoricoModel.SetFFIDContaContabilDebito(
  const Value: string);
begin
  FFIDContaContabilDebito := Value;
end;

procedure TTituloPagarHistoricoModel.SetFFIDHistorico(const Value: string);
begin
  FFIDHistorico := Value;
end;

procedure TTituloPagarHistoricoModel.SetFFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TTituloPagarHistoricoModel.SetFFIDTP(const Value: string);
begin
  FFIDTP := Value;
end;

procedure TTituloPagarHistoricoModel.SetFFvalor(const Value: Currency);
begin
  FFvalor := Value;
end;

end.


