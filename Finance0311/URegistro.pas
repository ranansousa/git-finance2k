unit URegistro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Menus,UFormPesquisaFinance,UFormBaseDados,UDM, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Mask, Vcl.DBCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    MainMenu1: TMainMenu;
    Pesquisar1: TMenuItem;
    Finance1: TMenuItem;
    Config1: TMenuItem;
    BasedeDados1: TMenuItem;
    Label15: TLabel;
    DBEdit14: TDBEdit;
    Label16: TLabel;
    DBEdit15: TDBEdit;
    Label17: TLabel;
    DBEdit16: TDBEdit;
    Label18: TLabel;
    DBEdit17: TDBEdit;
    Label19: TLabel;
    DBEdit18: TDBEdit;
    Label20: TLabel;
    DBEdit19: TDBEdit;
    Label21: TLabel;
    DBEdit20: TDBEdit;
    Label22: TLabel;
    DBEdit21: TDBEdit;
    Label23: TLabel;
    DBEdit22: TDBEdit;
    Label24: TLabel;
    DBEdit23: TDBEdit;
    Label25: TLabel;
    DBEdit24: TDBEdit;
    Label26: TLabel;
    DBEdit25: TDBEdit;
    Label27: TLabel;
    DBEdit26: TDBEdit;
    Label28: TLabel;
    DBEdit27: TDBEdit;
    procedure Finance1Click(Sender: TObject);
    procedure BasedeDados1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.BasedeDados1Click(Sender: TObject);
var
  loForm: TFrmConfigBaseDados;
begin
  loForm := TFrmConfigBaseDados.Create(Self);
  try
//    loForm.Conn := TUtil.getConn;
    //loForm.doInicializa;
    loForm.ShowModal;
  finally
    FreeAndNil(loForm);
  end;
end;



procedure TForm3.Finance1Click(Sender: TObject);
var
  loForm: TFrmPesquisaFinance;
begin
  loForm := TFrmPesquisaFinance.Create(Self);
  try
//    loForm.Conn := TUtil.getConn;
    //loForm.doInicializa;
    loForm.ShowModal;
  finally
    FreeAndNil(loForm);
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
Self.Position :=poDesktopCenter;

end;

end.
