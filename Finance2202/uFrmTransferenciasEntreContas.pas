unit uFrmTransferenciasEntreContas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,udmConexao,
  dxSkinsCore, dxSkinsDefaultPainters, dxCore, cxDateUtils, Vcl.Menus, uUtil, System.DateUtils,
  cxButtons, cxDropDownEdit, cxCalendar, cxMaskEdit, cxTextEdit, cxLabel,
  uFrameContaBancaria, Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option, uFrmRelatorioTransferencias,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, uDMContaBancariaTransferencia,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uContaContabilModel,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, dxStatusBar,
  dxRibbonSkins, dxRibbonCustomizationForm, dxBar, cxClasses, dxRibbon, cxMemo,
  cxRichEdit, cxBarEditItem, dxBarBuiltInMenu, cxPC, cxImage, cxDBEdit,
  uFrameGeneric, uFrameResponsavel, uFramePeriodo, Vcl.Buttons, frxClass,
  frxDBSet, ENumEd;

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
    dxStatusTRF: TdxStatusBar;
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
   FsListaIdTransferencia, FslistaIdResponsavel,    FslistaIdContaOrigem,    FslistaIdContaDestino :TStringList;

   contaOrigem, contaDestino, pIdResponsavel, pIdentificacao,  iDContaOrigem, iDContaDestino, pIdOperacao,    pIDOrganizacao :string;
    pDataMovimento, pDataRegistro :TDate;
    procedure limpaPanel;
    procedure limpaPanelEstorna;
    procedure inicializarDM(Sender: TObject);
    function validarForm: Boolean;
    procedure limpaPanelTransfere;

  public
    { Public declarations }
  end;

var
  frmTransferenciasEntreContas: TfrmTransferenciasEntreContas;

implementation

{$R *.dfm}

procedure TfrmTransferenciasEntreContas.btnBuscaTRFClick(Sender: TObject);
begin

  if dmCBT.obterPorPeriodo(pIDOrganizacao, frmPeriodo1.getDataInicial, frmPeriodo1.getDataFinal) then begin

    FsListaIdTransferencia := TStringList.Create;
    FsListaIdTransferencia.Clear;
    FsListaIdTransferencia.Add('Sem ID');
    cbbTransferencias.Clear;
    cbbTransferencias.Items.Add('<<< Selecione uma Transfer�ncia  >>>');

   if not (dmCBT.qryObterPorPeriodo.IsEmpty) then begin
        dmCBT.qryObterPorPeriodo.First;

      while not dmCBT.qryObterPorPeriodo.Eof do
        begin
          cbbTransferencias.Items.Add((dmCBT.qryObterPorPeriodo.FieldByName('IDENTIFICACAO').AsString)+ ' - ' +(dmCBT.qryObterPorPeriodo.FieldByName('VALOR').AsString)  );
          FsListaIdTransferencia.Add(dmCBT.qryObterPorPeriodo.FieldByName('ID_CONTA_BANCARIA_TRANSFERENCIA').AsString);
          dmCBT.qryObterPorPeriodo.Next;
        end;
    //  dmCBT.qryObterPorPeriodo.Close;
      cbbTransferencias.ItemIndex := 0;


   end;

  end;
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

    ShowMessage(' a data do movimento n�o pode ser maior que a data de hoje...');
    dxStatusTRF.Panels[1].Text := 'Erro na data de movimento. ';

  end;


end;

procedure TfrmTransferenciasEntreContas.cbbTransferenciasChange(
  Sender: TObject);
begin

  if cbbTransferencias.ItemIndex >0  then begin

    if (dmCBT.obterTransferencia(pIDOrganizacao,FsListaIdTransferencia[cbbTransferencias.ItemIndex])) then begin

       edtValorTransf.Text := CurrToStr(dmCBT.qryObterTRFPORID.FieldByName('VALOR').AsCurrency);
       edtContaOrigem.Text := dmCBT.qryObterTRFPORID.FieldByName('CONTAORIGEM').AsString  + ' ' + dmCBT.qryObterTRFPORID.FieldByName('TITULARORIGEM').AsString;
       edtContaDestino.Text := dmCBT.qryObterTRFPORID.FieldByName('CONTADESTINO').AsString  + ' ' + dmCBT.qryObterTRFPORID.FieldByName('TITULARDESTINO').AsString;

         dxBtnTransfere.Enabled := False;
         dxBtnEstorno.Enabled := True;

    end;


  end else begin ShowMessage('Escolha uma transfer�ncia para estornar...'); cbbTransferencias.ItemIndex :=0; end;

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
idCBt, idCBO, idCBD :string;
aux :Integer;

