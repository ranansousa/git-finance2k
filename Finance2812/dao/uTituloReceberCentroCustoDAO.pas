unit uTituloReceberCentroCustoDAO;

interface
{
CREATE TABLE TITULO_RECEBER_RATEIO_CC (
    ID_TITULO_RECEBER_RATEIO_CC  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO               VARCHAR(36) NOT NULL,
    ID_CENTRO_CUSTO              VARCHAR(36),
    ID_TITULO_RECEBER            VARCHAR(36),
    VALOR                        NUMERIC(10,2)
);}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  uFuncionarioModel, uCedenteModel, uCedenteDAO,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, uTituloReceberCentroCustoModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uCentroCustoModel, uCentroCustoDAO,
  udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'TITULO_RECEBER_RATEIO_CC';
type
 TTituloReceberCentroCustoDAO = class
  private
    class function getModel (query :TFDQuery) : TTituloReceberCentroCustoModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
    class function Insert(value :TTituloReceberCentroCustoModel): Boolean;
    class function Update (value :TTituloReceberCentroCustoModel) :Boolean;
    class function obterPorID(value :TTituloReceberCentroCustoModel): TTituloReceberCentroCustoModel;
    class function Delete(value :TTituloReceberCentroCustoModel): Boolean;
    class function DeletePorIDTR(value :TTituloReceberCentroCustoModel): Boolean;


  end;

implementation



class function TTituloReceberCentroCustoDAO.Delete(value: TTituloReceberCentroCustoModel): Boolean;
var
qryDelete : TFDQuery;
sucesso :Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
  qryDelete := TFDQuery.Create(nil);


  try

    try

      qryDelete.Close;
      qryDelete.Connection := dmConexao.conn;
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add('DELETE FROM ' + pTable);
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_' + pTable + ' = :PID ');
      qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qryDelete.ParamByName('PID').AsString := value.FID;

      qryDelete.ExecSQL;

      if qryDelete.RowsAffected > 0 then
      begin
        sucesso := True;
      end;

      Result := sucesso;

    except
      raise Exception.Create('Erro ao tentar DELETAR ' + pTable);
    end;

  finally
    if Assigned(qryDelete) then
    begin
      FreeAndNil(qryDelete);
    end;
  end;

end;

class function TTituloReceberCentroCustoDAO.DeletePorIDTR( value: TTituloReceberCentroCustoModel): Boolean;
var
qryDelete : TFDQuery;
sucesso :Boolean;
begin

 sucesso := True;
 dmConexao.conectarBanco;
 qryDelete := TFDQuery.Create(nil);

  qryDelete.Close;
  qryDelete.Connection := dmConexao.conn;
  qryDelete.SQL.Clear;
  qryDelete.SQL.Add('DELETE FROM '+pTable     );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_RECEBER ' +  ' = :PIDTR '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PIDTR').AsString := value.FIDTR;

  qryDelete.ExecSQL;
  if qryDelete.RowsAffected >0 then begin  sucesso := True; end;

  Result := sucesso;

end;

class function TTituloReceberCentroCustoDAO.getModel(query: TFDQuery): TTituloReceberCentroCustoModel;
var model : TTituloReceberCentroCustoModel;
begin
      model              := TTituloReceberCentroCustoModel.Create;
      model.FCentroCusto := TCentroCustoModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID                     := query.FieldByName('ID_TITULO_RECEBER_RATEIO_CC').AsString;
      model.FIDorganizacao          := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FIDCentroCusto          := query.FieldByName('ID_CENTRO_CUSTO').AsString;
      model.FIDTR                   := query.FieldByName('ID_TITULO_RECEBER').AsString;
      model.Fvalor                  := query.FieldByName('VALOR').AsCurrency;

      try

        model.FCentroCusto.FIDorganizacao := model.FIDorganizacao;
        model.FCentroCusto.FID := model.FIDCentroCusto;
        model.FCentroCusto := TCentroCustoDAO.obterPorID(model.FCentroCusto);

      except
        raise Exception.Create('Erro ao tentar obter Centro Custo por ' + pTable);

      end;

    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TTituloReceberCentroCustoDAO.Insert(value: TTituloReceberCentroCustoModel): Boolean;
