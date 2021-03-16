unit uContaBancariaTRFDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, MDDAO, MDModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uOrganizacaoModel,
  uContaBancariaDBModel,uTipoOperacaoBancariaModel,uFuncionarioModel,uContaBancariaChequeModel,uLoteContabilModel,uUsuarioModel,
  uTipoOperacaoBancariaDAO,uFuncionarioDAO,uContaBancariaChequeDAO,uLoteContabilDAO,uUsuarioDAO,
  uContaBancariaCRModel, uContaBancariaDebitoDAO,uContaBancariaCreditoDAO, uContaBancariaTRFModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uContaBancariaModel,uContaBancariaDAO, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
    Vcl.StdCtrls;


  const
   pTable : string = 'CONTA_BANCARIA_TRANSFERENCIA';

type
 TContaBancariaTRFDAO = class
  private
  class function getModel (query :TFDQuery) : TContaBancariaTRFModel;

  public

    class function Insert(value :TContaBancariaTRFModel): Boolean;
    class function obterPorID(value :TContaBancariaTRFModel): TContaBancariaTRFModel;
    class function Delete(value: TContaBancariaTRFModel): Boolean;
    class function Update(value: TContaBancariaTRFModel): Boolean;
    class function obterTodos(value: TContaBancariaTRFModel; pDataInicial, pDataFinal :TDateTime) : TFDQuery; overload;
    class function obterTodos(value: string; pDataInicial, pDataFinal :TDateTime; var combo: TComboBox; var listaID: TStringList): boolean; overload;

    class function transfereEntreContas (value : TContaBancariaTRFModel) :Boolean;
    class function estornarTransfEntreContas(value : TContaBancariaTRFModel) :Boolean;
    class function obterValorDebitoPeriodo(pIDOrganizacao, pTOB : string; pDataInicio, pDataFim :TDateTime) : Currency;
    class function obterDadosExportacao(tipoSaida :Integer; pIDOrganizacao :string; pDataInicio, pDataFim :TDateTime; var query :TFDQuery): TFDQuery;
  end;

implementation

{ TContaBancariaDebitoDAO }

class function TContaBancariaTRFDAO.Delete(value :TContaBancariaTRFModel): Boolean;
var
qryDelete : TFDQuery;
sucesso  :Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
  qryDelete := TFDQuery.Create(nil);

  try
    try

      qryDelete.Close;
      qryDelete.Connection := dmConexao.conn;
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add('DELETE FROM CONTA_BANCARIA_TRANSFERENCIA  ');
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTA_BANCARIA_TRANSFERENCIA = :PID ');
      qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qryDelete.ParamByName('PID').AsString := value.FID;

      qryDelete.ExecSQL;

      if qryDelete.RowsAffected > 0 then
      begin
        sucesso := True;
      end;
    except
      sucesso := False;
      raise Exception.Create('Erro ao tentar DELETAR CBT');
    end;
    Result := sucesso;
  finally
    FreeAndNil(qryDelete);
  end;
end;


class function TContaBancariaTRFDAO.estornarTransfEntreContas(value: TContaBancariaTRFModel): Boolean;
var
 sucesso : Boolean;
begin
sucesso := False;

  if not dmConexao.conn.InTransaction then
    dmConexao.conn.StartTransaction;

    try

      if not uutil.Empty(value.FcontaBancariaDB.FID) then begin
       sucesso := TContaBancariaDebitoDAO.Delete(value.FcontaBancariaDB);
      end;

      if not uutil.Empty(value.FcontaBancariaCR.FID) then begin
       sucesso := TContaBancariaCreditoDAO.Delete(value.FcontaBancariaCR);
      end;

      if sucesso then begin

        Delete(value);

      end;


      if dmConexao.conn.InTransaction then
        dmConexao.conn.CommitRetaining;
    except
      if dmConexao.conn.InTransaction then
        dmConexao.conn.RollbackRetaining;

    end;

    Result := sucesso;

