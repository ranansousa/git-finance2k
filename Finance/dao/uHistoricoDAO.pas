unit uHistoricoDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uContaContabilModel,uContaContabilDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uHistoricoModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, dxBar;


  const
   pTable : string = 'HISTORICO';



type
 THistoricoDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;

    class function getModel (query :TFDQuery) : THistoricoModel;
  public
    {métodos CRUD (Create, Read, Update e Delete)
    para manipulação dos dados}
   class function Insert(value :THistoricoModel): Boolean;
    class function obterPorID(value :THistoricoModel): THistoricoModel;
    class function Update(value :THistoricoModel): Boolean;
    class function Delete(value :THistoricoModel): Boolean;
    class function comboDxBar(value: THistoricoModel; var combo: TdxBarCombo;  var listaID: TStringList): Boolean;
    class function obterListaHistoricos(value :string) : TFDQuery;


  end;

implementation





class function THistoricoDAO.comboDxBar(value: THistoricoModel; var combo: TdxBarCombo; var listaID: TStringList): Boolean;
var
qryObterPorTipo :TFDQuery;
sqlCmd : string;
begin
 dmConexao.conectarBanco;
 qryObterPorTipo := TFDQuery.Create(nil);
  try
    try
   {
   sqlCmd :=  ' SELECT H.ID_HISTORICO, H.ID_ORGANIZACAO,  H.DESCRICAO AS DESCRICAO_HISTORICO, H.TIPO, '+
              ' H.CODIGO, H.DESCRICAO_REDUZIDA, CC.CONTA, CC.DESCRICAO AS DESCRICAO_CONTA, CC.CODREDUZ AS CODIGO_REDUZ '+
              ' FROM HISTORICO H '+
              ' LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO) '+
              ' WHERE (H.ID_ORGANIZACAO = :PIDORGANIZACAO)   AND ((H.TIPO = :PTIPO) OR (H.TIPO = ''G'')) ORDER BY H.DESCRICAO ';
       }


      sqlCmd := ' SELECT H.ID_HISTORICO,  H.DESCRICAO  ' + ' FROM HISTORICO H ' +
                ' WHERE (H.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
                ' AND ((H.TIPO = :PTIPO) OR (H.TIPO = ''G'') OR (H.TIPO = ''N'') ) '+
                ' ORDER BY H.DESCRICAO ';


   qryObterPorTipo.Close;
   qryObterPorTipo.Connection := dmConexao.conn;
   qryObterPorTipo.SQL.Clear;
   qryObterPorTipo.sql.Add(sqlCmd);


   qryObterPorTipo.ParamByName('PIDORGANIZACAO').AsString := value.FIdOrganizacao;
   qryObterPorTipo.ParamByName('PTIPO').AsString := value.FTipo  ;
   qryObterPorTipo.Open;
   qryObterPorTipo.Last;

   listaID := TStringList.Create;
   listaID.Clear;
   listaID.Add('Sem ID');
   combo.Items.Clear;
   combo.Items.Add('<<< Selecione  >>>');


   if not qryObterPorTipo.IsEmpty then begin
          qryObterPorTipo.First;

      while not qryObterPorTipo.Eof do
        begin
          combo.Items.Add(qryObterPorTipo.FieldByName('DESCRICAO').AsString);
          listaID.Add(qryObterPorTipo.FieldByName('ID_HISTORICO').AsString);
          qryObterPorTipo.Next;
        end;
      qryObterPorTipo.Close;
      combo.ItemIndex := 0;

   end;


 except

 raise Exception.Create('Erro ao obter históricos por tipo');

 end;
 finally

  FreeAndNil(qryObterPorTipo);

 end;


end;

