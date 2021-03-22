unit uUtil;

interface

uses
  Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent, IdIPWatch,
  System.SysUtils, Windows, Registry, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Error,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, uCriptografia, uMensagens,
  System.Classes, Printers, wininet, Winsock, IdSSL, IdSSLOpenSSL, IdMessage,
  IdAttachmentFile, StdCtrls, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, uVarGlobais,
  IdTCPConnection, IdSMTP, Vcl.Graphics, jpeg;

function GetIp(): String;
function GetLicenca(): String;
function LerRegistro(xArquivo, xSection, xIdent: String): String;
procedure GravarRegistros(xArquivo, xSection, xIdent, xValue: String);
Function GetMacAddress(): String;
Function FinanceRegister(xOrg, xControle: String): Boolean;
function ConverterStringToHex(S: String): String;
function ConverterHexToString(H: String): String;
function GeraControleLicenca(xRazao, xCodinome, xLicenca,
  xData: String): String;
Function GetIPAddress(): String;
FUNCTION CapturaTelaForm(Sender: TForm; NameFile: String): TJPEGImage;
function obterSubChavesRegistro(xChave: String): TStringList;
function GeraSenhaHex(Digitos: Integer; Min, Mai, Num: Boolean): string;
function DecimalToBase(ID, b: Integer): string;
Function NomeComputador: String;
function GetNetStation(Tipo: Integer): string;
function CorrentPrinter: String;
Function ConnectionKind: Boolean;
function DetectaDrv(const drive: char): Boolean;
function GetSerialMotherBoard: String;
function GetComputerNetName: String;
function GetUserFromWindows: string;
procedure EnviarEmailGen(Origem, Msg, Assunto, Dest1, Dest2, Anexo: String);
Function GeraNameFileJPG(): String;
Function obterInstalacaoFinance(Propriedade: String): TStringList;
function getFileSize(Arquivo: string): Integer;
function PastaExist(pasta :String):Boolean;
function ArquivoExist(arq :String):Boolean;
function FormataCNPJ(CNPJ: string): string;



implementation

Function GeraNameFileJPG(): String;
var
  Data, hora, NameFile, pathServer: String;

begin
  Data := FormatDateTime('dd_mm_yyyy', now);
  hora := FormatDateTime('hh_mm_ss', now);

  pathServer := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_ERRO');

  if (pathServer = String.Empty) then
  begin
    pathServer := ExtractFilePath(Application.ExeName) + 'img\';
  end;

  if not DirectoryExists(pathServer) then
  begin
  try
    CreateDir(pathServer);
    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_ERRO',pathServer);
  Except
  raise Exception.Create('Erro ao criar pasta pata imagens. Contate o suporte.');
  end;

  end;

  NameFile := pathServer + 'FIN_PICT_' + Data + '-' + hora + '.jpg';
  Result := NameFile;

end;

FUNCTION CapturaTelaForm(Sender: TForm; NameFile: String): TJPEGImage;
var
  hTela: HDC;
  oBmp: TBitmap;

begin
  oBmp := TBitmap.Create;
  Result := TJPEGImage.Create;
  try
    with oBmp do
    begin
      oBmp := Sender.GetFormImage;
    end;
    with Result do
    begin
      CompressionQuality := 30;
      Assign(oBmp);
      Compress;
      Result.SaveToFile(NameFile);
    end;
  finally
    oBmp.Free;
  end;

end;

function GetLicenca(): String;
var
  licenca: String;
begin
  licenca := '00000';

  licenca := uCriptografia.DesCriptografa(LerRegistro('Pempec Enterprise',
    'Finance', 'SerialNumber'), 128);

  Result := licenca;

end;

{ Procedure para criar um determinado valor no registro }

procedure GravarRegistros(xArquivo, xSection, xIdent, xValue: String);

var
  ArqReg: TRegIniFile;

begin

  ArqReg := TRegIniFile.Create(xArquivo);
  ArqReg.rootkey := HKEY_CURRENT_USER;

  Try

    ArqReg.WriteString(xSection, xIdent, xValue);

  Finally
    ArqReg.Free;

  end;

end;

{ Fun��o para retornar o conte�do de um determinado registro }

