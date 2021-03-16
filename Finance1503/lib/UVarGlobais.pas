unit uVarGlobais;

interface

uses
  Windows, SysUtils, SqlExpr, Dialogs, Classes,
  Forms, Controls, ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Error,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB;

// type
// TTipoInscMf = (tpFisica, tpJuridica, tpCEI);

type
  TInfoLogin = record
    sIdUsuario: String;
    sNomeUsuario: String;
    sNomeRealUsuario: String;
    sSenha: String;
    bLoginOk: boolean;
    sNomeReal: String;
    sIdPerfil: String;
    sPerfil: String;
    bAdministrador: boolean;
    dDataTrocaSenha: TDate;
    bAtivo: boolean;
    bExpira: boolean;
    dDtExpira: TDate;
    dLoginDataHora: TDateTime;
    dLogoutDataHora: TDateTime;
    iNumeroDeTentativas: Integer;
    sIdPrograma: String;
    sPrograma: String;
  end;

  TInfoConexao = record
    // sConnectionName : String; //ShortString
    // sDriverName : String; //ShortString
    // sGetDriverFunc : String; //ShortString
    // sLibraryName : String; //ShortString
    // aParams : array[0..13] of String; //ShortString
    // sVendorLib : String; //ShortString
    bFireDac: boolean;
    iTransacao: LongWord;
  end;

  // Dados do cliente Wellsoft para sair no assunto dos e-mails de erro, validador, etc.
  TInfoResponsavel = record
    sNome: String; // ShortString
    sEmail: String; // ShortString
    sInscMf: String; // ShortString
  end;

  TInfoAplicacao = record
    sIdPrograma: String; // ShortString
    sNomeExe: String; // ShortString
    sEstacao: String; // ShortString
    sVersaoExe: String; // ShortString
    iVersaoDDL: Integer;
    dDataExe: TDateTime;
    sPathExe: String;
    sPathIni: String;
    sPathAppData: String;
    sPathWsBdPessoal: String;
    sPathWsBdFiscal: String;
    sPathBancoDados: String;
    iSerial: Int64;
    iRegistro: Cardinal;
    iRegistroCalculado: Cardinal;
    iRegistroInformado: Cardinal;
    bProcessaMsg: boolean; // Para executar ProcessaMsg (passar campo com enter)
    bTkAtalhos: boolean;
    // bTkAtalhos n�o deixa as teclas F2...F6 serem executadas duas vezes
    bF9: boolean; // bF9 n�o deixa a calculadora ser executada duas vezes
    dblResultCalc: Double;
    // Variav�l utilizada para retornar os valores da Calculadora F9
    sNomeComputador: String; // ShortString
    iScreenHeight: word; // Altura das telas filhas
    iScreenWidth: word; // Largura das telas filhas
    iBloqueio: ShortInt;
    // -1 = N�o bloqueado, 0 = Bloqueio parcial,  1 = Bloqueio total, 2-Falta de atualiza��o do programa
    dDtBloq: TDate; // Data do bloqueio
    sMsgBloq: String; // ShortString //Mensagem do bloqueio
    bAlertaBloq: boolean;
    // Caso seja verdadeiro, n�o blequeia o uso do sistema. Mostra apenas a mensagem
    bSysCorrompido: boolean; // Se o arquivo aplicacao.sys est� corrompido.
    sExeTeste: String; // ShortString
    iDiasGeraSys: SmallInt;
    // Esta variavel � alimentada na rotina fGeraSys e cont�m a quantidade de dias que foi gerado o arquivo sys
    StBar: TStatusBar;
    { Guarda a referencia para a StatusBar do form principal. Pois, quando calcula a folha eu preciso passar a StatusBar por refer�ncia para o m�todo AtualizaStatusBar para atualizar a data. }
    sFileVersion: String;
    { Guarda a vers�o do aplicativo. Pois, quando calcula a folha eu preciso passar para o m�todo AtualizaStatusBar. }
    { As vari�veis strListTabelasGerais e strListTabelasEspecificas
      devem ser criadas no create do Form principal da aplica��o atr�ves de
      chamada ao m�todo TabelasDaAplicacao. Os strLst com
      o sufixo Amigavel, cont�m os nomes amig�veis das tabelas.
      O StrLst com sufixo Gerais, guarda os nomes das tabelas que s�o utilizadas
      por todas as aplica��es. O StrLst com sufixo especificas, guarda os nomes
      das tabelas espec�ficas da aplica��o/ }
    strLstTabelasGerais: TStringList;
    strLstTabelasGeraisAmigavel: TStringList;
    strLstTabelasEspecificas: TStringList;
    strLstTabelasEspecificasAmigavel: TStringList;

    strLstTabelasMegaPessoal: TStringList;

    strLstTabelasMegaFiscal: TStringList;

    { Tabelas compartilhadas, como PESSOA, REGIMES, SOCIOS, etc, n�o podem ser
      recuperadas se o usu�rio utiliza mais de um programa }
    strLstTabelasCompartilhadas: TStringList;
    strLstTabelasCompartilhadasAmigavel: TStringList;

    { Caminho e nome do arquivo que apresenta as modifica��es do aplicativo. }
    sArquivoModificacoes: String;
    iLastKey: Integer;
    iOriginalLastKey: Integer;
    dDataOperacao: TDate;
    strLstLogTempo: TStringList;
  end;

  TInfoEureka = record
    sEMailAddresses: String; // ShortString
    sEMailSubject: String; // ShortString
    sSMTPFrom: String; // ShortString
    sSMTPHost: String; // ShortString
    iSMTPPort: Integer;
    sSMTPUserID: String; // ShortString
    sSMTPPassword: String; // ShortString
  end;

  TRodapeEmail = record
    licenca, nomePc, usuarioWindows, serialMother, ipLocal, nomeUsuario: String;
  end;

    THost = record
    conta, senha, host, porta, autentica: String;
    isEnable: boolean;
  end;

  // Dados da WellSoft
  TInfoEmpresa = record
    sNome: String; // ShortString
    sNomeAbreviado: String; // ShortString
    sInscMf: String;
    sEndereco: String;
    sFone: String; // ShortString
    sFax: String; // ShortString
    sEmail: String; // ShortString
    sHomePage: String; // ShortString
    sDados: String; // ShortString
    sFTPHost: String; // ShortString
    sFTPUsername: String; // ShortString
    sFTPPassword: String; // ShortString
  end;

  { Neste registro cont�m os dados da empresa acessada pelo usu�rio. Ex: o usu�rio logou no
    programa contabil e entrou na empresa Modelo. No registro rSessaoInfo conter� as informa��es
    da empresa Modelo e tudo o mais relacionado � aquela sess�o }
  {
    TInfoPessoa = record
    sNome : String; //ShortString
    sInscMfCliente : String; //ShortString
    tTpInscMfCliente : TTipoInscMf;
    sTpInscMfCliente : String; //ShortString
    end;
  }

  // Registro de vari�veis auxiliares
  TInfoAuxiliares = record
    iPCGrauMax: Integer; // Plano de contas - Grau M�ximo
    sPCEstrutura: String; // ShortString //Plano de contas - Estrutura
    sPCMascara: String; // ShortString //Plano de contas - M�scara
    sContaSel: String;
    // ShortString  //Conta selecionada do plano de contas em FSelConta
    sDgContaSel: String;
    // ShortString //D�gito da conta selecionada em FSelConta
    iCdHistSel: Integer; // C�digo de hist�rico selecionado em FSelHist
    sIdContaSel: String; // ShortString //ID da conta selecionada
    sContaMasc: String; // ShortString //A conta cont�bil com a m�scara
    sGrupoCli: String; // ShortString //Grupo de clientes
    sGrupoFor: String; // ShortString //Grupo de fornecedores
    bMostraGrupo: boolean;
    // Variavel para controlar de FSelConta deve mostrar somente grupos (clientes,fornecedores)
    sGrupo: String;
    // ShortString //Variavel para controlar qual o grupo deve ser mostrado em FSelConta (clientes,fornecedores)
    wTeclaDigitada: word;
    iTamMaxArqLogo: Int64;
    { Tamanho m�ximo de uma arquivo de Logo para ser gravado no Firebird }
    iTamMaxArqFoto: Int64;
    { Tamanho m�ximo de uma arquivo de Foto para ser gravado no Firebird }

    // Nesta variavel ser� armazenada as informa��es sobre mes e ano para calculo ou lan�amento.
    // Ex: a data inicial e final para calculo da folha de pagamento
    // DataOperacao : TDataInfo;
    // sIdTabelaGeral : String; //ShortString
  end;

