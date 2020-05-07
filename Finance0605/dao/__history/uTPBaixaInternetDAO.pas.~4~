unit uTPBaixaInternetDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uTPBaixaInternetModel ;



  const
   pTable : string = 'TITULO_PAGAR_BAIXA_INTERNET';


type
 TTPBaixaInternetDAO = class
  private
    class function getModel (query :TFDQuery) : TTPBaixaInternetModel;

  public

    class function Insert(value :TTPBaixaInternetModel): Boolean;
    class function obterPorID (value :TTPBaixaInternetModel): TTPBaixaInternetModel;
    class function Delete(value :TTPBaixaInternetModel): Boolean;
    class function obterTodosPorBaixa (value :TTPBaixaInternetModel): TFDQuery;


  end;


implementation



class function TTPBaixaInternetDAO.Delete(value: TTPBaixaInternetModel): Boolean;
var
  qryDelete: TFDQuery;
  xResp: Boolean;
begin
  xResp := False;
  dmConexao.conectarBanco;
  try

    qryDelete := TFDQuery.Create(nil);
    qryDelete.Close;
    qryDelete.Connection := dmConexao.conn;
    qryDelete.SQL.Clear;
    qryDelete.SQL.Add('DELETE FROM TITULO_PAGAR_BAIXA_INTERNET  ');
    qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR_BAIXA_INTERNET = :PID ');
    qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qryDelete.ParamByName('PID').AsString := value.FID;

    qryDelete.ExecSQL;
    xResp := True;


  except
    xResp := False;
    raise Exception.Create('Erro ao tentar DELETAR TITULO_PAGAR_BAIXA_FP');

  end;

  Result := xResp;
end;

class function TTPBaixaInternetDAO.getModel( query: TFDQuery): TTPBaixaInternetModel;
var
tpbInternet: TTPBaixaInternetModel;

begin
     tpbInternet  := TTPBaixaInternetModel.Create;

 try

  if not query.IsEmpty then begin

      tpbInternet.FID                     := query.FieldByName('ID_TITULO_PAGAR_BAIXA_INTERNET').AsString;
      tpbInternet.FIDorganizacao          := query.FieldByName('ID_ORGANIZACAO').AsString;
      tpbInternet.FIDTPB                  := query.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString;
      tpbInternet.FIDTOB                  := query.FieldByName('ID_TIPO_OPERACAO_BANCARIA').AsString;
      tpbInternet.FIDcontaBancariaOrigem  := query.FieldByName('ID_CONTA_BANCARIA').AsString;
      tpbInternet.FIDbancoDestino         := query.FieldByName('ID_BANCO_DESTINO').AsString;
      tpbInternet.Fdetalhamento           := query.FieldByName('DETALHAMENTO').AsString;
      tpbInternet.FcontaDestino           := query.FieldByName('CONTA_DESTINO').AsString;
      tpbInternet.FagenciaDestino         := query.FieldByName('AGENCIA_DESTINO').AsString;
      tpbInternet.FnomeCorrentista        := query.FieldByName('NOME_CORRENTISTA').AsString;
      tpbInternet.Fpersonalidade          := query.FieldByName('PERSONALIDADE').AsString;
      tpbInternet.FCPCFCNPJCorrentista    := query.FieldByName('CPFCNPJ_CORRENTISTA').AsString;
      tpbInternet.FValor                  := query.FieldByName('VALOR').AsCurrency;
      tpbInternet.FdataOperacao           := query.FieldByName('DATA_OPERACAO').AsDateTime;

  end;

 except
 raise Exception.Create('Erro ao obter TITULO_PAGAR_BAIXA_INTERNET');

 end;


  Result := tpbInternet;

end;

