unit uLancamentoCreditoModel;

interface

uses
  Windows, Messages, Classes, SysUtils, TypInfo;

type
  TLancamentoCreditoModel = class(TObject)
  private
    FFilial: Integer;      //ok
    FIdEmpresa: Integer;  //ok
    FAno: string; //ok
    FLote: Integer;
    FValor: Currency;     //ok

    FContaCredito: string;
    FDgContaCredito: string;
    FCodReduzCre: Integer;
    FDgCodReduzCre: string;

    FIdRegistroFinance: string;
    FRegistroProvisao: string;

    FExecTrigger: string;
    FIdLancamento: Integer;  //ok
    FLinha: Integer;
    FCentroCusto: Integer;
    FIdOrganizacao: string;
    FCodHistorico: Integer;
    FComplemento: string;
    FHistorico: string;
    FTipo: string;
    FData: TDateTime;
    FDataLanc: TDateTime;
    FFncIdentificacao: string;



  public

    procedure SetRegistroFinance(const Value: string);
    procedure SetRegistroProvisao(const Value: string);
    procedure SetHistorico(const Value: string);
    procedure SetAno(const Value: string);
    procedure SetFncIdentificacao(const value: string);
    procedure SetCentroCusto(const Value: Integer);
    procedure SetCodHistorico(const Value: Integer);
    procedure SetCodReduzCre(const Value: Integer);
    procedure SetComplemento(const Value: string);
    procedure SetContaCredito(const Value: string);
    procedure SetData(const Value: TDateTime);
    procedure SetDataLanc(const Value: TDateTime);
    procedure SetDgCodReduzCre(const Value: string);
    procedure SetDgContaCredito(const Value: string);
    procedure SetExecTrigger(const Value: string);
    procedure SetFilial(const Value: Integer);
    procedure SetIdEmpresa(const Value: Integer);
    procedure SetIdLancamento(const Value: Integer);
    procedure SetIdOrganizacao(const Value: string);
    procedure SetIdRegistroFinance(const Value: string);
    procedure SetLinha(const Value: Integer);
    procedure SetLote(const Value: Integer);
    procedure SetTipo(const Value: string);
    procedure SetValor(const Value: Currency);


    property Historico: string read FHistorico write SetHistorico;
   // property IdFinance: string read FIdRegistroFinance write SetRegistroFinance;
    property FncIdentificacao: string read FFncIdentificacao write SetFncIdentificacao;
    property DataLanc: TDateTime read FDataLanc write SetDataLanc;
    property Data: TDateTime read FData write SetData;

    property Linha: Integer read FLinha write SetLinha;
    property Complemento: string read FComplemento write SetComplemento;
    property CodHistorico: Integer read FCodHistorico write SetCodHistorico;
    property Tipo: string read FTipo write SetTipo;
    property DgCodReduzCre: string read FDgCodReduzCre write SetDgCodReduzCre;

    property IdEmpresa: Integer read FIdEmpresa write SetIdEmpresa;
    property Filial: Integer read FFilial write SetFilial;
    property IdRegistroFinance: string read FIdRegistroFinance write SetIdRegistroFinance;
    property RegistroProvisao: string read FRegistroProvisao write SetRegistroProvisao;

    property CodReduzCre: Integer read FCodReduzCre write SetCodReduzCre;
    property Valor: Currency read FValor write SetValor;
    property ExecTrigger: string read FExecTrigger write SetExecTrigger;
    property IdLancamento: Integer read FIdLancamento write SetIdLancamento;
    property DgContaCredito: string read FDgContaCredito write SetDgContaCredito;
    property CentroCusto: Integer read FCentroCusto write SetCentroCusto;
    property Ano: string read FAno write SetAno;
    property ContaCredito: string read FContaCredito write SetContaCredito;
    property IdOrganizacao: string read FIdOrganizacao write SetIdOrganizacao;
    property Lote: Integer read FLote write SetLote;
    destructor Destroy; override;
  end;

implementation


{ TLancamentoCreditoModel }

destructor TLancamentoCreditoModel.Destroy;
begin

  inherited;
end;

procedure TLancamentoCreditoModel.SetAno(const Value: string);
begin
  FAno := Value;
end;

procedure TLancamentoCreditoModel.SetCentroCusto(const Value: Integer);
begin
//  FCentroCusto := Value;
  FCentroCusto := 0;
end;

procedure TLancamentoCreditoModel.SetExecTrigger(const Value: string);
begin
  //FExecTrigger := Value;
  FExecTrigger := 'S';
end;

procedure TLancamentoCreditoModel.SetFilial(const Value: Integer);
begin
  //FFilial := Value;
  FFilial := 0;
end;

procedure TLancamentoCreditoModel.SetCodHistorico(const Value: Integer);
begin
  FCodHistorico := Value;
end;

procedure TLancamentoCreditoModel.SetCodReduzCre(const Value: Integer);
begin
  FCodReduzCre := Value;
end;

procedure TLancamentoCreditoModel.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TLancamentoCreditoModel.SetContaCredito(const Value: string);
begin
  FContaCredito := Value;
end;

procedure TLancamentoCreditoModel.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TLancamentoCreditoModel.SetDataLanc(const Value: TDateTime);
begin
  FDataLanc := Value;
end;

procedure TLancamentoCreditoModel.SetDgCodReduzCre(const Value: string);
begin
  FDgCodReduzCre := Value;
end;

procedure TLancamentoCreditoModel.SetDgContaCredito(const Value: string);
begin
  FDgContaCredito := Value;
end;

procedure TLancamentoCreditoModel.SetFncIdentificacao(const Value: string);
begin
  FFncIdentificacao := Value;
end;

procedure TLancamentoCreditoModel.SetHistorico(const Value: string);
begin
FHistorico := Value;
end;

procedure TLancamentoCreditoModel.SetIdEmpresa(const Value: Integer);
begin
  FIdEmpresa := Value;
end;

procedure TLancamentoCreditoModel.SetIdLancamento(const Value: Integer);
begin
  FIdLancamento := Value;
end;

procedure TLancamentoCreditoModel.SetIdOrganizacao(const Value: string);
begin
  FIdOrganizacao := Value;
end;

procedure TLancamentoCreditoModel.SetIdRegistroFinance(const Value: string);
begin
  FIdRegistroFinance := Value;
end;


procedure TLancamentoCreditoModel.SetLinha(const Value: Integer);
begin
  FLinha := Value;
end;

procedure TLancamentoCreditoModel.SetLote(const Value: Integer);
begin
  FLote := Value;
end;

procedure TLancamentoCreditoModel.SetRegistroFinance(const Value: string);
begin
FIdRegistroFinance := Value;
end;

procedure TLancamentoCreditoModel.SetRegistroProvisao(const Value: string);
begin
  FRegistroProvisao := Value;
end;

procedure TLancamentoCreditoModel.SetTipo(const Value: string);
begin
  FTipo := Value;
end;

procedure TLancamentoCreditoModel.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.


