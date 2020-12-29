unit uTRBaixaDEDAO;


interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uTRBaixaDEModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uTipoDeducaoModel,uTipoDeducaoDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'TITULO_RECEBER_BAIXA_DE';



type
 TTRBaixaDEDAO = class
  private
    class function getModel (query :TFDQuery) : TTRBaixaDEModel;
  public
    {métodos CRUD (Create, Read, Update e Delete)
    para manipulação dos dados}
    class function Insert(value :TTRBaixaDEModel): Boolean;
    class function obterPorID(value :TTRBaixaDEModel): TTRBaixaDEModel;
    class function Update(value :TTRBaixaDEModel): Boolean;
    class function Delete(value :TTRBaixaDEModel): Boolean;
    class function deletePorTRBaixa(value :TTRBaixaDEModel): Boolean;


  end;

implementation

class function TTRBaixaDEDAO.Delete(value: TTRBaixaDEModel): Boolean;
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
  qryDelete.SQL.Add('DELETE FROM '+pTable     );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_'+pTable +  ' = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := value.FID;
    qryDelete.ExecSQL;

    if qryDelete.RowsAffected > 0 then
    begin
      sucesso := True;
    end;

 except
 sucesso := False;
 raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

 end;

  Result := sucesso;
end;



class function TTRBaixaDEDAO.deletePorTRBaixa(value: TTRBaixaDEModel): Boolean;
var
qryDelete : TFDQuery;
sucesso :Boolean;
begin
sucesso := False;
 qryDelete := TFDQuery.Create(nil);
 dmConexao.conectarBanco;

 try

  qryDelete.Close;
  qryDelete.Connection := dmConexao.conn;
  qryDelete.SQL.Clear;
  qryDelete.SQL.Add('DELETE FROM '+pTable     );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_RECEBER_BAIXA = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := value.FIDtituloReceberBaixa;

  qryDelete.ExecSQL;

  if qryDelete.RowsAffected >0  then begin
    sucesso := True;
  end;

 except
 sucesso := False;
 raise Exception.Create('Erro ao tentar DELETAR ' + pTable);
 end;

  Result := sucesso;
end;

class function TTRBaixaDEDAO.getModel(query: TFDQuery): TTRBaixaDEModel;
var model :TTRBaixaDEModel;

begin

model                     := TTRBaixaDEModel.Create;
model.FtipoDeducao                := TTipoDeducaoModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID                   := query.FieldByName('ID_TITULO_RECEBER_BAIXA_DE').AsString;
      model.FIDorganizacao        := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FIDtituloReceberBaixa := query.FieldByName('ID_TITULO_RECEBER_BAIXA').AsString;
      model.FIDtipoDeducao        := query.FieldByName('ID_TIPO_DEDUCAO').AsString;
      model.Fvalor                := query.FieldByName('VALOR').AsCurrency;

      try

        model.FtipoDeducao.FID            := model.FIDtipoDeducao;
        model.FtipoDeducao.FIDOrganizacao := model.FIDOrganizacao;
        model.FtipoDeducao                := TTipoDeducaoDAO.obterPorID(model.FtipoDeducao);

      except
        raise Exception.Create('Erro ao tentar obter tipo deducao por ' + pTable);

      end;

    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;

   Result := model;

end;

class function TTRBaixaDEDAO.Insert(value: TTRBaixaDEModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
 sucesso : Boolean;
begin
 sucesso := False;

  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);

  try


     cmdSql :=  ' INSERT INTO TITULO_RECEBER_BAIXA_DE '+
                ' (ID_TITULO_RECEBER_BAIXA_DE, ID_ORGANIZACAO, ID_TITULO_RECEBER_BAIXA, ID_TIPO_DEDUCAO, VALOR ) '+
                ' VALUES (:PID, :PIDORGANIZACAO, :PIDBAIXA,:PIDTIPO_DE, :PVALOR ) ';

    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PIDTIPO_DE').AsString            := value.FIDtipoDeducao;
    qry.ParamByName('PIDBAIXA').AsString              := value.FIDtituloReceberBaixa;
    qry.ParamByName('PVALOR').AsCurrency              := value.Fvalor ;
    qry.ExecSQL;

   if qry.RowsAffected > 0 then
    begin
      sucesso := True;
    end;

    Result := sucesso;


  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;

class function TTRBaixaDEDAO.obterPorID( value: TTRBaixaDEModel): TTRBaixaDEModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TTRBaixaDEModel;
begin

  dmConexao.conectarBanco;
  qryPesquisa := TFDQuery.Create(nil);
  model := TTRBaixaDEModel.Create;


try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM ' + pTable  );
  qryPesquisa.SQL.Add('WHERE ID_'+pTable+ ' = :PID '  );

  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
      model := getModel(qryPesquisa);  end;


except
raise Exception.Create('Erro ao tentar obter ' + pTable );
end;

 Result := model;
end;

class function TTRBaixaDEDAO.Update(value: TTRBaixaDEModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
sucesso : Boolean;
begin
 sucesso := False;

  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try

     cmdSql := ' UPDATE TITULO_RECEBER_BAIXA_DE '+
               ' SET ID_TITULO_RECEBER_BAIXA  = :PIDBAIXA, '+
               '     ID_TIPO_DEDUCAO          = :PIDTIPO_DE,'+
               '     VALOR                    = :PVALOR '+
               ' WHERE (ID_TITULO_RECEBER_BAIXA_DE = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';


    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PIDTIPO_DE').AsString            := value.FIDtipoDeducao;
    qry.ParamByName('PIDBAIXA').AsString              := value.FIDtituloReceberBaixa;
    qry.ParamByName('PVALOR').AsCurrency              := value.Fvalor ;
    qry.ExecSQL;


      if qry.RowsAffected > 0 then
      begin
        sucesso := True;
      end;

      Result := sucesso;


    except
      Result := False;
      raise Exception.Create('Erro ao tentar alterar ' + pTable);
    end;

  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;
end.
