unit uUtil;

interface

uses
//  Vcl.Forms,  Vcl.Graphics, System.SysUtils,
//    Vcl.Dialogs, IdBaseComponent, IdComponent, IdIPWatch,
//    Windows, Registry, FireDAC.Stan.Intf, FireDAC.Stan.Option,
//    FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
//    FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Error, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.IBBase, FireDAC.Phys.FB, uCriptografia, uMensagens, System.Classes, Printers, wininet, Winsock, IdSSL, IdSSLOpenSSL, IdMessage,
//    IdAttachmentFile, StdCtrls, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, uVarGlobais, System.UITypes, System.RegularExpressions, IdTCPConnection, IdSMTP, FireDAC.Stan.Param, jpeg, Organizacao;

Vcl.Forms,DateUtils, Vcl.Dialogs, IdBaseComponent, IdComponent, IdIPWatch, System.SysUtils, Windows,
Registry, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Error, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
uCriptografia, uMensagens, System.Classes, Printers, wininet, Winsock, IdSSL, IdSSLOpenSSL, IdMessage,
  IdAttachmentFile, StdCtrls, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, uVarGlobais,
  System.UITypes, System.RegularExpressions, IdTCPConnection, IdSMTP, Vcl.Graphics, FireDAC.Stan.Param, jpeg, Organizacao;



type
  {$REGION 'TOrg: Classe para armazenar ID da ORganizacao escolhida na tela principal'}
  TOrgAtual = class
  public
    class procedure setId(lsId: string);
    class procedure setPathSGBD(lsPathSgbd: string);
    class procedure setCNPJ(lsCnpj: string);
    class procedure setFantasia(lsFantasia: string);
    class procedure setRazaoSocial(lsRazaoSocial: string);
    class procedure setSistemaContabil(lsSistemaContabil: string);
    class function getId: string;
    class function getCNPJ: string;
    class function getFantasia: string;
    class function getRazaoSocial: string;
    class function getPathSGBD: string;
    class function getSistemaContabil: string;



  end;
  {$ENDREGION}

  {$REGION 'TUserAtual: Classe para armazenar dados do usuario logado'}

  TUserAtual = class
  public
    class procedure setId(UserId: string);
    class procedure setLogin(lsLogin: string);
    class procedure setNameUser(lsName: string);
    class procedure setPassword(lsPassword: string);
    class function getUserId: string;
    class function getLogin: string;
    class function getNameUser: string;
    class function getPassword: string;
  end;
  {$ENDREGION}

//function varToStr(Value: Variant): String;

function SoNumeros(psString: string): string;

function GetIp(): string;

function GetLicenca(): string;

function LerRegistro(xArquivo, xSection, xIdent: string): string;

function GetMacAddress(): string;

function FinanceRegister(xOrg, xControle: string): Boolean;

function ConverterStringToHex(S: string): string;

function ConverterHexToString(H: string): string;

function GeraControleLicenca(xRazao, xCodinome, xLicenca, xData: string): string;

function GetIPAddress(): string;

function CapturaTelaForm(Sender: TForm; NameFile: string): TJPEGImage;

function obterSubChavesRegistro(xChave: string): TStringList;

function GeraSenhaHex(Digitos: Integer; Min, Mai, Num: Boolean): string;

function DecimalToBase(ID, b: Integer): string;

function NomeComputador: string;

function GetNetStation(Tipo: Integer): string;

function CorrentPrinter: string;

function ConnectionKind: Boolean;

function DetectaDrv(const drive: char): Boolean;

function GetSerialMotherBoard: string;

function GetComputerNetName: string;

function GetUserFromWindows: string;

function GeraNameFileJPG(): string;

function obterInstalacaoFinance(Propriedade: string): TStringList;

function getFileSize(Arquivo: string): Integer;

function PastaExist(pasta: string): Boolean;

function ArquivoExist(arq: string): Boolean;

function FormataCNPJ(CNPJ: string): string;

procedure LimpaTela(Form: TForm);

