unit uNotaFiscalEntradaDAO;


interface

{
CREATE TABLE NOTA_FISCAL_ENTRADA (
    ID_NOTA_FISCAL_ENTRADA  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO          VARCHAR(36) NOT NULL,
    ID_RESPONSAVEL          VARCHAR(36),
    ID_TIPO_NOTA_FISCAL     VARCHAR(36),
    ID_USUARIO              NUMERIC(5,0),

    NUMERO                  VARCHAR(20),
    DESCRICAO               VARCHAR(150),
    OBSERVACAO              VARCHAR(200),
    SERIE                   VARCHAR(2),
    SUB_SERIE               VARCHAR(2),
    ALIQUOTA_ISS            VARCHAR(5),

    DATA_RETENCAO_ISS       DATE,
    DATA_REGISTRO           DATE,
    DATA_EMISSAO            DATE,
    DATA_PROTOCOLO          DATE,

    VALOR                   NUMERIC(10,2),
    VALOR_ISS               NUMERIC(10,2),
    BASE_CALCULO_ISS        NUMERIC(10,2),

);
}


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil, uNotaFiscalEntradaModel,
  uTipoNotaFiscalModel,uFuncionarioModel,uUsuarioModel,
  uTipoNotaFiscalDAO,uFuncionarioDAO,uUsuarioDAO,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,Vcl.StdCtrls, uOrganizacaoModel;

  const
   pTable : string = 'NOTA_FISCAL_ENTRADA';

type
 TNotaFiscalEntradaDAO = class
  private
    class function getModel (query :TFDQuery) : TNotaFiscalEntradaModel;
  public

    class function Insert(value     :TNotaFiscalEntradaModel): Boolean;
    class function obterPorID(value :TNotaFiscalEntradaModel): TNotaFiscalEntradaModel;
    class function Update(value     :TNotaFiscalEntradaModel): Boolean;
    class function Delete(value     :TNotaFiscalEntradaModel): Boolean;


  end;

implementation

class function TNotaFiscalEntradaDAO.Delete(value: TNotaFiscalEntradaModel): Boolean;
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
      qryDelete.SQL.Add('DELETE FROM NOTA_FISCAL_ENTRADA  ');
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_NOTA_FISCAL_ENTRADA = :PID ');
      qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qryDelete.ParamByName('PID').AsString := value.FID;

      qryDelete.ExecSQL;
      xResp := True;

      dmConexao.conn.CommitRetaining;

    except
      dmConexao.conn.RollbackRetaining;
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

class function TNotaFiscalEntradaDAO.getModel(query: TFDQuery): TNotaFiscalEntradaModel;
var
  model: TNotaFiscalEntradaModel;
