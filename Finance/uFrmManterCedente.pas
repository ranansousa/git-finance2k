unit uFrmManterCedente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinsDefaultPainters, udmConexao, uUtil, uDMOrganizacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins, uFrmManterTipoCedente,
  dxRibbonCustomizationForm, dxStatusBar, cxClasses, dxRibbon, dxBar,  uContaContabilModel,uEnderecoModel,uContatoModel,
  uFrameContaContabil, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, System.StrUtils,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, MDDAO, uContaContabilDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, cxContainer,uCedenteModel, uCedenteDAO,
  cxEdit, cxTextEdit, cxBarEditItem, EMsgDlg, dxBarBuiltInMenu, cxPC, uContatoDAO,  uEnderecoDAO,
  uFrameBanco, uFrameGeneric, uFrameEstado, uFrameBairro, uFrameCidade,
  uFrameTipoCedente, EChkCNPJ, uFrameCartaoCredito, Vcl.ComCtrls;

type
  TfrmManterCedente = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    frmContaContabil1: TfrmContaContabil;
    dbgrd1: TDBGrid;
    dsCedente: TDataSource;
    edtCODREDUZ: TEdit;
    lbl1: TLabel;
    edtContaContabil: TEdit;
    lbl2: TLabel;
    edtNomeCedente: TEdit;
    edtCNPJCPF: TEdit;
    lblCPFCNPJ: TLabel;
    dxBarManager1Bar1: TdxBar;
    dxBtnEditar: TdxBarLargeButton;
    dxBarSalvar: TdxBar;
    dxBtnSalvar: TdxBarLargeButton;
    dxBarManager1Bar2: TdxBar;
    dxBtnNovo: TdxBarLargeButton;
    dxBarManager1Bar3: TdxBar;
    dxBtnFechar: TdxBarLargeButton;
    dxBarManager1Bar4: TdxBar;
    dxBtnDeletar: TdxBarLargeButton;
    dxBarManager1Bar5: TdxBar;
    cxbrdtmPesquisa: TcxBarEditItem;
    qryPreencheGrid: TFDQuery;
    cxpgcntrlPage: TcxPageControl;
    tbTransfereCedente: TcxTabSheet;
    tbTransfereEndereco: TcxTabSheet;
    tbTransfereContato: TcxTabSheet;
    tbTransfereContaBancaria: TcxTabSheet;
    tbTransfereContaContabil: TcxTabSheet;
    edtAgencia: TEdit;
    edtConta: TEdit;
    lblAge: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    edtCelular: TEdit;
    lbl9: TLabel;
    edtTelFixo: TEdit;
    lbl10: TLabel;
    edtEmail: TEdit;
    lbl12: TLabel;
    frmEstado1: TfrmEstado;
    frmCidade1: TfrmCidade;
    frmBairro1: TfrmBairro;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    edtCEP: TEdit;
    lbl16: TLabel;
    edtLogradouro: TEdit;
    edtNumero: TEdit;
    edtComplemento: TEdit;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    lbl21: TLabel;
    frmTipoCedente1: TfrmTipoCedente;
    cbbPersonalidade: TComboBox;
    lbl5: TLabel;
    edtInscEstadual: TEdit;
    edtCGA: TEdit;
    edtInscMunicipal: TEdit;
    lbl22: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    dbgrdBanco: TDBGrid;
    lbl23: TLabel;
    dsBanco: TDataSource;
    qryGridBanco: TFDQuery;
    frmCartaoCredito1: TfrmCartaoCredito;
    lbl8: TLabel;
    frmBanco1: TfrmBanco;
    edtCodigo: TEdit;
    lbl11: TLabel;
    edtStatus: TEdit;
    lbl24: TLabel;
    dtpRegistro: TDateTimePicker;
    lbl25: TLabel;
    dxBarManager1Bar6: TdxBar;
    dxBtnLimpar: TdxBarLargeButton;
    PempecMsg: TEvMsgDlg;
    dxBtnContaContabil: TdxBarLargeButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dsCedenteDataChange(Sender: TObject; Field: TField);
    procedure frmContaContabil1cbbContaContabilChange(Sender: TObject);
    procedure dxBtnEditarClick(Sender: TObject);
    procedure dxBtnSalvarClick(Sender: TObject);
    procedure dxBtnFecharClick(Sender: TObject);
    procedure dxBtnNovoClick(Sender: TObject);
    procedure dxBtnDeletarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrd1TitleClick(Column: TColumn);
    procedure cxbrdtmPesquisaCurChange(Sender: TObject);
    procedure edtCelularExit(Sender: TObject);
    procedure frmEstado1cbbcomboChange(Sender: TObject);
    procedure frmTipoCedente1cbbcomboChange(Sender: TObject);
    procedure frmCidade1cbbcomboChange(Sender: TObject);
    procedure frmBairro1cbbcomboChange(Sender: TObject);
    procedure edtCNPJCPFExit(Sender: TObject);
    procedure cbbPersonalidadeChange(Sender: TObject);
    procedure dsBancoDataChange(Sender: TObject; Field: TField);
    procedure dbgrdBancoTitleClick(Column: TColumn);
    procedure tbTransfereContaBancariaShow(Sender: TObject);
    procedure tbTransfereContaContabilShow(Sender: TObject);
    procedure tbTransfereContatoShow(Sender: TObject);
    procedure tbTransfereEnderecoShow(Sender: TObject);
    procedure tbTransfereCedenteShow(Sender: TObject);
    procedure tbTransfereEnderecoExit(Sender: TObject);
    procedure dxBtnLimparClick(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
    procedure frmCartaoCredito1cbbCartaoChange(Sender: TObject);

  private
    { Private declarations }
  pPersonalidade,  pIdCartaoCredito, pIdContaContabil, pIdCedente,pIdTipo, pIdEndereco, pIdContato,  pIdOrganizacao, pIdUsuario :string;
  pIdBanco,  pIdCidade, pIdEstado,pIdBairro :string;

 FsListaCartaoCredito, FsListaPersonalidade,  FslistaTipo,    FsListaIdContas : TStringList;
   FslistaIdBanco,    FsListaIdEstado,FsListaIdCidade,FsListaIdBairro : TStringList;

    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    procedure preencheComboTipo;
    function salvar(cedenteModel :TCedenteModel): Boolean;
    function salvarEndereco(enderecoModel : TEnderecoModel) : Boolean;   //sem uso
    function salvarContato (contatoModel :TContatoModel) :Boolean; //sem uso
    function obterCodigo() :string;

    function qtdUso(pIdOrganizacao, pIdCedente: string): Integer;
    procedure preencheComboPersonalidade;
    procedure preencheComboCartao;

    procedure preencheGrid(pIdOrganizacao :string);

    function obterPersonalidade(pPersonalidade: String): Integer;
    function obterTipoCedente(pTipo: String): Integer;
    procedure preecheGridBanco;
    function obterCartaoCreditoPorID(pIdOrganizacao, pIdEndereco: string): TFDQuery;

    function obterEnderecoPorId(pIdOrganizacao, pIdEndereco: string): TFDQuery;
    procedure preencheAbaEndereco(query: TFDQuery);
    procedure preencheAbaContato(query: TFDQuery);

    function obterContatoPorId(pIdOrganizacao, pIdContato: string): TFDQuery;

    procedure limparAba(aba: TcxTabSheet);
    function retornaIndiceCbbBanco(_pIdBanco: string): Integer;
    function obterCedentePorId(pIdOrganizacao,   pIdCedente: String): TCedenteModel;
    function isValidForm: Boolean;
    function deletaEndereco(pOrganizacao, pEndereco: string): Boolean;
    function deletarContato(pOrganizacao, pContato: string): Boolean;
    procedure registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
    function isValidAbaEndereco: Boolean;
    function isValidAbaContato: Boolean;
    procedure cadastraTipoCedente;




  public
    { Public declarations }


  end;

var
  frmManterCedente: TfrmManterCedente;

implementation

{$R *.dfm}

procedure TfrmManterCedente.cbbPersonalidadeChange(Sender: TObject);
begin
if cbbPersonalidade.ItemIndex >0 then
 edtCNPJCPF.Enabled := true;
 pPersonalidade := FsListaPersonalidade[cbbPersonalidade.ItemIndex];
end;

procedure TfrmManterCedente.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
  dbgrd1.DataSource.DataSet.Locate('NOME',UpperCase(cxbrdtmPesquisa.CurEditValue),[loPartialKey]);
end;

procedure TfrmManterCedente.dbgrd1TitleClick(Column: TColumn);
begin
 (dbgrd1.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

procedure TfrmManterCedente.dbgrdBancoTitleClick(Column: TColumn);
begin
 (dbgrdBanco.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;


procedure TfrmManterCedente.dsBancoDataChange(Sender: TObject; Field: TField);
begin

  pIdBanco := qryGridBanco.FieldByName('ID_BANCO').AsString;
  frmBanco1.cbbBanco.ItemIndex := retornaIndiceCbbBanco(pIdBanco) ;

end;

function TfrmManterCedente.retornaIndiceCbbBanco(_pIdBanco :string) :Integer;
 var
indice :Integer;
  I: Integer;
begin
  indice :=0;

   for I := 0 to FslistaIdBanco.Count -1 do begin
     if FslistaIdBanco[I].Equals(_pIdBanco) then begin
        indice := I;
        Break
     end;
  end;

   Result := indice;

end;



procedure TfrmManterCedente.dsCedenteDataChange(Sender: TObject;
  Field: TField);
  var
  idContaContabil :string;
  I: Integer;
  conta :TContaContabilModel;
  cedenteModel :TCedenteModel;


begin

      limparAba(Self.tbTransfereCedente);
      limparAba(Self.tbTransfereEndereco);
      limparAba(Self.tbTransfereContato);
      limparAba(Self.tbTransfereContaBancaria);
      limparAba(Self.tbTransfereContaContabil);
      frmContaContabil1.cbbContaContabil.ItemIndex := 0;
      frmCartaoCredito1.cbbCartao.ItemIndex := 0;
      frmBanco1.cbbBanco.ItemIndex := 0;
      frmEstado1.cbbcombo.ItemIndex := 0;
      frmCidade1.cbbcombo.ItemIndex := 0;
      frmBairro1.cbbcombo.ItemIndex := 0;
      frmTipoCedente1.cbbcombo.ItemIndex := 0;
      cbbPersonalidade.ItemIndex := 0;
      dtpRegistro.Date := Now;

     pIdCedente     := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CEDENTE').AsString;
     pIdOrganizacao := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_ORGANIZACAO').AsString;
     cedenteModel := TCedenteModel.Create;
     cedenteModel.FIDorganizacao := pIdOrganizacao;
     cedenteModel.FID := pIdCedente;


  //   cedenteModel := obterCedentePorId(pIdOrganizacao, pIdCedente); //mudando em 260320
       cedenteModel := TCedenteDAO.obterPorID(cedenteModel);

     if uutil.Empty(cedenteModel.FID) then begin
       PempecMsg.MsgWarning('N�o foi poss�vel obter os dados do cedente. Verifique se digitou o nome corretamente...');
     end ;
   //come�a
     edtNomeCedente.Text     := cedenteModel.Fnome;
     edtCGA.Text             := cedenteModel.Fcga;
     edtInscEstadual.Text    := cedenteModel.FinscricaoEstadual;
     edtInscMunicipal.Text   := cedenteModel.FinscricaoMunicipal;
     edtAgencia.Text         := cedenteModel.Fagencia;
     edtConta.Text           := cedenteModel.Fconta;

     edtStatus.Text          := cedenteModel.FStatus;
     edtCodigo.Text          := cedenteModel.FCodigo ;
     dtpRegistro.Date        := cedenteModel.FDataRegistro;
     pPersonalidade          := cedenteModel.Fpersonalidade;

     pIdBanco                := cedenteModel.FIDbanco;
     idContaContabil         := cedenteModel.FIDcontaContabil;
     pIdEndereco             := cedenteModel.FIDendereco;
     pIdContato              := cedenteModel.FIDcontato;
     pIdCartaoCredito        := cedenteModel.FIDcartaoCreditoModel;
     pIdTipo                 := cedenteModel.FIDtipoCedente;


      Self.dxRibbon1Tab1.Caption := 'Manuten��o do cadastro de : ' + UpperCase(edtNomeCedente.Text);
      frmBanco1.cbbBanco.ItemIndex := retornaIndiceCbbBanco(pIdBanco);
      cbbPersonalidade.ItemIndex := obterPersonalidade(cedenteModel.Fpersonalidade);
      frmTipoCedente1.cbbcombo.ItemIndex := obterTipoCedente(cedenteModel.FIDtipoCedente);

      if not uutil.Empty(pIdCartaoCredito) then
      begin
        preencheComboCartao;
      end;


     if cbbPersonalidade.ItemIndex = 1 then begin
       //cpf
       edtCNPJCPF.Text := uutil.TFormat.formacpf(cedenteModel.FcpfCnpj);
     end;

      if cbbPersonalidade.ItemIndex = 2 then begin
       //cnpj
       edtCNPJCPF.Text := uutil.TFormat.formacnpj(cedenteModel.FcpfCnpj);
     end;

       //OBTER ENDERECO
    if not uutil.Empty(pIdEndereco) then
    begin
      preencheAbaEndereco(obterEnderecoPorId(pIdOrganizacao, pIdEndereco));
    end;

      //  OBTER CONTATO
    if not uutil.Empty(pIdContato) then
    begin
      preencheAbaContato(obterContatoPorId(pIdOrganizacao, pIdContato));
    end;

   // OBTER CONTA CONTABIL
  if not uUtil.Empty(idContaContabil) then
  begin

    for I := 0 to FsListaIdContas.Count - 1 do
    begin
      if FsListaIdContas[I].Equals(idContaContabil) then
      begin
        frmContaContabil1.cbbContaContabil.ItemIndex := I;
        conta := TContaContabilModel.Create;
        conta := frmContaContabil1.obterPorID(pIdOrganizacao, idContaContabil);

        if not uUtil.Empty(conta.FCodigoReduzido) then
        begin
              // edtDescricaoConta.Text := conta.FDescricao;
          edtCODREDUZ.Text := conta.FCodigoReduzido;
          edtContaContabil.Text := conta.FConta;
        end;

      end;
    end;

  end
  else
  begin
    frmContaContabil1.cbbContaContabil.ItemIndex := 0;
   // edtDescricaoConta.Clear;
    edtCODREDUZ.Clear;
    edtContaContabil.Clear;
  end;

  //VERIFICA SE PODE DELETAR
    if qtdUso(pIdOrganizacao, pIdCedente) = 0 then
    begin
      dxBtnDeletar.Enabled := True;
    end
    else
    begin
      dxBtnDeletar.Enabled := False;
    end;

     dxBtnEditar.Enabled := True;

end;

procedure TfrmManterCedente.dxBtnDeletarClick(Sender: TObject);
var
  cedenteModel: TCedenteModel;
begin
  if not dmConexao.conn.InTransaction then
    dmConexao.conn.StartTransaction;

  try

    cedenteModel := TCedenteModel.Create;
    cedenteModel.FIDorganizacao := pIdOrganizacao;
    cedenteModel.FID := pIdCedente;
    cedenteModel := TCedenteDAO.obterPorID(cedenteModel);

    if not uUtil.Empty(cedenteModel.FID) then
    begin
      if TCedenteDAO.Delete(cedenteModel) then
      begin
        registraMovimentacao(pIDOrganizacao, 'CEDENTE', 'DELETAR CEDENTE', uutil.TUserAtual.getNameUser + ' DELETOU ' + cedenteModel.Fnome, 'DELETADO');
        PempecMsg.MsgInformation('Cedente : ' + cedenteModel.Fnome + ' deletado com sucesso.');
      end;
    end;

    if dmConexao.conn.InTransaction then
      dmConexao.conn.CommitRetaining;

  except
    if dmConexao.conn.InTransaction then
      dmConexao.conn.RollbackRetaining;

  end;

  limparPanel;

end;

procedure TfrmManterCedente.dxBtnEditarClick(Sender: TObject);

begin
  dbgrd1.Enabled     :=False;
  dbgrdBanco.Enabled :=True;

  frmContaContabil1.cbbContaContabil.Enabled :=True;
  cxbrdtmPesquisa.Enabled :=False;

  pIdCedente :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CEDENTE').AsString;

  cxbrdtmPesquisa.Enabled :=False;
  edtCNPJCPF.Enabled := True;

  dxBtnSalvar.Enabled  :=True ;
  dxBtnNovo.Enabled    :=False;
  dxBtnDeletar.Enabled :=False;

end;

procedure TfrmManterCedente.dxBtnFecharClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManterCedente.dxBtnLimparClick(Sender: TObject);
begin
limparPanel;
  frmContaContabil1.cbbContaContabil.ItemIndex :=0;
  frmCartaoCredito1.cbbCartao.ItemIndex :=0;
  frmBanco1.cbbBanco.ItemIndex :=0;
  frmEstado1.cbbcombo.ItemIndex :=0;
  frmCidade1.cbbcombo.ItemIndex :=0;
  frmBairro1.cbbcombo.ItemIndex :=0;
  frmTipoCedente1.cbbcombo.ItemIndex :=0;
  cbbPersonalidade.ItemIndex :=0;
  dtpRegistro.Date := Now;



end;

procedure TfrmManterCedente.dxBtnNovoClick(Sender: TObject);
begin
  limparPanel;

  {limparAba(Self.tbTransfereCedente);
  limparAba(Self.tbTransfereEndereco);
  limparAba(Self.tbTransfereContato);
  limparAba(Self.tbTransfereContaBancaria);
  limparAba(Self.tbTransfereContaContabil);}

  dbgrd1.Enabled :=False;
 (dbgrd1.DataSource.DataSet as TFDQuery).Close;
  frmContaContabil1.cbbContaContabil.Enabled :=True;
  frmContaContabil1.cbbContaContabil.ItemIndex :=0;
  frmBanco1.cbbBanco.ItemIndex :=0;
  frmTipoCedente1.cbbcombo.ItemIndex :=0;
  frmEstado1.cbbcombo.ItemIndex :=0;
  frmCidade1.cbbcombo.ItemIndex :=0;
  frmBairro1.cbbcombo.ItemIndex :=0;

  dxBtnSalvar.Enabled      :=True;
  dxBtnEditar.Enabled      :=False;
  pIdCedente :='';
  cxbrdtmPesquisa.Enabled :=False;
  edtCodigo.Text := obterCodigo;


end;

procedure TfrmManterCedente.dxBtnSalvarClick(Sender: TObject);
var
 conta :TContaContabilModel;
 pDescricao, pTipo :string;
 pCodigo  :Integer;
 cedente  : TCedenteModel;
 endereco : TEnderecoModel;
 contato  : TContatoModel;
sucesso : Boolean;

begin
   sucesso := True;
   dxBtnNovo.Enabled := False;
   dxBtnEditar.Enabled := False;
   dxBtnDeletar.Enabled := False;

  dmConexao.conectarBanco;
  if not dmConexao.conn.InTransaction then
         dmConexao.conn.StartTransaction;


 try
  //SALVADR ENDERECO
    if isValidForm then
    begin

      if not uutil.Empty(edtLogradouro.Text) then
      begin
        sucesso := False;
        endereco := TEnderecoModel.Create;
        endereco.FID := pIdEndereco;
        endereco.FIDorganizacao := pIdOrganizacao;
        endereco.FLOGRADOURO := edtLogradouro.Text;
        endereco.FIDCIDADE := pIdCidade;
        endereco.FCEP := edtCEP.Text;
        endereco.FNUMERO := edtNumero.Text;
        endereco.FIDBAIRRO := pIdBairro;
        endereco.FIDESTADO := pIdEstado;
        endereco.FCOMPLEMENTO := edtComplemento.Text;

        if isValidAbaEndereco then
        begin
         sucesso := salvarEndereco(endereco);
        end;

      end;

    // Salvar CONTATO


      contato                  := TContatoModel.Create;
      contato.FID              := pIdContato;
      contato.FIDorganizacao   := pIdOrganizacao;
      contato.FEmail           := edtEmail.Text;
      contato.FCelular         := edtCelular.Text;
      contato.FTelefone        := edtTelFixo.Text;

      if isValidAbaContato then
      begin
        sucesso := False;
       sucesso :=  salvarContato(contato);
      end;

      if uUtil.Empty(pIdCedente) then pIdCedente := dmConexao.obterNewID;


      cedente                       := TCedenteModel.Create;
      cedente.FIDorganizacao        := pIdOrganizacao;
      cedente.FID                   := pIdCedente;

      cedente := TCedenteDAO.obterPorID(cedente);

      if uUtil.Empty(cedente.FID) then
      begin
        cedente.FIDorganizacao := pIdOrganizacao;
        cedente.FID := pIdCedente;
        cedente.Fnovo := True;
      end;

      cedente.Fcga := edtCGA.Text;
      cedente.FinscricaoEstadual    := edtInscEstadual.Text;
      cedente.FinscricaoMunicipal   := edtInscMunicipal.Text;
      cedente.FIDcontaContabil      := pIdContaContabil; // FsListaIdContas[frmContaContabil1.cbbContaContabil.ItemIndex];
      cedente.FIDendereco           := pIdEndereco;
      cedente.FIDcontato            := pIdContato;
      cedente.FIDcartaoCreditoModel := '';
      if not uutil.Empty(pIdCartaoCredito) then begin
      cedente.FIDcartaoCreditoModel := pIdCartaoCredito;
      end;

      cedente.Fagencia              := edtAgencia.Text;
      cedente.Fconta                := edtConta.Text;
      cedente.FIDbanco              := pIdBanco;
      cedente.Fnome                 := UpperCase(TrimLeft(edtNomeCedente.Text));
      cedente.Fpersonalidade        := FsListaPersonalidade[cbbPersonalidade.ItemIndex];

      cedente.FIDtipoCedente        := pIdTipo;

      cedente.FcpfCnpj              := edtCNPJCPF.Text;
      cedente.FIDorganizacao        := pIdOrganizacao;
      cedente.FStatus               := UpperCase(edtStatus.Text);
      cedente.FCodigo               := edtCodigo.Text;
      cedente.FDataUltimaAtualizacao := Now;
      cedente.FDataRegistro         := dtpRegistro.Date;

      if sucesso then
      begin

        if cedente.Fnovo then
        begin

          if TCedenteDAO.Insert(cedente) then
          begin

            PempecMsg.MsgInformation('Cedente : ' + (cedente.Fnome) + '  salvo com sucesso.');
            registraMovimentacao(pIDOrganizacao, 'CEDENTE', 'MANTER CEDENTE', uutil.TUserAtual.getNameUser + ' SALVOU ' + cedente.FCodigo + ' ' + cedente.Fnome, 'MANTIDO');
          end;
        end
        else
        begin
          if TCedenteDAO.Update(cedente) then
          begin
            PempecMsg.MsgInformation('Cedente : ' + (cedente.Fnome) + '  salvo com sucesso.');
            registraMovimentacao(pIDOrganizacao, 'CEDENTE', 'MANTER CEDENTE', uutil.TUserAtual.getNameUser + ' ALTEROU ' + cedente.FCodigo + ' ' + cedente.Fnome, 'ALTERADO');
          end;

        end;
      end;

      limparPanel;

    end;


    if dmConexao.conn.InTransaction then
      dmConexao.conn.CommitRetaining;

  except

    on e: Exception do
    begin
      if dmConexao.conn.InTransaction then
        dmConexao.conn.RollbackRetaining;

      ShowMessage(e.Message + sLineBreak + ' N�o foi poss�vel salvar o cedente.');

    end;

  end;


end;


procedure TfrmManterCedente.edtCelularExit(Sender: TObject);
begin
edtCelular.Text := uutil.FormatarTelefone (edtCelular.Text);
end;

procedure TfrmManterCedente.edtCEPExit(Sender: TObject);
begin
  if not uUtil.Empty(edtCEP.Text) then begin
      edtCEP.Text := uUtil.TFormat.formataCEP(edtCEP.Text);
  end;
end;

procedure TfrmManterCedente.edtCNPJCPFExit(Sender: TObject);
begin
 if cbbPersonalidade.ItemIndex = 1 then begin
  //1 = cpf e 2 = cnpj
  lblCPFCNPJ.Caption := 'CPF';
  edtCNPJCPF.Text := uUtil.TFormat.formacpf(edtCNPJCPF.Text);
 end else
 begin
  lblCPFCNPJ.Caption := 'CNPJ';
  edtCNPJCPF.Text := uUtil.TFormat.formacnpj(edtCNPJCPF.Text);
 end;

end;

procedure TfrmManterCedente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freeAndNilDM(Self);
 Action :=caFree;

end;

procedure TfrmManterCedente.FormCreate(Sender: TObject);
begin
 pIdOrganizacao := uutil.TOrgAtual.getId;
 inicializarDM(Self);
 limparPanel;
end;

procedure TfrmManterCedente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case key of
  vk_f2: dxBtnEditar.Click;
  vk_f3: cadastraTipoCedente;
  vk_f4: dxBtnNovo.Click;
  vk_f10: dxBtnSalvar.Click;


end;

end;

procedure TfrmManterCedente.cadastraTipoCedente;
begin
  frmManterTipoCedente := TfrmManterTipoCedente.Create(Self);
  frmManterTipoCedente.ShowModal;
  FreeAndNil(frmManterTipoCedente);
  preencheComboTipo;

end;


procedure TfrmManterCedente.freeAndNilDM(Sender: TObject);
begin

//nada
end;

procedure TfrmManterCedente.frmBairro1cbbcomboChange(Sender: TObject);
begin
 if frmBairro1.cbbcombo.ItemIndex >0 then begin
  pIdBairro := FsListaIdBairro[frmBairro1.cbbcombo.ItemIndex];
 end;
end;

procedure TfrmManterCedente.frmCartaoCredito1cbbCartaoChange(Sender: TObject);
begin
  pIdCartaoCredito :='';

  if frmCartaoCredito1.cbbCartao.ItemIndex > 0  then begin

      pIdCartaoCredito := FsListaCartaoCredito[frmCartaoCredito1.cbbCartao.ItemIndex];


  end;


end;

procedure TfrmManterCedente.frmCidade1cbbcomboChange(Sender: TObject);
begin
  if frmCidade1.cbbcombo.ItemIndex > 0 then
  begin
    pIdCidade := FsListaIdCidade[frmCidade1.cbbcombo.ItemIndex];
    frmBairro1.obterTodosPorCidade(pIdCidade, frmBairro1.cbbcombo, FsListaIdBairro);
  end;

end;

procedure TfrmManterCedente.frmContaContabil1cbbContaContabilChange(
  Sender: TObject);
  var
  conta : TContaContabilModel;
begin

  if frmContaContabil1.cbbContaContabil.ItemIndex > 0 then
  begin

    pIdContaContabil := FsListaIdContas[frmContaContabil1.cbbContaContabil.ItemIndex];
    conta := TContaContabilModel.Create;
    conta.FIDorganizacao := pIdOrganizacao;
    conta.FID := pIdContaContabil;
    conta :=  TContaContabilDAO.obterPorID(conta);


    if not uUtil.Empty(conta.FCodigoReduzido) then
    begin
      edtCODREDUZ.Text := conta.FCodigoReduzido;
      edtContaContabil.Text := conta.FConta;
      pIdContaContabil :=conta.FID;
    end;

  end;

end;

procedure TfrmManterCedente.frmEstado1cbbcomboChange(Sender: TObject);
begin
 pIdEstado := FsListaIdEstado[frmEstado1.cbbcombo.ItemIndex];
 frmCidade1.obterPorEstado(pIdEstado,frmCidade1.cbbcombo, FsListaIdCidade);

end;

procedure TfrmManterCedente.frmTipoCedente1cbbcomboChange(Sender: TObject);
begin
 if frmTipoCedente1.cbbcombo.ItemIndex  >0 then begin
   pIdTipo := FslistaTipo[frmTipoCedente1.cbbcombo.ItemIndex];
   edtStatus.Text := 'ATIVO';
 end;

end;

procedure TfrmManterCedente.inicializarDM(Sender: TObject);
begin
 //nada
  pIdOrganizacao := uutil.TOrgAtual.getId;

 if not Assigned(dmOrganizacao) then begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
 end;

 limparPanel;


end;

procedure TfrmManterCedente.limparPanel();
begin
 uutil.LimpaTela(Self);
 limpaStatusBar;

 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdUsuario     := uutil.TUserAtual.getUserId;

 frmBanco1.obterTodosPorIndice(pIdOrganizacao, frmBanco1.cbbBanco, FslistaIdBanco);
 frmContaContabil1.obterTodos(pIdOrganizacao, frmContaContabil1.cbbContaContabil,FsListaIdContas);
 frmEstado1.obterTodos(frmEstado1.cbbcombo, FsListaIdEstado);

 preencheComboTipo();
 preencheComboPersonalidade;
 preencheGrid(pIdOrganizacao);
 preecheGridBanco;

 //botao editar muda
  dbgrd1.Enabled :=True;
  edtCODREDUZ.Clear;
  edtContaContabil.Clear;


  dxBtnNovo.Enabled := True;
  dxBtnEditar.Enabled := False;
  dxBtnSalvar.Enabled :=False;
  dxBtnDeletar.Enabled := False;
  cxbrdtmPesquisa.Enabled :=True;
  dtpRegistro.Date := Now;

  frmContaContabil1.cbbContaContabil.ItemIndex :=0;

  //desabilitados
  edtCNPJCPF.Enabled := False; //cbPersonalidade quem libera

   cxpgcntrlPage.ActivePageIndex :=0;

//

 //botao editar muda
  dbgrd1.Enabled :=True;
  edtNomeCedente.Clear;

  limparAba(Self.tbTransfereCedente);
  limparAba(Self.tbTransfereEndereco);
  limparAba(Self.tbTransfereContato);
  limparAba(Self.tbTransfereContaBancaria);
  limparAba(Self.tbTransfereContaContabil);
  frmBanco1.cbbBanco.ItemIndex :=0;
  frmTipoCedente1.cbbcombo.ItemIndex :=0;
  edtStatus.Text := 'ATIVO';
  Self.dxRibbon1Tab1.Caption := 'Manuten��o do cadastro de cedentes/fornecedores.';


  pPersonalidade:='';
  pIdCartaoCredito:='';
  pIdContaContabil:='';
  pIdCedente:='';
  pIdTipo:='';
  pIdEndereco:='';
  pIdContato:='';

end;

procedure TfrmManterCedente.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmManterCedente.preencheGrid(pIdOrganizacao: string);
var
 cmdSql :string;
begin

dmConexao.conectarBanco;
if uutil.Empty(pIdOrganizacao) then begin pIdOrganizacao := TOrgAtual.getId; end;

   cmdSql := ' SELECT C.ID_CEDENTE, C.ID_ORGANIZACAO,' +
                     ' C.ID_TIPO_CEDENTE, TC.DESCRICAO AS TIPO,  C.ID_ENDERECO,' +
                     ' C.ID_CONTATO, C.NOME, C.CPFCNPJ,' +
                     ' C.PERSONALIDADE, C.CONTA_BANCARIA,' +
                     ' C.AGENCIA, C.ID_BANCO, C.CGA,' +
                     ' C.INSCRICAO_ESTADUAL,  C.ID_CONTA_CONTABIL,' +
                     ' C.INSCRICAO_MUNICIPAL, C.ID_CARTAO_CREDITO,' +
                     ' C.DATA_REGISTRO, C.SACADO, C.STATUS, ' +
                     ' C.DATA_ULTIMA_ATUALIZACAO, C.CODIGO, CTO.TELEFONE, CTO.CELULAR' +
             ' FROM CEDENTE C ' +
             ' LEFT OUTER JOIN CONTATO CTO ON (CTO.ID_CONTATO = C.ID_CONTATO) AND (CTO.ID_ORGANIZACAO = C.ID_ORGANIZACAO)'+
             ' LEFT OUTER JOIN TIPO_CEDENTE TC ON (TC.ID_TIPO_CEDENTE = C.ID_TIPO_CEDENTE) AND (TC.ID_ORGANIZACAO = C.ID_ORGANIZACAO) '+
             ' WHERE ( C.ID_ORGANIZACAO = :PIDORGANIZACAO ) ORDER BY C.NOME  ' ;

   cmdSql := ' SELECT C.ID_CEDENTE, C.ID_ORGANIZACAO,' +
                     ' TC.DESCRICAO AS TIPO,C.NOME, C.CPFCNPJ,' +
                     ' C.CODIGO, CTO.TELEFONE' +
             ' FROM CEDENTE C ' +
             ' LEFT OUTER JOIN CONTATO CTO ON (CTO.ID_CONTATO = C.ID_CONTATO) AND (CTO.ID_ORGANIZACAO = C.ID_ORGANIZACAO)'+
             ' LEFT OUTER JOIN TIPO_CEDENTE TC ON (TC.ID_TIPO_CEDENTE = C.ID_TIPO_CEDENTE) AND (TC.ID_ORGANIZACAO = C.ID_ORGANIZACAO) '+
             ' WHERE ( C.ID_ORGANIZACAO = :PIDORGANIZACAO ) ORDER BY C.NOME  ' ;




  try

        //qryPreencheGrid := TFDQuery.Create(Self);
        qryPreencheGrid.Close;
        qryPreencheGrid.SQL.Clear;
        qryPreencheGrid.SQL.Add(cmdSql);
        qryPreencheGrid.Connection := dmConexao.conn;
        qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryPreencheGrid.Open;


    (dbgrd1.DataSource.DataSet as TFDQuery).Last;
    (dbgrd1.DataSource.DataSet as TFDQuery).First;


   except

   raise Exception.Create('Erro preencher grid');

  end;


end;

function TfrmManterCedente.qtdUso(pIdOrganizacao, pIdCedente: string): Integer;
  var
qryTP, qryTR : TFDQuery;
cmd : string;
qtd :Integer;

begin
  dmConexao.conectarBanco;
  qtd := 0;

  try

    cmd := ' SELECT  FIRST 1 TP.ID_TITULO_PAGAR  FROM TITULO_PAGAR TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_CEDENTE = :PID) ';

    qryTP := TFDQuery.Create(Self);
    qryTP.Close;
    qryTP.Connection := dmConexao.conn;
    qryTP.SQL.Clear;
    qryTP.SQL.Add(cmd);
    qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTP.ParamByName('PID').AsString := pIdCedente;
    qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

     if qtd < 1 then
    begin

      cmd := ' SELECT FIRST 1 TP.ID_TESOURARIA_DEBITO FROM TESOURARIA_DEBITO TP '+
             ' WHERE  (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_CEDENTE = :PID) ';

      qryTP := TFDQuery.Create(Self);
      qryTP.Close;
      qryTP.Connection := dmConexao.conn;
      qryTP.SQL.Clear;
      qryTP.SQL.Add(cmd);
      qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTP.ParamByName('PID').AsString := pIdCedente;
      qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

    end;


    if qtd < 1 then
    begin

      cmd := ' SELECT C.ID_CARTAO_CREDITO AS CARTAO FROM CEDENTE C '+
             ' WHERE  (C.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (C.ID_CEDENTE = :PID) ';

      qryTP := TFDQuery.Create(Self);
      qryTP.Close;
      qryTP.Connection := dmConexao.conn;
      qryTP.SQL.Clear;
      qryTP.SQL.Add(cmd);
      qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTP.ParamByName('PID').AsString := pIdCedente;
      qryTP.Open;

      if not uUtil.Empty (qryTP.FieldByName('CARTAO').AsString) then begin

       qtd := qtd + qryTP.RecordCount;

      end;
    end;

  except
    raise Exception.Create('Erro ao buscar uso dos CEDENTES ');

  end;

  Result := qtd;

end;

procedure TfrmManterCedente.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
msgStatusBar(1,'Ativo. Teclas de atalho:  [F2] = Editar - [F3] = Novo Tipo Cedente - [F4] = Novo Cedente - [F10] = Salvar ');
end;

function TfrmManterCedente.obterPersonalidade(pPersonalidade :String) :Integer;
var
  posicao: Integer;
  I: Integer;
begin
  posicao := 0;

  for I := 0 to FsListaPersonalidade.Count -1 do begin
       if FsListaPersonalidade[I].Equals(pPersonalidade) then begin
         posicao := I;
       end;
  end;

  Result := posicao;
end;

function TfrmManterCedente.obterTipoCedente(pTipo :String) :Integer;
var
  posicao: Integer;
  I: Integer;
begin
  posicao := 0;

  for I := 0 to FslistaTipo.Count -1 do begin
       if FslistaTipo[I].Equals(pTipo) then begin
         posicao := I;
       end;
  end;

  Result := posicao;
end;




procedure TfrmManterCedente.preencheComboTipo;
begin
frmTipoCedente1.obterTodos(pIdOrganizacao,frmTipoCedente1.cbbcombo, FslistaTipo);
frmTipoCedente1.cbbcombo.ItemIndex :=0;

end;


function  TfrmManterCedente.salvar (cedenteModel :TCedenteModel): Boolean;
var
cmdSalvar :string;
qrySalvar :TFDQuery;
begin

 dmConexao.conectarBanco;
 try

             cmdSalvar := ' UPDATE CEDENTE '  +
                          ' SET ID_TIPO_CEDENTE =     :PIDTIPO, '+
                          '     ID_ENDERECO =         :PIDENDERECO,'+
                          '     ID_CONTATO =          :PIDCONTATO,'+
                          '     NOME =                :PNOME,'+
                          '     CPFCNPJ =             :PCNPJ,'+
                          '     PERSONALIDADE =       :PPERSONALIDADE,'+
                          '     CONTA_BANCARIA =      :PCONTA, '+
                          '     AGENCIA =             :PAGENCIA,'+
                          '     ID_BANCO =            :PIDBANCO,'+
                          '     CGA =                 :PCGA,'+
                          '     INSCRICAO_ESTADUAL  = :PINSCEST,'+
                          '     ID_CONTA_CONTABIL   = :PIDCONTACTB,'+
                          '     INSCRICAO_MUNICIPAL = :PINSCMUN, '+
                          '     ID_CARTAO_CREDITO   = :PIDCARTAO,'+
                          '     STATUS              = :PSTATUS, '+
                          '     DATA_ULTIMA_ATUALIZACAO = :PDATA,'+
                          '     DATA_REGISTRO       = :PDATAREGISTRO, '+
                          '     CODIGO              = :PCODIGO '+
                          '     WHERE (ID_CEDENTE = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';


   if UUTIL.Empty(cedenteModel.FID) then begin

     cedenteModel.FID := dmConexao.obterNewID;
     cedenteModel.FDataRegistro :=Now;
     cedenteModel.FCodigo := obterCodigo;



      cmdSalvar :=  ' INSERT  INTO CEDENTE (ID_CEDENTE, ID_ORGANIZACAO, ID_BANCO, ' +
                    ' ID_TIPO_CEDENTE, ID_ENDERECO, ID_CONTATO, ID_CONTA_CONTABIL, ID_CARTAO_CREDITO, '+
                    ' NOME, CPFCNPJ, PERSONALIDADE, AGENCIA, CONTA_BANCARIA,CODIGO, STATUS, '+
                    ' CGA, INSCRICAO_ESTADUAL, INSCRICAO_MUNICIPAL, DATA_REGISTRO, DATA_ULTIMA_ATUALIZACAO ) '+
                    ' VALUES (:PID, :PIDORGANIZACAO, :PIDBANCO, '+
                    '         :PIDTIPO, :PIDENDERECO, :PIDCONTATO, :PIDCONTACTB, :PIDCARTAO, '+
                    '         :PNOME, :PCNPJ, :PPERSONALIDADE, :PAGENCIA, :PCONTA, :PCODIGO, :PSTATUS, '+
                    '         :PCGA, :PINSCEST, :PINSCMUN, :PDATAREGISTRO, :PDATA ) ' ;

    end;

    if not uUtil.Empty(cedenteModel.FID) then
    begin
      qrySalvar := TFDQuery.Create(Self);
      qrySalvar.Close;
      qrySalvar.Connection := dmConexao.conn;
      qrySalvar.SQL.Clear;
      qrySalvar.SQL.Add(cmdSalvar);

      qrySalvar.ParamByName('PID').AsString               := cedenteModel.FID;
      qrySalvar.ParamByName('PIDORGANIZACAO').AsString    := cedenteModel.FIDorganizacao;

      qrySalvar.ParamByName('PIDBANCO').AsString          := cedenteModel.FIDbanco;
      qrySalvar.ParamByName('PIDTIPO').AsString           := cedenteModel.FIDtipoCedente;
      qrySalvar.ParamByName('PIDENDERECO').AsString       := cedenteModel.FIDendereco;
      qrySalvar.ParamByName('PIDCONTATO').AsString        := cedenteModel.FIDcontato;
      qrySalvar.ParamByName('PIDCONTACTB').AsString       := cedenteModel.FIDcontaContabil;
      qrySalvar.ParamByName('PIDCARTAO').AsString         := cedenteModel.FIDcartaoCreditoModel;

      qrySalvar.ParamByName('PNOME').AsString             := UpperCase(cedenteModel.Fnome);
      qrySalvar.ParamByName('PCNPJ').AsString             := cedenteModel.FcpfCnpj;
      qrySalvar.ParamByName('PPERSONALIDADE').AsString    := cedenteModel.Fpersonalidade;
      qrySalvar.ParamByName('PAGENCIA').AsString          := cedenteModel.Fagencia;
      qrySalvar.ParamByName('PCONTA').AsString            := cedenteModel.Fconta;
      qrySalvar.ParamByName('PCODIGO').AsString           := cedenteModel.FCodigo;
      qrySalvar.ParamByName('PSTATUS').AsString           := cedenteModel.FStatus;
      qrySalvar.ParamByName('PCGA').AsString              := cedenteModel.Fcga;
      qrySalvar.ParamByName('PINSCEST').AsString          := cedenteModel.FinscricaoEstadual;
      qrySalvar.ParamByName('PINSCMUN').AsString          := cedenteModel.FinscricaoMunicipal;
      qrySalvar.ParamByName('PDATAREGISTRO').AsDate       := cedenteModel.FDataRegistro;
      qrySalvar.ParamByName('PDATA').AsDate               := Now;

          if cedenteModel.FIDcartaoCreditoModel = EmptyStr then
          begin
            qrySalvar.ParamByName('PIDCARTAO').Value := null;
          end;
          if cedenteModel.FIDbanco = EmptyStr then
          begin
            qrySalvar.ParamByName('PIDBANCO').Value := null;
          end;
          if cedenteModel.FIDendereco = EmptyStr then
          begin
            qrySalvar.ParamByName('PIDENDERECO').Value := null;
          end;
          if cedenteModel.FIDcontato = EmptyStr then
          begin
            qrySalvar.ParamByName('PIDCONTATO').Value := null;
          end;
          if cedenteModel.FIDcontaContabil = EmptyStr then
          begin
            qrySalvar.ParamByName('PIDCONTACTB').Value := null;
          end;


      qrySalvar.ExecSQL;

      pIdCedente := cedenteModel.FID;
      dmConexao.conn.CommitRetaining;

    end;

 except
 dmConexao.conn.RollbackRetaining;
 Result :=False;
  raise Exception.Create('Erro ao tentar salvar o cedente.');
 end;

  Result :=System.True;
end;

function TfrmManterCedente.salvarContato(contatoModel: TContatoModel): Boolean;
var
cmdSalvar :string;
qrySalvar :TFDQuery;
begin

 dmConexao.conectarBanco;
 try

   cmdSalvar := ' UPDATE CONTATO  SET TELEFONE = :PTEL ,  CELULAR = :PCEL , '+
                ' EMAIL = :PEMAIL '+
                ' WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO) AND (ID_CONTATO = :PID) ';



   if UUTIL.Empty(contatoModel.FID) then begin
      contatoModel.FID := dmConexao.obterNewID;
      TContatoDAO.Insert(contatoModel);

      cmdSalvar := ' INSERT INTO CONTATO (ID_CONTATO, ID_ORGANIZACAO,  TELEFONE, CELULAR, EMAIL ) '+
                '               VALUES (:PID, :PIDORGANIZACAO, :PTEL, :PCEL, :PEMAIL)' ;
   end;

    if not uUtil.Empty(contatoModel.FID) then
    begin
     TContatoDAO.Update(contatoModel);

      qrySalvar := TFDQuery.Create(Self);
      qrySalvar.Close;
      qrySalvar.Connection := dmConexao.conn;
      qrySalvar.SQL.Clear;
      qrySalvar.SQL.Add(cmdSalvar);

      qrySalvar.ParamByName('PID').AsString := contatoModel.FID;
      qrySalvar.ParamByName('PIDORGANIZACAO').AsString := contatoModel.FIDorganizacao;
      qrySalvar.ParamByName('PTEL').AsString     := contatoModel.FTelefone;
      qrySalvar.ParamByName('PCEL').AsString     := contatoModel.FCelular;
      qrySalvar.ParamByName('PEMAIL').AsString   := contatoModel.FEmail;

     // qrySalvar.ExecSQL; mudado em 26/03/20 para usar o DAO

      pIdContato := contatoModel.FID;
    end;

 except
 Result :=False;
  raise Exception.Create('Erro ao tentar salvar o CONTATO.');
 end;

  Result :=True;


end;

function TfrmManterCedente.salvarEndereco(enderecoModel: TEnderecoModel): Boolean;
var
cmdSalvar :string;
qrySalvar :TFDQuery;
begin

 dmConexao.conectarBanco;
 try

   cmdSalvar := ' UPDATE ENDERECO  SET ID_ESTADO = :PIDESTADO ,  ID_BAIRRO = :PIDBAIRRO, '+
                ' ID_CIDADE = :PIDCIDADE , LOGRADOURO = :PLOGRADOURO, ' +
                ' COMPLEMENTO = :PCOMPLEMENTO, NUMERO = :PNUMERO, CEP = :PCEP ' +
                ' WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO) AND (ID_ENDERECO = :PID) ';


   if UUTIL.Empty(enderecoModel.FID) then begin
       enderecoModel.FID := dmConexao.obterNewID;
       TEnderecoDAO.Insert(enderecoModel);


      cmdSalvar := ' INSERT INTO ENDERECO (ID_ENDERECO, ID_ORGANIZACAO, ID_ESTADO, LOGRADOURO, COMPLEMENTO, ID_BAIRRO, NUMERO, CEP, ID_CIDADE) '+
                '               VALUES (:PID, :PIDORGANIZACAO, :PIDESTADO, :PLOGRADOURO, :PCOMPLEMENTO, :PIDBAIRRO, :PNUMERO, :PCEP, :PIDCIDADE)' ;
   end;

    if not uUtil.Empty(enderecoModel.FID) then
    begin
       TEnderecoDAO.Update(enderecoModel);


      qrySalvar := TFDQuery.Create(Self);
      qrySalvar.Close;
      qrySalvar.Connection := dmConexao.conn;
      qrySalvar.SQL.Clear;
      qrySalvar.SQL.Add(cmdSalvar);

      qrySalvar.ParamByName('PID').AsString := enderecoModel.FID;
      qrySalvar.ParamByName('PIDORGANIZACAO').AsString := enderecoModel.FIDorganizacao;
      qrySalvar.ParamByName('PIDESTADO').AsString := enderecoModel.FIDESTADO;
      qrySalvar.ParamByName('PLOGRADOURO').AsString := UpperCase(enderecoModel.FLOGRADOURO);
      qrySalvar.ParamByName('PCOMPLEMENTO').AsString := UpperCase(enderecoModel.FCOMPLEMENTO);
      qrySalvar.ParamByName('PIDBAIRRO').AsString := enderecoModel.FIDBAIRRO;
      qrySalvar.ParamByName('PNUMERO').AsString := enderecoModel.FNUMERO;
      qrySalvar.ParamByName('PCEP').AsString := enderecoModel.FCEP;
      qrySalvar.ParamByName('PIDCIDADE').AsString := enderecoModel.FIDCIDADE;

      if enderecoModel.FIDESTADO = EmptyStr then
      begin
        qrySalvar.ParamByName('PIDESTADO').Value := null;
      end;

       if enderecoModel.FIDBAIRRO = EmptyStr then
      begin
        qrySalvar.ParamByName('PIDBAIRRO').Value := null;
      end;

       if enderecoModel.FIDCIDADE = EmptyStr then
      begin
        qrySalvar.ParamByName('PIDCIDADE').Value := null;
      end;


    //  qrySalvar.ExecSQL; mudando em 26/03 para usar o DAO


      pIdEndereco := enderecoModel.FID;

    end;

 except
 Result :=False;
  raise Exception.Create('Erro ao tentar salvar o ENDERECO.');
 end;

  Result :=True;


end;

procedure TfrmManterCedente.tbTransfereCedenteShow(Sender: TObject);
begin
 dbgrd1.Visible :=True;
  msgStatusBar(1,'Ativo. Teclas de atalho:  [F2] = Editar - [F3] = Novo Tipo Cedente - [F4] = Novo Cedente - [F10] = Salvar ');


end;

procedure TfrmManterCedente.tbTransfereContaBancariaShow(Sender: TObject);
begin
 dbgrd1.Visible :=False;
 msgStatusBar(1,'Dados da conta banc�ria');

end;

procedure TfrmManterCedente.tbTransfereContaContabilShow(Sender: TObject);
begin
  dbgrd1.Visible :=False;
   msgStatusBar(1,'Dados da conta cont�bil');
end;

procedure TfrmManterCedente.tbTransfereContatoShow(Sender: TObject);
begin
 dbgrd1.Visible :=False;
  msgStatusBar(1,'Contatos cadastrados');
end;

procedure TfrmManterCedente.tbTransfereEnderecoExit(Sender: TObject);
begin

if frmEstado1.cbbcombo.ItemIndex >0 then begin
  if frmCidade1.cbbcombo.ItemIndex > 0 then begin
   if frmBairro1.cbbcombo.ItemIndex >0 then begin
    if not uutil.Empty(edtLogradouro.Text)  then begin
     if not uUtil.Empty(edtNumero.Text) then begin
       if not uutil.Empty(edtCEP.Text) then begin
         dxBtnSalvar.Enabled :=True;
       end;
     end;
    end;
   end;
  end;
end;
end;

procedure TfrmManterCedente.tbTransfereEnderecoShow(Sender: TObject);
begin
 dbgrd1.Visible :=False;
  msgStatusBar(1,'Dados do endere�o');
end;

procedure TfrmManterCedente.preencheComboCartao;
var
qryPesquisa :TFDQuery;
sqlEnd :string;
posicao :Integer;
  I: Integer;
begin
 dmConexao.conectarBanco;
 FsListaCartaoCredito := TStringList.Create;
 FsListaCartaoCredito.Clear;
 posicao :=0;

  frmCartaoCredito1.obterTodos(pIdOrganizacao, frmCartaoCredito1.cbbCartao, FsListaCartaoCredito);

  if not uUtil.Empty(pIdCartaoCredito) then
  begin

    for I := 0 to FsListaCartaoCredito.Count - 1 do
    begin
      if FsListaCartaoCredito[I].Equals(pIdCartaoCredito) then
      begin
        posicao := I;
        Break;
      end;
    end;
  end;


  frmCartaoCredito1.cbbCartao.ItemIndex := posicao;

end;

procedure TfrmManterCedente.preencheComboPersonalidade;
begin

  FsListaPersonalidade :=TStringList.Create;
  FsListaPersonalidade.Clear;
  FsListaPersonalidade.Add('0');
  FsListaPersonalidade.Add('PF');
  FsListaPersonalidade.Add('PJ');


  cbbPersonalidade.Clear;
  cbbPersonalidade.Items.Add(' >>Selecione<<');
  cbbPersonalidade.Items.Add('P. Fisica');
  cbbPersonalidade.Items.Add('P. Juridica');

  cbbPersonalidade.ItemIndex :=0;


end;


procedure TfrmManterCedente.preecheGridBanco;
begin

 dmConexao.conectarBanco;
 try

   qryGridBanco.Close;
   qryGridBanco.Connection := dmConexao.conn;
  // qryGridBanco.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   qryGridBanco.Open;

 except
 raise Exception.Create('Erro ao obter lista de bancos');

 end;

end;

function TfrmManterCedente.obterCartaoCreditoPorID(pIdOrganizacao,  pIdEndereco: string): TFDQuery;
var
qryPesquisa :TFDQuery;
sqlEnd :string;
begin
     {
    ID_CARTAO_CREDITO  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO     VARCHAR(36) NOT NULL,
    CARTAO             VARCHAR(120),
    NUMERO             VARCHAR(50),
    LIMITE             NUMERIC(10,2),
    DIA_VENCIMENTO     VARCHAR(2),
    DATA_VALIDADE      DATE,
    TITULAR            VARCHAR(200),
    CODIGO_SEGURANCA   VARCHAR(6),
    BANDEIRA           VARCHAR(30),
    DIA_COMPRA         VARCHAR(2)

    }

dmConexao.conectarBanco;

qryPesquisa := TFDQuery.Create(Self);

sqlEnd := ' SELECT E.ID_CARTAO_CREDITO, E.ID_ORGANIZACAO, ' +
          ' E.CARTAO, E.NUMERO, E.DIA_VENCIMENTO, E.TITULAR ' +
          ' E.CODIGO_SEGURANCA, E.BANDEIRA, E.DIA_COMPRA, '+
          ' E.LIMITE, E.DATA_VALIDADE '+
          ' FROM CONTATO E  ' +
          ' WHERE (E.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
          '  AND  (E.ID_CARTAO_CREDITO = :PID) ';


 try
     qryPesquisa.Close;
     qryPesquisa.Connection := dmConexao.conn;
     qryPesquisa.SQL.Clear;
     qryPesquisa.SQL.Add(sqlEnd);
     qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
     qryPesquisa.ParamByName('PID').AsString := pIdContato;
     qryPesquisa.Open;
 except

  raise Exception.Create('Erro ao obter CART�O DE CR�DITO ');

 end;

 Result := qryPesquisa;

end;

function TfrmManterCedente.obterCodigo: string;
var
qryPesquisa :TFDQuery;
cod, sqlEnd :string;
begin
dmConexao.conectarBanco;

   sqlEnd := ' SELECT  MAX ( CAST( C.CODIGO AS INTEGER) +1 ) AS CODIGO  FROM CEDENTE C WHERE 1=1 ';

 try
     qryPesquisa := TFDQuery.Create(Self);
     qryPesquisa.Close;
     qryPesquisa.Connection := dmConexao.conn;
     qryPesquisa.SQL.Clear;
     qryPesquisa.SQL.Add(sqlEnd);
     qryPesquisa.Open;


      if uUtil.Empty(qryPesquisa.FieldByName('CODIGO').AsString) then begin

       cod := '2000';

     end else begin cod := qryPesquisa.FieldByName('CODIGO').AsString; end;



 except

  raise Exception.Create('Erro ao obter c�digo ');

 end;

 Result := cod;

end;

function TfrmManterCedente.obterContatoPorId(pIdOrganizacao,  pIdContato: string): TFDQuery;
  var
qryPesquisa :TFDQuery;
sqlEnd :string;
begin
dmConexao.conectarBanco;

qryPesquisa := TFDQuery.Create(Self);

sqlEnd := ' SELECT E.ID_CONTATO, E.ID_ORGANIZACAO, ' +
          ' E.TELEFONE, E.CELULAR, E.EMAIL' +
          ' FROM CONTATO E  ' +
          ' WHERE (E.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
          '  AND  (E.ID_CONTATO = :PID) ';


 try
     qryPesquisa.Close;
     qryPesquisa.Connection := dmConexao.conn;
     qryPesquisa.SQL.Clear;
     qryPesquisa.SQL.Add(sqlEnd);
     qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
     qryPesquisa.ParamByName('PID').AsString := pIdContato;
     qryPesquisa.Open;
 except

  raise Exception.Create('Erro ao obter CONTATO ');

 end;

 Result := qryPesquisa;

end;


function TfrmManterCedente.obterEnderecoPorId(pIdOrganizacao, pIdEndereco :string) :TFDQuery;
var
qryEndereco :TFDQuery;
sqlEnd :string;
begin
dmConexao.conectarBanco;

qryEndereco := TFDQuery.Create(Self);

sqlEnd := ' SELECT E.ID_ENDERECO, E.ID_ORGANIZACAO, ' +
          ' E.ID_ESTADO, E.LOGRADOURO, E.COMPLEMENTO,' +
          ' E.ID_BAIRRO, E.NUMERO, E.CEP, E.ID_CIDADE' +
          ' FROM ENDERECO E  ' +
          ' WHERE (E.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
          '  AND  (E.ID_ENDERECO = :PIDENDERECO) ';
 try
     qryEndereco.Close;
     qryEndereco.Connection := dmConexao.conn;
     qryEndereco.SQL.Clear;
     qryEndereco.SQL.Add(sqlEnd);
     qryEndereco.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
     qryEndereco.ParamByName('PIDENDERECO').AsString := pIdEndereco;
     qryEndereco.Open;
 except

  raise Exception.Create('Erro ao obter endere�o ');

 end;

 Result := qryEndereco;

end;

procedure TfrmManterCedente.preencheAbaContato(query: TFDQuery);
begin
  if not query.IsEmpty then begin
     pIdContato := query.FieldByName('ID_CONTATO').AsString;

    edtTelFixo.Text  := query.FieldByName('TELEFONE').AsString;
    edtCelular.Text      := query.FieldByName('CELULAR').AsString;
    edtEmail.Text         := query.FieldByName('EMAIL').AsString;

  end else begin

    limparAba(tbTransfereContato);

  end;



end;

procedure TfrmManterCedente.preencheAbaEndereco( query :TFDQuery);
var
  I,J,F: Integer;
begin
  if not query.IsEmpty then begin

    pIdEndereco := query.FieldByName('ID_ENDERECO').AsString;

    pIdEstado   := query.FieldByName('ID_ESTADO').AsString;
    pIdCidade   := query.FieldByName('ID_CIDADE').AsString;
    pIdBairro   := query.FieldByName('ID_BAIRRO').AsString;


    edtLogradouro.Text  := query.FieldByName('LOGRADOURO').AsString;
    edtNumero.Text      := query.FieldByName('NUMERO').AsString;
    edtCEP.Text         := query.FieldByName('CEP').AsString;
    edtComplemento.Text := query.FieldByName('COMPLEMENTO').AsString;

    if not uutil.Empty(pIdEstado) then
    begin

      for I := 0 to FsListaIdEstado.Count - 1 do
      begin
        if FsListaIdEstado[I].Equals(pIdEstado) then
        begin
          frmEstado1.cbbcombo.ItemIndex := I;
          Break
        end
      end;

      if frmEstado1.cbbcombo.ItemIndex > 0 then
      begin
        frmCidade1.obterPorEstado(pIdEstado, frmCidade1.cbbcombo, FsListaIdCidade);
      end;
    end;

    if not uutil.Empty(pIdCidade) then
    begin
      for J := 0 to FsListaIdCidade.Count - 1 do
      begin
        if FsListaIdCidade[J].Equals(pIdCidade) then
        begin
          frmCidade1.cbbcombo.ItemIndex := J;
          Break
        end
      end;

      if frmCidade1.cbbcombo.ItemIndex > 0 then
      begin
        frmBairro1.obterTodosPorCidade(pIdCidade, frmBairro1.cbbcombo, FsListaIdBairro);
      end;
    end;

    if not uutil.Empty(pIdBairro) then
    begin
      for F := 0 to FsListaIdBairro.Count - 1 do
      begin
        if FsListaIdBairro[F].Equals(pIdBairro) then
        begin
          frmBairro1.cbbcombo.ItemIndex := F;
          Break
        end
      end;
    end;




  end else begin

    limparAba(tbTransfereEndereco);
     frmEstado1.limpaFrame;

   // frmEstado1.cbbcombo.ItemIndex := 0;
    frmCidade1.cbbcombo.ItemIndex := 0;
    frmBairro1.cbbcombo.ItemIndex := 0;

  end;

end;

procedure TfrmManterCedente.limparAba(aba :TcxTabSheet );
var
 j, i: Integer;
begin
 // limpa os componentes da aba q chegou

  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TCustomEdit then
    begin
       if TCustomEdit(Components[i]).Parent = aba then
         (Components[i] as TCustomEdit).Clear;
    end;

    if Components[i] is TEdit then
    begin
      if TEdit(Components[i]).Parent = aba then
         TEdit(Components[i]).Clear;
    end;

     if Components[i] is TComboBox then
    begin
       TComboBox(Components[i]).ItemIndex := 0;
    if TComboBox(Components[i]).Parent = aba then
      // TComboBox(Components[i]).Clear;
      TComboBox(Components[i]).ItemIndex := 0;
    end;

   end;


end;



function TfrmManterCedente.obterCedentePorId(pIdOrganizacao, pIdCedente: String): TCedenteModel;
  var
  qryPesquisa :TFDQuery;
 sqlEnd :string;
 cedente :TCedenteModel;

begin
 dmConexao.conectarBanco ;
 cedente := TCedenteModel.Create;

  sqlEnd := ' SELECT * FROM CEDENTE C ' +
                  ' WHERE (C.ID_ORGANIZACAO = :pIdOrganizacao) ' + ' AND ' +
                  '(C.ID_CEDENTE = :pIdCedente)';

 try

    qryPesquisa := TFDQuery.Create(Self);
    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.Conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add(sqlEnd);
    qryPesquisa.ParamByName('pIdOrganizacao').AsString :=   pIdOrganizacao;
    qryPesquisa.ParamByName('pIdCedente').AsString := pIdCedente;
    qryPesquisa.Open;

    if  not qryPesquisa.IsEmpty then begin

     cedente.Fcga                   := qryPesquisa.FieldByName('CGA').AsString;
     cedente.FinscricaoEstadual     := qryPesquisa.FieldByName('INSCRICAO_ESTADUAL').AsString;
     cedente.FinscricaoMunicipal    := qryPesquisa.FieldByName('INSCRICAO_MUNICIPAL').AsString;
     cedente.Fagencia               := qryPesquisa.FieldByName('AGENCIA').AsString;
     cedente.Fconta                 := qryPesquisa.FieldByName('CONTA_BANCARIA').AsString;

     cedente.Fnome                  := qryPesquisa.FieldByName('NOME').AsString;
     cedente.Fpersonalidade         := qryPesquisa.FieldByName('PERSONALIDADE').AsString;

     cedente.FcpfCnpj               := qryPesquisa.FieldByName('CPFCNPJ').AsString;

     cedente.FCodigo                := qryPesquisa.FieldByName('CODIGO').AsString;
     cedente.FStatus                := qryPesquisa.FieldByName('STATUS').AsString;
     cedente.FDataRegistro          := qryPesquisa.FieldByName('DATA_REGISTRO').AsDateTime;

     cedente.FIDtipoCedente         := qryPesquisa.FieldByName('ID_TIPO_CEDENTE').AsString;
     cedente.FIDorganizacao         := qryPesquisa.FieldByName('ID_ORGANIZACAO').AsString;
     cedente.FIDbanco               := qryPesquisa.FieldByName('ID_BANCO').AsString;
     cedente.FID                    := qryPesquisa.FieldByName('ID_CEDENTE').AsString;
     cedente.FIDcontaContabil       := qryPesquisa.FieldByName('ID_CONTA_CONTABIL').AsString;
     cedente.FIDendereco            := qryPesquisa.FieldByName('ID_ENDERECO').AsString;
     cedente.FIDcontato             := qryPesquisa.FieldByName('ID_CONTATO').AsString;
     cedente.FIDcartaoCreditoModel  := qryPesquisa.FieldByName('ID_CARTAO_CREDITO').AsString;




     if uutil.Empty(qryPesquisa.FieldByName('CODIGO').AsString) then begin

       cedente.FCodigo := obterCodigo;

     end;


    end;



 except
 raise Exception.Create('Erro ao tentar obter cedente por ID');


 end;

    Result := cedente;

end;

function TfrmManterCedente.isValidAbaContato: Boolean;
var
  liberado: Boolean;
begin
  liberado := False;

 if not uUtil.Empty(edtCelular.Text) then
  begin
    liberado := True;
  end;

  if not  uUtil.Empty(edtTelFixo.Text) then
  begin
    liberado := True;
  end;

  if not uUtil.Empty(edtEmail.Text) then
  begin
    liberado := True;
  end;


  Result := liberado;
end;
function TfrmManterCedente.isValidAbaEndereco: Boolean;
var
  liberado: Boolean;
begin
  liberado := True;

  if uUtil.Empty(edtLogradouro.Text) then
  begin
    liberado := False;
  end;

  if uUtil.Empty(edtNumero.Text) then
  begin
    liberado := False;
  end;

  if uUtil.Empty(edtCEP.Text) then
  begin
    liberado := False;
  end;

  if frmEstado1.cbbcombo.ItemIndex = 0 then
  begin
    liberado := False;
  end;

  if frmCidade1.cbbcombo.ItemIndex = 0 then
  begin
    liberado := False;
  end;

  if frmBairro1.cbbcombo.ItemIndex = 0 then
  begin
    liberado := False;
  end;

  Result := liberado;

end;


 function TfrmManterCedente.isValidForm :Boolean;
var i:integer;
liberado : Boolean;

begin
 liberado :=false;

 msgStatusBar(1, 'Verifique os campos obrigat�rios.');

      for i := 0 to Self.ComponentCount - 1 do
      begin
          {  if ActiveControl is Tedit then begin
                 Showmessage(TEdit(ActiveControl).Name); end; }
        if Self.components[i] is TEdit then
        begin
          if (Tedit(components[i]).tag = 1) and uutil.Empty((Tedit(components[i]).text)) then
          begin
                  liberado := false;
                  if Tedit(components[i]).Parent.ClassType = TcxTabSheet then
                  begin
                    TcxPageControl(TcxTabSheet(Tedit(components[i]).Parent).Parent).ActivePageIndex := TcxTabSheet(Tedit(components[i]).Parent).TabIndex;
                    TEdit(Components[i]).Enabled := True;
                    TEdit(Components[i]).Visible := True;
                    TEdit(Components[i]).SetFocus;
                    PempecMsg.MsgWarning('Alguns campos obrigat�rios n�o foram preenchidos!' +#13 + 'A conta cont�bil � obrigat�ria.');
                    msgStatusBar(1, 'O cedente precisa ter conta cont�bil, endere�o e contato. Verifique todas as abas');
                    Break
                  end;

          end
          else
          begin
            liberado := True;
          end;

        end;
      end;



Result := liberado;
end;


function TfrmManterCedente.deletaEndereco (pOrganizacao, pEndereco :string) : Boolean;
var
 cmdEnd :string;
 qryDelEnd :TFDQuery;

begin


        //deleta endereco
        cmdEnd := ' DELETE FROM ENDERECO WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO) AND (ID_ENDERECO = :PIDENDERECO) ';

        qryDelEnd := TFDQuery.Create(Self);
        qryDelEnd.Close;
        qryDelEnd.Connection := dmConexao.conn;
        qryDelEnd.SQL.Clear;
        qryDelEnd.SQL.Add(cmdEnd);
        qryDelEnd.ParamByName('PIDORGANIZACAO').AsString := pOrganizacao;
        qryDelEnd.ParamByName('PIDENDERECO').AsString := pEndereco;
        qryDelEnd.ExecSQL;


end;



function TfrmManterCedente.deletarContato(pOrganizacao, pContato :string) : Boolean;
 var
 cmdCto   :string;
 qryDelCto :TFDQuery;
begin
  //deleta o contato

        cmdCto := ' DELETE FROM CONTATO WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO) AND (ID_CONTATO = :PIDCONTATO) ';

        qryDelCto := TFDQuery.Create(Self);
        qryDelCto.Close;
        qryDelCto.Connection := dmConexao.conn;
        qryDelCto.SQL.Clear;
        qryDelCto.SQL.Add(cmdCto);
        qryDelCto.ParamByName('PIDORGANIZACAO').AsString := pOrganizacao;
        qryDelCto.ParamByName('PIDCONTATO').AsString := pContato;
        qryDelCto.ExecSQL;

end;


procedure TfrmManterCedente.registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
begin
  TMDDAO.registroMD(pOrg, pTable, pAcao, pDsc, pStatus);

end;


end.

