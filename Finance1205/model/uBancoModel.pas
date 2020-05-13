unit uBancoModel;

interface
 {


CREATE TABLE BANCO (
    ID_BANCO        VARCHAR(36) NOT NULL,
    CODIGO_BANCO    VARCHAR(10),
    NOME_BANCO      VARCHAR(60),
    SIGLA_BANCO     VARCHAR(20),
    ID_ORGANIZACAO  VARCHAR(36) NOT NULL
);


}
uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel;

type
  TBancoModel = class(TObject)
  private
    FFID: string;
    FFCODIGO_BANCO: string;
    FFNOME_BANCO: string;
    FFSIGLA_BANCO: string;
    FFIDorganizacao: string;
    FFINDICE :Integer;
    FFOrganizacao: TOrganizacaoModel;
    procedure SetFCODIGO_BANCO(const Value: string);
    procedure SetFID(const Value: string);
    procedure SetFIDorganizacao(const Value: string);
    procedure SetFNOME_BANCO(const Value: string);
    procedure SetForganizacao(const Value: TOrganizacaoModel);
    procedure SetFSIGLA_BANCO(const Value: string);
    procedure SetFINDICE(const Value: Integer);



  public


    property FID: string                      read FFID             write SetFID;
    property FIDorganizacao: string           read FFIDorganizacao  write SetFIDorganizacao;
    property Forganizacao: TOrganizacaoModel  read FFOrganizacao    write SetForganizacao;
    property FCODIGO_BANCO: string            read FFCODIGO_BANCO   write SetFCODIGO_BANCO;
    property FNOME_BANCO: string              read FFNOME_BANCO     write SetFNOME_BANCO;
    property FSIGLA_BANCO: string             read FFSIGLA_BANCO    write SetFSIGLA_BANCO;
    property FINDICE: Integer                 read FFINDICE         write SetFINDICE;



    constructor Create;
    destructor Destroy; override;


  end;

implementation

{ TBancoModel }

constructor TBancoModel.Create;
begin

end;

destructor TBancoModel.Destroy;
begin

  inherited;
end;

procedure TBancoModel.SetFCODIGO_BANCO(const Value: string);
begin
  FFCODIGO_BANCO := Value;
end;

procedure TBancoModel.SetFID(const Value: string);
begin
  FFID := Value;
end;

procedure TBancoModel.SetFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TBancoModel.SetFINDICE(const Value: Integer);
begin
  FFINDICE := Value;
end;

procedure TBancoModel.SetFNOME_BANCO(const Value: string);
begin
  FFNOME_BANCO := Value;
end;

procedure TBancoModel.SetForganizacao(const Value: TOrganizacaoModel);
begin
  FFOrganizacao := Value;
end;

procedure TBancoModel.SetFSIGLA_BANCO(const Value: string);
begin
  FFSIGLA_BANCO := Value;
end;

end.
