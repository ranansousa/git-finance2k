unit uContaBancariaCreditoDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uOrganizacaoModel,
  uContaBancariaCRModel,uTipoOperacaoBancariaModel,uFuncionarioModel,uTituloReceberModel,uLoteContabilModel,uUsuarioModel,
  uTipoOperacaoBancariaDAO,uFuncionarioDAO,uTituloReceberDAO,uLoteContabilDAO,uUsuarioDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uContaBancariaModel,uContaBancariaDAO, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


type
 TContaBancariaCreditoDAO = class
  private
  class function getModel (query :TFDQuery) : TContaBancariaCRModel;

  public

    class function Insert(tContaCR :TContaBancariaCRModel): Boolean;
    class function obterPorID(tContaCR :TContaBancariaCRModel): TContaBancariaCRModel;
    class function Delete(tContaCR :TContaBancariaCRModel): Boolean;
    class function Update(tContaCR :TContaBancariaCRModel): Boolean;
    class function obterSaldoAnterior(tConta :TContaBancariaModel; pDataInicial :TDateTime) : Currency;
    class function obterSaldoPeriodo(tConta :TContaBancariaModel; pDataInicial, pDataFinal :TDateTime) : Currency;
    class function obterTodosCreditos(tConta :TContaBancariaModel; pDataInicial, pDataFinal :TDateTime) : TFDQuery;

  end;

implementation

{ TContaBancariaCreditoDAO }

class function TContaBancariaCreditoDAO.Delete(  tContaCR: TContaBancariaCRModel): Boolean;
var
  qryDelete: TFDQuery;
  xResp: Boolean;
begin
  xResp := False;
  dmConexao.conectarBanco;
  qryDelete := TFDQuery.Create(nil);

  try
    try


        qryDelete.Close;
        qryDelete.Connection := dmConexao.conn;
        qryDelete.SQL.Clear;
        qryDelete.SQL.Add('DELETE FROM CONTA_BANCARIA_CREDITO  '  );
        qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTA_BANCARIA_CREDITO = :PID '  );
        qryDelete.ParamByName('PIDORGANIZACAO').AsString := tContaCR.FIDorganizacao;
        qryDelete.ParamByName('PID').AsString := tContaCR.FID;
        qryDelete.Open;

      qryDelete.ExecSQL;
      xResp := True;
    //o comit fica na transacao

    except
      xResp := False;
      raise Exception.Create('Erro ao tentar DELETAR CBC');

    end;

  finally
    if Assigned(qryDelete) then
    begin
      FreeAndNil(qryDelete);

    end;

  end;
end;

class function TContaBancariaCreditoDAO.getModel(  query: TFDQuery): TContaBancariaCRModel;
var
 contaDB : TContaBancariaCRModel;
