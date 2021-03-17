unit uTipoCedenteModel;

interface

 {
CREATE TABLE TIPO_CEDENTE (
    ID_TIPO_CEDENTE  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO   VARCHAR(36) NOT NULL,
    DESCRICAO        VARCHAR(60)
);

}
uses
  Windows, Messages, Classes, SysUtils, uHistoricoModel;

type
  TTipoCedenteModel = class(TObject)
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

{ TTipoCedenteModel }

constructor TTipoCedenteModel.Create;
begin
 FFnovo := True;
end;

procedure TTipoCedenteModel.SetFDescricao(const Value: string);
begin
  FFDescricao := Value;
end;

procedure TTipoCedenteModel.SetFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTipoCedenteModel.SetFIdOrganizacao(const Value: string);
begin
  FFIDOrganizacao := Value;
end;

end.
