unit uBackup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, uUtil,uVarGlobais,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Phys.ADSWrapper,
  FireDAC.UI.Intf, FireDAC.VCLUI.Error, FireDAC.VCLUI.Wait, FireDAC.Phys,
  FireDAC.stan.Def, Registry, uBrowseForFolderU,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Comp.UI, FireDAC.stan.Intf,
  FireDAC.Phys.ADS, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  FireDAC.Phys.IBWrapper, Vcl.Samples.Gauges, Vcl.ComCtrls,
  Vcl.Samples.Spin, wininet, Winsock,
  IdSSL, IdSSLOpenSSL, IdMessage,
  IdAttachmentFile, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase,uLogin,
  IdTCPConnection, IdSMTP, jpeg, IdBaseComponent, IdComponent, IdHTTP, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.Phys.Intf, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, Vcl.Mask,uPendentes, VCLUnZip, VCLZip,
  FireDAC.Phys.FBDef, IdAntiFreezeBase, Vcl.IdAntiFreeze, frxClass,
  uRelPagamentos, udmConexao, uDMOrganizacao, udmMegaContabil, ACBrBase,
  uDmExportaFinance,uDMContasPagar,uDMRelatorioExportacaoMega, Vcl.Imaging.pngimage, Vcl.Grids, Vcl.DBGrids, frxDBSet;



type
  TFrmBackup = class(TForm)
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    DrvLnk: TFDPhysFBDriverLink;
    btnBackup: TButton;
    FinanceBackup: TFDIBBackup;
    FinanceRestore: TFDIBRestore;
    btnAttachment: TBitBtn;
    ledAttachment: TLabeledEdit;
    AttachmentDialog: TOpenDialog;
    btnRestore: TButton;
    lblPrincipal: TLabel;
    StatusBar1: TStatusBar;
    lblAviso: TLabel;
    PageControl1: TPageControl;
    tbsBackup: TTabSheet;
    tbsRestore: TTabSheet;
    Label3: TLabel;
    Panel1: TPanel;
    edtOrigem: TLabeledEdit;
    btnOrigem: TBitBtn;
    dlgOrigem: TOpenDialog;
    edtDestino: TLabeledEdit;
    btnDestino: TBitBtn;
    btnSalvar: TBitBtn;
    Label1: TLabel;
//    EvMsgDlg1: TEvMsgDlg;
    tbAgenda: TTabSheet;
    chkDesliga: TCheckBox;
    Label10: TLabel;
    spinHora: TSpinEdit;
    Label9: TLabel;
    spinMin: TSpinEdit;
    Label8: TLabel;
    spinSeg: TSpinEdit;
    btnAgendar: TButton;
    edtHrAgendada: TEdit;
    Timer1: TTimer;
    edtHoraAtual: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    chkZipar: TCheckBox;
    chkEmail: TCheckBox;
    tbConfig: TTabSheet;
    edtHost: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtPorta: TEdit;
    edtUser: TEdit;
    Label7: TLabel;
    edtDestinoUm: TEdit;
    chAutentica: TCheckBox;
    Label11: TLabel;
    btnSalvarConfig: TButton;
    btnSalvaDestino: TButton;
    lblEmailOff: TLabel;
    chkFechaApp: TCheckBox;
    VCLZip1: TVCLZip;
    IdHTTP1: TIdHTTP;
    tabExport: TTabSheet;
    edtFileExport: TLabeledEdit;
    btnLocateExport: TBitBtn;
    lblStatusExport: TLabel;
    Memo1: TMemo;
    btnCheckExport: TBitBtn;
    btnExportar: TBitBtn;
    QueryTPS: TFDQuery;
    Label12: TLabel;
    edtPassword: TMaskEdit;
    lblBaseDados: TLabel;
    btnPendentes: TBitBtn;
    IdAntiFreeze1: TIdAntiFreeze;
    tbRelatorios: TTabSheet;
    btnRelContaPagar: TButton;
    tbsImport: TTabSheet;
    tbsTabRegistros: TTabSheet;
    btnRegistrar: TButton;
    cbxOrganizacoes: TComboBox;
    btnSelect: TButton;
    lblOrgCodinome: TLabel;
    lblOrgSerial: TLabel;
    lblOrgLicenca: TLabel;
    lblOrgSistema: TLabel;
    lblOrgCnpj: TLabel;
    lblOrgIpServerBD: TLabel;
    lblOrgPathMega: TLabel;
    lblOrgSerialMega: TLabel;
    lblOrgPathExeMega: TLabel;
    lblOrgCodigoMega: TLabel;
    lblStatusSistemaContabil: TLabel;
    edtLote: TEdit;
    btnGeraLote: TButton;
    cbxMesLote: TComboBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    cbxAnoLote: TComboBox;
    lblGeneratorID: TLabel;
    Label16: TLabel;
    dtDataInicial: TDateTimePicker;
    Label17: TLabel;
    dtDataFinal: TDateTimePicker;
    imgGreen: TImage;
    SpeedButton1: TSpeedButton;
    lblStatusExp: TLabel;
    imgRed: TImage;
    lblIdOrganizacao: TLabel;
    dbgTitulo: TDBGrid;
    dtsTituloPagar: TDataSource;
    dbgHistorico: TDBGrid;
    dtsHistorico: TDataSource;
    dbgCentroCusto: TDBGrid;
    dtsCentroCusto: TDataSource;
    btnImprimir: TBitBtn;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    Label18: TLabel;
    Label19: TLabel;
    dtsTituloReceber: TDataSource;
    dtsHistoricoTR: TDataSource;
    dtsCentroCustoTR: TDataSource;
    lblHistoricoSemConta: TLabel;
    procedure btnBackupClick(Sender: TObject);
    procedure btnAttachmentClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Limpatela(Sender: TObject);
    procedure LimpaTabSheetRegistros(Sender: TObject);
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
    procedure tbsTabRegistrosShow(Sender: TObject);
    procedure tbsImportShow(Sender: TObject);
    procedure tbRelatoriosShow(Sender: TObject);
    procedure btnRegistrarClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure FinalDM();
    procedure InitDM();
    procedure statusExportar(sinal :Integer);
    procedure btnGeraLoteClick(Sender: TObject);
    procedure cbxMesLoteChange(Sender: TObject);
    procedure cbxAnoLoteClick(Sender: TObject);
    procedure dtsTituloPagarDataChange(Sender: TObject; Field: TField);
    procedure dbgHistoricoCellClick(Column: TColumn);
    procedure btnImprimirClick(Sender: TObject);
    procedure dtsTituloReceberDataChange(Sender: TObject; Field: TField);



  private
    { Private declarations }
    ipReal,Versao, Anexo: String;
    nomeFileBackup, path_backup, arquivoZip, arquivoBackup, arquivoFBK, hora,
      data, Path_Bd: String;
    destinoUm, conta, senha, host, porta, autentica: String;
    FsListaIdOrganizacoes: TStringList;
