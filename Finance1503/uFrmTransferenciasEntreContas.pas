unit uFrmTransferenciasEntreContas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,udmConexao,
  dxSkinsCore, dxSkinsDefaultPainters, dxCore, cxDateUtils, Vcl.Menus, uUtil, System.DateUtils,
  cxButtons, cxDropDownEdit, cxCalendar, cxMaskEdit, cxTextEdit, cxLabel,
  uFrameContaBancaria, Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option, uFrmRelatorioTransferencias, uContaBancariaTRFModel, uContaBancariaTRFDAO,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, uDMContaBancariaTransferencia,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uContaContabilModel,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, dxStatusBar,
  dxRibbonSkins, dxRibbonCustomizationForm, dxBar, cxClasses, dxRibbon, cxMemo,
  cxRichEdit, cxBarEditItem, dxBarBuiltInMenu, cxPC, cxImage, cxDBEdit,
  uFrameGeneric, uFrameResponsavel, uFramePeriodo, Vcl.Buttons, frxClass,
  uContaBancariaModel,  uContaBancariaDAO,
  uContaBancariaCRModel, uContaBancariaDBModel, uContaBancariaDebitoDAO,uContaBancariaCreditoDAO,
  frxDBSet, ENumEd, EMsgDlg;

type
  TfrmTransferenciasEntreContas = class(TForm)
    frmContaBancaria1: TfrmContaBancaria;
    frmContaBancaria2: TfrmContaBancaria;
    cxLabel2: TcxLabel;
    cbbDataMovimento: TcxDateEdit;
    cxLabel5: TcxLabel;
    edtTipoOperacao: TcxTextEdit;
    cxLabel6: TcxLabel;
    edtContaContabilDB: TcxTextEdit;
    edtContaContabilCR: TcxTextEdit;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    dxStatusBar: TdxStatusBar;
    dxBarManager1: TdxBarManager;
    dxBarLargeButton1: TdxBarLargeButton;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBtnTransfere: TdxBarLargeButton;
    dxBarManager1Bar2: TdxBar;
    dxBarLargeButton2: TdxBarLargeButton;
    dxBarManager1Bar3: TdxBar;
    dxBarLargeButton3: TdxBarLargeButton;
    edtIdentificador: TcxTextEdit;
    cxLabel1: TcxLabel;
    cbbIdentificador: TcxBarEditItem;
    cxPageCTRFBCO: TcxPageControl;
    cxTableTransfere: TcxTabSheet;
    cxTableEstorna: TcxTabSheet;
    frameResponsavel1: TframeResponsavel;
    edtObservacao: TcxTextEdit;
    cxLabel3: TcxLabel;
    frmPeriodo1: TfrmPeriodo;
    cxLabel4: TcxLabel;
    btnBuscaTRF: TBitBtn;
    cbbTransferencias: TComboBox;
    edtContaOrigem: TcxTextEdit;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    edtContaDestino: TcxTextEdit;
    cxLabel11: TcxLabel;
    dxBarManager1Bar4: TdxBar;
    dxBtnEstorno: TdxBarLargeButton;
    dxBarManager1Bar5: TdxBar;
    dxBtnRelTRF: TdxBarLargeButton;
    edtValor: TEvNumEdit;
    edtValorTransf: TEvNumEdit;
    edtSaldoBancario: TcxTextEdit;
    chkSaldo: TCheckBox;
    PempecMsg: TEvMsgDlg;
    procedure FormCreate(Sender: TObject);
    procedure frmContaBancaria2cbbContaChange(Sender: TObject);
    procedure frmContaBancaria1cbbContaChange(Sender: TObject);
    procedure dxBtnTransfereClick(Sender: TObject);
    procedure dxBarLargeButton2Click(Sender: TObject);
    procedure dxBarLargeButton3Click(Sender: TObject);
    procedure cbbDataMovimentoPropertiesChange(Sender: TObject);
    procedure frameResponsavel1cbbcomboChange(Sender: TObject);
    procedure btnBuscaTRFClick(Sender: TObject);
    procedure cbbTransferenciasChange(Sender: TObject);
    procedure dxBtnEstornoClick(Sender: TObject);
    procedure dxBtnRelTRFClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkSaldoClick(Sender: TObject);

  private
    { Private declarations }
    msgStatus : string;
   FsListaIdTransferencia, FslistaIdResponsavel,    FslistaIdContaOrigem,    FslistaIdContaDestino :TStringList;

   contaOrigem, contaDestino, pIdResponsavel, pIdentificacao,  iDContaOrigem, iDContaDestino, pIdOperacao,    pIDOrganizacao :string;
    pDataMovimento, pDataRegistro :TDate;
    procedure limpaPanel;
    procedure limpaPanelEstorna;
    procedure inicializarDM(Sender: TObject);
    function validarForm: Boolean;
    procedure limpaPanelTransfere;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    function obterIndiceLista(pId: string; lista: TStringList): Integer;

  public
    { Public declarations }
  end;

