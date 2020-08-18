unit uFrmRegistro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uDMOrganizacao, udmConexao, uDMMegaContabil, uUtil, uOrganizacaoModel, uOrganizacaoDAO,
  Vcl.StdCtrls, Vcl.Buttons, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP,IdSSLOpenSSL, EMsgDlg;

type
  TfrmRegistro = class(TForm)
    btnSelect: TButton;
    btnRegistrar: TButton;
    cbxOrganizacoes: TComboBox;
    edtCnpj: TEdit;
    edtCodinome: TEdit;
    edtIpServerBD: TEdit;
    edtLicenca: TEdit;
    edtSerialCliente: TEdit;
    edtSistemaContabil: TEdit;
    edtPathBdMega: TEdit;
    edtSerialMega: TEdit;
    edtPathMega: TEdit;
    edtCodigoMega: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    lblPrincipal: TLabel;
    lblSistRegistrado: TLabel;
    btnValidarLicenca: TButton;
    btnFechar: TBitBtn;
    btnVersao: TButton;
    lblVersao: TLabel;
    IdHTTP1: TIdHTTP;
    PempecMsg: TEvMsgDlg;
    procedure FormCreate(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnRegistrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnValidarLicencaClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnVersaoClick(Sender: TObject);
  private
    { Private declarations }

    FsListaIdOrganizacoes: TStringList;
    procedure preencherListaOrganizacoes;
    function verificaConectarBanco(): Boolean;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);

  public
    { Public declarations }
  end;

var
  frmRegistro: TfrmRegistro;

implementation

{$R *.dfm}

procedure TfrmRegistro.btnFecharClick(Sender: TObject);
begin
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmRegistro.btnRegistrarClick(Sender: TObject);
var
  registro, porta_bd, database, path_server, serial, serialMega: string;
 org :  TOrganizacaoModel;
begin
  org :=  TOrganizacaoModel.Create;

  serial := '0';
  serialMega := '1';
  path_server := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_SERVER');
  database := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD');
  porta_bd := LerRegistro('Pempec Enterprise', 'Finance', 'PORTA_BD');

  // Caminho do finance
  if not(path_server = String.Empty) then
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_SERVER', path_server);
  end
  else
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_SERVER',
      'c:\finance\');
  end;

  // Caminho do banco de dados
  if not(database = String.Empty) then
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_BD', database);
  end
  else
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_BD',
      'c:\finance\dados\finance.fdb');
  end;

  // Porta para acesso ao banco de dados
  if not(porta_bd = String.Empty) then
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PORTA_BD', porta_bd);
  end
  else
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PORTA_BD', '3051');
  end;

  GravarRegistros('Pempec Enterprise', 'Finance', 'AgendaBackup', '22:00:00');
  GravarRegistros('Pempec Enterprise', 'Finance', 'HostWeb', '1');
  GravarRegistros('Pempec Enterprise', 'Finance', 'LastFile', '1');
  GravarRegistros('Pempec Enterprise', 'Finance', 'LastFileDate', '1');
  GravarRegistros('Pempec Enterprise', 'Finance', 'PasswordWeb', 'hf3810');
  GravarRegistros('Pempec Enterprise', 'Finance', 'IPSERVERBD',
    edtIpServerBD.Text);
  GravarRegistros('Pempec Enterprise', 'Finance', 'HOST_IP', '127.0.0.1');
  GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_BD_BKP',
    'c:\finance\dados\bkp\');
  GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_ERRO',
    'c:\finance\dados\exception');
  GravarRegistros('Pempec Enterprise', 'Finance', 'PathUpdate', '127.0.0.1');
  GravarRegistros('Pempec Enterprise', 'Finance', 'PathWeb', '127.0.0.1');
  GravarRegistros('Pempec Enterprise', 'Finance', 'SerialNumber',
    edtSerialCliente.Text);
  GravarRegistros('Pempec Enterprise', 'Finance', 'UserNameWeb', '127.0.0.1');
  GravarRegistros('Pempec Enterprise', 'Finance', 'REGISTER', '1');
  // 1 =registrado / 0= nao registrado

  // mega
  GravarRegistros('Pempec Enterprise', 'Mega', 'PATH_BD', edtPathBdMega.Text);
  GravarRegistros('Pempec Enterprise', 'Mega', 'PATH_MEGA', edtPathMega.Text);
  GravarRegistros('Pempec Enterprise', 'Mega', 'SERIAL', edtSerialMega.Text);
  GravarRegistros('Pempec Enterprise', 'Mega', 'CODIGO_EMPRESA', '1');

  registro := LerRegistro('Pempec Enterprise', 'Finance', 'REGISTER');
  if (registro = '1') then
  begin
    ShowMessage('Sistema registrado com sucesso!');
  end;