//        function carregarOrganizacoes: Boolean;
    procedure preencherListaOrganizacoes;


  public
    { Public declarations }
    arq: TextFile; { declarando a vari�vel "arq" do tipo arquivo texto }
    idOrganizacao :String;

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


  for I := 0 to 1 do
  begin
    StatusBar1.Panels[1].Text := 'O backup ser� iniciado em instantes...';
    StatusBar1.Panels[1].Text := 'O backup foi iniciado. Aguarde...';
    StatusBar1.Panels[1].Text := 'Verificando pasta destino. Aguarde...';
    Application.ProcessMessages;

  end;

  if not DirectoryExists(edtDestino.Text) then
  begin
    StatusBar1.Panels[1].Text := 'Pasta n�o existe...';
    sleep(5);
    lblAviso.Caption := 'PASTA DESTINO N�O EXISTE...';

    if MessageDlg(PChar(' Deseja criar a pasta ' +
      uUtil.GetUserFromWindows + '?'),  mtWarning, mbOKCancel, 0) = mrOk then
//
    begin;
      if CreateDir(edtDestino.Text) then
      begin
        StatusBar1.Panels[1].Text := 'Pasta criada com sucesso..';
        lblAviso.Caption := 'PASTA CRIADA...';
        btnSalvar.Click;
        btnBackup.Click; // repete a operacao
      end;
    end
    else
    begin
      ShowMessage
        ('A aplica��o ser� encerrada. Obrigado por utilizar nossos servi�os...');
      Application.Terminate;
      Close;
      Application.ProcessMessages;
    end;
  end
  else
  begin

    cap := Label1.Caption;
    btnBackup.Visible := False;
    Label1.Caption := '          OPERA��O INICIADA';
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
      sleep(30);
      Application.ProcessMessages;
     FinanceBackup.Backup;

      //dados do FBK
     //arqLastSize :=0;

//problema. Quando nao existe o registro d� erro aqui
  arqLastSize := 0;
  lastSize :=LerRegistro('Pempec Enterprise', 'Finance','LastFile');

  if  not (lastSize = String.Empty ) then begin
     arqLastSize := StrToInt(lastSize);
  end;

     arquivoSize := getFileSize(arquivoBackup);
     //registrando o tamanho do ultimo arquivo de backup

     GravarRegistros('Pempec Enterprise', 'Finance','LastFile',IntToStr(arquivoSize));
     GravarRegistros('Pempec Enterprise', 'Finance','LastFileDate',DateTimeToStr(Now));
     StatusBar1.Panels[1].Text := 'Conclu�do. Arquivo : ' +
     arquivoBackup.ToUpper;
      sleep(10);
      lblAviso.Visible := True;
      lblAviso.Caption := 'Opera��o Conclu�da com sucesso...' +' Tamanho do arquivo : ' + IntToStr(arquivoSize) ;
      sleep(10);
      Label1.Caption := cap;
      btnBackup.Visible := True;
      btnBackup.Enabled := True;
      sleep(10);
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
          lblAviso.Caption :=
            'Pempec Enterprise Backup  - Compactado com Sucesso! ';
          Application.ProcessMessages;
        end;
      end;

      if chkEmail.Checked then
      begin

        lblAviso.Caption :=
          'Pempec Enterprise Backup  -  Enviando Email. Aguarde...';
        sleep(500);
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
            MessageDlg(PChar('O arquivo n�o est� comprimido!' + #13 +
            #13 + #13 + 'O envio ser� muito demorado. ' + #13 + #13 + #13 + #13
            + 'Tem certeza que deseja continuar Sr(a) ' +
            uUtil.GetUserFromWindows + ' ?'),  mtWarning, mbOKCancel, 0) = mrOk
          ) then
