unit uSacadoDAO;


interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, uSacadoModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uContaContabilModel,uContaContabilDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,  udmConexao, uUtil, uCartaoCreditoModel, uCartaoCreditoDAO,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, dxBar,   uTipoSacadoModel, uTipoSacadoDAO;


  const
   pTable : string = 'SACADO';
   pCampoPesquisa : string = 'NOME';
   pCampoID : string = 'ID_SACADO';



type
 TSacadoDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;
    class function getModel (query :TFDQuery) : TSacadoModel;
     class function obterCodigo: string;


  public
    {métodos CRUD (Create, Read, Update e Delete)
    para manipulação dos dados}
    class function combo(var comboDX: TdxBarCombo; var listaID: TStringList): Boolean; static;
    class function Insert(value :TSacadoModel): Boolean;
    class function obterPorID(value :TSacadoModel): TSacadoModel;
    class function Update(value :TSacadoModel): Boolean;
    class function Delete(value :TSacadoModel): Boolean;

  end;

implementation

class function TSacadoDAO.obterCodigo: string;
var
qryPesquisa :TFDQuery;
cod, sqlEnd :string;
sucesso : Boolean ;
begin
dmConexao.conectarBanco;
 qryPesquisa := TFDQuery.Create(nil);
   sqlEnd := ' SELECT  MAX ( CAST( C.CODIGO AS INTEGER) +1 ) AS CODIGO  FROM SACADO C WHERE 1=1 ';
 try
 try

     qryPesquisa.Close;
     qryPesquisa.Connection := dmConexao.conn;
     qryPesquisa.SQL.Clear;
     qryPesquisa.SQL.Add(sqlEnd);
     qryPesquisa.Open;


      if uUtil.Empty(qryPesquisa.FieldByName('CODIGO').AsString) then begin

       cod := '2000';

     end else begin cod := qryPesquisa.FieldByName('CODIGO').AsString; end;



 except

  raise Exception.Create('Erro ao obter código ');

 end;

 Result := cod;


 finally
   if Assigned(qryPesquisa) then begin
     FreeAndNil(qryPesquisa);
   end;

 end;

end;


class function TSacadoDAO.Delete(value: TSacadoModel): Boolean;
var
qryDelete : TFDQuery;
 sucesso : Boolean ;
begin

  sucesso := False;
  dmConexao.conectarBanco;
  qryDelete := TFDQuery.Create(nil);

  try
    try

      qryDelete.Close;
      qryDelete.Connection := dmConexao.conn;
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add('DELETE FROM SACADO  ');
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_SACADO = :PID ');
      qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qryDelete.ParamByName('PID').AsString := value.FID;
      qryDelete.ExecSQL;

      if qryDelete.RowsAffected > 0 then
      begin
        sucesso := True;
      end;

      Result := sucesso;
    except
      Result := False;
      raise Exception.Create('Erro ao tentar DELETAR ' + pTable);
    end;

  finally
    if Assigned(qryDelete) then
    begin
      FreeAndNil(qryDelete);
    end;

  end;

end;

class function TSacadoDAO.getModel(query: TFDQuery): TSacadoModel;
var model   :TSacadoModel;
 contaCtb   : TContaContabilModel;
 tipoSacado : TTipoSacadoModel;
begin
  model       := TSacadoModel.Create;
  contaCtb    := TContaContabilModel.Create;
  tipoSacado  := TTipoSacadoModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID                     := query.FieldByName('ID_SACADO').AsString;
      model.FIDorganizacao          := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FIDtipoSacado           := query.FieldByName('ID_TIPO_SACADO').AsString;
      model.FIDendereco             := query.FieldByName('ID_ENDERECO').AsString;
      model.FIdContaContabil        := query.FieldByName('ID_CONTA_CONTABIL').AsString;
      model.FIDcontato              := query.FieldByName('ID_CONTATO').AsString;
      model.FIDbanco                := query.FieldByName('ID_BANCO').AsString;
      model.FagenciaBancaria        := query.FieldByName('AGENCIA').AsString;
      model.FcontaBancaria          := query.FieldByName('CONTA_BANCARIA').AsString;
      model.FCodigo                 := query.FieldByName('CODIGO').AsString;
      model.Fpersonalidade          := query.FieldByName('PERSONALIDADE').AsString;
      model.FStatus                 := query.FieldByName('STATUS').AsString;
      model.FcpfCnpj                := query.FieldByName('CPFCNPJ').AsString;
      model.Fnome                   := query.FieldByName('NOME').AsString;
      model.FinscricaoEstadual      := query.FieldByName('INSCRICAO_ESTADUAL').AsString;
      model.FDataUltimaAtualizacao  := query.FieldByName('DATA_ULTIMA_ATUALIZACAO').AsDateTime;
      model.FDataRegistro           := query.FieldByName('DATA_REGISTRO').AsDateTime;
      model.Fnovo                   :=False;

          try

            contaCtb.FID            := model.FIDcontaContabil;
            contaCtb.FIDorganizacao := model.FIDorganizacao;
            model.FcontaContabil    := TContaContabilDAO.obterPorID(contaCtb);

            tipoSacado.FID         := model.FIDtipoSacado;
            tipoSacado.FIDOrganizacao := model.FIDorganizacao;
            model.FtipoSacado := TTipoSacadoDAO.obterPorID(tipoSacado);


          except
            raise Exception.Create('Erro ao tentar obter Conta Contabil por ' + pTable);

          end;

    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;

   Result := model;