function LerRegistro(xArquivo, xSection, xIdent: String): String;
// mudado em 20/04 add HKEY_CURRENT_USER
var
  ArqReg: TRegIniFile;
begin

  ArqReg := TRegIniFile.Create(xArquivo);
  ArqReg.rootkey := HKEY_CURRENT_USER;
  Try

    Result := ArqReg.ReadString(xSection, xIdent, '');

  Finally

    ArqReg.Free;

  end;

end;

// Funcao para capturar o endere�o Mac da pl rede

Function GetMacAddress(): string;
var
  Lib: Cardinal;
  Func: function(GUID: PGUID): Longint; stdcall;
  GUID1, GUID2: TGUID;

begin
  Result := '';
  Lib := LoadLibrary('rpcrt4.dll');
  if Lib <> 0 then
  begin
    @Func := GetProcAddress(Lib, 'UuidCreateSequential');
    if Assigned(Func) then
    begin
      if (Func(@GUID1) = 0) and (Func(@GUID2) = 0) and
        (GUID1.D4[2] = GUID2.D4[2]) and (GUID1.D4[3] = GUID2.D4[3]) and
        (GUID1.D4[4] = GUID2.D4[4]) and (GUID1.D4[5] = GUID2.D4[5]) and
        (GUID1.D4[6] = GUID2.D4[6]) and (GUID1.D4[7] = GUID2.D4[7]) then
      begin
        Result := IntToHex(GUID1.D4[2], 2) + '-' + IntToHex(GUID1.D4[3], 2) +
          '-' + IntToHex(GUID1.D4[4], 2) + '-' + IntToHex(GUID1.D4[5], 2) + '-'
          + IntToHex(GUID1.D4[6], 2) + '-' + IntToHex(GUID1.D4[7], 2);
      end;
    end;
  end;
end;

// utilidades encontradas na www
{ B�sicamente essa Fun��o vai Gerar um C�digo aleat�rio,
  com a quantidade de d�gitos definidos atrav�z da vari�vel "Digitos",
  contendo ou n�o letras mai�sculas, min�sculas ou numeros,
  voc� pode tamb�m acrescentar mais letras ou at� caracteres especiais a fun��o. }
function GeraSenhaHex(Digitos: Integer; Min: Boolean; Mai: Boolean;
  Num: Boolean): string;
const
  MinC = 'abcdef';
  MaiC = 'ABCDEF';
  NumC = '1234567890';
var
  p, q: Integer;
  char, Senha: String;
begin
  char := '';
  If Min then
    char := char + MinC;
  If Mai then
    char := char + MaiC;
  If Num then
    char := char + NumC;
  for p := 1 to Digitos do
  begin
    Randomize;
    q := Random(Length(char)) + 1;
    Senha := Senha + char[q];
  end;
  Result := Senha;
end;

function ConverterStringToHex(S: String): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(S) do
    Result := Result + IntToHex(ord(S[I]), 2);
end;

function ConverterHexToString(H: String): String;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(H) div 2 do
    Result := Result + char(StrToInt('$' + Copy(H, (I - 1) * 2 + 1, 2)));
end;

//
// Transforma um valor decimal em uma base qualquer especificada em b
//

function DecimalToBase(ID: Integer; b: Integer): string;

