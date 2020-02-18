unit uSacadoModel;

interface


uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel;

type
  TSacadoModel = class(TObject)
  private
    FFID: string;
    FFCodigo :string;
    FFStatus :string;
    FFIDtipoSacado: string;
    FFIDorganizacao :string;
    FFIDendereco: string;
    FFIDcontato: string;
    FFnome: string;
    FFcpfCnpj: string;
    FFinscricaoEstadual: string;
    FFpersonalidade: string;
    FFconta: string;
    FFagencia: string;
    FFIDbanco: string;
    FFIDcontaContabil: string;
    FFDataRegistro: TDateTime;
    FFDataUltimaAtualizacao: TDateTime;
    FFOrganizacao :TOrganizacaoModel;


    function getFFOrganizacao : TOrganizacaoModel;
    function getFFIDtipoSacado: string;
    function getFFID: string;
    function getFFCodigo: string;
    function getFFStatus: string;

    function getFFIDendereco: string;
    function getFFIDcontato: string;
    function getFFnome: string;
    function getFFcpfCnpj: string;
    function getFFinscricaoEstadual: string;
    function getFFpersonalidade: string;
    function getFFconta: string;
    function getFFagencia: string;
    function getFFIDbanco: string;
    function getFFIDcontaContabil: string;
    function getFFIDorganizacao: string;
    function getFFDataRegistro :TDateTime;
    function getFFDataUltimaAtualizacao :TDateTime;

    procedure SetFagencia(const Value: string);

    procedure SetFconta(const Value: string);
    procedure SetFcpfCnpj(const Value: string);
    procedure SetFIDbanco(const Value: string);
    procedure SetFIDcontaContabil(const Value: string);
    procedure SetFIDcontato(const Value: string);
    procedure SetFIDendereco(const Value: string);
    procedure SetFIDtipoSacado(const Value: string);
    procedure SetFinscricaoEstadual(const Value: string);
    procedure SetFnome(const Value: string);
    procedure SetFpersonalidade(const Value: string);
    procedure SetFIDorganizacao(const Value: string);
    procedure SetForganizacao(const Value: TOrganizacaoModel);
    procedure SetFID(const Value: string);
    procedure SetFCodigo(const Value: string);
    procedure SetFStatus(const Value: string);
    procedure SetFDataRegistro(const Value: TDateTime);
    procedure SetFDataUltimaAtualizacao(const Value: TDateTime);

  public

    property FDataRegistro: TDateTime read getFFDataRegistro write SetFDataRegistro;
    property FDataUltimaAtualizacao: TDateTime read getFFDataUltimaAtualizacao write SetFDataUltimaAtualizacao;

    property FIDtipoSacado: string read getFFIDtipoSacado write SetFIDtipoSacado;
    property FCodigo: string read getFFCodigo write SetFCodigo;
    property FStatus: string read getFFStatus write SetFStatus;

    property  FID: string read getFFID write SetFID;
    property FIDorganizacao: string read getFFIDorganizacao write SetFIDorganizacao;
    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetForganizacao;

    property FIDendereco: string read getFFIDendereco write SetFIDendereco;
    property FIDcontato: string read getFFIDcontato write SetFIDcontato;
    property Fnome: string read getFFnome write SetFnome;
    property FcpfCnpj: string read getFFcpfCnpj write SetFcpfCnpj;
    property FinscricaoEstadual: string read getFFinscricaoEstadual write SetFinscricaoEstadual;
    property Fpersonalidade: string read getFFpersonalidade write SetFpersonalidade;
    property Fconta: string read getFFconta write SetFconta;
    property Fagencia: string read getFFagencia write SetFagencia;
    property FIDbanco: string read getFFIDbanco write SetFIDbanco;
    property FIDcontaContabil: string read getFFIDcontaContabil write SetFIDcontaContabil;


      Constructor Create;

  end;


implementation


{ TSacadoModel }

constructor TSacadoModel.Create;
begin
 if 1=1 then begin
  /// ver

 end;
end;

