unit uFormBaseMaster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RxLookup;

type
  TFormBaseMaster = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBaseMaster: TFormBaseMaster;

implementation

{$R *.dfm}

procedure TFormBaseMaster.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  liFor: Integer;
begin
  for liFor := 0 to Self.ComponentCount-1 do begin
    {Verifica se existe componente TRxDBLookupCombo e fecha
     antes de fechar o form, pois, caso contrário, ocorre um
     erro.}
    if (Self.Components[liFor] is TRxDBLookupCombo) then begin
      TRxDBLookupCombo(Self.Components[liFor]).CloseUp(true);
    end else if (Self.Components[liFor] is TRxDBLookupCombo) then begin
      TRxDBLookupCombo(Self.Components[liFor]).CloseUp(true);
    end;
  end;
end;

end.
