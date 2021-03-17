unit uListaLancamentos;

interface

uses
  Windows, Dialogs, Messages, Classes, SysUtils, uLancamentoCreditoModel, uLancamentoDebitoModel, uListaLancamentosCredito, uListaLancamentosDebito;

type
  TListaLancamentos = class(TObject)
  private

  public
    listaDebito: TList;
    listaCredito: TList;
    { public declarations }
      constructor Create;
      procedure AdicionarCredito(pLista: TListaLancamentoCredito);
      procedure AdicionarDebito(pLista: TListaLancamentoDebito);
      procedure listaDebitoRemover(Index: Integer);
      procedure listaCreditoRemover(Index: Integer);
      function  listaDebitoCount: Integer;
      function  listaDebitoSum: Currency;
      function  listaCreditoCount: Integer;
      function  listaCreditoSum: Currency;
      function  validarCRxDB : Boolean;
  end;

implementation
{ TListaLancamentos }

procedure TListaLancamentos.AdicionarCredito(pLista: TListaLancamentoCredito);
begin
  listaCredito.Add(pLista);
end;

procedure TListaLancamentos.AdicionarDebito(pLista: TListaLancamentoDebito);
begin
  listaDebito.Add(pLista);
end;

constructor TListaLancamentos.Create;
begin
  inherited Create;
  listaDebito := TList.Create;
  listaCredito := TList.Create;

end;

function TListaLancamentos.listaCreditoCount: Integer;
begin
  Result := listaCredito.Count;
end;

procedure TListaLancamentos.listaCreditoRemover(Index: Integer);
begin

  if Index < listaCreditoCount then
    listaCredito.Delete(Index)
  else
    ShowMessage('Lancaçmento não encontrado!');

end;

function TListaLancamentos.listaCreditoSum: Currency;
var total : Currency;
I :Integer;
begin

    total :=0;

    for I := 0 to listaCredito.Count - 1 do
    begin
      total := total + TLancamentoCreditoModel(listaCredito.Items[I]).Valor ;
    end;

    Result := total;

end;

function TListaLancamentos.listaDebitoSum: Currency;
var total : Currency;
listaDB,lancamentoDB, I :Integer;
begin
   total :=0;

    for I := 0 to listaDebito.Count - 1 do
    begin
     total := total + TLancamentoDebitoModel(listaDebito.Items[I]).Valor ;
    //  total := total +  TLancamentoDebitoModel(TListaLancamentoDebito(listaDebito.Items[I])).Valor ;
//      total := total +  TLancamentoDebitoModel(TListaLancamentoDebito(listaDebito.Items[0])).Valor ;
    end;

    Result := total;
end;


function TListaLancamentos.validarCRxDB: Boolean;
begin

Result := (listaDebitoSum = listaCreditoSum);

end;

function TListaLancamentos.listaDebitoCount: Integer;
begin
  Result := listaDebito.Count;
end;

procedure TListaLancamentos.listaDebitoRemover(Index: Integer);
begin
  if Index < listaDebitoCount then
    listaDebito.Delete(Index)
  else
    ShowMessage('Lancaçmento não encontrado!');

end;



end.


