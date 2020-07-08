unit uLotePagamentoModel;

interface
{
CREATE TABLE LOTE_PAGAMENTO (
    ID_LOTE_PAGAMENTO          VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO             VARCHAR(36) NOT NULL,
    ID_USUARIO                 NUMERIC(5,0),
    ID_CONTA_BANCARIA          VARCHAR(36),
    ID_FUNCIONARIO             VARCHAR(36),
    ID_CONTA_BANCARIA_CHEQUE   VARCHAR(36),
    ID_TIPO_OPERACAO_BANCARIA  VARCHAR(36),
    ID_FORMA_PAGAMENTO         VARCHAR(36),
    LOTE                       VARCHAR(30),
    STATUS                     VARCHAR(30),
    DATA_REGISTRO              DATE,
    DATA_PAGAMENTO             DATE NOT NULL,
    QTD_TIT_PAG                NUMERIC(5,0),
    VALOR                      NUMERIC(10,2)
); }

uses
  Windows, Messages, Classes, SysUtils, uContaBancariaModel, uContaBancariaDAO,
  uContaBancariaChequeModel, uContaBancariaChequeDAO, uUsuarioModel, uUsuarioDAO,
  uOrganizacaoModel, //uTituloPagarModel, uTituloPagarDAO,
  uFormaPagamentoModel, uFormaPagamentoDAO, uTipoOperacaoBancariaModel, uTipoOperacaoBancariaDAO;

type
  TLotePagamentoModel = class(TObject)
  private

    FFID: string;
    FFIDorganizacao: string;
    FFIDcontaBancaria :String;
    FFIDcheque:String;
    FFIDTOB :string;
    FFIDformaPagamento :string;
    FFIDResponsavel: string;
    FFIDusuario: Integer;

    FFstatus :string;
    FFlote :string;
    FFdataRegistro: TDateTime;
    FFdataPagamento: TDateTime;
    FFperiodoInicial: TDateTime;
    FFperiodoFinal: TDateTime;
    FFqtdTitPag: Integer;
    FFvalor: Currency;
    FFnovo      : Boolean;


    FFusuario         : TUsuarioModel;
    FFcontaBancaria   : TContaBancariaModel;
    FFcheque          : TContaBancariaChequeModel;
    FFFOrmaPagamento  : TFormaPagamentoModel;
    FFTOB             : TTipoOperacaoBancariaModel;

    procedure SetFcheque(const Value: TContaBancariaChequeModel);
    procedure SetFcontaBancaria(const Value: TContaBancariaModel);
    procedure SetFdataPagamento(const Value: TDateTime);
    procedure SetFdataRegistro(const Value: TDateTime);
    procedure SetFFOrmaPagamento(const Value: TFormaPagamentoModel);
    procedure SetFID(const Value: string);
    procedure SetFIDcheque(const Value: string);
    procedure SetFIDcontaBancaria(const Value: string);
    procedure SetFIDformaPagamento(const Value: string);
    procedure SetFIDorganizacao(const Value: string);
    procedure SetFIDresponsavel(const Value: string);
    procedure SetFIDTOB(const Value: string);
    procedure SetFIDusuario(const Value: Integer);
    procedure SetFlote(const Value: string);
    procedure SetFqtdTitPag(const Value: Integer);
    procedure SetFstatus(const Value: string);
    procedure SetFTOB(const Value: TTipoOperacaoBancariaModel);
    procedure SetFusuario(const Value: TUsuarioModel);
    procedure SetFvalor(const Value: Currency);

    public


    property FID: string read FFID write SetFID;
    property FIDresponsavel: string read FFIDresponsavel write SetFIDresponsavel;
    property FIDorganizacao: string read FFIDorganizacao write SetFIDorganizacao;
    property FIDusuario: Integer read FFIDusuario write SetFIDusuario;
    property FIDcontaBancaria: string read FFIDcontaBancaria write SetFIDcontaBancaria;
    property FIDcheque: string read FFIDcheque write SetFIDcheque;
    property FIDformaPagamento: string read FFIDformaPagamento write SetFIDformaPagamento;
    property FIDTOB: string read FFIDTOB write SetFIDTOB;
    property Fstatus: string read FFstatus write SetFstatus;
    property Flote: string read FFlote write SetFlote;
    property FdataRegistro: TDateTime read FFdataRegistro write SetFdataRegistro;
    property FdataPagamento: TDateTime read FFdataPagamento write SetFdataPagamento;
    property Fvalor: Currency read FFvalor write SetFvalor;
    property FqtdTitPag: Integer read FFqtdTitPag write SetFqtdTitPag;

    property Fusuario         : TUsuarioModel               read FFusuario        write SetFusuario;
    property FcontaBancaria   : TContaBancariaModel         read FFcontaBancaria  write SetFcontaBancaria;
    property Fcheque          : TContaBancariaChequeModel   read FFcheque         write SetFcheque;
    property FFOrmaPagamento  : TFormaPagamentoModel        read FFFOrmaPagamento write SetFFOrmaPagamento;
    property FTOB             : TTipoOperacaoBancariaModel  read FFTOB            write SetFTOB;

     property Fnovo :Boolean        read FFnovo       write FFnovo;

    destructor Destroy; override;
    constructor Create;



  end;