begin
      contaDB                 := TContaBancariaCRModel.Create;
      contaDB.FcontaBancaria  := TContaBancariaModel.Create;
      contaDB.Fusuario        := TUsuarioModel.Create;
      contaDB.FtipoOperacao   := TTipoOperacaoBancariaModel.Create;
      contaDB.FloteContabil   := TLoteContabilModel.Create;
      contaDB.FtituloReceber  := TTituloReceberModel.Create;
      contaDB.Fresponsavel    := TFuncionarioModel.Create;
  try
    if not query.IsEmpty then
    begin
      contaDB.FID               := query.FieldByName('ID_CONTA_BANCARIA_CREDITO').AsString;
      contaDB.FIDorganizacao    := query.FieldByName('ID_ORGANIZACAO').AsString;
      contaDB.FIDcontaBancaria  := query.FieldByName('ID_CONTA_BANCARIA').AsString;
      contaDB.FIDusuario        := query.FieldByName('ID_USUARIO').AsInteger;
      contaDB.FIDTOB            := query.FieldByName('ID_TIPO_OPERACAO_BANCARIA').AsString;
      contaDB.FIDResponsavel    := query.FieldByName('ID_RESPONSAVEL').AsString;
      contaDB.FIDTR             := query.FieldByName('ID_TITULO_RECEBER').AsString;
      contaDB.FIDloteDeposito   := query.FieldByName('ID_LOTE_DEPOSITO').AsString;
      contaDB.FIDloteContabil   := query.FieldByName('ID_LOTE_CONTABIL').AsString;

      contaDB.Fobservacao       := query.FieldByName('OBSERVACAO').AsString;
      contaDB.FtipoLancamento   := query.FieldByName('TIPO_LANCAMENTO').AsString;
      contaDB.Fdescricao        := query.FieldByName('DESCRICAO').AsString;
      contaDB.Fidentificacao    := query.FieldByName('IDENTIFICACAO').AsString;
      contaDB.FdataRegistro     := query.FieldByName('DATA_REGISTRO').AsDateTime;
      contaDB.FdataMovimento    := query.FieldByName('DATA_MOVIMENTO').AsDateTime;
      contaDB.Fvalor            := query.FieldByName('VALOR').AsCurrency;


      try
      contaDB.FcontaBancaria.FIDorganizacao   := contaDB.FIDorganizacao;
      contaDB.FtipoOperacao.FIDorganizacao    := contaDB.FIDorganizacao;
      contaDB.FloteContabil.FIDorganizacao    := contaDB.FIDorganizacao;
      contaDB.FtituloReceber.FIDorganizacao     := contaDB.FIDorganizacao;
      contaDB.Fresponsavel.FIDorganizacao     := contaDB.FIDorganizacao;

      contaDB.Fusuario.FID        := (contaDB.FIDusuario);
      contaDB.FcontaBancaria.FID  := contaDB.FIDcontaBancaria;
      contaDB.FtipoOperacao.FID   := contaDB.FIDTOB;
      contaDB.FloteContabil.FID   := contaDB.FIDloteContabil;
      contaDB.FtituloReceber.FID  := contaDB.FIDTR;
      contaDB.Fresponsavel.FID    := contaDB.FIDResponsavel;

      contaDB.FcontaBancaria  := TContaBancariaDAO.obterPorID(contaDB.FcontaBancaria);
      contaDB.Fusuario        := TUsuarioDAO.obterPorID(contaDB.Fusuario);
      contaDB.FtipoOperacao   := TTipoOperacaoBancariaDAO.obterPorID(contaDB.FtipoOperacao);
      contaDB.FloteContabil   := TLoteContabilDAO.obterPorID(contaDB.FloteContabil);
      contaDB.FtituloReceber  := TTituloReceberDAO.obterPorID(contaDB.FtituloReceber);
      contaDB.Fresponsavel    := TFuncionarioDAO.obterPorID(contaDB.Fresponsavel);
      except
        raise Exception.Create('Erro ao obter detalhes da conta bancaria credito');

      end;
  end;

except

  raise Exception.Create('Erro ao converter CBC');
 end;

  Result := contaDB;

end;