procedure EnviarEmailGen(Origem, Msg, Assunto, Dest1, Dest2, Anexo: string);

procedure GravarRegistros(xArquivo, xSection, xIdent, xValue: string);

function GetPathConfigIni(): string;

function QueryToLog(Q: TFDQuery): string;

function GetVersionInfo(const AFileName: string): string;

function GetPeriodoSt(dtInicial , dtFinal :TDate): string;

function removeCaracteresConta(const v: string): string;

procedure setDataServer(lsData: TDateTime);

Function getDataServer(): TDateTime;

Function qtdDiasPeriodo(pDataInicial, pDataFinal: TDate): Integer;



implementation

var
  //Organizacao
  FsId: string; //armazena o id da organizacao Finance
  FsCnpj: string;
  FsFantasia: string;
  FsRazaoSocial: string;
  FsOrganizacao: TOrganizacao;
  FpathSGBD: string;
  FsistemaContabil : string;

  FDataServidorDatabase: TDateTime;

//User
  FIdUser: string;
  FLogin: string;
  FNameUser: string;
  FPassword: string;

  //outra aqui


{ TOrg }
{$REGION 'TOrg: Implementação...'}
class function TOrgAtual.getId: string;
begin
  Result := FsId;
end;

class function TOrgAtual.getPathSGBD: string;
begin
  Result := FpathSGBD;
end;

class procedure TOrgAtual.setPathSGBD(lsPathSgbd: string);
begin
  FpathSGBD := lsPathSgbd;
end;


class procedure TOrgAtual.setId(lsId: string);
begin
  FsId := lsId;
end;

class procedure TOrgAtual.setCNPJ(lsCnpj: string);
begin
  FsCnpj := lsCnpj;
end;

class procedure TOrgAtual.setFantasia(lsFantasia: string);
begin
  FsFantasia := lsFantasia;
end;

class procedure TOrgAtual.setRazaoSocial(lsRazaoSocial: string);
begin
  FsRazaoSocial := lsRazaoSocial;
end;

class procedure TOrgAtual.setSistemaContabil(lsSistemaContabil: string);
begin
FsistemaContabil := lsSistemaContabil;
end;

class function TOrgAtual.getCNPJ: string;
begin
  Result := FsCnpj;
end;

class function TOrgAtual.getFantasia: string;
begin
  Result := FsFantasia;
end;

class function TOrgAtual.getRazaoSocial: string;
begin
  Result := FsRazaoSocial;
end;


class function TOrgAtual.getSistemaContabil: string;
begin
  Result := FsistemaContabil;
end;

{$ENDREGION}

function SoNumeros(psString: string): string;
begin
 {TRegEx precisa da declaração em uses de
  System.RegularExpressions}
  Result := TRegEx.Replace(psString, '\D', '');
end;

function removeCaracteresConta(const v: string): string;
const
  cP = '.';
  cVa = '';
  cVi = ',';
begin
  result := v;
  result := StringReplace(StringReplace(result, cP, cVa, [rfReplaceAll]), cVi, cP, [rfReplaceAll]);
end;

procedure LimpaTela(Form: TForm);
var
  i: Integer;
begin
  // limpa os componentes da tela

  for i := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[i] is TCustomEdit then
    begin
      (Form.Components[i] as TCustomEdit).Clear;
    end;

    if Form.Components[i] is TLabel then
    begin
      TLabel(Form.Components[i]).Caption := '';
    end;

    if Form.Components[i] is TEdit then
    begin
      TEdit(Form.Components[i]).Text := '';
    end;

    if Form.Components[i] is TComboBox then
    begin
      TComboBox(Form.Components[i]).Text := '';
      TComboBox(Form.Components[i]).ItemIndex := 0;
    end;
   end;

end;

function GeraNameFileJPG(): string;
var
  Data, hora, NameFile, pathServer: string;