end;



procedure TfrmRegistro.btnSelectClick(Sender: TObject);
var
  idOrganizacao, registro, idMega, cnpj, pid: string;

  org :  TOrganizacaoModel;
begin
  org :=  TOrganizacaoModel.Create;

  idMega := '0';
  registro := '0';
  dmConexao.conectarBanco;


  if (cbxOrganizacoes.ItemIndex > (-1)) then
  begin
    pid := FsListaIdOrganizacoes[cbxOrganizacoes.ItemIndex];
    org.FID := pid;
    org := TOrganizacaoDAO.obterPorID(org);
    lblVersao.Caption :=org.FVersao;


    dmOrganizacao.carregarDadosOrganizacao(pid);
    // Vai no mega pegar o ID dessa empresa selecionada. Passando CNPJ como parametro
    cnpj := dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString;
    cnpj := StringReplace(cnpj, '''', '', []);
    idOrganizacao := dmOrganizacao.qryDadosEmpresa.FieldByName('ID_ORGANIZACAO').AsString;

    //dados do sistema contabil
    dmMegaContabil.carregarDadosEmpresaMega(cnpj); // inscmf = cnpj
    // verifica se o banco do mega retornou o codigo e seta no registro
    idMega := dmMegaContabil.qryDadosEmpresaMega.FieldByName('ID').AsString;

  end;

  if not(idMega = String.Empty) then
  begin
    idMega := StringReplace(idMega, '''', '', []);
    GravarRegistros('Pempec Enterprise', 'Mega', 'CODIGO_EMPRESA', idMega);
  end;

  edtCodinome.Text := dmOrganizacao.qryDadosEmpresa.FieldByName
    ('CODINOME').AsString;
  edtSerialCliente.Text := dmOrganizacao.qryDadosEmpresa.FieldByName
    ('SERIAL_CLIENTE').AsString;
  edtLicenca.Text := dmOrganizacao.qryDadosEmpresa.FieldByName
    ('LICENCA').AsString;
  edtSistemaContabil.Text := dmOrganizacao.qryDadosEmpresa.FieldByName
    ('SISTEMA_CONTABIL').AsString;
  edtCnpj.Text := dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString;
  edtIpServerBD.Text := dmOrganizacao.qryDadosEmpresa.FieldByName
    ('IPSERVERBD').AsString;
  edtPathBdMega.Text := LerRegistro('Pempec Enterprise', 'Mega', 'PATH_BD');
  edtSerialMega.Text := LerRegistro('Pempec Enterprise', 'Mega', 'SERIAL');
  edtPathMega.Text := LerRegistro('Pempec Enterprise', 'Mega', 'PATH_MEGA');
  edtCodigoMega.Text := LerRegistro('Pempec Enterprise', 'Mega',
    'CODIGO_EMPRESA');

  btnRegistrar.Enabled := false;
  btnRegistrar.Visible := true;
  btnRegistrar.Caption := ' Registrado ';
  lblSistRegistrado.Caption := 'Sistema Registrado.';

  registro := LerRegistro('Pempec Enterprise', 'Finance', 'REGISTER');
  if ((registro = String.Empty) OR (registro = '0')) then
  begin
    btnRegistrar.Enabled := true;
    btnRegistrar.Caption := ' Registrar ';
    // Só libera o botao para reistrar se no registro nao tiver valor 1
    lblSistRegistrado.Caption := 'Não Registrado!';
  end;

end;

procedure TfrmRegistro.btnValidarLicencaClick(Sender: TObject);
     // validação consiste apenas em criar no regedit os campos
var
msgValida,  registro, porta_bd, database, path_server, serial, serialMega: string;

pSite, pString, sep, tk,codi,insc,lic, serhd, sercli, respostaSite : string;
Id_HandlerSocket : TIdSSLIOHandlerSocketOpenSSL;

 begin

  sep     := '@';
  tk      := uutil.TOrgAtual.getOrganizacao.FSERIAL_HD+sep;
  codi    := uutil.TOrgAtual.getOrganizacao.FCODINOME+ sep;
  insc    := uutil.TOrgAtual.getOrganizacao.FCNPJ + sep;
  lic     := uutil.TOrgAtual.getOrganizacao.FLICENCA + sep;
  serhd   := uutil.TOrgAtual.getOrganizacao.FSERIAL_HD+sep;
  sercli  := uutil.TOrgAtual.getOrganizacao.FSERIAL_CLIENTE;

  pString := tk+codi+insc+lic;
  pSite := 'https://pempec.com.br/validator/?entrada='+pString;


  if uUtil.IsInternetConected then
  begin
   try
    try

      IdHTTP1.Request.BasicAuthentication := False;
      IdHTTP1.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';
      Id_HandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create( IdHTTP1 );
      Id_HandlerSocket.SSLOptions.Mode := sslmClient;
      Id_HandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdHTTP1.IOHandler := Id_HandlerSocket;


      respostaSite := IdHTTP1.Get(pSite);

    except
      respostaSite := '0';

    end;

   finally

      FreeAndNil(IdHTTP1);

   end;

  end;

  msgValida := 'Não foi possível validar essa cópia.';

  if respostaSite = '1@'+uutil.TOrgAtual.getOrganizacao.FCODINOME then begin

       msgValida := 'Sistema validado para uso por : ' + #13 + uutil.TOrgAtual.getOrganizacao.FRazaoSocial + #13 + 'CNPJ '+ uutil.TOrgAtual.getOrganizacao.FCNPJ;

  end;

  PempecMsg.MsgWarning(msgValida);


  serial := '0';
  serialMega := '1';
  path_server := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_SERVER');
  database := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD');
  porta_bd := LerRegistro('Pempec Enterprise', 'Finance', 'PORTA_BD');

  // Caminho do finance
  if not(path_server = String.Empty) then
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_SERVER', path_server);
  end
  else
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_SERVER',
      'c:\finance\');
  end;

  // Caminho do banco de dados
  if not(database = String.Empty) then
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_BD', database);
  end
  else
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_BD',
      'c:\finance\dados\finance.fdb');
  end;

  // Porta para acesso ao banco de dados
  if not(porta_bd = String.Empty) then
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PORTA_BD', porta_bd);
  end
  else
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PORTA_BD', '3051');
  end;

  GravarRegistros('Pempec Enterprise', 'Finance', 'AgendaBackup', '22:00:00');
  GravarRegistros('Pempec Enterprise', 'Finance', 'HostWeb', '1');
  GravarRegistros('Pempec Enterprise', 'Finance', 'LastFile', '1');
  GravarRegistros('Pempec Enterprise', 'Finance', 'LastFileDate', '1');
  GravarRegistros('Pempec Enterprise', 'Finance', 'PasswordWeb', 'hf3810');
  GravarRegistros('Pempec Enterprise', 'Finance', 'IPSERVERBD',
    edtIpServerBD.Text);
  GravarRegistros('Pempec Enterprise', 'Finance', 'HOST_IP', '127.0.0.1');
  GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_BD_BKP',
    'c:\finance\dados\bkp\');
  GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_ERRO',
    'c:\finance\dados\exception');
  GravarRegistros('Pempec Enterprise', 'Finance', 'PathUpdate', '127.0.0.1');
  GravarRegistros('Pempec Enterprise', 'Finance', 'PathWeb', '127.0.0.1');
  GravarRegistros('Pempec Enterprise', 'Finance', 'SerialNumber',
    edtSerialCliente.Text);
  GravarRegistros('Pempec Enterprise', 'Finance', 'UserNameWeb', '127.0.0.1');
  GravarRegistros('Pempec Enterprise', 'Finance', 'REGISTER', '1');
  // 1 =registrado / 0= nao registrado

  // mega
  GravarRegistros('Pempec Enterprise', 'Mega', 'PATH_BD', edtPathBdMega.Text);
  GravarRegistros('Pempec Enterprise', 'Mega', 'PATH_MEGA', edtPathMega.Text);
  GravarRegistros('Pempec Enterprise', 'Mega', 'SERIAL', edtSerialMega.Text);
  GravarRegistros('Pempec Enterprise', 'Mega', 'CODIGO_EMPRESA', '0');

  registro := LerRegistro('Pempec Enterprise', 'Finance', 'REGISTER');
  if (registro = '0') then
  begin
   // ShowMessage('Sistema registrado com sucesso!');
  end;


   btnVersao.Enabled := False;
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);


