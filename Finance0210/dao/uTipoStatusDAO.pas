unit uTipoStatusDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uTipoStatusModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'TIPO_STATUS';

type
 TTipoStatusDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;

    class function getModel (query :TFDQuery) : TTipoStatusModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
   class function Insert(value :TTipoStatusModel): Boolean;
    class function obterPorID(value :TTipoStatusModel): TTipoStatusModel;
    class function Update(value :TTipoStatusModel): Boolean;
    class function Delete(value :TTipoStatusModel): Boolean;

  end;

implementation

class function TTipoStatusDAO.Delete(value: TTipoStatusModel): Boolean;
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
      qryDelete.SQL.Add('DELETE FROM TIPO_STATUS  ');
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TIPO_STATUS = :PID ');
      qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
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

class function TTipoStatusDAO.getModel(query: TFDQuery): TTipoStatusModel;
var model :TTipoStatusModel;

begin
  model := TTipoStatusModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID                   := query.FieldByName('ID_TIPO_STATUS').AsString;
      model.FIDorganizacao        := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.Fdescricao            := query.FieldByName('DESCRICAO').AsString;


    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TTipoStatusDAO.Insert(value: TTipoStatusModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try

     cmdSql := ' INSERT INTO TIPO_STATUS (ID_TIPO_STATUS, ID_ORGANIZACAO, DESCRICAO) '+
               ' VALUES (:PID, :PIDORGANIZACAO, :PDESCRICAO) ' ;

    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString             := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString      := value.Fdescricao;

    qry.ExecSQL;

    except
      Result := False;
      raise Exception.Create('Erro ao tentar inserir ' + pTable);
    end;

    Result := System.True;
  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;
end;

class function TTipoStatusDAO.obterPorID( value: TTipoStatusModel): TTipoStatusModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TTipoStatusModel;
begin

dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := TTipoStatusModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TIPO_STATUS  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TIPO_STATUS = :PID '  );

  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIdOrganizacao;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      model := getModel(qryPesquisa);  end;


except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;

 Result := model;
end;

class function TTipoStatusDAO.Update(value: TTipoStatusModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try


   cmdSql := ' UPDATE TIPO_STATUS '+
             '   SET DESCRICAO = :PDESCRICAO '+
             ' WHERE (ID_TIPO_STATUS = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';


    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString             := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString      := value.Fdescricao;

    qry.ExecSQL;


  except
    Result := False;
    raise Exception.Create('Erro ao tentar alterar ' + pTable);
  end;
    Result := System.True;
  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;
end;
end.