const
  Trans: array [0 .. 35] of char = ('0', '1', '2', '3', '4', '5', '6', '7', '8',
    '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
    'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
begin
  Result := '';
  while ID <> 0 do
  begin
    Result := Trans[ID mod b] + Result;
    ID := ID div b;
  end;
  if Result = '' then
    Result := '0';
end;

// aqui

function DetectaDrv(const drive: char): Boolean; //
{ Detecta quantas unidade possui no computador }
var
  Letra: string;
begin
  Letra := drive + ':\';
  if GetDriveType(PChar(Letra)) < 2 then
  begin
    Result := false;
  end
  else
  begin
    Result := true;
  end;
end;

function CorrentPrinter: String; //
// Retorna a impressora padr�o do windows
// Requer a unit printers declarada na clausula uses da unit
var
  Device: array [0 .. 255] of char;
  Driver: array [0 .. 255] of char;
  Port: array [0 .. 255] of char;
  hDMode: THandle;
begin
  Printer.GetPrinter(Device, Driver, Port, hDMode);
  Result := Device + ' na porta ' + Port;
end;

Function ConnectionKind: Boolean; //
//
// Retorna o tipo de conex�o com a Internet
//
// Requer a wininet na clausula Uses da Unit
var
  flags: DWORD;
begin
  Result := InternetGetConnectedState(@flags, 0);
  if Result then
  begin
    if (flags and INTERNET_CONNECTION_MODEM) = INTERNET_CONNECTION_MODEM then
      showmessage('Modem')
    else if (flags and INTERNET_CONNECTION_LAN) = INTERNET_CONNECTION_LAN then
      showmessage('LAN')
    else if (flags and INTERNET_CONNECTION_PROXY) = INTERNET_CONNECTION_PROXY
    then
      showmessage('Proxy')
    else if (flags and INTERNET_CONNECTION_MODEM_BUSY) = INTERNET_CONNECTION_MODEM_BUSY
    then
      showmessage('Modem ocupado')
    else
      showmessage('Sem Conex�o');
  end;
end;

function GetNetStation(Tipo: Integer): string; //
//
// Retorna informa��es sobre o Computador na rede
//
// Requer a Registry declarada na clausula uses da unit
//
// Tipo :  1 - Nome do Computador na rede
// 2 - Nome do Grupo de trabalho
// 3 - Descri��o do computador na rede
//
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Result := '(n/a)';
  with Reg do
    try
      rootkey := HKEY_LOCAL_MACHINE;
      if OpenKey('System\CurrentControlSet\Services\VxD\VNETSUP', false) then
      begin
        Case Tipo of
          1:
            Result := ReadString('ComputerName');
          2:
            Result := ReadString('Workgroup');
          3:
            Result := ReadString('Comment');
        end;
      end;
    Finally
      CloseKey;
      Free;
    end;
end;

Function NomeComputador: String; //
//
// Retorna o nome do computador
//
var
  lpBuffer: PChar;
  nSize: DWORD;
const
  Buff_Size = MAX_COMPUTERNAME_LENGTH + 1;
begin
  nSize := Buff_Size;
  lpBuffer := StrAlloc(Buff_Size);
  GetComputerName(lpBuffer, nSize);
  Result := String(lpBuffer);
  StrDispose(lpBuffer);
end;

Function FinanceRegister(xOrg, xControle: String): Boolean;
var
  Query: TFDQuery;
  comando: String;
  org: String;
  emps: Integer;
  xEmps: String;
begin
  // gravando os dados no registro
  org := xOrg;
  comando := 'SELECT * from ORGANIZACAO WHERE RAZAO_SOCIAL =:FRAZAO ';
  try

    if (org.IsEmpty) then
    begin
      showmessage(msgErroOrganizacaoNula + msgExitApplication);
      Application.Terminate;
    end;

    Query := TFDQuery.Create(NIL);
    // Query.Connection := uDM.dmGenerico.BDFinance;
    Query.Connection.Connected;
    Query.Close;
    Query.sql.Add(comando);
    Query.ParamByName('FRAZAO').AsString; // := ftString;
    Query.ParamByName('FRAZAO').value := org;
    Query.Open();


    // infs criptografadas

    GravarRegistros('Pempec Enterprise', 'Finance', 'FCC_ID',
      uCriptografia.Criptografa(GetSerialMotherBoard, 128));

    GravarRegistros('Pempec Enterprise', 'Finance', 'LICENCA',
      uCriptografia.Criptografa(Query.FieldByName('LICENCA').Text, 128));

    GravarRegistros('Pempec Enterprise', 'Finance', 'CODINOME',
      uCriptografia.Criptografa(Query.FieldByName('CODINOME').Text, 128));

    GravarRegistros('Pempec Enterprise', 'Finance', 'ID_CPU',
      uCriptografia.Criptografa(Query.FieldByName('ID_CPU').Text, 128));
    GravarRegistros('Pempec Enterprise', 'Finance', 'SerialNumber',
      uCriptografia.Criptografa(Query.FieldByName('SERIAL_CLIENTE').Text, 128));
    GravarRegistros('Pempec Enterprise', 'Finance', 'RAZAO_SOCIAL',
      Query.FieldByName('RAZAO_SOCIAL').Text);

    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_ERRO',
      Query.FieldByName('PATH_SERVER').Text + 'database\img\');

    // para estacoes clientes.
    if (Query.FieldByName('IPSERVERBD').Text <> GetIp) then
    begin
      GravarRegistros('Pempec Enterprise', 'Finance', 'CONTROLE',
        GeraControleLicenca(Query.FieldByName('RAZAO_SOCIAL').Text,
        Query.FieldByName('CODINOME').Text, Query.FieldByName('LICENCA').Text,
        Query.FieldByName('DATA_REGISTRO').Text));
    end;

    // infs N�O criptografadas
    xEmps := LerRegistro('Pempec Enterprise', 'Finance', 'EMPRESAS');
    if not(xEmps.IsEmpty) then
    begin
      emps := StrToInt(xEmps) + 1;
      xEmps := IntToStr(emps);
    end
    else
    begin
      xEmps := '1';
    end;

    GravarRegistros('Pempec Enterprise', 'Finance', 'EMPRESAS', xEmps);

    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_BD',
      Query.FieldByName('PATH_BD').Text);

    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_SERVER',
      Query.FieldByName('PATH_SERVER').Text);

    if (Query.FieldByName('IPSERVERBD').Text = GetIp) then
    begin
      GravarRegistros('Pempec Enterprise', 'Finance', 'TIPO', 'SERVER')
    end
    else
    begin
      GravarRegistros('Pempec Enterprise', 'Finance', 'TIPO', 'CLIENT')
    end;
    GravarRegistros('Pempec Enterprise', 'Finance', 'ID_ORGANIZACAO',
      Query.FieldByName('ID_ORGANIZACAO').Text);
    // nao veio do form princpal

    GravarRegistros('Pempec Enterprise', 'Finance', 'CNPJ',
      Query.FieldByName('CNPJ').Text);

    GravarRegistros('Pempec Enterprise', 'Finance', 'placaMain', GetMacAddress);
    GravarRegistros('Pempec Enterprise', 'Finance', 'IPSERVERBD',
      Query.FieldByName('IPSERVERBD').Text);

    GravarRegistros('Pempec Enterprise', 'Finance', 'PORTABD', '3050');

    GravarRegistros('Pempec Enterprise', 'Finance', 'NAMESERVERBD',
      Query.FieldByName('NAMESERVERBD').Text);
    GravarRegistros('Pempec Enterprise', 'Finance', 'HOST_IP', GetIp);
    GravarRegistros('Pempec Enterprise', 'Finance', 'HOST_NAME',
      NomeComputador);
    GravarRegistros('Pempec Enterprise', 'Finance', 'SERIAL_HD',
      Query.FieldByName('SERIAL_HD').Text);
    GravarRegistros('Pempec Enterprise', 'Finance', 'SISTEMA_CONTABIL',
      Query.FieldByName('SISTEMA_CONTABIL').Text);

  finally
    FreeAndNil(Query);
  end;

  Result := true;