//          if EvMsgDlg1.MsgConfirmation('O arquivo n�o est� comprimido!' + #13 +
//            #13 + #13 + 'O envio ser� muito demorado. ' + #13 + #13 + #13 + #13
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
        sleep(50);
      Label1.Caption := cap;

      end;

    except
      on E: EIBNativeException do
      begin
        MessageDlg('Erro no Backup do Banco.' + 'Opera��o  n�o conclu�da.' + #13
          + 'Possivelmente o Banco de Dados ainda est� em uso.  ' + e.Message, mtInformation,
          [mbOK], 0);
        lblAviso.Visible := True;
        lblAviso.Caption := 'Erro no Backup do Banco.' +
          'Opera��o  n�o conclu�da.' + #13 +
          'Possivelmente o Banco de Dados ainda est� em uso.';
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
        MessageDlg('Um erro inesperado ocorreu.' + 'Backup n�o realizado.' + #13
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
      'Pempec Enterprise Backup  - A aplica��o ser� encerrada a seguir! ';
    Application.ProcessMessages;
    sleep(100);
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

// [ 1 ] Associa a vari�vel do programa "arq" ao arquivo externo "tabuada.txt"
//       na unidade de disco "d"
  AssignFile(arq, edtFileExport.Text);

  {$I-}         // desativa a diretiva de Input
  Reset(arq);   // [ 3 ] Abre o arquivo texto para leitura
  {$I+}         // ativa a diretiva de Input

  if (IOResult <> 0) // verifica o resultado da opera��o de abertura
     then Memo1.Lines.Add('Erro na abertura do arquivo !!!')
  else begin
// [ 11 ] verifica se o ponteiro de arquivo atingiu a marca de final de arquivo
indx :=0;
lblStatusExport.Caption := 'Arquivo sendo processado';
      StatusBar1.Panels[1].Text := 'Cuidado. Opera��o irrevers�vel. Fa�a backup antes.';
         while (not eof(arq)) do
         begin
           readln(arq, linha); // [ 6 ] L� uma linha do arquivo
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
          Memo1.Lines.Add('Foram encontradas  ' + indx.ToString + '  linhas poss�veis de exporta��o.' ) ;

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

  if (IOResult <> 0) // verifica o resultado da opera��o de abertura
     then Memo1.Lines.Add('Erro na abertura do arquivo !!!')
  else begin
indx :=0;
lblStatusExport.Caption := 'Arquivo sendo preparado para exporta��o';
         while (not eof(arq)) do
         begin
           readln(arq, linha); // [ 6 ] L� uma linha do arquivo
           Memo1.Lines.Add('Processando a solicita��o..');
           try
             if not (linha ='Committ Work;') then begin
              if not (linha = '')  then begin
                comando := linha ;
                QueryTPS := TFDQuery.Create(Self);
                QueryTPS.Connection := dmConexao.Conn;
                QueryTPS.Connection.Connected;
                QueryTPS.Close;

                if (QueryTPS.ExecSQL(comando) =0) then begin
                indx := indx + 1;
                Memo1.Clear;
                Memo1.Lines.Add('Processando a solicita��o atual de numero  ' + indx.ToString());
                sleep(10);


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
          Memo1.Lines.Add('Foram encontradas  ' + indx.ToString + '  linhas poss�veis de exporta��o.' ) ;

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
//    FPendentes.Show ;
      FPendentes.ShowModal;
      FreeAndNil(FPendentes);
end;

procedure TFrmBackup.btnRegistrarClick(Sender: TObject);
var
porta_bd,database,path_server,serial,serialMega :string;

begin

    serial := '0'; serialMega := '1';
    path_server := LerRegistro('Pempec Enterprise','Finance','PATH_SERVER');
    database := LerRegistro('Pempec Enterprise','Finance','PATH_BD');
     porta_bd := LerRegistro('Pempec Enterprise','Finance','PORTABD');


    //Caminho do finance
    if not (path_server = String.Empty) then begin
        GravarRegistros('Pempec Enterprise', 'Finance','PATH_SERVER',path_server);
    end else begin  GravarRegistros('Pempec Enterprise', 'Finance','PATH_SERVER', 'c:\finance\'); end;

    //Caminho do banco de dados
    if not (database = String.Empty) then begin
        GravarRegistros('Pempec Enterprise', 'Finance','PATH_BD',database);
    end else begin  GravarRegistros('Pempec Enterprise', 'Finance','PATH_BD', 'c:\finance\dados\finance.fdb'); end;

    //Porta para acesso ao banco de dados
    if not (porta_bd = String.Empty) then begin
        GravarRegistros('Pempec Enterprise', 'Finance','PORTABD',porta_bd);
    end else begin  GravarRegistros('Pempec Enterprise', 'Finance','PORTABD', '3051'); end;

    GravarRegistros('Pempec Enterprise', 'Finance','AgendaBackup','21:00:00');
    GravarRegistros('Pempec Enterprise', 'Finance','HostWeb','1');
    GravarRegistros('Pempec Enterprise', 'Finance','LastFile','1');
    GravarRegistros('Pempec Enterprise', 'Finance','LastFileDate','1');
    GravarRegistros('Pempec Enterprise', 'Finance','PasswordWeb','hf3810');
    GravarRegistros('Pempec Enterprise', 'Finance','IPSERVERBD','127.0.0.1');
    GravarRegistros('Pempec Enterprise', 'Finance','HOST_IP','127.0.0.1');
    GravarRegistros('Pempec Enterprise', 'Finance','PATH_BD_BKP','127.0.0.1');
    GravarRegistros('Pempec Enterprise', 'Finance','PATH_ERRO','127.0.0.1');
    GravarRegistros('Pempec Enterprise', 'Finance','PathUpdate','127.0.0.1');
    GravarRegistros('Pempec Enterprise', 'Finance','PathWeb','127.0.0.1');
    GravarRegistros('Pempec Enterprise', 'Finance','SerialNumber',serial);
    GravarRegistros('Pempec Enterprise', 'Finance','UserNameWeb','127.0.0.1');
    GravarRegistros('Pempec Enterprise', 'Finance', 'REGISTER','1'); //1 =registrado / 0= nao registrado

//host

    if chAutentica.Checked then begin
       GravarRegistros('Pempec Enterprise', 'Host','autentica','1');
    end else
    begin
           GravarRegistros('Pempec Enterprise', 'Host','autentica','0');
    end;

    GravarRegistros('Pempec Enterprise', 'Host','conta',edtUser.Text);
    GravarRegistros('Pempec Enterprise', 'Host','destinoUm','ranansousa@gmail.com');
    GravarRegistros('Pempec Enterprise', 'Host','host',edtHost.Text);
    GravarRegistros('Pempec Enterprise', 'Host','porta',edtPorta.Text);
    GravarRegistros('Pempec Enterprise', 'Host','senha',edtPassword.Text);

//mega
    GravarRegistros('Pempec Enterprise', 'Mega','PATH_BD','caminho do banco mega');
    GravarRegistros('Pempec Enterprise', 'Mega','PATH_MEGA','caminho do EXE');
    GravarRegistros('Pempec Enterprise', 'Mega','SERIAL',serialMega);
    GravarRegistros('Pempec Enterprise', 'Mega','CODIGO_EMPRESA','1');



end;

procedure TFrmBackup.btnRelContaPagarClick(Sender: TObject);
begin
//usado
  try
    if dmConexao.conectarBanco then begin
      FRelPagamentos := TFRelPagamentos.Create(Self);
      FRelPagamentos.ShowModal;
      FreeAndNil(FRelPagamentos);
    end else begin
      ShowMessage('N�o foi poss�vel conectar o banco de dados!' + sLineBreak + 'Contate o Administrador!');
    end;
  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;
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

    if (MessageDlg('Esta opera��o � irrevers�vel. ' + #13 +
      ' Tem certeza que deseja continuar ?', mtConfirmation, mbYesNo, 0) = mrYes)
    then
    begin;

      StatusBar1.Panels[1].Text := 'Restore sendo iniciado...';
      FinanceRestore.Restore;

      lblAviso.Visible := True;
      lblAviso.Caption := 'Opera��o conclu�da com sucesso...';
      btnBackup.Visible := True;
      btnBackup.Enabled := True;
      btnRestore.Enabled := False;
      StatusBar1.Panels[1].Text := 'Opera��o bem sucedida...';
      ledAttachment.Text := '';
      Application.ProcessMessages;
    end;

  except
    on E: EIBNativeException do
      // raise EIBNativeException.Create('Erro ao restaurar o Banco.'+#13 +'Possivelmente o  Banco de Dados ainda est� em uso.');
      MessageDlg('Erro ao restaurar o Banco.' + #13 +
        'Possivelmente o  Banco de Dados ainda est� em uso.' + #13 +
        'Ser� necess�rio parar o servi�o do Banco de Dados.', mtInformation,
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



procedure TFrmBackup.btnSelectClick(Sender: TObject);
var
registro,idMega,cnpj,pid: string;
begin
idMega :='0';
registro :='0';

if  (cbxOrganizacoes.ItemIndex > (-1) ) then begin
 pid := FsListaIdOrganizacoes[cbxOrganizacoes.ItemIndex];
end;
if (dmConexao.Conn.Connected) then begin
dmOrganizacao.carregarDadosEmpresa(pid);
//Vai no mega pegar o ID dessa empresa selecionada. Passando CNPJ como parametro
cnpj := dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString;
cnpj :=StringReplace(cnpj, '''', '',[]);
idOrganizacao := dmOrganizacao.qryDadosEmpresa.FieldByName('ID_ORGANIZACAO').AsString;
end;

if (dmConexao.ConnMega.Connected) then begin
dmMegaContabil.carregarDadosEmpresaMega(cnpj);   //inscmf = cnpj
//verifica se o banco do mega retornou o codigo e seta no registro
idMega := dmMegaContabil.qryDadosEmpresaMega.FieldByName('ID').AsString;

end;

if not ( idMega = String.Empty) then
begin

idMega := StringReplace(idMega, '''', '',[]);
 GravarRegistros('Pempec Enterprise', 'Mega', 'CODIGO_EMPRESA',idMega);
end;

lblOrgCodinome.Caption := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CODINOME').AsString);
lblOrgSerial.Caption   := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('SERIAL_CLIENTE').AsString);
lblOrgLicenca.Caption  := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('LICENCA').AsString);
lblOrgSistema.Caption  := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('SISTEMA_CONTABIL').AsString);
lblOrgCnpj.Caption  := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
lblOrgIpServerBD.Caption  := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('IPSERVERBD').AsString);
lblOrgPathMega.Caption  := 'BASE DO MEGA  : '+ LerRegistro('Pempec Enterprise', 'Mega', 'PATH_BD');
lblOrgSerialMega.Caption  := 'SERIAL DO MEGA  : '+ LerRegistro('Pempec Enterprise', 'Mega', 'SERIAL');
lblOrgPathExeMega.Caption  := 'APP MEGA  : '+ LerRegistro('Pempec Enterprise', 'Mega', 'PATH_MEGA');
lblOrgCodigoMega.Caption  := 'CODIGO EMPRESA MEGA  : '+ LerRegistro('Pempec Enterprise', 'Mega', 'CODIGO_EMPRESA');

 btnRegistrar.Enabled := false;   btnRegistrar.Visible := true; btnRegistrar.Caption := ' Registrado ';