var
  rInfoConexao: TInfoConexao;
  rInfoAplicacao: TInfoAplicacao;
  rInfoEureka: TInfoEureka;
  rInfoEmpresa: TInfoEmpresa;
  rInfoResponsavel: TInfoResponsavel;
  rInfoLogin: TInfoLogin;
  rRodapeEmail: TRodapeEmail;
  rHost: THost;

function GetDataHoraServidorBD(Conexao: TFDConnection): TDateTime;
procedure IniVarGlobais(); // Inicializa as variaveis globais
procedure IniRodapeEmail(licenca, ip, nomePc, usuarioWindows, serialMae, nomeUser: String); { Inicializa as variaveis globais para rodape do email }
procedure IniHostEmail(conta, senha, host, porta, autentica: String);
{ Inicializa as variaveis globais para host do email }
procedure IniVarEmpresa(sqlConexao: TFDConnection); overload;
// Inicializa as variaveis com os dados da empresa
procedure IniVarEmpresa(); overload;
// Inicializa as variaveis com os dados da empresa para o Megacontabil que n�o tem SQLCONEXAO

implementation

function GetDataHoraServidorBD(Conexao: TFDConnection): TDateTime;
var
  oQryDataHora: TFDQuery;
  comando: String;

begin
  comando := 'select current_timestamp as data from rdb$database';

  oQryDataHora := TFDQuery.Create(nil);
  oQryDataHora.Connection := Conexao;
  oQryDataHora.Connection.Connected;
  oQryDataHora.Close;
  oQryDataHora.sql.Add(comando);
  oQryDataHora.Open;
  Result := oQryDataHora.FieldByName('DATA').AsDatetime;
  oQryDataHora.Close;
  oQryDataHora.Free;
