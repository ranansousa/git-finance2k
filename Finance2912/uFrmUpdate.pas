unit uFrmUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP,uUtil;

type
  TfrmUpdate = class(TForm)
    btnAtualizacao: TBitBtn;
    lbStatus: TLabel;
    pbDownload: TProgressBar;
    IdFTP: TIdFTP;
    PageControl1: TPageControl;
    tbsUpdate: TTabSheet;
    tbsConfig: TTabSheet;
    edtHost: TEdit;
    edtUsuario: TEdit;
    edtDiretorio: TEdit;
    edtSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnConfirma: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    lblVersaoLocal: TLabel;
    lblVersaoFtp: TLabel;
    procedure IdFTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdFTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure btnAtualizacaoClick(Sender: TObject);
    procedure carregaDadosRegistro();
    procedure configuraTIDFTP();
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FnTamanhoTotal: integer;

    function VerificarExisteConexaoComInternet: boolean;
    function ObterDiretorioDoExecutavel: string;
    function ConectarAoServidorFTP: boolean;
    function ObterNumeroVersaoLocal: smallint;
    function ObterNumeroVersaoFTP: smallint;
    procedure BaixarAtualizacao;
    procedure DescompactarAtualizacao;
    procedure AtualizarNumeroVersao;



  end;

var
  frmUpdate: TfrmUpdate;
  fileWeb: string;

implementation

uses
  IdException,
  // declarada para usar a fun��o "InternetGetConnectedState"
  WinInet,
  // declarada para acessar os arquivos INI
  IniFiles,
  // declarada para executar a linha de comando do 7-zip
  ShellAPI;

  var
  teste : String;

{$R *.dfm}

{ TForm1 }

function TfrmUpdate.VerificarExisteConexaoComInternet: boolean;
var
  nFlags: Cardinal;
begin
  // retorna True se houver conex�o com a internet
  result := InternetGetConnectedState(@nFlags, 0);
end;

function TfrmUpdate.ConectarAoServidorFTP: boolean;
begin
  // desconecta, caso tenha sido conectado anteriormente
  if IdFTP.Connected then
    IdFTP.Disconnect;

  try
    IdFTP.Connect;
    result := True;
  except
    On E:Exception do
    begin
      ShowMessage('Erro ao acessar o servidor de atualiza��o: ' + E.Message);
      result := False;
    end;
  end;
end;

procedure TfrmUpdate.configuraTIDFTP;
begin
  IdFTP := TIdFTP.Create(Self);
  IdFTP.Host := edtHost.Text;
  IdFTP.Username := edtUsuario.Text;
  IdFTP.Password := edtSenha.Text;
end;

function TfrmUpdate.ObterNumeroVersaoLocal: smallint;
var
  sNumeroVersao: string;
  oArquivoINI: TIniFile;
begin
  // abre o arquivo "VersaoLocal.ini"
  oArquivoINI := TIniFile.Create(ObterDiretorioDoExecutavel + 'VersaoLocal.ini');
  try
    // l� o n�mero da vers�o
    sNumeroVersao := oArquivoINI.ReadString('VersaoLocal', 'Numero', EmptyStr);

    // retira os pontos (exemplo: "1.0.0" para "100")
    sNumeroVersao := StringReplace(sNumeroVersao, '.', EmptyStr, [rfReplaceAll]);

    // converte o n�mero da vers�o para n�mero
    result := StrToIntDef(sNumeroVersao, 0);
  finally
    FreeAndNil(oArquivoINI);
  end;
end;

function TfrmUpdate.ObterNumeroVersaoFTP: smallint;
var
  sNumeroVersao: string;
  oArquivoINI: TIniFile;
begin
  // deleta o arquivo "VersaoFTP.ini" do computador, caso exista,
  // evitando erro de arquivo j� existente
  if FileExists(ObterDiretorioDoExecutavel + 'VersaoWeb.ini') then
    DeleteFile(ObterDiretorioDoExecutavel + 'VersaoWeb.ini');

  // baixa o arquivo "VersaoFTP.ini" para o computador
  IdFTP.Get('update/VersaoWeb.ini', ObterDiretorioDoExecutavel + 'VersaoWeb.ini', True, True);

  // abre o arquivo "VersaoFTP.ini"
  oArquivoINI := TIniFile.Create(ObterDiretorioDoExecutavel + 'VersaoWeb.ini');
  try
    // l� o n�mero da vers�o
    sNumeroVersao := oArquivoINI.ReadString('VersaoWeb', 'Numero', EmptyStr);

    // retira os pontos (exemplo: "1.0.1" para "101")
    sNumeroVersao := StringReplace(sNumeroVersao, '.', EmptyStr, [rfReplaceAll]);

    // converte o n�mero da vers�o para n�mero
    result := StrToIntDef(sNumeroVersao, 0);
  finally
    FreeAndNil(oArquivoINI);
  end;
