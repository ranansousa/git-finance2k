unit uFrmGerarCheques;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinsDefaultPainters, udmConexao, uUtil,uContaBancariaModel, uContaBancariaDAO, uContaBancariaChequeModel,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins, uContaContabilModel, uContaBancariaChequeDAO,
  dxRibbonCustomizationForm, cxClasses, dxRibbon, dxBar, dxStatusBar,
  cxContainer, cxEdit, cxLabel, cxTextEdit, uFrameContaBancaria, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, MDDAO,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uFrameGeneric, uFrameResponsavel, EMsgDlg;

type
  TfrmGerarCheques = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    frmContaBancaria1: TfrmContaBancaria;
    edtContaContabil: TcxTextEdit;
    edtChequeInicial: TEdit;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar3: TdxBar;
    dxBtnSair: TdxBarLargeButton;
    dxBtnLimpar: TdxBarLargeButton;
    dxBtnGerar: TdxBarLargeButton;
    edtQtd: TEdit;
    frameResponsavel1: TframeResponsavel;
    PempecMsg: TEvMsgDlg;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtTitular: TcxTextEdit;
    Label4: TLabel;
    procedure dxBtnSairClick(Sender: TObject);
    procedure dxBtnLimparClick(Sender: TObject);
    procedure frameResponsavel1cbbcomboChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frmContaBancaria1cbbContaChange(Sender: TObject);
    procedure dxBtnGerarClick(Sender: TObject);
  private
  FslistaIdContaBancaria, FslistaIdResponsavel :TStringList;
    contaOrigem, pIdResponsavel, iDContaOrigem, pIdOperacao, pIdUsuario,  pIDOrganizacao :string;
    pDataMovimento, pDataRegistro :TDate;

    procedure limpaPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGerarCheques: TfrmGerarCheques;

implementation

{$R *.dfm}

procedure TfrmGerarCheques.dxBtnGerarClick(Sender: TObject);
var cheque : TContaBancariaChequeModel;
qtd :Integer;
begin

    qtd := StrToInt(edtQtd.Text);

    cheque := TContaBancariaChequeModel.Create;
    cheque.FIDorganizacao := pIDOrganizacao;
    cheque.FID := dmConexao.obterNewID;
    cheque.FIDcontaBancaria := iDContaOrigem;
    cheque.FIDresponsavel := pIdResponsavel;
    cheque.FIDusuario := pIdUsuario;
    cheque.FIDtipoStatus := 'BLOQUEADO';
    cheque.Fvalor := 0;
    cheque.FdataRegistro := Now;
    cheque.FqtdImpressao := 0;
    cheque.FNumero := edtChequeInicial.Text;

  if TContaBancariaChequeDAO.gerarCheques(qtd, cheque) then begin

   registraMovimentacao(pIDOrganizacao, 'CONTA_BANCARIA_CHEQUE', 'GERAR CHEQUE', uutil.TUserAtual.getNameUser + ' gerou '  + IntToStr(qtd) + ' cheques ', 'GERADO');
   PempecMsg.MsgInformation('Cheques gerados com sucesso.' );


  end;

  dxBtnLimpar.Click;


end;


procedure TfrmGerarCheques.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;


procedure TfrmGerarCheques.dxBtnLimparClick(Sender: TObject);
begin
 limpaPanel;
end;

procedure TfrmGerarCheques.dxBtnSairClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmGerarCheques.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action :=caFree;
end;

procedure TfrmGerarCheques.FormCreate(Sender: TObject);
begin

 limpaPanel;

end;

procedure TfrmGerarCheques.frameResponsavel1cbbcomboChange(Sender: TObject);
begin

 if frameResponsavel1.cbbcombo.ItemIndex > 0  then begin

    pIdResponsavel := FslistaIdResponsavel[frameResponsavel1.cbbcombo.ItemIndex];
 end;

end;

procedure TfrmGerarCheques.frmContaBancaria1cbbContaChange(Sender: TObject);
var
  conta : TContaBancariaModel;

begin
   conta := TContaBancariaModel.Create;
   iDContaOrigem  := FslistaIdContaBancaria[frmContaBancaria1.cbbConta.ItemIndex];
   conta.FID := iDContaOrigem;
   conta.FIDorganizacao := pIDOrganizacao;
   conta := TContaBancariaDAO.obterPorID(conta);
   edtContaContabil.Text := conta.FcontaContabil.Fconta;
   edtTitular.Text := conta.Ftitular;

  //  conta := frmContaBancaria1.getContaContabil(pIDOrganizacao, iDContaOrigem);


   msgStatusBar(3, 'Conta origem ' + conta.Fconta + ' selecionada');

end;

procedure TfrmGerarCheques.limpaPanel;
begin
 // status
 edtQtd.Text := '20';
 edtChequeInicial.Clear;
 edtContaContabil.Clear;
 edtTitular.Clear;
 iDContaOrigem := '';
 pIdResponsavel :='';
  pIDOrganizacao :=uUtil.TOrgAtual.getId;
 pIdUsuario :=IntToStr(uutil.TUserAtual.getUserId);

// frameResponsavel1.createComboAll('FUNCIONARIO','NOME','NOME',frameResponsavel1.cbbcombo,FslistaIdResponsavel);
 frameResponsavel1.obterTodosAtivos(pIDorganizacao, frameResponsavel1.cbbcombo, FslistaIdResponsavel);

 msgStatusBar(0, 'Status : ');
 msgStatusBar(1, 'Pronto : ');
 msgStatusBar(2, '');
 msgStatusBar(3, ' Selecione uma conta bancária... ');




 pDataMovimento := Now;
 pDataRegistro := Now;

 //sempre por último
 frameResponsavel1.cbbcombo.ItemIndex :=0;
 frmContaBancaria1.obterTodos(pIDOrganizacao, frmContaBancaria1.cbbConta, FslistaIdContaBancaria);
 frmContaBancaria1.cbbConta.ItemIndex :=0;


end;


procedure TfrmGerarCheques.registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
begin
  TMDDAO.registroMD(pOrg, pTable, pAcao, pDsc, pStatus);

end;


end.