registro := LerRegistro('Pempec Enterprise', 'Finance', 'REGISTER');
  if ((registro = String.Empty) OR (registro = '0')) then begin

    btnRegistrar.Enabled := true;
    btnRegistrar.Caption := ' Registrar ';
    // S� libera o botao para reistrar se no registro nao tiver valor 1

  end;


end;



procedure TFrmBackup.btnGeraLoteClick(Sender: TObject);
var
IdFechamento,idLote,ano  : String;
codEmpresa,lote, loteInicial :Integer;
fechamento :Boolean;
begin
   fechamento := true;



//verifica se existe o lote
      codEmpresa := StrToInt(LerRegistro('Pempec Enterprise', 'Mega', 'CODIGO_EMPRESA'));
      lote :=  StrToInt(edtLote.Text);
      loteInicial := lote;
      dmMegaContabil.VerificaSeExistLote(codEmpresa,lote,ano) ;
      ano  :=  cbxAnoLote.Text;
//      idLote := dmMegaContabil.qryExistLote.FieldByName('ID').AsString;

//verifica se tem ID_ORGANIZACAO Selecionada

if idOrganizacao = '' then begin
    ShowMessage('Ser� preciso selecionar uma Organiza��o antes de prosseguir.');
    fechamento := false;
    Limpatela(Self);
    PageControl1.ActivePage := tbsTabRegistros;


