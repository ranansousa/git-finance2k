unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls
  ;

type
  TfrmLogin = class(TForm)
    edtUsuario: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
     procedure loginValido(usuario,senha :String);
  public
    { Public declarations }

  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}



procedure TfrmLogin.loginValido(usuario,senha :String);
var
  loginIsValido : Boolean;
 begin

 loginIsValido := false;


 end;

procedure TfrmLogin.BitBtn1Click(Sender: TObject);
begin



 ShowMessage('Senha incorreta. ');





end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Self.Release;
 Action := cafree;


end;

end.
