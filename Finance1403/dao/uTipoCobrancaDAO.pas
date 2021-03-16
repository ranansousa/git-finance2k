unit uTipoCobrancaDAO;

interface
{

CREATE TABLE TIPO_COBRANCA (
    ID_TIPO_COBRANCA  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO    VARCHAR(36) NOT NULL,
    DESCRICAO         VARCHAR(20)
);  }

uses
  Winapi.Windows, Winapi.Messages, System.DateUtils, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uTipoCobrancaModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
uOrganizacaoDAO, uOrganizacaoModel, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

  const
   pTable : string = 'TIPO_COBRANCA';

type
 TTipoCobrancaDAO = class
  private
   class function getModel (query :TFDQuery) : TTipoCobrancaModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}

    class function Insert(value :TTipoCobrancaModel): Boolean;
    class function Update(value :TTipoCobrancaModel) :Boolean;
    class function obterPorID(value :TTipoCobrancaModel): TTipoCobrancaModel;
    class function Delete(value :TTipoCobrancaModel): Boolean;

  end;


implementation

class function TTipoCobrancaDAO.Delete(value: TTipoCobrancaModel): Boolean;
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
      qryDelete.SQL.Add('DELETE FROM TIPO_COBRANCA  ');
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TIPO_COBRANCA = :PID ');
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

class function TTipoCobrancaDAO.getModel (query: TFDQuery): TTipoCobrancaModel;
var
local : TTipoCobrancaModel;
begin

    local                  := TTipoCobrancaModel.Create;

    if not query.IsEmpty then begin

       if not  query.IsEmpty then begin
        local.FID                      := (query.FieldByName('ID_TIPO_COBRANCA').AsString);
        local.FIDorganizacao           := (query.FieldByName('ID_ORGANIZACAO').AsString);
        local.FDescricao               := (query.FieldByName('DESCRICAO').AsString);
       end;
  end;


   Result := local;

end;

class function TTipoCobrancaDAO.Insert(value: TTipoCobrancaModel): Boolean;
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
      cmdSql := ' INSERT INTO TIPO_COBRANCA (ID_TIPO_COBRANCA, ID_ORGANIZACAO, DESCRICAO) '+
                ' VALUES (:PID, :PIDORGANIZACAO, :PDESC)';

      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add(cmdSql);
      qry.ParamByName('PID').AsString                 := value.FID;
      qry.ParamByName('PIDORGANIZACAO').AsString      := value.FIDorganizacao;
      qry.ParamByName('PDESC').AsString               := value.FDescricao;

      qry.ExecSQL;

       if qry.RowsAffected >0 then begin sucesso := True; end;


    except
      raise Exception.Create('Erro ao tentar manipular dados em  ' + pTable);
    end;

    Result := sucesso;

  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;
end;

class function TTipoCobrancaDAO.obterPorID(value: TTipoCobrancaModel): TTipoCobrancaModel;
var
 local : TTipoCobrancaModel;
 qryPesquisa : TFDQuery;
 cmdSql : string;
begin
   local := TTipoCobrancaModel.Create;
   dmConexao.conectarBanco;

   try
    cmdSql := ' SELECT * FROM TIPO_COBRANCA CBC '+
              ' WHERE (CBC.ID_ORGANIZACAO =:PIDORGANIZACAO) AND (CBC.ID_TIPO_COBRANCA = :PID) ';

    qryPesquisa := TFDQuery.Create(nil);
    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add(cmdSql);
    qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qryPesquisa.ParamByName('PID').AsString := value.FID;

    qryPesquisa.Open;

     if not  qryPesquisa.IsEmpty then begin

      local := getModel(qryPesquisa);

     end;


   except
   raise Exception.Create('Erro ao obter local por ID');

   end;

   Result := local;
end;

class function TTipoCobrancaDAO.Update(value: TTipoCobrancaModel): Boolean;
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
      cmdSql := ' UPDATE TIPO_COBRANCA '+
                '  SET DESCRICAO = :PDESC '+
                '  WHERE (ID_TIPO_COBRANCA = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO)';


      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add(cmdSql);
      qry.ParamByName('PID').AsString                 := value.FID;
      qry.ParamByName('PIDORGANIZACAO').AsString      := value.FIDorganizacao;
      qry.ParamByName('PDESC').AsString               := value.FDescricao;

      qry.ExecSQL;

       if qry.RowsAffected >0 then begin sucesso := True; end;

    except
      raise Exception.Create('Erro ao tentar manipular dados em  ' + pTable);
    end;

    Result := sucesso;

  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;
end;

end.
