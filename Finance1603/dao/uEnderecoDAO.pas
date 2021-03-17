unit uEnderecoDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uEnderecoModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,  uCidadeModel, uEstadoModel, uBairroModel,
  uCidadeDAO, uEstadoDAO, uBairroDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,Vcl.StdCtrls;

  const
   pTable : string = 'ENDERECO';

type
 TEnderecoDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;

    class function getModel (query :TFDQuery) : TEnderecoModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
   class function Insert(value :TEnderecoModel): Boolean;
    class function obterPorID(value :TEnderecoModel): TEnderecoModel;
    class function Update(value :TEnderecoModel): Boolean;
    class function Delete(value :TEnderecoModel): Boolean;

  end;

implementation

class function TEnderecoDAO.Delete(value: TEnderecoModel): Boolean;
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
      qryDelete.SQL.Add('DELETE FROM ENDERECO  ');
      qryDelete.SQL.Add('WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)  AND  (ID_ENDERECO = :PID) ');
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

class function TEnderecoDAO.getModel(query: TFDQuery): TEnderecoModel;
var model :TEnderecoModel;
cidade :TCidadeModel;
estado :TEstadoModel;
bairro :TBairroModel;


begin
cidade :=TCidadeModel.Create;
estado :=TEstadoModel.Create;
bairro :=TBairroModel.Create;

  model := TEnderecoModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID             := query.FieldByName('ID_ENDERECO').AsString;
      model.FIDorganizacao  := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FIDCIDADE       := query.FieldByName('ID_CIDADE').AsString;
      model.FIDBAIRRO       := query.FieldByName('ID_BAIRRO').AsString;
      model.FIDESTADO       := query.FieldByName('ID_ESTADO').AsString;
      model.FCEP            := query.FieldByName('CEP').AsString;
      model.FNUMERO         := query.FieldByName('NUMERO').AsString;
      model.FCOMPLEMENTO    := UpperCase(query.FieldByName('COMPLEMENTO').AsString);
      model.FLOGRADOURO     := UpperCase(query.FieldByName('LOGRADOURO').AsString);
      model.Fnovo           := False;

      cidade.FID := model.FIDCIDADE;
      bairro.FID := model.FIDBAIRRO;
      estado.FID := model.FIDESTADO;


      model.Fbairro := TBairroDAO.obterPorID(bairro);
      model.Fcidade := TCidadeDAO.obterPorID(cidade);
      model.Festado := TEstadoDAO.obterPorID(estado);



    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TEnderecoDAO.Insert(value: TEnderecoModel): Boolean;
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

     cmdSql :=  ' INSERT INTO ENDERECO (ID_ENDERECO, ID_ORGANIZACAO, ID_BAIRRO, ID_ESTADO, ID_CIDADE, '+
                ' LOGRADOURO, COMPLEMENTO,  NUMERO, CEP ) ' +
                ' VALUES (:PID,:PIDORGANIZACAO, :PID_BAIRRO, :PID_ESTADO, :PID_CIDADE, '+
                ' :PLOGRADOURO, :PCOMPLEMENTO,  :PNUMERO, :PCEP ) ';

      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add(cmdSql);
      qry.ParamByName('PID').AsString             := value.FID;
      qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
      qry.ParamByName('PID_BAIRRO').AsString      := value.FIDBAIRRO;
      qry.ParamByName('PID_ESTADO').AsString      := value.FIDESTADO;
      qry.ParamByName('PID_CIDADE').AsString      := value.FIDCIDADE;
      qry.ParamByName('PLOGRADOURO').AsString     := UpperCase(value.FLOGRADOURO);
      qry.ParamByName('PCOMPLEMENTO').AsString    := UpperCase(value.FCOMPLEMENTO);
      qry.ParamByName('PNUMERO').AsString         := value.FNUMERO ;
      qry.ParamByName('PCEP').AsString            := value.FCEP ;


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

class function TEnderecoDAO.obterPorID( value: TEnderecoModel): TEnderecoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TEnderecoModel;
begin
dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := TEnderecoModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM ENDERECO  '  );
  qryPesquisa.SQL.Add('WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)  AND  (ID_ENDERECO = :PID) '  );

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

class function TEnderecoDAO.Update(value: TEnderecoModel): Boolean;
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

     cmdSql :=  ' UPDATE ENDERECO   '+
                '  SET ID_ESTADO    = :PID_ESTADO, '+
                '      LOGRADOURO   = :PLOGRADOURO, '+
                '      COMPLEMENTO  = :PCOMPLEMENTO,  '+
                '      ID_BAIRRO    = :PID_BAIRRO, '+
                '      NUMERO       = :PNUMERO,    '+
                '      CEP          = :PCEP, '+
                '      ID_CIDADE    = :PID_CIDADE '+
                '  WHERE (ID_ENDERECO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';

      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add(cmdSql);
      qry.ParamByName('PID').AsString             := value.FID;
      qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
      qry.ParamByName('PID_BAIRRO').AsString      := value.FIDBAIRRO;
      qry.ParamByName('PID_ESTADO').AsString      := value.FIDESTADO;
      qry.ParamByName('PID_CIDADE').AsString      := value.FIDCIDADE;
      qry.ParamByName('PLOGRADOURO').AsString     := UpperCase(value.FLOGRADOURO);
      qry.ParamByName('PCOMPLEMENTO').AsString    := UpperCase(value.FCOMPLEMENTO);
      qry.ParamByName('PNUMERO').AsString         := value.FNUMERO ;
      qry.ParamByName('PCEP').AsString            := value.FCEP ;


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
