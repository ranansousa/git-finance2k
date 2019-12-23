unit uFrmRibbonBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinsDefaultPainters, udmConexao, uUtil, uDMOrganizacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins,
  dxRibbonCustomizationForm, dxStatusBar, cxClasses, dxRibbon, dxBar;

type
  TfrmRibbonBase = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    pIdOrganizacao, pIdUsuario :string;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
  public
    { Public declarations }
  end;

var
  frmRibbonBase: TfrmRibbonBase;

implementation

{$R *.dfm}

procedure TfrmRibbonBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin


 freeAndNilDM(Self);
 Action :=caFree;

end;

procedure TfrmRibbonBase.freeAndNilDM(Sender: TObject);
begin

//nada
limparPanel;


end;

procedure TfrmRibbonBase.inicializarDM(Sender: TObject);
begin
 //nada

end;

procedure TfrmRibbonBase.limparPanel();
begin

 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdUsuario :=uutil.TUserAtual.getUserId;
// frmPeriodo1.inicializa(IncDay(Now, -1), Now);


end;

procedure TfrmRibbonBase.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;



end.
