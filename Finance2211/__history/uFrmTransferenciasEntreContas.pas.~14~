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
  frxDBSet;

type
  TfrmTransferenciasEntreContas = class(TForm)
    edtValor: TcxMaskEdit;
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
    edtValorTransf: TcxTextEdit;
    cxLabel8: TcxLabel;
    edtContaDestino: TcxTextEdit;
    cxLabel11: TcxLabel;
    dxBarManager1Bar4: TdxBar;
    dxBtnEstorno: TdxBarLargeButton;
    dxBarManager1Bar5: TdxBar;
    dxBtnRelTRF: TdxBarLargeButton;
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
  private
    { Private declarations }
   FsListaIdTransferencia, FslistaIdResponsavel,    FslistaIdContaOrigem,    FslistaIdContaDestino :TStringList;

   contaOrigem, contaDestino, pIdResponsavel, pIdentificacao,  iDContaOrigem, iDContaDestino, pIdOperacao,    pIDOrganizacao :string;
    pDataMovimento, pDataRegistro :TDate;
    procedure limpaPanel;
    procedure inicializarDM(Sender: TObject);
    function validarForm: Boolean;
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
    cbbTransferencias.Items.Add('<<< Selecione uma Transferência  >>>');

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


  if validarData = 1  then   begin // a data do movimento é maior que a data de hoje

    ShowMessage(' a data do movimento não pode ser maior que a data de hoje...');
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


    end;





  end else begin ShowMessage('Escolha uma transferência para estornar...'); cbbTransferencias.ItemIndex :=0; end;

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
        dxStatusTRF.Panels[1].Text := 'Lançamento de transferência estornado. ';
        if (dmCBT.deletaTRF(pIDOrganizacao, 'CONTA_BANCARIA_CREDITO', idCBD)) then
        begin
          Inc(aux);
          dxStatusTRF.Panels[1].Text := 'Lançamento estornado na conta destino. ';
          if (dmCBT.deletaTRF(pIDOrganizacao, 'CONTA_BANCARIA_DEBITO', idCBO)) then
          begin
            Inc(aux);
            dxStatusTRF.Panels[1].Text := 'Lançamento estornado na conta origem. ';
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
pObs, pIdentificacao, pIdTransf, pIdUsuario, pDescricao, pIdOperacao :string;
pValor :Currency;
begin
 pDataRegistro := StrToDate(FormatDatetime('DD/MM/YYYY', Now));
 pDataMovimento:= StrToDate(FormatDatetime('DD/MM/YYYY', cbbDataMovimento.Date));
 pValor := StrToCurr(edtValor.Text);
 pIdOperacao := edtTipoOperacao.Text;
 pDescricao := 'TRANSF CTA ORIG. ' + contaOrigem  + ' CTA DEST. ' + contaDestino ;
 pIdUsuario := uutil.TUserAtual.getUserId;
 pIdTransf := dmCBT.obterNewID;
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
                  ShowMessage('Transferência realizada com sucesso.');

                  dxStatusTRF.Panels[1].Text := 'Pronto. ';

                 end;
 end;




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


end;

procedure TfrmTransferenciasEntreContas.frmContaBancaria1cbbContaChange( Sender: TObject);
  var
  conta : TContaContabilModel;
begin
   conta :=TContaContabilModel.Create;
   iDContaOrigem  := FslistaIdContaOrigem[frmContaBancaria1.cbbConta.ItemIndex];
   conta := frmContaBancaria1.getContaContabil(pIDOrganizacao, iDContaOrigem);

// verificar seo ID da conta confere
    if iDContaOrigem.Equals(dmcbt.obterIDContaBancaria(pIDOrganizacao, iDContaOrigem)) then begin

      edtContaContabilDB.Visible := True;
      edtContaContabilDB.Text := conta.FConta;
      contaOrigem := frmContaBancaria1.cbbConta.Items[frmContaBancaria1.cbbConta.ItemIndex];

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

 //verificar se a conta destino é igual a origem. caso seja, nao permitir.
  if not (iDContaOrigem.Equals(iDContaDestino)) then begin

    conta :=TContaContabilModel.Create;
    conta := frmContaBancaria2.getContaContabil(pIDOrganizacao, iDContaDestino);

