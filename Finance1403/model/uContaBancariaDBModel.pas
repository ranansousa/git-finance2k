unit uContaBancariaDBModel;


interface
{
 TABLE


CREATE TABLE CONTA_BANCARIA_DEBITO (
    ID_CONTA_BANCARIA_DEBITO       VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO                 VARCHAR(36) NOT NULL,
    ID_CONTA_BANCARIA              VARCHAR(36),
    ID_TIPO_OPERACAO_BANCARIA      VARCHAR(36),
    ID_RESPONSAVEL                 VARCHAR(36),
    ID_TITULO_PAGAR                VARCHAR(36),
    ID_CONTA_BANCARIA_CHEQUE       VARCHAR(36),
    ID_LOTE_CONTABIL               VARCHAR(36),
    ID_USUARIO                     NUMERIC(5,0),
    TIPO_LANCAMENTO                VARCHAR(1) NOT NULL,
    OBSERVACAO                     VARCHAR(250),
    DESCRICAO                      VARCHAR(150),
    VALOR                          NUMERIC(10,2) NOT NULL,
    DATA_REGISTRO                  DATE NOT NULL,
    DATA_MOVIMENTO                 DATE NOT NULL,
    IDENTIFICACAO                  VARCHAR(36)

);



);   }

uses
  Windows, Messages, Classes, SysUtils,uContaBancariaChequeModel,uContaBancariaModel,uLoteContabilModel,uFuncionarioModel,
  uTipoOperacaoBancariaModel,uUsuarioModel, uOrganizacaoModel ;

type
  TContaBancariaDBModel = class(TObject)
  private
    FFID: string;
    FFIDorganizacao: string;
    FFIDResponsavel: string;
    FFIDTOB: string;
    FFIDcontaBancaria: string;
    FFIDTP: string; //titulo pagar
    FFIDCheque: string;
    FFIDloteContabil: string;
    FFIDusuario: Integer;
    FFtipoLancamento: string;
    FFobservacao: string;
    FFdescricao: string;
    FFidentificacao: string;
    FFvalor: Currency;
    FFdataRegistro: TDateTime;
    FFdataMovimento: TDateTime;
    FFnovo : Boolean;

   //Objetos
       FFOrganizacao      : TOrganizacaoModel;
       FFcontaBancaria    : TContaBancariaModel;
       FFtipoOperacao     : TTipoOperacaoBancariaModel;
       FFresponsavel      : TFuncionarioModel;
   //    FFtituloPagar      : TTituloPagarModel;
       FFcheque           : TContaBancariaChequeModel;
       FFloteContabil     : TLoteContabilModel;
       FFusuario          : TUsuarioModel;


    procedure SetFdataMovimento(const Value: TDateTime);
    procedure SetFdataRegistro(const Value: TDateTime);
    procedure SetFdescricao(const Value: string);
    procedure SetFFcheque(const Value: TContaBancariaChequeModel);
    procedure SetFFcontaBancaria(const Value: TContaBancariaModel);
    procedure SetFFloteContabil(const Value: TLoteContabilModel);
    procedure SetFFresponsavel(const Value: TFuncionarioModel);
    procedure SetFFtipoOperacao(const Value: TTipoOperacaoBancariaModel);
    procedure SetFFusuario(const Value: TUsuarioModel);
    procedure SetFID(const Value: string);
    procedure SetFIDCheque(const Value: string);
    procedure SetFIDcontaBancaria(const Value: string);
    procedure SetFidentificacao(const Value: string);
    procedure SetFIDloteContabil(const Value: string);
    procedure SetFIDorganizacao(const Value: string);
    procedure SetFIDResponsavel(const Value: string);
    procedure SetFIDTOB(const Value: string);
    procedure SetFIDTP(const Value: string);
    procedure SetFIDusuario(const Value: Integer);
    procedure SetFobservacao(const Value: string);
    procedure SetForganizacao(const Value: TOrganizacaoModel);
    procedure SetFtipoLancamento(const Value: string);
    procedure SetFvalor(const Value: Currency);


  public

    property FID: string read FFID write SetFID;
    property FIDorganizacao: string read FFIDorganizacao write SetFIDorganizacao;
    property FIDusuario: Integer read FFIDusuario write SetFIDusuario;
    property FIDResponsavel: string read FFIDResponsavel write SetFIDResponsavel;
    property FIDTOB: string read FFIDTOB write SetFIDTOB;
    property FIDcontaBancaria: string read FFIDcontaBancaria write SetFIDcontaBancaria;

    property FIDTP: string read FFIDTP write SetFIDTP;


    property FIDCheque: string read FFIDCheque write SetFIDCheque;
    property FIDloteContabil: string read FFIDloteContabil write SetFIDloteContabil;
    property FtipoLancamento: string read FFtipoLancamento write SetFtipoLancamento;
    property Fdescricao: string read FFdescricao write SetFdescricao;
    property Fobservacao: string read FFobservacao write SetFobservacao;
    property Fidentificacao: string read FFidentificacao write SetFidentificacao;
    property Fvalor: Currency read FFvalor write SetFvalor;
    property FdataRegistro: TDateTime read FFdataRegistro write SetFdataRegistro;
    property FdataMovimento: TDateTime read FFdataMovimento write SetFdataMovimento;
     property Fnovo :Boolean                         read FFnovo                write FFnovo;

     //Objetos
       property Forganizacao      : TOrganizacaoModel read FFOrganizacao write SetForganizacao;
       property FcontaBancaria    : TContaBancariaModel  read FFcontaBancaria   write   SetFFcontaBancaria  ;
       property FtipoOperacao     : TTipoOperacaoBancariaModel  read FFtipoOperacao   write   SetFFtipoOperacao  ;
       property Fresponsavel      : TFuncionarioModel  read FFresponsavel   write   SetFFresponsavel  ;
     //  property FtituloPagar      : TTituloPagarModel  read FFtituloPagar   write   SetFFtituloPagar  ;
       property Fcheque           : TContaBancariaChequeModel  read FFcheque   write   SetFFcheque  ;
       property FloteContabil     : TLoteContabilModel  read FFloteContabil   write   SetFFloteContabil  ;
       property Fusuario          : TUsuarioModel  read FFusuario   write   SetFFusuario  ;

    constructor Create;
    destructor Destroy; override;

  end;