begin
  model := TNotaFiscalEntradaModel.Create;
  model.Fresponsavel := TFuncionarioModel.Create;
  model.FtipoNotaFiscal := TTipoNotaFiscalModel.Create;
  model.Fusuario := TUsuarioModel.Create;


  if not query.IsEmpty then begin

    try

      model.FID                 := query.FieldByName('ID_NOTA_FISCAL_ENTRADA').AsString;
      model.FIDorganizacao      := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FIDresponsavel      := query.FieldByName('ID_RESPONSAVEL').AsString;
      model.FIDtipoNotaFiscal   := query.FieldByName('ID_TIPO_NOTA_FISCAL').AsString;
      model.FIDusuario          := query.FieldByName('ID_USUARIO').AsInteger;

      model.FDescricao          := query.FieldByName('DESCRICAO').AsString;
      model.Fnumero             := query.FieldByName('NUMERO').AsString;
      model.Fobservacao         := query.FieldByName('OBSERVACAO').AsString;
      model.Fserie              := query.FieldByName('SERIE').AsString;
      model.FsubSerie           := query.FieldByName('SUB_SERIE').AsString;
      model.FaliquotaISS        := query.FieldByName('ALIQUOTA_ISS').AsString;


      model.FdataRetenncaoISS   := query.FieldByName('DATA_RETENCAO_ISS').AsDateTime;
      model.FdataRegistro       := query.FieldByName('DATA_REGISTRO').AsDateTime;
      model.FdataEmissao        := query.FieldByName('DATA_EMISSAO').AsDateTime;
      model.FdataProtocolo      := query.FieldByName('DATA_PROTOCOLO').AsDateTime;

      model.Fvalor              := query.FieldByName('VALOR').AsCurrency;
      model.FvalorISS           := query.FieldByName('VALOR_ISS').AsCurrency;
      model.FbaseCalculoISS     := query.FieldByName('BASE_CALCULO_ISS').asCurrency;


      try
         model.Fusuario.FIDorganizacao := model.FIDorganizacao;
         model.Fusuario.FID := model.FIDusuario;
         model.Fusuario := TUsuarioDAO.obterPorID(model.Fusuario);

      except raise Exception.Create('Erro ao tentar obter o usuario ');

      end;

      try
         model.FtipoNotaFiscal.FIDorganizacao := model.FIDorganizacao;
         model.FtipoNotaFiscal.FID := model.FIDtipoNotaFiscal;
         model.FtipoNotaFiscal := TTipoNotaFiscalDAO.obterPorID(model.FtipoNotaFiscal);

      except raise Exception.Create('Erro ao tentar obter o tipo da nota ');

      end;

      try

         model.Fresponsavel.FIDorganizacao := model.FIDorganizacao;
         model.Fresponsavel.FID := model.FIDresponsavel;
         model.Fresponsavel := TFuncionarioDAO.obterPorID(model.Fresponsavel);

      except raise Exception.Create('Erro ao tentar obter o responsavel ');

      end;

    except

      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TNotaFiscalEntradaDAO.Insert(value: TNotaFiscalEntradaModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
  sucesso : Boolean;
begin
 sucesso := True;
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try

   cmdSql :=  ' INSERT INTO NOTA_FISCAL_ENTRADA '+
              ' (ID_NOTA_FISCAL_ENTRADA, ID_ORGANIZACAO, NUMERO, '+
              '  DESCRICAO, ID_RESPONSAVEL, DATA_REGISTRO, DATA_EMISSAO, ' +
              ' DATA_PROTOCOLO, VALOR, OBSERVACAO, SERIE, SUB_SERIE, VALOR_ISS, ' +
              ' BASE_CALCULO_ISS, ALIQUOTA_ISS, DATA_RETENCAO_ISS, ID_TIPO_NOTA_FISCAL, ID_USUARIO) '+
              ' VALUES (:PID, :PIDORGANIZACAO, :PNUMERO, '+
              ' :PDESCRICAO, :PIDRESPONSAVEL, :PDATA_REGISTRO, :PDATA_EMISSAO, ' +
              ' :PDATA_PROTOCOLO, :PVALOR, :POBSERVACAO, :PSERIE, :PSUB_SERIE, :PVALOR_ISS, ' +
              ' :PBASE_CALCULO_ISS, :PALIQUOTA_ISS, :PDATA_RETENCAO_ISS, :PID_TIPO_NOTA_FISCAL, :PID_USUARIO) ';




    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);

    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PID_USUARIO').AsInteger          := value.FIDusuario;
    qry.ParamByName('PNUMERO').AsString               := value.Fnumero;
    qry.ParamByName('PDESCRICAO').AsString            := upperCase(value.Fdescricao);
    qry.ParamByName('PIDRESPONSAVEL').AsString        := value.FIDresponsavel;
    qry.ParamByName('PDATA_REGISTRO').AsDate          := value.FdataRegistro;
    qry.ParamByName('PDATA_EMISSAO').AsDate           := value.FdataEmissao;
    qry.ParamByName('PDATA_PROTOCOLO').AsDate         := value.FdataProtocolo;
    qry.ParamByName('PDATA_RETENCAO_ISS').AsDate      := value.FdataRetenncaoISS;
    qry.ParamByName('POBSERVACAO').AsString           := upperCase(value.Fobservacao);
    qry.ParamByName('PSERIE').AsString                := upperCase(value.Fserie);
    qry.ParamByName('PSUB_SERIE').AsString            := upperCase(value.FsubSerie);
    qry.ParamByName('PALIQUOTA_ISS').AsString         := value.FaliquotaISS;
    qry.ParamByName('PID_TIPO_NOTA_FISCAL').AsString  := value.FIDtipoNotaFiscal;
    qry.ParamByName('PBASE_CALCULO_ISS').AsCurrency   := value.FbaseCalculoISS;
    qry.ParamByName('PVALOR_ISS').AsCurrency          := value.FvalorISS;
    qry.ParamByName('PVALOR').AsCurrency              := value.Fvalor;

     qry.ExecSQL;

    Result := sucesso;
  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;