end;

function GeraControleLicenca(xRazao, xCodinome, xLicenca,
  xData: String): String;

// pegar o FCC_ID (GetSerialMotherBoard)

var
  controle: String;
  conversao: String;
  Senha: String;
  codigoInt: Integer;
  xReal: Double;

begin
  try
    conversao := ConverterStringToHex(xRazao) + ConverterStringToHex(xCodinome)
      + ConverterStringToHex(xLicenca) + ConverterStringToHex(xData) +
      GetSerialMotherBoard;
    // senha :=GeraSenhaHex(32,False,True,True);
    controle := conversao;

  except
    raise Exception.Create(uMensagens.msgErroLicencaFinance);

  end;

  Result := controle;
end;

function GetComputerNetName: string;
var
  Buffer: array [0 .. 255] of char;
  size: DWORD;
begin
  size := 256;
  if GetComputerName(Buffer, size) then
    Result := Buffer
  else
    Result := ''
end;

function GetUserFromWindows: string;
Var
  Username: string;
  UserNameLen: DWORD;
Begin
  UserNameLen := 255;
  SetLength(Username, UserNameLen);
  If GetUserName(PChar(Username), UserNameLen) Then
    Result := Copy(Username, 1, UserNameLen - 1)
  Else
    Result := 'Desconhecido';