implementation

{ TContaBancariaDBModel }


constructor TContaBancariaDBModel.Create;
begin
FFnovo := True;
end;

destructor TContaBancariaDBModel.Destroy;
begin

  inherited;
end;

procedure TContaBancariaDBModel.SetFdataMovimento(const Value: TDateTime);
begin
  FFdataMovimento := Value;
end;

procedure TContaBancariaDBModel.SetFdataRegistro(const Value: TDateTime);
begin
  FFdataRegistro := Value;
end;

procedure TContaBancariaDBModel.SetFdescricao(const Value: string);
begin
  FFdescricao := Value;
end;

procedure TContaBancariaDBModel.SetFFcheque(
  const Value: TContaBancariaChequeModel);
begin
  FFcheque := Value;
end;

procedure TContaBancariaDBModel.SetFFcontaBancaria(
  const Value: TContaBancariaModel);
begin
  FFcontaBancaria := Value;
end;

procedure TContaBancariaDBModel.SetFFloteContabil(
  const Value: TLoteContabilModel);
begin
  FFloteContabil := Value;
end;

procedure TContaBancariaDBModel.SetFFresponsavel(
  const Value: TFuncionarioModel);
begin
  FFresponsavel := Value;
end;

procedure TContaBancariaDBModel.SetFFtipoOperacao(
  const Value: TTipoOperacaoBancariaModel);
begin
  FFtipoOperacao := Value;
end;


procedure TContaBancariaDBModel.SetFFusuario(const Value: TUsuarioModel);
begin
  FFusuario := Value;
end;

procedure TContaBancariaDBModel.SetFID(const Value: string);
begin
  FFID := Value;
end;

procedure TContaBancariaDBModel.SetFIDCheque(const Value: string);
begin
  FFIDCheque := Value;
end;

procedure TContaBancariaDBModel.SetFIDcontaBancaria(const Value: string);
begin
  FFIDcontaBancaria := Value;
end;

procedure TContaBancariaDBModel.SetFidentificacao(const Value: string);
begin
  FFidentificacao := Value;
end;

procedure TContaBancariaDBModel.SetFIDloteContabil(const Value: string);
begin
  FFIDloteContabil := Value;
end;

procedure TContaBancariaDBModel.SetFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TContaBancariaDBModel.SetFIDResponsavel(const Value: string);
begin
  FFIDResponsavel := Value;
end;

procedure TContaBancariaDBModel.SetFIDTOB(const Value: string);
begin
  FFIDTOB := Value;
end;

procedure TContaBancariaDBModel.SetFIDTP(const Value: string);
begin
  FFIDTP := Value;
end;

procedure TContaBancariaDBModel.SetFIDusuario(const Value: Integer);
begin
  FFIDusuario := Value;
end;

procedure TContaBancariaDBModel.SetFobservacao(const Value: string);
begin
  FFobservacao := Value;
end;

procedure TContaBancariaDBModel.SetForganizacao(const Value: TOrganizacaoModel);
begin
  FFOrganizacao := Value;
end;

procedure TContaBancariaDBModel.SetFtipoLancamento(const Value: string);
begin
  FFtipoLancamento := Value;
end;

procedure TContaBancariaDBModel.SetFvalor(const Value: Currency);
begin
  FFvalor := Value;
end;

end.
