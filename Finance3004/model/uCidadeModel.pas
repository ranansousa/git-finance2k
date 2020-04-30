unit uCidadeModel;

interface
 {
CREATE TABLE CIDADE (
    ID_CIDADE  VARCHAR(36) NOT NULL,
    CODIGO     INTEGER,
    CIDADE     VARCHAR(50),
    ID_ESTADO  VARCHAR(50)
);


}

uses
  Windows, Messages, Classes, SysUtils,uEstadoModel;

type
  TCidadeModel = class(TObject)
  private
    FFID: string;
    FFcidade :string;
    FFIDestado :string;
    FFcodigo :Integer;
    FFestado : TEstadoModel;
    FFnovo : Boolean;

    procedure SetFFcidade(const Value: string);
    procedure SetFFcodigo(const Value: Integer);
    procedure SetFFestado(const Value: TEstadoModel);
    procedure SetFFIDestado(const Value: string);
    procedure SetFID(const Value: string);

  public

    property FID: string read FFID write SetFID;
    property Fcidade: string read FFcidade write SetFFcidade;
    property FIDestado: string read FFIDestado write SetFFIDestado;
    property Fcodigo: Integer read FFcodigo write SetFFcodigo;
    property Festado: TEstadoModel read FFestado write SetFFestado;
    property Fnovo :Boolean        read FFnovo       write FFnovo; //define se é novo ou já existe.
    Constructor Create;

  end;

implementation

{ TEstadoModel }

constructor TCidadeModel.Create;
begin
FFnovo := True;
end;

procedure TCidadeModel.SetFFcidade(const Value: string);
begin
  FFcidade := Value;
end;

procedure TCidadeModel.SetFFcodigo(const Value: Integer);
begin
  FFcodigo := Value;
end;

procedure TCidadeModel.SetFFestado(const Value: TEstadoModel);
begin
  FFestado := Value;
end;

procedure TCidadeModel.SetFFIDestado(const Value: string);
begin
  FFIDestado := Value;
end;

procedure TCidadeModel.SetFID(const Value: string);
begin
  FFID := Value;
end;

end.
