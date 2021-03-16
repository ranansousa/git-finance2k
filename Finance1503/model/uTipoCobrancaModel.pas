unit uTipoCobrancaModel;

interface


uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel;

 type
  TTipoCobrancaModel = class(TObject)

  private

    FFID: string;
    FFIDorganizacao: string;
    FFDescricao: string;
    FFOrganizacao: TOrganizacaoModel;

    function getFFOrganizacao: TOrganizacaoModel;
    function getFFID: string;
    function getFFIDorganizacao: string;
    function getFFDescricao: string;

    procedure setFFID(const Value: string);
    procedure setFFIDorganizacao(const Value: string);
    procedure setFFDescricao(const Value: string);
    procedure SetForganizacao(const Value: TOrganizacaoModel);


  public

    property FID: string read getFFID write SetFFID;
    property FIDorganizacao: string read getFFIDorganizacao write SetFFIDorganizacao;
    property FDescricao: string read getFFDescricao write SetFFDescricao;
    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetForganizacao;


  Constructor Create;


  end;

implementation

{ TTipoCobrancaModel }

constructor TTipoCobrancaModel.Create;
begin
 //VER
end;

function TTipoCobrancaModel.getFFDescricao: string;
begin
Result := FFDescricao;
end;

function TTipoCobrancaModel.getFFID: string;
begin
Result := FFID;
end;

function TTipoCobrancaModel.getFFIDorganizacao: string;
begin
Result := FFIDorganizacao;
end;

function TTipoCobrancaModel.getFFOrganizacao: TOrganizacaoModel;
begin
Result := FFOrganizacao;

end;

procedure TTipoCobrancaModel.setFFDescricao(const Value: string);
begin
 FFDescricao := Value;
end;

procedure TTipoCobrancaModel.setFFID(const Value: string);
begin
 FFID := Value;
end;

procedure TTipoCobrancaModel.setFFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TTipoCobrancaModel.SetForganizacao(const Value: TOrganizacaoModel);
begin
FFOrganizacao := Value;
end;

end.

