unit uOrganizacaoModel;


interface
{ table



CREATE TABLE ORGANIZACAO (
    ID_ORGANIZACAO       VARCHAR(36) NOT NULL,
    RAZAO_SOCIAL         VARCHAR(50) NOT NULL,
    SIGLA                VARCHAR(10) NOT NULL,
    FANTASIA             VARCHAR(50),
    CNPJ                 VARCHAR(20) NOT NULL,
    INSCRICAO_ESTADUAL   VARCHAR(20) NOT NULL,
    INSCRICAO_MUNICIPAL  VARCHAR(20) NOT NULL,
    LOGRADOURO           VARCHAR(60),
    COMPLEMENTO          VARCHAR(60),
    NUMERO               VARCHAR(6),
    CEP                  VARCHAR(10),
    ID_ESTADO            VARCHAR(36),
    ID_CIDADE            VARCHAR(36),
    ID_BAIRRO            VARCHAR(36),
    NAMESERVERBD         VARCHAR(60) NOT NULL,
    IPSERVERBD           VARCHAR(60) NOT NULL,
    SISTEMA_CONTABIL     VARCHAR(60),
    SERIAL_HD            VARCHAR(60),
    SERIAL_CLIENTE       VARCHAR(60),
    LICENCA              VARCHAR(60),
    SOCKET_WEB           VARCHAR(60),
    CODIGO_WEB           VARCHAR(60),
    CODINOME             VARCHAR(60),
    HOST_NAME            VARCHAR(60),
    HOST_IP              VARCHAR(60),
    VERSAO               VARCHAR(30),
    DATA_ATUALIZACAO     DATE,
    FLAG_HST             SMALLINT,
    SN1                  VARCHAR(80),
    SN2                  VARCHAR(80),
    SN3                  VARCHAR(80),
    ATIVA                SMALLINT DEFAULT 1
);

}

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

    FFINSCRICAO_ESTADUAL   : string ;
    FFINSCRICAO_MUNICIPAL  : string ;
    FFLOGRADOURO           : string ;
    FFCOMPLEMENTO          : string ;
    FFNUMERO               : string ;
    FFCEP                  : string ;
    FFIDESTADO            : string ;
    FFIDCIDADE            : string ;
    FFIDBAIRRO            : string ;
    FFNAMESERVERBD         : string ;
    FFIPSERVERBD           : string ;
    FFSISTEMA_CONTABIL     : string ;
    FFSERIAL_HD            : string ;
    FFSERIAL_CLIENTE       : string ;
    FFLICENCA              : string ;
    FFSOCKET_WEB           : string ;
    FFCODIGO_WEB           : string ;
    FFCODINOME             : string ;
    FFHOST_NAME            : string ;
    FFHOST_IP              : string ;
    FFSN1                  : string ;
    FFSN2                  : string ;
    FFSN3                  : string ;
    FFDATA_ATUALIZACAO     :TDateTime;
    FFFLAG_HST             :Integer;
    FFATIVA                :Integer;
    FFnovo                 :Boolean;

    procedure SetFFantasia(const Value: string);
    procedure SetFFATIVA(const Value: Integer);
    procedure SetFFCEP(const Value: string);
    procedure SetFFCNPJ(const Value: string);
    procedure SetFFCODIGO_WEB(const Value: string);
    procedure SetFFCODINOME(const Value: string);
    procedure SetFFCOMPLEMENTO(const Value: string);
    procedure SetFFDATA_ATUALIZACAO(const Value: TDateTime);
    procedure SetFFFLAG_HST(const Value: Integer);
    procedure SetFFHOST_IP(const Value: string);
    procedure SetFFHOST_NAME(const Value: string);
    procedure SetFFID(const Value: string);
    procedure SetFFIDBAIRRO(const Value: string);
    procedure SetFFIDCIDADE(const Value: string);
    procedure SetFFIDESTADO(const Value: string);
    procedure SetFFINSCRICAO_ESTADUAL(const Value: string);
    procedure SetFFINSCRICAO_MUNICIPAL(const Value: string);
    procedure SetFFIPSERVERBD(const Value: string);
    procedure SetFFLICENCA(const Value: string);
    procedure SetFFLOGRADOURO(const Value: string);
    procedure SetFFNAMESERVERBD(const Value: string);
    procedure SetFFNUMERO(const Value: string);
    procedure SetFFRazaoSocial(const Value: string);
    procedure SetFFSERIAL_CLIENTE(const Value: string);
    procedure SetFFSERIAL_HD(const Value: string);
    procedure SetFFSigla(const Value: string);
    procedure SetFFSISTEMA_CONTABIL(const Value: string);
    procedure SetFFSN1(const Value: string);
    procedure SetFFSN2(const Value: string);
    procedure SetFFSN3(const Value: string);
    procedure SetFFSOCKET_WEB(const Value: string);
    procedure SetFFVersao(const Value: string);


  public
    // atibutos e métodos públicos
    property FID: string read FFID write SetFFID;
    property FRazaoSocial: string read FFRazaoSocial write SetFFRazaoSocial;
    property FSigla: string read FFSigla write SetFFSigla;
    property FFantasia: string read FFFantasia write SetFFantasia;
    property FCNPJ: string read FFCNPJ write SetFFCNPJ;
    property FVersao: string read FFVersao write SetFFVersao;
    property FINSCRICAO_ESTADUAL   : string  read FFINSCRICAO_ESTADUAL    write SetFFINSCRICAO_ESTADUAL   ;
    property FINSCRICAO_MUNICIPAL  : string  read FFINSCRICAO_MUNICIPAL    write SetFFINSCRICAO_MUNICIPAL   ;
    property FLOGRADOURO           : string  read FFLOGRADOURO    write SetFFLOGRADOURO   ;
    property FCOMPLEMENTO          : string  read FFCOMPLEMENTO    write SetFFCOMPLEMENTO   ;
    property FNUMERO               : string  read FFNUMERO    write SetFFNUMERO   ;
    property FCEP                  : string  read FFCEP    write SetFFCEP   ;
    property FIDESTADO             : string  read FFIDESTADO    write SetFFIDESTADO   ;
    property FIDCIDADE             : string  read FFIDCIDADE    write SetFFIDCIDADE   ;
    property FIDBAIRRO             : string  read FFIDBAIRRO    write SetFFIDBAIRRO   ;
    property FNAMESERVERBD         : string  read FFNAMESERVERBD    write SetFFNAMESERVERBD   ;
    property FIPSERVERBD           : string  read FFIPSERVERBD    write SetFFIPSERVERBD   ;
    property FSISTEMA_CONTABIL     : string  read FFSISTEMA_CONTABIL    write SetFFSISTEMA_CONTABIL   ;
    property FSERIAL_HD            : string  read FFSERIAL_HD    write SetFFSERIAL_HD   ;
    property FSERIAL_CLIENTE       : string  read FFSERIAL_CLIENTE    write SetFFSERIAL_CLIENTE   ;
    property FLICENCA              : string  read FFLICENCA    write SetFFLICENCA   ;
    property FSOCKET_WEB           : string  read FFSOCKET_WEB    write SetFFSOCKET_WEB   ;
    property FCODIGO_WEB           : string  read FFCODIGO_WEB    write SetFFCODIGO_WEB   ;
    property FCODINOME             : string  read FFCODINOME    write SetFFCODINOME   ;
    property FHOST_NAME            : string  read FFHOST_NAME    write SetFFHOST_NAME   ;
    property FHOST_IP              : string  read FFHOST_IP    write SetFFHOST_IP   ;
    property FSN1                  : string  read FFSN1    write SetFFSN1   ;
    property FSN2                  : string  read FFSN2    write SetFFSN2   ;
    property FSN3                  : string  read FFSN3    write SetFFSN3   ;
    property FDATA_ATUALIZACAO     :TDateTime read FFDATA_ATUALIZACAO    write SetFFDATA_ATUALIZACAO   ;
    property FFLAG_HST             :Integer read FFFLAG_HST    write SetFFFLAG_HST   ;
    property FATIVA                :Integer read FFATIVA       write SetFFATIVA   ;
    property Fnovo                 :Boolean read FFnovo        write FFnovo   ;



    constructor Create;
    destructor Destroy; override;

  end;