class function TContaBancariaCreditoDAO.Insert(tContaCR: TContaBancariaCRModel): Boolean;
var
cmdSql:string;
qryInsert : TFDQuery;
xResp :Boolean;
begin
  xResp := False;
  dmConexao.conectarBanco;
  qryInsert := TFDQuery.Create(nil);
  try
    try

    cmdSql := ' INSERT INTO CONTA_BANCARIA_CREDITO '+
              ' (ID_CONTA_BANCARIA_CREDITO, ID_ORGANIZACAO, ID_CONTA_BANCARIA, '+
              ' ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, ID_TITULO_RECEBER, '+
              ' ID_LOTE_DEPOSITO, ID_LOTE_CONTABIL, ID_USUARIO, TIPO_LANCAMENTO, '+
              ' OBSERVACAO, DESCRICAO, VALOR, DATA_REGISTRO, DATA_MOVIMENTO, IDENTIFICACAO )'+
              ' VALUES (:PID, :PIDORGANIZACAO, :PIDCONTABANCARIA, '+
              ' :PIDTOB, :PIDRESP, :PIDTR, '+
              ' :PIDLOTEDEPOSITO, :PIDLOTECONTABIL, :PIDUSUARIO, :PTIPOLANCAMENTO, '+
              ' :POBS, :PDESCRICAO, :PVALOR,:PDTREGISTRO, :PDTMOVIMENTO, :PIDENTIFICACAO  ) ';

      qryInsert.Close;
      qryInsert.Connection := dmConexao.conn;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add(cmdSql);
      qryInsert.ParamByName('PID').AsString               := tContaCR.FID;
      qryInsert.ParamByName('PIDORGANIZACAO').AsString    := tContaCR.FIDorganizacao;
      qryInsert.ParamByName('PIDCONTABANCARIA').AsString  := tContaCR.FIDcontaBancaria;
      qryInsert.ParamByName('PIDTOB').AsString            := tContaCR.FIDTOB;
      qryInsert.ParamByName('PIDRESP').AsString           := tContaCR.FIDResponsavel;
      qryInsert.ParamByName('PIDTR').AsString             := tContaCR.FIDTR;
      qryInsert.ParamByName('PIDLOTECONTABIL').AsString   := tContaCR.FIDloteContabil;
      qryInsert.ParamByName('PIDLOTEDEPOSITO').AsString   := tContaCR.FIDloteDeposito;
      qryInsert.ParamByName('PIDUSUARIO').AsInteger       := tContaCR.FIDusuario;
      qryInsert.ParamByName('PTIPOLANCAMENTO').AsString   := tContaCR.FtipoLancamento;
      qryInsert.ParamByName('POBS').AsString              := tContaCR.Fobservacao;
      qryInsert.ParamByName('PDESCRICAO').AsString        := tContaCR.Fdescricao;
      qryInsert.ParamByName('PIDENTIFICACAO').AsString    := tContaCR.Fidentificacao;
      qryInsert.ParamByName('PDTREGISTRO').AsDateTime     := tContaCR.FdataRegistro;
      qryInsert.ParamByName('PDTMOVIMENTO').AsDateTime    := tContaCR.FdataMovimento;
      qryInsert.ParamByName('PVALOR').AsCurrency          := tContaCR.Fvalor;


    if uUtil.Empty(tContaCR.FIDTR) then
    begin
      qryInsert.ParamByName('PIDTR').Value := null;
    end;

    if uUtil.Empty(tContaCR.FIDloteDeposito) then
    begin
      qryInsert.ParamByName('PIDLOTEDEPOSITO').Value := null;
    end;

    if uUtil.Empty(tContaCR.FIDloteContabil) then
    begin
      qryInsert.ParamByName('PIDLOTECONTABIL').Value := null;
    end;



      qryInsert.ExecSQL;
      xResp := True;
    //o comit fica na transacao

    except
      xResp := False;
      raise Exception.Create('Erro ao tentar inserir CBC');

    end;

    Result := xResp;
  finally
    if Assigned(qryInsert) then
    begin
      FreeAndNil(qryInsert);

    end;

  end;
end;

class function TContaBancariaCreditoDAO.obterPorID( tContaCR: TContaBancariaCRModel): TContaBancariaCRModel;
var
qryPesquisa : TFDQuery;
contaDB: TContaBancariaCRModel;
begin
dmConexao.conectarBanco;
contaDB     := TContaBancariaCRModel.Create;
qryPesquisa := TFDQuery.Create(nil);

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM CONTA_BANCARIA_CREDITO  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTA_BANCARIA_CREDITO = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := tContaCR.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := tContaCR.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
      contaDB     := getModel(qryPesquisa);
  end;

except
raise Exception.Create('Erro ao tentar obter CONTA BANCARIA DB ');
end;

 Result := contaDB;
