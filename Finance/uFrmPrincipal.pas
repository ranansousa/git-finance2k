unit uFrmPrincipal;

interface

uses
  Winapi.Windows, uMD5, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics, uUtil, uVarGlobais, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Phys.ADSWrapper, FireDAC.UI.Intf, FireDAC.VCLUI.Error, FireDAC.VCLUI.Wait, FireDAC.Phys, FireDAC.stan.Def, Registry, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Comp.UI, FireDAC.stan.Intf, uFrmRegistraBaseDados, FireDAC.Phys.ADS, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, FireDAC.Phys.IBWrapper, Vcl.Samples.Gauges, Vcl.ComCtrls,
  Vcl.Samples.Spin, wininet, Winsock, IdSSL, IdSSLOpenSSL, IdMessage, Organizacao, IdAttachmentFile, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, uLogin, IdTCPConnection, IdSMTP, jpeg, IdBaseComponent, IdComponent, IdHTTP, FireDAC.stan.Option, FireDAC.stan.Error, FireDAC.Phys.Intf, FireDAC.stan.Pool, FireDAC.stan.Async, FireDAC.stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet, Vcl.Mask, VCLUnZip, VCLZip, FireDAC.Phys.FBDef,
  IdAntiFreezeBase, Vcl.IdAntiFreeze, frxClass, udmConexao, uDMOrganizacao, udmMegaContabil, uDMUsuarioConsulta, ACBrBase, uDmExportaFinance, uDMContasPagar, Vcl.Imaging.pngimage, Vcl.Grids, Vcl.DBGrids, frxDBSet, uFrmManutencao, Vcl.Menus, uFrmBackup, uFrmRegistro, uFrmServidorEmail, System.ImageList, Vcl.ImgList, uFrmImportacao, uFrmRelatorios, uFrmExportacao, uFrmSincronizaMega, uFrmTeste, uFrmUpdate, udmCombos, RxDBCtrl, frxCrypt, UMostraErros,uFrmAlteraTituloPagar,uFrmAlteraTituloReceber,
  uFrameBDTables, udmManutencao, uFrameOrganizacoes, uFrameEstado, uFrmDeletaLoteContabil,
  uFrameGeneric, uFrameCidade, uFrameEndereco, uFrameBairro, uDMServerMail,uFrmAlteraOrganizacao,uFrmSelecionaOrganizacao,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script;

