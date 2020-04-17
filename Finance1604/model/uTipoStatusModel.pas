unit uTipoStatusModel;

interface
{

CREATE TABLE TIPO_STATUS (
    ID_TIPO_STATUS  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO  VARCHAR(36) NOT NULL,
    DESCRICAO       VARCHAR(20)
);

}


uses
  Windows, Messages, Classes, SysUtils, uOrganizacaoModel;

type
  TTipoStatusModel = class(TObject)
  private

    FFID: string;
    FFIDorganizacao: string;
    FFOrganizacao :TOrganizacaoModel;
    FFdescricao :string;
    procedure SetFFdescricao(const Value: string);
    procedure SetFFID(const Value: string);
    procedure SetFFIDorganizacao(const Value: string);
    procedure SetFFOrganizacao(const Value: TOrganizacaoModel);

 public

    property FID: string read FFID write SetFFID;
    property FIDorganizacao: string read FFIDorganizacao write SetFFIDorganizacao;
    property Forganizacao: TOrganizacaoModel read FFOrganizacao write SetFFOrganizacao;
    property Fdescricao: string read FFdescricao write SetFFdescricao;


    Constructor Create;




  end;


implementation

{ TTipoStatusModel }

constructor TTipoStatusModel.Create;
begin

end;

procedure TTipoStatusModel.SetFFdescricao(const Value: string);
begin
  FFdescricao := Value;
end;

procedure TTipoStatusModel.SetFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTipoStatusModel.SetFFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TTipoStatusModel.SetFFOrganizacao(const Value: TOrganizacaoModel);
begin
  FFOrganizacao := Value;
end;

end.
