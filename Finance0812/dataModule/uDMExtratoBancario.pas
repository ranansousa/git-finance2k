unit uDMExtratoBancario;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,udmConexao,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.DateUtils, uUtil ;

type
  TdmExtratoBancario = class(TDataModule)
    qryCBD: TFDQuery;
    qryCBC: TFDQuery;
    qrySaldoCredito: TFDQuery;
    qrySaldoDebito: TFDQuery;
    qryDeletaTemp: TFDQuery;
    qryInsereTemp: TFDQuery;
    qryExtrato: TFDQuery;
  private


    { Private declarations }
  public
    { Public declarations }
    function montarTabelaTemp(pData: TDate; pDetalhe, pTipo: string;
      pValor: Currency) :Boolean;
    function obterSaldoPorContaCredito(pIdOrganizacao, pIDConta: string;
      pDataInicial, pDataFinal: TDate): Currency;
    function obterSaldoPorContaDebito(pIdOrganizacao, pIDConta: string;
      pDataInicial, pDataFinal: TDate): Currency;
    function obterLancamentosDebito(pIdOrganizacao, pIDConta: string;
      pDataInicial, pDataFinal: TDate): Integer;
  function obterSaldoAnterior(pIdOrganizacao, pIDConta :string; pDataInicial, pDataFinal :TDate) : Currency;
  function obterLancamentosCredito(pIdOrganizacao, pIDConta :string; pDataInicial, pDataFinal :TDate) : Integer;
  function insereLancamentoTemp( pData: TDate; pDetalhe,  pTipo: string; pValor: Currency ) :Boolean;
 // function limpaTabelaTemp(): Boolean;





  end;

var
  dmExtratoBancario: TdmExtratoBancario;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmExtratoBancario }



function TdmExtratoBancario.obterLancamentosDebito(pIdOrganizacao,
  pIDConta: string; pDataInicial, pDataFinal: TDate): Integer;
begin
dmConexao.conectarBanco;
  try

      qryCBD.Close;
      qryCBD.Connection := dmConexao.conn;
      qryCBD.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryCBD.ParamByName('PIDCONTA').AsString       := pIDConta ;
      qryCBD.ParamByName('DTDATAINICIAL').AsDate    := pDataInicial;
      qryCBD.ParamByName('DTDATAFINAL').AsDate      := pDataFinal;
      qryCBD.Open;


  except
  raise Exception.Create('Error ao obter lançamentos de débito');
  end;

  Result :=qryCBD.RecordCount;

end;


function TdmExtratoBancario.montarTabelaTemp(pData: TDate; pDetalhe,  pTipo: string; pValor: Currency) :Boolean;
var
cheque :string;
rstaux : Boolean;
begin

  cheque :='';
    //fazer primeiro o insert do saldo anterior. Dados na assinatura
  rstAux := insereLancamentoTemp(pData, pDetalhe, pTipo, pValor); //SALDO ANTERIOR

    // enviar os dados dos lancamentos creditos
     if qryCBC.RecordCount > 0  then begin
        qryCBC.First;
         while  (not qryCBC.Eof) do begin

          pData    := qryCBC.FieldByName('data_movimento').AsDateTime;
          pTipo    := qryCBC.FieldByName('tipo_lancamento').AsString;
          pValor   := qryCBC.FieldByName('valor').AsCurrency;
          pDetalhe := 'Transacao Nº ' + qryCBC.FieldByName('identificacao').AsString + ' ' +
                       qryCBC.FieldByName('descricao').AsString + ' ' +
                       qryCBC.FieldByName('NOME').AsString + ' '  ;


            insereLancamentoTemp(pData, UpperCase(pDetalhe), pTipo, pValor);

            qryCBC.Next;

         end;
     end;


     // enviar os dados dos lancamentos debitos
      if qryCBD.RecordCount >0  then begin
        qryCBD.First;
         while  (not qryCBD.Eof) do begin
          cheque := qryCBD.FieldByName('numero_cheque').AsString;

          pData    := qryCBD.FieldByName('data_movimento').AsDateTime;
          pTipo    := qryCBD.FieldByName('tipo_lancamento').AsString;
          pValor   := qryCBD.FieldByName('valor').AsCurrency;
          pDetalhe :=  'Transacao Nº ' + qryCBD.FieldByName('identificacao').AsString + ' ' +
                      qryCBD.FieldByName('descricao').AsString + ' ' +
                      qryCBD.FieldByName('FORNECEDOR').AsString  ;


             if (not uutil.Empty (cheque)) then begin
             pDetalhe := qryCBD.FieldByName('descricao').AsString + '  ' +
                         qryCBD.FieldByName('NUMERO_DOCUMENTO').AsString + '  ' +
                         ' CTA  ' + qryCBD.FieldByName('CONTA_BANCO').AsString + '  ' +
                         qryCBD.FieldByName('FORNECEDOR').AsString  ;
             end;



            insereLancamentoTemp(pData, UpperCase(pDetalhe), pTipo, pValor);

            qryCBD.Next;

         end;
     end;

      Result := rstaux;
end;

function TdmExtratoBancario.insereLancamentoTemp(pData: TDate; pDetalhe,  pTipo: string; pValor: Currency): Boolean;
  VAR
  comando :string;
