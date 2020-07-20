unit uTesourariaCRModel;

interface
{
CREATE TABLE TESOURARIA_CREDITO (
    ID_TESOURARIA_CREDITO           VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO                  VARCHAR(36) NOT NULL,
    ID_HISTORICO                    VARCHAR(36),
    ID_RESPONSAVEL                  VARCHAR(36),
    ID_SACADO                       VARCHAR(36),
    ID_TITULO_RECEBER_BAIXA_CHEQUE  VARCHAR(36),
    ID_TITULO_RECEBER_BAIXA         VARCHAR(36),
    ID_USUARIO                      NUMERIC(5,0),
    ID_LOTE_CONTABIL                VARCHAR(36),
    ID_CONTA_BANCARIA_DEBITO        VARCHAR(36)


    DATA_REGISTRO                   DATE,
    DATA_CONTABIL                   DATE,
    DATA_MOVIMENTO                  DATE NOT NULL,
    VALOR_NOMINAL                   NUMERIC(10,2) NOT NULL,

    OBSERVACAO                      VARCHAR(200),
    NUMERO_DOCUMENTO                VARCHAR(40),
    DESCRICAO                       VARCHAR(120),
    TIPO_LANCAMENTO                 VARCHAR(1) NOT NULL

);

}



uses
  Windows, Messages, Classes, SysUtils,uContaBancariaDBModel, uHistoricoModel,System.Generics.Collections,
   uFuncionarioModel, uLocalPagamentoModel, uTRBaixaChequeModel,uSacadoModel,
   uLoteContabilModel,uUsuarioModel,uTRBaixaModel, uOrganizacaoModel;

type
  TTesourariaCRModel = class(TObject)
  private

    FFID: string;
    FFIDorganizacao: string;
    FFIDhistorico: string;
    FFIDresponsavel: string;
    FFIDsacado: string;
    FFIDTRB: string; //ID_TITULO_RECEBER_BAIXA
    FFIDusuario: Integer;
    FFIDloteContabil: string;
    FFIDcheque :string; // ID_TITULO_RECEBER_BAIXA_CHEQUE
    FFIDloteDeposito: string;
    FFIDContaBancariaDebito: string;
    FFnumeroDocumento: string;
    FFdescricao: string;
    FFobservacao: string;
    FFtipoLancamento: string;
    FFvalorNominal: Currency;
    FFdataRegistro: TDateTime;
    FFdataContabil: TDateTime;
    FFdataMovimento: TDateTime;
    FFnovo      : Boolean;


    //objetos
     FFOrganizacao          : TOrganizacaoModel;
     FFHistorico            : THistoricoModel;
     FFSacado               : TSacadoModel;
     FFResponsavel          : TFuncionarioModel;
     FFCheque               : TTRBaixaChequeModel;
     FFTituloReceberBaixa   : TTRBaixaModel;
     FFLoteContabil         : TLoteContabilModel;
     FFUsuario              : TUsuarioModel;
     FFContaBancariaDebito  : TContaBancariaDBModel;

    procedure SetFFContaBancariaDebito(const Value: TContaBancariaDBModel);
    procedure SetFFdataContabil(const Value: TDateTime);
    procedure SetFFdataMovimento(const Value: TDateTime);
    procedure SetFFdataRegistro(const Value: TDateTime);
    procedure SetFFdescricao(const Value: string);
    procedure SetFFHistorico(const Value: THistoricoModel);
    procedure SetFFID(const Value: string);
    procedure SetFFIDHistorico(const Value: string);
    procedure SetFFIDLoteContabil(const Value: string);
    procedure SetFFIDorganizacao(const Value: string);
    procedure SetFFIDResponsavel(const Value: string);
    procedure SetFFIDSacado(const Value: string);
    procedure SetFFIDTRB(const Value: string);
    procedure SetFFLoteContabil(const Value: TLoteContabilModel);
    procedure SetFFnumeroDocumento(const Value: string);
    procedure SetFFobservacao(const Value: string);
    procedure SetFForganizacao(const Value: TOrganizacaoModel);
    procedure SetFFResponsavel(const Value: TFuncionarioModel);
    procedure SetFFSacado(const Value: TSacadoModel);
    procedure SetFFtipoLancamento(const Value: string);
    procedure SetFFTituloReceberBaixa(const Value: TTRBaixaModel);
    procedure SetFFUsuario(const Value: TUsuarioModel);
    procedure SetFFvalorNominal(const Value: currency);
    procedure SetFIDContaBancariaDebito(const Value: string);
    procedure SetFFIDcheque(const Value: string);
    procedure SetFFCheque(const Value: TTRBaixaChequeModel);
    procedure SetFFIDUsuario(const Value: Integer);

     //cole�oes
    // exemplo FListaFormasPagto: TObjectList<TTRBaixaFPModel>; //rateio de formas

  public

    property FID: string read FFID write SetFFID;
    property FIDorganizacao: string read FFIDorganizacao write SetFFIDorganizacao;
    property FIDHistorico: string read FFIDHistorico write SetFFIDHistorico;
    property FIDResponsavel: string read FFIDResponsavel write SetFFIDResponsavel;
    property FIDUsuario: Integer read FFIDUsuario write SetFFIDUsuario;
    property FIDSacado: string read FFIDSacado write SetFFIDSacado;
    property FIDTRB: string read FFIDTRB write SetFFIDTRB;
    property FIDcheque :string read FFIDcheque write SetFFIDcheque;
    property FIDLoteContabil: string read FFIDLoteContabil write SetFFIDLoteContabil;
    property FIDcontaBancariaDebito: string read FFIDContaBancariaDebito write SetFIDContaBancariaDebito;
    property FnumeroDocumento: string read FFnumeroDocumento write SetFFnumeroDocumento;
    property Fdescricao: string read FFdescricao write SetFFdescricao;
    property FtipoLancamento: string read FFtipoLancamento write SetFFtipoLancamento;
    property Fobservacao: string read FFobservacao write SetFFobservacao;
    property FdataRegistro: TDateTime read FFdataRegistro write SetFFdataRegistro;
    property FdataContabil: TDateTime read FFdataContabil write SetFFdataContabil;
    property FdataMovimento: TDateTime read FFdataMovimento write SetFFdataMovimento;
    property FvalorNominal: currency read FFvalorNominal write SetFFvalorNominal;

 //objetos
    property Forganizacao: TOrganizacaoModel read FFOrganizacao write SetFForganizacao;
    property FHistorico: THistoricoModel read FFHistorico write SetFFHistorico;
    property FSacado: TSacadoModel read FFSacado write SetFFSacado;
    property FResponsavel: TFuncionarioModel read FFResponsavel write SetFFResponsavel;
    property FLoteContabil: TLoteContabilModel read FFLoteContabil write SetFFLoteContabil;
    property FUsuario: TUsuarioModel read FFUsuario write SetFFUsuario;
    property FTituloReceberBaixa: TTRBaixaModel read FFTituloReceberBaixa write SetFFTituloReceberBaixa;
    property FContaBancariaDebito : TContaBancariaDBModel read FFContaBancariaDebito write SetFFContaBancariaDebito;
    property FCheque : TTRBaixaChequeModel read FFCheque write SetFFCheque;


    property Fnovo :Boolean        read FFnovo       write FFnovo;

    constructor Create;
    destructor Destroy; override;


  end;

