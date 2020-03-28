unit uUsuarioModel;

interface
{

CREATE TABLE USUARIO (
    ID_USUARIO        NUMERIC(5,0) NOT NULL,
    LOGIN             VARCHAR(30) NOT NULL,
    NOME              VARCHAR(50) NOT NULL,
    SENHA             VARCHAR(36) NOT NULL,
    ATIVO             INTEGER NOT NULL,
    ID_ORGANIZACAO    VARCHAR(36),
    ULTIMO_ACESSO     DATE,
    EH_ADMINISTRADOR  INTEGER
);


}
uses
  Windows, Messages, Classes, SysUtils, uOrganizacaoModel;

type
  TUsuarioModel = class(TObject)
  private

    FFID: Integer;
    FFativo :Integer;
    FFadmin :Integer;
    FFIDorganizacao: string;
    FFlogin :string;
    FFnome :string;
    FFsenha :string;
    FFultimoAcesso :TDateTime;
    function getFFadmin: Integer;
    function getFFativo: Integer;
    function getFFID: Integer;
    function getFFIDorganizacao: string;
    function getFFlogin: string;
    function getFFnome: string;
    function getFFsenha: string;
    function getFFultimoAcesso: TDateTime;
    procedure SetFFadmin(const Value: Integer);
    procedure SetFFativo(const Value: Integer);
    procedure SetFFID(const Value: Integer);
    procedure SetFFIDorganizacao(const Value: string);
    procedure SetFFlogin(const Value: string);
    procedure SetFFnome(const Value: string);
    procedure SetFFsenha(const Value: string);
    procedure SetFFultimoAcesso(const Value: TDateTime);


    public

    property FID: Integer read getFFID  write SetFFID ;
    property Fativo :Integer read getFFativo   write SetFFativo   ;
    property Fadmin :Integer read getFFadmin   write SetFFadmin   ;
    property FIDorganizacao: string read getFFIDorganizacao write SetFFIDorganizacao;
    property Flogin :string read getFFlogin   write SetFFlogin   ;
    property Fnome :string read getFFnome   write SetFFnome   ;
    property Fsenha :string read getFFsenha   write SetFFsenha  ;
    property FultimoAcesso :TDateTime read getFFultimoAcesso   write SetFFultimoAcesso   ;

    constructor Create;
    destructor Destroy; override;
  end;


implementation

{ TUsuarioModel }

constructor TUsuarioModel.Create;
begin
//ver
end;

destructor TUsuarioModel.Destroy;
begin

  inherited;
end;

function TUsuarioModel.getFFadmin: Integer;
begin
  Result := FFadmin;
end;

function TUsuarioModel.getFFativo: Integer;
begin
   Result := FFativo;
end;

function TUsuarioModel.getFFID: Integer;
begin
    Result := FFID;
end;

function TUsuarioModel.getFFIDorganizacao: string;
begin
    Result := FFIDorganizacao;
end;

function TUsuarioModel.getFFlogin: string;
begin
    Result := FFlogin;
end;

function TUsuarioModel.getFFnome: string;
begin
    Result := FFnome;
end;

function TUsuarioModel.getFFsenha: string;
begin
     Result := FFsenha;
end;

function TUsuarioModel.getFFultimoAcesso: TDateTime;
begin
     Result := FFultimoAcesso;
end;

procedure TUsuarioModel.SetFFadmin(const Value: Integer);
begin
  FFadmin := Value;
end;

procedure TUsuarioModel.SetFFativo(const Value: Integer);
begin
   FFativo := Value;
end;

procedure TUsuarioModel.SetFFID(const Value: Integer);
begin
    FFID := Value;
end;

procedure TUsuarioModel.SetFFIDorganizacao(const Value: string);
begin
     FFIDorganizacao := Value;
end;

procedure TUsuarioModel.SetFFlogin(const Value: string);
begin
    FFlogin := Value;
end;

procedure TUsuarioModel.SetFFnome(const Value: string);
begin
    FFnome := Value;
end;

procedure TUsuarioModel.SetFFsenha(const Value: string);
begin
    FFsenha := Value;
end;

procedure TUsuarioModel.SetFFultimoAcesso(const Value: TDateTime);
begin
    FFultimoAcesso := Value;
end;

end.