end;
class function TContaBancariaTRFDAO.getModel(  query: TFDQuery): TContaBancariaTRFModel;
var
 transf : TContaBancariaTRFModel;
 contaDB : TContaBancariaDBModel;
 contaCR : TContaBancariaCRModel;

begin
      transf  := TContaBancariaTRFModel.Create;
      contaDB := TContaBancariaDBModel.Create;
      contaCR := TContaBancariaCRModel.Create;
 try
  try
    if not query.IsEmpty then
    begin

      transf.FID                  := query.FieldByName('ID_CONTA_BANCARIA_TRANSFERENCIA').AsString;
      transf.FIDorganizacao       := query.FieldByName('ID_ORGANIZACAO').AsString;
      transf.FIDusuario           := query.FieldByName('ID_USUARIO').AsInteger;
      transf.FIDResponsavel       := query.FieldByName('ID_RESPONSAVEL').AsString;
      transf.FIDTOB               := query.FieldByName('ID_TIPO_OPERACAO_BANCARIA').AsString;
      transf.FIDcontaBancariaCR   := query.FieldByName('ID_CONTA_BANCARIA_CREDITO').AsString;
      transf.FIDcontaBancariaDB   := query.FieldByName('ID_CONTA_BANCARIA_DEBITO').AsString;
      transf.FIDloteContabil      := query.FieldByName('ID_LOTE_CONTABIL').AsString;
      transf.Fidentificacao       := query.FieldByName('IDENTIFICACAO').AsString;
      transf.Fobservacao          := query.FieldByName('OBSERVACAO').AsString;
      transf.Fvalor               := query.FieldByName('VALOR').AsCurrency;
      transf.FdataRegistro        := query.FieldByName('DATA_REGISTRO').AsDateTime;
      transf.FdataMovimento       := query.FieldByName('DATA_MOVIMENTO').AsDateTime;
      transf.Fnovo                := False;

      contaDB.FID             := transf.FIDcontaBancariaDB;
      contaDB.FIDorganizacao  := transf.FIDorganizacao;
      transf.FcontaBancariaDB := TContaBancariaDebitoDAO.obterPorID(contaDB);

      contaCR.FID             := transf.FIDcontaBancariaCR;
      contaCR.FIDorganizacao  := transf.FIDorganizacao;
      transf.FcontaBancariaCR := TContaBancariaCreditoDAO.obterPorID(contaCR);
      end;
    except
      raise Exception.Create('Erro ao converter CBT');
    end;
    Result := transf;

  finally
    FreeAndNil(query);
  end;

end;