function TSacadoModel.getFFagencia: string;
begin
 Result := FFagencia;
end;


function TSacadoModel.getFFCodigo: string;
begin
  Result := FFCodigo;
end;

function TSacadoModel.getFFconta: string;
begin
  Result := FFconta
end;

function TSacadoModel.getFFcpfCnpj: string;
begin
   Result := FFcpfCnpj;
end;

function TSacadoModel.getFFDataRegistro: TDateTime;
begin
  Result := FFDataRegistro;
end;

function TSacadoModel.getFFDataUltimaAtualizacao: TDateTime;
begin
  Result := FFDataUltimaAtualizacao;
end;

function TSacadoModel.getFFID: string;
begin

Result := FFID;
end;

function TSacadoModel.getFFIDbanco: string;
begin
   Result := FFIDbanco;
end;

function TSacadoModel.getFFIDcontaContabil: string;
begin
  Result := FFIDcontaContabil;
end;

function TSacadoModel.getFFIDcontato: string;
begin
  Result := FFIDcontato;
end;

function TSacadoModel.getFFIDendereco: string;
begin
  Result := FFIDendereco;
end;

function TSacadoModel.getFFIDorganizacao: string;
begin
Result :=FFIDorganizacao;
end;

function TSacadoModel.getFFIDtipoSacado: string;
begin
   Result := FFIDtipoSacado;
end;

function TSacadoModel.getFFinscricaoEstadual: string;
begin
   Result := FFinscricaoEstadual;
end;

function TSacadoModel.getFFnome: string;
begin
   Result := FFnome;
end;

function TSacadoModel.getFFOrganizacao: TOrganizacaoModel;
begin
Result := FFOrganizacao;
end;

function TSacadoModel.getFFpersonalidade: string;
begin
  Result := FFpersonalidade;
end;



function TSacadoModel.getFFStatus: string;
begin
 Result := FFStatus;
end;

procedure TSacadoModel.SetFagencia(const Value: string);
begin
  FFagencia := Value;
end;

procedure TSacadoModel.SetFCodigo(const Value: string);
begin
    FFCodigo := Value;
end;

procedure TSacadoModel.SetFconta(const Value: string);
begin
  FFconta := Value;
end;

procedure TSacadoModel.SetFcpfCnpj(const Value: string);
begin
  FFcpfCnpj := Value;
end;

procedure TSacadoModel.SetFDataRegistro(const Value: TDateTime);
begin
 FFDataRegistro :=Value;
end;

procedure TSacadoModel.SetFDataUltimaAtualizacao(const Value: TDateTime);
begin
    FFDataUltimaAtualizacao :=Value;
end;

procedure TSacadoModel.SetFID(const Value: string);
begin
 FFID := Value;
end;

procedure TSacadoModel.SetFIDbanco(const Value: string);
begin
  FFIDbanco := Value;
end;

procedure TSacadoModel.SetFIDcontaContabil(const Value: string);
begin
  FFIDcontaContabil := Value;
end;

procedure TSacadoModel.SetFIDcontato(const Value: string);
begin
  FFIDcontato := Value;
end;

procedure TSacadoModel.SetFIDendereco(const Value: string);
begin
  FFIDendereco := Value;
end;

procedure TSacadoModel.SetFIDorganizacao(const Value: string);
begin
 FFIDorganizacao := value;
end;

procedure TSacadoModel.SetFIDtipoSacado(const Value: string);
begin
  FFIDtipoSacado := Value;
end;

procedure TSacadoModel.SetFinscricaoEstadual(const Value: string);
begin
  FFinscricaoEstadual := Value;
end;

procedure TSacadoModel.SetFnome(const Value: string);
begin
  FFnome := Value;
end;


procedure TSacadoModel.SetForganizacao(const Value: TOrganizacaoModel);
begin
 Forganizacao  := Value;
end;

procedure TSacadoModel.SetFpersonalidade(const Value: string);
begin
  FFpersonalidade := Value;
end;

procedure TSacadoModel.SetFStatus(const Value: string);
begin
  FFStatus := Value;
end;

end.
