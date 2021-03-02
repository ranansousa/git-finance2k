unit uLocalPagamento;

interface

uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel;

 type
  TLocalPagamento = class(TObject)

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

{ TLocalPagamento }

constructor TLocalPagamento.Create;
begin
 //VER
end;

function TLocalPagamento.getFFDescricao: string;
begin
Result := FFDescricao;
end;

function TLocalPagamento.getFFID: string;
begin
Result := FFID;
end;

function TLocalPagamento.getFFIDorganizacao: string;
begin
Result := FFIDorganizacao;
end;

function TLocalPagamento.getFFOrganizacao: TOrganizacaoModel;
begin
Result := FFOrganizacao;

end;

procedure TLocalPagamento.setFFDescricao(const Value: string);
begin
 FFDescricao := Value;
end;

procedure TLocalPagamento.setFFID(const Value: string);
begin
 FFID := Value;
end;

procedure TLocalPagamento.setFFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TLocalPagamento.SetForganizacao(const Value: TOrganizacaoModel);
begin
FFOrganizacao := Value;
end;

end.