end else begin

    //verifica se tem fechamento apos a data inicial at� 2020 e impede importar
        // recebe o ID EMPRESA e a data incial
        IdFechamento := dmMegaContabil.verificaFechamento(codEmpresa,  DateToStr(dtDataInicial.Date));
      if  not (IdFechamento = String.Empty) then begin
          ShowMessage('Tem fechamndo. N�o ser� poss�vem continuar. Verifique o periodo. ' + IdFechamento);
          fechamento := false;
      end;

      if (dmMegaContabil.lotesRestritos(lote)) then begin
              edtLote.Text := 'LOTE RESTRITO';
              cbxAnoLote.ItemIndex :=0;
              cbxMesLote.ItemIndex :=0;
              idLote := '';
              fechamento := false;
      end else begin
          while dmMegaContabil.VerificaSeExistLote(codEmpresa,lote,ano) do begin
          lote := lote+1;
          if ((lote = 65) OR (lote =75))  then begin
            lote := lote +2;
          end;
          edtLote.Text := IntToStr(lote);
          fechamento := true;
          end;
      end;
        //so permite ate 10 lotes no mes de referencia
      if (lote > (loteInicial+9))  then begin
           ShowMessage('Problemas com o numero do lote.  Verifique!' );
           Limpatela(Self);
           fechamento := false;

      end;
           //se passou pelas validacoes acima,
           //gravar na table CLOTES
           //gravar parte 1 de LOTE_CONTABIL
           //pegar os lancamentos no FINANCE
           //gravar na table CLANCAMENTOS
           //VERIFICAR SE DEU ERRO EM CLOTES_ERROR
           //gravar parte 2 de LOTE_CONTABIL

      if fechamento then begin
         statusExportar(1); //ativa export  com verde
         //verifica se existem historicos sem conta contabil e avisa no label
         if dmExportaFinance.verificaHistoricoSemConta(idOrganizacao) then begin
                lblHistoricoSemConta.Visible := true;
             lblHistoricoSemConta.Caption := 'Existem Hist�ricos sem Conta Cont�bil. Verifique antes de exportar!';
         end;
         //pega o generator da tabela CLOTES
         lblGeneratorID.Caption :=  IntToStr(dmMegaContabil.retornarIDPorTabela('CLOTES'));



         //carrega os TITULOS // preenche dbgrid
         dmOrganizacao.carregarDadosEmpresa(idOrganizacao);
         dmExportaFinance.obterTPProvisionados(idOrganizacao,'ABERTO', dtDataInicial.Date,dtDataFinal.Date,1) ;
         dmRelExportacaoMega.obterTRProvisionados(idOrganizacao,'ABERTO', dtDataInicial.Date,dtDataFinal.Date,1) ;
         btnImprimir.Enabled := true;
       end;

      end;

   {colocar isso dentro de um botao
   o lote contabil sera gravado em duas partes:
   1 - dados basicos obrigatorios.
   2 - estatisticas do que foi exportado.
   PRIMEIRO
   ID_LOTE_CONTABIL = ID criado no generator de CLOTES do MEGA
   ID_ORGANIZADO = ID da ORG selecionada
   LOTE = ano de referencia + o index do combo de mes de referncia + lote

   }

{     if not (idOrganizacao='') then begin
        dmExportaFinance.gravarLoteContabil(lblGeneratorID.Caption,idOrganizacao,cbxAnoLote.Text + cbxMesLote.ItemIndex + edtLote.Text,'EXPORTADO','1','', '','','');
     end;  }

  end ;