end;


class function TContaBancariaCreditoDAO.obterSaldoAnterior( tConta: TContaBancariaModel; pDataInicial: TDateTime): Currency;
var
qryPesquisa : TFDQuery;
saldoAnterior :Currency;

begin
dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
saldoAnterior :=0;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT SUM(VALOR) AS SALDO  '  );
  qryPesquisa.SQL.Add('FROM CONTA_BANCARIA_CREDITO  '  );
  qryPesquisa.SQL.Add('WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)  AND  (ID_CONTA_BANCARIA = :PID ) AND (DATA_MOVIMENTO  < :PDTINICIAL )');
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := tConta.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := tConta.FID;
  qryPesquisa.ParamByName('PDTINICIAL').AsDateTime := pDataInicial;
  qryPesquisa.Open;


    saldoAnterior := qryPesquisa.FieldByName('SALDO').AsCurrency;



except
raise Exception.Create('Erro ao tentar obter SALDO ANTERIOR  ');
end;

 Result := saldoAnterior;
end;


class function TContaBancariaCreditoDAO.obterSaldoPeriodo(tConta: TContaBancariaModel; pDataInicial, pDataFinal: TDateTime): Currency;
var
qryPesquisa : TFDQuery;
saldo :Currency;
begin
dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
saldo :=0;

    try

      qryPesquisa.Close;
      qryPesquisa.Connection := dmConexao.conn;
      qryPesquisa.SQL.Clear;
      qryPesquisa.SQL.Add('SELECT SUM(VALOR) AS SALDO  ');
      qryPesquisa.SQL.Add('FROM CONTA_BANCARIA_CREDITO  ');
      qryPesquisa.SQL.Add('WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)  AND  (ID_CONTA_BANCARIA = :PID ) AND (DATA_MOVIMENTO  BETWEEN :PDTINICIAL AND :PDTFINAL )');
      qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := tConta.FIDorganizacao;
      qryPesquisa.ParamByName('PID').AsString := tConta.FID;
      qryPesquisa.ParamByName('PDTINICIAL').AsDateTime := pDataInicial;
      qryPesquisa.ParamByName('PDTFINAL').AsDateTime := pDataFinal;

      qryPesquisa.Open;

      saldo := qryPesquisa.FieldByName('SALDO').AsCurrency;

    except
      raise Exception.Create('Erro ao tentar obter SALDO   ');
    end;

 Result := saldo;
end;


class function TContaBancariaCreditoDAO.obterTodosCreditos(tConta: TContaBancariaModel; pDataInicial, pDataFinal: TDateTime): TFDQuery;
var
qryPesquisa : TFDQuery;
begin
dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
 //melhor retornar cole��o de debitos
try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT *  '  );
  qryPesquisa.SQL.Add('FROM CONTA_BANCARIA_CREDITO  '  );
  qryPesquisa.SQL.Add('WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)  AND  (ID_CONTA_BANCARIA = :PID ) AND (DATA_MOVIMENTO  BETWEEN :PDTINICIAL AND :PDTFINAL )');
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := tConta.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := tConta.FID;
  qryPesquisa.ParamByName('PDTINICIAL').AsDateTime := pDataInicial;
  qryPesquisa.ParamByName('PDTFINAL').AsDateTime := pDataFinal;

  qryPesquisa.Open;


except
raise Exception.Create('Erro ao tentar obter CREDITOS NO PERIODO  ');
end;

 Result := qryPesquisa;
end;