end;

procedure TfrmUpdate.BaixarAtualizacao;

begin
fileWeb := 'Finance.rar';

  try

  lbStatus.Visible :=true;
  pbDownload.Visible :=true;
  lbStatus.Caption := 'Aguarde...';
  Application.ProcessMessages;

    // deleta o arquivo "Atualizacao.rar", caso exista,
    // evitando erro de arquivo j� existente
    if FileExists(ObterDiretorioDoExecutavel + fileWeb) then
      DeleteFile(ObterDiretorioDoExecutavel + fileWeb);

    // obt�m o tamanho da atualiza��o e preenche a vari�vel "FnTamanhoTotal"
    FnTamanhoTotal := IdFTP.Size('update/'+fileWeb);

    // faz o download do arquivo "Atualizacao.rar"
    IdFTP.Get('update/'+fileWeb,
      ObterDiretorioDoExecutavel + fileWeb, True, True);
  except
    On E:EIdConnClosedGracefully do
      Exit;

    On E:Exception do
    begin
      ShowMessage('Erro ao baixar a atualiza��o: ' + E.Message);

      // interrompe a atualiza��o
      Abort;
    end;
  end;
end;

procedure TfrmUpdate.DescompactarAtualizacao;
var
 sNomeExecutavel, sNomeArquivoAtualizacao: string;
begin
sNomeExecutavel := 'Finance.jar';
  // deleta o backup anterior, ou melhor, de vers�es anteriores,
  // evitando erro de arquivo j� existente
  if FileExists(ObterDiretorioDoExecutavel + 'Finance_Backup.exe') then
    DeleteFile(ObterDiretorioDoExecutavel + 'Finance_Backup.exe');

  // Renomeia o execut�vel atual (desatualizado) para "Sistema_Backup.exe"
  RenameFile(ObterDiretorioDoExecutavel + sNomeExecutavel,
    ObterDiretorioDoExecutavel + 'Finance_Backup.exe');

  // armazena o nome do arquivo de atualiza��o em uma vari�vel
  sNomeArquivoAtualizacao := ObterDiretorioDoExecutavel + fileWeb;

  // executa a linha de comando do 7zip para descompactar o arquivo baixado
  ShellExecute(0, nil, '7z',  PWideChar(' e -aoa ' +
    sNomeArquivoAtualizacao +' -o' + ObterDiretorioDoExecutavel), '', SW_SHOW);
end;

procedure TfrmUpdate.FormCreate(Sender: TObject);
begin
 carregaDadosRegistro;
 //configuraTIDFTP;
 lblVersaoLocal.Caption := 'Vers�o Atual do Sistema :  '+IntToStr(ObterNumeroVersaoLocal);
  lblVersaoFtp.Caption := '';
  lbStatus.Visible :=false;
  pbDownload.Visible :=false;
end;

procedure TfrmUpdate.AtualizarNumeroVersao;
var
  oArquivoLocal, oArquivoFTP: TIniFile;
  sNumeroNovaVersao: string;
begin
  // abre os dois arquivos INI
  oArquivoFTP := TIniFile.Create(ObterDiretorioDoExecutavel + 'VersaoWeb.ini');
  oArquivoLocal := TIniFile.Create(ObterDiretorioDoExecutavel + 'VersaoLocal.ini');
  try
    // obt�m o n�mero da nova vers�o no arquivo "VersaoFTP.ini"...
    sNumeroNovaVersao := oArquivoFTP.ReadString('VersaoWeb', 'Numero', EmptyStr);
    // ... e grava este n�mero no arquivo "VersaoLocal.ini"
    oArquivoLocal.WriteString('VersaoLocal', 'Numero', sNumeroNovaVersao);
  finally
    FreeAndNil(oArquivoFTP);
    FreeAndNil(oArquivoLocal);
  end;
end;

procedure TfrmUpdate.btnAtualizacaoClick(Sender: TObject);
var
  nNumeroVersaoLocal, nNumeroVersaoFTP: smallint;
