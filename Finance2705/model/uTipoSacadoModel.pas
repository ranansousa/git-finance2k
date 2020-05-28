unit uTipoSacadoModel;

interface

 {

CREATE TABLE TIPO_SACADO (
    ID_TIPO_SACADO  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO  VARCHAR(36) NOT NULL,
    DESCRICAO       VARCHAR(60),

}
uses
  Windows, Messages, Classes, SysUtils, uHistoricoModel;

type
  TTipoSacadoModel = class(TObject)
  private
    FFID :string ;
    FFIDOrganizacao :string;
    FFDescricao: string;
    FFnovo      : Boolean;
    procedure SetFDescricao(const Value: string);
    procedure SetFID(const Value: string);
    procedure SetFIdOrganizacao(const Value: string);


   public

    property FID :string read FFID write SetFID;
    property FIDOrganizacao :string read FFIDOrganizacao write SetFIdOrganizacao;
    property FDescricao: string read FFDescricao write SetFDescricao;
    property Fnovo :Boolean        read FFnovo       write FFnovo;


    Constructor Create;


  end;
implementation

{ TTipoSacadoModel }

constructor TTipoSacadoModel.Create;
begin
 FFnovo := True;
end;

procedure TTipoSacadoModel.SetFDescricao(const Value: string);
begin
  FFDescricao := Value;
end;

procedure TTipoSacadoModel.SetFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTipoSacadoModel.SetFIdOrganizacao(const Value: string);
begin
  FFIDOrganizacao := Value;
end;

end.