class function TContaBancariaTRFDAO.Insert(value: TContaBancariaTRFModel): Boolean;
var
cmdSql:string;
qryInsert : TFDQuery;
sucesso :Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
  qryInsert := TFDQuery.Create(nil);

  try
      cmdSql := ' INSERT INTO CONTA_BANCARIA_TRANSFERENCIA ' +
                ' (ID_CONTA_BANCARIA_TRANSFERENCIA, ID_ORGANIZACAO, '+
                ' ID_CONTA_BANCARIA_CREDITO, ID_CONTA_BANCARIA_DEBITO, '+
                ' ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, OBSERVACAO,'+
                ' VALOR, DATA_REGISTRO, DATA_MOVIMENTO, IDENTIFICACAO, '+
                ' ID_USUARIO, ID_LOTE_CONTABIL ) '+
                ' VALUES (:PID, :PIDORGANIZACAO, '+
                ' :PID_CONTA_BANCARIA_CREDITO, :PID_CONTA_BANCARIA_DEBITO, '+
                ' :PIDTOB, :PIDRESP, :POBSERVACAO, '+
                ' :PVALOR, :PDTREGISTRO, :PDTMOVIMENTO, :PIDENTIFICACAO, '+
                ' :PIDUSUARIO, :PIDLOTECONTABIL )';


      qryInsert.Close;
      qryInsert.Connection := dmConexao.conn;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add(cmdSql);
      qryInsert.ParamByName('PID').AsString                         := value.FID;
      qryInsert.ParamByName('PIDORGANIZACAO').AsString              := value.FIDorganizacao;
      qryInsert.ParamByName('PID_CONTA_BANCARIA_CREDITO').AsString  := value.FIDcontaBancariaCR;
      qryInsert.ParamByName('PID_CONTA_BANCARIA_DEBITO').AsString   := value.FIDcontaBancariaDB;
      qryInsert.ParamByName('PIDTOB').AsString                      := value.FIDTOB;
      qryInsert.ParamByName('PIDRESP').AsString                     := value.FIDResponsavel;
      qryInsert.ParamByName('POBSERVACAO').AsString                 := value.Fobservacao;
      qryInsert.ParamByName('PIDLOTECONTABIL').AsString             := value.FIDloteContabil;
      qryInsert.ParamByName('PIDUSUARIO').AsInteger                 := value.FIDusuario;
      qryInsert.ParamByName('PIDENTIFICACAO').AsString              := value.Fidentificacao;
      qryInsert.ParamByName('PDTREGISTRO').AsDateTime               := value.FdataRegistro;
      qryInsert.ParamByName('PDTMOVIMENTO').AsDateTime              := value.FdataMovimento;
      qryInsert.ParamByName('PVALOR').AsCurrency                    := value.Fvalor;

    if uUtil.Empty(value.FIDloteContabil) then
    begin
      qryInsert.ParamByName('PIDLOTECONTABIL').Value := null;
    end;

    if (value.FIDusuario = 0) then
    begin
      qryInsert.ParamByName('PIDUSUARIO').AsString := IntToStr(uutil.TUserAtual.getUserId);
    end;

     qryInsert.ExecSQL;
     if qryInsert.RowsAffected >0 then begin sucesso := True;
      end;


    Result := sucesso;

  finally
    if Assigned(qryInsert) then
    begin
      FreeAndNil(qryInsert);
    end;
  end;
end;

