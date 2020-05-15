unit uTipoNotaFiscalDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil, uTipoNotaFiscalModel,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,Vcl.StdCtrls, uOrganizacaoModel;

  const
   pTable : string = 'TIPO_NOTA_FISCAL';

type
 TTipoNotaFiscalDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;

    class function getModel (query :TFDQuery) : TTipoNotaFiscalModel;
  public

    class function Insert(value :TTipoNotaFiscalModel): Boolean;
    class function obterPorID(value :TTipoNotaFiscalModel): TTipoNotaFiscalModel;
    class function Update(value :TTipoNotaFiscalModel): Boolean;
    class function Delete(value :TTipoNotaFiscalModel): Boolean;


  end;

implementation

class function TTipoNotaFiscalDAO.Delete(value: TTipoNotaFiscalModel): Boolean;
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
      qryDelete.SQL.Add('DELETE FROM TIPO_NOTA_FISCAL  ');
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TIPO_NOTA_FISCAL = :PID ');
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

class function TTipoNotaFiscalDAO.getModel(query: TFDQuery): TTipoNotaFiscalModel;
var model :TTipoNotaFiscalModel;

begin
  model := TTipoNotaFiscalModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID                   := query.FieldByName('ID_TIPO_NOTA_FISCAL').AsString;
      model.FIDorganizacao        := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FDescricao            := query.FieldByName('DESCRICAO').AsString;

    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TTipoNotaFiscalDAO.Insert(value: TTipoNotaFiscalModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try
   cmdSql :=  ' INSERT INTO TIPO_NOTA_FISCAL (ID_TIPO_NOTA_FISCAL, ID_ORGANIZACAO, DESCRICAO) '+
              ' VALUES ( :PID, :PIDORGANIZACAO, :PDESCRICAO) ';

    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString             := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString      := UpperCase(value.FDescricao);

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

class function TTipoNotaFiscalDAO.obterPorID( value: TTipoNotaFiscalModel): TTipoNotaFiscalModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TTipoNotaFiscalModel;
begin

dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := TTipoNotaFiscalModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TIPO_NOTA_FISCAL  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TIPO_NOTA_FISCAL = :PID '  );

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

class function TTipoNotaFiscalDAO.Update(value: TTipoNotaFiscalModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try


   cmdSql := 'UPDATE TIPO_NOTA_FISCAL SET DESCRICAO = :PDESCRICAO '+
             ' WHERE (ID_TIPO_NOTA_FISCAL = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO)';


    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString             := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString      := upperCase(value.FDescricao);

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
