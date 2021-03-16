unit uFrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, iniFiles, DateUtils,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Zlib,UMostraErros, udmConexao, uFrmPrincipal,uDMOrganizacao,uDMUsuarioConsulta;

  procedure configurarDB(Arquivo : TIniFile);
  procedure executarAplicacao(Arquivo : TIniFile);
  procedure AtualizarExecutavel;

type
  TfrmLogin = class(TForm)
    edtSenha: TEdit;
    btnEntrar: TBitBtn;
    edtLogin: TEdit;
    Image1: TImage;
    lblBoasVindas: TLabel;
    lblSelectOrg: TLabel;
    cbbOrganizacoes: TComboBox;
    procedure btnEntrarClick(Sender: TObject);
    procedure cbbOrganizacoesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private

   numberError: string;
    pid: string;
    userValidado: Boolean;
    FsListaIdOrganizacoes: TStringList;
    FsListaIdUsuarios: TStringList;
    ajustaFormLigado : Boolean;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    function conectarBaseDados(): Boolean;
    procedure AjustaForm;

  public

  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses uUtil;


procedure TfrmLogin.btnEntrarClick(Sender: TObject);

var
  loMostraErros: TFMostraErros;
begin
  loMostraErros := TFMostraErros.Create(Self);
  try

//    loMostraErros.caption := 'Aviso';
//
//    loMostraErros.Add('v� pra porra');
//    loMostraErros.Add('v� pra porra 1');
//    loMostraErros.Add('v� pra porra 2');
//    loMostraErros.Add('v� pra porra 3');
//    loMostraErros.Add('v� pra porra 4');
//    loMostraErros.Add('v� pra porra 5');
//
//
//    if loMostraErros.Count > 0 then begin
//      loMostraErros.ShowModal;
//    end;
  finally
    FreeAndNil(loMostraErros);
  end;

  userValidado := False;

  if dmUsuarioConsulta.validarLogin(StrToInt(pid), edtLogin.Text, edtSenha.Text) then
  begin
    dmOrganizacao.obterDataServidor;  // seta a data atual originada do server de banco de dados
    edtLogin.Enabled := False;
    edtSenha.Enabled := False;
    edtLogin.Text := '';
    edtSenha.Text := '';

    lblBoasVindas.Visible := True;
    lblBoasVindas.Caption := 'Seja bem vindo(a). Selecione uma organiza��o para trabalhar.';
    cbbOrganizacoes.Enabled := True;
        //cbxOrganizacoes.Focused := True;
    lblSelectOrg.Visible := True;
    lblSelectOrg.Caption := 'Selecione uma organiza��o.';
  end
  else
  begin
    cbbOrganizacoes.Enabled := False;
    lblSelectOrg.Visible := False;
    lblBoasVindas.Visible := False;
    edtSenha.Text := '';
    ShowMessage('Login/Senha incorretos.');
  end;


end;


procedure ExecutarAplicacao(Arquivo : TIniFile);
var
  Hora: Integer;
  Data : TDateTime;
  Hash, Serial : String;
begin

    Hora := HourOf(Now);
    Data := Date();
   // Serial := SerialHD(Serial);
    Hash := IntToStr(Hora) + DateToStr(Data) + Serial;

end;



procedure cbxOrganizacoesChange(Sender: TObject);
var
  cnpj, pid: string;
  indice: Integer;
begin

  try


    if (cbbOrganizacoes.ItemIndex > (-1)) then
    begin

      indice := (cbbOrganizacoes.ItemIndex);
      pid := FsListaIdOrganizacoes[indice];

      if not (dmConexao.Conn.Connected) then
      begin
        dmConexao.conectarBanco;
      end;

      if (dmConexao.Conn.Connected) then
      begin
        dmOrganizacao.carregarDadosEmpresa(pid);
        pid := dmOrganizacao.qryDadosEmpresa.FieldByName('ID_ORGANIZACAO').AsString;
        cnpj := Trim(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
    //setando dados da organizacao selecionada
        uUtil.TOrgAtual.setId(pid);
        uUtil.TOrgAtual.setCNPJ(cnpj);
        uUtil.TOrgAtual.setFantasia(dmOrganizacao.qryDadosEmpresa.FieldByName('FANTASIA').AsString);
        uUtil.TOrgAtual.setRazaoSocial(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL').AsString);



//    lblPathSGBD.Caption := 'PATH BANCO ' + uUtil.TOrgAtual.getPathSGBD;
        stat1.Panels[1].Text := 'USER : > ' + TUserAtual.getNameUser;
        stat1.Panels[2].Text := 'ORG : > ' + uUtil.TOrgAtual.getFantasia;
        stat1.Panels[3].Text := 'DATA : > ' + FormatDateTime('dd/mm/yyyy', uUtil.getDataServer);
        stat1.Panels[5].Text := 'BANCO DE DADOS : > ' + uUtil.TOrgAtual.getPathSGBD;

        if not (pid = '') then
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

    end
    else
    begin
      acessoMenu(false);
      MessageDlg('Dados incorretos...', mtWarning, [mbOK], 0);
    end;
  except
    on e: Exception do
      MessageDlg('Problemas ao selecionar uma empresa...', mtWarning, [mbOK], 0);
  end;

end;


eprocedure TfrmLogin.cbbOrganizacoesChange(Sender: TObject);
begin

eprocedure TfrmLogin.FormCreate(Sender: TObject);
begin

end;

nd;

nd.