implementation
{ TOrganizacao }


constructor TOrganizacaoModel.Create;
begin
FFnovo := True;
end;

destructor TOrganizacaoModel.Destroy;
begin
  inherited;
end;


procedure TOrganizacaoModel.SetFFantasia(const Value: string);
begin
  FFFantasia := Value;
end;

procedure TOrganizacaoModel.SetFFATIVA(const Value: Integer);
begin
  FFATIVA := Value;
end;

procedure TOrganizacaoModel.SetFFCEP(const Value: string);
begin
  FFCEP := Value;
end;

procedure TOrganizacaoModel.SetFFCNPJ(const Value: string);
begin
  FFCNPJ := Value;
end;

procedure TOrganizacaoModel.SetFFCODIGO_WEB(const Value: string);
begin
  FFCODIGO_WEB := Value;
end;

procedure TOrganizacaoModel.SetFFCODINOME(const Value: string);
begin
  FFCODINOME := Value;
end;

procedure TOrganizacaoModel.SetFFCOMPLEMENTO(const Value: string);
begin
  FFCOMPLEMENTO := Value;
end;

procedure TOrganizacaoModel.SetFFDATA_ATUALIZACAO(const Value: TDateTime);
begin
  FFDATA_ATUALIZACAO := Value;
end;

procedure TOrganizacaoModel.SetFFFLAG_HST(const Value: Integer);
begin
  FFFLAG_HST := Value;
