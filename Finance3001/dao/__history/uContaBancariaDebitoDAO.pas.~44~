unit uContaBancariaDebitoDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uContaBancariaDBModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uContaContabilModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uContaBancariaModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
 TContaBancariaDebitoDAO = class
  private

  public
    {métodos CRUD (Create, Read, Update e Delete)
    para manipulação dos dados}

    class function Insert(tContaDB :TContaBancariaDBModel): Boolean;
    class function obterPorID(tContaDB :TContaBancariaDBModel): TContaBancariaDBModel;
    class function Delete(tContaDB :TContaBancariaDBModel): Boolean;
  //  class function Update(tContaDB :TContaBancariaDBModel): Boolean;

  end;

implementation

{ TContaBancariaDebitoDAO }

class function TContaBancariaDebitoDAO.Delete(  tContaDB: TContaBancariaDBModel): Boolean;
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
  qryDelete.SQL.Add('DELETE FROM CONTA_BANCARIA_DEBITO  '  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTA_BANCARIA_DEBITO = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := tContaDB.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := tContaDB.FID;
  qryDelete.Open;

  qryDelete.ExecSQL;
  xResp := True;
    //o comit fica na transacao

 except
 xResp := False;
 raise Exception.Create('Erro ao tentar DELETAR CBD');

 end;


  Result := xResp;
end;

class function TContaBancariaDebitoDAO.Insert(tContaDB: TContaBancariaDBModel): Boolean;
var
cmdSql:string;
qryInsert : TFDQuery;
xResp :Boolean;
begin
xResp := False;
 dmConexao.conectarBanco;
 try

    cmdSql := ' INSERT INTO CONTA_BANCARIA_DEBITO '+
              ' (ID_CONTA_BANCARIA_DEBITO, ID_ORGANIZACAO, ID_CONTA_BANCARIA, '+
              ' ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, ID_TITULO_PAGAR, '+
              ' ID_CONTA_BANCARIA_CHEQUE, ID_LOTE_CONTABIL, ID_USUARIO, TIPO_LANCAMENTO, '+
              ' OBSERVACAO, DESCRICAO, VALOR, DATA_REGISTRO, DATA_MOVIMENTO, IDENTIFICACAO )'+
              ' VALUES (:PID, :PIDORGANIZACAO, :PIDCONTABANCARIA, '+
              ' :PIDTOB, :PIDRESP, :PIDTP, '+
              ' :PIDCHEQUE, :PIDLOTECONTABIL, :PIDUSUARIO, :PTIPOLANCAMENTO, '+
              ' :POBS, :PDESCRICAO, :PVALOR,:PDTREGISTRO, :PDTMOVIMENTO, :PIDENTIFICACAO  ) ';


  qryInsert := TFDQuery.Create(nil);
  qryInsert.Close;
  qryInsert.Connection := dmConexao.conn;
  qryInsert.SQL.Clear;
  qryInsert.SQL.Add(cmdSql);
  qryInsert.ParamByName('PID').AsString               := tContaDB.FID;
  qryInsert.ParamByName('PIDORGANIZACAO').AsString    := tContaDB.FIDorganizacao;
  qryInsert.ParamByName('PIDCONTABANCARIA').AsString  := tContaDB.FIDcontaBancaria;

  qryInsert.ParamByName('PIDTOB').AsString            := tContaDB.FIDTOB;
  qryInsert.ParamByName('PIDRESP').AsString           := tContaDB.FIDResponsavel;
  qryInsert.ParamByName('PIDTP').AsString             := tContaDB.FIDTP;
  qryInsert.ParamByName('PIDCHEQUE').AsString         := tContaDB.FIDCheque;
  qryInsert.ParamByName('PIDLOTECONTABIL').AsString   := tContaDB.FIDloteContabil;
  qryInsert.ParamByName('PIDUSUARIO').AsString        := tContaDB.FIDusuario;

    if uUtil.Empty(tContaDB.FIDTP) then
    begin
      qryInsert.ParamByName('PIDTP').Value := null;
    end;

    if uUtil.Empty(tContaDB.FIDCheque) then
    begin
      qryInsert.ParamByName('PIDCHEQUE').Value := null;
    end;

    if uUtil.Empty(tContaDB.FIDloteContabil) then
    begin
      qryInsert.ParamByName('PIDLOTECONTABIL').Value := null;
    end;

    if uUtil.Empty(tContaDB.FIDusuario) then
    begin
      qryInsert.ParamByName('PIDUSUARIO').Value := null;
    end;


  qryInsert.ParamByName('PTIPOLANCAMENTO').AsString   := tContaDB.FtipoLancamento;
  qryInsert.ParamByName('POBS').AsString              := tContaDB.Fobservacao;
  qryInsert.ParamByName('PDESCRICAO').AsString        := tContaDB.Fdescricao;
  qryInsert.ParamByName('PIDENTIFICACAO').AsString    := tContaDB.Fidentificacao;
  qryInsert.ParamByName('PDTREGISTRO').AsDateTime     := tContaDB.FdataRegistro;
  qryInsert.ParamByName('PDTMOVIMENTO').AsDateTime    := tContaDB.FdataMovimento;
  qryInsert.ParamByName('PVALOR').AsCurrency          := tContaDB.Fvalor;

  qryInsert.ExecSQL;
  xResp := True;
    //o comit fica na transacao

 except
 xResp := False;
 raise Exception.Create('Erro ao tentar inserir CBD');

 end;


  Result := xResp;
end;

class function TContaBancariaDebitoDAO.obterPorID( tContaDB: TContaBancariaDBModel): TContaBancariaDBModel;
var
qryPesquisa : TFDQuery;

contaDB: TContaBancariaDBModel;
begin
dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM CONTA_BANCARIA_DEBITO  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTA_BANCARIA_DEBITO = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := tContaDB.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := tContaDB.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      contaDB                  := TContaBancariaDBModel.Create;
      contaDB.FID              := qryPesquisa.FieldByName('ID_CONTA_BANCARIA_DEBITO').AsString;
      contaDB.FIDorganizacao   := qryPesquisa.FieldByName('ID_ORGANIZACAO').AsString;
      contaDB.FIDcontaBancaria := qryPesquisa.FieldByName('ID_CONTA_BANCARIA').AsString;
      contaDB.FIDusuario       := qryPesquisa.FieldByName('ID_USUARIO').AsString;
      contaDB.FIDTOB           := qryPesquisa.FieldByName('ID_TIPO_OPERACAO_BANCARIA').AsString;
      contaDB.FIDResponsavel   := qryPesquisa.FieldByName('ID_RESPONSAVEL').AsString;
      contaDB.FIDTP            := qryPesquisa.FieldByName('ID_TITULO_PAGAR').AsString;
      contaDB.FIDCheque        := qryPesquisa.FieldByName('ID_CONTA_BANCARIA_CHEQUE').AsString;
      contaDB.Fobservacao      := qryPesquisa.FieldByName('OBSERVACAO').AsString;
      contaDB.FIDloteContabil  := qryPesquisa.FieldByName('ID_LOTE_CONTABIL').AsString;
      contaDB.FtipoLancamento  := qryPesquisa.FieldByName('TIPO_LANCAMENTO').AsString;
      contaDB.Fdescricao       := qryPesquisa.FieldByName('DESCRICAO').AsString;
      contaDB.Fidentificacao   := qryPesquisa.FieldByName('IDENTIFICACAO').AsString;
      contaDB.FdataRegistro   := qryPesquisa.FieldByName('DATA_REGISTRO').AsDateTime;
      contaDB.FdataMovimento   := qryPesquisa.FieldByName('DATA_MOVIMENTO').AsDateTime;
      contaDB.Fvalor           := qryPesquisa.FieldByName('VALOR').AsCurrency;


  end;


except
raise Exception.Create('Erro ao tentar obter CONTA BANCARIA DB ');

end;

 Result := contaDB;
end;


{
function TContaBancariaDebitoDAO.insereCBOrigem(ID_CONTA_BANCARIA_DEBITO, ID_ORGANIZACAO,
  ID_CONTA_BANCARIA, ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, TIPO_LANCAMENTO,
  DESCRICAO: string; ID_USUARIO: Integer; VALOR: Currency; DATA_REGISTRO,
  DATA_MOVIMENTO: TDate): Boolean;
var
pIdentificadorCBD, cmdCBD :string;

begin
 dmConexao.conectarBanco;

 try

      pIdentificadorCBD := dmConexao.obterIdentificador(ID_ORGANIZACAO,'CBD');


      //inserir cbc
      cmdCBD := ' INSERT INTO CONTA_BANCARIA_DEBITO (IDENTIFICACAO, ID_CONTA_BANCARIA_DEBITO, ID_ORGANIZACAO, ID_CONTA_BANCARIA, ID_TIPO_OPERACAO_BANCARIA, '+
                ' ID_RESPONSAVEL, TIPO_LANCAMENTO, DESCRICAO, VALOR, DATA_REGISTRO, DATA_MOVIMENTO,  ID_USUARIO) ' +
                ' VALUES (:PIDENT, :PID, :PIDORGANIZACAO, :PIDCONTABANCARIA, :PIDTIPO, :PIDRESP, :PTIPO, :PDESCRICAO, :PVALOR, :PDTREGISTRO, :PDTMOVIMENTO, :PUSUARIO) ' ;

    qryInsereCBORIGEM.Close;
    qryInsereCBORIGEM.Connection := dmConexao.conn;
    qryInsereCBORIGEM.SQL.Clear;
    qryInsereCBORIGEM.SQL.Add(cmdCBD);
    qryInsereCBORIGEM.ParamByName('PIDENT').AsString := pIdentificadorCBD;
    qryInsereCBORIGEM.ParamByName('PID').AsString := ID_CONTA_BANCARIA_DEBITO;
    qryInsereCBORIGEM.ParamByName('PIDORGANIZACAO').AsString := ID_ORGANIZACAO;
    qryInsereCBORIGEM.ParamByName('PIDCONTABANCARIA').AsString := ID_CONTA_BANCARIA;
    qryInsereCBORIGEM.ParamByName('PTIPO').AsString := TIPO_LANCAMENTO;
    qryInsereCBORIGEM.ParamByName('PIDTIPO').AsString := ID_TIPO_OPERACAO_BANCARIA;
    qryInsereCBORIGEM.ParamByName('PIDRESP').AsString := ID_RESPONSAVEL;
    qryInsereCBORIGEM.ParamByName('PDESCRICAO').AsString := DESCRICAO;
    qryInsereCBORIGEM.ParamByName('PVALOR').AsCurrency := VALOR;
    qryInsereCBORIGEM.ParamByName('PDTREGISTRO').AsDate := DATA_REGISTRO;
    qryInsereCBORIGEM.ParamByName('PDTMOVIMENTO').AsDate := DATA_MOVIMENTO;
    qryInsereCBORIGEM.ParamByName('PUSUARIO').AsInteger := ID_USUARIO;

    qryInsereCBORIGEM.ExecSQL;

    dmConexao.conn.CommitRetaining;

    Result := System.True;

 except
     dmConexao.conn.RollbackRetaining;

  raise Exception.Create('Erro ao inserir CBDESTINO');

 end;
end;

   }
end.
