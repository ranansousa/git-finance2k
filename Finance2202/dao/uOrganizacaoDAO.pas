unit uOrganizacaoDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uOrganizacaoModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'ORGANIZACAO';

type
 TOrganizacaoDAO = class
  private
    class function getModel (query :TFDQuery) : TOrganizacaoModel;
  public
    {métodos CRUD (Create, Read, Update e Delete)
    para manipulação dos dados}
    class function Insert(value :TOrganizacaoModel): Boolean;
    class function obterPorID(value :TOrganizacaoModel): TOrganizacaoModel;
    class function Update(value :TOrganizacaoModel): Boolean;
    class function Delete(value :TOrganizacaoModel): Boolean;
    class function ajustarVersao(value :TOrganizacaoModel) :Boolean;

  end;

implementation

class function TOrganizacaoDAO.ajustarVersao(value: TOrganizacaoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
sucesso : Boolean;
begin
 sucesso := False;

  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);

  try
    cmdSql := ' UPDATE ORGANIZACAO ORG SET ORG.VERSAO = :PVERSAO WHERE ORG.ID_ORGANIZACAO = :PID' ;

    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString      := value.FID;
    qry.ParamByName('PVERSAO').AsString  := value.FVersao;
    qry.ExecSQL;

    dmConexao.conn.CommitRetaining;

    if qry.RowsAffected >0 then sucesso :=  True;

    Result := sucesso;

  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;

class function TOrganizacaoDAO.Delete(value: TOrganizacaoModel): Boolean;
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

      qry.ParamByName('PID').AsString := value.FID;

      qry.ExecSQL;
      xResp := True;

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

class function TOrganizacaoDAO.getModel(query: TFDQuery): TOrganizacaoModel;
var model :TOrganizacaoModel;
begin
  model := TOrganizacaoModel.Create;

  if not query.IsEmpty then
  begin


      model.FID                   := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FSN1                  := query.FieldByName('SN1').AsString;
      model.FSN2                  := query.FieldByName('SN2').AsString;
      model.FSN3                  := query.FieldByName('SN3').AsString;
      model.FVersao               := query.FieldByName('VERSAO').AsString;
      model.FHOST_IP              := query.FieldByName('HOST_IP').AsString;
      model.FHOST_NAME            := query.FieldByName('HOST_NAME').AsString;
      model.FCODINOME             := query.FieldByName('CODINOME').AsString;
      model.FCODIGO_WEB           := query.FieldByName('CODIGO_WEB').AsString;
      model.FSOCKET_WEB           := query.FieldByName('SOCKET_WEB').AsString;
      model.FLICENCA              := query.FieldByName('LICENCA').AsString;
      model.FSERIAL_CLIENTE       := query.FieldByName('SERIAL_CLIENTE').AsString;
      model.FSERIAL_HD            := query.FieldByName('SERIAL_HD').AsString;
      model.FSISTEMA_CONTABIL     := query.FieldByName('SISTEMA_CONTABIL').AsString;
      model.FIPSERVERBD           := query.FieldByName('IPSERVERBD').AsString;
      model.FNAMESERVERBD         := query.FieldByName('NAMESERVERBD').AsString;
      model.FIDBAIRRO             := query.FieldByName('ID_BAIRRO').AsString;
      model.FIDCIDADE             := query.FieldByName('ID_CIDADE').AsString;
      model.FIDESTADO             := query.FieldByName('ID_ESTADO').AsString;
      model.FCEP                  := query.FieldByName('CEP').AsString;
      model.FNUMERO               := query.FieldByName('NUMERO').AsString;
      model.FCOMPLEMENTO          := query.FieldByName('COMPLEMENTO').AsString;
      model.FLOGRADOURO           := query.FieldByName('LOGRADOURO').AsString;
      model.FINSCRICAO_ESTADUAL   := query.FieldByName('INSCRICAO_MUNICIPAL').AsString;
      model.FINSCRICAO_MUNICIPAL  := query.FieldByName('INSCRICAO_ESTADUAL').AsString;
      model.FCNPJ                 := query.FieldByName('CNPJ').AsString;
      model.FFantasia             := query.FieldByName('FANTASIA').AsString;
      model.FSigla                := query.FieldByName('SIGLA').AsString;
      model.FRazaoSocial          := query.FieldByName('RAZAO_SOCIAL').AsString;
      model.FFLAG_HST             := query.FieldByName('FLAG_HST').AsInteger;
      model.FATIVA                := query.FieldByName('ATIVA').AsInteger;
      model.FDATA_ATUALIZACAO     := query.FieldByName('DATA_ATUALIZACAO').AsDateTime;
      model.Fnovo                 := False;

  end;


   Result := model;

end;

class function TOrganizacaoDAO.Insert(value: TOrganizacaoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
  sucesso : Boolean;
begin
 sucesso := True;
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);

  try
     cmdSql :=  ' INSERT INTO TIPO_DEDUCAO '+
                ' (ID_TIPO_DEDUCAO, ID_ORGANIZACAO, DESCRICAO, ID_HISTORICO '+
                ' VALUES (:PID, :PIDORGANIZACAO, :PDESCRICAO, :PIDHISTORICO )' ;

    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;

//    qry.ExecSQL;

   Result := sucesso;

  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;

class function TOrganizacaoDAO.obterPorID( value: TOrganizacaoModel): TOrganizacaoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TOrganizacaoModel;
begin
dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
 model := TOrganizacaoModel.Create;
  try

    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add('SELECT * ');
    qryPesquisa.SQL.Add('FROM ' + pTable);
    qryPesquisa.SQL.Add('WHERE ID_' + pTable + ' = :PID ');

    qryPesquisa.ParamByName('PID').AsString := value.FID;
    qryPesquisa.Open;

    if not qryPesquisa.IsEmpty then
    begin

      model := getModel(qryPesquisa);
    end;

    Result := model;

  finally
    if Assigned(qryPesquisa) then
    begin
      FreeAndNil(qryPesquisa);
    end;
  end;

end;

class function TOrganizacaoDAO.Update(value: TOrganizacaoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
sucesso : Boolean;
begin
 sucesso := True;

  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try


     cmdSql := ' UPDATE TIPO_DEDUCAO '+
               ' SET ID_HISTORICO = :PIDHISTORICO, '+
               ' DESCRICAO = :PDESCRICAO '+
               ' WHERE (ID_TIPO_DEDUCAO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO )';




    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;


    qry.ExecSQL;


    Result := System.True;
  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;
end.
