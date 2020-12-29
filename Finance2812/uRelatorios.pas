unit uRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, uUtil,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Phys.ADSWrapper,
  FireDAC.UI.Intf, FireDAC.VCLUI.Error, FireDAC.VCLUI.Wait, FireDAC.Phys,
  FireDAC.stan.Def, Registry, uBrowseForFolderU,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Comp.UI, FireDAC.stan.Intf,
  FireDAC.Phys.ADS, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  FireDAC.Phys.IBWrapper, Vcl.Samples.Gauges, Vcl.ComCtrls,
  Vcl.Samples.Spin, wininet, Winsock,
  IdSSL, IdSSLOpenSSL, IdMessage,
  IdAttachmentFile, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase,
  IdTCPConnection, IdSMTP, jpeg, uVarGlobais,IdBaseComponent, IdComponent, IdHTTP, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.Phys.Intf, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, Vcl.Mask,uPendentes, VCLUnZip, VCLZip,
  FireDAC.Phys.FBDef, IdAntiFreezeBase, Vcl.IdAntiFreeze, frxClass,
  uRelPagamentos;

type
  TFrmBackup = class(TForm)
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    StatusBar1: TStatusBar;
    lblAviso: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Label1: TLabel;
    Conn: TFDConnection;
    QueryTPS: TFDQuery;
    IdAntiFreeze1: TIdAntiFreeze;
    tbRelatorios: TTabSheet;
    btnRelContaPagar: TButton;
    procedure btnBackupClick(Sender: TObject);
    procedure btnAttachmentClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Limpatela(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbsBackupShow(Sender: TObject);
    procedure tbsRestoreShow(Sender: TObject);
    function LerRegistro(xArquivo, xSection, xIdent: String): String;
    procedure GravarRegistros(xArquivo, xSection, xIdent, xValue: String);
    procedure btnOrigemClick(Sender: TObject);
    procedure btnDestinoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAgendarClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnSalvarConfigClick(Sender: TObject);
    procedure preencheDadosHost(Sender: TObject);
    procedure btnSalvaDestinoClick(Sender: TObject);
    procedure edtDestinoUmChange(Sender: TObject);
    procedure IpExterno();
    procedure tabExportShow(Sender: TObject);
    procedure tbAgendaShow(Sender: TObject);
    procedure tbConfigShow(Sender: TObject);
    procedure btnCheckExportClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure btnPendentesClick(Sender: TObject);
    procedure btnRelContaPagarClick(Sender: TObject);

  private
    { Private declarations }
    ipReal,Versao, Anexo: String;
    nomeFileBackup, path_backup, arquivoZip, arquivoBackup, arquivoFBK, hora,
      data, Path_Bd: String;
    destinoUm, conta, senha, host, porta, autentica: String;
    function conectarBanco: boolean;
  public
    { Public declarations }
    arq: TextFile; { declarando a variável "arq" do tipo arquivo texto }
  end;

var
  FrmBackup: TFrmBackup;

implementation

{$R *.dfm}

uses
  System.UITypes, ShellAnimations;

procedure TFrmBackup.btnAgendarClick(Sender: TObject);
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

procedure TFrmBackup.btnAttachmentClick(Sender: TObject);

begin
  Label3.Visible := True;

  if AttachmentDialog.Execute then
  begin
    ledAttachment.Text := AttachmentDialog.FileName;
    Anexo := ledAttachment.Text;
  end;
  if Anexo <> '' then
  begin
    btnRestore.Enabled := True;
    btnBackup.Enabled := False;
  end;

end;

procedure TFrmBackup.btnBackupClick(Sender: TObject);
var
  arqLastSize,arquivoSize,aux, I: Integer;
  lastSize,host, arq, msg, cap: String;
begin


// verifica se foi marcado para envio de email e se os dados para envio foram preenchidos.
  if chkEmail.Checked then
  begin
    if not(uVarGlobais.rHost.isEnable) then
    begin
      chkEmail.Checked := False;
      chkEmail.Enabled := False;
      lblEmailOff.Visible := True;
    end;

    if (destinoUm = String.Empty) then
    begin
      destinoUm := edtUser.Text;
      edtDestinoUm.Text := destinoUm;
      btnSalvaDestino.Click;
    end;

  end;
  Label1.Caption := 'Pempec Enterprise Backup ';
  lblAviso.Caption := '';
  aux := 10;

  for I := 0 to 10 do
  begin
    StatusBar1.Panels[1].Text := 'O backup será iniciado em ' + IntToStr(aux) +
      ' segundos.';
    aux := aux - 1;
    Application.ProcessMessages;
    StatusBar1.Panels[1].Text := 'O backup foi iniciado. Aguarde...';
    Application.ProcessMessages;
    StatusBar1.Panels[1].Text := 'Verificando pasta destino. Aguarde...';
    Application.ProcessMessages;
    sleep(200);

    IpExterno();
  end;

  if not DirectoryExists(edtDestino.Text) then
  begin
    StatusBar1.Panels[1].Text := 'Pasta não existe...';
    lblAviso.Caption := 'PASTA DESTINO NÃO EXISTE...';
    msg := 'BCKP ERRO -  PST N EXISTE   ' + #13 + 'FILE :   ' + arquivoBackup;

    if uVarGlobais.rHost.isEnable then
    begin
      if not(destinoUm = String.Empty) then
      begin
        EnviarEmailGen(Self.GetNamePath, msg, 'Formulario Backup', destinoUm,
          '', arq); // retirado o arquivo
        sleep(1200);
      end;

    end;

    if MessageDlg(PChar(' Deseja criar a pasta ' +
      uUtil.GetUserFromWindows + '?'),  mtWarning, mbOKCancel, 0) = mrOk then
//    if EvMsgDlg1.MsgConfirmation(' Deseja criar a pasta ' +
//      uUtil.GetUserFromWindows + '?') = 6 then
    begin;
      if CreateDir(edtDestino.Text) then
      begin
        StatusBar1.Panels[1].Text := 'Pasta criada com sucesso..';
        lblAviso.Caption := 'PASTA CRIADA...';
        btnSalvar.Click;
        btnBackup.Click; // repete a operacao
        sleep(200);
      end;
    end
    else
    begin
      ShowMessage
        ('A aplicação será encerrada. Obrigado por utilizar nossos serviços...');
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

      FinanceBackup.DriverLink := DrvLnk;

      FinanceBackup.UserName := 'sysdba';
      FinanceBackup.Password := 'masterkey';
      if not host.IsEmpty then
      begin
        FinanceBackup.host := LerRegistro('Pempec Enterprise', 'Finance',
          'IPSERVERBD'); // configurar na aba
      end
      else
      begin
        FinanceBackup.host := '127.0.0.1';
      end;

      FinanceBackup.Protocol := ipTCPIP;
      FinanceBackup.Database := Path_Bd;
      GravarRegistros('Pempec Enterprise', 'Finance','PATH_BD',Path_Bd); //setando no registro para usar no restore

      FinanceBackup.BackupFiles.Clear; //cld 0807

      FinanceBackup.BackupFiles.Add(arquivoBackup);
      StatusBar1.Panels[1].Text := 'Gerando arquivo de backup...';
      sleep(3000);
      Application.ProcessMessages;
     FinanceBackup.Backup;

      //dados do FBK
     //arqLastSize :=0;

//problema. Quando nao existe o registro dá erro aqui
  arqLastSize := 0;
  lastSize :=LerRegistro('Pempec Enterprise', 'Finance','LastFile');

  if  not (lastSize = String.Empty ) then begin
     arqLastSize := StrToInt(lastSize);
  end;

     arquivoSize := getFileSize(arquivoBackup);
     //registrando o tamanho do ultimo arquivo de backup

     GravarRegistros('Pempec Enterprise', 'Finance','LastFile',IntToStr(arquivoSize));
     GravarRegistros('Pempec Enterprise', 'Finance','LastFileDate',DateTimeToStr(Now));


             StatusBar1.Panels[1].Text := 'Concluído. Arquivo : ' +
        arquivoBackup.ToUpper;
      sleep(5000);
      lblAviso.Visible := True;
      lblAviso.Caption := 'Operação Concluída com sucesso...' +' Tamanho do arquivo : ' + IntToStr(arquivoSize) ;
      sleep(5000);
      Label1.Caption := cap;
      btnBackup.Visible := True;
      btnBackup.Enabled := True;
      sleep(5000);
      Label1.Caption := cap;

      arq := GeraNameFileJPG();
      CapturaTelaForm(Self, arq);

      if uVarGlobais.rHost.isEnable then
      // verifrica se o sistema pode enviar email
      begin
        msg := 'BCKP SUCESS' + #13 + 'FILE :   ' + arquivoBackup + #13 +
          DateTimeToStr(Now) + #13 + 'IP > ' + ipReal ;
        EnviarEmailGen(Self.GetNamePath, msg, 'Formulario Backup',
          destinoUm, '', arq);

        Application.ProcessMessages;
      end;

      if chkZipar.Checked then
      begin
        With VCLZip1 do
        begin

          lblAviso.Caption :=
            'Pempec Enterprise Backup  -  Compactando arquivo(s). Aguarde...';
          sleep(2000);
          Label1.Caption := ' Arquivo Compactado : ' + arquivoZip;
          Application.ProcessMessages;
          sleep(5000);
      Label1.Caption := cap;

          ZipName := arquivoZip;
          FilesList.Add(arquivoBackup);
          Recurse := True; // * Recurse directories */
          StorePaths := True; // * Keep path information */
          PackLevel := 9; // * Highest level of compression */
          Zip;
          // * Return value of Zip is the actual number of files zipped */
          sleep(2000);
          lblAviso.Caption :=
            'Pempec Enterprise Backup  - Compactado com Sucesso! ';
          Application.ProcessMessages;
        end;
      end;

      if chkEmail.Checked then
      begin

        lblAviso.Caption :=
          'Pempec Enterprise Backup  -  Enviando Email. Aguarde...';
        sleep(5000);
        Application.ProcessMessages;

        if chkZipar.Checked then
        begin
          if uVarGlobais.rHost.isEnable then
          begin
            msg := 'ZIP FILE ' + #13 + 'FILE :   ' + arquivoZip + #13 +
              DateTimeToStr(Now);;
            EnviarEmailGen(Self.GetNamePath, msg, 'Backup comprimido',
              destinoUm, '', arquivoZip);

            msg := #13 + DateTimeToStr(Now);
          end;
          // EnviarEmailGen(Self.GetNamePath, msg, 'Email Enviado...',  destinoUm, '', '');
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
              EnviarEmailGen(Self.GetNamePath, msg, 'Backup FBK', destinoUm, '',
                arquivoBackup);
            end;

          end;
        end;

        lblAviso.Caption := 'Pempec Enterprise Backup ';
        Application.ProcessMessages;
        sleep(5000);
      Label1.Caption := cap;

      end;

    except
      on E: EIBNativeException do
      begin
        MessageDlg('Erro no Backup do Banco.' + 'Operação  não concluída.' + #13
          + 'Possivelmente o Banco de Dados ainda está em uso.  ' + e.Message, mtInformation,
          [mbOK], 0);
        lblAviso.Visible := True;
        lblAviso.Caption := 'Erro no Backup do Banco.' +
          'Operação  não concluída.' + #13 +
          'Possivelmente o Banco de Dados ainda está em uso.';
        btnBackup.Visible := True;
        Label1.Caption := cap;
        btnBackup.Enabled := True;

        msg := 'BCKP ERRO' + #13 + 'FILE :   ' + arquivoBackup + #13 + E.Message
          + #13 + DateTimeToStr(Now);
        if uVarGlobais.rHost.isEnable then
        begin
          EnviarEmailGen(Self.GetNamePath, msg, 'Formulario Backup',
            destinoUm, '', arq);
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
          EnviarEmailGen(Self.GetNamePath, msg, 'Formulario Backup',
            destinoUm, '', arq);
        end;

      end;

    end;

  end;

  if chkFechaApp.Checked then
  begin
    lblAviso.Caption :=
      'Pempec Enterprise Backup  - A aplicação será encerrada a seguir! ';
    Application.ProcessMessages;
    sleep(10000);
     Label1.Caption := cap;
    Application.Terminate;
  end;
end;

procedure TFrmBackup.btnCheckExportClick(Sender: TObject);
var
    aux,linha: string;
    indx :integer;
begin
 Memo1.Clear;
lblStatusExport.Visible := True;
lblStatusExport.Caption := 'Analisando o arquivo selecionado. Aguarde...';

// [ 1 ] Associa a variável do programa "arq" ao arquivo externo "tabuada.txt"
//       na unidade de disco "d"
  AssignFile(arq, edtFileExport.Text);

  {$I-}         // desativa a diretiva de Input
  Reset(arq);   // [ 3 ] Abre o arquivo texto para leitura
  {$I+}         // ativa a diretiva de Input

  if (IOResult <> 0) // verifica o resultado da operação de abertura
     then Memo1.Lines.Add('Erro na abertura do arquivo !!!')
  else begin
// [ 11 ] verifica se o ponteiro de arquivo atingiu a marca de final de arquivo
indx :=0;
lblStatusExport.Caption := 'Arquivo sendo processado';
      StatusBar1.Panels[1].Text := 'Cuidado. Operação irreversível. Faça backup antes.';
         while (not eof(arq)) do
         begin
           readln(arq, linha); // [ 6 ] Lê uma linha do arquivo
           Memo1.Lines.Add(linha);
          if not (linha = '')  then begin
           indx := indx + 1;
            if (linha.Length >0) then begin
            aux := linha;
            //edit2.Text := ' CMD '+ StringReplace(aux,'%#$',EmptyStr,[rfReplaceAll]);
            Application.ProcessMessages;
            end;
          end;
         end;

         CloseFile(arq); // [ 8 ] Fecha o arquivo texto aberto
       end;
         lblStatusExport.Caption := 'Arquivo analisado com sucesso.' ;//'Foram encontrados  ' + indx.ToString + '  registros .'   ;

          Memo1.Clear;
          Memo1.Lines.Add('Foram encontradas  ' + indx.ToString + '  linhas possíveis de exportação.' ) ;

           btnExportar.Enabled :=true;



end;


procedure TFrmBackup.btnDestinoClick(Sender: TObject);
var
  caminho: String;
begin

  caminho := uBrowseForFolderU.BrowseForFolder(' Pastas ', 'C:\', False);
  // dlgDestino.FileName;
  edtDestino.Text := caminho + '\';
  path_backup := edtDestino.Text;


end;

procedure TFrmBackup.btnExportarClick(Sender: TObject);
var
QueryTPS : TFDQuery;
  linha,comando: String;
  indx: integer;

begin
btnCheckExport.Enabled :=false;
Memo1.Clear;
AssignFile(arq, edtFileExport.Text);

  {$I-}         // desativa a diretiva de Input
  Reset(arq);   // [ 3 ] Abre o arquivo texto para leitura
  {$I+}         // ativa a diretiva de Input

  if (IOResult <> 0) // verifica o resultado da operação de abertura
     then Memo1.Lines.Add('Erro na abertura do arquivo !!!')
  else begin
indx :=0;
lblStatusExport.Caption := 'Arquivo sendo preparado para exportação';
         while (not eof(arq)) do
         begin
           readln(arq, linha); // [ 6 ] Lê uma linha do arquivo
           Memo1.Lines.Add('Processando a solicitação..');
           try
             if not (linha ='Committ Work;') then begin
              if not (linha = '')  then begin
                comando := linha ;
                QueryTPS := TFDQuery.Create(Self);
                QueryTPS.Connection := Conn;
                QueryTPS.Connection.Connected;
                QueryTPS.Close;

                if (QueryTPS.ExecSQL(comando) =0) then begin
                indx := indx + 1;
                Memo1.Clear;
                Memo1.Lines.Add('Processando a solicitação atual de numero  ' + indx.ToString());
                sleep(100);


                Label12.Caption := 'Foram exportados  '+ indx.ToString() + ' registros.';

                Application.ProcessMessages;
                end;
             end;
             end;

           finally
           FreeAndNil(QueryTPS);

           end;


         end;

         CloseFile(arq); // [ 8 ] Fecha o arquivo texto aberto
       end;

         lblStatusExport.Caption := 'Arquivo analisado com sucesso.' ;//'Foram encontrados  ' + indx.ToString + '  registros .'   ;

          Memo1.Clear;
          Memo1.Lines.Add('Foram encontradas  ' + indx.ToString + '  linhas possíveis de exportação.' ) ;

          btnExportar.Enabled :=false;


end;

procedure TFrmBackup.btnOrigemClick(Sender: TObject);
begin
  if dlgOrigem.Execute then
  begin
    edtFileExport.Text := dlgOrigem.FileName;
    btnCheckExport.Enabled :=true;

  end;

end;

procedure TFrmBackup.btnPendentesClick(Sender: TObject);
begin
if FPendentes = nil then
    FPendentes:= TFPendentes.Create(Self);
    FPendentes.Show ;
end;

procedure TFrmBackup.btnRelContaPagarClick(Sender: TObject);
begin
  try
    if conectarBanco then begin
      FRelPagamentos := TFRelPagamentos.Create(Self);
      FRelPagamentos.ShowModal;
      FreeAndNil(FRelPagamentos);
    end else begin
      ShowMessage('Não foi possível conectar o banco de dados!' + sLineBreak + 'Contate o Administrador!');
    end;
  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;
end;

function TFrmBackup.conectarBanco: boolean;
var
  database: string;
  host: string;
  porta: string;
  user: string;
  password: string;
begin
{Verificando se o banco esta conectado}
  if not(conn.Connected) then begin
    database := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD');
    host     := LerRegistro('Pempec Enterprise', 'Finance', 'IPSERVERBD');
    porta    := LerRegistro('Pempec Enterprise', 'Finance', 'PORTABD');
    user     := 'SYSDBA';
    password := 'masterkey';

    try
      // O que essa parte do código faz?
      if (database = String.Empty) then begin
        GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_SERVER', '');
        PageControl1.TabIndex := 0;
      end;


      if uUtil.PastaExist(LerRegistro('Pempec Enterprise', 'Finance', 'PATH_SERVER')) then begin
        if uUtil.ArquivoExist(database) then  begin
          Conn.Params.Clear;
          Conn.LoginPrompt := False;
          Conn.DriverName := 'FB';
          Conn.Params.Add('database=' + database);
          Conn.Params.Add('drivername=' + Conn.DriverName);
          Conn.Params.Add('hostname=' + host);
          Conn.Params.Add('user_name=' + user);
          Conn.Params.Add('password=' + password);
          Conn.Params.Add('port=' + porta);
          Conn.Params.Add('blobsize=-1');
          Conn.Params.Add('SQLDialect=3');
          Conn.Params.Add('CharacterSet = iso8859_1');
          Conn.Params.Add('PageSize=4096');
          Conn.Open;
        end;

        if not Conn.Ping then  begin
          raise Exception.Create('Não foi possível conectar ao banco de dados!');
        end;
      end  else  begin
        raise Exception.Create('O Caminho do banco de dados parece estar incorreto.');
      end;
    except
      raise Exception.Create('ERRO DE REGISTRO. REGISTRE OS SISTEMAS!');
    end;
  end;
  Result := conn.Connected;
end;

procedure TFrmBackup.btnRestoreClick(Sender: TObject);
begin
  lblAviso.Caption := '';
  try
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

      StatusBar1.Panels[1].Text := 'Restore sendo iniciado...';
      FinanceRestore.Restore;

      lblAviso.Visible := True;
      lblAviso.Caption := 'Operação concluída com sucesso...';
      btnBackup.Visible := True;
      btnBackup.Enabled := True;
      btnRestore.Enabled := False;
      StatusBar1.Panels[1].Text := 'Operação bem sucedida...';
      ledAttachment.Text := '';
      Application.ProcessMessages;
    end;

  except
    on E: EIBNativeException do
      // raise EIBNativeException.Create('Erro ao restaurar o Banco.'+#13 +'Possivelmente o  Banco de Dados ainda está em uso.');
      MessageDlg('Erro ao restaurar o Banco.' + #13 +
        'Possivelmente o  Banco de Dados ainda está em uso.' + #13 +
        'Será necessário parar o serviço do Banco de Dados.', mtInformation,
        [mbOK], 0);

    on E: Exception do
      MessageDlg('Um erro inesperado ocorreu.', mtWarning, [mbOK], 0);
  end;

end;

procedure TFrmBackup.btnSalvaDestinoClick(Sender: TObject);
begin
  if edtDestinoUm.Text <> '' then
  begin
    destinoUm := edtDestinoUm.Text;
    GravarRegistros('Pempec Enterprise', 'Host', 'destinoUm',
      edtDestinoUm.Text);
  end;
end;

procedure TFrmBackup.btnSalvarClick(Sender: TObject);
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

procedure TFrmBackup.btnSalvarConfigClick(Sender: TObject);
begin
  GravarRegistros('Pempec Enterprise', 'Host', 'conta', edtUser.Text);
  GravarRegistros('Pempec Enterprise', 'Host', 'senha', edtPassword.Text);
  GravarRegistros('Pempec Enterprise', 'Host', 'host', edtHost.Text);
  GravarRegistros('Pempec Enterprise', 'Host', 'porta', edtPorta.Text);
  if chAutentica.Checked then
  begin
    GravarRegistros('Pempec Enterprise', 'Host', 'autentica', 'S');
  end
  else
  begin
    GravarRegistros('Pempec Enterprise', 'Host', 'autentica', 'N');
  end;

  preencheDadosHost(Self);

end;

procedure TFrmBackup.edtDestinoUmChange(Sender: TObject);
begin
  destinoUm := edtDestinoUm.Text;
end;

procedure TFrmBackup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Limpatela(Self);
  Action := caFree;

end;

procedure TFrmBackup.preencheDadosHost(Sender: TObject);
begin

  conta := LerRegistro('Pempec Enterprise', 'Host', 'conta');
  senha := LerRegistro('Pempec Enterprise', 'Host', 'senha');
  host := LerRegistro('Pempec Enterprise', 'Host', 'host');
  porta := LerRegistro('Pempec Enterprise', 'Host', 'porta');
  autentica := LerRegistro('Pempec Enterprise', 'Host', 'autentica');

  edtHost.Text := host;
  edtUser.Text := conta;
  edtPorta.Text := porta;
  edtPassword.Text := senha;
  edtDestinoUm.Text := LerRegistro('Pempec Enterprise', 'Host', 'destinoUm');

  { if autentica = String.Empty then
    begin
    autentica := 'N';
    end;

    if conta = String.Empty then
    begin
    conta := ' ';
    end;

    if senha = String.Empty then
    begin
    senha := ' ';
    end;

    if host = String.Empty then
    begin
    host := ' ';
    end;
    if porta = String.Empty then
    begin
    porta := ' ';
    end;
  }
  if (autentica.Equals('N')) then
  begin
    chAutentica.Checked := False;
  end
  else
  begin
    chAutentica.Checked := True;
  end;

  // inicializa as variaveis do host do email a ser enviado.
  uVarGlobais.IniHostEmail(conta, senha, host, porta, autentica);

end;

procedure TFrmBackup.FormCreate(Sender: TObject);
begin
  Limpatela(Self);
  preencheDadosHost(Self);
  Versao := 'V. 1.0 - 1911';
  Path_Bd := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD');
  edtOrigem.Text := Path_Bd;
  hora := FormatDateTime('hhmmss', Now());
  data := FormatDateTime('ddmmyyyy', Now());
  btnExportar.Enabled :=false;
  btnCheckExport.Enabled :=false;



IpExterno();


  nomeFileBackup := LerRegistro('Pempec Enterprise', 'Finance',
    'ID_ORGANIZACAO');
  if (nomeFileBackup = String.Empty) then
  begin
    nomeFileBackup := 'BKP_';
  end
  else
  begin
    nomeFileBackup := nomeFileBackup + '_';
  end;

  path_backup := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD_BKP');
  // 'dados\backup\';

  edtDestino.Text := path_backup;

  Label1.Caption := 'Pempec Enterprise Backup ' + #13 + Versao;

end;

procedure TFrmBackup.Limpatela(Sender: TObject);
begin
  PageControl1.ActivePage := tbsBackup;
  lblAviso.Visible := False;
  btnRestore.Enabled := False;
  btnBackup.Enabled := True;
  btnBackup.Visible := True;
  StatusBar1.Panels[1].Text := 'Manutençao do Banco de Dados';
  Label3.Visible := False;
  ledAttachment.Text := '';
  Label1.Caption := 'Pempec Enterprise Backup ' + #13 + Versao;
  edtHrAgendada.Text := '';
  lblEmailOff.Visible := False;
  edtHrAgendada.Text :=   LerRegistro('Pempec Enterprise', 'Finance', 'AgendaBackup');
  Label3.Caption := '';
  Label12.Caption := '';
  Memo1.Clear;
  lblStatusExport.Visible := false;


end;

procedure TFrmBackup.tabExportShow(Sender: TObject);
var
database, user, password, porta, host: String;

begin
lblPrincipal.Caption := 'EXPORTAÇÃO DE DADOS';

lblBaseDados.Caption := 'BASE : '+edtOrigem.Text;

//conectando com o banco de dados
 //database := edtOrigem.Text;

 database :=LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD');
 edtOrigem.Text := database;


  host := LerRegistro('Pempec Enterprise', 'Finance', 'IPSERVERBD');
  porta := LerRegistro('Pempec Enterprise', 'Finance', 'PORTABD');
  user := 'SYSDBA';
  password := 'masterkey';

  try

  if (database = String.Empty) then begin
      GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_SERVER', '');
      PageControl1.TabIndex := 0;
    end;


    if uUtil.PastaExist(LerRegistro('Pempec Enterprise', 'Finance',
      'PATH_SERVER')  ) then
    begin
      if uUtil.ArquivoExist(database) then
      begin

        Conn.Params.Clear;
        Conn.LoginPrompt := False;
        Conn.DriverName := 'FB';
        Conn.Params.Add('database=' + database);
        Conn.Params.Add('drivername=' + Conn.DriverName);
        Conn.Params.Add('hostname=' + host);
        Conn.Params.Add('user_name=' + user);
        Conn.Params.Add('password=' + password);
        Conn.Params.Add('port=' + porta);
        Conn.Params.Add('blobsize=-1');
        Conn.Params.Add('SQLDialect=3');
        Conn.Params.Add('CharacterSet = iso8859_1');
        Conn.Params.Add('PageSize=4096');
        Conn.Open;
      end;

      if not Conn.Ping then  begin
     Memo1.Lines.Add('O Banco de Dados não está conectado.') ;
     btnExportar.Enabled := false;
      PageControl1.TabIndex := 0;
      end;


    end
    else
    begin
      raise Exception.Create
        ('O Caminho do banco de dados parece estar incorreto.');
    end;

  except
    raise Exception.Create(' ERRO DE REGISTRO. REGISTRE OS SISTEMAS!');
     PageControl1.TabIndex := 0;
    Memo1.Clear;
    Memo1.Lines.Add('O Banco de Dados não está conectado.') ;
    btnExportar.Enabled := false;

  end;




end;

procedure TFrmBackup.tbAgendaShow(Sender: TObject);
begin
lblPrincipal.Caption := ' CONFIGURAÇÃO DO AGENDAMENTO  ';
end;

procedure TFrmBackup.tbConfigShow(Sender: TObject);
begin
lblPrincipal.Caption := ' CONFIGURAÇÃO SERVIDOR DE EMAIL.  ';
end;

procedure TFrmBackup.tbsBackupShow(Sender: TObject);
begin
  lblPrincipal.Caption := ' BACKUP DA BASE DE DADOS  ';
  Label3.Caption := '';
  Label3.Visible := False;
end;

procedure TFrmBackup.tbsRestoreShow(Sender: TObject);
begin
  Label3.Visible := True;
  lblPrincipal.Caption := ' RESTAURAR BASE DE DADOS  ';
end;

procedure TFrmBackup.Timer1Timer(Sender: TObject);
begin
  edtHoraAtual.Text := FormatDateTime('hh:MM:ss', Now);

  if edtHoraAtual.Text = edtHrAgendada.Text then
  begin
    // ShowMessage('vai comercar o back..');
    btnBackupClick(Self);
    Application.ProcessMessages;

    if chkDesliga.Checked then
    begin
      WinExec('cmd /c shutdown -s -t 61', SW_NORMAL);
      Application.ProcessMessages;
    end;

  end;
end;

{ Função para retornar o conteúdo de um determinado registro }

function TFrmBackup.LerRegistro(xArquivo, xSection, xIdent: String): String;
// mudado em 20/04 add HKEY_CURRENT_USER
var
  ArqReg: TRegIniFile;
begin

  ArqReg := TRegIniFile.Create(xArquivo);
  ArqReg.rootkey := HKEY_CURRENT_USER;
  Try

    Result := ArqReg.ReadString(xSection, xIdent, '');

  Finally

    ArqReg.free;

  end;

end;

procedure TFrmBackup.GravarRegistros(xArquivo, xSection, xIdent,
  xValue: String);

var
  ArqReg: TRegIniFile;

begin

  ArqReg := TRegIniFile.Create(xArquivo);
  ArqReg.rootkey := HKEY_CURRENT_USER;

  Try

    ArqReg.WriteString(xSection, xIdent, xValue);

  Finally
    ArqReg.free;

  end;

end;

procedure TFrmBackup.IpExterno();
var
IPExterno: string;
begin
IPExterno := '';
with TIdHTTP.Create(nil) do
try
IPExterno:= Get('http://checkip.dyndns.org');
IPExterno:= Copy(IPExterno, Pos('Current IP Address: ', IPExterno) + 20, 15);
IPExterno := Copy(IPExterno, 1, Pos('<', IPExterno) - 1);

except on E: Exception do
IPExterno:= E.Message;
end;
     if not (IPExterno = String.Empty) then begin
        label1.Caption := 'Seu ip é : ' + IPExterno;
     end;

      ipReal := IPExterno;

end;


end.
