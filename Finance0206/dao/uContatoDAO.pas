unit uContatoDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uContatoModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,Vcl.StdCtrls;

  const
   pTable : string = 'CONTATO';

type
 TContatoDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;

    class function getModel (query :TFDQuery) : TContatoModel;
  public
    {métodos CRUD (Create, Read, Update e Delete)
    para manipulação dos dados}
   class function Insert(value :TContatoModel): Boolean;
    class function obterPorID(value :TContatoModel): TContatoModel;
    class function Update(value :TContatoModel): Boolean;
    class function Delete(value :TContatoModel): Boolean;

  end;

implementation

class function TContatoDAO.Delete(value: TContatoModel): Boolean;
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
      qryDelete.SQL.Add('DELETE FROM CONTATO  ');
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTATO = :PID ');
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

class function TContatoDAO.getModel(query: TFDQuery): TContatoModel;
var model :TContatoModel;

begin
  model := TContatoModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID             := query.FieldByName('ID_CONTATO').AsString;
      model.FIDorganizacao  := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FTelefone       := query.FieldByName('TELEFONE').AsString;
      model.FCelular        := query.FieldByName('CELULAR').AsString;
      model.FEmail          := query.FieldByName('EMAIL').AsString;
      model.Fnovo           := False;


    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TContatoDAO.Insert(value: TContatoModel): Boolean;
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

     cmdSql :=  '  INSERT INTO CONTATO ' +
                '  (ID_CONTATO, ID_ORGANIZACAO,'+
                '  TELEFONE, CELULAR, EMAIL) '+
                '  VALUES (:PID,:PIDORGANIZACAO,:PTELEFONE,:PCELULAR,:PEMAIL )';

    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString             := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
    qry.ParamByName('PTELEFONE').AsString       := value.FTelefone;
    qry.ParamByName('PCELULAR').AsString        := value.FCelular;
    qry.ParamByName('PEMAIL').AsString          := value.FEmail ;

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

class function TContatoDAO.obterPorID( value: TContatoModel): TContatoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TContatoModel;
begin

dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := TContatoModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM CONTATO  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTATO = :PID '  );

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

class function TContatoDAO.Update(value: TContatoModel): Boolean;
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


   cmdSql := ' UPDATE CONTATO '+
             ' SET TELEFONE    = :PTELEFONE, '+
             '     CELULAR     = :PCELULAR,'+
             '     EMAIL       = :PEMAIL ' +
             ' WHERE (ID_CONTATO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';



    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString             := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
    qry.ParamByName('PTELEFONE').AsString       := value.FTelefone;
    qry.ParamByName('PCELULAR').AsString        := value.FCelular;
    qry.ParamByName('PEMAIL').AsString          := value.FEmail ;

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