class function TContaBancariaTRFDAO.obterDadosExportacao(tipoSaida :Integer; pIDOrganizacao: string;
  pDataInicio, pDataFim: TDateTime; var query :TFDQuery): TFDQuery;
 var
 sqlCmd : string;

 begin
 //if tipoSaida = 1 vai para tela ou relatorio e 2 vai para exportacao
  dmConexao.conectarBanco;

  sqlCmd := 'SELECT  CBT.ID_CONTA_BANCARIA_TRANSFERENCIA, '+
            '  CBT.ID_CONTA_BANCARIA_CREDITO,'+
            '  CBT.ID_CONTA_BANCARIA_DEBITO,   '+
            '  CBT.ID_TIPO_OPERACAO_BANCARIA,    '+
            '  CBT.VALOR, CBT.DATA_MOVIMENTO,'+
            '  CBT.ID_ORGANIZACAO,             '+
            '  CBT.IDENTIFICACAO,                '+
            '  TOB.descricao AS TIPO_OPERACAO,     '+
            '  TOB.codigo AS TOB_CODIGO,             '+
            '  TOB.id_conta_contabil,                  '+
            ' ''CBT'' AS TIPO '+
            ' FROM CONTA_BANCARIA_TRANSFERENCIA CBT '+
            ' LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERACAO_BANCARIA = CBT.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGANIZACAO = CBT.ID_ORGANIZACAO) '+
            ' WHERE (CBT.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
            ' AND   (CBT.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) '+
            ' AND   (CBT.ID_LOTE_CONTABIL IS NULL) ';

  if tipoSaida = 2 then begin

 sqlCmd := ' SELECT CBT.DATA_MOVIMENTO AS DATA, '+
           ' CBT.VALOR AS VALOR, '+
           ' CBT.ID_TIPO_OPERACAO_BANCARIA AS IDOPER, '+
           ' CBT.ID_CONTA_BANCARIA_TRANSFERENCIA AS ID, '+
           ' CBT.ID_ORGANIZACAO AS IDORG, '+
           ' CBT.IDENTIFICACAO AS IDENTIFCRE, '+
           ' CBT.IDENTIFICACAO AS IDENTIFDEB, '+
           ' CBT.ID_CONTA_BANCARIA_CREDITO AS IDCRE, '+
           ' CBT.ID_CONTA_BANCARIA_DEBITO AS IDDEB, '+
           ' CCCBD.CONTA AS CONTA_DEB, '+
           ' CCCBD.DGVER AS DGDEB, '+
           ' CCCBD.CODREDUZ AS CDREDUZDEB, '+
           ' CCCBD.DGREDUZ AS DGREDUZDEB, '+
           ' CCCBD.DESCRICAO AS DESCTADEBITO, '+
           ' CCCBC.CONTA AS CONTA_CRE, '+
           ' CCCBC.DGVER AS DGCRE, '+
           ' CCCBC.CODREDUZ AS CDREDUZCRE, '+
           ' CCCBC.DGREDUZ AS DGREDUZCRE, '+
           ' CCCBC.DESCRICAO AS DESCTACREDITO, '+
           ' TOPB.TIPO AS TIPOOPERACAO, '+
           ' TOPB.TIPO AS COMPL, '+
           ' TOPB.CODIGO AS CDHIST, '+
           ' TOPB.DESCRICAO AS HISTORICO, '+
           ' BANCOD.CONTA AS CTAORIGEM, '+
           ' BANCOC.CONTA AS CTADESTINO '+

            ' FROM CONTA_BANCARIA_TRANSFERENCIA CBT '+

            ' LEFT OUTER JOIN CONTA_BANCARIA_CREDITO CBC ON (CBC.ID_CONTA_BANCARIA_CREDITO = CBT.ID_CONTA_BANCARIA_CREDITO) AND (CBC.ID_ORGANIZACAO=CBT.ID_ORGANIZACAO) '+
            ' LEFT OUTER JOIN  CONTA_BANCARIA BANCOC ON (BANCOC.ID_CONTA_BANCARIA = CBC.ID_CONTA_BANCARIA) AND (BANCOC.ID_ORGANIZACAO=CBT.ID_ORGANIZACAO)               '+
            ' LEFT OUTER JOIN  CONTA_BANCARIA_DEBITO CBD ON (CBD.ID_CONTA_BANCARIA_DEBITO = CBT.ID_CONTA_BANCARIA_DEBITO) AND (CBD.ID_ORGANIZACAO=CBT.ID_ORGANIZACAO)   '+
            ' LEFT OUTER JOIN  CONTA_BANCARIA BANCOD ON (BANCOD.ID_CONTA_BANCARIA = CBD.ID_CONTA_BANCARIA) AND (BANCOD.ID_ORGANIZACAO=CBT.ID_ORGANIZACAO)               '+
            ' LEFT OUTER JOIN  CONTA_CONTABIL CCCBC ON(CCCBC.ID_CONTA_CONTABIL =BANCOD.ID_CONTA_CONTABIL) AND (CCCBC.ID_ORGANIZACAO=CBT.ID_ORGANIZACAO)                 '+
            ' LEFT OUTER JOIN  CONTA_CONTABIL CCCBD ON(CCCBD.ID_CONTA_CONTABIL =BANCOC.ID_CONTA_CONTABIL) AND (CCCBD.ID_ORGANIZACAO=CBT.ID_ORGANIZACAO)                 '+
            ' LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOPB ON (TOPB.ID_TIPO_OPERACAO_BANCARIA=CBT.ID_TIPO_OPERACAO_BANCARIA AND TOPB.ID_ORGANIZACAO=CBT.ID_ORGANIZACAO)  '+

            ' WHERE (CBT.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL)  '+
            ' AND   (CBT.ID_ORGANIZACAO= :PIDORGANIZACAO)  '+
            ' AND   (CBT.ID_LOTE_CONTABIL IS NULL) '+
            ' ORDER BY CBT.DATA_MOVIMENTO, CBT.VALOR ';
  end;


  query.Close;
  query.Connection := dmConexao.Conn;
  query.SQL.Clear;
  query.SQL.Add(sqlCmd);
  query.ParamByName('PIDORGANIZACAO').AsString := pIDOrganizacao;
  query.ParamByName('DTDATAINICIAL').AsDateTime := pDataInicio;
  query.ParamByName('DTDATAFINAL').AsDateTime := pDataFim;

  query.Open;

  Result := query;