End;

Function GetIPAddress(): String;
type
  pu_long = ^u_long;
var
  varTWSAData: TWSAData;
  varPHostEnt: PHostEnt;
  varTInAddr: TInAddr;
  // namebuf :  Array[0..255] of char;
  namebuf: PAnsiChar;

begin
  If WSAStartup($101, varTWSAData) <> 0 Then
    Result := '0.0.0.0'
  Else
  Begin
    gethostname(namebuf, SizeOf(namebuf));
    varPHostEnt := gethostbyname(namebuf);
    varTInAddr.S_addr := u_long(pu_long(varPHostEnt^.h_addr_list^)^);
    Result := inet_ntoa(varTInAddr);
  End;
  WSACleanup;
end;

function GetIp(): String;
var
  r: TIdIPWatch;
begin

  r := TIdIPWatch.Create(nil);
  Result := r.LocalIP;
  r.Free;

end;

function GetSerialMotherBoard: String;
var
  a, b, c, d: LongWord;

begin

  asm
    push EAX
    push EBX
    push ECX
    push EDX

    mov eax, 1
    db $0F, $A2
    mov a, EAX
    mov b, EBX
    mov c, ECX
    mov d, EDX

    pop EDX
    pop ECX
    pop EBX
    pop EAX

  end;
  { result := inttohex(a, 8) + '-' +
    inttohex(b, 8) + '-' +
    inttohex(c, 8) + '-' +
    inttohex(d, 8); }

  Result := IntToHex(a, 8) + IntToHex(c, 8) + IntToHex(d, 8);
end;

function obterSubChavesRegistro(xChave: String): TStringList;
var
  Reg: TRegistry;
  chaves: TStringList;
  I: Integer;
begin
  Reg := TRegistry.Create;
  chaves := TStringList.Create;

  try
    Reg.rootkey := HKEY_CURRENT_USER;
    Reg.OpenKey(xChave, false);
    Reg.GetKeyNames(chaves);
  Except
    Reg.Free;
  end;

  Result := chaves;

end;

