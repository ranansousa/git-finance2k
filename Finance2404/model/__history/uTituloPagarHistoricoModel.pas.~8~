unit uTituloPagarHistoricoModel;

interface

uses
  Windows, Dialogs, Messages, Classes, SysUtils;

type
  TTituloPagarHistoricoModel = class(TObject)
  private
    FIdTituloPagar: string;
    FValor: Currency;
    FExecTrigger: string;
    FDescricao: string;
    FDgCodReduz: string;
    FConta: string;
    FCodReduz: Integer;
    FDgVer: string;
    FCodHistorico: Integer;

    public

    procedure SetCodHistorico(const Value: Integer);
    procedure SetCodReduz(const Value: Integer);
    procedure SetConta(const Value: string);
    procedure SetDescricao(const Value: string);
    procedure SetDgCodReduz(const Value: string);
    procedure SetDgVer(const Value: string);
    procedure SetExecTrigger(const Value: string);
    procedure SetIdTituloPagar(const Value: string);
    procedure SetValor(const Value: Currency);

    property IdTituloPagar: string read FIdTituloPagar write SetIdTituloPagar;
    property Valor: Currency read FValor write SetValor;
    property ExecTrigger: string read FExecTrigger write SetExecTrigger;
    property DgCodReduz: string read FDgCodReduz write SetDgCodReduz;
    property DgVer: string read FDgVer write SetDgVer;
    property Descricao: string read FDescricao write SetDescricao;
    property CodReduz: Integer read FCodReduz write SetCodReduz;
    property CodHistorico: Integer read FCodHistorico write SetCodHistorico;
    property Conta: string read FConta write SetConta;

  end;

implementation

{ TTituloPagarHistoricoModel }

procedure TTituloPagarHistoricoModel.SetCodHistorico(const Value: Integer);
begin
  FCodHistorico := Value;
end;

procedure TTituloPagarHistoricoModel.SetCodReduz(const Value: Integer);
begin
  FCodReduz := Value;
end;

procedure TTituloPagarHistoricoModel.SetConta(const Value: string);
begin
  FConta := Value;
end;

procedure TTituloPagarHistoricoModel.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TTituloPagarHistoricoModel.SetDgCodReduz(const Value: string);
begin
  FDgCodReduz := Value;
end;

procedure TTituloPagarHistoricoModel.SetDgVer(const Value: string);
begin
  FDgVer := Value;
end;

procedure TTituloPagarHistoricoModel.SetExecTrigger(const Value: string);
begin
  FExecTrigger := Value;
end;

procedure TTituloPagarHistoricoModel.SetIdTituloPagar(const Value: string);
begin
  FIdTituloPagar := Value;
end;

procedure TTituloPagarHistoricoModel.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.


