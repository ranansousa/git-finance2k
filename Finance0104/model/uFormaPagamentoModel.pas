unit uFormaPagamentoModel;

interface

uses
  Windows, Messages, Classes, SysUtils,uContaContabilModel,uOrganizacaoModel;

  {table
CREATE TABLE FORMA_PAGAMENTO (
    ID_FORMA_PAGAMENTO     VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO         VARCHAR(36) NOT NULL,
    DESCRICAO              VARCHAR(60),
    ID_CONTA_CONTABIL      VARCHAR(36)

);
  }


 type
  TFormaPagamentoModel = class(TObject)

  private

    FFID: string;
    FFIDorganizacao: string;
    FFDescricao: string;
    FFOrganizacao: TOrganizacaoModel;
    FFContaContabil: TContaContabilModel;
    FFIdContaContabil :string;


    function getFFOrganizacao: TOrganizacaoModel;
    function getFFID: string;
    function getFFIDorganizacao: string;
    function getFFDescricao: string;
    function getFFIDcontaContabil: string;
    function getFFContaContabil: TContaContabilModel;

    procedure setFFID(const Value: string);
    procedure setFFIDorganizacao(const Value: string);
    procedure setFFDescricao(const Value: string);
    procedure SetForganizacao(const Value: TOrganizacaoModel);
    procedure SetFContaContabil(const Value: TContaContabilModel);
    procedure SetFIdContaContabil(const Value: string);


  public

    property FID: string read getFFID write SetFFID;
    property FIDorganizacao: string read getFFIDorganizacao write SetFFIDorganizacao;
    property FDescricao: string read getFFDescricao write SetFFDescricao;
    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetForganizacao;
    property FIDcontaContabil: string read getFFIDcontaContabil write SetFIDcontaContabil;
    property FContaContabil: TContaContabilModel read getFFContaContabil write SetFContaContabil;


  Constructor Create;


  end;

implementation

{ TFormaPagamentoModel }

constructor TFormaPagamentoModel.Create;
begin
 //VER
end;

function TFormaPagamentoModel.getFFContaContabil: TContaContabilModel;
begin
Result := FFContaContabil;
end;

function TFormaPagamentoModel.getFFDescricao: string;
begin
Result := FFDescricao;
end;

function TFormaPagamentoModel.getFFID: string;
begin
Result := FFID;
end;

function TFormaPagamentoModel.getFFIDcontaContabil: string;
begin
 Result := FFIdContaContabil;
end;

function TFormaPagamentoModel.getFFIDorganizacao: string;
begin
Result := FFIDorganizacao;
end;

function TFormaPagamentoModel.getFFOrganizacao: TOrganizacaoModel;
begin
Result := FFOrganizacao;

end;

procedure TFormaPagamentoModel.SetFContaContabil( const Value: TContaContabilModel);
begin
 FFContaContabil := Value;
end;

procedure TFormaPagamentoModel.setFFDescricao(const Value: string);
begin
 FFDescricao := Value;
end;

procedure TFormaPagamentoModel.setFFID(const Value: string);
begin
 FFID := Value;
end;

procedure TFormaPagamentoModel.setFFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TFormaPagamentoModel.SetFIdContaContabil(const Value: string);
begin
   FFIdContaContabil := Value;
end;

procedure TFormaPagamentoModel.SetForganizacao(const Value: TOrganizacaoModel);
begin
FFOrganizacao := Value;
end;

end.
