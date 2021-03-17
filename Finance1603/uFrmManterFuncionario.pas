unit uFrmManterFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinsDefaultPainters, udmConexao, uUtil, uDMOrganizacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins,
  dxRibbonCustomizationForm, dxStatusBar, cxClasses, dxRibbon, dxBar,  uContaContabilModel,uEnderecoModel,uContatoModel,
  uFrameContaContabil, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, System.StrUtils,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, cxContainer,
  cxEdit, cxTextEdit, cxBarEditItem, EMsgDlg, dxBarBuiltInMenu, cxPC, uEnderecoDAO, uContatoDAO,
  uFrameBanco, uFrameGeneric, uFrameEstado, uFrameBairro, uFrameCidade, uFuncionarioModel, uFuncionarioDAO,
  EChkCNPJ, uFrameCartaoCredito, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfrmManterFuncionario = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    frmContaContabil1: TfrmContaContabil;
    dbgrd1: TDBGrid;
    dsMain: TDataSource;
    edtCODREDUZ: TEdit;
    edtContaContabil: TEdit;
    lbl2: TLabel;
    edtNome: TEdit;
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
    tbFuncionario: TcxTabSheet;
    tbEndereco: TcxTabSheet;
    tbContato: TcxTabSheet;
    tbContaBancaria: TcxTabSheet;
    tbContaContabil: TcxTabSheet;
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
    rdStatus: TRadioGroup;
    PempecMsg: TEvMsgDlg;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dsMainDataChange(Sender: TObject; Field: TField);
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
    procedure frmCidade1cbbcomboChange(Sender: TObject);
    procedure frmBairro1cbbcomboChange(Sender: TObject);
    procedure dsBancoDataChange(Sender: TObject; Field: TField);
    procedure dbgrdBancoTitleClick(Column: TColumn);
    procedure tbContaBancariaShow(Sender: TObject);
    procedure tbContaContabilShow(Sender: TObject);
    procedure tbContatoShow(Sender: TObject);
    procedure tbEnderecoShow(Sender: TObject);
    procedure tbFuncionarioShow(Sender: TObject);
    procedure tbEnderecoExit(Sender: TObject);
    procedure dxBtnLimparClick(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
    procedure edtCNPJCPFExit(Sender: TObject);
  private
    { Private declarations }
  pIdContaContabil, pIdModel,pIdTipo, pIdEndereco, pIdContato,  pIdOrganizacao, pIdUsuario :string;
  pIdBanco,  pIdCidade, pIdEstado,pIdBairro :string;

   FsListaIdContas : TStringList;
   FSlistaIDmodel,  FslistaIdBanco,   FsListaIdEstado,FsListaIdCidade,FsListaIdBairro : TStringList;
   // FSlistaIDmodel //é o model do form.

    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    function qtdUso(pIdOrganizacao, pIDModel: string): Integer;
    procedure preencheGrid(pIdOrganizacao: string);
    procedure preecheGridBanco;
    procedure preencheAbaEndereco(endereco: TEnderecoModel);
    procedure preencheAbaContato(contato: TContatoModel);
    procedure limparAba(aba: TcxTabSheet);
    function retornaIndiceCbbBanco(_pIdBanco: string): Integer;
    function isValidForm: Boolean;
    function isValidAbaContato: Boolean;
    function isValidAbaEndereco: Boolean;
  public
    { Public declarations }
  end;

var
  frmManterFuncionario: TfrmManterFuncionario;

implementation

{$R *.dfm}


procedure TfrmManterFuncionario.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
  dbgrd1.DataSource.DataSet.Locate('NOME',UpperCase(cxbrdtmPesquisa.CurEditValue),[loPartialKey]);
end;

procedure TfrmManterFuncionario.dbgrd1TitleClick(Column: TColumn);
begin
 (dbgrd1.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

procedure TfrmManterFuncionario.dbgrdBancoTitleClick(Column: TColumn);
begin
 (dbgrdBanco.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;


procedure TfrmManterFuncionario.dsBancoDataChange(Sender: TObject; Field: TField);
begin

  pIdBanco := qryGridBanco.FieldByName('ID_BANCO').AsString;
  frmBanco1.cbbBanco.ItemIndex := retornaIndiceCbbBanco(pIdBanco) ;

end;

function TfrmManterFuncionario.retornaIndiceCbbBanco(_pIdBanco :string) :Integer;
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



procedure TfrmManterFuncionario.dsMainDataChange(Sender: TObject;
  Field: TField);
  var
  idContaContabil :string;
  I: Integer;
  conta :TContaContabilModel;
  funcionarioModel :TFuncionarioModel;
begin

  limparAba(Self.tbFuncionario);
  limparAba(Self.tbEndereco);
  limparAba(Self.tbContato);
  limparAba(Self.tbContaBancaria);
  limparAba(Self.tbContaContabil);
  frmContaContabil1.cbbContaContabil.ItemIndex := 0;

  frmBanco1.cbbBanco.ItemIndex := 0;
  frmEstado1.cbbcombo.ItemIndex := 0;
  frmCidade1.cbbcombo.ItemIndex := 0;
  frmBairro1.cbbcombo.ItemIndex := 0;

  pIdModel := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_FUNCIONARIO').AsString;

  funcionarioModel := TFuncionarioModel.Create;
  funcionarioModel.FID := pIdModel;
  funcionarioModel.FIDorganizacao := pIdOrganizacao;
  funcionarioModel := TFuncionarioDAO.obterPorID(funcionarioModel);

  if not uutil.Empty(funcionarioModel.FID) then
  begin

    if funcionarioModel.Fativo = 1 then
    begin
      rdStatus.ItemIndex := 0;
    end
    else
    begin
      rdStatus.ItemIndex := 1;
    end;

    edtNome.Text := UpperCase(funcionarioModel.FNOME);
    edtCNPJCPF.Text := funcionarioModel.FCPF;

    if not uUtil.Empty(funcionarioModel.FIDEndereco) then
    begin
      pIdEndereco := funcionarioModel.FIDendereco;
      preencheAbaEndereco(funcionarioModel.Fendereco);

    end;

    if not uUtil.Empty(funcionarioModel.FIDContato) then
    begin
       pIdContato := funcionarioModel.FIDcontato;
       preencheAbaContato(funcionarioModel.Fcontato);

    end;

    Self.dxRibbon1Tab1.Caption := 'Manutenção do cadastro de : ' + UpperCase(edtNome.Text);
    frmBanco1.cbbBanco.ItemIndex := retornaIndiceCbbBanco(pIdBanco);

     idContaContabil := '';
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
    if qtdUso(pIdOrganizacao, pIdModel) = 0 then
    begin
      dxBtnDeletar.Enabled := True;
    end
    else
    begin
      dxBtnDeletar.Enabled := False;
    end;

    dxBtnEditar.Enabled := True;

  end;

end;


procedure TfrmManterFuncionario.dxBtnDeletarClick(Sender: TObject);
var
model : TFuncionarioModel;
sucesso: Boolean;
begin

  dmConexao.conectarBanco;
  sucesso := False;

  model := TFuncionarioModel.Create;
  model.FIDorganizacao := pIdOrganizacao;
  model.FID := pIdModel;

  model := TFuncionarioDAO.obterPorID(model);

  if not (uutil.Empty(model.FID)) then
  begin
    sucesso := TFuncionarioDAO.Delete(model);  //ver os detalhes
  end
  else
  begin
    sucesso := False;

   PempecMsg.MsgInformation('Funcionário : ' + model.FNOME + #13 + ' não localizado.');
  end;

  if sucesso then
  begin

    PempecMsg.MsgInformation('Funcionário : ' + model.FNOME + #13 + ' deletado com sucesso.');
    limparPanel;
  end;

end;

procedure TfrmManterFuncionario.dxBtnEditarClick(Sender: TObject);

begin
  dbgrd1.Enabled     :=False;
  dbgrdBanco.Enabled :=True;

  frmContaContabil1.cbbContaContabil.Enabled :=True;
  cxbrdtmPesquisa.Enabled :=False;

  pIdModel    :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_FUNCIONARIO').AsString;
  pIdEndereco := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_ENDERECO').AsString;
  pIdContato  := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CONTATO').AsString;

  cxbrdtmPesquisa.Enabled :=False;
  edtCNPJCPF.Enabled := True;

  dxBtnSalvar.Enabled  :=True ;
  dxBtnNovo.Enabled    :=False;
  dxBtnDeletar.Enabled :=False;

end;

procedure TfrmManterFuncionario.dxBtnFecharClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManterFuncionario.dxBtnLimparClick(Sender: TObject);
begin
limparPanel;
  frmContaContabil1.cbbContaContabil.ItemIndex :=0;
  frmBanco1.cbbBanco.ItemIndex :=0;
  frmEstado1.cbbcombo.ItemIndex :=0;
  frmCidade1.cbbcombo.ItemIndex :=0;
  frmBairro1.cbbcombo.ItemIndex :=0;

end;

procedure TfrmManterFuncionario.dxBtnNovoClick(Sender: TObject);
begin
  limparPanel;
  dbgrd1.Enabled :=False;
 (dbgrd1.DataSource.DataSet as TFDQuery).Close;
  frmContaContabil1.cbbContaContabil.Enabled :=True;
  frmContaContabil1.cbbContaContabil.ItemIndex :=0;
  frmBanco1.cbbBanco.ItemIndex :=0;

  frmEstado1.cbbcombo.ItemIndex :=0;
  frmCidade1.cbbcombo.ItemIndex :=0;
  frmBairro1.cbbcombo.ItemIndex :=0;

  dxBtnSalvar.Enabled      :=True;
  dxBtnEditar.Enabled      :=False;
  pIdModel :='';
  pIdEndereco :='';
  pIdContato :='';
  cxbrdtmPesquisa.Enabled :=False;
  rdStatus.ItemIndex :=0;




end;

procedure TfrmManterFuncionario.dxBtnSalvarClick(Sender: TObject);
var
 conta :TContaContabilModel;
 pDescricao, pTipo :string;
 pCodigo  :Integer;
 model  : TFuncionarioModel;
 endereco : TEnderecoModel;
 contato  : TContatoModel;
 sucesso : Boolean;
begin
  sucesso := False;

  dxBtnNovo.Enabled := False;
  dxBtnEditar.Enabled := False;
  dxBtnDeletar.Enabled := False;
  dmConexao.conectarBanco;

  model := TFuncionarioModel.Create;
  model.FIDorganizacao := pIdOrganizacao;

  if not uutil.Empty(pIdModel) then
  begin
    model.Fnovo := False;
  end
  else
  begin
    pIdModel := dmConexao.obterNewID;
  end;

  model.FID := pIdModel;

 try
  //SALVADR ENDERECO
    if isValidForm then
    begin
      endereco                 := TEnderecoModel.Create;
      if not uutil.Empty(pIdEndereco)  then begin
        endereco.Fnovo := False;
      end else begin pIdEndereco := dmConexao.obterNewID; end;

      if not uutil.Empty(edtLogradouro.Text) then
      begin
        endereco.FID := pIdEndereco;
        endereco.FIDorganizacao := pIdOrganizacao;
        endereco.FLOGRADOURO := UpperCase(edtLogradouro.Text);
        endereco.FIDCIDADE := pIdCidade;
        endereco.FCEP := edtCEP.Text;
        endereco.FNUMERO := edtNumero.Text;
        endereco.FIDBAIRRO := pIdBairro;
        endereco.FIDESTADO := pIdEstado;
        endereco.FCOMPLEMENTO := UpperCase(edtComplemento.Text);

        if isValidAbaEndereco then
        begin
          if endereco.Fnovo then
          begin
            if TEnderecoDAO.Insert(endereco) then
            begin
              model.FIDEndereco := endereco.FID;
              model.Fendereco := endereco;
            end;
          end
          else
          begin
            if TEnderecoDAO.Update(endereco) then
            begin
              model.FIDEndereco := endereco.FID;
              model.Fendereco := endereco;
            end;
          end;

        end;

      end;



    // Salvar CONTATO
      contato                  := TContatoModel.Create;
      if not uutil.Empty(pIdContato)  then begin
        contato.Fnovo := False;
      end else begin pIdContato := dmConexao.obterNewID; end;

      contato.FID              := pIdContato;
      contato.FIDorganizacao   := pIdOrganizacao;
      contato.FEmail           := edtEmail.Text;
      contato.FCelular         := edtCelular.Text;
      contato.FTelefone        := edtTelFixo.Text;

      if isValidAbaContato then
      begin

        if contato.Fnovo then
        begin
          if TContatoDAO.Insert(contato) then
          begin
            model.FIDContato := contato.FID;
            model.Fcontato := contato;
          end;

        end
        else
        begin
          if TContatoDAO.Update(contato) then
          begin
            model.FIDContato := contato.FID;
            model.Fcontato := contato;
          end;

        end;
      end;

      model.Fativo := 1;
      if rdStatus.ItemIndex = 1 then model.Fativo := 1;
      model.FNOME := edtNome.Text;
      model.FCPF := edtCNPJCPF.Text;


      if model.Fnovo then begin
       sucesso :=  TFuncionarioDAO.Insert(model);
      end else begin sucesso := TFuncionarioDAO.Update(model); end;

      if sucesso then
      begin
        PempecMsg.MsgInformation('Funcionário : ' + model.FNOME + #13 + 'Salvo com sucesso.');
        limparPanel;
      end;

    end;

  except

    on e: Exception do
      PempecMsg.MsgError(e.Message + sLineBreak + ' Não foi possível salvar o funcionário.');

  end;


end;


procedure TfrmManterFuncionario.edtCelularExit(Sender: TObject);
begin
edtCelular.Text := uutil.FormatarTelefone (edtCelular.Text);
end;

procedure TfrmManterFuncionario.edtCEPExit(Sender: TObject);
begin
  if not uUtil.Empty(edtCEP.Text) then begin
      edtCEP.Text := uUtil.TFormat.formataCEP(edtCEP.Text);
  end;
end;

procedure TfrmManterFuncionario.edtCNPJCPFExit(Sender: TObject);
begin
edtCNPJCPF.Text := uUtil.TFormat.formacpf(edtCNPJCPF.Text);
end;

procedure TfrmManterFuncionario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freeAndNilDM(Self);
 Action :=caFree;

end;

procedure TfrmManterFuncionario.FormCreate(Sender: TObject);
begin
 inicializarDM(Self);
 limparPanel;
end;

procedure TfrmManterFuncionario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case key of
  vk_f2: dxBtnEditar.Click;
  vk_f4: dxBtnNovo.Click;
  vk_f10: dxBtnSalvar.Click;
end;

end;

procedure TfrmManterFuncionario.freeAndNilDM(Sender: TObject);
begin

//nada
end;

procedure TfrmManterFuncionario.frmBairro1cbbcomboChange(Sender: TObject);
begin
 if frmBairro1.cbbcombo.ItemIndex >0 then begin
  pIdBairro := FsListaIdBairro[frmBairro1.cbbcombo.ItemIndex];
 end;
end;

procedure TfrmManterFuncionario.frmCidade1cbbcomboChange(Sender: TObject);
begin
  if frmCidade1.cbbcombo.ItemIndex > 0 then
  begin
    pIdCidade := FsListaIdCidade[frmCidade1.cbbcombo.ItemIndex];
    frmBairro1.obterTodosPorCidade(pIdCidade, frmBairro1.cbbcombo, FsListaIdBairro);
  end;

end;

procedure TfrmManterFuncionario.frmContaContabil1cbbContaContabilChange(
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

procedure TfrmManterFuncionario.frmEstado1cbbcomboChange(Sender: TObject);
begin
 pIdEstado := FsListaIdEstado[frmEstado1.cbbcombo.ItemIndex];
 frmCidade1.obterPorEstado(pIdEstado,frmCidade1.cbbcombo, FsListaIdCidade);

end;



procedure TfrmManterFuncionario.inicializarDM(Sender: TObject);
begin
 //nada
 if not Assigned(dmOrganizacao) then begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
 end;

 limparPanel;


end;

procedure TfrmManterFuncionario.limparPanel();
begin
  //por enquanto
   tbContaBancaria.Enabled := False;
   tbContaContabil.Enabled := False;

 uutil.LimpaTela(Self);
  limpaStatusBar;

 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdUsuario :=IntToStr(uutil.TUserAtual.getUserId);

 frmBanco1.obterTodosPorIndice(pIdOrganizacao, frmBanco1.cbbBanco, FslistaIdBanco);
 frmContaContabil1.obterTodos(pIdOrganizacao, frmContaContabil1.cbbContaContabil,FsListaIdContas);
 frmEstado1.obterTodos(frmEstado1.cbbcombo, FsListaIdEstado);

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
  frmContaContabil1.cbbContaContabil.ItemIndex :=0;

   cxpgcntrlPage.ActivePageIndex :=0;

//

 //botao editar muda
  dbgrd1.Enabled :=True;
  edtNome.Clear;

  limparAba(Self.tbFuncionario);
  limparAba(Self.tbEndereco);
  limparAba(Self.tbContato);
  limparAba(Self.tbContaBancaria);
  limparAba(Self.tbContaContabil);
  frmBanco1.cbbBanco.ItemIndex :=0;
  Self.dxRibbon1Tab1.Caption := 'Manutenção do cadastro de funcionários.';

end;

procedure TfrmManterFuncionario.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmManterFuncionario.preencheGrid(pIdOrganizacao: string);
var
 cmdSql :string;
begin

dmConexao.conectarBanco;
if uutil.Empty(pIdOrganizacao) then begin pIdOrganizacao := TOrgAtual.getId; end;

  try

        //qryPreencheGrid := TFDQuery.Create(Self);
        qryPreencheGrid.Close;
        //qryPreencheGrid.SQL.Clear;
       // qryPreencheGrid.SQL.Add(cmdSql);
        qryPreencheGrid.Connection := dmConexao.conn;
        qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryPreencheGrid.Open;


    (dbgrd1.DataSource.DataSet as TFDQuery).Last;
    (dbgrd1.DataSource.DataSet as TFDQuery).First;


   except

   raise Exception.Create('Erro preencher grid');

  end;


end;

function TfrmManterFuncionario.qtdUso(pIdOrganizacao, pIDModel: string): Integer;
  var
qryTP, qryTR : TFDQuery;
cmd : string;
qtd :Integer;

begin
  dmConexao.conectarBanco;
   qtd := 0;

  //funcionario.

  try

    cmd := ' SELECT  FIRST 1 TP.ID_TITULO_PAGAR  FROM TITULO_PAGAR TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_RESPONSAVEL = :PID) ';

    qryTP := TFDQuery.Create(Self);
    qryTP.Close;
    qryTP.Connection := dmConexao.conn;
    qryTP.SQL.Clear;
    qryTP.SQL.Add(cmd);
    qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTP.ParamByName('PID').AsString := pIDModel;
    qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

     if qtd < 1 then
    begin

      cmd := ' SELECT  FIRST 1 TP.ID_TITULO_RECEBER  FROM TITULO_RECEBER TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_RESPONSAVEL = :PID) ';

      qryTP := TFDQuery.Create(Self);
      qryTP.Close;
      qryTP.Connection := dmConexao.conn;
      qryTP.SQL.Clear;
      qryTP.SQL.Add(cmd);
      qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTP.ParamByName('PID').AsString := pIDModel;
      qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

    end;



     if qtd < 1 then
    begin

      cmd := ' SELECT FIRST 1 TP.ID_TESOURARIA_DEBITO FROM TESOURARIA_DEBITO TP '+
             ' WHERE  (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_RESPONSAVEL = :PID) ';

      qryTP := TFDQuery.Create(Self);
      qryTP.Close;
      qryTP.Connection := dmConexao.conn;
      qryTP.SQL.Clear;
      qryTP.SQL.Add(cmd);
      qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTP.ParamByName('PID').AsString := pIDModel;
      qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

    end;

     if qtd < 1 then
    begin

      cmd := ' SELECT FIRST 1 TP.ID_TESOURARIA_CREDITO FROM TESOURARIA_CREDITO TP '+
             ' WHERE  (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_RESPONSAVEL = :PID) ';

      qryTP := TFDQuery.Create(Self);
      qryTP.Close;
      qryTP.Connection := dmConexao.conn;
      qryTP.SQL.Clear;
      qryTP.SQL.Add(cmd);
      qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTP.ParamByName('PID').AsString := pIDModel;
      qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

    end;



  except
    raise Exception.Create('Erro ao buscar uso dos RESPONSÁVEIS ');

  end;

  Result := qtd;

end;

procedure TfrmManterFuncionario.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ';
end;

procedure TfrmManterFuncionario.tbFuncionarioShow(Sender: TObject);
begin
 dbgrd1.Visible :=True;
  msgStatusBar(1,' Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ');

end;

procedure TfrmManterFuncionario.tbContaBancariaShow(Sender: TObject);
begin
 dbgrd1.Visible :=False;
 msgStatusBar(1,'Dados da conta bancária');

end;

procedure TfrmManterFuncionario.tbContaContabilShow(Sender: TObject);
begin
  dbgrd1.Visible :=False;
   msgStatusBar(1,'Dados da conta contábil');
end;

procedure TfrmManterFuncionario.tbContatoShow(Sender: TObject);
begin
 dbgrd1.Visible :=False;
  msgStatusBar(1,'Contatos cadastrados');
end;

procedure TfrmManterFuncionario.tbEnderecoExit(Sender: TObject);
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

procedure TfrmManterFuncionario.tbEnderecoShow(Sender: TObject);
begin
 dbgrd1.Visible :=False;
  msgStatusBar(1,'Dados do endereço');
end;

procedure TfrmManterFuncionario.preecheGridBanco;
begin

 dmConexao.conectarBanco;
 try

   qryGridBanco.Close;
   qryGridBanco.Connection := dmConexao.conn;
   qryGridBanco.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   qryGridBanco.Open;

 except
 raise Exception.Create('Erro ao obter lista de bancos');

 end;

end;

procedure TfrmManterFuncionario.preencheAbaContato(contato :TContatoModel);
begin
  if not uutil.Empty(contato.FID) then begin
     pIdContato :=  contato.FID;

    edtTelFixo.Text  := contato.FTelefone;
    edtCelular.Text  := contato.FCelular;
    edtEmail.Text    := contato.FEmail;

  end else begin

    limparAba(tbContato);

  end;



end;

procedure TfrmManterFuncionario.preencheAbaEndereco(endereco  : TEnderecoModel);
var
  I,J,F: Integer;
begin
  if not uutil.Empty(endereco.FID)  then begin

    pIdEndereco := endereco.FID;
    pIdEstado   := endereco.FIDESTADO;
    pIdCidade   := endereco.FIDCIDADE;
    pIdBairro   := endereco.FIDBAIRRO;

    edtCEP.Text         := endereco.FCEP;
    edtNumero.Text      := endereco.FNUMERO;
    edtLogradouro.Text  := endereco.FLOGRADOURO;
    edtComplemento.Text := endereco.FCOMPLEMENTO;


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

    limparAba(tbEndereco);
     frmEstado1.limpaFrame;

   // frmEstado1.cbbcombo.ItemIndex := 0;
    frmCidade1.cbbcombo.ItemIndex := 0;
    frmBairro1.cbbcombo.ItemIndex := 0;

  end;

end;

procedure TfrmManterFuncionario.limparAba(aba :TcxTabSheet );
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



 function TfrmManterFuncionario.isValidForm :Boolean;
var i:integer;
liberado : Boolean;

begin
 liberado :=false;
 msgStatusBar(1, 'Verifique os campos obrigatórios.');

      for i := 0 to Self.ComponentCount - 1 do
      begin

        if Self.components[i] is TEdit then
        begin
          if (Tedit(components[i]).tag = 1) and uutil.Empty((Tedit(components[i]).text)) then
          begin
                  liberado := false;
                  if Tedit(components[i]).Parent.ClassType = TcxTabSheet then
                  begin
                    TcxPageControl(TcxTabSheet(Tedit(components[i]).Parent).Parent).ActivePageIndex := TcxTabSheet(Tedit(components[i]).Parent).TabIndex;
                    TEdit(Components[i]).SetFocus;
                    Application.MessageBox('Alguns campos obrigatorios não foram preenchidos! ', 'Aviso', mb_iconinformation + mb_ok);
                    msgStatusBar(1, 'O responsável precisa ter endereço e contato. Verifique todas as abas');
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

function TfrmManterFuncionario.isValidAbaContato: Boolean;
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
function TfrmManterFuncionario.isValidAbaEndereco: Boolean;
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

end.

