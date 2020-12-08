unit uFrmInfoUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, ShellApi,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, uUtil,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdAntiFreezeBase, Vcl.IdAntiFreeze, Vcl.ComCtrls, EMsgDlg, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, dxStatusBar ;

type
  TfrmInfoUpdate = class(TForm)
    Panel1: TPanel;
    btnFechar: TBitBtn;
    btnDown: TBitBtn;
    IdHttp: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Memo1: TMemo;
    dlgSave: TSaveDialog;
    edtUrl: TEdit;
    ckbOpcao: TCheckBox;
    pbProgresso: TProgressBar;
    img: TImage;
    lbl1: TLabel;
    lblStatus: TLabel;
    btnCancelar: TBitBtn;
    PempecMsg: TEvMsgDlg;
    btnBaixar: TBitBtn;
    dxStatusBar: TdxStatusBar;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDownClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure IdHttpWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdHttpWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHttpWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure btnBaixarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    function RetornaPorcentagem(ValorMaximo, ValorAtual: real): string;
    function RetornaKiloBytes(ValorAtual: real): string;
    procedure limpaStatusBar;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInfoUpdate: TfrmInfoUpdate;

implementation

{$R *.dfm}

procedure TfrmInfoUpdate.btnBaixarClick(Sender: TObject);
var
  fileDownload: TFileStream;
begin
  dlgSave.Filter := 'Arquivos' + ExtractFileExt(edtUrl.Text) + '|*' + ExtractFileExt(edtUrl.Text);
  dlgSave.FileName := 'FinanceInstal.exe';
  if dlgSave.Execute then
  begin
    fileDownload := TFileStream.Create(dlgSave.FileName + ExtractFileExt(edtUrl.Text), fmCreate);
    try
      pbprogresso.Visible := True;
      lblStatus.Visible := True;
      btnBaixar.Enabled := false;
      IdHTTP.Get(edtUrl.Text, fileDownload);
    finally
      FreeAndNil(fileDownload);
    end;
  end;

  PempecMsg.MsgInformation('Processo concluído.');
  btnFechar.Click;

end;

procedure TfrmInfoUpdate.btnCancelarClick(Sender: TObject);
begin
IdHTTP.Disconnect;
end;

procedure TfrmInfoUpdate.btnDownClick(Sender: TObject);
var
  Id_HandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
begin
      IdHTTP.Request.BasicAuthentication := False;
      IdHTTP.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';
      Id_HandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create( IdHTTP );
      Id_HandlerSocket.SSLOptions.Mode := sslmClient;
      Id_HandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdHTTP.IOHandler := Id_HandlerSocket;
  try

    if uutil.IsInternetConected then
    begin

      IdHTTP.Get('https://www.pempec.com.br/FinanceInstal.exe');

    end;


  finally

    FreeAndNil(IdHTTP);

  end;


end;

procedure TfrmInfoUpdate.btnFecharClick(Sender: TObject);
begin
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmInfoUpdate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := caFree; // sempre como ultimo comando
end;

procedure TfrmInfoUpdate.FormCreate(Sender: TObject);
var
  Id_HandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
begin
      IdHTTP.Request.BasicAuthentication := False;
      IdHTTP.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';
      Id_HandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create( IdHTTP );
      Id_HandlerSocket.SSLOptions.Mode := sslmClient;
      Id_HandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdHTTP.IOHandler := Id_HandlerSocket;
      IdHttp.HandleRedirects := True;

  if uutil.IsInternetConected then
  begin

    edtUrl.Text := 'https://www.pempec.com.br/FinanceInstal.exe';

  end;

end;

procedure TfrmInfoUpdate.IdHttpWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
 pbprogresso.Position   := AWorkCount;
 lblStatus.Caption      := 'Baixando ...  ' + RetornaKiloBytes(AWorkCount);
 frmInfoUpdate.Caption  := 'Download em ... ' + RetornaPorcentagem(pbprogresso.Max, AWorkCount);
 msgStatusBar(0,'Status');
 msgStatusBar(1,lblStatus.Caption);

end;

procedure TfrmInfoUpdate.IdHttpWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
pbprogresso.Max := AWorkCountMax;
end;

procedure TfrmInfoUpdate.IdHttpWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
pbprogresso.Position := 0;
frmInfoUpdate.Caption := 'Finalizado ...';
lblStatus.Caption    := 'Download Finalizado ...';
pbprogresso.Visible  := false;
btnBaixar.Enabled    := true;

if ckbOpcao.Checked then  begin


end;

end;

function TfrmInfoUpdate.RetornaPorcentagem(ValorMaximo, ValorAtual: real): string;
var
resultado: Real;
begin
resultado := ((ValorAtual * 100) / ValorMaximo);
Result    := FormatFloat('0%', resultado);
end;

function TfrmInfoUpdate.RetornaKiloBytes(ValorAtual: real): string;
var
resultado : real;
begin
resultado := ((ValorAtual / 1024) / 1024);
Result    := FormatFloat('0.000 KBs', resultado);
end;


procedure TfrmInfoUpdate.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. ';
end;

procedure TfrmInfoUpdate.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;




end.