end;

class function TSacadoDAO.Insert(value: TSacadoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
  sucesso : Boolean ;
begin
   sucesso := False;
  dmConexao.conectarBanco;
  try

     cmdSql := ' INSERT  INTO SACADO (ID_SACADO, ID_ORGANIZACAO, ID_BANCO, ' +
                    ' ID_TIPO_SACADO, ID_ENDERECO, ID_CONTATO, ID_CONTA_CONTABIL, '+
                    ' NOME, CPFCNPJ, PERSONALIDADE, AGENCIA, CONTA_BANCARIA,CODIGO, STATUS, '+
                    ' INSCRICAO_ESTADUAL, DATA_REGISTRO, DATA_ULTIMA_ATUALIZACAO ) '+
                    ' VALUES (:PID, :PIDORGANIZACAO, :PIDBANCO, '+
                    '         :PIDTIPO, :PIDENDERECO, :PIDCONTATO, :PIDCONTACTB, '+
                    '         :PNOME, :PCNPJ, :PPERSONALIDADE, :PAGENCIA, :PCONTA, :PCODIGO, :PSTATUS, '+
                    '         :PINSCEST, :PDATAREGISTRO, :PDATA ) ' ;


          qry := TFDQuery.Create(nil);
          qry.Close;
          qry.Connection := dmConexao.conn;
          qry.SQL.Clear;
          qry.SQL.Add(cmdSql);

          qry.ParamByName('PID').AsString               := value.FID;
          qry.ParamByName('PIDORGANIZACAO').AsString    := value.FIDorganizacao;

          qry.ParamByName('PIDBANCO').AsString          := value.FIDbanco;
          qry.ParamByName('PIDTIPO').AsString           := value.FIDtipoSacado;
          qry.ParamByName('PIDENDERECO').AsString       := value.FIDendereco;
          qry.ParamByName('PIDCONTATO').AsString        := value.FIDcontato;
          qry.ParamByName('PIDCONTACTB').AsString       := value.FIDcontaContabil;

          qry.ParamByName('PNOME').AsString             := UpperCase(value.Fnome);
          qry.ParamByName('PCNPJ').AsString             := value.FcpfCnpj;
          qry.ParamByName('PPERSONALIDADE').AsString    := value.Fpersonalidade;
          qry.ParamByName('PAGENCIA').AsString          := value.FagenciaBancaria;
          qry.ParamByName('PCONTA').AsString            := value.FcontaBancaria;
          qry.ParamByName('PCODIGO').AsString           := value.FCodigo;
          qry.ParamByName('PSTATUS').AsString           := value.FStatus;
          qry.ParamByName('PINSCEST').AsString          := value.FinscricaoEstadual;
          qry.ParamByName('PDATAREGISTRO').AsDate       := Now;
          qry.ParamByName('PDATA').AsDate               := Now;



          if value.FIDbanco = EmptyStr then
          begin
            qry.ParamByName('PIDBANCO').Value := null;
          end;
          if value.FIDendereco = EmptyStr then
          begin
            qry.ParamByName('PIDENDERECO').Value := null;
          end;
          if value.FIDcontato = EmptyStr then
          begin
            qry.ParamByName('PIDCONTATO').Value := null;
          end;
          if value.FIDcontaContabil = EmptyStr then
          begin
            qry.ParamByName('PIDCONTACTB').Value := null;
          end;

          if value.FCodigo = EmptyStr then
          begin
            qry.ParamByName('PCODIGO').AsString := obterCodigo;
          end;


    qry.ExecSQL;

     if qry.RowsAffected > 0 then
    begin
      sucesso := True;
    end;

  except
    Result := sucesso;
    raise Exception.Create('Erro ao tentar inserir ' + pTable);
  end;

  Result := System.True;
end;

class function TSacadoDAO.obterPorID( value: TSacadoModel): TSacadoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TSacadoModel;
begin

dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := TSacadoModel.Create;
try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM SACADO  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND ID_SACADO = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIdOrganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
  model := getModel(qryPesquisa);  end;



except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;

 Result := model;
end;

class function TSacadoDAO.Update(value: TSacadoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
sucesso : Boolean ;
begin
sucesso := False;

  dmConexao.conectarBanco;
  try

     cmdSql :=     ' UPDATE SACADO '  +
                          ' SET ID_TIPO_SACADO =     :PIDTIPO, '+
                          '     ID_ENDERECO =         :PIDENDERECO,'+
                          '     ID_CONTATO =          :PIDCONTATO,'+
                          '     NOME =                :PNOME,'+
                          '     CPFCNPJ =             :PCNPJ,'+
                          '     PERSONALIDADE =       :PPERSONALIDADE,'+
                          '     CONTA_BANCARIA =      :PCONTA, '+
                          '     AGENCIA =             :PAGENCIA,'+
                          '     ID_BANCO =            :PIDBANCO,'+
                          '     INSCRICAO_ESTADUAL  = :PINSCEST,'+
                          '     ID_CONTA_CONTABIL   = :PIDCONTACTB,'+
                          '     STATUS              = :PSTATUS, '+
                          '     DATA_ULTIMA_ATUALIZACAO = :PDATA,'+
                          '     CODIGO              = :PCODIGO '+
                          '     WHERE (ID_SACADO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';


          qry := TFDQuery.Create(nil);
          qry.Close;
          qry.Connection := dmConexao.conn;
          qry.SQL.Clear;
          qry.SQL.Add(cmdSql);


          qry.ParamByName('PID').AsString               := value.FID;
          qry.ParamByName('PIDORGANIZACAO').AsString    := value.FIDorganizacao;
          qry.ParamByName('PIDBANCO').AsString          := value.FIDbanco;
          qry.ParamByName('PIDTIPO').AsString           := value.FIDtipoSacado;
          qry.ParamByName('PIDENDERECO').AsString       := value.FIDendereco;
          qry.ParamByName('PIDCONTATO').AsString        := value.FIDcontato;
          qry.ParamByName('PIDCONTACTB').AsString       := value.FIDcontaContabil;
          qry.ParamByName('PNOME').AsString             := UpperCase(value.Fnome);
          qry.ParamByName('PCNPJ').AsString             := value.FcpfCnpj;
          qry.ParamByName('PPERSONALIDADE').AsString    := value.Fpersonalidade;
          qry.ParamByName('PAGENCIA').AsString          := value.FagenciaBancaria;
          qry.ParamByName('PCONTA').AsString            := value.FcontaBancaria;
          qry.ParamByName('PCODIGO').AsString           := value.FCodigo;
          qry.ParamByName('PSTATUS').AsString           := value.FStatus;
          qry.ParamByName('PINSCEST').AsString          := value.FinscricaoEstadual;
          qry.ParamByName('PDATA').AsDate               := Now;

          if value.FIDbanco = EmptyStr then
          begin
            qry.ParamByName('PIDBANCO').Value := null;
          end;
          if value.FIDendereco = EmptyStr then
          begin
            qry.ParamByName('PIDENDERECO').Value := null;
          end;
          if value.FIDcontato = EmptyStr then
          begin
            qry.ParamByName('PIDCONTATO').Value := null;
          end;
          if value.FIDcontaContabil = EmptyStr then
          begin
            qry.ParamByName('PIDCONTACTB').Value := null;
          end;

          if value.FCodigo = EmptyStr then
          begin
            qry.ParamByName('PCODIGO').AsString := obterCodigo;
          end;

          if value.FCodigo = '2000' then
          begin
            qry.ParamByName('PCODIGO').AsString := obterCodigo;
          end;

    qry.ExecSQL;

    if qry.RowsAffected > 0 then
    begin
      sucesso := True;
    end;

  except
    Result := sucesso;
    raise Exception.Create('Erro ao tentar alterar ' + pTable);
  end;

  Result := sucesso
end;


class function TSacadoDAO.combo(var comboDX: TdxBarCombo; var listaID: TStringList):Boolean;
var
qry :TFDQuery;

cmdSql :string;
begin
   cmdSql := 'SELECT  C.'+ pCampoPesquisa + ' , C.'+ pCampoID + ' FROM  '+pTable + ' C WHERE C.ID_ORGANIZACAO = :PIDORGANIZACAO ';
  qry := TFDQuery.Create(nil);
  qry.Close;
  qry.Connection := dmConexao.conn;
  qry.SQL.Clear;
 // qry.SQL.Add('SELECT C.ID_CENTRO_CUSTO, C.DESCRICAO FROM CENTRO_CUSTO C WHERE C.ID_ORGANIZACAO = :PIDORGANIZACAO  ORDER BY C.DESCRICAO ');
  qry.SQL.Add(cmdSql);
  qry.ParamByName('PIDORGANIZACAO').AsString := UUTIL.TOrgAtual.getId;
  qry.Open;
  qry.First;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  comboDX.Items.Clear;
  comboDX.Items.Add('<<< Selecione  >>>');

  while not qry.Eof do
  begin
      // combo.Items.Add(qry.FieldByName('DESCRICAO').AsString);
   // listaID.Add(qry.FieldByName('ID_CENTRO_CUSTO').AsString);
   //   combo.Items.Add(uUtil.TFormat.retiraAcento(qryObterTodos.FieldByName('NOME').AsString));
      comboDX.Items.Add(uUtil.TFormat.retiraAcento(qry.FieldByName(pCampoPesquisa).AsString));
      listaID.Add(qry.FieldByName(pCampoID).AsString);

    qry.Next;
  end;

  qry.Close;
  comboDX.ItemIndex := 0;

  Result := not qry.IsEmpty;

end;


end.
