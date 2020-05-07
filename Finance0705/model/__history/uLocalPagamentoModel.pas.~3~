unit uLocalPagamentoModel;

interface

uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel;

 type
  TLocalPagamentoModel = class(TObject)

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

{ TLocalPagamentoModel }

constructor TLocalPagamentoModel.Create;
begin
 //VER
end;

function TLocalPagamentoModel.getFFDescricao: string;
begin
Result := FFDescricao;
end;

function TLocalPagamentoModel.getFFID: string;
begin
Result := FFID;
end;

function TLocalPagamentoModel.getFFIDorganizacao: string;
begin
Result := FFIDorganizacao;
end;

function TLocalPagamentoModel.getFFOrganizacao: TOrganizacaoModel;
begin
Result := FFOrganizacao;

end;

procedure TLocalPagamentoModel.setFFDescricao(const Value: string);
begin
 FFDescricao := Value;
end;

procedure TLocalPagamentoModel.setFFID(const Value: string);
begin
 FFID := Value;
end;

procedure TLocalPagamentoModel.setFFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TLocalPagamentoModel.SetForganizacao(const Value: TOrganizacaoModel);
begin
FFOrganizacao := Value;
end;

end.