end;

class function TContaBancariaTRFDAO.obterPorID(value: TContaBancariaTRFModel): TContaBancariaTRFModel;
var
qryPesquisa : TFDQuery;
model: TContaBancariaTRFModel;
begin
dmConexao.conectarBanco;
model     := TContaBancariaTRFModel.Create;
qryPesquisa := TFDQuery.Create(nil);

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM CONTA_BANCARIA_TRANSFERENCIA  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTA_BANCARIA_TRANSFERENCIA = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
      model     := getModel(qryPesquisa);
  end;

except
raise Exception.Create('Erro ao tentar obter CONTA_BANCARIA_TRANSFERENCIA ');
end;

 Result := model;
end;


class function TContaBancariaTRFDAO.obterTodos(value: string; pDataInicial,  pDataFinal: TDateTime; var combo: TComboBox;  var listaID: TStringList): boolean;
var
qryObterTodos : TFDQuery;
cmdSql :string;
identificacao :string;
begin

dmConexao.conectarBanco;
qryObterTodos := TFDQuery.Create(nil);

cmdSql := ' SELECT CBT.ID_CONTA_BANCARIA_TRANSFERENCIA, CBT.IDENTIFICACAO, CBT.DATA_MOVIMENTO, CBT.VALOR '+
          ' FROM CONTA_BANCARIA_TRANSFERENCIA CBT '+
          ' WHERE   (CBT.ID_ORGANIZACAO = :PIDORGANIZACAO)'+
          ' AND (CBT.DATA_MOVIMENTO BETWEEN :PDTINICIAL AND :PDTFINAL) '+
          ' AND (CBT.ID_LOTE_CONTABIL IS NULL) ';

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< Selecione  >>>');

   qryObterTodos.Close;
   qryObterTodos.SQL.Clear;
   qryObterTodos.SQL.Add(cmdSql);
   qryObterTodos.Connection := dmConexao.conn;
   qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := value;
   qryObterTodos.ParamByName('PDTINICIAL').AsDateTime := pDataInicial;
   qryObterTodos.ParamByName('PDTFINAL').AsDateTime := pDataFinal;
   qryObterTodos.Open;

   if not qryObterTodos.IsEmpty then begin
          qryObterTodos.First;

      while not qryObterTodos.Eof do
        begin
          identificacao := qryObterTodos.FieldByName('IDENTIFICACAO').AsString + ' - ' +
              DateToStr(qryObterTodos.FieldByName('DATA_MOVIMENTO').AsDateTime) + ' - R$ ' +
              FormatCurr(',0.00',(qryObterTodos.FieldByName('VALOR').AsCurrency));

          combo.Items.Add(identificacao);
          listaID.Add(qryObterTodos.FieldByName('ID_CONTA_BANCARIA_TRANSFERENCIA').AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      combo.ItemIndex := 0;

   end;


end;

class function TContaBancariaTRFDAO.obterValorDebitoPeriodo(pIDOrganizacao,  pTOB: string; pDataInicio, pDataFim: TDateTime): Currency;
   var
  comando : string;
  qryObterValorDebitoGeneric : TFDQuery;
begin
   //  pDataInicial := StrToDate(FormatDateTime('dd/mm/yyyy', pDataInicial));
    // pDataFinal := StrToDate(FormatDateTime('dd/mm/yyyy', pDataFinal));

   qryObterValorDebitoGeneric :=  TFDQuery.Create(nil);
   dmConexao.conectarBanco;

   comando :='SELECT Sum(VALOR) as VALOR_DEBITO ' +
           'FROM ' + pTable + ' as TB '+
           'WHERE TB.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL '+
           'AND TB.ID_ORGANIZACAO=:PIDORGANIZACAO ' +
           'AND TB.ID_TIPO_OPERACAO_BANCARIA = :PTOB '+
           'AND TB.ID_LOTE_CONTABIL IS NULL ';
  try
   try

            qryObterValorDebitoGeneric.Close;
            qryObterValorDebitoGeneric.Connection := dmConexao.Conn;
            qryObterValorDebitoGeneric.SQL.Clear;
            qryObterValorDebitoGeneric.SQL.Add(comando);
            qryObterValorDebitoGeneric.ParamByName('PIDORGANIZACAO').AsString := pIDOrganizacao;
            qryObterValorDebitoGeneric.ParamByName('PTOB').AsString := pTOB;
            qryObterValorDebitoGeneric.ParamByName('DTDATAINICIAL').AsDateTime := pDataInicio;
            qryObterValorDebitoGeneric.ParamByName('DTDATAFINAL').AsDateTime := pDataFim;

            qryObterValorDebitoGeneric.Open;

            Result := qryObterValorDebitoGeneric.FieldByName('VALOR_DEBITO').AsCurrency;

  except
    raise(Exception).Create('Problemas ao OBTER VALOR DEBITO POR TIPO OPERACAO BANCARIA');
  end;
  finally
    FreeAndNil(qryObterValorDebitoGeneric);
  end;

end;

class function TContaBancariaTRFDAO.obterTodos(value: TContaBancariaTRFModel; pDataInicial, pDataFinal: TDateTime): TFDQuery;
var
qryPesquisa : TFDQuery;
begin
dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);

      try

        qryPesquisa.Close;
        qryPesquisa.Connection := dmConexao.conn;
        qryPesquisa.SQL.Clear;
        qryPesquisa.SQL.Add('SELECT *  '  );
        qryPesquisa.SQL.Add('FROM CONTA_BANCARIA_TRANSFERENCIA  '  );
        qryPesquisa.SQL.Add('WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)  AND (DATA_MOVIMENTO  BETWEEN :PDTINICIAL AND :PDTFINAL )');
        qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
        qryPesquisa.ParamByName('PDTINICIAL').AsDateTime := pDataInicial;
        qryPesquisa.ParamByName('PDTFINAL').AsDateTime := pDataFinal;

        qryPesquisa.Open;


      except
      raise Exception.Create('Erro ao tentar obter TRANSFERÊNCIAS NO PERIODO  ');
      end;

 Result := qryPesquisa;
