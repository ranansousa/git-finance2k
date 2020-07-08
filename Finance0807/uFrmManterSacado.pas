unit uFrmManterSacado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, udmConexao, uUtil, uDMOrganizacao,
  cxGraphics, cxControls,   MDDAO, uSacadoDAO,
  dxStatusBar, cxClasses, dxRibbon, dxBar,  uContaContabilModel,uEnderecoModel,uContatoModel,
  uFrameContaContabil, Data.DB,
  FireDAC.Stan.Param,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.DBGrids, Vcl.StdCtrls, uSacadoModel,
  cxBarEditItem, EMsgDlg, cxPC,
  uFrameBanco, uFrameGeneric, uFrameEstado, uFrameBairro, uFrameCidade,
  Vcl.ComCtrls, uFrameTipoSacado, cxLookAndFeels, cxLookAndFeelPainters,
  dxRibbonSkins, dxSkinsCore, dxSkinsDefaultPainters, dxRibbonCustomizationForm,
  dxBarBuiltInMenu, cxTextEdit, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.Grids;

type
  TfrmManterSacado = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    frmContaContabil1: TfrmContaContabil;
    dbgrd1: TDBGrid;
    edtCODREDUZ: TEdit;
    edtContaContabil: TEdit;
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
    dbgrdBanco: TDBGrid;
    lbl23: TLabel;
    dsBanco: TDataSource;
    qryGridBanco: TFDQuery;
    frmBanco1: TfrmBanco;
    dxBarManager1Bar6: TdxBar;
    dxBtnLimpar: TdxBarLargeButton;
    tbTransfereSacado: TcxTabSheet;
    lbl1: TLabel;
    lbl2: TLabel;
    lblCPFCNPJ: TLabel;
    lbl5: TLabel;
    lbl3: TLabel;
    lbl11: TLabel;
    lbl24: TLabel;
    lbl25: TLabel;
    edtCNPJCPF: TEdit;
    edtNomeSacado: TEdit;
    cbbPersonalidade: TComboBox;
    edtInscEstadual: TEdit;
    edtCodigo: TEdit;
    edtStatus: TEdit;
    dtpRegistro: TDateTimePicker;
    frmTipoSacado1: TfrmTipoSacado;
    PempecMsg: TEvMsgDlg;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
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
    procedure frmTipoSacado1cbbcomboChange(Sender: TObject);
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
    procedure tbTransfereSacadoShow(Sender: TObject);
    procedure tbTransfereEnderecoExit(Sender: TObject);
    procedure dxBtnLimparClick(Sender: TObject);
    procedure dsGridMainDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  pPersonalidade,  pIdContaContabil, pIdSacado,pIdTipo, pIdEndereco, pIdContato,  pIdOrganizacao, pIdUsuario :string;
  pIdBanco,  pIdCidade, pIdEstado,pIdBairro :string;

  FsListaPersonalidade,  FslistaTipo,    FsListaIdContas : TStringList;
   FslistaIdBanco,    FsListaIdEstado,FsListaIdCidade,FsListaIdBairro : TStringList;

    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    procedure preencheComboTipo;
    function salvar(sacadoModel :TSacadoModel): Boolean;
    function salvarEndereco(enderecoModel : TEnderecoModel) : Boolean;   //sem uso
    function salvarContato (contatoModel :TContatoModel) :Boolean; //sem uso
    function obterCodigo() :string;


    function qtdUso(pIdOrganizacao, pIdSacado: string): Integer;

    function deletar (sacadoModel :TSacadoModel): Boolean;
    procedure preencheComboPersonalidade;


    procedure preencheGrid(pIdOrganizacao :string);

    function obterPersonalidade(pPersonalidade: String): Integer;
    function obterTipoSacado(pTipo: String): Integer;
    procedure preecheGridBanco;

    function obterEnderecoPorId(pIdOrganizacao, pIdEndereco: string): TFDQuery;
    procedure preencheAbaEndereco(query: TFDQuery);
    procedure preencheAbaContato(query: TFDQuery);

    function obterContatoPorId(pIdOrganizacao, pIdContato: string): TFDQuery;

    procedure limparAba(aba: TcxTabSheet);
    function retornaIndiceCbbBanco(_pIdBanco: string): Integer;
    function obterSacadoPorId(pIdOrganizacao,   pIdSacado: String): TSacadoModel;
    function isValidForm: Boolean;
    function deletaEndereco(pOrganizacao, pEndereco: string): Boolean;
    function deletarContato(pOrganizacao, pContato: string): Boolean;
    procedure registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
    function isValidAbaEndereco: Boolean;
    function isValidAbaContato: Boolean;




  public
    { Public declarations }


  end;

var
  frmManterSacado: TfrmManterSacado;

implementation

{$R *.dfm}

