unit uFrmImobilizado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, udmConexao,uUtil,uDMOrganizacao,uDMImobilizado,uContaContabilModel,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinsDefaultPainters,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins,
  dxRibbonCustomizationForm, dxStatusBar, cxClasses, dxRibbon, dxBar,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, uHistoricoModel,
  FireDAC.Comp.Client, ENumEd, Vcl.ComCtrls, uFrameGeneric, uFrameHistorico,
  uFrameContaContabil;

type
  TfrmImobilizado = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    lbl1: TLabel;
    cbbGrupo: TComboBox;
    qry1: TFDQuery;
    edtCodigo: TEdit;
    lbl2: TLabel;
    dtpAquisicao: TDateTimePicker;
    lbl3: TLabel;
    edtValorAquisicao: TEvNumEdit;
    lbl4: TLabel;
    edtDescricao: TEdit;
    lbl5: TLabel;
    cbbTipo: TComboBox;
    lbl6: TLabel;
    edtParcelas: TEdit;
    lbl7: TLabel;
    frmHistoricoPatrimonial: TframeHistorico;
    lbl8: TLabel;
    frmHistoricoDespesa: TframeHistorico;
    lbl9: TLabel;
    lbl10: TLabel;
    edtCODREDUZ: TEdit;
    lbl11: TLabel;
    edtContaContabil: TEdit;
    lbl12: TLabel;
    edtCodHistPadrao: TEdit;
    dxBarManager1Bar1: TdxBar;
    dxBarLargeButton1: TdxBarLargeButton;
    procedure FormCreate(Sender: TObject);
    procedure frmHistoricoPatrimonialcbbcomboChange(Sender: TObject);
    procedure dxBarLargeButton1Click(Sender: TObject);
  private
    { Private declarations }
   pIdOrganizacao, pIdUsuario :string;
   pEmpresa :Integer;
      FsListaHistoricoDesp,  FsListaHistoricoPat,  FslistaTipo, FsListaIDGrupo  :TStringList;

    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;

    procedure preencheComboGrupo(pEmpresa :Integer; var combo: TComboBox; var listaID: TStringList);
    procedure preencheComboTipo;


  public
    { Public declarations }


  end;

var
  frmImobilizado: TfrmImobilizado;

implementation

{$R *.dfm}

{ TfrmImobilizado }

procedure TfrmImobilizado.dxBarLargeButton1Click(Sender: TObject);
var
pEMPRESA, pGRUPO, pCODIGO : Integer;
pDATAAQ: TDateTime; pVALORAQ :Currency;
pTIPO, pDESCRICAO, pCTDESTCM, pCTDESTDP, pCTPARTCM, pCTPARTDP,
pCTDESTCM_LEI11638, pCTPARTCM_LEI11638, pCTDESTDP_LEI11638, pCTPARTDP_LEI11638 :string;

begin
  pEMPRESA := StrToInt(uutil.TOrgAtual.getIDSistemaContabil);
  pGRUPO := StrToInt( FsListaIDGrupo[cbbGrupo.ItemIndex]);
  pCODIGO := StrToInt(edtCodigo.Text);
  pDATAAQ := dtpAquisicao.Date;
  pVALORAQ := StrToCurr(edtValorAquisicao.Text);
  pTIPO := FslistaTipo[cbbTipo.ItemIndex];
  pDESCRICAO :=  frmHistoricoPatrimonial.cbbcombo.Items[frmHistoricoPatrimonial.cbbcombo.ItemIndex] + ' '+  UpperCase(edtDescricao.Text);

  pCTDESTCM := '';
  pCTDESTDP := '';
  pCTPARTCM := '';
  pCTPARTDP := '';
  pCTDESTCM_LEI11638 := '';
  pCTPARTCM_LEI11638 := '';
  pCTDESTDP_LEI11638  := '';
  pCTPARTDP_LEI11638 := '';




 dmImobilizado.cadastrarBem( pEMPRESA, pGRUPO, pCODIGO ,
                             pDATAAQ, pVALORAQ,
                             pTIPO, UpperCase(pDESCRICAO), pCTDESTCM, pCTDESTDP, pCTPARTCM, pCTPARTDP,
                             pCTDESTCM_LEI11638, pCTPARTCM_LEI11638, pCTDESTDP_LEI11638, pCTPARTDP_LEI11638 );


 // cadastrando com sucesso no mega.