type
  TFrmPrincipal = class(TForm)

    menuPrincipal: TMainMenu;
    Pagar1: TMenuItem;
    Receber1: TMenuItem;
    esouraria1: TMenuItem;
    Relatorios1: TMenuItem;
    Parametros1: TMenuItem;
    Utilitarios1: TMenuItem;
    Sobre1: TMenuItem;
    Backup1: TMenuItem;
    Registro1: TMenuItem;
    Info1: TMenuItem;
    Atualizar1: TMenuItem;
    ServidorEmail1: TMenuItem;
    IdAntiFreeze1: TIdAntiFreeze;
    Importao1: TMenuItem;
    menuitemRelFinancas: TMenuItem;
    menuItemManutencao: TMenuItem;
    stat1: TStatusBar;
    menuItemTPNovo: TMenuItem;
    menuItemSincMega: TMenuItem;
    lblPathSGBD: TLabel;
    edtLogin: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    edtPassword: TEdit;
    lbl3: TLabel;
    btnLogin: TBitBtn;
    cbxUsuario: TComboBox;
    btnZoom: TButton;
    menuItemTPAltDoc: TMenuItem;
    mniTRAltDoc: TMenuItem;
    img1: TImage;
    mmoMain: TMemo;
    pnlMain: TPanel;
    mniSair1: TMenuItem;
    mniExportar1: TMenuItem;
    mniMegaContabil: TMenuItem;
    mniDelExport: TMenuItem;

    procedure Backup1Click(Sender: TObject);
    procedure Registro1Click(Sender: TObject);
    procedure ServidorEmail1Click(Sender: TObject);
    procedure Importao1Click(Sender: TObject);
    procedure menuitemRelFinancasClick(Sender: TObject);
    procedure Exportao1Click(Sender: TObject);
    procedure btnTesteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Atualizar1Click(Sender: TObject);
    procedure acessoMenu(value: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure menuItemManutencaoClick(Sender: TObject);
    procedure menuItemTPNovoClick(Sender: TObject);
    procedure menuItemSincMegaClick(Sender: TObject);
    procedure cbxUsuarioChange(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure Zoom(Sender: TObject);
    procedure menuItemTPAltDocClick(Sender: TObject);
    procedure cbxUsuarioClick(Sender: TObject);
    procedure mniTRAltDocClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure alignPanelLogin(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mniMegaContabilClick(Sender: TObject);
    procedure mniDelExportClick(Sender: TObject);



  private
    { Private declarations }
    numberError: string;
    pid: string;
    BDConectado, userValidado: Boolean;
    FsListaIdOrganizacoes: TStringList;
    FsListaIdUsuarios: TStringList;
    FsListaIdEstados: TStringList;
    FsListaIdCidades: TStringList;
    FsListaIdBairros: TStringList;

    ajustaFormLigado : Boolean;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure AjustaForm;
    procedure serverMail(pIdOrganizacao :string);
    procedure preenchePanelMain;
  public
    { Public declarations }
    orgAtual: TOrganizacao;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses
  uDMRelatorioExportacaoMega, uFrmContasPagar;

procedure TFrmPrincipal.Backup1Click(Sender: TObject);
begin
  try
    frmBackup := TFrmBackup.Create(Self);
    frmBackup.ShowModal;
    FreeAndNil(frmBackup);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;

procedure TFrmPrincipal.acessoMenu(value: Boolean);
var
  poItem: TMenuItem;
begin
  begin
    for poItem in menuPrincipal.Items do
    begin
      poItem.Enabled := value;
    end;
  end;

end;


procedure TFrmPrincipal.btn1Click(Sender: TObject);
begin

//frmEnd1.frmCidade1.createComboAll('CIDADE','CIDADE','CIDADE', frmEnd1.frmCidade1.cbbcombo , FsListaIdCidades );

end;

procedure TFrmPrincipal.btnLoginClick(Sender: TObject);
var
  loMostraErros: TFMostraErros;
begin
    userValidado := False;

  if dmUsuarioConsulta.validarLogin(StrToInt(pid), edtLogin.Text, edtPassword.Text) then
  begin

     try

        frmSelectOrganizacao := TfrmSelectOrganizacao.Create(Self);
        frmSelectOrganizacao.ShowModal;
        FreeAndNil(frmSelectOrganizacao);

    except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
    end;


    dmOrganizacao.obterDataServidor;  // seta a data atual originada do server de banco de dados

    edtLogin.Enabled := False;
    edtPassword.Enabled := False;
    edtLogin.Text := '';
    edtPassword.Text := '';

   { lblBoasVindas.Visible := True;
    lblBoasVindas.Caption := 'Seja bem vindo(a). Selecione uma organização para trabalhar.';
    cbxOrganizacoes.Visible := True;
    cbxOrganizacoes.Enabled := True;    }
      //cbxOrganizacoes.Focused := True;
//    lblSelectOrg.Visible := True; //  lblSelectOrg.Caption := 'Selecione uma organização.';

      //setando os dados para envio de email
        serverMail(uUtil.TOrgAtual.getId);

        //esconde o login
              pnlMain.Visible := true;
              img1.Visible := False;
              lbl1.Visible := False;
              lbl2.Visible := False;
              lbl3.Visible := False;

              preenchePanelMain;



    pnlMain.Align := alClient;
  end
  else
  begin
   // cbxOrganizacoes.Enabled := False;
    //lblSelectOrg.Visible := False;
   // lblBoasVindas.Visible := False;
    edtPassword.Text := '';
    ShowMessage('Login/Senha incorretos.');
  end;

end;


procedure TFrmPrincipal.btnTesteClick(Sender: TObject);
begin
  numberError := '1031';
  try

    if not (uUtil.TOrgAtual.getId = '') then
    begin
      frmTeste := TfrmTeste.Create(Self);
      frmTeste.ShowModal;
      FreeAndNil(frmTeste);
    end
    else
    begin
      acessoMenu(false);
      MessageDlg('Impossível apresentar dados da Organização...', mtWarning, [mbOK], 0);

    end;

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.Zoom(Sender: TObject);
begin
  if not ajustaFormLigado then
  begin
    ajustaFormLigado := True;
    AjustaForm;
    btnZoom.Caption := 'Ligado';
  end
  else
  begin
    ajustaFormLigado := False;
     AjustaForm;
    btnZoom.Caption := 'Desligado';
  end;
end;


procedure TFrmPrincipal.cbxUsuarioChange(Sender: TObject);
var
  cnpj: string;
  indice: Integer;
begin
    //desenvolver
  acessoMenu(false);
  uUtil.TUserAtual.setId('');
  userValidado := False;
  btnLogin.Enabled := False;

  if (cbxUsuario.ItemIndex > (-1)) then
  begin
    //obter usuario selecionado
    indice := (cbxUsuario.ItemIndex);
    pid := FsListaIdUsuarios[indice];

    if not (indice = 0 ) then begin

     dmUsuarioConsulta.obterUsuarioPorID(StrToInt(pid));
     //libera os botoes de login e senha
      edtLogin.Enabled := True;
      edtPassword.Enabled := True;
      btnLogin.Enabled := True;

    end
    else
    begin
      ShowMessage('Usuário não localizado... Selecione um usuário...');
    end;

  end;

end;

procedure TFrmPrincipal.cbxUsuarioClick(Sender: TObject);
begin
if( cbxUsuario.ItemIndex < 0) then begin

   ShowMessage('Seleção inválida!!!!');
end;
end;

procedure TFrmPrincipal.Exportao1Click(Sender: TObject);
begin
  numberError := '1032';
  try
    frmExportacao := TfrmExportacao.Create(Self);
    frmExportacao.ShowModal;
    FreeAndNil(frmExportacao);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;
end;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//freeAndNilDM(Self);
//Action := Cafree;
//lblPathSGBD.Caption := '';
  uUtil.LimpaTela(Self);

end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var
alignTop :Integer;
begin
  uUtil.LimpaTela(Self);
  stat1.Panels[0].Text := 'Versão: ' + GetVersionInfo(Application.ExeName);
  ajustaFormLigado :=False;
  inicializarDM(Self);
//  acessoMenu(false);
  edtLogin.Enabled := False;
  edtPassword.Enabled := False;
  lblPathSGBD.Caption := '';
  lbl2.Caption := 'Usuário';
  lbl1.Caption := 'Login';
  lbl3.Caption := 'Senha';
  acessoMenu(false);
  btnZoom.Visible := False;
  pnlMain.Visible := false;
  alignPanelLogin(Self);



  if dmConexao.obterHostONLINE then
  begin
       mmoMain.Clear;
    if not dmConexao.qryEstacoesConectadas.Eof then
    begin

//     mmoMain.Text :=  dmConexao.qryEstacoesConectadas.FieldByName('PROTOCOLO').AsString;
//     mmoMain.Text :=  dmConexao.qryEstacoesConectadas.FieldByName('ENDERECO').AsString;
//     mmoMain.Text := ' LISTA ESTAÇÔES CONECTADAS AO BANCO DE DADOS  ';
     mmoMain.Lines.Add(IntToStr(dmConexao.qryEstacoesConectadas.RecordCount));
     mmoMain.Lines.Add('ESTACÃO CONECTADA   >>> ' + dmConexao.qryEstacoesConectadas.FieldByName('ENDERECO').AsString);
     Application.ProcessMessages;

    end;

  end;


//  frmEstado1.createComboAll('ESTADO','DESCRICAO',frmEstado1.cbbcombo, FsListaIdEstados);

end;

procedure TFrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F10 then begin
  if not (Assigned(frmRegistraBaseDados)) then
         begin
             frmRegistraBaseDados := TfrmRegistraBaseDados.Create(Self);
             frmRegistraBaseDados.ShowModal;
             FreeAndNil(frmRegistraBaseDados);
          end;
  end;

  if Key = VK_F5 then begin
     try

        frmSelectOrganizacao := TfrmSelectOrganizacao.Create(Self);
        frmSelectOrganizacao.ShowModal;
        FreeAndNil(frmSelectOrganizacao);

        preenchePanelMain;

    except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
    end;

  end;



end;

procedure TFrmPrincipal.Importao1Click(Sender: TObject);
begin
  numberError := '1033';
  try
    frmImportar := TfrmImportar.Create(Self);
    frmImportar.ShowModal;
    FreeAndNil(frmImportar);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;
end;

procedure TFrmPrincipal.menuItemManutencaoClick(Sender: TObject);
begin
  numberError := '1038';

  try
    frmManutencao := TfrmManutencao.Create(Self);
    frmManutencao.ShowModal;
    FreeAndNil(frmManutencao);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.menuitemRelFinancasClick(Sender: TObject);
begin
  numberError := '1034';
  try
    frmRelatorios := TfrmRelatorios.Create(Self);
    frmRelatorios.ShowModal;
    FreeAndNil(frmRelatorios);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;

procedure TFrmPrincipal.menuItemSincMegaClick(Sender: TObject);
begin
  numberError := '1050';
  try
    frmSincronizaMega := TfrmSincronizaMega.Create(self);
    frmSincronizaMega.ShowModal;
    FreeAndNil(frmSincronizaMega);
  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;
end;

procedure TFrmPrincipal.menuItemTPNovoClick(Sender: TObject);
begin
  numberError := '1040';

  frmContasPagar := TfrmContasPagar.Create(Self);
  frmContasPagar.ShowModal;
  FreeAndNil(frmContasPagar);

end;

procedure TFrmPrincipal.Registro1Click(Sender: TObject);
begin
  numberError := '1035';
  try
    frmRegistro := TfrmRegistro.Create(Self);
    frmRegistro.ShowModal;
    FreeAndNil(frmRegistro);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.serverMail(pIdOrganizacao: string);
var
conta, senha, host, porta, autentica :string;

begin
// Added by adm 23/09/2019 11:51:54
    dmServerMail.obterDadosServidorEmail(pIdOrganizacao);

    if not dmServerMail.qryObterDadosMail.IsEmpty then begin

      conta     := dmServerMail.qryObterDadosMail.FieldByName('LOGIN').AsString;
      senha     := dmServerMail.qryObterDadosMail.FieldByName('SENHA').AsString;
      host      := dmServerMail.qryObterDadosMail.FieldByName('HOST').AsString;
      porta     := dmServerMail.qryObterDadosMail.FieldByName('PORTA').AsString;
      autentica := IntToStr(dmServerMail.qryObterDadosMail.FieldByName('REQUER_AUTENTICACAO').AsInteger);

      // inicializa as variaveis do host do email a ser enviado.
         uVarGlobais.IniHostEmail(conta, senha, host, porta, autentica);

    end;

end;

procedure TFrmPrincipal.ServidorEmail1Click(Sender: TObject);
begin
  numberError := '1036';
  try
    frmServidorEmail := TfrmServidorEmail.Create(Self);
    frmServidorEmail.ShowModal;
    FreeAndNil(frmServidorEmail);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;


procedure TFrmPrincipal.Atualizar1Click(Sender: TObject);
begin
  numberError := '1037';
  try
    frmUpdate := TfrmUpdate.Create(Self);
    frmUpdate.ShowModal;
    FreeAndNil(frmUpdate);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;
end;

procedure TFrmPrincipal.inicializarDM(Sender: TObject);
begin

  if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
    BDConectado :=False;

    try
    BDConectado := dmConexao.conectarBanco;

    except
     on E: Exception do
      ShowMessage(' '+ e.Message);
     end;
  end;


   if not BDConectado then begin
      if not (Assigned(frmRegistraBaseDados)) then
         begin
             frmRegistraBaseDados := TfrmRegistraBaseDados.Create(Self);
             frmRegistraBaseDados.ShowModal;
             FreeAndNil(frmRegistraBaseDados);
         end;

   end;

   if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;
  if not (Assigned(dmManutencao)) then
  begin
    dmManutencao := TdmManutencao.Create(Self);
  end;

  if not (Assigned(dmCombos)) then
  begin
    dmCombos := TdmCombos.Create(Self);
  end;

  if not (Assigned(dmContasPagar)) then
  begin
    dmContasPagar := TdmContasPagar.Create(Self);
  end;

  if not (Assigned(dmUsuarioConsulta)) then
  begin
    dmUsuarioConsulta := TdmUsuarioConsulta.Create(Self);
  end;

  if not (Assigned(dmServerMail)) then
  begin
    dmServerMail := TdmServerMail.Create(Self);
  end;


  if BDConectado then
  begin

    if dmUsuarioConsulta.carregarUsuarios then
    begin
      dmCombos.listaUsuario(cbxUsuario, FsListaIdUsuarios);
    end;
  end ;




  //fim




end;



procedure TFrmPrincipal.freeAndNilDM(Sender: TObject);
begin

  if (Assigned(dmConexao)) then
  begin
    FreeAndNil(dmConexao);
  end;

  if (Assigned(dmContasPagar)) then
  begin
    FreeAndNil(dmContasPagar);
  end;

  if (Assigned(dmOrganizacao)) then
  begin
    FreeAndNil(dmOrganizacao);
  end;

  if (Assigned(dmUsuarioConsulta)) then
  begin
    FreeAndNil(dmUsuarioConsulta);
  end;

  if (Assigned(dmMegaContabil)) then
  begin
    FreeAndNil(dmMegaContabil);
  end;

  if (Assigned(dmExportaFinance)) then
  begin
    FreeAndNil(dmExportaFinance);
  end;

  if (Assigned(dmContasPagar)) then
  begin
    FreeAndNil(dmContasPagar);
  end;

  if (Assigned(frmTeste)) then
  begin
    FreeAndNil(frmTeste);
  end;

  if (Assigned(dmCombos)) then
  begin
    FreeAndNil(dmCombos);
  end;

end;


procedure TFrmPrincipal.AjustaForm;
Const
nTamOriginal = 1024; // Será o 100% da escala
Var
nEscala : Double; // Vai me dar o percentual de Transformação escalar
nPorcento : Integer; // Vai me dar em percentual inteiro o valor
begin
With FrmPrincipal do
begin
      if nTamOriginal <> Screen.Width then
      begin
        nEscala := ((Screen.Width-nTamOriginal)/nTamOriginal);
        nPorcento := Round((nEscala*100) + 100);
        Self.Width := Round(Self.Width * (nEscala+1));
        Self.Height := Round(Self.Height * (nEscala+1));
        Self.ScaleBy(nPorcento,100);
      end;
end;
end;

procedure TFrmPrincipal.alignPanelLogin(Sender: TObject);
var
alignTop :Integer;
begin
   alignTop         := Trunc((Self.Height - img1.Height)/2);
   btnZoom.Left     := Trunc(Self.Width/2);
   img1.Left        := Trunc((Self.Width - img1.Width)/2);
   img1.Top         := Trunc((Self.Height - img1.Height)/2);
   btnLogin.Top     := Trunc((alignTop + 65 ));

   lbl1.Left        := Trunc(img1.Left + 90);
   lbl2.Left        := Trunc(img1.Left + 90);
   lbl3.Left        := Trunc(img1.Left + 90);
   cbxUsuario.Left  := Trunc(lbl1.Left + lbl1.Width + 20);
   edtLogin.Left    := Trunc(lbl1.Left + lbl1.Width + 20);
   edtPassword.Left := Trunc(lbl1.Left + lbl1.Width + 20);
   btnLogin.Left    := Trunc(cbxUsuario.Left + (cbxUsuario.Width + 4) )   ;

   lbl2.Top         := Trunc((alignTop +  65 ));
   lbl1.Top         := Trunc((alignTop +  95 ));
   lbl3.Top         := Trunc((alignTop + 125 ));
   cbxUsuario.Top   := Trunc((alignTop +  65 ));
   edtLogin.Top     := lbl1.Top;
   edtPassword.Top  := lbl3.Top;


end;

procedure TFrmPrincipal.mniDelExportClick(Sender: TObject);
begin
  numberError := '1046';
  try
    frmDeletaLoteContabil := TfrmDeletaLoteContabil.Create(Self);
    frmDeletaLoteContabil.ShowModal;
    FreeAndNil(frmDeletaLoteContabil);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;
end;

procedure TFrmPrincipal.mniMegaContabilClick(Sender: TObject);
begin
  numberError := '1032';
  try
    frmExportacao := TfrmExportacao.Create(Self);
    frmExportacao.ShowModal;
    FreeAndNil(frmExportacao);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;
end;

procedure TFrmPrincipal.mniTRAltDocClick(Sender: TObject);
begin

numberError := 'ALT-TR-1044';
  try
    frmAlteraNumDocTR := TfrmAlteraNumDocTR.Create(Self);
    frmAlteraNumDocTR.ShowModal;
    FreeAndNil(frmAlteraNumDocTR);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.menuItemTPAltDocClick(Sender: TObject);
begin

numberError := 'ALT-TP-1045';
  try
    frmAlteraNumDocTP := TfrmAlteraNumDocTP.Create(Self);
    frmAlteraNumDocTP.ShowModal;
    FreeAndNil(frmAlteraNumDocTP);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.preenchePanelMain();
begin

//    lblPathSGBD.Caption := 'PATH BANCO ' + uUtil.TOrgAtual.getPathSGBD;
        stat1.Panels[1].Text := 'USER : > ' + TUserAtual.getNameUser;
        stat1.Panels[2].Text := ' ORG  : > ' + uUtil.TOrgAtual.getFantasia ;
        stat1.Panels[3].Text := 'DATA : > ' + FormatDateTime('dd/mm/yyyy', uUtil.getDataServer);
        stat1.Panels[4].Text := 'BANCO DE DADOS : > ' + uUtil.TOrgAtual.getPathSGBD ;
        stat1.Panels[5].Text := '';

        if not (uUtil.TOrgAtual.getSistemaContabil = '') then begin
            stat1.Panels[5].Text := 'SISTEMA CONTÁBIL : > ' + uUtil.TOrgAtual.getSistemaContabil;
        end;


        if not (uUtil.TOrgAtual.getId = '') then
        begin
          acessoMenu(true); // libera o menu principal
        end
        else
        begin
          acessoMenu(false);
          stat1.Panels[1].Text := '';
          stat1.Panels[2].Text := ' ';
          stat1.Panels[3].Text := 'DATA : > ' + FormatDateTime('dd/mm/yyyy', dmOrganizacao.obterDataServidor);
          stat1.Panels[5].Text := '';

        end;

end;


end.


