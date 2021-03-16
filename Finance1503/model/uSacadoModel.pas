unit uSacadoModel;

interface
{

CREATE TABLE SACADO (
    ID_SACADO                VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO           VARCHAR(36) NOT NULL,
    ID_TIPO_SACADO           VARCHAR(36),
    ID_ENDERECO              VARCHAR(36),
    ID_CONTATO               VARCHAR(36),
    ID_BANCO                 VARCHAR(36),
    ID_CONTA_CONTABIL        VARCHAR(36),

    NOME                     VARCHAR(80) NOT NULL,
    CPFCNPJ                  VARCHAR(20) NOT NULL,
    PERSONALIDADE            VARCHAR(2) NOT NULL,
    STATUS                   VARCHAR(20),
    CODIGO_CEDENTE           VARCHAR(36),
    CONTA_BANCARIA           VARCHAR(20),
    AGENCIA                  VARCHAR(10),
    INSCRICAO_ESTADUAL       VARCHAR(36),

    DATA_REGISTRO            TIMESTAMP,
    DATA_ULTIMA_ATUALIZACAO  TIMESTAMP,
    CODIGO                   VARCHAR(10)

    }

uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel, uTipoSacadoModel,
  uBancoModel, uContaContabilModel, uEnderecoModel, uContatoModel;



type
  TSacadoModel = class(TObject)
  private

    FFID: string;
    FFcodigo :string;
    FFstatus :string;
    FFIDtipoSacado: string;
    FFIDorganizacao :string;
    FFIDendereco: string;
    FFIDcontato: string;
    FFIDbanco: string;
    FFIDcontaContabil: string;

    FFnome: string;
    FFcpfCnpj: string;
    FFinscricaoEstadual: string;
    FFpersonalidade: string;
    FFcontaBancaria: string;
    FFagenciaBancaria: string;

    FFdataRegistro: TDateTime;
    FFdataUltimaAtualizacao: TDateTime;

    FForganizacao     : TOrganizacaoModel;
    FFtipoSacado      : TTipoSacadoModel;
    FFendereco        : TEnderecoModel;
    FFcontato         : TContatoModel;
    FFbanco           : TBancoModel;
    FFcontaContabil   : TContaContabilModel;
    FFnovo      : Boolean;
    procedure SetFCodigo(const Value: string);
    procedure SetFcpfCnpj(const Value: string);
    procedure SetFDataRegistro(const Value: TDateTime);
    procedure SetFDataUltimaAtualizacao(const Value: TDateTime);
    procedure SetFFagenciaBancaria(const Value: string);
    procedure SetFFbanco(const Value: TBancoModel);
    procedure SetFFcontaBancaria(const Value: string);
    procedure SetFFcontaContabil(const Value: TContaContabilModel);
    procedure SetFFcontato(const Value: TContatoModel);
    procedure SetFFendereco(const Value: TEnderecoModel);
    procedure SetFFtipoSacado(const Value: TTipoSacadoModel);
    procedure SetFID(const Value: string);
    procedure SetFIDbanco(const Value: string);
    procedure SetFIDcontaContabil(const Value: string);
    procedure SetFIDcontato(const Value: string);
    procedure SetFIDendereco(const Value: string);
    procedure SetFIDorganizacao(const Value: string);
    procedure SetFIDtipoSacado(const Value: string);
    procedure SetFinscricaoEstadual(const Value: string);
    procedure SetFnome(const Value: string);
    procedure SetForganizacao(const Value: TOrganizacaoModel);
    procedure SetFpersonalidade(const Value: string);
    procedure SetFStatus(const Value: string);


  public

    property FDataRegistro: TDateTime read FFDataRegistro write SetFDataRegistro;
    property FDataUltimaAtualizacao: TDateTime read FFDataUltimaAtualizacao write SetFDataUltimaAtualizacao;

    property FIDtipoSacado: string read FFIDtipoSacado write SetFIDtipoSacado;
    property FCodigo: string read FFCodigo write SetFCodigo;
    property FStatus: string read FFStatus write SetFStatus;

    property FID: string read FFID write SetFID;
    property FIDorganizacao: string read FFIDorganizacao write SetFIDorganizacao;

    property FinscricaoEstadual: string read FFinscricaoEstadual write SetFinscricaoEstadual;
    property FIDcontaContabil: string read FFIDcontaContabil write SetFIDcontaContabil;
    property Fpersonalidade: string read FFpersonalidade write SetFpersonalidade;
    property FIDendereco: string read FFIDendereco write SetFIDendereco;
    property FIDcontato: string read FFIDcontato write SetFIDcontato;
    property FcpfCnpj: string read FFcpfCnpj write SetFcpfCnpj;
    property Fnome: string read FFnome write SetFnome;
    property FcontaBancaria: string read FFcontaBancaria write SetFFcontaBancaria;
    property FagenciaBancaria: string read FFagenciaBancaria write SetFFagenciaBancaria;
    property FIDbanco: string read FFIDbanco write SetFIDbanco;


    property FcontaContabil: TContaContabilModel read FFcontaContabil write SetFFcontaContabil;
    property Forganizacao: TOrganizacaoModel read FForganizacao write SetForganizacao;
    property FtipoSacado: TTipoSacadoModel read FFtipoSacado write SetFFtipoSacado;
    property Fendereco: TEnderecoModel read FFendereco write SetFFendereco;
    property Fcontato: TContatoModel read FFcontato write SetFFcontato;
    property Fbanco: TBancoModel read FFbanco write SetFFbanco;

    property Fnovo: Boolean read FFnovo write FFnovo; //define se � novo ou j� existe.

    constructor Create;

  end;


implementation


{ TSacadoModel }

constructor TSacadoModel.Create;
begin
FFnovo := True;
end;

procedure TSacadoModel.SetFCodigo(const Value: string);
begin
  FFCodigo := Value;
end;

procedure TSacadoModel.SetFcpfCnpj(const Value: string);
begin
  FFcpfCnpj := Value;
end;

procedure TSacadoModel.SetFDataRegistro(const Value: TDateTime);
begin
  FFDataRegistro := Value;
end;

procedure TSacadoModel.SetFDataUltimaAtualizacao(const Value: TDateTime);
begin
  FFDataUltimaAtualizacao := Value;
end;

procedure TSacadoModel.SetFFagenciaBancaria(const Value: string);
begin
  FFagenciaBancaria := Value;
end;

procedure TSacadoModel.SetFFbanco(const Value: TBancoModel);
begin
  FFbanco := Value;
end;

procedure TSacadoModel.SetFFcontaBancaria(const Value: string);
begin
  FFcontaBancaria := Value;
end;

procedure TSacadoModel.SetFFcontaContabil(const Value: TContaContabilModel);
begin
  FFcontaContabil := Value;
end;

procedure TSacadoModel.SetFFcontato(const Value: TContatoModel);
begin
  FFcontato := Value;
end;

procedure TSacadoModel.SetFFendereco(const Value: TEnderecoModel);
begin
  FFendereco := Value;
end;

procedure TSacadoModel.SetFFtipoSacado(const Value: TTipoSacadoModel);
begin
  FFtipoSacado := Value;
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
  FFIDorganizacao := Value;
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
  FForganizacao := Value;
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