//gerar os titulos provisionados
//



end;

procedure TfrmImobilizado.FormCreate(Sender: TObject);
begin
inicializarDM(Self);

end;

procedure TfrmImobilizado.freeAndNilDM(Sender: TObject);
begin

if Assigned(dmImobilizado) then begin
     FreeAndNil(dmImobilizado);
 end;

end;

procedure TfrmImobilizado.frmHistoricoPatrimonialcbbcomboChange(Sender: TObject);
var
conta : TContaContabilModel;
pIdHistoricoPat :string;
historicoModel :THistoricoModel;
begin
   pIdHistoricoPat := FsListaHistoricoPat[frmHistoricoPatrimonial.cbbcombo.ItemIndex];
   historicoModel := THistoricoModel.Create;
   historicoModel := frmHistoricoPatrimonial.getHistorico(pIdOrganizacao,pIdHistoricoPat);
   edtCodHistPadrao.Text := IntToStr( historicoModel.FCodigo);


   conta := TContaContabilModel.Create;
   conta :=frmHistoricoPatrimonial.getContaContabil(pIdOrganizacao,pIdHistoricoPat);

  if not uutil.Empty(conta.FIdContaContabil) then  begin

    edtCODREDUZ.Text := conta.FCodigoReduzido;
    edtContaContabil.Text := conta.FConta;

  end;





end;

procedure TfrmImobilizado.inicializarDM(Sender: TObject);
begin
dmConexao.conectarBanco;
dmConexao.conectarMega;
 pIdOrganizacao := uutil.TOrgAtual.getId;
 pIdUsuario := uutil.TUserAtual.getUserId;
 pEmpresa := StrToInt(uutil.TOrgAtual.getIDSistemaContabil);


if not Assigned(dmOrganizacao) then begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
 end;

 if not Assigned(dmImobilizado) then begin
    dmImobilizado := TdmImobilizado.Create(Self);
 end;

  limparPanel;
end;

procedure TfrmImobilizado.limparPanel;
begin
 limpaStatusBar;
 preencheComboGrupo(pEmpresa,cbbGrupo, FsListaIDGrupo );
 edtCodigo.Text := IntToStr(dmImobilizado.obterCodigoBem(pEmpresa));
 preencheComboTipo;
 frmHistoricoPatrimonial.obterTodosPorCodigo(pIdOrganizacao, 200, frmHistoricoPatrimonial.cbbcombo, FsListaHistoricoPat);
 frmHistoricoDespesa.obterTodos(pIdOrganizacao, frmHistoricoDespesa.cbbcombo,FsListaHistoricoDesp );

 edtCodHistPadrao.Clear;
 edtCODREDUZ.Clear;
 edtContaContabil.Clear;

end;

procedure TfrmImobilizado.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. ';

end;

procedure TfrmImobilizado.msgStatusBar(pPosicao: Integer; msg: string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmImobilizado.preencheComboGrupo(pEmpresa: Integer; var combo: TComboBox; var listaID: TStringList);
var  qryGrupo :TFDQuery;

begin

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< GRUPOS   >>>');

  qryGrupo := TFDQuery.Create(Self);
  qryGrupo := dmImobilizado.obterGrupoPermanente(pEmpresa);
  qryGrupo.First;


  while not qryGrupo.Eof do
  begin
    combo.Items.Add( IntToStr(qryGrupo.FieldByName('GRUPO').AsInteger)+ ' - '+ qryGrupo.FieldByName('DESCRICAO').AsString);
    listaID.Add(IntToStr(qryGrupo.FieldByName('GRUPO').AsInteger));
    qryGrupo.Next;
  end;
  qryGrupo.Close;
  combo.ItemIndex := 0;


end;

procedure TfrmImobilizado.preencheComboTipo;
begin

  FslistaTipo :=TStringList.Create;
  FslistaTipo.Clear;
  FslistaTipo.Add('0');
  FslistaTipo.Add('IMOBILIZADO');
  cbbTipo.Clear;
  cbbTipo.Items.Add(' >>Selecione<<');
  cbbTipo.Items.Add('Imobilizado');
  cbbTipo.ItemIndex :=0;
end;



end.
