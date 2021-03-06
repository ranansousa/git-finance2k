unit uTipoOperacaoBancariaDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,uTipoOperacaoBancariaModel,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uContaContabilModel, uContaContabilDAO;


const
   pTable : string = 'TIPO_OPERACAO_BANCARIA';

type
 TTipoOperacaoBancariaDAO = class
  private

    class function getModel (query :TFDQuery) : TTipoOperacaoBancariaModel;
  public


    class function Insert(value :TTipoOperacaoBancariaModel): Boolean;
    class function obterPorID(value :TTipoOperacaoBancariaModel): TTipoOperacaoBancariaModel;
    class function Update(value :TTipoOperacaoBancariaModel): Boolean;
    class function Delete(value :TTipoOperacaoBancariaModel): Boolean;

  end;

implementation

class function TTipoOperacaoBancariaDAO.Delete(value: TTipoOperacaoBancariaModel): Boolean;
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
  qryDelete.SQL.Add('DELETE FROM ' + pTable  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_'+pTable +' = :PID '  );
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

class function TTipoOperacaoBancariaDAO.getModel(query: TFDQuery): TTipoOperacaoBancariaModel;
var model :TTipoOperacaoBancariaModel;
 contaCTB : TContaContabilModel;
begin

  if not query.IsEmpty then begin

    try

      model                   := TTipoOperacaoBancariaModel.Create;
      model.FID               := query.FieldByName('ID_TIPO_OPERACAO_BANCARIA').AsString;
      model.FIDorganizacao    := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.Fdescricao        := query.FieldByName('DESCRICAO').AsString;
      model.Ftipo             := query.FieldByName('TIPO').AsInteger;
      model.Fcodigo           := query.FieldByName('CODIGO').AsInteger;
      model.FIDcontaContabil  := query.FieldByName('ID_CONTA_CONTABIL').AsString;

       if not uutil.Empty (model.FIDcontaContabil) then begin
           contaCTB                 := TContaContabilModel.Create;
           contaCTB.FIDorganizacao  := model.FIDorganizacao;
           contaCTB.FID             := model.FIDcontaContabil;
           model.FcontaContabil     := TContaContabilDAO.obterPorID(contaCTB);
       end;

    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;


  end;


   Result := model;

end;

class function TTipoOperacaoBancariaDAO.Insert(value: TTipoOperacaoBancariaModel): Boolean;
var
  qryGenerica: TFDQuery;
  cmdSql: string;
sucesso :Boolean;
begin
sucesso := False;
  dmConexao.conectarBanco;
  qryGenerica := TFDQuery.Create(nil);

  try

     cmdSql :=  ' INSERT INTO TIPO_OPERACAO_BANCARIA '+
                ' (ID_TIPO_OPERACAO_BANCARIA, ID_ORGANIZACAO, '+
                ' DESCRICAO, TIPO, CODIGO, ID_CONTA_CONTABIL )'+
                ' VALUES (:PID, :PIDORGANIZACAO, '+
                ' :PDESCRICAO, :PTIPO, :PCODIGO, :PIDCONTA_CONTABIL)' ;


    qryGenerica.Close;
    qryGenerica.Connection := dmConexao.conn;
    qryGenerica.SQL.Clear;
    qryGenerica.SQL.Add(cmdSql);
    qryGenerica.ParamByName('PID').AsString               := value.FID;
    qryGenerica.ParamByName('PIDORGANIZACAO').AsString    := value.FIDorganizacao;
    qryGenerica.ParamByName('PDESCRICAO').AsString        := value.Fdescricao;
    qryGenerica.ParamByName('PTIPO').AsInteger            := value.Ftipo;
    qryGenerica.ParamByName('PCODIGO').AsInteger          := value.Fcodigo;
    qryGenerica.ParamByName('PIDCONTA_CONTABIL').AsString := value.FIDcontaContabil;


    if uutil.Empty(value.FIdContaContabil) then
    begin
      qryGenerica.ParamByName('PIDCONTA_CONTABIL').value := null;
    end;

    qryGenerica.ExecSQL;
    if qryGenerica.RowsAffected >0  then begin sucesso := True; dmConexao.conn.CommitRetaining;  end;

  finally
    FreeAndNil(qryGenerica);
  end;

  Result := sucesso;
end;

class function TTipoOperacaoBancariaDAO.obterPorID( value: TTipoOperacaoBancariaModel): TTipoOperacaoBancariaModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TTipoOperacaoBancariaModel;
begin

dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM     ' + pTable  );
  qryPesquisa.SQL.Add('WHERE ID_' + pTable  +' = :PID '  );

  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      model := TTipoOperacaoBancariaModel.Create;
      model := getModel(qryPesquisa);  end;


except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;

 Result := model;
end;

class function TTipoOperacaoBancariaDAO.Update(value: TTipoOperacaoBancariaModel): Boolean;
var
  qryGenerica: TFDQuery;
  cmdSql: string;
begin

  dmConexao.conectarBanco;
  try

     cmdSql :=  ' UPDATE TIPO_OPERACAO_BANCARIA '+
                ' SET DESCRICAO       = :PDESCRICAO, '+
                ' TIPO                = :PTIPO,  '+
                ' CODIGO              = :PCODIGO, '+
                ' ID_CONTA_CONTABIL   = :PIDCONTA_CONTABIL '+
                ' WHERE (ID_TIPO_OPERACAO_BANCARIA = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';


    qryGenerica := TFDQuery.Create(nil);
    qryGenerica.Close;
    qryGenerica.Connection := dmConexao.conn;
    qryGenerica.SQL.Clear;
    qryGenerica.SQL.Add(cmdSql);
    qryGenerica.ParamByName('PID').AsString               := value.FID;
    qryGenerica.ParamByName('PIDORGANIZACAO').AsString    := value.FIDorganizacao;
    qryGenerica.ParamByName('PDESCRICAO').AsString        := value.Fdescricao;
    qryGenerica.ParamByName('PTIPO').AsInteger            := value.Ftipo;
    qryGenerica.ParamByName('PCODIGO').AsInteger          := value.Fcodigo;
    qryGenerica.ParamByName('PIDCONTA_CONTABIL').AsString := value.FIDcontaContabil;

    qryGenerica.ExecSQL;

  except
    Result := False;
    raise Exception.Create('Erro ao tentar alterar ' + pTable);
  end;

  Result := System.True;
end;
end.