end;




procedure TfrmRegistro.btnVersaoClick(Sender: TObject);
var
org : TOrganizacaoModel;
msgFinal :string;
Id_HandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
begin
 dmConexao.conectarBanco;
 msgFinal := 'Você não tem permissão para essa funcionalidade. Procure o suporte e solicite orientações.';
 org := TOrganizacaoModel.Create;
 org.FID := uutil.TOrgAtual.getId;
 org := TOrganizacaoDAO.obterPorID(org);
 org.FVersao := GetVersionInfo(Application.ExeName);

  if TOrganizacaoDAO.ajustarVersao(org) then
  begin

    if uUtil.IsInternetConected then
    begin
     if not Assigned(IdHTTP1) then begin   IdHTTP1.Create(Self);  end;

      IdHTTP1.Request.BasicAuthentication := False;
      IdHTTP1.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';
      Id_HandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create( IdHTTP1 );
      Id_HandlerSocket.SSLOptions.Mode := sslmClient;
      Id_HandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdHTTP1.IOHandler := Id_HandlerSocket;

      if edtIpServerBD.Text = '192.168.15.200' then
      begin
        IdHTTP1.Get('https://pempec.com.br/validator/inserirversao.php?versao=FNC@' + org.FVersao);
        msgFinal := 'Versão alterada com sucesso.';


      end;

    end;

  end;

  if Assigned(IdHTTP1) then begin   FreeAndNil(IdHTTP1) end;
    btnVersao.Enabled := False;
   PempecMsg.MsgWarning(msgFinal);
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);


