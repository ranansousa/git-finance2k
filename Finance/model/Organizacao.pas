unit Organizacao;

interface

type
  TOrganizacao = class
  private
    Fid: String;
    FrazaoSocial: String;
    procedure Setid(const Value: String);
    procedure SetrazaoSocial(const Value: String);
  public
    // atibutos e m�todos p�blicos
    property id: String read Fid write Fid;
    property razaoSocial: String read FrazaoSocial write FrazaoSocial;
    Constructor Create;
    Destructor Destroy; Override;
  end;

implementation
{ TOrganizacao }
constructor TOrganizacao.Create;
begin
end;

destructor TOrganizacao.Destroy;
begin
  inherited;
end;

procedure TOrganizacao.Setid(const Value: String);
begin
  Fid := Value;
end;

procedure TOrganizacao.SetrazaoSocial(const Value: String);
begin
  FrazaoSocial := Value;
end;

end.
