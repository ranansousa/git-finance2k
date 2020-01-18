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
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel;

type
  TContaBancariaDBModel = class(TObject)
  private
    FFID: string;
    FFOrganizacao: TOrganizacaoModel;
    FFIDorganizacao: string;
    FFIDResponsavel: string;
    FFIDTOB: string;
    FFIDcontaBancaria: string;
    FFIDTP: string; //titulo pagar
    FFIDCheque: string;
    FFIDloteContabil: string;
    FFIDusuario: string;
    FFtipoLancamento: string;
    FFobservacao: string;
    FFdescricao: string;
    FFidentificacao: string;
    FFvalor: Currency;
    FFdataRegistro: TDateTime;
    FFdataMovimento: TDateTime;


    function getFFdataMovimento: TDateTime;
    function getFFdataRegistro: TDateTime;
    function getFFdescricao: string;
    function getFFID: string;
    function getFFIDCheque: string;
    function getFFIDcontaBancaria: string;
    function getFFidentificacao: string;
    function getFFIDloteContabil: string;
    function getFFIDorganizacao: string;
    function getFFIDResponsavel: string;
    function getFFIDTOB: string;
    function getFFIDTP: string;
    function getFFIDusuario: string;
    function getFFobservacao: string;
    function getFFOrganizacao: TOrganizacaoModel;
    function getFFvalor: Currency;

    procedure SetFdataMovimento(const Value: TDateTime);
    procedure SetFdataRegistro(const Value: TDateTime);
    procedure SetFdescricao(const Value: string);
    procedure SetFID(const Value: string);
    procedure SetFIDCheque(const Value: string);
    procedure SetFIDcontaBancaria(const Value: string);
    procedure SetFidentificacao(const Value: string);
    procedure SetFIDloteContabil(const Value: string);
    procedure SetFIDorganizacao(const Value: string);
    procedure SetFIDResponsavel(const Value: string);
    procedure SetFIDTOB(const Value: string);
    procedure SetFIDTP(const Value: string);
    procedure SetFIDusuario(const Value: string);
    procedure SetFobservacao(const Value: string);
    procedure SetForganizacao(const Value: TOrganizacaoModel);
    procedure SetFtipoLancamento(const Value: string);
    procedure SetFvalor(const Value: Currency);
    function getFFtipoLancamento: string;



  public

    property FID: string read getFFID write SetFID;
    property FIDorganizacao: string read getFFIDorganizacao write SetFIDorganizacao;
    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetForganizacao;
    property FIDusuario: string read getFFIDusuario write SetFIDusuario;
    property FIDResponsavel: string read getFFIDResponsavel write SetFIDResponsavel;
    property FIDTOB: string read getFFIDTOB write SetFIDTOB;
    property FIDcontaBancaria: string read getFFIDcontaBancaria write SetFIDcontaBancaria;
    property FIDTP: string read getFFIDTP write SetFIDTP;
    property FIDCheque: string read getFFIDCheque write SetFIDCheque;
    property FIDloteContabil: string read getFFIDloteContabil write SetFIDloteContabil;
    property FtipoLancamento: string read getFFtipoLancamento write SetFtipoLancamento;
    property Fdescricao: string read getFFdescricao write SetFdescricao;
    property Fobservacao: string read getFFobservacao write SetFobservacao;
    property Fidentificacao: string read getFFidentificacao write SetFidentificacao;
    property Fvalor: Currency read getFFvalor write SetFvalor;
    property FdataRegistro: TDateTime read getFFdataRegistro write SetFdataRegistro;
    property FdataMovimento: TDateTime read getFFdataMovimento write SetFdataMovimento;



      Constructor Create;

  end;

implementation

{ TContaBancariaDBModel }

constructor TContaBancariaDBModel.Create;
begin

end;

function TContaBancariaDBModel.getFFdataMovimento: TDateTime;
begin

end;

function TContaBancariaDBModel.getFFdataRegistro: TDateTime;
begin

end;

function TContaBancariaDBModel.getFFdescricao: string;
begin

end;

function TContaBancariaDBModel.getFFID: string;
begin

end;

function TContaBancariaDBModel.getFFIDCheque: string;
begin

end;

function TContaBancariaDBModel.getFFIDcontaBancaria: string;
begin

end;

function TContaBancariaDBModel.getFFidentificacao: string;
begin

end;

function TContaBancariaDBModel.getFFIDloteContabil: string;
begin

end;

function TContaBancariaDBModel.getFFIDorganizacao: string;
begin

end;

function TContaBancariaDBModel.getFFIDResponsavel: string;
begin

end;

function TContaBancariaDBModel.getFFIDTOB: string;
begin

end;

function TContaBancariaDBModel.getFFIDTP: string;
begin

end;

function TContaBancariaDBModel.getFFIDusuario: string;
begin

end;

function TContaBancariaDBModel.getFFobservacao: string;
begin

end;

function TContaBancariaDBModel.getFFOrganizacao: TOrganizacaoModel;
begin

end;

function TContaBancariaDBModel.getFFtipoLancamento: string;
begin

end;

function TContaBancariaDBModel.getFFvalor: Currency;
begin

end;

procedure TContaBancariaDBModel.SetFdataMovimento(const Value: TDateTime);
begin

end;

procedure TContaBancariaDBModel.SetFdataRegistro(const Value: TDateTime);
begin

end;

procedure TContaBancariaDBModel.SetFdescricao(const Value: string);
begin

end;

procedure TContaBancariaDBModel.SetFID(const Value: string);
begin

end;

procedure TContaBancariaDBModel.SetFIDCheque(const Value: string);
begin

end;

procedure TContaBancariaDBModel.SetFIDcontaBancaria(const Value: string);
begin

end;

procedure TContaBancariaDBModel.SetFidentificacao(const Value: string);
begin

end;

procedure TContaBancariaDBModel.SetFIDloteContabil(const Value: string);
begin

end;

procedure TContaBancariaDBModel.SetFIDorganizacao(const Value: string);
begin

end;

procedure TContaBancariaDBModel.SetFIDResponsavel(const Value: string);
begin

end;

procedure TContaBancariaDBModel.SetFIDTOB(const Value: string);
begin

end;

procedure TContaBancariaDBModel.SetFIDTP(const Value: string);
begin

end;

procedure TContaBancariaDBModel.SetFIDusuario(const Value: string);
begin

end;

procedure TContaBancariaDBModel.SetFobservacao(const Value: string);
begin

end;

procedure TContaBancariaDBModel.SetForganizacao(const Value: TOrganizacaoModel);
begin

end;

procedure TContaBancariaDBModel.SetFtipoLancamento(const Value: string);
begin
  FtipoLancamento := Value;
end;

procedure TContaBancariaDBModel.SetFvalor(const Value: Currency);
begin

end;

end.
