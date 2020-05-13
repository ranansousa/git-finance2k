unit uFrmDemonstrativoDespesasCC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, udmConexao,uUtil,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters, dxRibbonSkins, uCentroCustoDAO, uCentroCustoModel,
  dxRibbonCustomizationForm, cxClasses, dxRibbon, dxBar, EMsgDlg, dxStatusBar,
  dxBarExtItems, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmDemonstrativoDespesasCC = class(TForm)
    dxStatusBar: TdxStatusBar;
    PempecMsg: TEvMsgDlg;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBarDataInicial: TdxBarDateCombo;
    dxBarDataFinal: TdxBarDateCombo;
    dxBarCbxCentroCusto: TdxBarCombo;
    qryCentroCusto: TFDQuery;
    dxBarBtnFechar: TdxBarLargeButton;
    dxBarManager1Bar3: TdxBar;
    dxBarBtnConsulta: TdxBarLargeButton;
    qryPreencheGrid: TFDQuery;
    dbGrid: TDBGrid;
    dtsGrid: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dxBarBtnFecharClick(Sender: TObject);
    procedure dxBarBtnConsultaClick(Sender: TObject);
  private
    { Private declarations }

    FsListaIdCentrosCusto: TStringList;
    idOrganizacao: string;

    function preencheGrid (pidOrganizacao, pIdCentroCusto :string; pDataInicial, pDataFinal :TDateTime) :Boolean;


    procedure limpaPanel;



  public
    { Public declarations }
  end;

var
  frmDemonstrativoDespesasCC: TfrmDemonstrativoDespesasCC;

implementation

{$R *.dfm}

procedure TfrmDemonstrativoDespesasCC.dxBarBtnConsultaClick(Sender: TObject);
var
idCentroCusto :string;
begin
idCentroCusto := '';

  if dxBarCbxCentroCusto.ItemIndex >0  then begin

     idCentroCusto := FsListaIdCentrosCusto[dxBarCbxCentroCusto.ItemIndex];
  end;

  preencheGrid(idOrganizacao, idCentroCusto ,dxBarDataInicial.Date, dxBarDataFinal.Date);

end;

procedure TfrmDemonstrativoDespesasCC.dxBarBtnFecharClick(Sender: TObject);
begin
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmDemonstrativoDespesasCC.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;

end;



procedure TfrmDemonstrativoDespesasCC.FormCreate(Sender: TObject);
begin
 idOrganizacao := uutil.TOrgAtual.getId;

 limpaPanel;
end;

procedure TfrmDemonstrativoDespesasCC.limpaPanel;
begin

dxBarDataFinal.Date := Now;
dxBarDataInicial.Date := Now;

  TCentroCustoDAO.comboDxBar(dxBarCbxCentroCusto, FsListaIdCentrosCusto);
  dxBarCbxCentroCusto.ItemIndex := 0;


end;

function TfrmDemonstrativoDespesasCC.preencheGrid(pidOrganizacao,
  pIdCentroCusto: string; pDataInicial, pDataFinal: TDateTime): Boolean;
begin

  qryPreencheGrid.Close;
  qryPreencheGrid.Connection := dmConexao.conn;
  qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pidOrganizacao;
  qryPreencheGrid.ParamByName('PID').AsString := pIdCentroCusto;
  qryPreencheGrid.ParamByName('DTINICIAL').AsDateTime := pDataInicial;
  qryPreencheGrid.ParamByName('DTFINAL').AsDateTime := pDataFinal;
  qryPreencheGrid.Open ;



  Result := not qryPreencheGrid.IsEmpty;

end;

end.