end;

Procedure IniHostEmail(conta, senha, host, porta, autentica: String);
begin
  rHost.isEnable := False;

  if not (conta = String.Empty) then
  begin
    if not (senha = String.Empty) then
    begin
      if not (host = String.Empty) then
      begin
        if not (porta = String.Empty) then
        begin
          if not (autentica = String.Empty) then
          begin
            rHost.autentica := autentica;
            rHost.conta := conta;
            rHost.senha := senha;
            rHost.porta := porta;
            rHost.host := host;
            rHost.isEnable := True;

          end;

        end;

      end;

    end;

  end;

end;

procedure IniRodapeEmail(licenca, ip, nomePc, usuarioWindows, serialMae, nomeUser: String); { Inicializa as variaveis globais }
begin
  { Rodape email }
  {
    rRodapeEmail.licenca := uUtil.GetLicenca;
    rRodapeEmail.nomePc := uUtil.NomeComputador;
    rRodapeEmail.usuarioWindows := uUtil.GetUserFromWindows;
    rRodapeEmail.serialMother := uUtil.GetSerialMotherBoard;
    rRodapeEmail.ipLocal := uutil.GetIp; }

  rRodapeEmail.licenca := licenca;
  rRodapeEmail.nomePc := nomePc;
  rRodapeEmail.usuarioWindows := usuarioWindows;
  rRodapeEmail.serialMother := serialMae;
  rRodapeEmail.ipLocal := ip;
  rRodapeEmail.nomeUsuario := nomeUser;



end;

procedure IniVarGlobais(); { Inicializa as variaveis globais }
begin


end;

procedure IniVarEmpresa(sqlConexao: TFDConnection); overload;
// Inicializa as variaveis com os dados da empresa
var
  loQryParametros, loQryControleVersaoDDL, loQryClienteDados: TFDQuery;
begin
  loQryParametros := TFDQuery.Create(nil);
  loQryClienteDados := TFDQuery.Create(nil);
  loQryControleVersaoDDL := TFDQuery.Create(nil);
  try
    { marquei o SetDisableAutoDaylightTimeSet porque na m�quina de D. Meire est� dando erro }
    // SetDisableAutoDaylightTimeSet(false); //Desabilita o hor�rio de ver�o

    loQryClienteDados.Connection := sqlConexao;
    loQryClienteDados.sql.Add
      ('SELECT FIRST 1 CD.INSCMF,CD.NOME,CD.E_MAIL FROM CLIENTE_DADOS CD');
    loQryClienteDados.Open;

    rInfoResponsavel.sNome := loQryClienteDados.FieldByName('NOME').AsString;
    rInfoResponsavel.sEmail := loQryClienteDados.FieldByName('E_MAIL').AsString;
    rInfoResponsavel.sInscMf := loQryClienteDados.FieldByName('INSCMF')
      .AsString;

  finally
    FreeAndNil(loQryParametros);
    FreeAndNil(loQryClienteDados);
    FreeAndNil(loQryControleVersaoDDL);
  end;
end;

procedure IniVarEmpresa(); overload;
// Inicializa as variaveis com os dados da empresa  para o Megacontabil que n�o tem SQLCONEXAO
begin


end;

end.