procedure TFrmBackup.btnImprimirClick(Sender: TObject);
begin
    if not dbgTitulo.DataSource.DataSet.IsEmpty then begin
            dmRelExportacaoMega.obterTRProvisionados(idOrganizacao,'ABERTO', dtDataInicial.Date,dtDataFinal.Date,1) ;
            dmRelExportacaoMega.exibirRelatorioExportacao;
    end
    else begin
        btnImprimir.Enabled :=false;
        ShowMessage('N�o existem dados para imprimir.');
    end

end;



procedure TFrmBackup.cbxAnoLoteClick(Sender: TObject);
begin

if cbxAnoLote.ItemIndex > 0 then begin
    cbxMesLote.Enabled :=true;
  end else begin
  cbxMesLote.Enabled    :=false;
  edtLote.Enabled       :=false;
  dtDataInicial.Enabled :=false;
  dtDataFinal.Enabled   :=false;
  btnGeraLote.Enabled   :=false;

  end;

end;

procedure TFrmBackup.cbxMesLoteChange(Sender: TObject);
begin

case cbxMesLote.ItemIndex of

      0 : edtLote.Text :='';
      1 : edtLote.Text :=IntToStr(10);
      2 : edtLote.Text :=IntToStr(20);
      3 : edtLote.Text :=IntToStr(30);
      4 : edtLote.Text :=IntToStr(40);
      5 : edtLote.Text :=IntToStr(50);
      6 : edtLote.Text :=IntToStr(60);
      7 : edtLote.Text :=IntToStr(70);
      8 : edtLote.Text :=IntToStr(80);
      9 : edtLote.Text :=IntToStr(90);
      10 : edtLote.Text :=IntToStr(100);
      11 : edtLote.Text :=IntToStr(110);
      12 : edtLote.Text :=IntToStr(120);
end;

  if cbxMesLote.ItemIndex > 0 then begin
    dtDataInicial.Enabled :=true;
      btnGeraLote.Enabled :=true;
  end else begin
  edtLote.Enabled :=false;
  btnGeraLote.Enabled :=false;

  end;
end;



procedure TFrmBackup.dbgHistoricoCellClick(Column: TColumn);
var
total :Currency;
begin



end;


procedure TFrmBackup.dtsTituloPagarDataChange(Sender: TObject; Field: TField);
begin
//carrega os historicos
dmExportaFinance.qryObterTPHistoricoPorTitulo.Close;
dmExportaFinance.qryObterTPHistoricoPorTitulo.ParamByName('pId_TITULO_PAGAR').AsString := dmExportaFinance.qryTitulosProvisionados.FieldByName('ID_TITULO_PAGAR').AsString;
dmExportaFinance.qryObterTPHistoricoPorTitulo.ParamByName('pIdOrganizacao').AsString :=dmExportaFinance.qryTitulosProvisionados.FieldByName('ID_ORGANIZACAO').AsString;
dmExportaFinance.qryObterTPHistoricoPorTitulo.Open();

//carrega os centros de custos .. sv jrg

dmExportaFinance.qryObterCentroCustoPorTitulo.Close;
dmExportaFinance.qryObterCentroCustoPorTitulo.ParamByName('pId_TITULO_PAGAR').AsString := dmExportaFinance.qryTitulosProvisionados.FieldByName('ID_TITULO_PAGAR').AsString;
dmExportaFinance.qryObterCentroCustoPorTitulo.ParamByName('pIdOrganizacao').AsString := dmExportaFinance.qryTitulosProvisionados.FieldByName('ID_ORGANIZACAO').AsString;
dmExportaFinance.qryObterCentroCustoPorTitulo.Open();

end;

procedure TFrmBackup.dtsTituloReceberDataChange(Sender: TObject; Field: TField);
var
idCCNotExist :Boolean;

begin
//carrega os historicos
dmRelExportacaoMega.qryHistoricoTR.Close;
dmRelExportacaoMega.qryHistoricoTR.ParamByName('pId_TITULO_RECEBER').AsString := dmRelExportacaoMega.qryTRProvisionados.FieldByName('ID_TITULO_RECEBER').AsString;
dmRelExportacaoMega.qryHistoricoTR.ParamByName('pIdOrganizacao').AsString :=dmRelExportacaoMega.qryTRProvisionados.FieldByName('ID_ORGANIZACAO').AsString;
dmRelExportacaoMega.qryHistoricoTR.Open();

//carrega os centros de custos .. sv jrg

dmRelExportacaoMega.qryCentroCustoTR.Close;
dmRelExportacaoMega.qryCentroCustoTR.ParamByName('pId_TITULO_RECEBER').AsString := dmRelExportacaoMega.qryTRProvisionados.FieldByName('ID_TITULO_RECEBER').AsString;
dmRelExportacaoMega.qryCentroCustoTR.ParamByName('pIdOrganizacao').AsString := dmRelExportacaoMega.qryTRProvisionados.FieldByName('ID_ORGANIZACAO').AsString;
dmRelExportacaoMega.qryCentroCustoTR.Open();

end;

procedure TFrmBackup.edtDestinoUmChange(Sender: TObject);
begin
  destinoUm := edtDestinoUm.Text;
end;

