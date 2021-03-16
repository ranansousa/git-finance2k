unit uEstadoDAO;


interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uEstadoModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,Vcl.StdCtrls;

  const
   pTable : string = 'ESTADO';

type
 TEstadoDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;

    class function getModel (query :TFDQuery) : TEstadoModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
   class function Insert(value :TEstadoModel): Boolean;
    class function obterPorID(value :TEstadoModel): TEstadoModel;
    class function Update(value :TEstadoModel): Boolean;
    class function Delete(value :TEstadoModel): Boolean;

  end;

implementation

class function TEstadoDAO.Delete(value: TEstadoModel): Boolean;
var
qryDelete : TFDQuery;
xResp :Boolean;
begin
  xResp := False;
  dmConexao.conectarBanco;
  qryDelete := TFDQuery.Create(nil);
  try
    try
      qryDelete.Close;
      qryDelete.Connection := dmConexao.conn;
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add('DELETE FROM ESTADO  ');
      qryDelete.SQL.Add('WHERE ID_ESTADO = :PID ');
      qryDelete.ParamByName('PID').AsString := value.FID;

      qryDelete.ExecSQL;

      xResp := True;

    except
      xResp := False;
      raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

    end;

    Result := xResp;
  finally
    if Assigned(qryDelete) then
    begin
      FreeAndNil(qryDelete);
    end;
  end;
end;

class function TEstadoDAO.getModel(query: TFDQuery): TEstadoModel;
var model :TEstadoModel;

begin
  model := TEstadoModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID         := query.FieldByName('ID_ESTADO').AsString;
      model.Fsigla      := query.FieldByName('SIGLA').AsString;
      model.Fdescricao  := query.FieldByName('DESCRICAO').AsString;
      model.Fnovo       := False;


    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TEstadoDAO.Insert(value: TEstadoModel): Boolean;
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

     cmdSql :=  '  INSERT INTO ESTADO ' +
                '  (ID_ESTADO, '+
                '  SIGLA, DESCRICAO ) '+
                '  VALUES (:PID,:PSIGLA,:PDESCRICAO )';

    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString         := value.FID;
    qry.ParamByName('PSIGLA').AsString      := value.Fsigla;
    qry.ParamByName('PDESCRICAO').AsString  := value.Fdescricao;

    qry.ExecSQL;

     if qry.RowsAffected >0 then begin

        sucesso := True;
     end;

    except
      Result := sucesso;
      raise Exception.Create('Erro ao tentar inserir ' + pTable);
    end;

    Result := sucesso
  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;
end;

class function TEstadoDAO.obterPorID( value: TEstadoModel): TEstadoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TEstadoModel;
begin

dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := TEstadoModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM ESTADO  '  );
  qryPesquisa.SQL.Add('WHERE ID_ESTADO = :PID '  );

  qryPesquisa.ParamByName('PID').AsString := value.FID;

  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      model := getModel(qryPesquisa);  end;


except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;

 Result := model;
end;

class function TEstadoDAO.Update(value: TEstadoModel): Boolean;
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
   cmdSql := ' UPDATE ESTADO '+
             ' SET SIGLA    = :PSIGLA, '+
             '     DESCRICAO       = :PDESCRICAO ' +
             ' WHERE (ID_ESTADO = :PID) ';

    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString         := value.FID;
    qry.ParamByName('PSIGLA').AsString      := value.Fsigla;
    qry.ParamByName('PDESCRICAO').AsString  := value.Fdescricao;

    qry.ExecSQL;

     if qry.RowsAffected >0 then begin

        sucesso := True;
     end;

    except
      Result := sucesso;
      raise Exception.Create('Erro ao tentar ALTERAR ' + pTable);
    end;
    Result := sucesso
  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;
end;
end.