// verificar seo ID da conta confere
    if iDContaDestino.Equals(dmcbt.obterIDContaBancaria(pIDOrganizacao, iDContaDestino)) then begin

      edtContaContabilCR.Visible := True;
      edtContaContabilCR.Text := conta.FConta;
      contaDestino := frmContaBancaria2.cbbConta.Items[frmContaBancaria2.cbbConta.ItemIndex];

    end;

     dxStatusTRF.Panels[1].Text := ' Conta destino ' + conta.FConta +'  selecionada ';
  end else begin

      frmContaBancaria2.cbbConta.ItemIndex :=0;
      edtContaContabilCR.Visible := False;
      edtContaContabilCR.Text := '';
      ShowMessage ('O sistema não permite transferência para a conta de destino selecionada. ');


      dxStatusTRF.Panels[1].Text := ' Conta destino parece ser igual a conta de origem. Verifique!! ' + conta.FConta +'  selecionada ';

  end;


end;

procedure TfrmTransferenciasEntreContas.inicializarDM(Sender: TObject);
begin


  if not(Assigned(dmCBT)) then
  begin
    dmCBT := TdmCBT.Create(Self);
  end;

 dmConexao.conectarBanco;
 pIDOrganizacao :=uUtil.TOrgAtual.getId;
 frameResponsavel1.createComboAll('FUNCIONARIO','NOME','NOME',frameResponsavel1.cbbcombo,FslistaIdResponsavel);
 limpaPanel;

end;

procedure TfrmTransferenciasEntreContas.limpaPanel;
begin
{ // edtValor.Properties.EditFormat :='!0.,00; 0.,00;';
 edtValor.Properties.EditMask :='R$ ###,###,##0.0000';
 edtValor.Text := '0,00'; }

 dxStatusTRF.Panels[0].Text := 'Status : ';
 dxStatusTRF.Panels[1].Text := ' Pronto ';
 frmContaBancaria1.cbbConta.ItemIndex :=0;
 frmContaBancaria2.cbbConta.ItemIndex :=0;
 edtContaContabilDB.Text :='';
 edtContaContabilCR.Text :='';
 edtValor.Text :='';
 pDataMovimento := Now;
 pDataRegistro := Now;
 cbbDataMovimento.Date := Now;
 edtIdentificador.Text :='';

 edtContaContabilDB.Visible := False;
 edtContaContabilCR.Visible := False;

  pIdOperacao := 'TRANSFERENCIA ENTRE CONTAS';
 edtTipoOperacao.Text := pIdOperacao;
 pIdentificacao := dmCBT.obterIdentificador(pIDOrganizacao);
 edtIdentificador.Text := pIdentificacao;
 cbbTransferencias.ItemIndex :=0;
 edtValorTransf.Text :='';
 edtContaOrigem.Text :='';
 edtContaDestino.Text :='';


 frmPeriodo1.inicializa(Now,Now);

//sempre por último
 frameResponsavel1.cbbcombo.ItemIndex :=0;
 frmContaBancaria1.obterTodos(pIDOrganizacao, frmContaBancaria1.cbbConta, FslistaIdContaOrigem);
 frmContaBancaria2.obterTodos(pIDOrganizacao, frmContaBancaria2.cbbConta, FslistaIdContaDestino);

end;


function TfrmTransferenciasEntreContas.validarForm() :Boolean;
var
validar :Boolean;
begin
  validar :=True;


 if StrToCurr(edtValor.Text) = 0 then begin
   validar := false;
   dxStatusTRF.Panels[1].Text := ' Transferência sem valor. ';
 end;

 if ( frameResponsavel1.cbbcombo.ItemIndex = 0)  then begin
    validar := False;
    dxStatusTRF.Panels[1].Text := ' Selecione um responsável pela transferência... ';
 end;

 if ( frmContaBancaria1.cbbConta.ItemIndex = 0)  then begin
    validar := False;
    dxStatusTRF.Panels[1].Text := ' Selecione uma conta de origem transferência... ';
 end;

 if ( frmContaBancaria2.cbbConta.ItemIndex = 0)  then begin
    validar := False;
    dxStatusTRF.Panels[1].Text := ' Selecione uma conta de destino transferência... ';
 end;

  if validar then begin
       dxStatusTRF.Panels[1].Text := ' Formulário validado... a transferência está sendo processada. ';
       Sleep(3000);
  end;

 Result := validar;
end;


end.