end;

function TfrmRegistro.verificaConectarBanco(): Boolean;
var
  msg: String;
  conectado: Boolean;
begin
  msg := sLineBreak + 'Banco de dados não conectado.!';
  conectado := false;
  try
     if not(Assigned(dmConexao)) then
        begin
        dmConexao := TdmConexao.Create(Self);
        dmConexao.conectarBanco;
      end;

  except
    on e: Exception do
      raise Exception.Create(e.Message + msg);
  end;

  try
    msg := sLineBreak + 'Banco de dados FINANCE não conectado.!';
    if not(dmConexao.Conn.Connected) then
    begin
      if dmConexao.conectarBanco then
      begin
        conectado := true;
      end;
    end;
  except
    on e: Exception do
      raise Exception.Create(e.Message + msg);
  end;


  Result := conectado;
end;

procedure TfrmRegistro.inicializarDM(Sender: TObject);
begin

  if not(Assigned(dmConexao)) then
     begin
      dmConexao := TdmConexao.Create(Self);
     end;

  if not(Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;

  if not(Assigned(dmMegaContabil)) then
  begin
    dmMegaContabil := TdmMegaContabil.Create(Self);
  end;

  dmConexao.conectarBanco;

end;

procedure TfrmRegistro.freeAndNilDM(Sender: TObject);
begin

  if (Assigned(dmMegaContabil)) then
  begin
    FreeAndNil(dmMegaContabil);
  end;

end;

procedure TfrmRegistro.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  LimpaTela(Self);
  freeAndNilDM(Self);
  Action := caFree; // sempre como ultimo comando

end;

procedure TfrmRegistro.FormCreate(Sender: TObject);
begin
//  LimpaTela(Self);
  inicializarDM(Self);
  lblPrincipal.Caption := ' REGISTRAR O SISTEMA ';
  // verifica e conecta com o banco desejado para esse form
  try
    if dmOrganizacao.carregarOrganizacoes then
    begin
      if (dmConexao.conectarBanco) then begin
          preencherListaOrganizacoes;
      end;

    end;
  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak +
        'Não foi possível carregar a lista de organizações.!');
  end;
  // informa se o sistema está registrado.
  lblSistRegistrado.Caption := '';

end;

procedure TfrmRegistro.preencherListaOrganizacoes;
begin
  FsListaIdOrganizacoes := TStringList.Create;
  FsListaIdOrganizacoes.Clear;
  cbxOrganizacoes.Clear;
  dmOrganizacao.qryOrganizacoes.First;
  while not dmOrganizacao.qryOrganizacoes.Eof do
  begin
    cbxOrganizacoes.Items.Add(dmOrganizacao.qryOrganizacoes.FieldByName('NOME')
      .AsString);
    FsListaIdOrganizacoes.Add(dmOrganizacao.qryOrganizacoes.FieldByName
      ('ID_ORGANIZACAO').AsString);
    dmOrganizacao.qryOrganizacoes.Next;
  end;
  dmOrganizacao.qryOrganizacoes.Close;
  cbxOrganizacoes.ItemIndex := 0;
end;

end.