end;


class function TContaBancariaTRFDAO.transfereEntreContas( value: TContaBancariaTRFModel): Boolean;
 var
 sucesso : Boolean;
 contaDB, contaCR :string;
begin
  sucesso := False;

  if not dmConexao.conn.InTransaction then
    dmConexao.conn.StartTransaction;

  try

    if not uutil.Empty(value.FcontaBancariaDB.FID) then
    begin
      contaDB := value.FcontaBancariaDB.FcontaBancaria.Fconta;
      sucesso := TContaBancariaDebitoDAO.Insert(value.FcontaBancariaDB);
    end;

    if not uutil.Empty(value.FcontaBancariaCR.FID) then
    begin
      contaCR := value.FcontaBancariaCR.FcontaBancaria.Fconta;
      sucesso := TContaBancariaCreditoDAO.Insert(value.FcontaBancariaCR);
    end;

    if sucesso then
    begin
      Insert(value);
      TMDDAO.registroMD(value.FIDorganizacao, pTable, 'TRF', 'TRF DA ' + contaDB + '  para ' + contaCR, 'TRANSF');
    end;

    if dmConexao.conn.InTransaction then
      dmConexao.conn.CommitRetaining;

  except
    if dmConexao.conn.InTransaction then
      dmConexao.conn.RollbackRetaining;

  end;

  Result := sucesso;