procedure TFrmBackup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Limpatela(Self);
    FinalDM(); //desvincula os DMs


  Action := caFree;  //sempre como ultimo comando


end;

procedure TFrmBackup.preencheDadosHost(Sender: TObject);
begin
  conta     := LerRegistro('Pempec Enterprise', 'Host', 'conta');
  senha     := LerRegistro('Pempec Enterprise', 'Host', 'senha');
  host      := LerRegistro('Pempec Enterprise', 'Host', 'host');
  porta     := LerRegistro('Pempec Enterprise', 'Host', 'porta');
  autentica := LerRegistro('Pempec Enterprise', 'Host', 'autentica');

  edtHost.Text := host;
  edtUser.Text := conta;
  edtPorta.Text := porta;
  edtPassword.Text := senha;
  edtDestinoUm.Text := LerRegistro('Pempec Enterprise', 'Host', 'destinoUm');

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
  {Instanciando o objeto dmConexao}
  InitDM();

  Limpatela(Self);
  preencheDadosHost(Self);
  Versao := 'V. 2.0 - 1609';
  Path_Bd := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD');
  edtOrigem.Text := Path_Bd;
  hora := FormatDateTime('hhmmss', Now());
  data := FormatDateTime('ddmmyyyy', Now());
  btnExportar.Enabled :=false;
  btnCheckExport.Enabled :=false;



  //IpExterno();


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

  if not Assigned(frmLogin) then begin
      frmLogin := TfrmLogin.Create(Self);
      //frmLogin.ShowModal;

     // FreeAndNil(frmLogin);//destruindo o form login

  end



end;

procedure TFrmBackup.Limpatela(Sender: TObject);
begin
  PageControl1.ActivePage := tbsBackup;
  lblAviso.Visible := False;
  btnRestore.Enabled := False;
  btnBackup.Enabled := True;
  btnBackup.Visible := True;
  StatusBar1.Panels[1].Text := 'Manuten�ao do Banco de Dados' +   ' iniciado em : ' + FormatDateTime('dd/mm/yyyy', Now()) + ' �s ' + FormatDateTime('hh:mm:ss', Now());
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
  lblGeneratorID.Visible :=false; //lbl na sheet de importacao. tem o novo ID //Apos btn  Confirma
  cbxMesLote.Enabled :=false;
  edtLote.Enabled :=false;
//  dtDataInicial.Enabled :=false;
  //dtDataFinal.Enabled :=false;
  btnGeraLote.Enabled :=false;
  btnImprimir.Enabled :=false;
  lblHistoricoSemConta.Visible :=false;

  statusExportar(0); //ativa export

  LimpaTabSheetRegistros(self);



end;

//limpa os campos da tabsheet Registros

procedure TFrmBackup.LimpaTabSheetRegistros(Sender: TObject);
begin

lblOrgCodinome.Caption := '';
lblOrgSerial.Caption   := '';
lblOrgLicenca.Caption  := '';
lblOrgSistema.Caption  := '';
lblOrgCnpj.Caption  := '';
lblOrgIpServerBD.Caption  := '';
lblOrgPathMega.Caption  := '';
lblOrgSerialMega.Caption  := '';
lblOrgPathExeMega.Caption  := '';
lblOrgCodigoMega.Caption :='';
lblOrgSistema.Caption :='';
 cbxMesLote.ItemIndex :=0;
 cbxAnoLote.ItemIndex :=0;

end;

procedure TFrmBackup.tabExportShow(Sender: TObject);
var
database, user, password, porta, host: String;

begin
lblPrincipal.Caption := 'EXPORTA��O DE DADOS';

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
     if uUtil.PastaExist(LerRegistro('Pempec Enterprise', 'Finance',
      'PATH_SERVER') ) then


    begin
      if uUtil.ArquivoExist(database) then
      begin
             dmConexao.conectarBanco;

      end;

      if not dmConexao.Conn.Ping then  begin
             Memo1.Lines.Add('O Banco de Dados n�o est� conectado.') ;
             btnExportar.Enabled := false;

      end;


    end
    else
    begin
      raise Exception.Create
        ('O Caminho do banco de dados parece estar incorreto.');
    end;

  except
    raise Exception.Create(' ERRO 1 DE REGISTRO. REGISTRE OS SISTEMAS!');
    Memo1.Clear;
    Memo1.Lines.Add('O Banco de Dados n�o est� conectado.') ;
    btnExportar.Enabled := false;

  end;




end;

procedure TFrmBackup.tbAgendaShow(Sender: TObject);
begin
lblPrincipal.Caption := ' CONFIGURA��O DO AGENDAMENTO  ';
end;

procedure TFrmBackup.tbConfigShow(Sender: TObject);
begin
lblPrincipal.Caption := ' CONFIGURA��O SERVIDOR DE EMAIL.  ';
end;

procedure TFrmBackup.tbRelatoriosShow(Sender: TObject);
begin
  Label3.Visible := True;
  lblPrincipal.Caption := ' RELAT�RIOS   ';
end;

procedure TFrmBackup.tbsBackupShow(Sender: TObject);
begin
  lblPrincipal.Caption := ' BACKUP DA BASE DE DADOS  ';
  Label3.Caption := '';
  Label3.Visible := False;
end;

procedure TFrmBackup.tbsImportShow(Sender: TObject);
begin
  Label3.Visible := True;
  lblIdOrganizacao.Visible := True;

  lblPrincipal.Caption := ' IMPORTAR BASE DE DADOS   ';
  cbxAnoLote.ItemIndex :=0;
  cbxMesLote.ItemIndex := 0;