begin
aux :=0;
  if cbbTransferencias.ItemIndex >0  then begin
    if (dmCBT.obterTransferencia(pIDOrganizacao,FsListaIdTransferencia[cbbTransferencias.ItemIndex])) then begin
       idCBD := dmCBT.qryObterTRFPORID.FieldByName('ID_CONTA_BANCARIA_CREDITO').AsString ;
       idCBO := dmCBT.qryObterTRFPORID.FieldByName('ID_CONTA_BANCARIA_DEBITO').AsString ;
       idCBt := dmCBT.qryObterTRFPORID.FieldByName('ID_CONTA_BANCARIA_TRANSFERENCIA').AsString ;

      if (dmCBT.deletaTRF(pIDOrganizacao, 'CONTA_BANCARIA_TRANSFERENCIA', idCBt)) then
      begin
        Inc(aux);
        dxStatusTRF.Panels[1].Text := 'Lan�amento de transfer�ncia estornado. ';
        if (dmCBT.deletaTRF(pIDOrganizacao, 'CONTA_BANCARIA_CREDITO', idCBD)) then
        begin
          Inc(aux);
          dxStatusTRF.Panels[1].Text := 'Lan�amento estornado na conta destino. ';
          if (dmCBT.deletaTRF(pIDOrganizacao, 'CONTA_BANCARIA_DEBITO', idCBO)) then
          begin
            Inc(aux);
            dxStatusTRF.Panels[1].Text := 'Lan�amento estornado na conta origem. ';
          end;
        end;
      end;
    end;
  end;

  if aux=3 then begin
      limpaPanel;
      dxStatusTRF.Panels[1].Text := 'Pronto. ';
      ShowMessage('Estorno realizado com sucesso..');

  end;

  btnBuscaTRF.Click;
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
begin
 pDataRegistro := StrToDate(FormatDatetime('DD/MM/YYYY', Now));
 pDataMovimento:= StrToDate(FormatDatetime('DD/MM/YYYY', cbbDataMovimento.Date));
 pValor := StrToCurr(edtValor.Text);
 pIdOperacao := edtTipoOperacao.Text;
 pDescricao := 'TRANSF CTA ORIG. ' + contaOrigem  + ' CTA DEST. ' + contaDestino ;
 pIdUsuario := uutil.TUserAtual.getUserId;
 pIdTransf := dmConexao.obterNewID;
 pIdentificacao := dmConexao.obterIdentificador('',PIDORGANIZACAO,'CBT');
 pIdentificacao := edtIdentificador.Text;
 pObs := edtObservacao.Text;

 if validarForm then begin

   //registra a conta credito e a conta debito


  if dmCBT.insereCBT(pIdTransf,
                 pIDOrganizacao,
                 iDContaDestino,
                 iDContaOrigem,
                 pIdOperacao,
                 pIdResponsavel,
                 pIdentificacao,
                 pObs,
                 pDescricao,
                 StrToInt(pIdUsuario),
                 pValor,
                 pDataRegistro,
                 pDataMovimento   ) then begin
                  limpaPanel;
                  ShowMessage('Transfer�ncia realizada com sucesso.');

                  dxStatusTRF.Panels[1].Text := 'Pronto. ';

                 end;
 end;

 limpaPanel;

end;


procedure TfrmTransferenciasEntreContas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(dmCBT);
 Action := caFree;
end;

procedure TfrmTransferenciasEntreContas.FormCreate(Sender: TObject);
begin
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
  conta : TContaContabilModel;
  SDconta : Currency;
begin
   conta :=TContaContabilModel.Create;
   iDContaOrigem  := FslistaIdContaOrigem[frmContaBancaria1.cbbConta.ItemIndex];
   conta := frmContaBancaria1.getContaContabil(pIDOrganizacao, iDContaOrigem);
   //SDconta :=   '  R$ ' + FormatCurr('###,##0.00', saldoConta);
   SDconta := dmCBT.obterSaldoContaBancaria(pIDOrganizacao,FslistaIdContaOrigem[frmContaBancaria1.cbbConta.ItemIndex],  IncYear(Now, -25),cbbDataMovimento.Date);


// verificar seo ID da conta confere
    if iDContaOrigem.Equals(dmcbt.obterIDContaBancaria(pIDOrganizacao, iDContaOrigem)) then begin

      edtContaContabilCR.Visible := True;
      edtContaContabilCR.Text := conta.FConta;
      contaOrigem := frmContaBancaria1.cbbConta.Items[frmContaBancaria1.cbbConta.ItemIndex];
      edtObservacao.Text := 'SD DA CONTA ORIGEM  R$ ' + FormatCurr('###,##0.00',SDconta);

    end;



 dxStatusTRF.Panels[1].Text := ' Conta origem ' + conta.FConta +'  selecionada ';
end;

procedure TfrmTransferenciasEntreContas.frmContaBancaria2cbbContaChange(
  Sender: TObject);
  var
    conta : TContaContabilModel;
begin

   iDContaOrigem  := FslistaIdContaOrigem[frmContaBancaria1.cbbConta.ItemIndex];
   iDContaDestino := FslistaIdContaDestino[frmContaBancaria2.cbbConta.ItemIndex];

 //verificar se a conta destino � igual a origem. caso seja, nao permitir.
  if not (iDContaOrigem.Equals(iDContaDestino)) then begin

    conta :=TContaContabilModel.Create;
    conta := frmContaBancaria2.getContaContabil(pIDOrganizacao, iDContaDestino);

