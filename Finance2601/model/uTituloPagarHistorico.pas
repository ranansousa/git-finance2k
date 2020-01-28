unit uTituloPagarHistorico;

interface

uses
  Windows, Dialogs,Messages, Classes, SysUtils ;

type
  TTituloPagarHistorico = class(TObject)

  private

    IdTituloPagar :string;
    Valor: Currency;
    ExecTrigger: string;
    DgCodReduz: string;
    DgVer: string;
    Descricao: string;
    CodReduz: Integer;
    CodHistorico: Integer;
    Conta: string;
  end;


implementation

end.