end;

procedure TOrganizacaoModel.SetFFHOST_IP(const Value: string);
begin
  FFHOST_IP := Value;
end;

procedure TOrganizacaoModel.SetFFHOST_NAME(const Value: string);
begin
  FFHOST_NAME := Value;
end;

procedure TOrganizacaoModel.SetFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TOrganizacaoModel.SetFFIDBAIRRO(const Value: string);
begin
  FFIDBAIRRO := Value;
end;

procedure TOrganizacaoModel.SetFFIDCIDADE(const Value: string);
begin
  FFIDCIDADE := Value;
end;

procedure TOrganizacaoModel.SetFFIDESTADO(const Value: string);
begin
  FFIDESTADO := Value;
end;

procedure TOrganizacaoModel.SetFFINSCRICAO_ESTADUAL(const Value: string);
begin
  FFINSCRICAO_ESTADUAL := Value;
end;

procedure TOrganizacaoModel.SetFFINSCRICAO_MUNICIPAL(const Value: string);
begin
  FFINSCRICAO_MUNICIPAL := Value;
end;

procedure TOrganizacaoModel.SetFFIPSERVERBD(const Value: string);
begin
  FFIPSERVERBD := Value;
end;

procedure TOrganizacaoModel.SetFFLICENCA(const Value: string);
begin
  FFLICENCA := Value;
end;

procedure TOrganizacaoModel.SetFFLOGRADOURO(const Value: string);
begin
  FFLOGRADOURO := Value;
end;

procedure TOrganizacaoModel.SetFFNAMESERVERBD(const Value: string);
begin
  FFNAMESERVERBD := Value;
end;

procedure TOrganizacaoModel.SetFFNUMERO(const Value: string);
begin
  FFNUMERO := Value;
end;

procedure TOrganizacaoModel.SetFFRazaoSocial(const Value: string);
begin
  FFRazaoSocial := Value;
end;

procedure TOrganizacaoModel.SetFFSERIAL_CLIENTE(const Value: string);
begin
  FFSERIAL_CLIENTE := Value;
end;

procedure TOrganizacaoModel.SetFFSERIAL_HD(const Value: string);
begin
  FFSERIAL_HD := Value;
end;

procedure TOrganizacaoModel.SetFFSigla(const Value: string);
begin
  FFSigla := Value;
end;

procedure TOrganizacaoModel.SetFFSISTEMA_CONTABIL(const Value: string);
begin
  FFSISTEMA_CONTABIL := Value;
end;

procedure TOrganizacaoModel.SetFFSN1(const Value: string);
begin
  FFSN1 := Value;
end;

procedure TOrganizacaoModel.SetFFSN2(const Value: string);
begin
  FFSN2 := Value;
end;

procedure TOrganizacaoModel.SetFFSN3(const Value: string);
begin
  FFSN3 := Value;
end;

procedure TOrganizacaoModel.SetFFSOCKET_WEB(const Value: string);
begin
  FFSOCKET_WEB := Value;
end;

procedure TOrganizacaoModel.SetFFVersao(const Value: string);
begin
  FFVersao := Value;
end;

end.