implementation

{ TTesourariaCRModel }

constructor TTesourariaCRModel.Create;
begin
FFnovo := True;
end;

destructor TTesourariaCRModel.Destroy;
begin

  inherited;
end;


procedure TTesourariaCRModel.SetFFCheque(const Value: TTRBaixaChequeModel);
begin
  FFCheque := Value;
end;

procedure TTesourariaCRModel.SetFFContaBancariaDebito(
  const Value: TContaBancariaDBModel);
begin
  FFContaBancariaDebito := Value;
end;

procedure TTesourariaCRModel.SetFFdataContabil(const Value: TDateTime);
begin
  FFdataContabil := Value;
end;

procedure TTesourariaCRModel.SetFFdataMovimento(const Value: TDateTime);
begin
  FFdataMovimento := Value;
end;

procedure TTesourariaCRModel.SetFFdataRegistro(const Value: TDateTime);
begin
  FFdataRegistro := Value;
end;

procedure TTesourariaCRModel.SetFFdescricao(const Value: string);
begin
  FFdescricao := Value;
end;

procedure TTesourariaCRModel.SetFFHistorico(const Value: THistoricoModel);
begin
  FFHistorico := Value;
end;

procedure TTesourariaCRModel.SetFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTesourariaCRModel.SetFFIDcheque(const Value: string);
begin
  FFIDcheque := Value;
end;

procedure TTesourariaCRModel.SetFFIDHistorico(const Value: string);
begin
  FFIDHistorico := Value;
end;

procedure TTesourariaCRModel.SetFFIDLoteContabil(const Value: string);
begin
  FFIDLoteContabil := Value;
end;

procedure TTesourariaCRModel.SetFFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TTesourariaCRModel.SetFFIDResponsavel(const Value: string);
begin
  FFIDResponsavel := Value;
end;

procedure TTesourariaCRModel.SetFFIDSacado(const Value: string);
begin
  FFIDSacado := Value;
end;

procedure TTesourariaCRModel.SetFFIDTRB(const Value: string);
begin
  FFIDTRB := Value;
end;

procedure TTesourariaCRModel.SetFFIDUsuario(const Value: Integer);
begin
  FFIDUsuario := Value;
end;

procedure TTesourariaCRModel.SetFFLoteContabil(const Value: TLoteContabilModel);
begin
  FFLoteContabil := Value;
end;

procedure TTesourariaCRModel.SetFFnumeroDocumento(const Value: string);
begin
  FFnumeroDocumento := Value;
end;

procedure TTesourariaCRModel.SetFFobservacao(const Value: string);
begin
  FFobservacao := Value;
end;

procedure TTesourariaCRModel.SetFForganizacao(const Value: TOrganizacaoModel);
begin
  FFOrganizacao := Value;
end;

procedure TTesourariaCRModel.SetFFResponsavel(const Value: TFuncionarioModel);
begin
  FFResponsavel := Value;
end;

procedure TTesourariaCRModel.SetFFSacado(const Value: TSacadoModel);
begin
  FFSacado := Value;
end;

procedure TTesourariaCRModel.SetFFtipoLancamento(const Value: string);
begin
  FFtipoLancamento := Value;
end;

procedure TTesourariaCRModel.SetFFTituloReceberBaixa(
  const Value: TTRBaixaModel);
begin
  FFTituloReceberBaixa := Value;
end;

procedure TTesourariaCRModel.SetFFUsuario(const Value: TUsuarioModel);
begin
  FFUsuario := Value;
end;

procedure TTesourariaCRModel.SetFFvalorNominal(const Value: currency);
begin
  FFvalorNominal := Value;
end;

procedure TTesourariaCRModel.SetFIDContaBancariaDebito(const Value: string);
begin
  FFIDContaBancariaDebito := Value;
end;

end.
