unit uContaBancariaDebitoDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uOrganizacaoModel,
  uTipoOperacaoBancariaModel,uFuncionarioModel, uContaBancariaDBModel,
  uContaBancariaChequeModel,uLoteContabilModel,uUsuarioModel,
  uTipoOperacaoBancariaDAO,uFuncionarioDAO,uContaBancariaChequeDAO,uLoteContabilDAO,uUsuarioDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uContaBancariaModel,uContaBancariaDAO, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


type
 TContaBancariaDebitoDAO = class
  private
  class function getModel (query :TFDQuery) : TContaBancariaDBModel;

  public

    class function Insert(tContaDB :TContaBancariaDBModel): Boolean;
    class function obterPorID(tContaDB :TContaBancariaDBModel): TContaBancariaDBModel;
    class function obterPorCheque(value :TContaBancariaDBModel): TContaBancariaDBModel;

    class function Delete(tContaDB :TContaBancariaDBModel): Boolean;
    class function deleteTodosPorTP(value :TContaBancariaDBModel): Boolean;
    class function Update(tContaDB :TContaBancariaDBModel): Boolean;
    class function obterSaldoAnterior(tConta :TContaBancariaModel; pDataInicial :TDateTime) : Currency;
    class function obterSaldoPeriodo(tConta :TContaBancariaModel; pDataInicial, pDataFinal :TDateTime) : Currency;
    class function obterTodosDebitos(tConta :TContaBancariaModel; pDataInicial, pDataFinal :TDateTime) : TFDQuery;

  end;

implementation
uses
uTituloPagarDAO,uTituloPagarModel;

{ TContaBancariaDebitoDAO }

class function TContaBancariaDebitoDAO.Delete(tContaDB: TContaBancariaDBModel): Boolean;
var
qryDelete : TFDQuery;
sucesso  :Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
  qryDelete := TFDQuery.Create(nil);

  try
    try

      qryDelete.Close;
      qryDelete.Connection := dmConexao.conn;
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add('DELETE FROM CONTA_BANCARIA_DEBITO  ');
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTA_BANCARIA_DEBITO = :PID ');
      qryDelete.ParamByName('PIDORGANIZACAO').AsString := tContaDB.FIDorganizacao;
      qryDelete.ParamByName('PID').AsString := tContaDB.FID;

      qryDelete.ExecSQL;

      if qryDelete.RowsAffected > 0 then
      begin
        sucesso := True;
      end;

    except
      sucesso := False;
      raise Exception.Create('Erro ao tentar deletar CBC');
    end;

    Result := sucesso;
  finally
    if Assigned(qryDelete) then
    begin
      FreeAndNil(qryDelete);

    end;

  end;
end;

