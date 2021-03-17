unit uBancoDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, uBancoModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,  udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'BANCO';



type
 TBancoDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;

    class function getModel (query :TFDQuery) : TBancoModel;

  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
    class function Insert(value :TBancoModel): Boolean;
    class function obterPorID(value :TBancoModel): TBancoModel;
    class function Update(value :TBancoModel): Boolean;
    class function Delete(value :TBancoModel): Boolean;
    class function incIndice(value :TBancoModel): Boolean;


  end;

implementation


class function TBancoDAO.Delete(value: TBancoModel): Boolean;
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
  qryDelete.SQL.Add('DELETE FROM BANCO  '  );
  qryDelete.SQL.Add('WHERE ID_BANCO = :PID '  );
  qryDelete.ParamByName('PID').AsString := value.FID;

  qryDelete.ExecSQL;

  dmConexao.conn.Commit;

  xResp := True;


 except
 xResp := False;

  value.FINDICE := 1;
  Update(value);
 raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

 end;

  Result := xResp;
end;

class function TBancoDAO.getModel(query: TFDQuery): TBancoModel;
var model :TBancoModel;

begin
      model                 := TBancoModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID             := query.FieldByName('ID_BANCO').AsString;
      model.FCODIGO_BANCO   := query.FieldByName('CODIGO_BANCO').AsString;
      model.FNOME_BANCO     := query.FieldByName('NOME_BANCO').AsString;
      model.FSIGLA_BANCO    := query.FieldByName('SIGLA_BANCO').AsString;
      model.FINDICE         := query.FieldByName('INDICE').AsInteger;
      model.Fnovo           := False;


    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TBancoDAO.incIndice(value: TBancoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try

     cmdSql := ' UPDATE BANCO '+
               ' SET INDICE = :PINDICE '+
               ' WHERE (ID_BANCO = :PID) ';


          qry.Close;
          qry.Connection := dmConexao.conn;
          qry.SQL.Clear;
          qry.SQL.Add(cmdSql);
          qry.ParamByName('PID').AsString            := value.FID;
          qry.ParamByName('PINDICE').AsInteger       := (value.FINDICE + 1);

         qry.ExecSQL;
         dmConexao.conn.Commit;

    except
      dmConexao.conn.Rollback;

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


class function TBancoDAO.Insert(value: TBancoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try

     cmdSql := ' INSERT INTO BANCO (ID_BANCO, CODIGO_BANCO, NOME_BANCO, SIGLA_BANCO, INDICE, ID_ORGANIZACAO) '+
               ' VALUES (:PID, :PCODIGO_BANCO, :PNOME_BANCO, :PSIGLA_BANCO, :PINDICE, :PORG) ';



          qry.Close;
          qry.Connection := dmConexao.conn;
          qry.SQL.Clear;
          qry.SQL.Add(cmdSql);


          qry.ParamByName('PID').AsString               := value.FID;
          qry.ParamByName('PCODIGO_BANCO').AsString     := value.FCODIGO_BANCO;
          qry.ParamByName('PNOME_BANCO').AsString       := value.FNOME_BANCO.ToUpper;
          qry.ParamByName('PSIGLA_BANCO').AsString      := value.FSIGLA_BANCO.ToUpper;
          qry.ParamByName('PINDICE').AsInteger           := 1;
          qry.ParamByName('PORG').AsString := uUtil.TOrgAtual.getId;


         qry.ExecSQL;
         dmConexao.conn.CommitRetaining;
    except
      dmConexao.conn.RollbackRetaining;
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

class function TBancoDAO.obterPorID( value: TBancoModel): TBancoModel;
var
qryPesquisa : TFDQuery;
model: TBancoModel;
begin

dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := TBancoModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM BANCO  '  );
  qryPesquisa.SQL.Add('WHERE ID_BANCO = :PID '  );

  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      model := getModel(qryPesquisa);  end;


except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;
 Result := model;
end;

class function TBancoDAO.Update(value: TBancoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try

     cmdSql := ' UPDATE BANCO '+
               ' SET CODIGO_BANCO = :PCODIGO_BANCO, NOME_BANCO = :PNOME_BANCO, '+
               ' SIGLA_BANCO = :PSIGLA_BANCO, INDICE = :PINDICE, ID_ORGANIZACAO = :PORG '+
               ' WHERE (ID_BANCO = :PID) ';


          qry.Close;
          qry.Connection := dmConexao.conn;
          qry.SQL.Clear;
          qry.SQL.Add(cmdSql);


          qry.ParamByName('PID').AsString               := value.FID;
          qry.ParamByName('PCODIGO_BANCO').AsString     := value.FCODIGO_BANCO;
          qry.ParamByName('PNOME_BANCO').AsString       := value.FNOME_BANCO.ToUpper;
          qry.ParamByName('PSIGLA_BANCO').AsString      := value.FSIGLA_BANCO.ToUpper;
          qry.ParamByName('PINDICE').AsInteger           := value.FINDICE;
          qry.ParamByName('PORG').AsString := uUtil.TOrgAtual.getId;

         qry.ExecSQL;
 //      dmConexao.conn.CommitRetaining;
         dmConexao.conn.Commit;

    except
      dmConexao.conn.RollbackRetaining;
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