begin
  // desativa o bot�o de atualiza��o para evitar 2 ou mais conex�es
  btnAtualizacao.Enabled := False;
  lbStatus.Caption := 'Aguarde...';
  Application.ProcessMessages;

  try
    // se n�o houver conex�o com a internet, sai do m�todo
    if not VerificarExisteConexaoComInternet then
      Exit;

    // se n�o houver conex�o com o servidor FTP, sai do m�todo
    if not ConectarAoServidorFTP then
      Exit;

    // obt�m os n�meros das vers�es (local e FTP)
    nNumeroVersaoLocal := ObterNumeroVersaoLocal;
    nNumeroVersaoFTP := ObterNumeroVersaoFTP;

    lblVersaoFtp.Caption   := 'Vers�o encontrada na WEB  :  '+ IntToStr(nNumeroVersaoFTP);
    Application.ProcessMessages;

    // faz uma compara��o para identificar se � necess�rio baixar a atualiza��o
    if nNumeroVersaoLocal < nNumeroVersaoFTP then
    begin
      // processa a atualiza��o
      BaixarAtualizacao;
      DescompactarAtualizacao;
      AtualizarNumeroVersao;

      ShowMessage('O sistema foi atualizado com sucesso!. A Aplica��o ser� encerrada.');

      // Reinicia a aplica��o para abrir o novo execut�vel
      ShellExecute(Handle, nil, PChar(Application.ExeName), '', nil, SW_SHOWNORMAL);

      Application.Terminate;
    end
    else
      ShowMessage('O sistema j� est� atualizado!');
  finally
    lbStatus.Caption := EmptyStr;
    btnAtualizacao.Enabled := True;
  end;
end;

procedure TfrmUpdate.btnConfirmaClick(Sender: TObject);
begin
 GravarRegistros('Pempec Enterprise', 'Finance', 'HostWeb',edtHost.Text);
 GravarRegistros('Pempec Enterprise', 'Finance','UserNameWeb',edtUsuario.Text);
 GravarRegistros('Pempec Enterprise', 'Finance','PasswordWeb',edtSenha.Text);
 GravarRegistros('Pempec Enterprise', 'Finance','PathWeb',edtDiretorio.Text);
end;

procedure TfrmUpdate.carregaDadosRegistro;
begin
  edtHost.Text      := LerRegistro('Pempec Enterprise', 'Finance', 'HostWeb');
  edtUsuario.Text   := LerRegistro('Pempec Enterprise', 'Finance','UserNameWeb');
  edtSenha.Text     := LerRegistro('Pempec Enterprise', 'Finance','PasswordWeb');
  edtDiretorio.Text := LerRegistro('Pempec Enterprise', 'Finance','PathWeb');

end;

procedure TfrmUpdate.IdFTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
var
  nTamanhoTotal, nTransmitidos, nPorcentagem: real;
begin
  if FnTamanhoTotal = 0 then
    Exit;

  // obt�m o tamanho total do arquivo em bytes
  nTamanhoTotal := FnTamanhoTotal div 1024;

  // obt�m a quantidade de bytes j� baixados
  nTransmitidos := AWorkCount div 1024;

  // calcula a porcentagem de download
  nPorcentagem := (nTransmitidos * 100) / nTamanhoTotal;

  // atualiza o componente TLabel com a porcentagem
  lbStatus.Caption := 'Download: ' +
    Format('%s%%', [FormatFloat('##0', nPorcentagem)]);

  // atualiza a barra de preenchimento do componente TProgressBar
  pbDownload.Position := AWorkCount div 1024;

  // processa as mensagens pendentes do sistema para atualizar os componentes
  Application.ProcessMessages;
end;

procedure TfrmUpdate.IdFTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  pbDownload.Max := FnTamanhoTotal div 1024;
end;

function TfrmUpdate.ObterDiretorioDoExecutavel: string;
begin
  result := ExtractFilePath(Application.ExeName);
end;
 {
function TfrmUpdate.Validate: Boolean;
begin

  if xSerial.IsEmpty then
    raise Exception.Create
      ('N�o foram encontradas aplica��es a serem atualizadas.');
  if FHost = EmptyStr then
    raise Exception.Create('O Host deve ser informado!!!');
  if FUserName = EmptyStr then
    raise Exception.Create('O Nome do Usuario deve ser informado!!!');
  if FPassWord = EmptyStr then
    raise Exception.Create('A Senha deve ser informada!!!');
  if FDirectory = EmptyStr then
    raise Exception.Create('O Diret�rio deve ser informado!!!');
  if FFileName = EmptyStr then
    raise Exception.Create('O Nome do Arquivo deve ser informado!!!');
  if FTargetFile = EmptyStr then
    raise Exception.Create('O Destino da Arquivo deve ser informado!!!');

  Result := True;
end;
    }

end.
