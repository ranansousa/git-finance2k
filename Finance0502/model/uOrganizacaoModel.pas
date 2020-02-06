unit uOrganizacaoModel;


interface


uses
  Windows, Messages, Classes, SysUtils;


type
  TOrganizacaoModel = class
  private

    FFID: string;
    FFRazaoSocial: string;
    FFSigla: string;
    FFFantasia: string;
    FFCNPJ: string;
    FFVersao: string;

    function getFFID: string;
    function getFFRazaoSocial: string;
    function getFFSigla: string;
    function getFFFantasia: string;
    function getFFCNPJ: string;
    function getFFVersao: string;


    procedure SetFID(const Value: string);
    procedure SetFCNPJ(const Value: string);
    procedure SetFFantasia(const Value: string);
    procedure SetFRazaoSocial(const Value: string);
    procedure SetFSigla(const Value: string);
    procedure SetFVersao(const Value: string);

  public
    // atibutos e métodos públicos
    property FID: string read getFFID write SetFID;
    property FRazaoSocial: string read getFFRazaoSocial write SetFRazaoSocial;
    property FSigla: string read getFFSigla write SetFSigla;
    property FFantasia: string read getFFFantasia write SetFFantasia;
    property FCNPJ: string read getFFCNPJ write SetFCNPJ;
    property FVersao: string read getFFVersao write SetFVersao;


    constructor Create;
    destructor Destroy; override;

  end;

implementation
{ TOrganizacao }


constructor TOrganizacaoModel.Create;
begin
// ver o que por aqui
end;

destructor TOrganizacaoModel.Destroy;
begin

  inherited;
end;

function TOrganizacaoModel.getFFCNPJ: string;
begin
 Result := FFCNPJ;
end;

function TOrganizacaoModel.getFFFantasia: string;
begin
  Result := FFFantasia;
end;

function TOrganizacaoModel.getFFID: string;
begin
  Result := FFID;
end;

function TOrganizacaoModel.getFFRazaoSocial: string;
begin
  Result := FFRazaoSocial;
end;

function TOrganizacaoModel.getFFSigla: string;
begin
   Result := FFSigla;
end;

function TOrganizacaoModel.getFFVersao: string;
begin
   Result := FFVersao;
end;

procedure TOrganizacaoModel.SetFCNPJ(const Value: string);
begin
   FFCNPJ :=Value;
end;

procedure TOrganizacaoModel.SetFFantasia(const Value: string);
begin
     FFFantasia :=Value;
end;

procedure TOrganizacaoModel.SetFID(const Value: string);
begin
     FFID :=Value;
end;

procedure TOrganizacaoModel.SetFRazaoSocial(const Value: string);
begin
     FFRazaoSocial :=Value;
end;

procedure TOrganizacaoModel.SetFSigla(const Value: string);
begin
     FFSigla :=Value;
end;

procedure TOrganizacaoModel.SetFVersao(const Value: string);
begin
    FFVersao :=Value;
end;


end.
