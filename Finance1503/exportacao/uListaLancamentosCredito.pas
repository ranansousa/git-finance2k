unit uListaLancamentosCredito;

interface

uses
  Classes, uLancamentoCreditoModel, Dialogs;

type
  TListaLancamentoCredito = class(TObject)
  private
    { private declarations }

  protected
    { protected declarations }
  public
    { public declarations }
    FListaLancamentoCredito : TList;
    constructor Create;
    procedure Adicionar(pLancamento: TLancamentoCreditoModel);
    procedure Remover(Index: Integer);
    function Count: Integer;
  published
    { published declarations }

  end;

implementation

{ TListaLancamento }

procedure TListaLancamentoCredito.Adicionar(pLancamento: TLancamentoCreditoModel);
begin
  FListaLancamentoCredito.Add(pLancamento);
end;

function TListaLancamentoCredito.Count: Integer;
begin

 Result := FListaLancamentoCredito.Count;
end;

constructor TListaLancamentoCredito.Create;
begin
  inherited Create;
  FListaLancamentoCredito := TList.Create;

end;

procedure TListaLancamentoCredito.Remover(Index: Integer);
begin
  if Index < Count then
    FListaLancamentoCredito.Delete(Index)
  else
    ShowMessage('Lanca�mento n�o encontrado!');
end;

end.