// verificar seo ID da conta confere
    if iDContaDestino.Equals(dmcbt.obterIDContaBancaria(pIDOrganizacao, iDContaDestino)) then begin

      edtContaContabilDB.Visible := True;
      edtContaContabilDB.Text := conta.FConta;
      contaDestino := frmContaBancaria2.cbbConta.Items[frmContaBancaria2.cbbConta.ItemIndex];

    end;

     dxStatusTRF.Panels[1].Text := ' Conta destino ' + conta.FConta +'  selecionada ';
  end else begin

      frmContaBancaria2.cbbConta.ItemIndex :=0;
      edtContaContabilDB.Visible := False;
      edtContaContabilDB.Text := '';
      ShowMessage ('O sistema n�o permite transfer�ncia para a conta de destino selecionada. ');


      dxStatusTRF.Panels[1].Text := ' Conta destino parece ser igual a conta de origem. Verifique!! ' + conta.FConta +'  selecionada ';

  end;


end;

procedure TfrmTransferenciasEntreContas.inicializarDM(Sender: TObject);
begin
  dmConexao.conectarBanco;

  if not(Assigned(dmCBT)) then
  begin
    dmCBT := TdmCBT.Create(Self);
  end;


 limpaPanel;

end;

procedure TfrmTransferenciasEntreContas.limpaPanel;
begin
 // status
  pIDOrganizacao :=uUtil.TOrgAtual.getId;
 frameResponsavel1.createComboAll('FUNCIONARIO','NOME','NOME',frameResponsavel1.cbbcombo,FslistaIdResponsavel);

 dxStatusTRF.Panels[0].Text := 'Status : ';
 dxStatusTRF.Panels[1].Text := ' Pronto ';

 pIdOperacao := 'TRANSFERENCIA ENTRE CONTAS';
 edtTipoOperacao.Text := pIdOperacao;
 pIdentificacao :=  dmConexao.obterIdentificador('',pIDOrganizacao, 'CBT');
 edtIdentificador.Text := pIdentificacao;

 pDataMovimento := Now;
 pDataRegistro := Now;

 limpaPanelTransfere;
 limpaPanelEstorna;

//sempre por �ltimo
 frameResponsavel1.cbbcombo.ItemIndex :=0;
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
saldoConta :Currency;
begin
  validar :=True;


 if StrToCurr(edtValor.Text) = 0 then begin
   validar := false;
   dxStatusTRF.Panels[1].Text := ' Transfer�ncia sem valor. ';
 end;

 if ( frameResponsavel1.cbbcombo.ItemIndex = 0)  then begin
    validar := False;
    dxStatusTRF.Panels[1].Text := ' Selecione um respons�vel pela transfer�ncia... ';
 end;

 if ( frmContaBancaria1.cbbConta.ItemIndex = 0)  then begin
    validar := False;
    dxStatusTRF.Panels[1].Text := ' Selecione uma conta de origem transfer�ncia... ';
 end;

         {if not chkSaldo.Checked then begin

         if ( frmContaBancaria1.cbbConta.ItemIndex > 0)  then begin

            saldoConta := dmCBT.obterSaldoContaBancaria(pIDOrganizacao,FslistaIdContaOrigem[frmContaBancaria1.cbbConta.ItemIndex],  IncYear(Now, -25),cbbDataMovimento.Date);

              if StrToCurr(edtValor.Text) > 0 then
              begin

                if StrToCurr(edtValor.Text) > saldoConta then
                begin

                  edtSaldoBancario.Text := 'O saldo da conta ' + frmContaBancaria1.cbbConta.Items[frmContaBancaria1.cbbConta.ItemIndex] + '  �  insuficiente. Se desejar prosseguir, confirme  aqui >>>! ';
                  edtObservacao.Text := ' SD CONTA ' + frmContaBancaria1.cbbConta.Items[frmContaBancaria1.cbbConta.ItemIndex] + '  R$ ' + FormatCurr('###,##0.00', saldoConta);
                  edtSaldoBancario.Visible := True;
                  edtSaldoBancario.Enabled := False;
                  chkSaldo.Visible := True;
                  validar := False;
                  dxStatusTRF.Panels[1].Text := 'Saldo da conta � insuficiente. Confirme ou cancele! ';

                end;
              end;

         end;
         end; }

 if ( frmContaBancaria2.cbbConta.ItemIndex = 0)  then begin
    validar := False;
    dxStatusTRF.Panels[1].Text := ' Selecione uma conta de destino transfer�ncia... ';
 end;

  if validar then begin
       dxStatusTRF.Panels[1].Text := ' Formul�rio validado... a transfer�ncia est� sendo processada. ';
       Sleep(1000);
  end;

 Result := validar;
end;



end.


