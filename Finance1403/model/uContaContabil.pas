       unit uContaContabil;
interface

uses
  Windows, Messages, Classes, SysUtils, uContaContabilModel;

type
  THistoricoModel = class(TObject)
  private

    FIdHistorico: string;
    FDescricao: string;
    FContaContabil :TContaContabilModel;

  end;

implementation

end.