end;

class function TNotaFiscalEntradaDAO.obterPorID( value: TNotaFiscalEntradaModel): TNotaFiscalEntradaModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TNotaFiscalEntradaModel;
begin

dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := TNotaFiscalEntradaModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM NOTA_FISCAL_ENTRADA'  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_NOTA_FISCAL_ENTRADA = :PID '  );

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

class function TNotaFiscalEntradaDAO.Update(value: TNotaFiscalEntradaModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
    sucesso : Boolean;
begin
sucesso := True;

  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);


  try

   cmdSql :=  ' UPDATE NOTA_FISCAL_ENTRADA'+
              ' SET NUMERO        = :PNUMERO, '+
              '    DESCRICAO      = :PDESCRICAO, '+
              '    ID_RESPONSAVEL = :PIDRESPONSAVEL, '+
              '    DATA_EMISSAO   = :PDATA_EMISSAO, '+
              '    DATA_PROTOCOLO = :PDATA_PROTOCOLO, '+
              '    VALOR          = :PVALOR, '+
              '    OBSERVACAO     = :POBSERVACAO, '+
              '    SERIE          = :PSERIE, '+
              '    SUB_SERIE      = :PSUB_SERIE, '+
              '    VALOR_ISS      = :PVALOR_ISS, '+
              '    BASE_CALCULO_ISS     = :PBASE_CALCULO_ISS, '+
              '    ALIQUOTA_ISS         = :PALIQUOTA_ISS, '+
              '    DATA_RETENCAO_ISS    = :PDATA_RETENCAO_ISS, '+
              '    ID_TIPO_NOTA_FISCAL  = :PID_TIPO_NOTA_FISCAL, '+
              '    ID_USUARIO           = :PID_USUARIO '+
              ' WHERE (ID_NOTA_FISCAL_ENTRADA = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';


    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);

    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PID_USUARIO').AsInteger          := value.FIDusuario;
    qry.ParamByName('PNUMERO').AsString               := value.Fnumero;
    qry.ParamByName('PDESCRICAO').AsString            := upperCase(value.Fdescricao);
    qry.ParamByName('PIDRESPONSAVEL').AsString        := value.FIDresponsavel;
//    qry.ParamByName('PDATA_REGISTRO').AsDate          := value.FdataRegistro;
    qry.ParamByName('PDATA_EMISSAO').AsDate           := value.FdataEmissao;
    qry.ParamByName('PDATA_PROTOCOLO').AsDate         := value.FdataProtocolo;
    qry.ParamByName('PDATA_RETENCAO_ISS').AsDate      := value.FdataRetenncaoISS;
    qry.ParamByName('POBSERVACAO').AsString           := upperCase(value.Fobservacao);
    qry.ParamByName('PSERIE').AsString                := upperCase(value.Fserie);
    qry.ParamByName('PSUB_SERIE').AsString            := upperCase(value.FsubSerie);
    qry.ParamByName('PALIQUOTA_ISS').AsString         := value.FaliquotaISS;
    qry.ParamByName('PID_TIPO_NOTA_FISCAL').AsString  := value.FIDtipoNotaFiscal;
    qry.ParamByName('PBASE_CALCULO_ISS').AsCurrency   := value.FbaseCalculoISS;
    qry.ParamByName('PVALOR_ISS').AsCurrency          := value.FvalorISS;
    qry.ParamByName('PVALOR').AsCurrency              := value.Fvalor;

      qry.ExecSQL;

    Result := sucesso;

  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;
end;
end.
