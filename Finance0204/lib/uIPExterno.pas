unit uIPExterno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Winsock,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.Buttons;

type
  TForm3 = class(TForm)
    BitBtn1: TBitBtn;
    IdHTTP1: TIdHTTP;
    Label1: TLabel;
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    procedure BitBtn1Click(Sender: TObject);
    function getIPs: String;
    Function TIPreal : String;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.BitBtn1Click(Sender: TObject);
var
IPExterno: string;
begin
IPExterno := '';
with TIdHTTP.Create(nil) do
try
IPExterno:= Get('http://checkip.dyndns.org');
IPExterno:= Copy(IPExterno, Pos('Current IP Address: ', IPExterno) + 20, 15);
IPExterno := Copy(IPExterno, 1, Pos('<', IPExterno) - 1);

except on E: Exception do
IPExterno:= E.Message;
end;


Memo4.Text := IPExterno;
label1.Caption := IPExterno ;


end;


procedure TForm3.Button1Click(Sender: TObject);
begin
label1.Caption := TIPreal;
Memo1.Text := TIPreal;
end;

function TForm3.getIPs: String;
var
   txt :string ;
   http : tidhttp ;

begin

    // criamos a instancia
    http := tIdhttp.Create ;

    try

       Try
          txt:=http.Get('http://checkip.dyndns.org');
       except
          exit;
       end;

    finally

        http.Free ;
        result := txt;

    end;
end;


Function TForm3.TIPreal : String;
var
IPExterno: string;
begin
IPExterno := '';
with TIdHTTP.Create(nil) do
try
IPExterno:= Get('http://checkip.dyndns.org');
IPExterno:= Copy(IPExterno, Pos('Current IP Address: ', IPExterno) + 20, 15);
IPExterno := Copy(IPExterno, 1, Pos('<', IPExterno) - 1);

except on E: Exception do
IPExterno:= E.Message;
end;
end;



end.