{ A fun��o retorna uma string contendo
  as letras de unidades de discos presentes.
  exemplo de uso:
  preencheComboUnidades(listaUnidades);
  ComboBox1.Items.Add(lista.Substring(I, 1) + ':\');
  usada em obterInstalacaoFinance


}

function listaUnidades: string;
var
  Drives: DWORD;
  I: byte;
begin
  Result := '';
  Drives := GetLogicalDrives;
  if Drives <> 0 then
    for I := 65 to 90 do
      if ((Drives shl (31 - (I - 65))) shr 31) = 1 then
        Result := Result + char(I);
end;


// proc procura instalacao do FInance e coloca
// num TStringList . Requer listbox
// depende de Function listaUnidades e obterSubChavesRegistro
// propriedade por ser :
// Sistema = retorna a pasta do sistema se existir
// Banco = retorna o caminho do Finance.fdb se existir



Function obterInstalacaoFinance(Propriedade: String): TStringList;
var
  rstInstal, xConexoes: TStringList;
  rsBanco, xUnidades, xArquivo, pesq: String;
  aux, I: Integer;
begin

  rstInstal := TStringList.Create;
  // verificando a instalacao marcada no registro do windows

  pesq := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_SERVER');
  if DirectoryExists(pesq) then

  begin

    pesq := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD');
    if FileExists(pesq) then
    begin

      pesq := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_SERVER');
      rstInstal.Append('Base Registrada localizada em : ' + '[' + pesq + ']');
      rstInstal.Append('SERVIDOR : ' + LerRegistro('Pempec Enterprise',
        'Finance', 'HOST_NAME'));
      rstInstal.Append('IP LOCAL : ' + LerRegistro('Pempec Enterprise',
        'Finance', 'HOST_IP'));
      rstInstal.Append('BACKUP EM  : ' + LerRegistro('Pempec Enterprise',
        'Finance', 'PATH_BD_BKP'));
      rstInstal.Append('IP DATABASE : ' + LerRegistro('Pempec Enterprise',
        'Finance', 'IPSERVERBD'));

      rstInstal.Append('');
    end
    else
    begin
      rstInstal.Append('Base Registrada em : ' + '[' + pesq + ']' +
        ' n�o foi localizada.');
    end;
  end;

  // verificando a instala��o no pc local
  xUnidades := listaUnidades;

  for I := 0 to xUnidades.Length - 1 do
  begin
    pesq := xUnidades[I] + ':\Finance\';
    if DirectoryExists(pesq) then
      rstInstal.Append(pesq);
    begin
      if Propriedade = 'Banco' then
      begin
        if FileExists(pesq + 'Dados\Finance.FDB') then
        begin
          rstInstal.Append('Base localizada em : ' + pesq + 'Dados\');
          rsBanco := pesq + 'Dados\';
          rstInstal.Clear;
          rstInstal.Append(rsBanco);
          aux := 1;
        end
        else
        begin
          rstInstal.Append(pesq);
        end;
      end;
    end;
  end;

  // verificando a insta��o nas unidades mapeadas
  xConexoes := TStringList.Create;
  xArquivo := 'Network';

  xConexoes := obterSubChavesRegistro(xArquivo);

  for I := 0 to xConexoes.Count - 1 do
  begin
    pesq := LerRegistro(xArquivo, xConexoes.Strings[I], 'RemotePath') +
      '\Finance\';

    if DirectoryExists(pesq) then
      rstInstal.Append(pesq);
    begin
      if Propriedade = 'Banco' then
      begin
        if FileExists(pesq + 'Dados\Finance.FDB') then
        begin
          rstInstal.Append('Base Remota localizada em : ' + pesq + 'Dados\');
          // ListBox2.Items.Add('Base localizada em : ' + pesq + 'Dados\');
          rsBanco := pesq + 'Dados\';
          if aux = 0 then
          begin
            rstInstal.Clear;
          end;
          rstInstal.Append(rsBanco);
        end
        else
        begin
          rstInstal.Append(pesq);
          // ListBox2.Items.Add(pesq);
        end;
      end;
    end;

    if rstInstal.Count = 0 then
    begin
      rstInstal.Append('Instala��o Finance n�o localizada.');
      rsBanco := 'Banco de Dados Ausente.'
    end;

  end;
  Result := rstInstal;

end;

procedure EnviarEmailGen(Origem, Msg, Assunto, Dest1, Dest2, Anexo: String);
var
  Conta, host, Senha, porta, remetente, Autentica, SSL: String;
  mensagem: TIdMessage;
  cnxSMTP: TIdSMTP;
  AuthSSL: TIdSSLIOHandlerSocketOpenSSL;
begin

  // inicializa as variaveis do rodape do email a ser enviado.
    uVarGlobais.IniRodapeEmail(uUtil.GetLicenca, uUtil.GetIp,
    uUtil.NomeComputador, uUtil.GetUserFromWindows, uUtil.GetSerialMotherBoard);

  try

    Conta := uVarGlobais.rHost.Conta;
    Senha := uVarGlobais.rHost.Senha;
    host := uVarGlobais.rHost.host;
    porta := uVarGlobais.rHost.porta;
    remetente := Conta;
    Autentica := uVarGlobais.rHost.Autentica;

  except
    MessageDlg
      ('As configura��es de email est�o incorretas. Informe ao suporte.',
      mtInformation, [mbOK], 0);
  end;

  if (Autentica.Equals('N�O')) then
  begin
    Autentica := 'N';
  end
  else
  begin
    Autentica := 'S';
  end;

  SSL := 'S';

  // inicia o envio
  try

    // verifica se foi setado algum destinatario, caso nao tenha sido, entao, envia o email para a propria conta

    if (Dest1 = String.Empty) then
    begin
      Dest1 := Conta;
    end;

    mensagem := TIdMessage.Create(nil);
    cnxSMTP := TIdSMTP.Create(nil);

    mensagem.From.Name := remetente; // Nome do Remetente
    mensagem.From.Address := Conta; // E-mail do Remetente = email valido...
    mensagem.Recipients.EMailAddresses := Dest1; // destinatario
    mensagem.ReplyTo.EMailAddresses := Dest1;
    mensagem.CCList.EMailAddresses := Dest2;
    mensagem.Priority := mpHighest;
    mensagem.Subject := Assunto; // Assunto do E-mail

    cnxSMTP.host := host; // smtp
    cnxSMTP.Username := Conta;
    cnxSMTP.Password := Senha;
    if Autentica = 'S' then
      cnxSMTP.AuthType := satDefault;
    if Autentica = 'N' then
      cnxSMTP.AuthType := satNone;

    if not (host = 'mail.pempec.com.br') then begin
            if Autentica = 'S' then
            begin
              AuthSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
              cnxSMTP.IOHandler := AuthSSL;
              cnxSMTP.UseTLS := utUseExplicitTLS; // utUseImplicitTLS;
              AuthSSL.DefaultPort := StrToInt(porta);
              AuthSSL.Port := StrToInt(porta); //add em 08/12

              AuthSSL.SSLOptions.Method := sslvSSLv3;
              AuthSSL.SSLOptions.Mode := sslmClient;


            end;
    end;


    cnxSMTP.Port := StrToInt(porta);

    if trim(Anexo) <> '' then
    begin
      try
        TIdAttachmentFile.Create(mensagem.MessageParts, TFileName(Anexo));
      except
        MessageDlg
          ('O sistema de auditoria encontrou um erro ao tentar anexar arquivo. Informe ao suporte.',
          mtInformation, [mbOK], 0);
      end;
    end;
    Msg := Msg + #13 + uVarGlobais.rRodapeEmail.licenca + #13 +
      uVarGlobais.rRodapeEmail.nomePc + #13 +
      uVarGlobais.rRodapeEmail.usuarioWindows + #13 +
      uVarGlobais.rRodapeEmail.serialMother + #13 +
      uVarGlobais.rRodapeEmail.ipLocal + #13;
    mensagem.Body.Clear;
    mensagem.Body.Add(Msg);
    cnxSMTP.UseEhlo := true;
    cnxSMTP.UseVerp := false;

    cnxSMTP.ReadTimeout := 10000;
    cnxSMTP.Connect;
    sleep(1000);
    cnxSMTP.Authenticate;
    sleep(1000);
    Try
      if cnxSMTP.Connected then
      begin
        mensagem.Body.Text;
        cnxSMTP.Send(mensagem)
      end
      else
      begin
        // registrar o erro do envio do e-mail.
        MessageDlg
          ('O sistema n�o consegue conectar-se com o seu provedor. Informe ao suporte.',
          mtInformation, [mbOK], 0);
      end;
    except
      cnxSMTP.Disconnect;
      cnxSMTP.host := porta; // smtp
      cnxSMTP.AuthType := satNone;
      cnxSMTP.Connect;
      try
        cnxSMTP.Send(mensagem);
      except
        begin
          MessageDlg
            ('O sistema de auditoria encontrou um erro ao tentar tratar msgs internas. Informe ao suporte.',
            mtInformation, [mbOK], 0);
        end;
      end;
      cnxSMTP.Disconnect;
    end;
    cnxSMTP.Disconnect;

  finally
    FreeAndNil(mensagem);
    FreeAndNil(cnxSMTP);
    if Autentica = 'S' then
      FreeAndNil(AuthSSL);
  end;

end;


function getFileSize(Arquivo: string): Integer;

begin

  with TFileStream.Create(Arquivo, fmOpenRead or fmShareExclusive) do

  try

    Result := Size;

  finally

   Free;

  end;

end;


function PastaExist(pasta :String):Boolean;
begin
     Result := DirectoryExists(pasta);
end;

function ArquivoExist(arq :String):Boolean;
begin
     Result := FileExists(arq);
end;



function FormataCNPJ(CNPJ: string): string;

begin

  Result :=Copy(CNPJ,1,2)+'.'+Copy(CNPJ,3,3)+'.'+Copy(CNPJ,6,3)+'/'+

    Copy(CNPJ,9,4)+'-'+Copy(CNPJ,13,2);

end;

end.
