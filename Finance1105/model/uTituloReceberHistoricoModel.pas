unit uTituloReceberHistoricoModel;

interface
{
CREATE TABLE TITULO_RECEBER_HISTORICO (
    ID_TITULO_RECEBER_HISTORICO  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO               VARCHAR(36) NOT NULL,
    ID_HISTORICO                 VARCHAR(36) NOT NULL,
    ID_TITULO_RECEBER            VARCHAR(36) NOT NULL,
    VALOR                        NUMERIC(10,2) NOT NULL,
    ID_CONTA_CONTABIL_DEBITO     VARCHAR(36)
);


}

uses
  Windows, Dialogs, Messages, Classes, SysUtils, uHistoricoModel,uContaContabilModel;

type
  TTituloReceberHistoricoModel = class(TObject)
  private

    FFID                    : string;
    FFIDorganizacao         : string;
    FFIDHistorico           : string;
    FFIDContaContabilDebito : string;
    FFIDTR                  : string;
    FFvalor                 : Currency;
    FFHistorico             : THistoricoModel;
    FFContaContabil         : TContaContabilModel;
    FFnovo                  : Boolean;


    procedure SetFFContaContabil(const Value: TContaContabilModel);
    procedure SetFFHistorico(const Value: THistoricoModel);
    procedure SetFFID(const Value: string);
    procedure SetFFIDContaContabilDebito(const Value: string);
    procedure SetFFIDHistorico(const Value: string);
    procedure SetFFIDorganizacao(const Value: string);
    procedure SetFFIDTR(const Value: string);
    procedure SetFFvalor(const Value: Currency);

    public

    property FID: string                          read FFID                     write SetFFID  ;
    property FIDorganizacao: string               read FFIDorganizacao          write SetFFIDorganizacao  ;
    property FIDHistorico: string                 read FFIDHistorico            write SetFFIDHistorico  ;
    property FIDContaContabilDebito: string       read FFIDContaContabilDebito  write SetFFIDContaContabilDebito  ;
    property FIDTR: string                        read FFIDTR                   write SetFFIDTR  ;
    property Fvalor : Currency                    read FFvalor                  write SetFFvalor  ;
    property FHistorico: THistoricoModel          read FFHistorico              write SetFFHistorico;
    property FContaContabil: TContaContabilModel  read FFContaContabil          write SetFFContaContabil;
    property Fnovo: Boolean read FFnovo write FFnovo;

   constructor Create;

  end;

implementation

{ TTituloReceberHistoricoModel }

constructor TTituloReceberHistoricoModel.Create;
begin
FFnovo := True;
end;

procedure TTituloReceberHistoricoModel.SetFFContaContabil(const Value: TContaContabilModel);
begin
  FFContaContabil := Value;
end;

procedure TTituloReceberHistoricoModel.SetFFHistorico(
  const Value: THistoricoModel);
begin
  FFHistorico := Value;
end;

procedure TTituloReceberHistoricoModel.SetFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTituloReceberHistoricoModel.SetFFIDContaContabilDebito(
  const Value: string);
begin
  FFIDContaContabilDebito := Value;
end;

procedure TTituloReceberHistoricoModel.SetFFIDHistorico(const Value: string);
begin
  FFIDHistorico := Value;
end;

procedure TTituloReceberHistoricoModel.SetFFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TTituloReceberHistoricoModel.SetFFIDTR(const Value: string);
begin
  FFIDTR := Value;
end;

procedure TTituloReceberHistoricoModel.SetFFvalor(const Value: Currency);
begin
  FFvalor := Value;
end;

end.


