unit uBairroModel;

interface
 { CREATE TABLE BAIRRO (
    ID_BAIRRO  VARCHAR(36) NOT NULL,
    ID_CIDADE  VARCHAR(36),
    BAIRRO     VARCHAR(50)
);  }

uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel, uCidadeModel;

type
  TBairroModel = class(TObject)
  private
    FFID        : string;
    FFIDcidade  : string;
    FFbairro    : string;
    FFcidade    : TCidadeModel;
    FFnovo      : Boolean;

    procedure SetFFbairro(const Value: string);
    procedure SetFFcidade(const Value: TCidadeModel);
    procedure SetFFIDcidade(const Value: string);
    procedure SetFID(const Value: string);

  public

    property FID: string read FFID write SetFID;
    property FIDcidade: string read FFIDcidade write SetFFIDcidade;
    property Fbairro: string read FFbairro write SetFFbairro;
    property Fcidade: TCidadeModel read FFcidade write SetFFcidade;
    property Fnovo :Boolean        read FFnovo       write FFnovo; //define se é novo ou já existe.

    Constructor Create;

  end;

implementation

{ TBairroModel }

constructor TBairroModel.Create;
begin
FFnovo := True;
end;

procedure TBairroModel.SetFFbairro(const Value: string);
begin
  FFbairro := Value;
end;

procedure TBairroModel.SetFFcidade(const Value: TCidadeModel);
begin
  FFcidade := Value;
end;

procedure TBairroModel.SetFFIDcidade(const Value: string);
begin
  FFIDcidade := Value;
end;

procedure TBairroModel.SetFID(const Value: string);
begin
  FFID := Value;
end;

end.
