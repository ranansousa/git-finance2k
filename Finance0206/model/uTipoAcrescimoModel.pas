unit uTipoAcrescimoModel;

interface

{
CREATE TABLE TIPO_ACRESCIMO (
    ID_TIPO_ACRESCIMO  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO     VARCHAR(36) NOT NULL,
    ID_HISTORICO       VARCHAR(36),
    DESCRICAO          VARCHAR(20)
);
}
uses
  Windows, Messages, Classes, SysUtils, uHistoricoModel;

type
  TTipoAcrescimoModel = class(TObject)
  private
    FFID :string ;
    FFIDOrganizacao :string;
    FFIDhistorico :string;
    FFDescricao: string;
    FFhistorico :THistoricoModel;

    procedure SetFDescricao(const Value: string);
    procedure SetFIdHistorico(const Value: string);
    procedure SetFhistorico(const Value: THistoricoModel);
    procedure SetFID(const Value: string);
    procedure SetFIdOrganizacao(const Value: string);

   public

    property FID :string read FFID write SetFID;
    property FIDOrganizacao :string read FFIDOrganizacao write SetFIdOrganizacao;
    property FIDHistorico: string read FFIdHistorico write SetFIdHistorico;
    property FDescricao: string read FFDescricao write SetFDescricao;
    property Fhistorico: THistoricoModel read FFhistorico write SetFhistorico;



    Constructor Create;


  end;
implementation

{ TTipoAcrescimoModel }

constructor TTipoAcrescimoModel.Create;
begin
//
end;

procedure TTipoAcrescimoModel.SetFDescricao(const Value: string);
begin
  FFDescricao := Value;
end;

procedure TTipoAcrescimoModel.SetFhistorico(const Value: THistoricoModel);
begin
  FFhistorico := Value;
end;

procedure TTipoAcrescimoModel.SetFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTipoAcrescimoModel.SetFIdHistorico(const Value: string);
begin
  FFIdHistorico := Value;
end;


procedure TTipoAcrescimoModel.SetFIdOrganizacao(const Value: string);
begin
  FFIDOrganizacao := Value;
end;

end.