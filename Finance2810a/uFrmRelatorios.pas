unit uFrmRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,uFrmDemonstrativoRD, uFrmRelatoriosPagamentos,uFrmRelatorioPagamentosHistorico;

type
  TfrmRelatorios = class(TForm)
    PageControl1: TPageControl;
    tbsContasPagar: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    btnRelContaPagar: TButton;
    btnCTPHistorico: TBitBtn;
    Label1: TLabel;
    btnRD: TBitBtn;
    procedure btnRelContaPagarClick(Sender: TObject);
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure btnCTPHistoricoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRDClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorios: TfrmRelatorios;

implementation

{$R *.dfm}

procedure TfrmRelatorios.btnCTPHistoricoClick(Sender: TObject);
begin

  try
      frmCTPHistorico := TfrmCTPHistorico.Create(Self);
      frmCTPHistorico.ShowModal;
      FreeAndNil(frmCTPHistorico);

  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;

procedure TfrmRelatorios.btnRDClick(Sender: TObject);
begin

  try
      frmDemonstrativoRD := TFrmDemonstrativoRD.Create(Self);
      frmDemonstrativoRD.ShowModal;
      FreeAndNil(frmDemonstrativoRD);

  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;


end;

procedure TfrmRelatorios.btnRelContaPagarClick(Sender: TObject);

begin

  try
      frmRelatorioPagamentos := TfrmRelatorioPagamentos.Create(Self);
      frmRelatorioPagamentos.ShowModal;
      FreeAndNil(frmRelatorioPagamentos);

  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;
end;



procedure TfrmRelatorios.FormCreate(Sender: TObject);
begin
inicializarDM(Self);
end;

procedure TfrmRelatorios.freeAndNilDM(Sender: TObject);
begin


  if (Assigned(frmCTPHistorico)) then
  begin
    FreeAndNil(frmCTPHistorico);
  end;

  if (Assigned(frmRelatorioPagamentos)) then
  begin
    FreeAndNil(frmRelatorioPagamentos);
  end;

  
end;

procedure TfrmRelatorios.inicializarDM(Sender: TObject);
begin


  if not(Assigned(frmCTPHistorico)) then
  begin
    frmCTPHistorico := TfrmCTPHistorico.Create(Self);
  end;


  if not(Assigned(frmRelatorioPagamentos)) then
  begin
    frmRelatorioPagamentos := TfrmRelatorioPagamentos.Create(Self);
  end;


end;

end.