var
  qryInsert: TFDQuery;
  cmdDB: string;
  sucesso : boolean;
begin
sucesso := True;
  dmConexao.conectarBanco;
  qryInsert := TFDQuery.Create(nil);

     cmdDB :=  ' INSERT INTO TITULO_RECEBER_RATEIO_CC '+
                ' (ID_TITULO_RECEBER_RATEIO_CC, ID_ORGANIZACAO, ID_CENTRO_CUSTO,' +
                ' ID_TITULO_RECEBER, VALOR) '+
                ' VALUES (:PID, :PIDORGANIZACAO,:PIDCC, '+
                ' :PIDTR, :PVALOR )' ;

    qryInsert.Close;
    qryInsert.Connection := dmConexao.conn;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(cmdDB);
    qryInsert.ParamByName('PID').AsString             := value.FID;
    qryInsert.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
    qryInsert.ParamByName('PIDCC').AsString           := value.FIDCentroCusto;
    qryInsert.ParamByName('PIDTR').AsString           := value.FIDTR;
    qryInsert.ParamByName('PVALOR').AsCurrency        := value.Fvalor;


    qryInsert.ExecSQL;
    if qryInsert.RowsAffected >0 then begin  sucesso := True; end;

   Result := sucesso;

end;

class function TTituloReceberCentroCustoDAO.obterPorID( value: TTituloReceberCentroCustoModel): TTituloReceberCentroCustoModel;
var
qryPesquisa : TFDQuery;
model: TTituloReceberCentroCustoModel;
begin
  dmConexao.conectarBanco;
  qryPesquisa := TFDQuery.Create(nil);
  model := TTituloReceberCentroCustoModel.Create;

  try

    try

      qryPesquisa.Close;
      qryPesquisa.Connection := dmConexao.conn;
      qryPesquisa.SQL.Clear;
      qryPesquisa.SQL.Add('SELECT * ');
      qryPesquisa.SQL.Add('FROM ' + pTable);
      qryPesquisa.SQL.Add('WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO ) AND  ID_' + pTable + ' = :PID ');

      qryPesquisa.ParamByName('PID').AsString := value.FID;
      qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;

      qryPesquisa.Open;

      if not qryPesquisa.IsEmpty then
      begin
        model := getModel(qryPesquisa);
      end;

       Result := model;

    except
      raise Exception.Create('Erro ao tentar obter ' + pTable);

    end;

  finally
    if Assigned(qryPesquisa) then
    begin
      FreeAndNil(qryPesquisa);
    end;
  end;

end;
class function TTituloReceberCentroCustoDAO.Update(value: TTituloReceberCentroCustoModel): Boolean;
var
  qry : TFDQuery;
  cmdDB: string;
  sucesso : Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try


     cmdDB := ' UPDATE TITULO_RECEBER_RATEIO_CC '+
              ' SET ID_CENTRO_CUSTO = :PID_CENTRO_CUSTO, '+
              ' ID_TITULO_RECEBER = :PIDTR,'+
              ' VALOR = :PVALOR '+
              ' WHERE (ID_TITULO_RECEBER_RATEIO_CC = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ' ;


    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdDB);
    qry.ParamByName('PID').AsString               := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString    := value.FIDorganizacao;
    qry.ParamByName('PID_CENTRO_CUSTO').AsString  := value.FIDCentroCusto;
    qry.ParamByName('PIDTR').AsString             := value.FIDTR;
    qry.ParamByName('PVALOR').AsCurrency          := value.Fvalor;
    qry.ExecSQL;

    if qry.RowsAffected >0 then begin  sucesso := True; end;

   Result := sucesso;


  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;



end;


end.