class function TContaBancariaDebitoDAO.deleteTodosPorTP( value: TContaBancariaDBModel): Boolean;
var
qryDelete : TFDQuery;
sucesso :Boolean;
begin
sucesso := False;
 dmConexao.conectarBanco;
 try

  qryDelete := TFDQuery.Create(nil);
  qryDelete.Close;
  qryDelete.Connection := dmConexao.conn;
  qryDelete.SQL.Clear;
  qryDelete.SQL.Add('DELETE FROM CONTA_BANCARIA_DEBITO  '  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := value.FIDTP;

  qryDelete.ExecSQL;
  if qryDelete.RowsAffected >0 then begin  sucesso := True; dmConexao.conn.CommitRetaining; end;


 except
 sucesso := False;
 raise Exception.Create('Erro ao tentar DELETAR CBD');

 end;


  Result := sucesso;
end;

class function TContaBancariaDebitoDAO.getModel(  query: TFDQuery): TContaBancariaDBModel;
var
 contaDB : TContaBancariaDBModel;
begin
      contaDB                 := TContaBancariaDBModel.Create;
      contaDB.FcontaBancaria  := TContaBancariaModel.Create;
      contaDB.Fusuario        := TUsuarioModel.Create;
      contaDB.FtipoOperacao   := TTipoOperacaoBancariaModel.Create;
      contaDB.FloteContabil   := TLoteContabilModel.Create;
      contaDB.Fcheque         := TContaBancariaChequeModel.Create;
     // contaDB.FtituloPagar    := TTituloPagarModel.Create;
      contaDB.Fresponsavel    := TFuncionarioModel.Create;
  try
    if not query.IsEmpty then
    begin

      contaDB.FID               := query.FieldByName('ID_CONTA_BANCARIA_DEBITO').AsString;
      contaDB.FIDorganizacao    := query.FieldByName('ID_ORGANIZACAO').AsString;
      contaDB.FIDcontaBancaria  := query.FieldByName('ID_CONTA_BANCARIA').AsString;
      contaDB.FIDusuario        := query.FieldByName('ID_USUARIO').AsInteger;
      contaDB.FIDTOB            := query.FieldByName('ID_TIPO_OPERACAO_BANCARIA').AsString;
      contaDB.FIDResponsavel    := query.FieldByName('ID_RESPONSAVEL').AsString;
      contaDB.FIDTP             := query.FieldByName('ID_TITULO_PAGAR').AsString;
      contaDB.FIDCheque         := query.FieldByName('ID_CONTA_BANCARIA_CHEQUE').AsString;
      contaDB.FIDloteContabil   := query.FieldByName('ID_LOTE_CONTABIL').AsString;

      contaDB.Fobservacao       := query.FieldByName('OBSERVACAO').AsString;
      contaDB.FtipoLancamento   := query.FieldByName('TIPO_LANCAMENTO').AsString;
      contaDB.Fdescricao        := query.FieldByName('DESCRICAO').AsString;
      contaDB.Fidentificacao    := query.FieldByName('IDENTIFICACAO').AsString;
      contaDB.FdataRegistro     := query.FieldByName('DATA_REGISTRO').AsDateTime;
      contaDB.FdataMovimento    := query.FieldByName('DATA_MOVIMENTO').AsDateTime;
      contaDB.Fvalor            := query.FieldByName('VALOR').AsCurrency;
      contaDB.Fnovo             := False;

      try
      contaDB.FcontaBancaria.FIDorganizacao   := contaDB.FIDorganizacao;
      contaDB.FtipoOperacao.FIDorganizacao    := contaDB.FIDorganizacao;
      contaDB.FloteContabil.FIDorganizacao    := contaDB.FIDorganizacao;
      contaDB.Fcheque.FIDorganizacao          := contaDB.FIDorganizacao;
  //    contaDB.FtituloPagar.FIDorganizacao     := contaDB.FIDorganizacao;
      contaDB.Fresponsavel.FIDorganizacao     := contaDB.FIDorganizacao;

      contaDB.Fusuario.FID        := (contaDB.FIDusuario);
      contaDB.FcontaBancaria.FID  := contaDB.FIDcontaBancaria;
      contaDB.FtipoOperacao.FID   := contaDB.FIDTOB;
      contaDB.FloteContabil.FID   := contaDB.FIDloteContabil;
      contaDB.Fcheque.FID         := contaDB.FIDCheque;
   //   contaDB.FtituloPagar.FID    := contaDB.FIDTP;
      contaDB.Fresponsavel.FID    := contaDB.FIDResponsavel;

      contaDB.FcontaBancaria  := TContaBancariaDAO.obterPorID(contaDB.FcontaBancaria);
      contaDB.Fusuario        := TUsuarioDAO.obterPorID(contaDB.Fusuario);
      contaDB.FtipoOperacao   := TTipoOperacaoBancariaDAO.obterPorID(contaDB.FtipoOperacao);
      contaDB.FloteContabil   := TLoteContabilDAO.obterPorID(contaDB.FloteContabil);
      contaDB.Fcheque         := TContaBancariaChequeDAO.obterPorID(contaDB.Fcheque);
  //    contaDB.FtituloPagar    := TTituloPagarDAO.obterPorID(contaDB.FtituloPagar);
      contaDB.Fresponsavel    := TFuncionarioDAO.obterPorID(contaDB.Fresponsavel);
      except
        raise Exception.Create('Erro ao obter detalhes da conta bancaria debito');

      end;
  end;

except

  raise Exception.Create('Erro ao converter CBD');
 end;

  Result := contaDB;

end;

class function TContaBancariaDebitoDAO.Insert(tContaDB: TContaBancariaDBModel): Boolean;
var
cmdSql:string;
qryInsert : TFDQuery;
sucesso :Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
  qryInsert := TFDQuery.Create(nil);

  try


    cmdSql := ' INSERT INTO CONTA_BANCARIA_DEBITO '+
              ' (ID_CONTA_BANCARIA_DEBITO, ID_ORGANIZACAO, ID_CONTA_BANCARIA, '+
              ' ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, ID_TITULO_PAGAR, '+
              ' ID_CONTA_BANCARIA_CHEQUE, ID_LOTE_CONTABIL, ID_USUARIO, TIPO_LANCAMENTO, '+
              ' OBSERVACAO, DESCRICAO, VALOR, DATA_REGISTRO, DATA_MOVIMENTO, IDENTIFICACAO )'+
              ' VALUES (:PID, :PIDORGANIZACAO, :PIDCONTABANCARIA, '+
              ' :PIDTOB, :PIDRESP, :PIDTP, '+
              ' :PIDCHEQUE, :PIDLOTECONTABIL, :PIDUSUARIO, :PTIPOLANCAMENTO, '+
              ' :POBS, :PDESCRICAO, :PVALOR,:PDTREGISTRO, :PDTMOVIMENTO, :PIDENTIFICACAO  ) ';



      qryInsert.Close;
      qryInsert.Connection := dmConexao.conn;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add(cmdSql);
      qryInsert.ParamByName('PID').AsString               := tContaDB.FID;
      qryInsert.ParamByName('PIDORGANIZACAO').AsString    := tContaDB.FIDorganizacao;
      qryInsert.ParamByName('PIDCONTABANCARIA').AsString  := tContaDB.FIDcontaBancaria;

      qryInsert.ParamByName('PIDTOB').AsString            := tContaDB.FIDTOB;
      qryInsert.ParamByName('PIDRESP').AsString           := tContaDB.FIDResponsavel;
      qryInsert.ParamByName('PIDTP').AsString             := tContaDB.FIDTP;
      qryInsert.ParamByName('PIDCHEQUE').AsString         := tContaDB.FIDCheque;
      qryInsert.ParamByName('PIDLOTECONTABIL').AsString   := tContaDB.FIDloteContabil;
      qryInsert.ParamByName('PIDUSUARIO').AsInteger        := tContaDB.FIDusuario;

      qryInsert.ParamByName('PTIPOLANCAMENTO').AsString   := tContaDB.FtipoLancamento;
      qryInsert.ParamByName('POBS').AsString              := tContaDB.Fobservacao;
      qryInsert.ParamByName('PDESCRICAO').AsString        := tContaDB.Fdescricao;
      qryInsert.ParamByName('PIDENTIFICACAO').AsString    := tContaDB.Fidentificacao;
      qryInsert.ParamByName('PDTREGISTRO').AsDateTime     := tContaDB.FdataRegistro;
      qryInsert.ParamByName('PDTMOVIMENTO').AsDateTime    := tContaDB.FdataMovimento;
      qryInsert.ParamByName('PVALOR').AsCurrency          := tContaDB.Fvalor;


    if uUtil.Empty(tContaDB.FIDTP) then
    begin
      qryInsert.ParamByName('PIDTP').Value := null;
    end;

    if uUtil.Empty(tContaDB.FIDCheque) then
    begin
      qryInsert.ParamByName('PIDCHEQUE').Value := null;
    end;

    if uUtil.Empty(tContaDB.FIDloteContabil) then
    begin
      qryInsert.ParamByName('PIDLOTECONTABIL').Value := null;
    end;

    if (tContaDB.FIDusuario = 0) then
    begin
      qryInsert.ParamByName('PIDUSUARIO').Value := null;
    end;

     qryInsert.ExecSQL;
     if qryInsert.RowsAffected >0 then begin sucesso := True; end;


    Result := sucesso;

  finally
    if Assigned(qryInsert) then
    begin
      FreeAndNil(qryInsert);
    end;
  end;
end;

class function TContaBancariaDebitoDAO.obterPorCheque( value: TContaBancariaDBModel): TContaBancariaDBModel;
var
qryPesquisa : TFDQuery;
contaDB: TContaBancariaDBModel;
begin
dmConexao.conectarBanco;
contaDB     := TContaBancariaDBModel.Create;

qryPesquisa := TFDQuery.Create(nil);

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM CONTA_BANCARIA_DEBITO  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTA_BANCARIA_CHEQUE = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FIDCheque;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
      contaDB     := getModel(qryPesquisa);
  end;



except
raise Exception.Create('Erro ao tentar obter CONTA BANCARIA DB POR CHEQUE ');
end;

 Result := contaDB;
end;



class function TContaBancariaDebitoDAO.obterPorID( tContaDB: TContaBancariaDBModel): TContaBancariaDBModel;
var
qryPesquisa : TFDQuery;
contaDB: TContaBancariaDBModel;
begin
dmConexao.conectarBanco;
contaDB     := TContaBancariaDBModel.Create;
qryPesquisa := TFDQuery.Create(nil);

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM CONTA_BANCARIA_DEBITO  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTA_BANCARIA_DEBITO = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := tContaDB.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := tContaDB.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
      contaDB     := getModel(qryPesquisa);
  end;

except
raise Exception.Create('Erro ao tentar obter CONTA BANCARIA DB ');
end;

 Result := contaDB;
end;




class function TContaBancariaDebitoDAO.obterSaldoAnterior( tConta: TContaBancariaModel; pDataInicial: TDateTime): Currency;
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
  qryPesquisa.SQL.Add('FROM CONTA_BANCARIA_DEBITO  '  );
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


class function TContaBancariaDebitoDAO.obterSaldoPeriodo(tConta: TContaBancariaModel; pDataInicial, pDataFinal: TDateTime): Currency;
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
  qryPesquisa.SQL.Add('SELECT SUM(VALOR) AS SALDO  '  );
  qryPesquisa.SQL.Add('FROM CONTA_BANCARIA_DEBITO  '  );
  qryPesquisa.SQL.Add('WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)  AND  (ID_CONTA_BANCARIA = :PID ) AND (DATA_MOVIMENTO  BETWEEN :PDTINICIAL AND :PDTFINAL )');
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := tConta.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := tConta.FID;
  qryPesquisa.ParamByName('PDTINICIAL').AsDateTime := pDataInicial;
  qryPesquisa.ParamByName('PDTFINAL').AsDateTime := pDataFinal;

  qryPesquisa.Open;

  saldo := qryPesquisa.FieldByName('SALDO').AsCurrency;

except
raise Exception.Create('Erro ao tentar obter SALDO  ');
end;

 Result := saldo;
end;


class function TContaBancariaDebitoDAO.obterTodosDebitos(tConta: TContaBancariaModel; pDataInicial, pDataFinal: TDateTime): TFDQuery;
var
qryPesquisa : TFDQuery;
begin
dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
 //melhor retornar coleção de debitos
try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT *  '  );
  qryPesquisa.SQL.Add('FROM CONTA_BANCARIA_DEBITO  '  );
  qryPesquisa.SQL.Add('WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)  AND  (ID_CONTA_BANCARIA = :PID ) AND (DATA_MOVIMENTO  BETWEEN :PDTINICIAL AND :PDTFINAL )');
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := tConta.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := tConta.FID;
  qryPesquisa.ParamByName('PDTINICIAL').AsDateTime := pDataInicial;
  qryPesquisa.ParamByName('PDTFINAL').AsDateTime := pDataFinal;

  qryPesquisa.Open;


except
raise Exception.Create('Erro ao tentar obter DEBITOS NO PERIODO  ');
end;

 Result := qryPesquisa;
end;


class function TContaBancariaDebitoDAO.Update( tContaDB: TContaBancariaDBModel): Boolean;
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

    cmdSql := ' UPDATE CONTA_BANCARIA_DEBITO '+
              ' SET ID_CONTA_BANCARIA = :PIDCONTABANCARIA,'+
               '   ID_TIPO_OPERACAO_BANCARIA = :PIDTOB,'+
               '   ID_RESPONSAVEL = :PIDRESP,'+
               '   ID_TITULO_PAGAR = :PIDTP, '+
               '   ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE,'+
               '   TIPO_LANCAMENTO = :PTIPOLANCAMENTO,'+
               '   OBSERVACAO = :POBS, '+
               '   DESCRICAO = :PDESCRICAO, '+
               '   VALOR = PVALOR,'+
               '   DATA_REGISTRO = :PDTREGISTRO, '+
               '   DATA_MOVIMENTO = :PDTMOVIMENTO, '+
               '   IDENTIFICACAO = :PIDENTIFICACAO,'+
               '   ID_USUARIO = :PIDUSUARIO, '+
               '   ID_LOTE_CONTABIL = :PIDLOTECONTABIL '+
              ' WHERE (ID_CONTA_BANCARIA_DEBITO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO)' ;

        qryInsert.Close;
        qryInsert.Connection := dmConexao.conn;
        qryInsert.SQL.Clear;
        qryInsert.SQL.Add(cmdSql);
        qryInsert.ParamByName('PID').AsString               := tContaDB.FID;
        qryInsert.ParamByName('PIDORGANIZACAO').AsString    := tContaDB.FIDorganizacao;
        qryInsert.ParamByName('PIDCONTABANCARIA').AsString  := tContaDB.FIDcontaBancaria;

        qryInsert.ParamByName('PIDTOB').AsString            := tContaDB.FIDTOB;
        qryInsert.ParamByName('PIDRESP').AsString           := tContaDB.FIDResponsavel;
        qryInsert.ParamByName('PIDTP').AsString             := tContaDB.FIDTP;
        qryInsert.ParamByName('PIDCHEQUE').AsString         := tContaDB.FIDCheque;
        qryInsert.ParamByName('PIDLOTECONTABIL').AsString   := tContaDB.FIDloteContabil;
        qryInsert.ParamByName('PIDUSUARIO').AsInteger       := tContaDB.FIDusuario;

        qryInsert.ParamByName('PTIPOLANCAMENTO').AsString   := tContaDB.FtipoLancamento;
        qryInsert.ParamByName('POBS').AsString              := tContaDB.Fobservacao;
        qryInsert.ParamByName('PDESCRICAO').AsString        := tContaDB.Fdescricao;
        qryInsert.ParamByName('PIDENTIFICACAO').AsString    := tContaDB.Fidentificacao;
        qryInsert.ParamByName('PDTREGISTRO').AsDateTime     := tContaDB.FdataRegistro;
        qryInsert.ParamByName('PDTMOVIMENTO').AsDateTime    := tContaDB.FdataMovimento;
        qryInsert.ParamByName('PVALOR').AsCurrency          := tContaDB.Fvalor;



    if uUtil.Empty(tContaDB.FIDTP) then
    begin
      qryInsert.ParamByName('PIDTP').Value := null;
    end;

    if uUtil.Empty(tContaDB.FIDCheque) then
    begin
      qryInsert.ParamByName('PIDCHEQUE').Value := null;
    end;

    if uUtil.Empty(tContaDB.FIDloteContabil) then
    begin
      qryInsert.ParamByName('PIDLOTECONTABIL').Value := null;
    end;

    if (tContaDB.FIDusuario = 0 ) then
    begin
      qryInsert.ParamByName('PIDUSUARIO').Value := null;
    end;

      qryInsert.ExecSQL;
      xResp := True;
    //o comit fica na transacao

    except
      xResp := False;
      raise Exception.Create('Erro ao tentar inserir CBD');

    end;

    Result := xResp;
  finally
    if Assigned(qryInsert) then
    begin
      FreeAndNil(qryInsert);

    end;

  end;
end;

{
function TContaBancariaDebitoDAO.insereCBOrigem(ID_CONTA_BANCARIA_DEBITO, ID_ORGANIZACAO,
  ID_CONTA_BANCARIA, ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, TIPO_LANCAMENTO,
  DESCRICAO: string; ID_USUARIO: Integer; VALOR: Currency; DATA_REGISTRO,
  DATA_MOVIMENTO: TDate): Boolean;
var
pIdentificadorCBD, cmdCBD :string;

begin
 dmConexao.conectarBanco;

 try

      pIdentificadorCBD := dmConexao.obterIdentificador(ID_ORGANIZACAO,'CBD');


      //inserir cbc
      cmdCBD := ' INSERT INTO CONTA_BANCARIA_DEBITO (IDENTIFICACAO, ID_CONTA_BANCARIA_DEBITO, ID_ORGANIZACAO, ID_CONTA_BANCARIA, ID_TIPO_OPERACAO_BANCARIA, '+
                ' ID_RESPONSAVEL, TIPO_LANCAMENTO, DESCRICAO, VALOR, DATA_REGISTRO, DATA_MOVIMENTO,  ID_USUARIO) ' +
                ' VALUES (:PIDENT, :PID, :PIDORGANIZACAO, :PIDCONTABANCARIA, :PIDTIPO, :PIDRESP, :PTIPO, :PDESCRICAO, :PVALOR, :PDTREGISTRO, :PDTMOVIMENTO, :PUSUARIO) ' ;

    qryInsereCBORIGEM.Close;
    qryInsereCBORIGEM.Connection := dmConexao.conn;
    qryInsereCBORIGEM.SQL.Clear;
    qryInsereCBORIGEM.SQL.Add(cmdCBD);
    qryInsereCBORIGEM.ParamByName('PIDENT').AsString := pIdentificadorCBD;
    qryInsereCBORIGEM.ParamByName('PID').AsString := ID_CONTA_BANCARIA_DEBITO;
    qryInsereCBORIGEM.ParamByName('PIDORGANIZACAO').AsString := ID_ORGANIZACAO;
    qryInsereCBORIGEM.ParamByName('PIDCONTABANCARIA').AsString := ID_CONTA_BANCARIA;
    qryInsereCBORIGEM.ParamByName('PTIPO').AsString := TIPO_LANCAMENTO;
    qryInsereCBORIGEM.ParamByName('PIDTIPO').AsString := ID_TIPO_OPERACAO_BANCARIA;
    qryInsereCBORIGEM.ParamByName('PIDRESP').AsString := ID_RESPONSAVEL;
    qryInsereCBORIGEM.ParamByName('PDESCRICAO').AsString := DESCRICAO;
    qryInsereCBORIGEM.ParamByName('PVALOR').AsCurrency := VALOR;
    qryInsereCBORIGEM.ParamByName('PDTREGISTRO').AsDate := DATA_REGISTRO;
    qryInsereCBORIGEM.ParamByName('PDTMOVIMENTO').AsDate := DATA_MOVIMENTO;
    qryInsereCBORIGEM.ParamByName('PUSUARIO').AsInteger := ID_USUARIO;

    qryInsereCBORIGEM.ExecSQL;

    dmConexao.conn.CommitRetaining;

    Result := System.True;

 except
     dmConexao.conn.RollbackRetaining;

  raise Exception.Create('Erro ao inserir CBDESTINO');

 end;
end;

   }
end.
