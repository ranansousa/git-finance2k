unit uMostrarLogErro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uPempecExceptions, uUtil,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxRibbonSkins, dxRibbonCustomizationForm, dxBar,
  cxClasses, dxRibbon, dxStatusBar;

type
  TfrmMostrarLogErro = class(TForm)
    Memo: TMemo;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarBtnSair: TdxBarLargeButton;
    dxStatusBar: TdxStatusBar;
    dxBarManager1Bar2: TdxBar;
    dxBarBtnClear: TdxBarLargeButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxBarBtnSairClick(Sender: TObject);
    procedure dxBarBtnClearClick(Sender: TObject);
  private
    procedure limpaStatusBar;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure clear;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMostrarLogErro: TfrmMostrarLogErro;

implementation

{$R *.dfm}
//metodo OnException do  componente TApplicationEvents

//Para exibir os erros

procedure TfrmMostrarLogErro.dxBarBtnClearClick(Sender: TObject);
begin
 clear;
 Memo.Clear;

end;

procedure TfrmMostrarLogErro.dxBarBtnSairClick(Sender: TObject);
begin
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmMostrarLogErro.clear;
var
  txt: TextFile;
begin
  if DirectoryExists(GetCurrentDir + '\temp') then
  begin

    AssignFile(txt, GetCurrentDir + '\temp\LogExcecoes.txt');

    try
      Rewrite(txt);
    finally
      CloseFile(txt);
    end;

  end;

end;


procedure TfrmMostrarLogErro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
FreeAndNil(Memo);
 Action := caFree;
end;

procedure TfrmMostrarLogErro.FormCreate(Sender: TObject);
var
CaminhoArquivoLog :string;
begin
 CaminhoArquivoLog := GetCurrentDir + '\temp\LogExcecoes.txt';
  // Carrega novamente o arquivo de log no Memo

  if FileExists(CaminhoArquivoLog) then
    Memo.Lines.LoadFromFile(CaminhoArquivoLog);

end;


procedure TfrmMostrarLogErro.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmMostrarLogErro.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo.  ';
end;




end.
