unit uFuncionarioDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uFuncionarioModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,Vcl.StdCtrls;

  const
   pTable : string = 'FUNCIONARIO';

type
 TFuncionarioDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;

    class function getModel (query :TFDQuery) : TFuncionarioModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
   class function Insert(value :TFuncionarioModel): Boolean;
    class function obterPorID(value :TFuncionarioModel): TFuncionarioModel;
    class function Update(value :TFuncionarioModel): Boolean;
    class function Delete(value :TFuncionarioModel): Boolean;
   class  function obterTodosAtivos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;

  end;

implementation

class function TFuncionarioDAO.Delete(value: TFuncionarioModel): Boolean;
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
      qryDelete.SQL.Add('DELETE FROM FUNCIONARIO  ');
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_FUNCIONARIO = :PID ');
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

class function TFuncionarioDAO.getModel(query: TFDQuery): TFuncionarioModel;
var model :TFuncionarioModel;

begin
  model := TFuncionarioModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID                   := query.FieldByName('ID_FUNCIONARIO').AsString;
      model.FIDorganizacao        := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FIDEndereco           := query.FieldByName('ID_ENDERECO').AsString;
      model.FIDContato            := query.FieldByName('ID_CONTATO').AsString;
      model.FNOME                 := UpperCase(query.FieldByName('NOME').AsString);
      model.FCPF                  := query.FieldByName('CPF').AsString;
      model.Fativo                := query.FieldByName('ATIVO').AsInteger;



    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TFuncionarioDAO.Insert(value: TFuncionarioModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try

     cmdSql :=  ' INSERT INTO FUNCIONARIO '+
                '(ID_FUNCIONARIO, ID_ORGANIZACAO, ID_ENDERECO, ID_CONTATO, NOME, CPF, ATIVO) '+
                ' VALUES (:PID, :PIDORGANIZACAO, :PID_ENDERECO, :PID_CONTATO, :PNOME, :PCPF, 1)';


    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString             := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
    qry.ParamByName('PID_ENDERECO').AsString    := value.FIDEndereco;
    qry.ParamByName('PID_CONTATO').AsString     := value.FIDContato;
    qry.ParamByName('PNOME').AsString           := UpperCase(value.FNOME) ;
    qry.ParamByName('PCPF').AsString            := value.FCPF;
    qry.ParamByName('PATIVO').AsInteger         := 1; //toda insert ser� 1 (ativo)

    if uUtil.Empty(value.FIDEndereco) then
    begin
      qry.ParamByName('PID_ENDERECO').Value := null;
     end;


    if uUtil.Empty(value.FIDContato) then
    begin
      qry.ParamByName('PID_CONTATO').Value := null;
     end;

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

class function TFuncionarioDAO.obterPorID( value: TFuncionarioModel): TFuncionarioModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TFuncionarioModel;
begin

dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := TFuncionarioModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM FUNCIONARIO  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_FUNCIONARIO = :PID '  );

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

class function TFuncionarioDAO.obterTodosAtivos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
var
qryObterTodos :TFDQuery;
 cmd :string;
begin
  cmd := ' SELECT F.ID_FUNCIONARIO, F.NOME ' +
         ' FROM   FUNCIONARIO F  ' +
         ' WHERE (F.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (F.ATIVO = 1) ' +
         ' ORDER BY F.NOME ';


  dmConexao.conectarBanco;


  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
   combo.Clear;
   combo.Items.Add('<<< RESPONS�VEL  >>>');

   qryObterTodos := TFDQuery.Create(nil);
   qryObterTodos.Close;
   qryObterTodos.Connection := dmConexao.conn;
   qryObterTodos.SQL.Clear;
   qryObterTodos.SQL.Add(cmd);

   qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   qryObterTodos.Open;

   if not qryObterTodos.IsEmpty then begin
          qryObterTodos.First;

      while not qryObterTodos.Eof do
        begin
          combo.Items.Add(qryObterTodos.FieldByName('NOME').AsString);
          listaID.Add(qryObterTodos.FieldByName('ID_FUNCIONARIO').AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      combo.ItemIndex := 0;

   end;

end;

class function TFuncionarioDAO.Update(value: TFuncionarioModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try


   cmdSql := ' UPDATE FUNCIONARIO '+
             ' SET ID_ENDERECO    = :PID_ENDERECO, '+
             '     ID_CONTATO     = :PID_CONTATO,'+
             '     NOME           = :PNOME, ' +
             '     ATIVO          = :PATIVO, ' +
             '     CPF            = :PCPF '+
             ' WHERE (ID_FUNCIONARIO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';



    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString             := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
    qry.ParamByName('PID_ENDERECO').AsString    := value.FIDEndereco;
    qry.ParamByName('PID_CONTATO').AsString     := value.FIDContato;
    qry.ParamByName('PNOME').AsString           := UpperCase(value.FNOME) ;
    qry.ParamByName('PCPF').AsString            := value.FCPF;
    qry.ParamByName('PATIVO').AsInteger         := value.Fativo;


    if uUtil.Empty(value.FIDEndereco) then
    begin
      qry.ParamByName('PID_ENDERECO').Value := null;
     end;

    if uUtil.Empty(value.FIDContato) then
    begin
      qry.ParamByName('PID_CONTATO').Value := null;
     end;



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
