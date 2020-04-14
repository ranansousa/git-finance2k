unit uEstadoModel;


interface
 {
CREATE TABLE ESTADO (
    ID_ESTADO  VARCHAR(50) NOT NULL,
    SIGLA      VARCHAR(2),
    DESCRICAO  VARCHAR(50)
);

}

uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel;

type
  TEstadoModel = class(TObject)
  private
    FFID: string;
    FFdescricao :string;
    FFsigla :string;
    FFnovo : Boolean;
    procedure SetFFdescricao(const Value: string);
    procedure SetFFsigla(const Value: string);
    procedure SetFID(const Value: string);

  public

    property FID: string read FFID write SetFID;
    property Fsigla: string read FFsigla write SetFFsigla;
    property Fdescricao: string read FFdescricao write SetFFdescricao;
    property Fnovo :Boolean                         read FFnovo                write FFnovo; //define se é novo ou já existe.

      Constructor Create;

  end;

implementation




{ TEstadoModel }

constructor TEstadoModel.Create;
begin
FFnovo := True;
end;

procedure TEstadoModel.SetFFdescricao(const Value: string);
begin
  FFdescricao := Value;
end;

procedure TEstadoModel.SetFFsigla(const Value: string);
begin
  FFsigla := Value;
end;

procedure TEstadoModel.SetFID(const Value: string);
begin
  FFID := Value;
end;

end.