end;

class function TContaBancariaTRFDAO.Update(value: TContaBancariaTRFModel): Boolean;
var
cmdSql:string;
qryInsert : TFDQuery;
sucesso :Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
  qryInsert := TFDQuery.Create(nil);

  try
    try
    cmdSql := ' UPDATE CONTA_BANCARIA_TRANSFERENCIA ' +
              '  SET ID_CONTA_BANCARIA_CREDITO    = :PID_CONTA_BANCARIA_CREDITO,'+
              '      ID_CONTA_BANCARIA_DEBITO     = :PID_CONTA_BANCARIA_DEBITO,'+
              '      ID_TIPO_OPERACAO_BANCARIA    = :PIDTOB,'+
              '      ID_RESPONSAVEL               = :PIDRESP,'+
              '      OBSERVACAO                   = :POBSERVACAO,'+
              '      VALOR                        = :PVALOR,'+
              '      DATA_MOVIMENTO               = :PDTMOVIMENTO,'+
              '      IDENTIFICACAO                = :PIDENTIFICACAO,'+
              '      ID_USUARIO                   = :PIDUSUARIO,'+
              '      ID_LOTE_CONTABIL             = :PIDLOTECONTABIL'+
              '      WHERE (ID_CONTA_BANCARIA_TRANSFERENCIA = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO)' ;


      qryInsert.Close;
      qryInsert.Connection := dmConexao.conn;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add(cmdSql);
      qryInsert.ParamByName('PID').AsString                         := value.FID;
      qryInsert.ParamByName('PIDORGANIZACAO').AsString              := value.FIDorganizacao;
      qryInsert.ParamByName('PID_CONTA_BANCARIA_CREDITO').AsString  := value.FIDcontaBancariaCR;
      qryInsert.ParamByName('PID_CONTA_BANCARIA_DEBITO').AsString   := value.FIDcontaBancariaDB;
      qryInsert.ParamByName('PIDTOB').AsString                      := value.FIDTOB;
      qryInsert.ParamByName('PIDRESP').AsString                     := value.FIDResponsavel;
      qryInsert.ParamByName('POBSERVACAO').AsString                 := value.Fobservacao;
      qryInsert.ParamByName('PIDLOTECONTABIL').AsString             := value.FIDloteContabil;
      qryInsert.ParamByName('PIDUSUARIO').AsInteger                 := value.FIDusuario;
      qryInsert.ParamByName('PIDENTIFICACAO').AsString              := value.Fidentificacao;
//      qryInsert.ParamByName('PDTREGISTRO').AsDateTime               := value.FdataRegistro;
      qryInsert.ParamByName('PDTMOVIMENTO').AsDateTime              := value.FdataMovimento;
      qryInsert.ParamByName('PVALOR').AsCurrency                    := value.Fvalor;

    if uUtil.Empty(value.FIDloteContabil) then
    begin
      qryInsert.ParamByName('PIDLOTECONTABIL').Value := null;
    end;

    if (value.FIDusuario = 0) then
    begin
      qryInsert.ParamByName('PIDUSUARIO').AsString := IntToStr(uutil.TUserAtual.getUserId);
    end;

     qryInsert.ExecSQL;
     if qryInsert.RowsAffected >0 then begin sucesso := True; end;

    Result := sucesso;
    except
      sucesso := False;
      raise Exception.Create('Erro ao tentar inserir CBT');
    end;

    Result := sucesso;
  finally
    if Assigned(qryInsert) then
    begin
      FreeAndNil(qryInsert);

    end;

  end;
end;


end.
