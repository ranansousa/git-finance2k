unit uCartaoCreditoDAO;


interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uCartaoCreditoModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'CARTAO_CREDITO';

type
 TCartaoCreditoDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;

    class function getModel (query :TFDQuery) : TCartaoCreditoModel;
  public
    {métodos CRUD (Create, Read, Update e Delete)
    para manipulação dos dados}
   class function Insert(value :TCartaoCreditoModel): Boolean;
    class function obterPorID(value :TCartaoCreditoModel): TCartaoCreditoModel;
    class function Update(value :TCartaoCreditoModel): Boolean;
    class function Delete(value :TCartaoCreditoModel): Boolean;

  end;

implementation

class function TCartaoCreditoDAO.Delete(value: TCartaoCreditoModel): Boolean;
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
      qryDelete.SQL.Add('DELETE FROM CARTAO_CREDITO  ');
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CARTAO_CREDITO = :PID ');
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

class function TCartaoCreditoDAO.getModel(query: TFDQuery): TCartaoCreditoModel;
var model :TCartaoCreditoModel;

begin

  model := TCartaoCreditoModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID                   := query.FieldByName('ID_CARTAO_CREDITO').AsString;
      model.FIDorganizacao        := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FDataValidade         := query.FieldByName('DATA_VALIDADE').AsDateTime;
      model.FLimite               := query.FieldByName('LIMITE').AsCurrency;
      model.FDiaCompra            := query.FieldByName('DIA_COMPRA').AsString;
      model.FBandeira             := query.FieldByName('BANDEIRA').AsString;
      model.FCodigoSeguranca      := query.FieldByName('CODIGO_SEGURANCA').AsString;
      model.FTitular              := query.FieldByName('TITULAR').AsString;
      model.FDiaVencimento        := query.FieldByName('DIA_VENCIMENTO').AsString;
      model.FNumero               := query.FieldByName('NUMERO').AsString;
      model.FCartao               := query.FieldByName('CARTAO').AsString;


    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TCartaoCreditoDAO.Insert(value: TCartaoCreditoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try

     cmdSql :=  ' INSERT INTO CARTAO_CREDITO '+
                ' (ID_CARTAO_CREDITO, ID_ORGANIZACAO, '+
                ' CARTAO, NUMERO, LIMITE, DIA_VENCIMENTO,'+
                ' DATA_VALIDADE, TITULAR, CODIGO_SEGURANCA, '+
                ' BANDEIRA, DIA_COMPRA) '+
                ' VALUES (:PID, :PIDORGANIZACAO, '+
                ' :PCARTAO, :PNUMERO, :PLIMITE, :PDIA_VENCIMENTO,'+
                ' :PDATA_VALIDADE, :PTITULAR, :PCODIGO_SEGURANCA, '+
                ' :PBANDEIRA, :PDIA_COMPRA) ' ;

      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add(cmdSql);
      qry.ParamByName('PID').AsString             := value.FID;
      qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;

      qry.ParamByName('PCARTAO').AsString         := value.FCartao;
      qry.ParamByName('PNUMERO').AsString         := value.FNumero;
      qry.ParamByName('PLIMITE').AsCurrency       := value.FLimite;
      qry.ParamByName('PDIA_VENCIMENTO').AsString := value.FDiaVencimento;

      qry.ParamByName('PDATA_VALIDADE').AsDateTime  := value.FDataValidade;
      qry.ParamByName('PTITULAR').AsString          := UpperCase(value.FTitular);
      qry.ParamByName('PCODIGO_SEGURANCA').AsString := value.FCodigoSeguranca;

      qry.ParamByName('PBANDEIRA').AsString         := value.FBandeira;
      qry.ParamByName('PDIA_COMPRA').AsString       := value.FDiaCompra;



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

class function TCartaoCreditoDAO.obterPorID( value: TCartaoCreditoModel): TCartaoCreditoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TCartaoCreditoModel;
begin

dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := TCartaoCreditoModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM CARTAO_CREDITO  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CARTAO_CREDITO = :PID '  );

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

class function TCartaoCreditoDAO.Update(value: TCartaoCreditoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try

   cmdSql := ' UPDATE CARTAO_CREDITO '+
             ' SET CARTAO = :PCARTAO,'+
             '     NUMERO = :PNUMERO,'+
             '     LIMITE = :PLIMITE'+
             '     DIA_VENCIMENTO = :PDIA_VENCIMENTO,'+
             '     DATA_VALIDADE = :PDATA_VALIDADE,'+
             '     TITULAR = :PTITULAR,'+
             '     CODIGO_SEGURANCA = :PCODIGO_SEGURANCA,'+
             '     BANDEIRA = :PBANDEIRA,'+
             '     DIA_COMPRA = :PDIA_COMPRA '+
             ' WHERE (ID_CARTAO_CREDITO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';


      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add(cmdSql);
      qry.ParamByName('PID').AsString             := value.FID;
      qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;

      qry.ParamByName('PCARTAO').AsString         := value.FCartao;
      qry.ParamByName('PNUMERO').AsString         := value.FNumero;
      qry.ParamByName('PLIMITE').AsCurrency       := value.FLimite;
      qry.ParamByName('PDIA_VENCIMENTO').AsString := value.FDiaVencimento;

      qry.ParamByName('PDATA_VALIDADE').AsDateTime  := value.FDataValidade;
      qry.ParamByName('PTITULAR').AsString          := UpperCase(value.FTitular);
      qry.ParamByName('PCODIGO_SEGURANCA').AsString := value.FCodigoSeguranca;

      qry.ParamByName('PBANDEIRA').AsString         := value.FBandeira;
      qry.ParamByName('PDIA_COMPRA').AsString       := value.FDiaCompra;

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