procedure TfrmManterSacado.cbbPersonalidadeChange(Sender: TObject);
begin

 edtCNPJCPF.MaxLength := 18;

  if cbbPersonalidade.ItemIndex > 0 then
  begin
    edtCNPJCPF.Enabled := true;
    pPersonalidade := FsListaPersonalidade[cbbPersonalidade.ItemIndex];
  end;

  if pPersonalidade.Equals('PF') then
  begin
    edtCNPJCPF.MaxLength := 14
  end;


end;

procedure TfrmManterSacado.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
  dbgrd1.DataSource.DataSet.Locate('NOME',UpperCase(cxbrdtmPesquisa.CurEditValue),[loPartialKey]);
end;

procedure TfrmManterSacado.dbgrd1TitleClick(Column: TColumn);
begin
 (dbgrd1.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

procedure TfrmManterSacado.dbgrdBancoTitleClick(Column: TColumn);
begin
 (dbgrdBanco.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

function TfrmManterSacado.deletar (sacadoModel :TSacadoModel): Boolean;
var cmd, cmdEnd, cmdCto :string;
qryDelEnd, qryDelCto, qryDel :TFDQuery;
begin

try

  if not (uutil.Empty( sacadoModel.FID)) then begin
     dmConexao.conectarBanco;
     dmConexao.conn.StartTransaction;

      cmd := ' DELETE FROM SACADO  WHERE  (ID_ORGANIZACAO = :PIDORGANIZACAO) AND (ID_SACADO = :PID) ';

      qryDel := TFDQuery.Create(Self);
      qryDel.Close;
      qryDel.Connection := dmConexao.conn;
      qryDel.SQL.Clear;
      qryDel.SQL.Add(cmd);
      qryDel.ParamByName('PIDORGANIZACAO').AsString := sacadoModel.FIDorganizacao;
      qryDel.ParamByName('PID').AsString := sacadoModel.FID;
      qryDel.ExecSQL;
      dmConexao.conn.CommitRetaining;

      //as FKS foram marcadas como cascade.. assim, serão deletadas diretamente


  end;


  dmConexao.conn.CommitRetaining;
 { FreeAndNil(qryDelEnd);
  FreeAndNil(qryDelCto);
  FreeAndNil(qryDel); }

except
  dmConexao.conn.RollbackRetaining;
  Result := System.False;
raise Exception.Create(' Não foi possível deletar o Sacado. Inform ao suporte.');

end;
  limparPanel;
  Result := System.True;
end;

procedure TfrmManterSacado.dsBancoDataChange(Sender: TObject; Field: TField);
begin

  pIdBanco := qryGridBanco.FieldByName('ID_BANCO').AsString;
  frmBanco1.cbbBanco.ItemIndex := retornaIndiceCbbBanco(pIdBanco) ;

end;

procedure TfrmManterSacado.dsGridMainDataChange(Sender: TObject; Field: TField);
 var
  idContaContabil :string;
  I: Integer;
  conta :TContaContabilModel;
  sacadoModel :TSacadoModel;


begin

     pIdSacado   := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_SACADO').AsString;
     sacadoModel := TSacadoModel.Create;
     sacadoModel := obterSacadoPorId(pIdOrganizacao, pIdSacado);

     if uutil.Empty(sacadoModel.FID) then begin
       ShowMessage('Não foi possível obter os dados do sacado. Verifique com o suporte.');
       Self.Close;
     end;

     edtNomeSacado.Text      := sacadoModel.Fnome;
     edtInscEstadual.Text    := sacadoModel.FinscricaoEstadual;

     edtAgencia.Text         := sacadoModel.FagenciaBancaria;
     edtConta.Text           := sacadoModel.FcontaBancaria;

     edtStatus.Text          := sacadoModel.FStatus;
     edtCodigo.Text          := sacadoModel.FCodigo ;
     dtpRegistro.Date        := sacadoModel.FDataRegistro;
     pPersonalidade          := sacadoModel.Fpersonalidade;

     pIdBanco                := sacadoModel.FIDbanco;
     idContaContabil         := sacadoModel.FIDcontaContabil;
     pIdEndereco             := sacadoModel.FIDendereco;
     pIdContato              := sacadoModel.FIDcontato;
     pIdTipo                 := sacadoModel.FIDtipoSacado;

      Self.dxRibbon1Tab1.Caption := 'Manutenção do cadastro de : ' + UpperCase(edtNomeSacado.Text);
      frmBanco1.cbbBanco.ItemIndex := retornaIndiceCbbBanco(pIdBanco);
      cbbPersonalidade.ItemIndex := obterPersonalidade(sacadoModel.Fpersonalidade);
      frmTipoSacado1.cbbcombo.ItemIndex := obterTipoSacado(sacadoModel.FIDtipoSacado);



     if cbbPersonalidade.ItemIndex = 1 then begin
       //cpf
       edtCNPJCPF.Text := uutil.TFormat.formacpf(sacadoModel.FcpfCnpj);
     end;

      if cbbPersonalidade.ItemIndex = 2 then begin
       //cnpj
       edtCNPJCPF.Text := uutil.TFormat.formacnpj(sacadoModel.FcpfCnpj);
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
     idContaContabil := sacadoModel.FIDcontaContabil;

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
          edtCODREDUZ.Text      := conta.FCodigoReduzido;
          edtContaContabil.Text := conta.FConta;
          pIdContaContabil      := conta.FID;
        end;

        Break

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
    if qtdUso(pIdOrganizacao, pIdSacado) = 0 then
    begin
      dxBtnDeletar.Enabled := True;
    end
    else
    begin
      dxBtnDeletar.Enabled := False;
    end;

     dxBtnEditar.Enabled := True;

end;

function TfrmManterSacado.retornaIndiceCbbBanco(_pIdBanco :string) :Integer;
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


procedure TfrmManterSacado.dxBtnDeletarClick(Sender: TObject);
var
  sacadoModel: TSacadoModel;
begin
  if not dmConexao.conn.InTransaction then
    dmConexao.conn.StartTransaction;

  try

    sacadoModel := TSacadoModel.Create;
    sacadoModel.FIDorganizacao := pIdOrganizacao;
    sacadoModel.FID := pIdSacado;
    sacadoModel := TSacadoDAO.obterPorID(sacadoModel);

    if not uUtil.Empty(sacadoModel.FID) then
    begin
      if TSacadoDAO.Delete(sacadoModel) then
      begin
        registraMovimentacao(pIDOrganizacao, 'SACADO', 'DELETAR SACADO', uutil.TUserAtual.getNameUser + ' DELETOU ' + sacadoModel.Fnome, 'DELETADO');
        PempecMsg.MsgInformation('Sacado : ' + sacadoModel.Fnome + ' deletado com sucesso.');
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

procedure TfrmManterSacado.dxBtnEditarClick(Sender: TObject);

begin
  dbgrd1.Enabled     :=False;
  dbgrdBanco.Enabled :=True;

  frmContaContabil1.cbbContaContabil.Enabled :=True;
  cxbrdtmPesquisa.Enabled :=False;

  pIdSacado :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_SACADO').AsString;

  cxbrdtmPesquisa.Enabled :=False;
  edtCNPJCPF.Enabled := True;

  dxBtnSalvar.Enabled  :=True ;
  dxBtnNovo.Enabled    :=False;
  dxBtnDeletar.Enabled :=False;

end;

procedure TfrmManterSacado.dxBtnFecharClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManterSacado.dxBtnLimparClick(Sender: TObject);
begin
limparPanel;
end;

procedure TfrmManterSacado.dxBtnNovoClick(Sender: TObject);
begin
  limparPanel;
  limparAba(Self.tbTransfereSacado);
  limparAba(Self.tbTransfereEndereco);
  limparAba(Self.tbTransfereContato);
  limparAba(Self.tbTransfereContaBancaria);
  limparAba(Self.tbTransfereContaContabil);

  dbgrd1.Enabled :=False;
 (dbgrd1.DataSource.DataSet as TFDQuery).Close;
  frmContaContabil1.cbbContaContabil.Enabled :=True;
  frmContaContabil1.cbbContaContabil.ItemIndex :=0;
  frmBanco1.cbbBanco.ItemIndex :=0;
  frmTipoSacado1.cbbcombo.ItemIndex :=0;
  frmEstado1.cbbcombo.ItemIndex :=0;
  frmCidade1.cbbcombo.ItemIndex :=0;
  frmBairro1.cbbcombo.ItemIndex :=0;

  dxBtnSalvar.Enabled      :=True;
  dxBtnEditar.Enabled      :=False;
  pIdSacado :='';
  cxbrdtmPesquisa.Enabled :=False;
  edtCodigo.Text := obterCodigo;


end;

procedure TfrmManterSacado.dxBtnSalvarClick(Sender: TObject);
var
 conta :TContaContabilModel;
 pDescricao, pTipo :string;
 pCodigo  :Integer;
 sacado  : TSacadoModel;
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
      endereco                 := TEnderecoModel.Create;
      endereco.FID             := pIdEndereco;
      endereco.FIDorganizacao  := pIdOrganizacao;
      endereco.FLOGRADOURO     := edtLogradouro.Text;
      endereco.FIDCIDADE       := pIdCidade;
      endereco.FCEP            := edtCEP.Text;
      endereco.FNUMERO         := edtNumero.Text;
      endereco.FIDBAIRRO       := pIdBairro;
      endereco.FIDESTADO       := pIdEstado;
      endereco.FCOMPLEMENTO    := edtComplemento.Text;

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


      if uUtil.Empty(pIdSacado) then pIdSacado := dmConexao.obterNewID;



      sacado                       := TSacadoModel.Create;
      sacado.FIDorganizacao        := pIdOrganizacao;
      sacado.FID                   := pIdSacado;

      sacado := TSacadoDAO.obterPorID(sacado);


      if uUtil.Empty(sacado.FID) then
      begin
        sacado.FIDorganizacao := pIdOrganizacao;
        sacado.FID := pIdSacado;
        sacado.Fnovo := True;
      end;

      sacado.FinscricaoEstadual    := edtInscEstadual.Text;
      sacado.FIDcontaContabil      := pIdContaContabil; // FsListaIdContas[frmContaContabil1.cbbContaContabil.ItemIndex];
      sacado.FIDendereco           := pIdEndereco;
      sacado.FIDcontato            := pIdContato;
      sacado.FagenciaBancaria      := edtAgencia.Text;
      sacado.FcontaBancaria        := edtConta.Text;
      sacado.FIDbanco              := pIdBanco;
      sacado.Fnome                 := UpperCase(TrimLeft(edtNomeSacado.Text));
      sacado.Fpersonalidade        := FsListaPersonalidade[cbbPersonalidade.ItemIndex];
      sacado.FIDtipoSacado         := pIdTipo;
      sacado.FcpfCnpj              := edtCNPJCPF.Text;
      sacado.FIDorganizacao        := pIdOrganizacao;
      sacado.FStatus               := UpperCase(edtStatus.Text);
      sacado.FCodigo               := edtCodigo.Text;
      sacado.FDataUltimaAtualizacao := Now;
      sacado.FDataRegistro         := dtpRegistro.Date;

       if sucesso then
      begin

        if sacado.Fnovo then
        begin

          if TSacadoDAO.Insert(sacado) then           begin

             PempecMsg.MsgInformation('Sacado ' + sacado.Fnome +  '  salvo com sucesso.');
            registraMovimentacao(pIDOrganizacao, 'SACADO', 'MANTER SACADO', uutil.TUserAtual.getNameUser +  ' SALVOU ' + sacado.FCodigo + ' '+ sacado.Fnome , 'MANTIDO');
          end;
        end
        else
        begin
          if TSacadoDAO.Update(sacado) then
          begin
            PempecMsg.MsgInformation('Sacado : ' + (sacado.Fnome) + '  alterado com sucesso.');
            registraMovimentacao(pIDOrganizacao, 'SACADO', 'ALTERAR SACADO', uutil.TUserAtual.getNameUser +  ' ALTEROU ' + sacado.FCodigo + ' '+ sacado.Fnome , 'ALTERADO');
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

      ShowMessage(e.Message + sLineBreak + ' Não foi possível salvar o sacado.');

    end;

  end;


end;


procedure TfrmManterSacado.edtCelularExit(Sender: TObject);
begin
edtCelular.Text := uutil.FormatarTelefone (edtCelular.Text);
end;

procedure TfrmManterSacado.edtCNPJCPFExit(Sender: TObject);
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

procedure TfrmManterSacado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freeAndNilDM(Self);
 Action :=caFree;

end;

procedure TfrmManterSacado.FormCreate(Sender: TObject);
begin
 inicializarDM(Self);
 limparPanel;
end;

procedure TfrmManterSacado.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case key of
  vk_f2: dxBtnEditar.Click;
  vk_f4: dxBtnNovo.Click;
  vk_f10: dxBtnSalvar.Click;
end;

end;

procedure TfrmManterSacado.freeAndNilDM(Sender: TObject);
begin

//nada
end;

procedure TfrmManterSacado.frmBairro1cbbcomboChange(Sender: TObject);
begin
  if frmBairro1.cbbcombo.ItemIndex >0 then begin
  pIdBairro := FsListaIdBairro[frmBairro1.cbbcombo.ItemIndex];
 end;
end;

procedure TfrmManterSacado.frmCidade1cbbcomboChange(Sender: TObject);
begin
   if frmCidade1.cbbcombo.ItemIndex > 0 then
  begin
    pIdCidade := FsListaIdCidade[frmCidade1.cbbcombo.ItemIndex];
    frmBairro1.obterTodosPorCidade(pIdCidade, frmBairro1.cbbcombo, FsListaIdBairro);
  end;


end;

procedure TfrmManterSacado.frmContaContabil1cbbContaContabilChange(
  Sender: TObject);
  var
  conta : TContaContabilModel;
begin
  if frmContaContabil1.cbbContaContabil.ItemIndex > 0 then
  begin

    pIdContaContabil := FsListaIdContas[frmContaContabil1.cbbContaContabil.ItemIndex];
    conta := TContaContabilModel.Create;
    conta := frmContaContabil1.obterPorID(pIdOrganizacao, pIdContaContabil);

    if not uUtil.Empty(conta.FCodigoReduzido) then
    begin
      edtCODREDUZ.Text := conta.FCodigoReduzido;
      edtContaContabil.Text := conta.FConta;
      pIdContaContabil :=conta.FID;
    end;

  end;

end;

procedure TfrmManterSacado.frmEstado1cbbcomboChange(Sender: TObject);
begin
 pIdEstado := FsListaIdEstado[frmEstado1.cbbcombo.ItemIndex];
 frmCidade1.obterPorEstado(pIdEstado,frmCidade1.cbbcombo, FsListaIdCidade);

end;

procedure TfrmManterSacado.frmTipoSacado1cbbcomboChange(Sender: TObject);
begin
 if frmTipoSacado1.cbbcombo.ItemIndex  >0 then begin
   pIdTipo := FslistaTipo[frmTipoSacado1.cbbcombo.ItemIndex];
   edtStatus.Text := 'ATIVO';
  end;
end;

procedure TfrmManterSacado.inicializarDM(Sender: TObject);
begin
 //nada
 if not Assigned(dmOrganizacao) then begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
 end;

 limparPanel;


end;

procedure TfrmManterSacado.limparPanel();
begin
 uutil.LimpaTela(Self);
 limpaStatusBar;

 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdUsuario :=uutil.TUserAtual.getUserId;

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

   limparAba(Self.tbTransfereSacado);
  limparAba(Self.tbTransfereEndereco);
  limparAba(Self.tbTransfereContato);
  limparAba(Self.tbTransfereContaBancaria);
  limparAba(Self.tbTransfereContaContabil);
  frmBanco1.cbbBanco.ItemIndex :=0;
  frmTipoSacado1.cbbcombo.ItemIndex :=0;
  edtStatus.Text := 'ATIVO';
  Self.dxRibbon1Tab1.Caption := 'Manutenção do cadastro de sacados/clientes.';




end;


procedure TfrmManterSacado.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmManterSacado.preencheGrid(pIdOrganizacao: string);
var
 cmdSql :string;
begin

dmConexao.conectarBanco;
if uutil.Empty(pIdOrganizacao) then begin pIdOrganizacao := TOrgAtual.getId; end;

   cmdSql := ' SELECT C.ID_SACADO, C.ID_ORGANIZACAO,' +
                     ' C.ID_TIPO_SACADO, TC.DESCRICAO AS TIPO,  C.ID_ENDERECO,' +
                     ' C.ID_CONTATO, C.NOME, C.CPFCNPJ,' +
                     ' C.PERSONALIDADE, C.CONTA_BANCARIA,' +
                     ' C.AGENCIA, C.ID_BANCO, ' +
                     ' C.INSCRICAO_ESTADUAL,  C.ID_CONTA_CONTABIL,' +
                     ' C.DATA_REGISTRO, C.STATUS, ' +
                     ' C.DATA_ULTIMA_ATUALIZACAO, C.CODIGO, CTO.TELEFONE, CTO.CELULAR' +
             ' FROM SACADO C ' +
             ' LEFT OUTER JOIN CONTATO CTO ON (CTO.ID_CONTATO = C.ID_CONTATO) AND (CTO.ID_ORGANIZACAO = C.ID_ORGANIZACAO)'+
             ' LEFT OUTER JOIN TIPO_SACADO TC ON (TC.ID_TIPO_SACADO = C.ID_TIPO_SACADO) AND (TC.ID_ORGANIZACAO = C.ID_ORGANIZACAO) '+
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

function TfrmManterSacado.qtdUso(pIdOrganizacao, pIdSacado: string): Integer;
  var
qryTP, qryTR : TFDQuery;
cmd : string;
qtd :Integer;

begin
  dmConexao.conectarBanco;
  qtd := 0;

  try

    cmd := ' SELECT  FIRST 1 TP.ID_TITULO_RECEBER  FROM TITULO_RECEBER TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_SACADO = :PID) ';

    qryTP := TFDQuery.Create(Self);
    qryTP.Close;
    qryTP.Connection := dmConexao.conn;
    qryTP.SQL.Clear;
    qryTP.SQL.Add(cmd);
    qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTP.ParamByName('PID').AsString := pIdSacado;
    qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

     if qtd < 1 then
    begin

      cmd := ' SELECT FIRST 1 TP.ID_TESOURARIA_CREDITO FROM TESOURARIA_CREDITO TP '+
             ' WHERE  (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_SACADO = :PID) ';

      qryTP := TFDQuery.Create(Self);
      qryTP.Close;
      qryTP.Connection := dmConexao.conn;
      qryTP.SQL.Clear;
      qryTP.SQL.Add(cmd);
      qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTP.ParamByName('PID').AsString := pIdSacado;
      qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

    end;

  except
    raise Exception.Create('Erro ao buscar uso dos SACADOS ');

  end;

  Result := qtd;

end;

procedure TfrmManterSacado.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ';
end;

function TfrmManterSacado.obterPersonalidade(pPersonalidade :String) :Integer;
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

function TfrmManterSacado.obterTipoSacado(pTipo :String) :Integer;
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




procedure TfrmManterSacado.preencheComboTipo;
begin
frmTipoSacado1.obterTodos(pIdOrganizacao,frmTipoSacado1.cbbcombo, FslistaTipo);
end;


function  TfrmManterSacado.salvar (sacadoModel :TSacadoModel): Boolean;
var
cmdSalvar :string;
qrySalvar :TFDQuery;
begin

 dmConexao.conectarBanco;
 try

             cmdSalvar := ' UPDATE SACADO '  +
                          ' SET ID_TIPO_SACADO =     :PIDTIPO, '+
                          '     ID_ENDERECO =         :PIDENDERECO,'+
                          '     ID_CONTATO =          :PIDCONTATO,'+
                          '     NOME =                :PNOME,'+
                          '     CPFCNPJ =             :PCNPJ,'+
                          '     PERSONALIDADE =       :PPERSONALIDADE,'+
                          '     CONTA_BANCARIA =      :PCONTA, '+
                          '     AGENCIA =             :PAGENCIA,'+
                          '     ID_BANCO =            :PIDBANCO,'+
                          '     INSCRICAO_ESTADUAL  = :PINSCEST,'+
                          '     ID_CONTA_CONTABIL   = :PIDCONTACTB,'+
                          '     STATUS              = :PSTATUS, '+
                          '     DATA_ULTIMA_ATUALIZACAO = :PDATA,'+
                          '     DATA_REGISTRO       = :PDATAREGISTRO, '+
                          '     CODIGO              = :PCODIGO '+
                          '     WHERE (ID_SACADO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';


   if UUTIL.Empty(sacadoModel.FID) then begin

     sacadoModel.FID := dmConexao.obterNewID;
     sacadoModel.FDataRegistro :=Now;
     sacadoModel.FCodigo := obterCodigo;



      cmdSalvar := ' INSERT  INTO SACADO (ID_SACADO, ID_ORGANIZACAO, ID_BANCO, ' +
                    ' ID_TIPO_SACADO, ID_ENDERECO, ID_CONTATO, ID_CONTA_CONTABIL,  '+
                    ' NOME, CPFCNPJ, PERSONALIDADE, AGENCIA, CONTA_BANCARIA,CODIGO, STATUS, '+
                    ' INSCRICAO_ESTADUAL, DATA_REGISTRO, DATA_ULTIMA_ATUALIZACAO ) '+
                    ' VALUES (:PID, :PIDORGANIZACAO, :PIDBANCO, '+
                    '         :PIDTIPO, :PIDENDERECO, :PIDCONTATO, :PIDCONTACTB, '+
                    '         :PNOME, :PCNPJ, :PPERSONALIDADE, :PAGENCIA, :PCONTA, :PCODIGO, :PSTATUS, '+
                    '         :PINSCEST, :PDATAREGISTRO, :PDATA ) ' ;

    end;

    if not uUtil.Empty(sacadoModel.FID) then
    begin
      qrySalvar := TFDQuery.Create(Self);
      qrySalvar.Close;
      qrySalvar.Connection := dmConexao.conn;
      qrySalvar.SQL.Clear;
      qrySalvar.SQL.Add(cmdSalvar);
      qrySalvar.ParamByName('PID').AsString               := sacadoModel.FID;
      qrySalvar.ParamByName('PIDORGANIZACAO').AsString    := sacadoModel.FIDorganizacao;

      qrySalvar.ParamByName('PIDBANCO').AsString          := sacadoModel.FIDbanco;
      qrySalvar.ParamByName('PIDTIPO').AsString           := sacadoModel.FIDtipoSacado;
      qrySalvar.ParamByName('PIDENDERECO').AsString       := sacadoModel.FIDendereco;
      qrySalvar.ParamByName('PIDCONTATO').AsString        := sacadoModel.FIDcontato;
      qrySalvar.ParamByName('PIDCONTACTB').AsString       := sacadoModel.FIDcontaContabil;


      qrySalvar.ParamByName('PNOME').AsString             := UpperCase(sacadoModel.Fnome);
      qrySalvar.ParamByName('PCNPJ').AsString             := sacadoModel.FcpfCnpj;
      qrySalvar.ParamByName('PPERSONALIDADE').AsString    := sacadoModel.Fpersonalidade;
      qrySalvar.ParamByName('PAGENCIA').AsString          := sacadoModel.FagenciaBancaria;
      qrySalvar.ParamByName('PCONTA').AsString            := sacadoModel.FcontaBancaria;
      qrySalvar.ParamByName('PCODIGO').AsString           := sacadoModel.FCodigo;
      qrySalvar.ParamByName('PSTATUS').AsString           := sacadoModel.FStatus;
      qrySalvar.ParamByName('PINSCEST').AsString          := sacadoModel.FinscricaoEstadual;
      qrySalvar.ParamByName('PDATAREGISTRO').AsDate       := sacadoModel.FDataRegistro;
      qrySalvar.ParamByName('PDATA').AsDate               := Now;


          if sacadoModel.FIDbanco = EmptyStr then
          begin
            qrySalvar.ParamByName('PIDBANCO').Value := null;
          end;
          if sacadoModel.FIDendereco = EmptyStr then
          begin
            qrySalvar.ParamByName('PIDENDERECO').Value := null;
          end;
          if sacadoModel.FIDcontato = EmptyStr then
          begin
            qrySalvar.ParamByName('PIDCONTATO').Value := null;
          end;
          if sacadoModel.FIDcontaContabil = EmptyStr then
          begin
            qrySalvar.ParamByName('PIDCONTACTB').Value := null;
          end;


      qrySalvar.ExecSQL;

      pIdSacado := sacadoModel.FID;
      dmConexao.conn.CommitRetaining;

    end;

 except
 dmConexao.conn.RollbackRetaining;
 Result :=False;
  raise Exception.Create('Erro ao tentar salvar o sacado.');
 end;

  Result :=System.True;
end;

function TfrmManterSacado.salvarContato(contatoModel: TContatoModel): Boolean;
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
      cmdSalvar := ' INSERT INTO CONTATO (ID_CONTATO, ID_ORGANIZACAO,  TELEFONE, CELULAR, EMAIL ) '+
                '               VALUES (:PID, :PIDORGANIZACAO, :PTEL, :PCEL, :PEMAIL)' ;
   end;

    if not uUtil.Empty(contatoModel.FID) then
    begin

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

      qrySalvar.ExecSQL;

      pIdContato := contatoModel.FID;
    end;

 except
 Result :=False;
  raise Exception.Create('Erro ao tentar salvar o CONTATO.');
 end;

  Result :=True;


end;

function TfrmManterSacado.salvarEndereco(enderecoModel: TEnderecoModel): Boolean;
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
      cmdSalvar := ' INSERT INTO ENDERECO (ID_ENDERECO, ID_ORGANIZACAO, ID_ESTADO, LOGRADOURO, COMPLEMENTO, ID_BAIRRO, NUMERO, CEP, ID_CIDADE) '+
                '               VALUES (:PID, :PIDORGANIZACAO, :PIDESTADO, :PLOGRADOURO, :PCOMPLEMENTO, :PIDBAIRRO, :PNUMERO, :PCEP, :PIDCIDADE)' ;
   end;

    if not uUtil.Empty(enderecoModel.FID) then
    begin

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


      qrySalvar.ExecSQL;


      pIdEndereco := enderecoModel.FID;

    end;

 except
 Result :=False;
  raise Exception.Create('Erro ao tentar salvar o ENDERECO.');
 end;

  Result :=True;


end;

procedure TfrmManterSacado.tbTransfereSacadoShow(Sender: TObject);
begin
  dbgrd1.Visible :=True;
  msgStatusBar(1,' Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ');

end;

procedure TfrmManterSacado.tbTransfereContaBancariaShow(Sender: TObject);
begin
 dbgrd1.Visible :=False;
 msgStatusBar(1,'Dados da conta bancária');

end;

procedure TfrmManterSacado.tbTransfereContaContabilShow(Sender: TObject);
begin
  dbgrd1.Visible :=False;
   msgStatusBar(1,'Dados da conta contábil');
end;

procedure TfrmManterSacado.tbTransfereContatoShow(Sender: TObject);
begin
 dbgrd1.Visible :=False;
  msgStatusBar(1,'Contatos cadastrados');
end;

procedure TfrmManterSacado.tbTransfereEnderecoExit(Sender: TObject);
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

procedure TfrmManterSacado.tbTransfereEnderecoShow(Sender: TObject);
begin
 dbgrd1.Visible :=False;
  msgStatusBar(1,'Dados do endereço');
end;


procedure TfrmManterSacado.preencheComboPersonalidade;
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


procedure TfrmManterSacado.preecheGridBanco;
begin

 dmConexao.conectarBanco;
 try

   qryGridBanco.Close;
   qryGridBanco.Connection := dmConexao.conn;
   //qryGridBanco.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   qryGridBanco.Open;

 except
 raise Exception.Create('Erro ao obter lista de bancos');

 end;

end;

function TfrmManterSacado.obterCodigo: string;
var
qryPesquisa :TFDQuery;
sqlEnd :string;
cod :string;

begin
dmConexao.conectarBanco;

   sqlEnd := ' SELECT MAX ( CAST( C.CODIGO AS INTEGER) +1 ) AS CODIGO  FROM SACADO C WHERE 1=1 ';

 try
     qryPesquisa := TFDQuery.Create(Self);
     qryPesquisa.Close;
     qryPesquisa.Connection := dmConexao.conn;
     qryPesquisa.SQL.Clear;
     qryPesquisa.SQL.Add(sqlEnd);
     qryPesquisa.Open;

     if uUtil.Empty(qryPesquisa.FieldByName('CODIGO').AsString) then begin

       cod := '1000';

     end else begin cod := qryPesquisa.FieldByName('CODIGO').AsString; end;


 except

  raise Exception.Create('Erro ao obter código ');

 end;

 Result := cod;

end;

function TfrmManterSacado.obterContatoPorId(pIdOrganizacao,  pIdContato: string): TFDQuery;
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


function TfrmManterSacado.obterEnderecoPorId(pIdOrganizacao, pIdEndereco :string) :TFDQuery;
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

  raise Exception.Create('Erro ao obter endereço ');

 end;

 Result := qryEndereco;

end;

procedure TfrmManterSacado.preencheAbaContato(query: TFDQuery);
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

procedure TfrmManterSacado.preencheAbaEndereco( query :TFDQuery);
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

procedure TfrmManterSacado.limparAba(aba :TcxTabSheet );
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



function TfrmManterSacado.obterSacadoPorId(pIdOrganizacao, pIdSacado: String): TSacadoModel;
  var
  qryPesquisa :TFDQuery;
 sqlEnd :string;
 sacado :TSacadoModel;

begin
 dmConexao.conectarBanco ;
 sacado := TSacadoModel.Create;

  sqlEnd := ' SELECT * FROM SACADO C ' +
                  ' WHERE (C.ID_ORGANIZACAO = :pIdOrganizacao) ' + ' AND ' +
                  '(C.ID_SACADO = :pIdSacado)';

 try

    qryPesquisa := TFDQuery.Create(Self);
    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.Conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add(sqlEnd);
    qryPesquisa.ParamByName('pIdOrganizacao').AsString :=   pIdOrganizacao;
    qryPesquisa.ParamByName('pIdSacado').AsString := pIdSacado;
    qryPesquisa.Open;

    if  not qryPesquisa.IsEmpty then begin


     sacado.FinscricaoEstadual     := qryPesquisa.FieldByName('INSCRICAO_ESTADUAL').AsString;
     sacado.FagenciaBancaria       := qryPesquisa.FieldByName('AGENCIA').AsString;
     sacado.FcontaBancaria         := qryPesquisa.FieldByName('CONTA_BANCARIA').AsString;

     sacado.Fnome                  := qryPesquisa.FieldByName('NOME').AsString;
     sacado.Fpersonalidade         := qryPesquisa.FieldByName('PERSONALIDADE').AsString;

     sacado.FcpfCnpj               := qryPesquisa.FieldByName('CPFCNPJ').AsString;

     sacado.FCodigo                := qryPesquisa.FieldByName('CODIGO').AsString;
     sacado.FStatus                := qryPesquisa.FieldByName('STATUS').AsString;
     sacado.FDataRegistro          := qryPesquisa.FieldByName('DATA_REGISTRO').AsDateTime;

     sacado.FIDtipoSacado         := qryPesquisa.FieldByName('ID_TIPO_SACADO').AsString;
     sacado.FIDorganizacao         := qryPesquisa.FieldByName('ID_ORGANIZACAO').AsString;
     sacado.FIDbanco               := qryPesquisa.FieldByName('ID_BANCO').AsString;
     sacado.FID                    := qryPesquisa.FieldByName('ID_SACADO').AsString;
     sacado.FIDcontaContabil       := qryPesquisa.FieldByName('ID_CONTA_CONTABIL').AsString;
     sacado.FIDendereco            := qryPesquisa.FieldByName('ID_ENDERECO').AsString;
     sacado.FIDcontato             := qryPesquisa.FieldByName('ID_CONTATO').AsString;


     if uutil.Empty(qryPesquisa.FieldByName('CODIGO').AsString) then begin

       sacado.FCodigo := obterCodigo;

     end;


    end;



 except
 raise Exception.Create('Erro ao tentar obter sacado por ID');


 end;

    Result := sacado;

end;

 function TfrmManterSacado.isValidForm :Boolean;
var i:integer;
liberado : Boolean;

begin
 liberado :=false;
 msgStatusBar(1, 'Verifique os campos obrigatórios.');

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
                    PempecMsg.MsgWarning('Alguns campos obrigatórios não foram preenchidos!' +#13 + 'A conta contábil é obrigatória.');
                    msgStatusBar(1, 'O cliente precisa ter conta contábil, endereço e contato. Verifique todas as abas');
                    Break
                  end;

          end
          else
          begin
            liberado := True;
          end;

        end;
      end;

    if frmContaContabil1.cbbContaContabil.ItemIndex = 0 then
      begin

        liberado := false;
        PempecMsg.MsgWarning('Atenção !' + #13 + 'A conta contábil é obrigatória.');
        frmContaContabil1.SetFocus;

      end;



Result := liberado;
end;


function TfrmManterSacado.deletaEndereco (pOrganizacao, pEndereco :string) : Boolean;
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



function TfrmManterSacado.deletarContato(pOrganizacao, pContato :string) : Boolean;
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

function TfrmManterSacado.isValidAbaEndereco: Boolean;
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

 function TfrmManterSacado.isValidAbaContato: Boolean;
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


procedure TfrmManterSacado.registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
begin
  TMDDAO.registroMD(pOrg, pTable, pAcao, pDsc, pStatus);

end;


end.

