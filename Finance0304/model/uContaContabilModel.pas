unit uContaContabilModel;
interface

uses
  Windows, Messages, Classes, SysUtils;

type
  TContaContabilModel = class(TObject)
  private
    FFconta: string;
    FFdgReduz: string;
    FFdgVer: string;
    FFcodigoReduzido: string;
    FFID: string;
    FFdescricao: string;
    FFIDorganizacao: string;
    FFinscMF: string;
    FFtipo: string;
    FFgrau: string;


    FFdataRegistro: TDateTime;
    FFordemDIPJ: Integer;
    FFrelacionamento: Integer;
    FFnatureza: Integer;


    function getFFcodigoReduzido: string;
    function getFFconta: string;
    function getFFdescricao: string;
    function getFFdgReduz: string;
    function getFFdgVer: string;
    function getFFgrau: string;
    function getFFID: string;
    function getFFIDorganizacao: string;
    function getFFinscMF: string;
    function getFFnatureza: Integer;
    function getFFrelacionamento: Integer;
    function getFFtipo: string;
    function getFFdataRegistro: TDateTime;
    function getFFordemDIPJ: Integer;

    procedure SetFcodigoReduzido(const Value: string);
    procedure SetFconta(const Value: string);
    procedure SetFdescricao(const Value: string);
    procedure SetFdgReduz(const Value: string);
    procedure SetFdgVer(const Value: string);
    procedure SetFgrau(const Value: string);
    procedure SetFID(const Value: string);
    procedure SetFIDorganizacao(const Value: string);
    procedure SetFinscMF(const Value: string);
    procedure SetFnatureza(const Value: Integer);
    procedure SetFrelacionamento(const Value: Integer);
    procedure SetFtipo(const Value: string);
    procedure SetFdataRegistro(const Value: TDateTime);
    procedure SetFordemDIPJ(const Value: Integer);


  public

    property Fdescricao: string read getFFdescricao write SetFdescricao;
    property FcodigoReduzido: string read getFFcodigoReduzido write SetFcodigoReduzido;
    property FdgVer: string read getFFdgVer write SetFdgVer;
    property Fconta: string read getFFconta write SetFconta;
    property FdgReduz: string read getFFdgReduz write SetFdgReduz;
    property FID: string read getFFID write SetFID;
    property FIDorganizacao: string read getFFIDorganizacao write SetFIDorganizacao;
    property FinscMF: string read getFFinscMF write SetFinscMF;
    property Ftipo: string read getFFtipo write SetFtipo;
    property Fgrau: string read getFFgrau write SetFgrau;
    property FordemDIPJ: Integer read getFFordemDIPJ write SetFordemDIPJ;
    property Frelacionamento: Integer read getFFrelacionamento write SetFrelacionamento;
    property Fnatureza: Integer read getFFnatureza write SetFnatureza;
    property FdataRegistro: TDateTime read getFFdataRegistro write SetFdataRegistro;

    constructor Create;
    destructor Destroy; override;

  end;

implementation




{ TContaContabilModel }

constructor TContaContabilModel.Create;
begin
  //
end;

destructor TContaContabilModel.Destroy;
begin

  inherited;
end;

function TContaContabilModel.getFFcodigoReduzido: string;
begin
  Result := FFcodigoReduzido;
end;

function TContaContabilModel.getFFconta: string;
begin
   Result := FFconta;
end;

function TContaContabilModel.getFFdataRegistro: TDateTime;
begin
      Result := FFdataRegistro;
end;

function TContaContabilModel.getFFdescricao: string;
begin
   Result := FFdescricao;
end;

function TContaContabilModel.getFFdgReduz: string;
begin
    Result := FFdgReduz;
end;

function TContaContabilModel.getFFdgVer: string;
begin
    Result := FFdgVer;
end;

function TContaContabilModel.getFFgrau: string;
begin
   Result := FFgrau;
end;

function TContaContabilModel.getFFID: string;
begin
   Result := FFID;
end;

function TContaContabilModel.getFFIDorganizacao: string;
begin
     Result := FFIDorganizacao;
end;

function TContaContabilModel.getFFinscMF: string;
begin
    Result := FFinscMF;
end;

function TContaContabilModel.getFFnatureza: Integer;
begin
     Result := FFnatureza;
end;

function TContaContabilModel.getFFordemDIPJ: Integer;
begin
    Result := FFordemDIPJ;
end;

function TContaContabilModel.getFFrelacionamento: Integer;
begin
    Result := FFrelacionamento;
end;

function TContaContabilModel.getFFtipo: string;
begin
   Result := FFtipo;
end;

procedure TContaContabilModel.SetFcodigoReduzido(const Value: string);
begin
   FFcodigoReduzido :=Value;
end;

procedure TContaContabilModel.SetFconta(const Value: string);
begin
    FFconta :=Value;
end;

procedure TContaContabilModel.SetFdataRegistro(const Value: TDateTime);
begin
     FFdataRegistro :=Value;
end;

procedure TContaContabilModel.SetFdescricao(const Value: string);
begin
     FFdescricao :=Value;
end;

procedure TContaContabilModel.SetFdgReduz(const Value: string);
begin
    FFdgReduz :=Value;
end;

procedure TContaContabilModel.SetFdgVer(const Value: string);
begin
      FFdgVer :=Value;
end;

procedure TContaContabilModel.SetFgrau(const Value: string);
begin
     FFgrau :=Value;
end;

procedure TContaContabilModel.SetFID(const Value: string);
begin
      FFID :=Value;
end;

procedure TContaContabilModel.SetFIDorganizacao(const Value: string);
begin
     FFIDorganizacao :=Value;
end;

procedure TContaContabilModel.SetFinscMF(const Value: string);
begin
     FFinscMF :=Value;
end;

procedure TContaContabilModel.SetFnatureza(const Value: Integer);
begin
     FFnatureza :=Value;
end;

procedure TContaContabilModel.SetFordemDIPJ(const Value: Integer);
begin
     FFordemDIPJ :=Value;
end;

procedure TContaContabilModel.SetFrelacionamento(const Value: Integer);
begin
      FFrelacionamento :=Value;
end;

procedure TContaContabilModel.SetFtipo(const Value: string);
begin
     FFtipo :=Value;
end;




end.