begin
  Data := FormatDateTime('dd_mm_yyyy', now);
  hora := FormatDateTime('hh_mm_ss', now);

  pathServer := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_ERRO');

  if (pathServer = string.Empty) then
  begin
    pathServer := ExtractFilePath(Application.ExeName) + 'img\';
  end;

  if not DirectoryExists(pathServer) then
  begin
    try
      CreateDir(pathServer);
      GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_ERRO', pathServer);
    except
      raise Exception.Create('Erro ao criar pasta pata imagens. Contate o suporte.');
    end;

  end;

  NameFile := pathServer + 'FIN_PICT_' + Data + '-' + hora + '.jpg';
  Result := NameFile;

end;

function CapturaTelaForm(Sender: TForm; NameFile: string): TJPEGImage;
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

function GetLicenca(): string;
var
  licenca: string;
begin
  licenca := '00000';

  licenca := uCriptografia.DesCriptografa(LerRegistro('Pempec Enterprise', 'Finance', 'SerialNumber'), 128);

  Result := licenca;

end;

{ Procedure para criar um determinado valor no registro }

procedure GravarRegistros(xArquivo, xSection, xIdent, xValue: string);
var
  ArqReg: TRegIniFile;
begin

  ArqReg := TRegIniFile.Create(xArquivo);
  ArqReg.rootkey := HKEY_CURRENT_USER;

  try

    ArqReg.WriteString(xSection, xIdent, xValue);

  finally
    ArqReg.Free;

  end;

end;

{ Função para retornar o conteúdo de um determinado registro }

function LerRegistro(xArquivo, xSection, xIdent: string): string;
// mudado em 20/04 add HKEY_CURRENT_USER
var
  ArqReg: TRegIniFile;
begin

  ArqReg := TRegIniFile.Create(xArquivo);
  ArqReg.rootkey := HKEY_CURRENT_USER;
  try

    Result := ArqReg.ReadString(xSection, xIdent, '');

  finally

    ArqReg.Free;

  end;

end;

function GetPathConfigIni(): string;
begin
  Result := ExtractFilePath(Application.ExeName) + 'config.ini';
end;


// Funcao para capturar o endereço Mac da pl rede

function GetMacAddress(): string;
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
      if (Func(@GUID1) = 0) and (Func(@GUID2) = 0) and (GUID1.D4[2] = GUID2.D4[2]) and (GUID1.D4[3] = GUID2.D4[3]) and (GUID1.D4[4] = GUID2.D4[4]) and (GUID1.D4[5] = GUID2.D4[5]) and (GUID1.D4[6] = GUID2.D4[6]) and (GUID1.D4[7] = GUID2.D4[7]) then
      begin
        Result := IntToHex(GUID1.D4[2], 2) + '-' + IntToHex(GUID1.D4[3], 2) + '-' + IntToHex(GUID1.D4[4], 2) + '-' + IntToHex(GUID1.D4[5], 2) + '-' + IntToHex(GUID1.D4[6], 2) + '-' + IntToHex(GUID1.D4[7], 2);
      end;
    end;
  end;
end;



// utilidades encontradas na www
{ Básicamente essa Função vai Gerar um Código aleatório,
  com a quantidade de dígitos definidos atravéz da variável "Digitos",
  contendo ou não letras maiúsculas, minúsculas ou numeros,
  você pode também acrescentar mais letras ou até caracteres especiais a função. }
function GeraSenhaHex(Digitos: Integer; Min: Boolean; Mai: Boolean; Num: Boolean): string;
const
  MinC = 'abcdef';
  MaiC = 'ABCDEF';
  NumC = '1234567890';
var
  p, q: Integer;
  char, Senha: string;
begin
  char := '';
  if Min then
    char := char + MinC;
  if Mai then
    char := char + MaiC;
  if Num then
    char := char + NumC;
  for p := 1 to Digitos do
  begin
    Randomize;
    q := Random(Length(char)) + 1;
    Senha := Senha + char[q];
  end;
  Result := Senha;
end;

