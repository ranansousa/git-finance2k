unit uTRBaixaFPModel;

{table

CREATE TABLE TITULO_RECEBER_BAIXA_FP (
    ID_TITULO_RECEBER_BAIXA_FP  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO              VARCHAR(36) NOT NULL,
    ID_TITULO_RECEBER_BAIXA     VARCHAR(36),
    ID_FORMA_PAGAMENTO          VARCHAR(36),
    VALOR                       NUMERIC(10,2) NOT NULL,
);
}


interface
 USes
  Windows, Messages, Classes, SysUtils,uFormaPagamentoModel,uOrganizacaoModel;

 type
  TTRBaixaFPModel = class(TObject)

  private

    FFID: string;
    FFIDorganizacao: string;
    FFIDformaPagamento :string;
    FFFormaPagamento: TFormaPagamentoModel;
    FFOrganizacao: TOrganizacaoModel;
    FFValor :Currency;
    FFIDTRBaixa: string;

    procedure SetFFFormaPagamento(const Value: TFormaPagamentoModel);
    procedure SetFFID(const Value: string);
    procedure SetFFIDformaPagamento(const Value: string);
    procedure SetFFIDorganizacao(const Value: string);
    procedure setFFIDTRBaixa(const Value: string);
    procedure SetFFValor(const Value: Currency);
    procedure SetForganizacao(const Value: TOrganizacaoModel);

  public

    property FIDformaPagamento: string              read FFIDformaPagamento   write SetFFIDformaPagamento;
    property FFormaPagamento: TFormaPagamentoModel  read FFFormaPagamento     write SetFFFormaPagamento;
    property FIDorganizacao: string                 read FFIDorganizacao      write SetFFIDorganizacao;
    property Forganizacao: TOrganizacaoModel        read FFOrganizacao        write SetForganizacao;
    property FIDTRBaixa: string                     read FFIDTRBaixa          write setFFIDTRBaixa;
    property FValor: Currency                       read FFValor              write SetFFValor;
    property FID: string                            read FFID                 write SetFFID;

  Constructor Create;

  end;

implementation

{ TTRBaixaFPModel }

constructor TTRBaixaFPModel.Create;
begin
//
end;

procedure TTRBaixaFPModel.SetFFFormaPagamento(
  const Value: TFormaPagamentoModel);
begin
  FFFormaPagamento := Value;
end;

procedure TTRBaixaFPModel.SetFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTRBaixaFPModel.SetFFIDformaPagamento(const Value: string);
begin
  FFIDformaPagamento := Value;
end;

procedure TTRBaixaFPModel.SetFFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TTRBaixaFPModel.setFFIDTRBaixa(const Value: string);
begin
  FFIDTRBaixa := Value;
end;

procedure TTRBaixaFPModel.SetFFValor(const Value: Currency);
begin
  FFValor := Value;
end;

procedure TTRBaixaFPModel.SetForganizacao(const Value: TOrganizacaoModel);
begin
  FFOrganizacao := Value;
end;

end.