class function THistoricoDAO.Delete(value: THistoricoModel): Boolean;
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
  qryDelete.SQL.Add('DELETE FROM HISTORICO  '  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_HISTORICO = :PID '  );
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

class function THistoricoDAO.getModel(query: TFDQuery): THistoricoModel;
var model :THistoricoModel;
 contaCtb : TContaContabilModel;
begin
  model := THistoricoModel.Create;
  contaCtb := TContaContabilModel.Create;

  if not query.IsEmpty then begin

    try


      model.FID                   := query.FieldByName('ID_HISTORICO').AsString;
      model.FIDorganizacao        := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FDescricao            := query.FieldByName('DESCRICAO').AsString;
      model.FTipo                 := query.FieldByName('TIPO').AsString;
      model.FIdContaContabil      := query.FieldByName('ID_CONTA_CONTABIL').AsString;
      model.FdescricaoReduzida    := query.FieldByName('DESCRICAO_REDUZIDA').AsString;
      model.FProduto              := query.FieldByName('PRODUTO').AsString;
      model.FCodigo               := query.FieldByName('CODIGO').AsInteger;


    try

      contaCtb.FID            := model.FIDcontaContabil;
      contaCtb.FIDorganizacao := model.FIDorganizacao;
      model.FcontaContabil    := TContaContabilDAO.obterPorID(contaCtb);

    except
      raise Exception.Create('Erro ao tentar obter Conta Contabil por ' + pTable);

    end;




    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function THistoricoDAO.Insert(value: THistoricoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
  sucesso :Boolean;

begin

sucesso := False;

  dmConexao.conectarBanco;
  try

     cmdSql :=  ' INSERT INTO HISTORICO '+
                ' (ID_HISTORICO, ID_ORGANIZACAO, DESCRICAO, '+
                ' TIPO, CODIGO, ID_CONTA_CONTABIL, DESCRICAO_REDUZIDA, PRODUTO )'+
                ' VALUES (:PID, :PIDORGANIZACAO, :PDESCRICAO, '+
                ' :PTIPO, :PCODIGO, :PIDCONTA_CONTABIL, :PDESC_REDUZ, :PPRODUTO) ' ;

    qry := TFDQuery.Create(nil);
    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString            := value.FDescricao;
    qry.ParamByName('PTIPO').AsString                 := value.FTipo;
    qry.ParamByName('PCODIGO').AsInteger              := value.FCodigo;
    qry.ParamByName('PIDCONTA_CONTABIL').AsString     := value.FIdContaContabil ;
    qry.ParamByName('PDESC_REDUZ').AsString           := value.FdescricaoReduzida;
    qry.ParamByName('PPRODUTO').AsString              := value.FProduto;

    if uutil.Empty(value.FIdContaContabil) then
    begin
      qry.ParamByName('PIDCONTA_CONTABIL').value := null;
    end;

    if uutil.Empty(value.FProduto) then
    begin
      qry.ParamByName('PPRODUTO').value := null;
    end;


    qry.ExecSQL;
    if qry.RowsAffected >0  then begin sucesso := True; dmConexao.conn.CommitRetaining;  end;


  except
    Result := False;
    raise Exception.Create('Erro ao tentar inserir ' + pTable);
  end;

  Result := sucesso;
end;

class function THistoricoDAO.obterListaHistoricos(value: string): TFDQuery;
var
sucesso : Boolean;
qryPesquisa : TFDQuery;
cmdSql:string;

begin
sucesso := False;
   //recebe o conjunto de Historicos
  dmConexao.conectarBanco;
  qryPesquisa := TFDQuery.Create(nil);

  try
    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add('SELECT * ');
    qryPesquisa.SQL.Add('FROM HISTORICO  ');
    qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO ');

    qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value ;
    qryPesquisa.Open;

  except

    raise(Exception).Create('Problemas ao tentar obter a lista de historicos ');

  end;

  Result := qryPesquisa;

end;



class function THistoricoDAO.obterPorID( value: THistoricoModel): THistoricoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: THistoricoModel;
begin

dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := THistoricoModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM HISTORICO  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_HISTORICO = :PID '  );

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

class function THistoricoDAO.Update(value: THistoricoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin

  dmConexao.conectarBanco;
  try

     cmdSql := ' UPDATE HISTORICO ' +
               ' SET DESCRICAO            = :PDESCRICAO,'+
               '     TIPO                 = :PTIPO, '+
               '     CODIGO               = :PCODIGO, '+
               '     ID_CONTA_CONTABIL    = :PIDCONTA_CONTABIL,'+
               '     DESCRICAO_REDUZIDA   = :PDESC_REDUZ, '+
               '     PRODUTO              = :PPRODUTO '+
               ' WHERE (ID_HISTORICO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';



    qry := TFDQuery.Create(nil);
    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString            := value.FDescricao;
    qry.ParamByName('PTIPO').AsString                 := value.FTipo;
    qry.ParamByName('PCODIGO').AsInteger              := value.FCodigo;
    qry.ParamByName('PIDCONTA_CONTABIL').AsString     := value.FIdContaContabil ;
    qry.ParamByName('PDESC_REDUZ').AsString           := value.FdescricaoReduzida;
    qry.ParamByName('PPRODUTO').AsString              := value.FProduto;
    qry.ExecSQL;

  except
    Result := False;
    raise Exception.Create('Erro ao tentar alterar ' + pTable);
  end;

  Result := System.True;
end;
end.