class function TTPBaixaInternetDAO.Insert(value: TTPBaixaInternetModel): Boolean;
var
qryInsert : TFDQuery;
cmdSql :string;
begin
dmConexao.conectarBanco;


  cmdSql :=   ' INSERT INTO TITULO_PAGAR_BAIXA_INTERNET '+
              ' (ID_TITULO_PAGAR_BAIXA_INTERNET, ID_ORGANIZACAO, '+
              ' ID_TITULO_PAGAR_BAIXA, ID_CONTA_BANCARIA, ID_TIPO_OPERACAO_BANCARIA, '+
              ' ID_BANCO_DESTINO, CONTA_DESTINO, AGENCIA_DESTINO, NOME_CORRENTISTA, PERSONALIDADE,'+
              ' CPFCNPJ_CORRENTISTA, VALOR, DETALHAMENTO, DATA_OPERACAO ) '+
              ' VALUES (:PID, :PIDORGANIZACAO, :PIDTITULO_PAGAR_BAIXA, '+
              '  :PIDCONTA_BANCARIA, :PIDTOB, :PID_BANCO_DESTINO, '+
              '  :PCONTA_DESTINO, :PAGENCIA_DESTINO, :PNOME_CORRENTISTA, :PPERSONALIDADE, '+
              '  :PCPFCNPJ_CORRENTISTA, :PVALOR, :PDETALHAMENTO, :PDATA_OPERACAO ) ';


    qryInsert := TFDQuery.Create(nil);
    qryInsert.Close;
    qryInsert.Connection := dmConexao.conn;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(cmdSql);
    qryInsert.ParamByName('PID').AsString                    := value.FID;
    qryInsert.ParamByName('PIDTITULO_PAGAR_BAIXA').AsString  := value.FIDTPB;
    qryInsert.ParamByName('PIDORGANIZACAO').AsString         := value.FIDorganizacao;
    qryInsert.ParamByName('PIDTOB').AsString                 := value.FIDTOB;
    qryInsert.ParamByName('PIDCONTA_BANCARIA').AsString      := value.FIDcontaBancariaOrigem;
    qryInsert.ParamByName('PID_BANCO_DESTINO').AsString      := value.FIDbancoDestino;
    qryInsert.ParamByName('PCONTA_DESTINO').AsString         := value.FcontaDestino;
    qryInsert.ParamByName('PAGENCIA_DESTINO').AsString       := value.FagenciaDestino;
    qryInsert.ParamByName('PNOME_CORRENTISTA').AsString      := value.FnomeCorrentista;
    qryInsert.ParamByName('PPERSONALIDADE').AsString         := value.Fpersonalidade;
    qryInsert.ParamByName('PCPFCNPJ_CORRENTISTA').AsString   := value.FCPCFCNPJCorrentista;
    qryInsert.ParamByName('PDETALHAMENTO').AsString          := value.Fdetalhamento;
    qryInsert.ParamByName('PDATA_OPERACAO').AsDateTime       := value.FdataOperacao;
    qryInsert.ParamByName('PVALOR').AsCurrency               := value.FValor;

     if uUtil.Empty(value.FIDbancoDestino) then
    begin
      qryInsert.ParamByName('PID_BANCO_DESTINO').Value := null;
    end;

    qryInsert.ExecSQL;

 Result := System.True;
end;

class function TTPBaixaInternetDAO.obterPorID( value: TTPBaixaInternetModel): TTPBaixaInternetModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
tpbInternet: TTPBaixaInternetModel;
begin
dmConexao.conectarBanco;
try

  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_PAGAR_BAIXA_INTERNET  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR_BAIXA_INTERNET = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
      tpbInternet   := TTPBaixaInternetModel.Create;
      tpbInternet   := getModel(qryPesquisa) ;
  end;
except
raise Exception.Create('Erro ao tentar obter  '+ pTable );

end;

 Result := tpbInternet;
end;




class function TTPBaixaInternetDAO.obterTodosPorBaixa(  value: TTPBaixaInternetModel): TFDQuery;
var
qryPesquisa : TFDQuery;
begin
dmConexao.conectarBanco;

try

  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_PAGAR_BAIXA_INTERNET  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR_BAIXA = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FIDTPB;
  qryPesquisa.Open;



except
raise Exception.Create('Erro ao tentar obter  '+ pTable );
end;

 Result := qryPesquisa;
end;


end.
