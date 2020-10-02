unit uFrmBackup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, MDModel, MDDAO, uOrganizacaoDAO, uOrganizacaoModel,
  System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, FireDAC.Phys.IBWrapper, IdHTTP, FireDAC.Phys.IBBase, Vcl.ExtCtrls,
  uUtil, uBrowseForFolderU, FireDAC.Comp.UI, FireDAC.Phys.FB, VCLUnZip, VCLZip,
  Vcl.StdCtrls, Vcl.Buttons, uVarGlobais, Vcl.Samples.Spin, udmConexao,
  Vcl.ComCtrls, IdSSLOpenSSL, EMsgDlg, FireDAC.Stan.Param, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxGraphics, cxControls, cxClasses,
  dxRibbon, dxBar, dxStatusBar, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinsDefaultPainters, dxRibbonSkins, dxRibbonCustomizationForm,
  FireDAC.Phys.FBDef, FireDAC.UI.Intf, FireDAC.VCLUI.Error, FireDAC.Stan.Error,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Def, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, FireDAC.Phys;

type
  TfrmBackup = class(TForm)
    edtOrigem: TLabeledEdit;
    edtDestino: TLabeledEdit;
    btnBackup: TButton;
    btnDestino: TBitBtn;
    btnOrigem: TBitBtn;
    btnSalvar: TBitBtn;
    chkFechaApp: TCheckBox;
    chkZipar: TCheckBox;
    chkEmail: TCheckBox;
    lblEmailOff: TLabel;
    AttachmentDialog: TOpenDialog;
    VCLZip1: TVCLZip;
    dlgOrigem: TOpenDialog;
    DrvLnk: TFDPhysFBDriverLink;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Timer1: TTimer;
    FinanceBackup: TFDIBBackup;
    IdHTTP1: TIdHTTP;
    Label1: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label2: TLabel;
    spinHora: TSpinEdit;
    spinMin: TSpinEdit;
    spinSeg: TSpinEdit;
    edtHrAgendada: TEdit;
    chkDesliga: TCheckBox;
    Label4: TLabel;
    edtHoraAtual: TEdit;
    btnAgendar: TButton;
    Label3: TLabel;
    ledAttachment: TLabeledEdit;
    btnAttachment: TBitBtn;
    btnRestore: TButton;
    Label5: TLabel;
    FinanceBackup2: TFDFBNBackup;
    FinanceRestore: TFDFBNRestore;
    PageControl1: TPageControl;
    tbsBackup: TTabSheet;
    tbsAgenda: TTabSheet;
    tbsRestore: TTabSheet;
    edtEnderecoEmail: TLabeledEdit;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    PempecMsg: TEvMsgDlg;
    qryServidorEmail: TFDQuery;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarBtnSair: TdxBarLargeButton;
    dxBarManager1Bar2: TdxBar;
    dxBarBtnBackup: TdxBarLargeButton;
    dxStatusBar: TdxStatusBar;
    procedure btnBackupClick(Sender: TObject);
    procedure btnOrigemClick(Sender: TObject);
    procedure btnDestinoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Limpatela(Sender: TObject);
    procedure btnAgendarClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnAttachmentClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure inicializarDM(Sender: TObject);
    procedure preencheDadosHost(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxBarBtnSairClick(Sender: TObject);
    procedure dxBarBtnBackupClick(Sender: TObject);

  private
    { Private declarations }
   msg, ipReal,Versao, Anexo: String;
    nomeFileBackup, path_backup, arquivoZip, arquivoBackup, arquivoFBK, hora,
      data, Path_Bd: String;
    destinoUm, conta, senha, host, porta, autentica: String;
    FsListaIdOrganizacoes: TStringList;
    procedure limpaStatusBar;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    class function registroMD(pAcao, pDsc, pStatus: string): Boolean; static;

  public
    { Public declarations }
  end;

var
  frmBackup: TfrmBackup;

implementation

{$R *.dfm}



procedure TfrmBackup.btnAgendarClick(Sender: TObject);
var
  hora, minuto: Integer;
begin
  hora := StrToInt(spinHora.Text);
  minuto := StrToInt(spinMin.Text);

  edtHrAgendada.Text := FormatDateTime('hh:MM:ss',
    EncodeTime(hora, minuto, 0, 0));

    GravarRegistros('Pempec Enterprise', 'Finance', 'AgendaBackup',
      edtHrAgendada.Text);

end;

procedure TfrmBackup.btnAttachmentClick(Sender: TObject);
begin
  Label3.Visible := True;
  msgStatusBar(1,'Pesquisando arquivo...');

  if AttachmentDialog.Execute then
  begin
    ledAttachment.Text := AttachmentDialog.FileName;
    Anexo := ledAttachment.Text;
  end;
  if Anexo <> '' then
  begin
    btnRestore.Enabled := True;
    btnBackup.Enabled := False;
    btnBackup.Visible := False;

  end;
end;

procedure TfrmBackup.btnBackupClick(Sender: TObject);
 var
  arqLastSize,arquivoSize,aux, I: Integer;
  lastSize,host, arq, msg, cap: String;
begin
  hora := FormatDateTime('hhmmss', Now());
  data := FormatDateTime('ddmmyyyy', Now());

// verifica se foi marcado para envio de email e se os dados para envio foram preenchidos.
  if chkEmail.Checked then
  begin
    if not(uVarGlobais.rHost.isEnable) then
    begin
      chkEmail.Checked := False;
      chkEmail.Enabled := False;
      lblEmailOff.Visible := True;
    end;

    //ERRO pq da tela n ter os dados. talvez pegar do registro
    destinoUm := LerRegistro('Pempec Enterprise', 'Host','destinoUm');
    destinoUm := edtEnderecoEmail.Text;

  end;
  Label1.Caption := 'Pempec Enterprise Backup ';


  if not DirectoryExists(edtDestino.Text) then
  begin
    msg := 'PASTA DESTINO NÃO EXISTE...';
    msgStatusBar(1,msg);

    if MessageDlg(PChar(' Deseja criar a pasta ' +
      uUtil.GetUserFromWindows + '?'),  mtWarning, mbOKCancel, 0) = mrOk then
//
    begin;
      if CreateDir(edtDestino.Text) then
      begin
        msg := 'PASTA CRIADA...';
        msgStatusBar(1,msg);
        btnSalvar.Click;
        dxBarBtnBackup.Click; // repete a operacao
      end;
    end
    else
    begin
       msg:= ('A aplicação será encerrada. Obrigado por utilizar nossos serviços...');
       PempecMsg.MsgWarning(msg);

      Application.Terminate;
      Close;
      Application.ProcessMessages;
    end;
  end
  else
  begin

    cap := Label1.Caption;
    btnBackup.Visible := False;
    Label1.Caption := '          OPERAÇÃO INICIADA';
    Application.ProcessMessages;

    try
      arquivoFBK := 'FIN_' + nomeFileBackup.ToUpper + data + hora;
      arquivoZip := edtDestino.Text + arquivoFBK + '.ZIP';
      arquivoBackup := edtDestino.Text + arquivoFBK + '.FBK';
      Path_Bd := edtOrigem.Text;

      dmConexao.conn.Connected := False;
      FinanceBackup.DriverLink := DrvLnk;
      FinanceBackup.UserName := 'SYSDBA';
      FinanceBackup.Password := 'masterkey';
      FinanceBackup.host := uutil.TOrgAtual.getFFIPSERVERBD;
      FinanceBackup.Protocol := ipTCPIP;
      FinanceBackup.Database := Path_Bd;
      FinanceBackup.BackupFiles.Clear; //cld 0807
      FinanceBackup.BackupFiles.Add(arquivoBackup);

      Application.ProcessMessages;
      Sleep(5000);
      FinanceBackup.Backup;

      //outro componente

     {
      FinanceBackup2.DriverLink := DrvLnk;
      FinanceBackup2.UserName := 'SYSDBA';
      FinanceBackup2.Password := 'masterkey';
      FinanceBackup2.host := '192.168.15.200' ; // util.TOrgAtual.getFFIPSERVERBD;
      FinanceBackup2.Protocol := ipTCPIP;
      FinanceBackup2.Database := Path_Bd;
      FinanceBackup2.BackupFile := arquivoBackup;
      FinanceBackup2.Level := 0;
    //  FinanceBackup2.Backup;  }



     arquivoBackup.ToUpper;

      sleep(10);

      msg := 'Operação Concluída com sucesso...' +' Tamanho do arquivo : ' + IntToStr(arquivoSize) ;
      msgStatusBar(1,msg);
      sleep(10);
      Label1.Caption := cap;
      btnBackup.Visible := False;
     // btnBackup.Enabled := True;
      sleep(10);
      Label1.Caption := cap;

      arq := GeraNameFileJPG();
      CapturaTelaForm(Self, arq);

      if uVarGlobais.rHost.isEnable then
      // verifrica se o sistema pode enviar email
      begin
         msg := 'BCKP SUCESS' + sLineBreak + 'FILE :   ' + arquivoBackup + #13 +
          DateTimeToStr(Now) + #13 + 'IP > ' + ipReal ;
      //  EnviarEmailGen(Self.GetNamePath, msg, 'Formulario Backup',
        //  destinoUm, '', arq);

        Application.ProcessMessages;
      end;

      if chkZipar.Checked then
      begin
        With VCLZip1 do
        begin

          msg := 'Pempec Enterprise Backup  -  Compactando arquivo(s). Aguarde...';
          msgStatusBar(1,msg);
          sleep(20);
          Label1.Caption := ' Arquivo Compactado : ' + arquivoZip;
          Application.ProcessMessages;
          sleep(50);
          Label1.Caption := cap;

          ZipName := arquivoZip;
          FilesList.Add(arquivoBackup);
          Recurse := True; // * Recurse directories */
          StorePaths := True; // * Keep path information */
          PackLevel := 9; // * Highest level of compression */
          Zip;
          // * Return value of Zip is the actual number of files zipped */
          sleep(20);
          msg := 'Pempec Enterprise Backup  - Compactado com Sucesso! ';
          msgStatusBar(1,msg);
          Application.ProcessMessages;
        end;
      end;

      if chkEmail.Checked then
      begin

        msg := 'Pempec Enterprise Backup  -  Enviando Email. Aguarde...';
        msgStatusBar(1,msg);
        sleep(50);
        Application.ProcessMessages;

        if chkZipar.Checked then
        begin
          if uVarGlobais.rHost.isEnable then
          begin
            msg := 'BACKUP FNC2K  ' + #13 + 'ANEXO :   ' + arquivoZip + #13 +
              DateTimeToStr(Now);;
            EnviarEmailGen(Self.GetNamePath, msg, 'Backup comprimido', destinoUm, '', arquivoZip);

           //  uutil.EnviarEmail('Backup COMP',destinoUm,arquivoZip,msg );

             msg := #13 + DateTimeToStr(Now);
          end;
        //   EnviarEmailGen(Self.GetNamePath, msg, 'Email Enviado...',  destinoUm, '', '');
        end
        else
        begin
          if (
            MessageDlg(PChar('O arquivo não está comprimido!' + #13 +
            #13 + #13 + 'O envio será muito demorado. ' + #13 + #13 + #13 + #13
            + 'Tem certeza que deseja continuar Sr(a) ' +
            uUtil.GetUserFromWindows + ' ?'),  mtWarning, mbOKCancel, 0) = mrOk
          ) then
//          if EvMsgDlg1.MsgConfirmation('O arquivo não está comprimido!' + #13 +
//            #13 + #13 + 'O envio será muito demorado. ' + #13 + #13 + #13 + #13
//            + 'Tem certeza que deseja continuar Sr(a) ' +
//            uUtil.GetUserFromWindows + ' ?') = 6 then
          begin;
            msg := 'FBK FILE ' + #13 + 'FILE :   ' + arquivoBackup + #13 +
              DateTimeToStr(Now);
            if uVarGlobais.rHost.isEnable then
            begin
              EnviarEmailGen(Self.GetNamePath, msg, 'Backup FBK', destinoUm, '', arquivoBackup);
             // uutil.EnviarEmail('Backup COMP',destinoUm,arquivoBackup,msg );
            end;

          end;
        end;

        msg := 'Pempec Enterprise Backup ';
        msgStatusBar(1,msg);
        Application.ProcessMessages;
        sleep(50);
      Label1.Caption := cap;

      end;

    except
      on E: EIBNativeException do
      begin
        MessageDlg('Erro no Backup do Banco.' + 'Operação  não concluída.' + #13
          + 'Possivelmente o Banco de Dados ainda está em uso.  ' + e.Message, mtInformation,
          [mbOK], 0);

        msg := 'Erro no Backup do Banco.' +
          'Operação  não concluída.' + #13 +
          'Possivelmente o Banco de Dados ainda está em uso.';
      msgStatusBar(1,msg);
        btnBackup.Visible := False;
        Label1.Caption := cap;
        //btnBackup.Enabled := True;

        msg := 'BCKP ERRO' + #13 + 'FILE :   ' + arquivoBackup + #13 + E.Message
          + #13 + DateTimeToStr(Now);
        if uVarGlobais.rHost.isEnable then
        begin
         // EnviarEmailGen(Self.GetNamePath, msg, 'Formulario Backup',
           // destinoUm, '', arq);
        end;
      end;

      on E: Exception do
      begin
        MessageDlg('Um erro inesperado ocorreu.' + 'Backup não realizado.' + #13
          + E.Message, mtWarning, [mbOK], 0);
        msg := 'BCKP ERRO' + #13 + 'FILE :   ' + arquivoBackup + #13 + E.Message
          + #13 + DateTimeToStr(Now);
        if uVarGlobais.rHost.isEnable then
        begin
         // EnviarEmailGen(Self.GetNamePath, msg, 'Formulario Backup',
            //destinoUm, '', arq);
        end;

      end;

    end;

  end;

  if chkFechaApp.Checked then
  begin
    msg :=   'Pempec Enterprise Backup  - Operação concluída. Aguarde a tela fechar... ';
    msgStatusBar(1,msg);

    Application.ProcessMessages;
     sleep(10000);
     Label1.Caption := cap;
//    Application.Terminate;
    Self.Close;
  end;


  dmConexao.conectarBanco;
  limpaStatusBar;

end;


procedure TfrmBackup.btnDestinoClick(Sender: TObject);

var
  caminho: String;
begin

  caminho := BrowseForFolder(' Pastas ', 'C:\', False);
  // dlgDestino.FileName;
  edtDestino.Text := caminho + '\';
  path_backup := edtDestino.Text;

end;


procedure TfrmBackup.btnOrigemClick(Sender: TObject);
begin
if dlgOrigem.Execute then
  begin
    edtOrigem.Text := dlgOrigem.FileName;
  end;
end;

procedure TfrmBackup.btnRestoreClick(Sender: TObject);
begin


    registroMD('RESTORE BD', 'BD RESTAURADO','SUCESS');

    freeAndNilDM(Self);

  try
    msg := 'Operação iniciada...';
    msgStatusBar(1,msg);

    FinanceRestore.DriverLink := DrvLnk;
    FinanceRestore.UserName := 'sysdba';
    FinanceRestore.Password := 'masterkey';
    FinanceRestore.host := LerRegistro('Pempec Enterprise', 'Finance',
      'IPSERVERBD');
    FinanceRestore.Protocol := ipTCPIP;

    FinanceRestore.Database := LerRegistro('Pempec Enterprise', 'Finance',
      'PATH_BD');

    FinanceRestore.BackupFiles.Clear;
    FinanceRestore.BackupFiles.Add(Anexo);

    if (MessageDlg('Esta operação é irreversível. ' + #13 +
      ' Tem certeza que deseja continuar ?', mtConfirmation, mbYesNo, 0) = mrYes)
    then
    begin;

      FinanceRestore.Restore;

      msg := 'Operação concluída com sucesso...';
      msgStatusBar(1,msg);
      btnBackup.Visible := False;
     // btnBackup.Enabled := True;
      btnRestore.Enabled := False;
      ledAttachment.Text := '';
      Application.ProcessMessages;
    end;



  except
    on E: EIBNativeException do
      // raise EIBNativeException.Create('Erro ao restaurar o Banco.'+#13 +'Possivelmente o  Banco de Dados ainda está em uso.');
      PempecMsg.MsgError('Erro ao restaurar o Banco.' + #13 +
        'Possivelmente o  Banco de Dados ainda está em uso.' + #13 +
        'Será necessário parar o serviço do Banco de Dados.');

    on E: Exception do
      PempecMsg.MsgError('Um erro inesperado ocorreu.');
  end;





end;

procedure TfrmBackup.btnSalvarClick(Sender: TObject);
begin
if edtOrigem.Text <> '' then
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_BD', edtOrigem.Text);
  end;

  if edtDestino.Text <> '' then
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_BD_BKP',
      edtDestino.Text);
  end;
end;

procedure TfrmBackup.dxBarBtnBackupClick(Sender: TObject);
var
  arqLastSize,arquivoSize,aux, I: Integer;
  lastSize,host, arq, msg, cap: String;
begin
// verifica se foi marcado para envio de email e se os dados para envio foram preenchidos.
  hora := FormatDateTime('hhmmss', Now());
  data := FormatDateTime('ddmmyyyy', Now());

  if chkEmail.Checked then
  begin
    if not(uVarGlobais.rHost.isEnable) then
    begin
      chkEmail.Checked := False;
      chkEmail.Enabled := False;
      lblEmailOff.Visible := True;
    end;

    //ERRO pq da tela n ter os dados. talvez pegar do registro
    destinoUm := LerRegistro('Pempec Enterprise', 'Host','destinoUm');
    destinoUm := edtEnderecoEmail.Text;

  end;
  Label1.Caption := 'Pempec Enterprise Backup ';
  msg:= ' ATENÇÃO:  ';
    msgStatusBar(1,msg);

  if not DirectoryExists(edtDestino.Text) then
  begin
    msg := 'PASTA DESTINO NÃO EXISTE...';

    if MessageDlg(PChar(' Deseja criar a pasta ' +
      uUtil.GetUserFromWindows + '?'),  mtWarning, mbOKCancel, 0) = mrOk then
//
    begin;
      if CreateDir(edtDestino.Text) then
      begin
        msg := 'PASTA CRIADA...';
        btnSalvar.Click;
        dxBarBtnBackup.Click; // repete a operacao
      end;
    end
    else
    begin
       msg:= ('A aplicação será encerrada. Obrigado por utilizar nossos serviços...');
       PempecMsg.MsgWarning(msg);

      Application.Terminate;
      Close;
      Application.ProcessMessages;
    end;
  end
  else
  begin

    cap := Label1.Caption;
    btnBackup.Visible := False;
    msgStatusBar(1,'          OPERAÇÃO INICIADA');
    Application.ProcessMessages;

    try
      arquivoFBK := 'FIN_' + nomeFileBackup.ToUpper + data + hora;
      arquivoZip := edtDestino.Text + arquivoFBK + '.ZIP';
      arquivoBackup := edtDestino.Text + arquivoFBK + '.FBK';
      Path_Bd := edtOrigem.Text;

      dmConexao.conn.Connected := False;
      FinanceBackup.DriverLink := DrvLnk;
      FinanceBackup.UserName := 'SYSDBA';
      FinanceBackup.Password := 'masterkey';
      FinanceBackup.host := uutil.TOrgAtual.getFFIPSERVERBD;
      FinanceBackup.Protocol := ipTCPIP;
      FinanceBackup.Database := Path_Bd;
      FinanceBackup.BackupFiles.Clear; //cld 0807
      FinanceBackup.BackupFiles.Add(arquivoBackup);

      Application.ProcessMessages;
      Sleep(5000);
      FinanceBackup.Backup;

      //outro componente

     {
      FinanceBackup2.DriverLink := DrvLnk;
      FinanceBackup2.UserName := 'SYSDBA';
      FinanceBackup2.Password := 'masterkey';
      FinanceBackup2.host := '192.168.15.200' ; // util.TOrgAtual.getFFIPSERVERBD;
      FinanceBackup2.Protocol := ipTCPIP;
      FinanceBackup2.Database := Path_Bd;
      FinanceBackup2.BackupFile := arquivoBackup;
      FinanceBackup2.Level := 0;
    //  FinanceBackup2.Backup;  }



     arquivoBackup.ToUpper;

      sleep(10);

      msg := 'Operação Concluída com sucesso...' +' Tamanho do arquivo : ' + IntToStr(arquivoSize) ;
      msgStatusBar(1,msg);
      sleep(10);
      Label1.Caption := cap;
      btnBackup.Visible := False;
     // btnBackup.Enabled := True;
      sleep(10);
      Label1.Caption := cap;

      arq := GeraNameFileJPG();
      CapturaTelaForm(Self, arq);

      if uVarGlobais.rHost.isEnable then
      // verifrica se o sistema pode enviar email
      begin
         msg := 'BCKP SUCESS' + sLineBreak + 'FILE :   ' + arquivoBackup + #13 +
          DateTimeToStr(Now) + #13 + 'IP > ' + ipReal ;
      //  EnviarEmailGen(Self.GetNamePath, msg, 'Formulario Backup',
        //  destinoUm, '', arq);

        Application.ProcessMessages;
      end;

      if chkZipar.Checked then
      begin
        With VCLZip1 do
        begin

          msg := 'Pempec Enterprise Backup  -  Compactando arquivo(s). Aguarde...';
          msgStatusBar(1,msg);
          sleep(20);
          Label1.Caption := ' Arquivo Compactado : ' + arquivoZip;
          Application.ProcessMessages;
          sleep(50);
          Label1.Caption := cap;

          ZipName := arquivoZip;
          FilesList.Add(arquivoBackup);
          Recurse := True; // * Recurse directories */
          StorePaths := True; // * Keep path information */
          PackLevel := 9; // * Highest level of compression */
          Zip;
          // * Return value of Zip is the actual number of files zipped */
          sleep(20);
          msg := 'Pempec Enterprise Backup  - Compactado com Sucesso! ';
          msgStatusBar(1, msg);

          Application.ProcessMessages;
        end;
      end;

      if chkEmail.Checked then
      begin

        msg :='Pempec Enterprise Backup  -  Enviando Email. Aguarde...';
        msgStatusBar(1,msg);
        sleep(50);
        Application.ProcessMessages;

        if chkZipar.Checked then
        begin
          if uVarGlobais.rHost.isEnable then
          begin
            msg := 'ZIP FILE ' + #13 + 'ANEXO :   ' + arquivoZip + #13 +
              DateTimeToStr(Now);;
            EnviarEmailGen(Self.GetNamePath, msg, 'Backup comprimido', destinoUm, '', arquivoZip);

           //  uutil.EnviarEmail('Backup COMP',destinoUm,arquivoZip,msg );

             msg := #13 + DateTimeToStr(Now);
          end;
        //   EnviarEmailGen(Self.GetNamePath, msg, 'Email Enviado...',  destinoUm, '', '');
        end
        else
        begin
          if (
            MessageDlg(PChar('O arquivo não está comprimido!' + #13 +
            #13 + #13 + 'O envio será muito demorado. ' + #13 + #13 + #13 + #13
            + 'Tem certeza que deseja continuar Sr(a) ' +
            uUtil.GetUserFromWindows + ' ?'),  mtWarning, mbOKCancel, 0) = mrOk
          ) then
//          if EvMsgDlg1.MsgConfirmation('O arquivo não está comprimido!' + #13 +
//            #13 + #13 + 'O envio será muito demorado. ' + #13 + #13 + #13 + #13
//            + 'Tem certeza que deseja continuar Sr(a) ' +
//            uUtil.GetUserFromWindows + ' ?') = 6 then
          begin;
            msg := 'FBK FILE ' + #13 + 'FILE :   ' + arquivoBackup + #13 +
              DateTimeToStr(Now);
            if uVarGlobais.rHost.isEnable then
            begin
              EnviarEmailGen(Self.GetNamePath, msg, 'Backup FBK', destinoUm, '', arquivoBackup);
             // uutil.EnviarEmail('Backup COMP',destinoUm,arquivoBackup,msg );
            end;

          end;
        end;

        limpaStatusBar;
        Application.ProcessMessages;
        sleep(50);
      Label1.Caption := cap;

      end;

    except
      on E: EIBNativeException do
      begin
       PempecMsg.MsgInformation('Erro no Backup do Banco.' + 'Operação  não concluída.' + #13
          + 'Possivelmente o Banco de Dados ainda está em uso.  ' + e.Message );

         msg := 'Operação  não concluída.' + #13 +
          'Possivelmente o Banco de Dados ainda está em uso.';
         msgStatusBar(1,msg);
        btnBackup.Visible := False;
        Label1.Caption := cap;
       // btnBackup.Enabled := True;

        msg := 'BCKP ERRO' + #13 + 'FILE :   ' + arquivoBackup + #13 + E.Message
          + #13 + DateTimeToStr(Now);
        if uVarGlobais.rHost.isEnable then
        begin
         // EnviarEmailGen(Self.GetNamePath, msg, 'Formulario Backup',
           // destinoUm, '', arq);
        end;
      end;

      on E: Exception do
      begin
        MessageDlg('Um erro inesperado ocorreu.' + 'Backup não realizado.' + #13
          + E.Message, mtWarning, [mbOK], 0);
        msg := 'BCKP ERRO' + #13 + 'FILE :   ' + arquivoBackup + #13 + E.Message
          + #13 + DateTimeToStr(Now);
        if uVarGlobais.rHost.isEnable then
        begin
         // EnviarEmailGen(Self.GetNamePath, msg, 'Formulario Backup',
            //destinoUm, '', arq);
        end;

      end;

    end;

  end;

  if chkFechaApp.Checked then
  begin
  msg:= ('Pempec Enterprise Backup  - Operação concluída. Aguarde a tela fechar... ');

   msgStatusBar(1,msg);
   Label1.Caption := cap;
   PempecMsg.MsgWarning(msg);
  //  Application.Terminate;
    Self.Close;
  end;


  dmConexao.conectarBanco;
  limpaStatusBar;

end;

procedure TfrmBackup.dxBarBtnSairClick(Sender: TObject);
begin

  PostMessage(Self.Handle, WM_CLOSE, 0, 0);

end;

procedure TfrmBackup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
end;

procedure TfrmBackup.FormCreate(Sender: TObject);
begin
 Limpatela(Self);

  preencheDadosHost(Self);

  Versao := 'V. 2.0 - 1609';
  Path_Bd := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD');
  edtOrigem.Text := Path_Bd;
  hora := FormatDateTime('hhmmss', Now());
  data := FormatDateTime('ddmmyyyy', Now());
  nomeFileBackup := LerRegistro('Pempec Enterprise', 'Finance',  'ID_ORGANIZACAO');

  if (nomeFileBackup = String.Empty) then
  begin
    nomeFileBackup := 'BKP_';
  end
  else
  begin
    nomeFileBackup := nomeFileBackup + '_';
  end;

  path_backup := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD_BKP');
  edtEnderecoEmail.Text := LerRegistro('Pempec Enterprise', 'Host', 'destinoUm');
  // 'dados\backup\';
  edtDestino.Text := path_backup;
  Label1.Caption := 'Pempec Enterprise Backup ' + #13 + Versao;


end;


procedure TfrmBackup.Limpatela(Sender: TObject);
begin
  PageControl1.ActivePage := tbsBackup;

  msg :=' ATENÇÃO:  ';  msgStatusBar(1,msg);
  dxBarBtnBackup.Enabled := True;

  Label1.Caption := 'Pempec Enterprise Backup ' + sLineBreak + Versao;

  //edtHrAgendada.Text := '';
 // edtHoraAtual.Text := '';
  lblEmailOff.Visible := False;
  edtHrAgendada.Text :=   LerRegistro('Pempec Enterprise', 'Finance', 'AgendaBackup');

end;


procedure TfrmBackup.Timer1Timer(Sender: TObject);
begin
  edtHoraAtual.Text := FormatDateTime('hh:MM:ss', Now);

  if edtHoraAtual.Text = edtHrAgendada.Text then
  begin
    // ShowMessage('vai comercar o back..');
    dxBarBtnBackup.Click;
    Application.ProcessMessages;

    if chkDesliga.Checked then
    begin
      WinExec('cmd /c shutdown -r -t 120', SW_NORMAL);
      Application.ProcessMessages;
    end;

  end;
end;


procedure TfrmBackup.freeAndNilDM(Sender: TObject);
begin

  if (Assigned(dmConexao)) then begin
    FreeAndNil(dmConexao);
  end;

  end;



procedure TfrmBackup.inicializarDM(Sender: TObject);
  begin

      if not(Assigned(dmConexao)) then begin
             dmConexao := TdmConexao.Create(Self);
             dmConexao.conectarBanco;
      end;

end;


procedure TfrmBackup.preencheDadosHost(Sender: TObject);
begin
 { conta     := LerRegistro('Pempec Enterprise', 'Host', 'conta');
  senha     := LerRegistro('Pempec Enterprise', 'Host', 'senha');
  host      := LerRegistro('Pempec Enterprise', 'Host', 'host');
  porta     := LerRegistro('Pempec Enterprise', 'Host', 'porta');
  autentica := LerRegistro('Pempec Enterprise', 'Host', 'autentica');


  edtEnderecoEmail.Text := LerRegistro('Pempec Enterprise', 'Host', 'destinoUm');

  // inicializa as variaveis do host do email a ser enviado.
  uVarGlobais.IniHostEmail(conta, senha, host, porta, autentica);    }

      qryServidorEmail.Close;
      qryServidorEmail.Connection := dmConexao.conn;
      qryServidorEmail.ParamByName('PIDORGANIZACAO').AsString := uutil.TOrgAtual.getId;

      qryServidorEmail.Open;

      if qryServidorEmail.RecordCount > 0 then
      begin

        conta     := qryServidorEmail.FieldByName('LOGIN').AsString;
        senha     := qryServidorEmail.FieldByName('SENHA').AsString;
        host      := qryServidorEmail.FieldByName('HOST').AsString;
        porta     := qryServidorEmail.FieldByName('PORTA').AsString;
        autentica := IntToStr(qryServidorEmail.FieldByName('REQUER_AUTENTICACAO').AsInteger);

        edtEnderecoEmail.Text := 'suporte@pempec.com.br';

      // inicializa as variaveis do host do email a ser enviado.
        uVarGlobais.IniHostEmail(conta, senha, host, porta, autentica);

      end;


end;


procedure TfrmBackup.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmBackup.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. Sistema pronto para Backup.';
end;



class function TfrmBackup.registroMD(pAcao, pDsc,pStatus: string): Boolean;
var
md :TMDModel;
org : TOrganizacaoModel;
begin
  org := TOrganizacaoModel.Create;
  org.FID := uUtil.TOrgAtual.getOrganizacao.FID;
  org :=  TOrganizacaoDAO.obterPorID(org);

   md                   := TMDModel.Create;
   md.FID               := dmConexao.obterNewID;
   md.FIDorganizacao    := uUtil.TOrgAtual.getId;
   md.FIDusuario        := uutil.TUserAtual.userID;
   md.FdataRegistro     := uutil.getDataServer;
   md.FvalorOperacao    := 0;
   md.FnumeroMovimento  := StrToInt(dmConexao.obterIdentificador('',md.FIDorganizacao,'MD'));
   md.Fcodigo           := '99999';
   md.Facao             := pAcao;
   md.Fobjeto           := pTable;
   md.Fdescricao        := pDsc + ' ' + uutil.GetUserFromWindows;
   md.Fstatus           := pStatus;
   md.Festacao          := uutil.GetComputerNetName;
   md.FipEstacao        := uUtil.GetIp;
   md.Fserver           := org.FNAMESERVERBD  + ' IP ' + org.FIPSERVERBD;

   TMDDAO.Insert(md);

end;





end.