var
  frmTransferenciasEntreContas: TfrmTransferenciasEntreContas;

implementation

{$R *.dfm}

procedure TfrmTransferenciasEntreContas.btnBuscaTRFClick(Sender: TObject);
begin
//preenche o combo com base nos parametros
  TContaBancariaTRFDAO.obterTodos(pIDOrganizacao,frmPeriodo1.getDataInicial, frmPeriodo1.getDataFinal, cbbTransferencias, FsListaIdTransferencia );

  msgStatusBar(2,'OBS: ');
  msgStatusBar(3,'S� � poss�vel estornar lan�amentos que n�o tenham sido exportados para o sistema cont�bil.');
end;

procedure TfrmTransferenciasEntreContas.cbbDataMovimentoPropertiesChange(
  Sender: TObject);
  var
  validarData :Integer;
begin


  pDataMovimento := StrToDate(FormatDateTime('DD/MM/YYYY',cbbDataMovimento.Date));
  pDataRegistro  := StrToDate(FormatDateTime('DD/MM/YYYY',now ));
  //se movimento < hoje = -1
  // se movimento > hoje =  1
  validarData := compareDate(pDataMovimento, pDataRegistro);


  if validarData = 1  then   begin // a data do movimento � maior que a data de hoje

    MessageDlg('A data do movimento n�o pode ser maior que a data de hoje.', mtInformation, [mbOK], 0);
    msgStatusBar(1,'Erro na data de movimento. ');

  end;


end;

procedure TfrmTransferenciasEntreContas.cbbTransferenciasChange(
  Sender: TObject);
  var
  transf :TContaBancariaTRFModel;
begin

  if cbbTransferencias.ItemIndex >0  then begin

       transf :=TContaBancariaTRFModel.Create;
       transf.FIDorganizacao := pIDOrganizacao;
       transf.FID := FsListaIdTransferencia[cbbTransferencias.ItemIndex];
       transf := TContaBancariaTRFDAO.obterPorID(transf);

       if not uUtil.Empty(transf.FID) then begin

          edtValorTransf.Text   := 'R$ ' + FormatCurr('###,##0.00', transf.Fvalor); // 'R$ '+  CurrToStr(transf.Fvalor) ;
          edtContaOrigem.Text   := transf.FcontaBancariaDB.FcontaBancaria.Fconta + ' ' + transf.FcontaBancariaDB.FcontaBancaria.Ftitular;
          edtContaDestino.Text  := transf.FcontaBancariaCR.FcontaBancaria.Fconta + ' ' + transf.FcontaBancariaCR.FcontaBancaria.Ftitular;

         dxBtnTransfere.Enabled := False;
         dxBtnEstorno.Enabled   := True;

       end;

   end;


end;

function TfrmTransferenciasEntreContas.obterIndiceLista(pId: string;  lista: TStringList): Integer;
var
  I: Integer;
begin
 Result :=0;

  for I := 0 to lista.Count-1 do begin
    if(lista[I].Equals(pId)) then begin
       Result := I;
       Break;
    end;

  end;

end;

procedure TfrmTransferenciasEntreContas.chkSaldoClick(Sender: TObject);
begin
 dxBtnTransfere.DoClick;