implementation

{ TLotePagamentoModel }

constructor TLotePagamentoModel.Create;
begin
  FFnovo :=True;
end;

destructor TLotePagamentoModel.Destroy;
begin

  inherited;
end;

procedure TLotePagamentoModel.SetFcheque(
  const Value: TContaBancariaChequeModel);
begin
  FFcheque := Value;
end;

procedure TLotePagamentoModel.SetFcontaBancaria(
  const Value: TContaBancariaModel);
begin
  FFcontaBancaria := Value;
end;

procedure TLotePagamentoModel.SetFdataPagamento(const Value: TDateTime);
begin
  FFdataPagamento := Value;
end;

procedure TLotePagamentoModel.SetFdataRegistro(const Value: TDateTime);
begin
  FFdataRegistro := Value;
end;

procedure TLotePagamentoModel.SetFFOrmaPagamento(
  const Value: TFormaPagamentoModel);
begin
  FFFOrmaPagamento := Value;
end;

procedure TLotePagamentoModel.SetFID(const Value: string);
begin
  FFID := Value;
end;

procedure TLotePagamentoModel.SetFIDcheque(const Value: string);
begin
  FFIDcheque := Value;
end;

procedure TLotePagamentoModel.SetFIDcontaBancaria(const Value: string);
begin
  FFIDcontaBancaria := Value;
end;

procedure TLotePagamentoModel.SetFIDformaPagamento(const Value: string);
begin
  FFIDformaPagamento := Value;
end;

procedure TLotePagamentoModel.SetFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TLotePagamentoModel.SetFIDresponsavel(const Value: string);
begin
  FFIDresponsavel := Value;
end;

procedure TLotePagamentoModel.SetFIDTOB(const Value: string);
begin
  FFIDTOB := Value;
end;

procedure TLotePagamentoModel.SetFIDusuario(const Value: Integer);
begin
  FFIDusuario := Value;
end;

procedure TLotePagamentoModel.SetFlote(const Value: string);
begin
  FFlote := Value;
end;

procedure TLotePagamentoModel.SetFqtdTitPag(const Value: Integer);
begin
  FFqtdTitPag := Value;
end;

procedure TLotePagamentoModel.SetFstatus(const Value: string);
begin
  FFstatus := Value;
end;

procedure TLotePagamentoModel.SetFTOB(const Value: TTipoOperacaoBancariaModel);
begin
  FFTOB := Value;
end;

procedure TLotePagamentoModel.SetFusuario(const Value: TUsuarioModel);
begin
  FFusuario := Value;
end;

procedure TLotePagamentoModel.SetFvalor(const Value: Currency);
begin
  FFvalor := Value;
end;

end.
