unit uLoteDepositoDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, uContaBancariaDAO,uContaBancariaModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, uLoteDepositoModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,  udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uOrganizacaoDAO, uOrganizacaoModel;


  const
   pTable : string = 'LOTE_DEPOSITO';



type
 TLoteDepositoDAO = class
  private


    class function getModel (query :TFDQuery) : TLoteDepositoModel;

  public

    class function Insert(value: TLoteDepositoModel): Boolean;
    class function obterPorID(value: TLoteDepositoModel): TLoteDepositoModel;
//    class function Update(value :TLoteDepositoModel): Boolean; //lote nao altera.. cancela
    class function Delete(value: TLoteDepositoModel): Boolean;

  end;

implementation


class function TLoteDepositoDAO.Delete(value: TLoteDepositoModel): Boolean;
var
qryDelete : TFDQuery;
sucesso :Boolean;
begin

  sucesso := False;
  dmConexao.conectarBanco;
  qryDelete := TFDQuery.Create(nil);
  try
    try
      qryDelete.Close;
      qryDelete.Connection := dmConexao.conn;
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add('DELETE FROM LOTE_DEPOSITO  ');
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_LOTE_DEPOSITO = :PID ');
      qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qryDelete.ParamByName('PID').AsString := value.FID;

      qryDelete.ExecSQL;

      if qryDelete.RowsAffected > 0 then
      begin

        sucesso := True;
        dmConexao.conn.CommitRetaining;

      end;

    except
      sucesso := False;
      raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

    end;

    Result := sucesso;
  finally
    FreeAndNil(qryDelete);
  end;
end;

class function TLoteDepositoDAO.getModel(query: TFDQuery): TLoteDepositoModel;
var
model       : TLoteDepositoModel;
contaBanco  : TContaBancariaModel;
org         : TOrganizacaoModel;


begin
  model     := TLoteDepositoModel.Create;
  contaBanco  := TContaBancariaModel.Create;
  org         := TOrganizacaoModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID := query.FieldByName('ID_LOTE_DEPOSITO').AsString;
      model.FIDorganizacao := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FIDusuario := query.FieldByName('ID_USUARIO').AsInteger;
      model.FIDcontaBancaria := query.FieldByName('ID_CONTA_BANCARIA').AsString;
      model.FDataRegistro := query.FieldByName('DATA_REGISTRO').AsDateTime;
      model.FDataAtualizacao := query.FieldByName('DATA_ATUALIZACAO').AsDateTime;
      model.Flote := query.FieldByName('LOTE').AsString;
      model.FStatus := query.FieldByName('STATUS').AsString;
      model.FqtdCheque := query.FieldByName('QTD_CHQ').AsInteger;
      model.FtotalDeposito := query.FieldByName('TOTAL_DEPOSITO').AsCurrency;

      model.Fnovo := False;

      org.FID := model.FIDorganizacao;
      org := TOrganizacaoDAO.obterPorID(org);
      model.Forganizacao := org;

      contaBanco.FIDorganizacao := model.FIDcontaBancaria;
      contaBanco.FID := model.FIDcontaBancaria;
      model.FContaBancaria := contaBanco;

    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TLoteDepositoDAO.Insert(value: TLoteDepositoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
  sucesso : Boolean;

begin
  dmConexao.conectarBanco;
  sucesso := False;
  try
    try

      cmdSql := ' INSERT INTO LOTE_DEPOSITO (ID_LOTE_DEPOSITO, ID_ORGANIZACAO, ID_CONTA_BANCARIA,ID_USUARIO, ' + ' LOTE, STATUS, DATA_REGISTRO, DATA_ATUALIZACAO,   ' + ' QTD_CHQ,  TOTAL_DEPOSITO) ' + ' VALUES (:PID, :PIDORGANIZACAO, :PCONTA, :PUSER, ' + ' :PLOTE, :PSTATUS, :PDATAREGISTRO, :PDATA, ' + ' :PQTD_CHQ, :PTOTAL ) ';

      qry := TFDQuery.Create(nil);
      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add(cmdSql);

      qry.ParamByName('PID').AsString := value.FID;
      qry.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qry.ParamByName('PCONTA').AsString := value.FIDcontaBancaria;
      qry.ParamByName('PUSER').AsInteger := value.FIDusuario;
      qry.ParamByName('PSTATUS').AsString := value.FStatus;
      qry.ParamByName('PLOTE').AsString := value.Flote;
      qry.ParamByName('PQTD_CHQ').AsInteger := value.FqtdCheque;
      qry.ParamByName('PTOTAL').AsCurrency := value.FtotalDeposito;
      qry.ParamByName('PDATAREGISTRO').AsDate := value.FDataRegistro;
      qry.ParamByName('PDATA').AsDate := value.FDataAtualizacao;

      qry.ExecSQL;

      if qry.RowsAffected > 0 then
      begin
        sucesso := True;
        dmConexao.conn.CommitRetaining;
      end;

    except
      Result := sucesso;
      raise Exception.Create('Erro ao tentar inserir ' + pTable);
    end;

    Result := sucesso;
  finally
    FreeAndNil(qry);

  end;
end;

class function TLoteDepositoDAO.obterPorID( value: TLoteDepositoModel): TLoteDepositoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TLoteDepositoModel;
begin

  dmConexao.conectarBanco;
  qryPesquisa := TFDQuery.Create(nil);
  model := TLoteDepositoModel.Create;

  try

    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add('SELECT * ');
    qryPesquisa.SQL.Add('FROM LOTE_DEPOSITO  ');
    qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND ID_LOTE_DEPOSITO = :PID ');

    qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIdOrganizacao;
    qryPesquisa.ParamByName('PID').AsString := value.FID;
    qryPesquisa.Open;

    if not qryPesquisa.IsEmpty then
    begin

      model := getModel(qryPesquisa);
    end;

  except
    raise Exception.Create('Erro ao tentar obter ' + pTable);
  end;

  Result := model;
end;

end.