end;

procedure TfrmTransferenciasEntreContas.dxBarLargeButton2Click(Sender: TObject);
begin
 limpaPanel;
end;

procedure TfrmTransferenciasEntreContas.dxBarLargeButton3Click(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmTransferenciasEntreContas.dxBtnEstornoClick(Sender: TObject);
var
 transf :TContaBancariaTRFModel;
 contaDB : TContaBancariaDBModel;
 contaCR : TContaBancariaCRModel;
 sucesso : Boolean;
begin
sucesso := False;
 dmConexao.conectarBanco;

 try
           transf :=TContaBancariaTRFModel.Create;
           transf.FIDorganizacao := pIDOrganizacao;
           transf.FID := FsListaIdTransferencia[cbbTransferencias.ItemIndex];
           transf := TContaBancariaTRFDAO.obterPorID(transf);

    if not uutil.Empty(transf.FID) then
    begin

      if not uutil.Empty(transf.FIDcontaBancariaDB) then
      begin

        contaDB := TContaBancariaDBModel.Create;
        contaDB.FIDorganizacao := transf.FIDorganizacao;
        contaDB.FID := transf.FIDcontaBancariaDB;
        contaDB := TContaBancariaDebitoDAO.obterPorID(contaDB);

        if not uutil.Empty(contaDB.FID) then
        begin

          contaCR := TContaBancariaCRModel.Create;
          contaCR.FID := transf.FIDcontaBancariaCR;
          contaCR.FIDorganizacao := transf.FIDorganizacao;
          contaCR := TContaBancariaCreditoDAO.obterPorID(contaCR);

          if not uUtil.Empty(contaCR.FID) then
          begin
            sucesso := TContaBancariaTRFDAO.estornarTransfEntreContas(transf);
          end else begin msgStatus := 'Falta conta cr�dito'; end;

        end else begin msgStatus := 'Falta conta d�bito'; end;

      end;

    end;

    if sucesso then
    begin
      limpaPanel;
      MessageDlg('Estorno realizado com sucesso.', mtInformation, [mbOK], 0);
      btnBuscaTRF.Click;
    end else begin

       MessageDlg('N�o foi poss�vel realizar o estorno. : ' +msgStatus , mtInformation, [mbOK], 0);

    end;


  except
    on e: Exception do
      MessageDlg('Ocorreram problemas com a transfer�ncia. =>  ' + e.Message + sLineBreak, mtInformation, [mbOK], 0);
  end;

end;

procedure TfrmTransferenciasEntreContas.dxBtnRelTRFClick(Sender: TObject);
begin

 try
    frmRelatorioTransferencias := TfrmRelatorioTransferencias.Create(Self);
     frmRelatorioTransferencias.ShowModal;
     FreeAndNil(frmRelatorioTransferencias);

  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;


end;

procedure TfrmTransferenciasEntreContas.dxBtnTransfereClick(Sender: TObject);
var
pObs,  pIdTransf, pIdUsuario, pDescricao, pIdOperacao :string;
pValor :Currency;
 transf :TContaBancariaTRFModel;
 contaDB : TContaBancariaDBModel;
 contaCR : TContaBancariaCRModel;
 conta : TContaBancariaModel;
begin
 pDataRegistro := StrToDate(FormatDatetime('DD/MM/YYYY', Now));
 pDataMovimento:= StrToDate(FormatDatetime('DD/MM/YYYY', cbbDataMovimento.Date));
 pValor := (edtValor.Value);
 pIdOperacao := edtTipoOperacao.Text;
 pDescricao := 'TRANSF CTA ORIG. ' + contaOrigem  + ' CTA DEST. ' + contaDestino ;
 pIdUsuario := IntToStr(uutil.TUserAtual.getUserId);
 pIdTransf := dmConexao.obterNewID;
 pIdentificacao := dmConexao.obterIdentificador('',PIDORGANIZACAO,'CBT');
 edtIdentificador.Text := pIdentificacao;
 pObs := edtObservacao.Text;
   //mudado em 06/03/20
  if validarForm then
  begin
    try
          contaDB                   := TContaBancariaDBModel.Create;
          contaDB.FID               := dmConexao.obterNewID;
          contaDB.FIDorganizacao    := pIDOrganizacao;
          contaDB.FIDusuario        := uutil.TUserAtual.getUserId;
          contaDB.FIDcontaBancaria  := iDContaOrigem;
          contaDB.FIDResponsavel    := pIdResponsavel;
          contaDB.FIDTOB            := pIdOperacao;
          contaDB.Fidentificacao    := dmConexao.obterIdentificador('',pIDOrganizacao,'CBD');
          contaDB.FtipoLancamento   := 'D';
          contaDB.Fdescricao        := pDescricao;
          contaDB.Fobservacao       := pObs;
          contaDB.FdataRegistro     := Now;
          contaDB.FdataMovimento    := cbbDataMovimento.Date;
          contaDB.Fvalor            :=  pValor;

          conta := TContaBancariaModel.Create;
          conta.FIDorganizacao :=pIDOrganizacao;
          conta.FID := contaDB.FIDcontaBancaria;
          contaDB.FcontaBancaria :=TContaBancariaDAO.obterPorID(conta);


          contaCR                   := TContaBancariaCRModel.Create;
          contaCR.FID               := dmConexao.obterNewID;
          contaCR.FIDorganizacao    := pIDOrganizacao;
          contaCR.FIDusuario        := uutil.TUserAtual.getUserId;
          contaCR.FIDcontaBancaria  :=  iDContaDestino ;
          contaCR.FIDResponsavel    := pIdResponsavel;
          contaCR.FIDTOB            := pIdOperacao;
          contaCR.Fidentificacao    := dmConexao.obterIdentificador('',pIDOrganizacao,'CBC');
          contaCR.FtipoLancamento   := 'C';
          contaCR.Fdescricao        := pDescricao;
          contaCR.Fobservacao       := pObs;
          contaCR.FdataRegistro     := Now;
          contaCR.FdataMovimento    := cbbDataMovimento.Date;
          contaCR.Fvalor            :=  pValor;

          conta.FIDorganizacao :=pIDOrganizacao;
          conta.FID := contaCR.FIDcontaBancaria;
          contaCR.FcontaBancaria :=TContaBancariaDAO.obterPorID(conta);


          transf                    := TContaBancariaTRFModel.Create;
          transf.FIDorganizacao     := pIDOrganizacao;
          transf.FID                := dmConexao.obterNewID;
          transf.FIDusuario         := uutil.TUserAtual.getUserId;
          transf.FIDResponsavel     := pIdResponsavel;
          transf.FIDTOB             := pIdOperacao;
          transf.FIDcontaBancariaCR := contaCR.FID;
          transf.FIDcontaBancariaDB := contaDB.FID;
          transf.Fidentificacao     := dmConexao.obterIdentificador('',PIDORGANIZACAO,'CBT');
          transf.FdataRegistro     := Now;
          transf.FdataMovimento    := cbbDataMovimento.Date;
          transf.Fvalor             :=  pValor;
          transf.FcontaBancariaDB   := contaDB;
          transf.FcontaBancariaCR   := contaCR;

          if TContaBancariaTRFDAO.transfereEntreContas(transf) then begin

            limpaPanel;
            MessageDlg('Transfer�ncia realizada com sucesso.', mtInformation, [mbOK], 0);
            msgStatusBar(3,'Processo conclu�do');
            FreeAndNil(conta);
          end;

    except
    on e: Exception do
      MessageDlg('Ocorreram problemas com a transfer�ncia. =>  '+ e.Message + sLineBreak , mtInformation, [mbOK], 0);
    end;

  end;

 end;


procedure TfrmTransferenciasEntreContas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 // FreeAndNil(dmCBT);
 Action := caFree;
end;

procedure TfrmTransferenciasEntreContas.FormCreate(Sender: TObject);
begin

limpaPanel;
inicializarDM(Self);
end;

procedure TfrmTransferenciasEntreContas.frameResponsavel1cbbcomboChange(
  Sender: TObject);
begin

 if frameResponsavel1.cbbcombo.ItemIndex > 0  then begin
    pIdResponsavel := FslistaIdResponsavel[frameResponsavel1.cbbcombo.ItemIndex];
 end;

 dxBtnTransfere.Enabled := True;
 dxBtnEstorno.Enabled := False;

end;

procedure TfrmTransferenciasEntreContas.frmContaBancaria1cbbContaChange( Sender: TObject);
  var
  SDconta : Currency;
  indice : Integer;
 contaBancoORG :TContaBancariaModel;
begin
   indice :=0;

  if frmContaBancaria1.cbbConta.ItemIndex > 0 then
  begin

    indice := frmContaBancaria1.cbbConta.ItemIndex;
    iDContaOrigem := FslistaIdContaOrigem[indice];

    contaBancoORG := TContaBancariaModel.Create;
    contaBancoORG.FIDorganizacao := pIDOrganizacao;
    contaBancoORG.FID := iDContaOrigem;
    contaBancoORG := TContaBancariaDAO.obterPorID(contaBancoORG);

    if not uUtil.Empty(contaBancoORG.FID) then
    begin
      contaOrigem := contaBancoORG.Fconta;

      if not uUtil.Empty(contaBancoORG.FIDcontaContabil) then
      begin

        edtContaContabilCR.Visible := True;
        edtContaContabilCR.Text := contaBancoORG.FcontaContabil.Fconta;
        frmContaBancaria2.obterTodos(pIDOrganizacao, frmContaBancaria2.cbbConta, FslistaIdContaDestino);


        frmContaBancaria2.cbbConta.Items.Delete(obterIndiceLista(iDContaOrigem, FslistaIdContaDestino));
        FslistaIdContaDestino.Delete(obterIndiceLista(iDContaOrigem, FslistaIdContaDestino));

      end;

    end;

    msgStatusBar(3, ' Conta origem ' + contaBancoORG.FConta + '  selecionada ');
  end;

end;

procedure TfrmTransferenciasEntreContas.frmContaBancaria2cbbContaChange(
  Sender: TObject);
var
  conta: TContaContabilModel;
  contaBancoDST: TContaBancariaModel;
  indiceDST: Integer;
begin
indiceDST :=0;
    if frmContaBancaria2.cbbConta.ItemIndex > 0 then
    begin

      indiceDST := frmContaBancaria2.cbbConta.ItemIndex;
      iDContaDestino := FslistaIdContaDestino[indiceDST];

      contaBancoDST := TContaBancariaModel.Create;
      contaBancoDST.FIDorganizacao := pIDOrganizacao;
      contaBancoDST.FID := iDContaDestino;
      contaBancoDST := TContaBancariaDAO.obterPorID(contaBancoDST);

      if not uUtil.Empty(contaBancoDST.FID) then
      begin
        contaDestino := contaBancoDST.Fconta;

        if not uUtil.Empty(contaBancoDST.FIDcontaContabil) then
        begin

          edtContaContabilDB.Visible := True;
          edtContaContabilDB.Text := contaBancoDST.FcontaContabil.Fconta;

        end;

      end;

      msgStatusBar(3, ' Conta destino ' + contaBancoDST.Fconta + '  selecionada ');
    end;

end;

procedure TfrmTransferenciasEntreContas.inicializarDM(Sender: TObject);
begin
  dmConexao.conectarBanco;
 {
  if not(Assigned(dmCBT)) then
  begin
    dmCBT := TdmCBT.Create(Self);
  end;
         }

 limpaPanel;

end;

procedure TfrmTransferenciasEntreContas.limpaPanel;
begin
 // status
 limpaStatusBar;

 limpaPanelTransfere;
 limpaPanelEstorna;

  pIDOrganizacao :=uUtil.TOrgAtual.getId;
 //frameResponsavel1.createComboAll('FUNCIONARIO','NOME','NOME',frameResponsavel1.cbbcombo,FslistaIdResponsavel); muda 05/03 pq mostra todos

 frameResponsavel1.obterTodosAtivos(pIDOrganizacao,frameResponsavel1.cbbcombo,FslistaIdResponsavel);

 pIdOperacao := 'TRANSFERENCIA ENTRE CONTAS';
 edtTipoOperacao.Text := pIdOperacao;
 pIdentificacao :=  dmConexao.obterIdentificador('',pIDOrganizacao, 'CBT');
 edtIdentificador.Text := pIdentificacao;

 pDataMovimento := Now;
 pDataRegistro := Now;


//sempre por �ltimo
 frameResponsavel1.cbbcombo.ItemIndex :=0;
 if Assigned(FslistaIdContaOrigem) then FslistaIdContaOrigem.Clear;
 if Assigned(FslistaIdContaDestino) then FslistaIdContaDestino.Clear;

 frmContaBancaria1.obterTodos(pIDOrganizacao, frmContaBancaria1.cbbConta, FslistaIdContaOrigem);
 frmContaBancaria2.obterTodos(pIDOrganizacao, frmContaBancaria2.cbbConta, FslistaIdContaDestino);


end;


procedure TfrmTransferenciasEntreContas.limpaPanelTransfere;
begin

//botoes
 dxBtnTransfere.Enabled := False;
 dxBtnTransfere.Enabled := False;

 //verifica��o do saldo da conta
 chkSaldo.Checked :=False;
 edtSaldoBancario.Clear;
 chkSaldo.Visible := False;
 edtSaldoBancario.Visible := False;
 //combos
 frmContaBancaria1.cbbConta.ItemIndex :=0;
 frmContaBancaria2.cbbConta.ItemIndex :=0;

 edtObservacao.Clear;
 cbbDataMovimento.Date := Now;
 edtIdentificador.Clear;
 edtContaContabilDB.Clear;
 edtContaContabilCR.Clear;
 edtValor.Clear;

 edtContaContabilDB.Visible := False;
 edtContaContabilCR.Visible := False;

end;


procedure TfrmTransferenciasEntreContas.limpaPanelEstorna;
begin

 frmPeriodo1.inicializa(Now,Now);
 edtValorTransf.Clear;
 cbbTransferencias.ItemIndex :=0;
 edtContaOrigem.Clear;
 edtContaDestino.Clear;
 dxBtnEstorno.Enabled := False;


end;

function TfrmTransferenciasEntreContas.validarForm() :Boolean;
var
validar :Boolean;
valor, saldoConta :Currency;

begin
  validar :=True;
  msgStatus :='Pronto';
  msgStatusBar(2,'OBS: ');
  valor := edtValor.Value;
 if (edtValor.Value  = 0) then begin
   validar := false;
   msgStatus := ' Transfer�ncia sem valor. ';
   msgStatusBar(3,msgStatus);
   edtValor.TabOrder := 0;
   edtValor.SetFocus;
 end;


 if ( frameResponsavel1.cbbcombo.ItemIndex = 0)  then begin
    validar := False;
    msgStatus := ' Selecione um respons�vel pela transfer�ncia. ';
   msgStatusBar(3,msgStatus);
 end;

 if ( frmContaBancaria1.cbbConta.ItemIndex = 0)  then begin
    validar := False;
    msgStatus := ' Selecione uma conta para origem da transfer�ncia. ';
    msgStatusBar(3,msgStatus);

 end;


 if ( frmContaBancaria2.cbbConta.ItemIndex = 0)  then begin
    validar := False;
    msgStatus := 'Selecione a conta de destino. ';
    msgStatusBar(3,msgStatus);
 end;

  if validar then begin
    msgStatus := ' Formul�rio validado... a transfer�ncia est� sendo processada. ';
    msgStatusBar(3,msgStatus);
  end;

 Result := validar;
end;

procedure TfrmTransferenciasEntreContas.limpaStatusBar;
begin
msgStatusBar(0, 'Status ');
msgStatusBar(1, 'Ativo ');

end;

procedure TfrmTransferenciasEntreContas.msgStatusBar(pPosicao: Integer; msg: string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;

end;



end.