sucesso : Boolean;
begin
  dmConexao.conectarBanco;
  sucesso := False;

    comando := ' INSERT INTO TEMP_EXTRATO (DATA, DETALHAMENTO, TIPO, VALOR) ' +
               ' VALUES (:PDATA, :PDETALHE, :PTIPO, :PVALOR) ' ;

  try


      qryInsereTemp.Close;
      qryInsereTemp.Connection := dmConexao.conn;
      qryInsereTemp.SQL.Clear;
      qryInsereTemp.SQL.Add(comando);
      qryInsereTemp.ParamByName('PDATA').AsDate := pData;
      qryInsereTemp.ParamByName('PDETALHE').AsString := pDetalhe;
      qryInsereTemp.ParamByName('PTIPO').AsString := pTipo;
      qryInsereTemp.ParamByName('PVALOR').AsCurrency := pValor;

      qryInsereTemp.ExecSQL;
      dmConexao.conn.CommitRetaining;

      Result := System.True;

    except
      dmConexao.conn.RollbackRetaining;
      raise Exception.Create('Erro ao tentar montar a tabela temporária...');

    end;



end;

//desativada em 18/06/20 Ranan para eliminar DM
{
function TdmExtratoBancario.limpaTabelaTemp: Boolean;
var
sucesso : Boolean;
begin
  dmConexao.conectarBanco;
  sucesso := False;

   if not Assigned(qryDeletaTemp) then begin
         qryDeletaTemp := TFDQuery.Create(nil);
  end;

  if not dmConexao.conn.InTransaction then
    dmConexao.conn.StartTransaction;

  try
    try

      qryDeletaTemp.Close;
      qryDeletaTemp.Connection := dmConexao.conn;
      qryDeletaTemp.SQL.Clear;
      qryDeletaTemp.SQL.Add('DELETE FROM TEMP_EXTRATO WHERE 1=1');
      qryDeletaTemp.ExecSQL;

      if qryDeletaTemp.RowsAffected > 0 then
      begin
        sucesso := True;
      end;

      Result := sucesso;

      if dmConexao.conn.InTransaction then
        dmConexao.conn.CommitRetaining;

    except
      if dmConexao.conn.InTransaction then
        dmConexao.conn.RollbackRetaining;

      Result := sucesso;
      raise Exception.Create('Erro ao tentar limpar a tabela temporária...');

    end;

  finally
    FreeAndNil(qryDeletaTemp);
  end;

end;


}
function TdmExtratoBancario.obterLancamentosCredito(pIdOrganizacao,
  pIDConta: string; pDataInicial, pDataFinal: TDate): Integer;
begin
  dmConexao.conectarBanco;

  try

      qryCBC.Close;
      qryCBC.Connection := dmConexao.conn;
      qryCBC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryCBC.ParamByName('PIDCONTA').AsString       := pIDConta ;
      qryCBC.ParamByName('DTDATAINICIAL').AsDate    := pDataInicial;
      qryCBC.ParamByName('DTDATAFINAL').AsDate      := pDataFinal;
      qryCBC.Open;

  except
  raise Exception.Create('Error ao obter lançamentos de crédito');
  end;

  Result := qryCBC.RecordCount;

end;

function TdmExtratoBancario.obterSaldoAnterior(pIdOrganizacao, pIDConta: string;
  pDataInicial, pDataFinal: TDate): Currency;
  var
  valorDB, valorCR,  vlrSaldo : Currency;
begin
  valorDB :=0; valorCR :=0;  vlrSaldo :=0;

  try

      valorDB := obterSaldoPorContaDebito(pIdOrganizacao, pIDConta, pDataInicial,pDataFinal);
      valorCR := obterSaldoPorContaCredito(pIdOrganizacao, pIDConta, pDataInicial,pDataFinal);

      vlrSaldo := valorCR - valorDB;

   Result := vlrSaldo;
  except

  raise Exception.Create('Erro ao obter saldo anterior...');

  end;


end;

function TdmExtratoBancario.obterSaldoPorContaCredito(pIdOrganizacao, pIDConta: string;
  pDataInicial, pDataFinal: TDate): Currency;
  var
  valor : Currency;
begin

  valor :=0;


    dmConexao.conectarBanco;
    try

      qrySaldoCredito.Close;
      qrySaldoCredito.Connection := dmConexao.conn;
      qrySaldoCredito.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qrySaldoCredito.ParamByName('PIDCONTA').AsString       := pIDConta ;
      qrySaldoCredito.ParamByName('DTDATAINICIAL').AsDate    := pDataInicial;
      qrySaldoCredito.ParamByName('DTDATAFINAL').AsDate      := pDataFinal;
      qrySaldoCredito.Open;

      if not qrySaldoCredito.IsEmpty then
       valor := qrySaldoCredito.FieldByName('SALDO').AsCurrency;


      Result := valor;
    except
    raise Exception.Create('Erro ao obter saldo crédito ');
    end;

end;



function TdmExtratoBancario.obterSaldoPorContaDebito(pIdOrganizacao, pIDConta: string;
  pDataInicial, pDataFinal: TDate): Currency;
  var
  valor : Currency;
begin

  valor :=0;

    dmConexao.conectarBanco;
    try

      qrySaldoDebito.Close;
      qrySaldoDebito.Connection := dmConexao.conn;
      qrySaldoDebito.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qrySaldoDebito.ParamByName('PIDCONTA').AsString       := pIDConta ;
      qrySaldoDebito.ParamByName('DTDATAINICIAL').AsDate    := pDataInicial;
      qrySaldoDebito.ParamByName('DTDATAFINAL').AsDate      := pDataFinal;
      qrySaldoDebito.Open;

      if not qrySaldoDebito.IsEmpty then
       valor := qrySaldoDebito.FieldByName('SALDO').AsCurrency;


      Result := valor;
    except
    raise Exception.Create('Erro ao obter saldo débito ');
    end;

end;


end.
