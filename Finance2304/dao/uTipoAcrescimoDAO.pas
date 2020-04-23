unit uTipoAcrescimoDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uTipoAcrescimoModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uHistoricoModel, uHistoricoDAO, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'TIPO_ACRESCIMO';



type
 TTipoAcrescimoDAO = class
  private
    class function getModel (query :TFDQuery) : TTipoAcrescimoModel;
  public
    {métodos CRUD (Create, Read, Update e Delete)
    para manipulação dos dados}
    class function Insert(value :TTipoAcrescimoModel): Boolean;
    class function obterPorID(value :TTipoAcrescimoModel): TTipoAcrescimoModel;
    class function Update(value :TTipoAcrescimoModel): Boolean;
    class function Delete(value :TTipoAcrescimoModel): Boolean;

  end;

implementation

class function TTipoAcrescimoDAO.Delete(value: TTipoAcrescimoModel): Boolean;
var
qryDelete : TFDQuery;
xResp :Boolean;
begin

xResp := False;
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
  xResp := True;


 except
 xResp := False;
 raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

 end;

  Result := xResp;
end;

class function TTipoAcrescimoDAO.getModel(query: TFDQuery): TTipoAcrescimoModel;
var model :TTipoAcrescimoModel;
 historico : THistoricoModel;
begin

  if not query.IsEmpty then begin

    try

      model                    := TTipoAcrescimoModel.Create;
      model.FID                := query.FieldByName('ID_TIPO_ACRESCIMO').AsString;
      model.FIDorganizacao     := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FDescricao         := query.FieldByName('DESCRICAO').AsString;
      model.FIDHistorico       := query.FieldByName('ID_HISTORICO').AsString;

    try
      historico                := THistoricoModel.Create;
      historico.FID            := model.FIDHistorico;
      historico.FIDorganizacao := model.FIDorganizacao;
      model.Fhistorico         := THistoricoDAO.obterPorID(historico);

    except
      raise Exception.Create('Erro ao tentar obter Conta Contabil por ' + pTable);

    end;




    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TTipoAcrescimoDAO.Insert(value: TTipoAcrescimoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin

  dmConexao.conectarBanco;
  try

     cmdSql :=  ' INSERT INTO TIPO_ACRESCIMO '+
                ' (ID_TIPO_ACRESCIMO, ID_ORGANIZACAO, DESCRICAO, ID_HISTORICO '+
                ' VALUES (:PID, :PIDORGANIZACAO, :PDESCRICAO, :PIDHISTORICO )' ;

    qry := TFDQuery.Create(nil);
    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString            := value.FDescricao;
    qry.ParamByName('PIDHISTORICO').AsString          := value.FIDHistorico ;
    qry.ExecSQL;

  except
    Result := False;
    raise Exception.Create('Erro ao tentar inserir ' + pTable);
  end;

  Result := System.True;
end;

class function TTipoAcrescimoDAO.obterPorID( value: TTipoAcrescimoModel): TTipoAcrescimoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TTipoAcrescimoModel;
begin

dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM ' + pTable  );
  qryPesquisa.SQL.Add('WHERE ID_'+pTable+ ' = :PID '  );

  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      model := TTipoAcrescimoModel.Create;
      model := getModel(qryPesquisa);  end;


except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;

 Result := model;
end;

class function TTipoAcrescimoDAO.Update(value: TTipoAcrescimoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin

  dmConexao.conectarBanco;
  try

     cmdSql := ' UPDATE TIPO_ACRESCIMO '+
               ' SET ID_HISTORICO = :PIDHISTORICO, '+
               ' DESCRICAO = :PDESCRICAO '+
               ' WHERE (ID_TIPO_ACRESCIMO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO )';



    qry := TFDQuery.Create(nil);
    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString            := value.FDescricao;
    qry.ParamByName('PIDHISTORICO').AsString          := value.FIDHistorico ;
    qry.ExecSQL;


  except
    Result := False;
    raise Exception.Create('Erro ao tentar alterar ' + pTable);
  end;

  Result := System.True;
end;
end.
