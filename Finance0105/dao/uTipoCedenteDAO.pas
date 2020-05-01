unit uTipoCedenteDAO;


interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uTipoCedenteModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'TIPO_CEDENTE';

type
 TTipoCedenteDAO = class
  private
    class function getModel (query :TFDQuery) : TTipoCedenteModel;
  public
    {métodos CRUD (Create, Read, Update e Delete)
    para manipulação dos dados}
    class function Insert(value :TTipoCedenteModel): Boolean;
    class function obterPorID(value :TTipoCedenteModel): TTipoCedenteModel;
    class function Update(value :TTipoCedenteModel): Boolean;
    class function Delete(value :TTipoCedenteModel): Boolean;

  end;
implementation

class function TTipoCedenteDAO.Delete(value: TTipoCedenteModel): Boolean;
var
  qry: TFDQuery;
  xResp: Boolean;
begin

  xResp := False;
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);

  try
    try

      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM ' + pTable);
      qry.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_' + pTable + ' = :PID ');
      qry.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qry.ParamByName('PID').AsString := value.FID;

      qry.ExecSQL;
     if qry.RowsAffected >0 then begin
      xResp := True; end;

      Result := xResp;

    except
      xResp := False;
      raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

    end;


  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;

class function TTipoCedenteDAO.getModel(query: TFDQuery): TTipoCedenteModel;
var model :TTipoCedenteModel;
begin

  model                    := TTipoCedenteModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID                := query.FieldByName('ID_TIPO_CEDENTE').AsString;
      model.FIDorganizacao     := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FDescricao         := query.FieldByName('DESCRICAO').AsString;
      model.Fnovo              := False;

    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;
  end;
   Result := model;

end;

class function TTipoCedenteDAO.Insert(value: TTipoCedenteModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
  sucesso :Boolean;

begin
sucesso := False;
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try
     cmdSql :=  ' INSERT INTO TIPO_CEDENTE '+
                ' (ID_TIPO_CEDENTE, ID_ORGANIZACAO, DESCRICAO '+
                ' VALUES (:PID, :PIDORGANIZACAO, :PDESCRICAO )' ;

    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString            := value.FDescricao;
      qry.ExecSQL;

      if qry.RowsAffected > 0 then
      begin
        sucesso := True;
      end;

      Result := sucesso;

  except
    Result := False;
    raise Exception.Create('Erro ao tentar inserir ' + pTable);
  end;

  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;

class function TTipoCedenteDAO.obterPorID( value: TTipoCedenteModel): TTipoCedenteModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TTipoCedenteModel;
begin
  dmConexao.conectarBanco;
  qryPesquisa := TFDQuery.Create(nil);
  model := TTipoCedenteModel.Create;
try
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM ' + pTable  );
  qryPesquisa.SQL.Add('WHERE ID_'+pTable+ ' = :PID '  );

  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

    if not qryPesquisa.IsEmpty then
    begin
      model := getModel(qryPesquisa);
    end;

except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;
 Result := model;
end;

class function TTipoCedenteDAO.Update(value: TTipoCedenteModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
  sucesso :Boolean;
begin
sucesso := True;
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
  try
     cmdSql := ' UPDATE TIPO_CEDENTE '+
               ' SET DESCRICAO = :PDESCRICAO '+
               ' WHERE (ID_TIPO_CEDENTE = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO )';

    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString            := value.FDescricao;

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