function ConverterStringToHex(S: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(S) do
    Result := Result + IntToHex(ord(S[i]), 2);
end;

function ConverterHexToString(H: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(H) div 2 do
    Result := Result + char(StrToInt('$' + Copy(H, (i - 1) * 2 + 1, 2)));
end;

//
// Transforma um valor decimal em uma base qualquer especificada em b
//

function DecimalToBase(ID: Integer; b: Integer): string;
const
  Trans: array[0..35] of char = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
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

function CorrentPrinter: string; //
// Retorna a impressora padrão do windows
// Requer a unit printers declarada na clausula uses da unit
var
  Device: array[0..255] of char;
  Driver: array[0..255] of char;
  Port: array[0..255] of char;
  hDMode: THandle;
begin
  Printer.GetPrinter(Device, Driver, Port, hDMode);
  Result := Device + ' na porta ' + Port;
end;

function ConnectionKind: Boolean; //
//
// Retorna o tipo de conexão com a Internet
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
    else if (flags and INTERNET_CONNECTION_PROXY) = INTERNET_CONNECTION_PROXY then
      showmessage('Proxy')
    else if (flags and INTERNET_CONNECTION_MODEM_BUSY) = INTERNET_CONNECTION_MODEM_BUSY then
      showmessage('Modem ocupado')
    else
      showmessage('Sem Conexão');
  end;
end;

function GetNetStation(Tipo: Integer): string; //
//
// Retorna informações sobre o Computador na rede
//
// Requer a Registry declarada na clausula uses da unit
//
// Tipo :  1 - Nome do Computador na rede
// 2 - Nome do Grupo de trabalho
// 3 - Descrição do computador na rede
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
      case Tipo of
        1:
          Result := ReadString('ComputerName');
        2:
          Result := ReadString('Workgroup');
        3:
          Result := ReadString('Comment');
      end;
    end;
  finally
    CloseKey;
    Free;
  end;
end;

function NomeComputador: string; //
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
  Result := string(lpBuffer);
  StrDispose(lpBuffer);
end;

function FinanceRegister(xOrg, xControle: string): Boolean;
var
  Query: TFDQuery;
  comando: string;
  org: string;
  emps: Integer;
  xEmps: string;
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

    GravarRegistros('Pempec Enterprise', 'Finance', 'FCC_ID', uCriptografia.Criptografa(GetSerialMotherBoard, 128));

    GravarRegistros('Pempec Enterprise', 'Finance', 'LICENCA', uCriptografia.Criptografa(Query.FieldByName('LICENCA').Text, 128));

    GravarRegistros('Pempec Enterprise', 'Finance', 'CODINOME', uCriptografia.Criptografa(Query.FieldByName('CODINOME').Text, 128));

    GravarRegistros('Pempec Enterprise', 'Finance', 'ID_CPU', uCriptografia.Criptografa(Query.FieldByName('ID_CPU').Text, 128));
    GravarRegistros('Pempec Enterprise', 'Finance', 'SerialNumber', uCriptografia.Criptografa(Query.FieldByName('SERIAL_CLIENTE').Text, 128));
    GravarRegistros('Pempec Enterprise', 'Finance', 'RAZAO_SOCIAL', Query.FieldByName('RAZAO_SOCIAL').Text);

    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_ERRO', Query.FieldByName('PATH_SERVER').Text + 'database\img\');

    // para estacoes clientes.
    if (Query.FieldByName('IPSERVERBD').Text <> GetIp) then
    begin
      GravarRegistros('Pempec Enterprise', 'Finance', 'CONTROLE', GeraControleLicenca(Query.FieldByName('RAZAO_SOCIAL').Text, Query.FieldByName('CODINOME').Text, Query.FieldByName('LICENCA').Text, Query.FieldByName('DATA_REGISTRO').Text));
    end;

    // infs NÃO criptografadas
    xEmps := LerRegistro('Pempec Enterprise', 'Finance', 'EMPRESAS');
    if not (xEmps.IsEmpty) then
    begin
      emps := StrToInt(xEmps) + 1;
      xEmps := IntToStr(emps);
    end
    else
    begin
      xEmps := '1';
    end;

    GravarRegistros('Pempec Enterprise', 'Finance', 'EMPRESAS', xEmps);

    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_BD', Query.FieldByName('PATH_BD').Text);

    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_SERVER', Query.FieldByName('PATH_SERVER').Text);

    if (Query.FieldByName('IPSERVERBD').Text = GetIp) then
    begin
      GravarRegistros('Pempec Enterprise', 'Finance', 'TIPO', 'SERVER')
    end
    else
    begin
      GravarRegistros('Pempec Enterprise', 'Finance', 'TIPO', 'CLIENT')
    end;
    GravarRegistros('Pempec Enterprise', 'Finance', 'ID_ORGANIZACAO', Query.FieldByName('ID_ORGANIZACAO').Text);
    // nao veio do form princpal

    GravarRegistros('Pempec Enterprise', 'Finance', 'CNPJ', Query.FieldByName('CNPJ').Text);

    GravarRegistros('Pempec Enterprise', 'Finance', 'placaMain', GetMacAddress);
    GravarRegistros('Pempec Enterprise', 'Finance', 'IPSERVERBD', Query.FieldByName('IPSERVERBD').Text);

    GravarRegistros('Pempec Enterprise', 'Finance', 'PORTABD', '3050');

    GravarRegistros('Pempec Enterprise', 'Finance', 'NAMESERVERBD', Query.FieldByName('NAMESERVERBD').Text);
    GravarRegistros('Pempec Enterprise', 'Finance', 'HOST_IP', GetIp);
    GravarRegistros('Pempec Enterprise', 'Finance', 'HOST_NAME', NomeComputador);
    GravarRegistros('Pempec Enterprise', 'Finance', 'SERIAL_HD', Query.FieldByName('SERIAL_HD').Text);
    GravarRegistros('Pempec Enterprise', 'Finance', 'SISTEMA_CONTABIL', Query.FieldByName('SISTEMA_CONTABIL').Text);

  finally
    FreeAndNil(Query);
  end;

  Result := true;

end;

function GeraControleLicenca(xRazao, xCodinome, xLicenca, xData: string): string;

// pegar o FCC_ID (GetSerialMotherBoard)

var
  controle: string;
  conversao: string;
  Senha: string;
  codigoInt: Integer;
  xReal: Double;
begin
  try
    conversao := ConverterStringToHex(xRazao) + ConverterStringToHex(xCodinome) + ConverterStringToHex(xLicenca) + ConverterStringToHex(xData) + GetSerialMotherBoard;
    // senha :=GeraSenhaHex(32,False,True,True);
    controle := conversao;

  except
    raise Exception.Create(uMensagens.msgErroLicencaFinance);

  end;

  Result := controle;
end;

function GetComputerNetName: string;
var
  Buffer: array[0..255] of char;
  size: DWORD;
begin
  size := 256;
  if GetComputerName(Buffer, size) then
    Result := Buffer
  else
    Result := ''
end;

function GetUserFromWindows: string;
var
  Username: string;
  UserNameLen: DWORD;
begin
  UserNameLen := 255;
  SetLength(Username, UserNameLen);
  if GetUserName(PChar(Username), UserNameLen) then
    Result := Copy(Username, 1, UserNameLen - 1)
  else
    Result := 'Desconhecido';
end;

function GetIPAddress(): string;
type
  pu_long = ^u_long;
var
  varTWSAData: TWSAData;
  varPHostEnt: PHostEnt;
  varTInAddr: TInAddr;
  // namebuf :  Array[0..255] of char;
  namebuf: PAnsiChar;
begin
  if WSAStartup($101, varTWSAData) <> 0 then
    Result := '0.0.0.0'
  else
  begin
    gethostname(namebuf, SizeOf(namebuf));
    varPHostEnt := gethostbyname(namebuf);
    varTInAddr.S_addr := u_long(pu_long(varPHostEnt^.h_addr_list^)^);
    Result := inet_ntoa(varTInAddr);
  end;
  WSACleanup;
end;

function GetIp(): string;
var
  r: TIdIPWatch;
begin

  r := TIdIPWatch.Create(nil);
  Result := r.LocalIP;
  r.Free;

end;

function GetSerialMotherBoard: string;
var
  a, b, c, d: LongWord;
begin

  asm
        push    EAX
        push    EBX
        push    ECX
        push    EDX
        mov     eax, 1
        db      $0F, $A2
        mov     a, EAX
        mov     b, EBX
        mov     c, ECX
        mov     d, EDX
        pop     EDX
        pop     ECX
        pop     EBX
        pop     EAX
  end;
  { result := inttohex(a, 8) + '-' +
    inttohex(b, 8) + '-' +
    inttohex(c, 8) + '-' +
    inttohex(d, 8); }

  Result := IntToHex(a, 8) + IntToHex(c, 8) + IntToHex(d, 8);
end;

function obterSubChavesRegistro(xChave: string): TStringList;
var
  Reg: TRegistry;
  chaves: TStringList;
  i: Integer;
begin
  Reg := TRegistry.Create;
  chaves := TStringList.Create;

  try
    Reg.rootkey := HKEY_CURRENT_USER;
    Reg.OpenKey(xChave, false);
    Reg.GetKeyNames(chaves);
  except
    Reg.Free;
  end;

  Result := chaves;

end;

{ A função retorna uma string contendo
  as letras de unidades de discos presentes.
  exemplo de uso:
  preencheComboUnidades(listaUnidades);
  ComboBox1.Items.Add(lista.Substring(I, 1) + ':\');
  usada em obterInstalacaoFinance


}

function listaUnidades: string;
var
  Drives: DWORD;
  i: byte;
begin
  Result := '';
  Drives := GetLogicalDrives;
  if Drives <> 0 then
    for i := 65 to 90 do
      if ((Drives shl (31 - (i - 65))) shr 31) = 1 then
        Result := Result + char(i);
end;


// proc procura instalacao do FInance e coloca
// num TStringList . Requer listbox
// depende de Function listaUnidades e obterSubChavesRegistro
// propriedade por ser :
// Sistema = retorna a pasta do sistema se existir
// Banco = retorna o caminho do Finance.fdb se existir

function obterInstalacaoFinance(Propriedade: string): TStringList;
var
  rstInstal, xConexoes: TStringList;
  rsBanco, xUnidades, xArquivo, pesq: string;
  aux, i: Integer;
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
      rstInstal.Append('SERVIDOR : ' + LerRegistro('Pempec Enterprise', 'Finance', 'HOST_NAME'));
      rstInstal.Append('IP LOCAL : ' + LerRegistro('Pempec Enterprise', 'Finance', 'HOST_IP'));
      rstInstal.Append('BACKUP EM  : ' + LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD_BKP'));
      rstInstal.Append('IP DATABASE : ' + LerRegistro('Pempec Enterprise', 'Finance', 'IPSERVERBD'));

      rstInstal.Append('');
    end
    else
    begin
      rstInstal.Append('Base Registrada em : ' + '[' + pesq + ']' + ' não foi localizada.');
    end;
  end;

  // verificando a instalação no pc local
  xUnidades := listaUnidades;

  for i := 0 to xUnidades.Length - 1 do
  begin
    pesq := xUnidades[i] + ':\Finance\';
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

  // verificando a instação nas unidades mapeadas
  xConexoes := TStringList.Create;
  xArquivo := 'Network';

  xConexoes := obterSubChavesRegistro(xArquivo);

  for i := 0 to xConexoes.Count - 1 do
  begin
    pesq := LerRegistro(xArquivo, xConexoes.Strings[i], 'RemotePath') + '\Finance\';

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
      rstInstal.Append('Instalação Finance não localizada.');
      rsBanco := 'Banco de Dados Ausente.'
    end;

  end;
  Result := rstInstal;

end;

procedure EnviarEmailGen(Origem, Msg, Assunto, Dest1, Dest2, Anexo: string);
var
  Conta, host, Senha, porta, remetente, Autentica, SSL: string;
  mensagem: TIdMessage;
  cnxSMTP: TIdSMTP;
  AuthSSL: TIdSSLIOHandlerSocketOpenSSL;
begin

  // inicializa as variaveis do rodape do email a ser enviado.
  uVarGlobais.IniRodapeEmail(uUtil.GetLicenca, uUtil.GetIp, uUtil.NomeComputador, uUtil.GetUserFromWindows, uUtil.GetSerialMotherBoard);

  try

    Conta := uVarGlobais.rHost.Conta;
    Senha := uVarGlobais.rHost.Senha;
    host := uVarGlobais.rHost.host;
    porta := uVarGlobais.rHost.porta;
    remetente := Conta;
    Autentica := uVarGlobais.rHost.Autentica;

  except
    MessageDlg('As configurações de email estão incorretas. Informe ao suporte.', mtInformation, [mbOK], 0);
  end;

  if (Autentica.Equals('NÃO')) then
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

    if (Dest1 = string.Empty) then
    begin
      Dest1 := Conta;
    end;

    mensagem := TIdMessage.Create(nil);
    cnxSMTP := TIdSMTP.Create(nil);

    mensagem.Name := 'Message';
    mensagem.From.Name := remetente; // Nome do Remetente
    mensagem.From.Address := Conta; // E-mail do Remetente = email valido...
    mensagem.Recipients.EMailAddresses := Dest1; // destinatario
    mensagem.ReplyTo.EMailAddresses := Dest1;
    mensagem.CCList.EMailAddresses := Dest2;
    mensagem.Priority := mpHigh; // mpHighest; 02/02/17
    mensagem.Subject := Assunto; // Assunto do E-mail

    cnxSMTP.host := host; // smtp
    cnxSMTP.Username := Conta;
    cnxSMTP.Password := Senha;
    if Autentica = 'S' then
      cnxSMTP.AuthType := satDefault;
    if Autentica = 'N' then
      cnxSMTP.AuthType := satNone;
    if Autentica = 'S' then
    begin
      AuthSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
      AuthSSL.DefaultPort := StrToInt(porta);
      AuthSSL.Port := StrToInt(porta); // add em 08/12
      AuthSSL.Name := 'SSLSocket';
      AuthSSL.SSLOptions.Method := sslvSSLv2; //sslvSSLv3;
      AuthSSL.SSLOptions.Mode := sslmUnassigned; //sslmClient;
     // AuthSSL.SSLOptions.VerifyMode :=[];
     // AuthSSL.SSLOptions.VerifyDepth :=[];
     // AuthSSL.OnStatusInfo := TIdSSLSocket; //ver

      cnxSMTP.IOHandler := AuthSSL;
     // cnxSMTP.UseTLS := utUseExplicitTLS; // utUseImplicitTLS;



    end;

    cnxSMTP.Port := StrToInt(porta);

    if trim(Anexo) <> '' then
    begin
      try
        TIdAttachmentFile.Create(mensagem.MessageParts, TFileName(Anexo));
      except
        MessageDlg('O sistema de auditoria encontrou um erro ao tentar anexar arquivo. Informe ao suporte.', mtInformation, [mbOK], 0);
      end;
    end;
    Msg := Msg + #13 + uVarGlobais.rRodapeEmail.licenca + #13 + uVarGlobais.rRodapeEmail.nomePc + #13 + uVarGlobais.rRodapeEmail.usuarioWindows + #13 + uVarGlobais.rRodapeEmail.serialMother + #13 + uVarGlobais.rRodapeEmail.ipLocal + #13;
    mensagem.Body.Clear;
    mensagem.Body.Add(Msg);
    cnxSMTP.UseEhlo := true;
    cnxSMTP.UseVerp := false;

    cnxSMTP.ReadTimeout := 10000;
    cnxSMTP.Connect;
    sleep(1000);
    cnxSMTP.Authenticate;
    sleep(1000);
    try
      if cnxSMTP.Connected then
      begin
        mensagem.Body.Text;
        cnxSMTP.Send(mensagem)
      end
      else
      begin
        // registrar o erro do envio do e-mail.
        MessageDlg('O sistema não consegue conectar-se com o seu provedor. Informe ao suporte.', mtInformation, [mbOK], 0);
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
          MessageDlg('O sistema de auditoria encontrou um erro ao tentar tratar msgs internas. Informe ao suporte.', mtInformation, [mbOK], 0);
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

    Result := size;

  finally

    Free;

  end;

end;

function PastaExist(pasta: string): Boolean;
begin
  Result := DirectoryExists(pasta);
end;

function ArquivoExist(arq: string): Boolean;
begin
  Result := FileExists(arq);
end;

function FormataCNPJ(CNPJ: string): string;
begin

  Result := Copy(CNPJ, 1, 2) + '.' + Copy(CNPJ, 3, 3) + '.' + Copy(CNPJ, 6, 3) + '/' + Copy(CNPJ, 9, 4) + '-' + Copy(CNPJ, 13, 2);

end;

function QueryToLog(Q: TFDQuery): string;
var
  i: Integer;
  r: string;
begin
  Result := Q.SQL.Text;
  for i := 0 to Q.Params.Count - 1 do
  begin
    case Q.Params.Items[i].DataType of
      ftString, ftDate, ftDateTime:
        r := QuotedStr(Q.Params[i].AsString);
    else
      r := Q.Params[i].AsString;
    end;
    Result := Q.Params.Items[i].Name;
  end;
end;

function GetVersionInfo(const AFileName: string): string;
var
  FileName: string;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  Result := EmptyStr;
  FileName := AFileName;
  UniqueString(FileName);
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
        if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
          Result := Concat(IntToStr(FI.dwFileVersionMS shr 16), '.', IntToStr(FI.dwFileVersionMS and $FFFF), '.', IntToStr(FI.dwFileVersionLS shr 16), '.', IntToStr(FI.dwFileVersionLS and $FFFF));
    finally
      FreeMem(VerBuf);
    end;
  end;
end;


function GetPeriodoSt(dtInicial , dtFinal :TDate): string;
begin

 Result := ' de ' + DateToStr(dtInicial) + ' até ' + DateToStr(dtFinal);

end;



procedure setDataServer(lsData: TDateTime);
begin
  FDataServidorDatabase := lsData;
end;

Function getDataServer(): TDateTime;
begin
  Result := FDataServidorDatabase;
end;



Function qtdDiasPeriodo(pDataInicial, pDataFinal: TDate): Integer;
begin

  Result :=  DaysBetween(pDataInicial,pDataFinal);

end;




{ TUserAtual }
{$REGION 'TUserAtual: Implementação...'}

class function TUserAtual.getLogin: string;
begin
  Result := FLogin;

end;

class function TUserAtual.getNameUser: string;
begin
  Result := FNameUser;
end;

class function TUserAtual.getPassword: string;
begin

  Result := FPassword;
end;

class function TUserAtual.getUserId: string;
begin

  Result := FIdUser;

end;

class procedure TUserAtual.setId(UserId: string);
begin
  FIdUser := UserId;
end;

class procedure TUserAtual.setLogin(lsLogin: string);
begin
  FLogin := lsLogin;
end;

class procedure TUserAtual.setNameUser(lsName: string);
begin
  FNameUser := lsName;
end;

class procedure TUserAtual.setPassword(lsPassword: string);
begin
  FPassword := lsPassword;

end;

  {$ENDREGION}


//
//  function varToStr(Value: Variant): String;
//begin
//  case TVarData(Value).VType of
//    varSmallInt,
//    varInteger   : Result := IntToStr(Value);
//    varSingle,
//    varDouble,
//    varCurrency  : Result := FloatToStr(Value);
//    varDate      : Result := FormatDateTime('dd/mm/yyyy', Value);
//    varBoolean   : if Value then Result := T else Result := F;
//    varString    : Result := Value;
//    else           Result := ;
//  end;
//end;



end.


