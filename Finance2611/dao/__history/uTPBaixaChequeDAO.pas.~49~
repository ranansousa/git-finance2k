unit uTPBaixaChequeDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, uTPBaixaChequeModel, uContaBancariaChequeModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,  uTPBaixaFPModel,uFormaPagamentoModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,uFormaPagamentoDAO,uContaBancariaChequeDAO,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;



  const
   pTable : string = 'TITULO_PAGAR_BAIXA_CHEQUE';

type
 TTPBaixaChequeDAO = class
  private
    class function getTPBCheque (query :TFDQuery) : TTPBaixaChequeModel;

  public

    class function Insert(value :TTPBaixaChequeModel): Boolean;
    class function obterPorID (value :TTPBaixaChequeModel): TTPBaixaChequeModel;
    class function obterTodosPorBaixa (value :TTPBaixaChequeModel): TFDQuery;
    class function Delete(value :TTPBaixaChequeModel): Boolean;
    class function deletePorTPBaixa(value :TTPBaixaChequeModel): Boolean;



  end;


implementation



class function TTPBaixaChequeDAO.Delete(value: TTPBaixaChequeModel): Boolean;
var
  qryDelete: TFDQuery;
  xResp: Boolean;
begin
  xResp := False;
  dmConexao.conectarBanco;
  try

    qryDelete := TFDQuery.Create(nil);
    qryDelete.Close;
    qryDelete.Connection := dmConexao.conn;
    qryDelete.SQL.Clear;
    qryDelete.SQL.Add('DELETE FROM TITULO_PAGAR_BAIXA_CHEQUE  ');
    qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR_BAIXA_CHEQUE = :PID ');
    qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qryDelete.ParamByName('PID').AsString := value.FID;

    qryDelete.ExecSQL;
    xResp := True;


  except
    xResp := False;
    raise Exception.Create('Erro ao tentar DELETAR TITULO_PAGAR_BAIXA_FP');

  end;

  Result := xResp;
end;

class function TTPBaixaChequeDAO.deletePorTPBaixa( value: TTPBaixaChequeModel): Boolean;
var
qryDelete : TFDQuery;
sucesso :Boolean;
begin
 sucesso := False;
 dmConexao.conectarBanco;
 qryDelete := TFDQuery.Create(nil);

 try


  qryDelete.Close;
  qryDelete.Connection := dmConexao.conn;
  qryDelete.SQL.Clear;
  qryDelete.SQL.Add('DELETE FROM '+pTable     );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR_BAIXA = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := value.FIDTPBaixa;

  qryDelete.ExecSQL;
  if qryDelete.RowsAffected >0  then begin
    sucesso := True;
    dmConexao.conn.CommitRetaining;
  end;


 except
 sucesso := False;
 raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

 end;

  Result := sucesso;
end;

class function TTPBaixaChequeDAO.getTPBCheque( query: TFDQuery): TTPBaixaChequeModel;
var
tpbCheque: TTPBaixaChequeModel;
cheque : TContaBancariaChequeModel;
begin
     tpbCheque  := TTPBaixaChequeModel.Create;
     cheque     := TContaBancariaChequeModel.Create;
 try

  if not query.IsEmpty then begin

      tpbCheque.FID            := query.FieldByName('ID_TITULO_PAGAR_BAIXA_CHEQUE').AsString;
      tpbCheque.FIDorganizacao := query.FieldByName('ID_ORGANIZACAO').AsString;
      tpbCheque.FIDTPBaixa     := query.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString;
      tpbCheque.FIDTOB         := query.FieldByName('ID_TIPO_OPERACAO_BANCARIA').AsString;
      tpbCheque.Fobservacao    := query.FieldByName('OBSERVACAO').AsString;
      tpbCheque.FValor         := query.FieldByName('VALOR').AsCurrency;
      tpbCheque.FIDCheque      := query.FieldByName('ID_CONTA_BANCARIA_CHEQUE').AsString;

    try
     cheque.FID                 := query.FieldByName('ID_CONTA_BANCARIA_CHEQUE').AsString;
     cheque.FIDorganizacao      := tpbCheque.FIDorganizacao;
     tpbCheque.FCheque          := TContaBancariaChequeDAO.obterPorID(cheque);

    except
      raise Exception.Create('Erro ao tentar obter CHEQUE por TPBFP');

    end;

  end;

 except
 raise Exception.Create('Erro ao obter TITULO_PAGAR_BAIXA_CHEQUE');


 end;


  Result := tpbCheque;

end;

class function TTPBaixaChequeDAO.Insert(value: TTPBaixaChequeModel): Boolean;
var
qryInsert : TFDQuery;
cmdSql :string;
sucesso : Boolean;
begin

sucesso := False;

dmConexao.conectarBanco;

  cmdSql := ' INSERT INTO TITULO_PAGAR_BAIXA_CHEQUE (ID_TITULO_PAGAR_BAIXA_CHEQUE, ID_ORGANIZACAO, '+
            ' ID_TITULO_PAGAR_BAIXA, VALOR, ID_TIPO_OPERACAO_BANCARIA, ID_CONTA_BANCARIA_CHEQUE,  OBSERVACAO ) '+
            ' VALUES (:PID, :PIDORGANIZACAO, '+
            ' :PIDTITULO_PAGAR_BAIXA, :PVALOR, :PIDTOB, :PIDCHEQUE, :POBS) ';

  qryInsert := TFDQuery.Create(nil);

  try


    qryInsert.Close;
    qryInsert.Connection := dmConexao.conn;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(cmdSql);
    qryInsert.ParamByName('PID').AsString                     := value.FID;
    qryInsert.ParamByName('PIDTITULO_PAGAR_BAIXA').AsString   := value.FIDTPBaixa;
    qryInsert.ParamByName('PIDORGANIZACAO').AsString          := value.FIDorganizacao;
    qryInsert.ParamByName('PIDTOB').AsString                  := value.FIDTOB;
    qryInsert.ParamByName('PIDCHEQUE').AsString               := value.FCheque.FID;
    qryInsert.ParamByName('POBS').AsString                    := value.Fobservacao;
    qryInsert.ParamByName('PVALOR').AsCurrency                := value.FValor;

    qryInsert.ExecSQL;

    if qryInsert.RowsAffected > 0 then
    begin
      sucesso := True;
      dmConexao.conn.CommitRetaining;
    end;


  finally
    FreeAndNil(qryInsert);
  end;

 Result := sucesso;


end;

class function TTPBaixaChequeDAO.obterPorID( value: TTPBaixaChequeModel): TTPBaixaChequeModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
tpbCheque: TTPBaixaChequeModel;
begin
dmConexao.conectarBanco;


  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_PAGAR_BAIXA_CHEQUE  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR_BAIXA_CHEQUE = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

   tpbCheque   := TTPBaixaChequeModel.Create;

  if not qryPesquisa.IsEmpty then begin
      tpbCheque   := getTPBCheque(qryPesquisa) ;
  end;


 Result := tpbCheque;
end;



class function TTPBaixaChequeDAO.obterTodosPorBaixa( value: TTPBaixaChequeModel): TFDQuery;
var
qryPesquisa : TFDQuery;
cmdSql:string;
begin
  dmConexao.conectarBanco;

  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_PAGAR_BAIXA_CHEQUE  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR_BAIXA = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FIDTPBaixa;
  qryPesquisa.Open;


 Result := qryPesquisa;
end;
end.