if  not (idOrganizacao = '') then begin
    lblIdOrganizacao.Caption := idOrganizacao;
      lblIdOrganizacao.Visible := false;
end else begin lblIdOrganizacao.Caption := 'Nenhuma Empresa Selecionada'; end;

   if not (dmConexao.ConnMega.Connected) then begin
           dmConexao.conectarMega;
   end;

   if( dmConexao.ConnMega.Ping) then begin
       lblStatusSistemaContabil.Caption := 'Sistema Cont�bil:  Mega Cont�bil ' + 'Base de dados conectada com sucesso!';
       Label1.Caption := 'Base de dados do MEGA CONT�BIL conectada com sucesso!';


   end else begin lblStatusSistemaContabil.Caption := 'Sistema Cont�bil N�o localizado';

   end;



end;

procedure TFrmBackup.tbsRestoreShow(Sender: TObject);
begin
  Label3.Visible := True;
  lblPrincipal.Caption := ' RESTAURAR BASE DE DADOS  ';
end;


 procedure TFrmBackup.preencherListaOrganizacoes;
  begin

  FsListaIdOrganizacoes := TStringList.Create;
  FsListaIdOrganizacoes.Clear;
  cbxOrganizacoes.Clear;
  dmOrganizacao.qryOrganizacoes.First;
  while not dmOrganizacao.qryOrganizacoes.Eof do begin
    cbxOrganizacoes.Items.Add(dmOrganizacao.qryOrganizacoes.FieldByName('NOME'          ).AsString);
    FsListaIdOrganizacoes.Add(dmOrganizacao.qryOrganizacoes.FieldByName('ID_ORGANIZACAO').AsString);
    dmOrganizacao.qryOrganizacoes.Next;
  end;
  dmOrganizacao.qryOrganizacoes.Close;
  cbxOrganizacoes.ItemIndex := 0;
end;



procedure TFrmBackup.tbsTabRegistrosShow(Sender: TObject);
begin
  Label1.Caption := 'Registrar Sistemas.';
  Label3.Visible := True;
  lblPrincipal.Caption := ' REGISTRAR SISTEMAS  ';
  btnRegistrar.Visible := false;
  LimpaTabSheetRegistros(Self);


  if not (dmConexao.Conn.Connected) then begin
          dmConexao.conectarBanco;
  end;

  if not (dmConexao.Conn.Ping) then begin
    ShowMessage('O banco de dados n�o foi conectado!');
  end
  else
    begin
  // carrega os dados das organizacoes para ser escolhida para registro
    if not Assigned(dmOrganizacao) then begin
      dmOrganizacao := TdmOrganizacao.Create(Self);
    end;

    if dmOrganizacao.carregarOrganizacoes then begin
          preencherListaOrganizacoes;
      end;


    end;

    //acesso ao mega

     if not (dmConexao.ConnMega.Connected) then begin
           dmConexao.conectarMega;
      end;



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

{ Fun��o para retornar o conte�do de um determinado registro }

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
        label1.Caption := 'Seu ip � : ' + IPExterno;
     end else begin label1.Caption := ' IP n�o atribu�do... '; end;

      ipReal := IPExterno;

end;


procedure TFrmBackup.FinalDM();
begin


  if (Assigned(dmConexao)) then begin
    FreeAndNil(dmConexao);
  end;

  if (Assigned(dmOrganizacao)) then begin
      FreeAndNil(dmOrganizacao) ;
  end;

  if (Assigned(dmMegaContabil)) then begin
      FreeAndNil(dmMegaContabil) ;
  end;

  if (Assigned(dmExportaFinance)) then begin
      FreeAndNil(dmExportaFinance);
  end;


  if (Assigned(dmContasPagar)) then begin
          FreeAndNil(dmContasPagar);
  end;

  if (Assigned(dmRelExportacaoMega)) then begin
         FreeAndNil(dmRelExportacaoMega);
  end;



end;

procedure TFrmBackup.statusExportar(sinal :Integer);
begin

// So ativa o sinal verde
if sinal = 1 then begin
  imgGreen.Visible := true;
  imgGreen.Top := 50;
  imgRed.Visible := false;
  imgRed.Top := 50;
end;

// So 10ativa o sinal verde
if sinal = 0 then begin
  imgGreen.Visible := false;
  imgGreen.Top := 50;
  imgRed.Visible := true;
  imgRed.Top := 50;
end;


end;

procedure TFrmBackup.InitDM();
   begin

      if not(Assigned(dmConexao)) then begin
             dmConexao := TdmConexao.Create(Self);
      end;

      if not(Assigned(dmOrganizacao)) then begin
             dmOrganizacao := TdmOrganizacao.Create(Self);
      end;

      if not(Assigned(dmMegaContabil)) then begin
             dmMegaContabil := TdmMegaContabil.Create(Self);
      end;

      
       if not(Assigned(dmContasPagar)) then begin
             dmContasPagar := TdmContasPagar.Create(Self);
      end;

      if not(Assigned(dmRelExportacaoMega)) then begin
             dmRelExportacaoMega := TdmRelExportacaoMega.Create(Self);
      end;

      if not(Assigned(dmExportaFinance)) then begin
            dmExportaFinance := TdmExportaFinance.Create(nil);
      end;

  end;


end.