class function TContaBancariaCreditoDAO.Update( tContaCR: TContaBancariaCRModel): Boolean;
var
cmdSql:string;
qryInsert : TFDQuery;
xResp :Boolean;
begin
  xResp := False;
  dmConexao.conectarBanco;
  qryInsert := TFDQuery.Create(nil);
  try
    try

    cmdSql := ' UPDATE CONTA_BANCARIA_CREDITO '+
              ' SET ID_CONTA_BANCARIA = :PIDCONTABANCARIA,'+
               '   ID_TIPO_OPERACAO_BANCARIA = :PIDTOB,'+
               '   ID_RESPONSAVEL = :PIDRESP,'+
               '   ID_TITULO_RECEBER = :PIDTR, '+
               '   ID_LOTE_DEPOSITO = :PIDLOTEDEPOSITO,'+
               '   TIPO_LANCAMENTO = :PTIPOLANCAMENTO,'+
               '   OBSERVACAO = :POBS, '+
               '   DESCRICAO = :PDESCRICAO, '+
               '   VALOR = PVALOR,'+
               '   DATA_REGISTRO = :PDTREGISTRO, '+
               '   DATA_MOVIMENTO = :PDTMOVIMENTO, '+
               '   IDENTIFICACAO = :PIDENTIFICACAO,'+
               '   ID_USUARIO = :PIDUSUARIO, '+
               '   ID_LOTE_CONTABIL = :PIDLOTECONTABIL '+
              ' WHERE (ID_CONTA_BANCARIA_CREDITO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO)' ;

        qryInsert.Close;
        qryInsert.Connection := dmConexao.conn;
        qryInsert.SQL.Clear;
        qryInsert.SQL.Add(cmdSql);
        qryInsert.ParamByName('PID').AsString               := tContaCR.FID;
        qryInsert.ParamByName('PIDORGANIZACAO').AsString    := tContaCR.FIDorganizacao;
        qryInsert.ParamByName('PIDCONTABANCARIA').AsString  := tContaCR.FIDcontaBancaria;
        qryInsert.ParamByName('PIDTOB').AsString            := tContaCR.FIDTOB;
        qryInsert.ParamByName('PIDRESP').AsString           := tContaCR.FIDResponsavel;
        qryInsert.ParamByName('PIDTR').AsString             := tContaCR.FIDTR;
        qryInsert.ParamByName('PIDLOTECONTABIL').AsString   := tContaCR.FIDloteContabil;
        qryInsert.ParamByName('PIDLOTEDEPOSITO').AsString   := tContaCR.FIDloteDeposito;
        qryInsert.ParamByName('PIDUSUARIO').AsInteger       := tContaCR.FIDusuario;
        qryInsert.ParamByName('PTIPOLANCAMENTO').AsString   := tContaCR.FtipoLancamento;
        qryInsert.ParamByName('POBS').AsString              := tContaCR.Fobservacao;
        qryInsert.ParamByName('PDESCRICAO').AsString        := tContaCR.Fdescricao;
        qryInsert.ParamByName('PIDENTIFICACAO').AsString    := tContaCR.Fidentificacao;
        qryInsert.ParamByName('PDTREGISTRO').AsDateTime     := tContaCR.FdataRegistro;
        qryInsert.ParamByName('PDTMOVIMENTO').AsDateTime    := tContaCR.FdataMovimento;
        qryInsert.ParamByName('PVALOR').AsCurrency          := tContaCR.Fvalor;


      if uUtil.Empty(tContaCR.FIDTR) then
      begin
        qryInsert.ParamByName('PIDTR').Value := null;
      end;

      if uUtil.Empty(tContaCR.FIDloteDeposito) then
      begin
        qryInsert.ParamByName('PIDLOTEDEPOSITO').Value := null;
      end;

      if uUtil.Empty(tContaCR.FIDloteContabil) then
      begin
        qryInsert.ParamByName('PIDLOTECONTABIL').Value := null;
      end;


      qryInsert.ExecSQL;
      xResp := True;
    //o comit fica na transacao

    except
      xResp := False;
      raise Exception.Create('Erro ao tentar alterar CBC');

    end;

    Result := xResp;
  finally
    if Assigned(qryInsert) then
    begin
      FreeAndNil(qryInsert);

    end;

  end;
end;


end.
