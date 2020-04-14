unit uTipoSacadoDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uTipoSacadoModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'TIPO_SACADO';

type
 TTipoSacadoDAO = class
  private
    class function getModel (query :TFDQuery) : TTipoSacadoModel;
  public
    {métodos CRUD (Create, Read, Update e Delete)
    para manipulação dos dados}
    class function Insert(value :TTipoSacadoModel): Boolean;
    class function obterPorID(value :TTipoSacadoModel): TTipoSacadoModel;
    class function Update(value :TTipoSacadoModel): Boolean;
    class function Delete(value :TTipoSacadoModel): Boolean;

  end;

implementation

class function TTipoSacadoDAO.Delete(value: TTipoSacadoModel): Boolean;
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

    except
      xResp := False;
      raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

    end;

    Result := xResp;
  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;

class function TTipoSacadoDAO.getModel(query: TFDQuery): TTipoSacadoModel;
var model :TTipoSacadoModel;
begin

  model                    := TTipoSacadoModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID                := query.FieldByName('ID_TIPO_SACADO').AsString;
      model.FIDorganizacao     := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FDescricao         := query.FieldByName('DESCRICAO').AsString;
      model.Fnovo              := False;

    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TTipoSacadoDAO.Insert(value: TTipoSacadoModel): Boolean;
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
     cmdSql :=  ' INSERT INTO TIPO_SACADO '+
                ' (ID_TIPO_SACADO, ID_ORGANIZACAO, DESCRICAO '+
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

class function TTipoSacadoDAO.obterPorID( value: TTipoSacadoModel): TTipoSacadoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TTipoSacadoModel;
begin
  dmConexao.conectarBanco;
  qryPesquisa := TFDQuery.Create(nil);
  model := TTipoSacadoModel.Create;
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

class function TTipoSacadoDAO.Update(value: TTipoSacadoModel): Boolean;
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
     cmdSql := ' UPDATE TIPO_SACADO '+
               ' SET DESCRICAO = :PDESCRICAO '+
               ' WHERE (ID_TIPO_SACADO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO )';

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
