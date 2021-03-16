unit uHistoricoModel;

interface

{


CREATE TABLE HISTORICO (
    ID_HISTORICO           VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO         VARCHAR(36) NOT NULL,
    DESCRICAO              VARCHAR(160) NOT NULL,
    TIPO                   CHAR(1) NOT NULL,
    CODIGO                 INTEGER NOT NULL,
    ID_CONTA_CONTABIL      VARCHAR(36),
    DESCRICAO_REDUZIDA     VARCHAR(100), //*
    PRODUTO                VARCHAR(200)
);





}
uses
  Windows, Messages, Classes, SysUtils, uContaContabilModel;

type
  THistoricoModel = class(TObject)
  private
    FFID :string ;
    FFdescricaoReduzida :string;
    FFIdOrganizcao :string;
    FFContaContabil: TContaContabilModel;
    FFIdContaContabil :string;
    FFDescricao: string;
    FFIdHistorico: string;
    FFTipo : string;
    FFProduto :string;
    FFCodigo : Integer;


    procedure SetFIdOrganizacao(const Value: string);
    procedure SetFContaContabil(const Value: TContaContabilModel);
    procedure SetFIdContaContabil(const Value: string);

    procedure SetFDescricao(const Value: string);
    procedure SetFIdHistorico(const Value: string);
    procedure SetFTipo(const Value: string);

    procedure SetFProduto(const Value: string);
    procedure SetFCodigo(const Value: Integer);
    procedure SetFdescricaoReduzida(const Value: string);
    procedure SetFID(const Value: string);

    public

    property FIdOrganizacao :string read FFIdOrganizcao write SetFIdOrganizacao;
    property FIdHistorico: string read FFIdHistorico write SetFIdHistorico;
    property FDescricao: string read FFDescricao write SetFDescricao;
    property FTipo :string read FFTipo write SetFTipo;
    property FIdContaContabil :string read FFIdContaContabil write SetFIdContaContabil;
    property FProduto :string read FFProduto write SetFProduto;
    property FCodigo :Integer read FFCodigo write SetFCodigo;
    property FContaContabil: TContaContabilModel read FFContaContabil write SetFContaContabil;

    property FID :string read FFID write SetFID;
    property FdescricaoReduzida :string read FFdescricaoReduzida write SetFdescricaoReduzida;


    Constructor Create;


  end;

implementation

{ THistoricoModel }


constructor THistoricoModel.Create;
begin

end;

procedure THistoricoModel.SetFCodigo(const Value: Integer);
begin
  FFCodigo := Value;
end;

procedure THistoricoModel.SetFContaContabil(const Value: TContaContabilModel);
begin
  FFContaContabil := Value;
end;

procedure THistoricoModel.SetFDescricao(const Value: string);
begin
  FFDescricao := Value;
end;

procedure THistoricoModel.SetFdescricaoReduzida(const Value: string);
begin
  FFdescricaoReduzida := Value;
end;

procedure THistoricoModel.SetFID(const Value: string);
begin
  FFID := Value;
end;

procedure THistoricoModel.SetFIdContaContabil(const Value: string);
begin
  FFIdContaContabil := Value;
end;

procedure THistoricoModel.SetFIdHistorico(const Value: string);
begin
  FFIdHistorico := Value;
end;

procedure THistoricoModel.SetFIdOrganizacao(const Value: string);
begin
FFIdOrganizcao := Value;
end;

procedure THistoricoModel.SetFProduto(const Value: string);
begin
  FFProduto := Value;
end;

procedure THistoricoModel.SetFTipo(const Value: string);
begin
  FFTipo := Value;
end;

end.


