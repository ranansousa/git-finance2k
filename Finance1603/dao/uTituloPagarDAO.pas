unit uTituloPagarDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,  System.DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,  uCedenteModel, uCedenteDAO,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,System.Generics.Collections,uTituloPagarParceladoModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uTituloPagarModel, udmConexao, uUtil, uTipoStatusModel, uTipoStatusDAO,
  FireDAC.Comp.DataSet, uTituloPagarHistoricoModel, uTituloPagarHistoricoDAO, uLoteContabilModel, uLoteContabilDAO,
  uTituloPagarCentroCustoModel , uTituloPagarCentroCustoDAO, uLotePagamentoModel, uLotePagamentoDAO,uNotaFiscalEntradaModel, uNotaFiscalEntradaDAO,
  uCentroCustoModel, uCentroCustoDAO, uHistoricoModel, uHistoricoDAO, uFuncionarioModel, uFuncionarioDAO,
   uOrganizacaoDAO, uOrganizacaoModel,  MDModel,MDDAO,
  FireDAC.Comp.Client;

   const
   pTable : string = 'TITULO_PAGAR';

type
 TTituloPagarDAO = class
  private

   class function getTP (query :TFDQuery) : TTituloPagarModel;
    class function registroMD(value: TTituloPagarModel; pAcao, pDsc,
      pStatus: string): Boolean; static;

  public
    {métodos CRUD (Create, Read, Update e Delete)
    para manipulação dos dados}


    class function Insert(titulo :TTituloPagarModel): Boolean;
    class function InsertParcelados(var titulos: TObjectList<TTituloPagarParceladoModel>): Boolean;
    class function existFilhos(titulo :TTituloPagarModel): Boolean;

    class function obterPorID(titulo :TTituloPagarModel): TTituloPagarModel;
    class function obterTodosPorStatus(titulo :TTituloPagarModel): TFDQuery;
    class function obterTodosFilhos(titulo :TTituloPagarModel): TFDQuery;
    class function obterBaixasPorContrato(titulo :TTituloPagarModel): TFDQuery;

    class function obterPorNumeroDocumento(titulo :TTituloPagarModel): TTituloPagarModel;
    class function Delete(titulo :TTituloPagarModel): Boolean;
    class function Update(titulo :TTituloPagarModel): Boolean;
    class function particionar(tituloNovo, tituloAntigo :TTituloPagarModel): Boolean;
    class function obterTodosPagar(pDataInicio, pDataFim :TDateTime; pIDorganizacao :string ) :  TObjectList<TTituloPagarModel>;
    class function obterTodosPagarExport(pDataInicio, pDataFim :TDateTime; pIDorganizacao :string ) :  TObjectList<TTituloPagarModel>;

    class function obterTodosPagarQry(pDataInicio, pDataFim :TDate; pIDorganizacao :string ) :  TFDQuery;
    class function obterTodosPagosPorLote(titulo :TTituloPagarModel ) :  TFDQuery;

    class function obterRateioHistorico(titulo :TTituloPagarModel) :  TObjectList<TTituloPagarHistoricoModel>;
    class function obterRateioCC(titulo :TTituloPagarModel)        :  TObjectList<TTituloPagarCentroCustoModel>;

  end;
implementation
{ TTituloPagarDAO }
class function TTituloPagarDAO.Delete(titulo: TTituloPagarModel): Boolean;
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
  qryDelete.SQL.Add('DELETE FROM TITULO_PAGAR  '  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := titulo.FID;

  qryDelete.ExecSQL;
  xResp := True;
    //o comit fica na transacao

 except
 xResp := False;
 raise Exception.Create('Erro ao tentar DELETAR TITULO');

 end;

  Result := xResp;

  finally
    if Assigned(qryDelete) then
    begin
      FreeAndNil(qryDelete);
    end;
  end;

end;

class function TTituloPagarDAO.Insert(titulo: TTituloPagarModel): Boolean;
var
qryInsert : TFDQuery;
cmdSql :string;

sucesso :Boolean;
I :Integer;
rateioHst : TTituloPagarHistoricoModel;
rateioCC : TTituloPagarCentroCustoModel;

begin
 dmConexao.conectarBanco;
 qryInsert := TFDQuery.Create(nil);

  try

    try


     cmdSql := ' INSERT INTO TITULO_PAGAR '+
     ' (ID_TITULO_PAGAR, ID_ORGANIZACAO, '+
     ' ID_HISTORICO, ID_CEDENTE, ID_TIPO_COBRANCA,'+
     ' ID_RESPONSAVEL, ID_LOCAL_PAGAMENTO, ID_TIPO_STATUS,'+
     ' ID_CENTRO_CUSTO, ID_TITULO_GERADOR, ID_NOTA_FISCAL_ENTRADA,' +
     ' NUMERO_DOCUMENTO, DESCRICAO, DATA_REGISTRO, DATA_EMISSAO, '+
     ' DATA_PROTOCOLO, DATA_VENCIMENTO, PREVISAO_CARTORIO,'+
     ' VALOR_NOMINAL, MOEDA, CARTEIRA, CODIGO_BARRAS, CONTRATO, PARCELA, '+
     ' OBSERVACAO, VALOR_ANTECIPADO, ID_USUARIO, ID_LOTE_PAGAMENTO,'+
     ' DATA_ULTIMA_ATUALIZACAO, ID_CONTA_CONTABIL_CREDITO, ID_CONTA_CONTABIL_DEBITO, '+
     ' REGISTRO_PROVISAO, IS_PROVISAO ) '+
     ' VALUES (:PIDTITULO_PAGAR,:PIDORGANIZACAO, '+
     ' :PIDHISTORICO,:PIDCEDENTE, :PIDTIPO_COBRANCA, '+
     ' :PIDRESPONSAVEL, :PIDLOCAL_PAGAMENTO, :PIDTIPO_STATUS, '+
     ' :PIDCENTRO_CUSTO, :PIDTITULO_GERADOR, :PIDNOTA_FISCAL_ENTRADA, '+
     ' :PNUMERO_DOCUMENTO, :PDESCRICAO, :PDATA_REGISTRO, :PDATA_EMISSAO, '+
     ' :PDATA_PROTOCOLO, :PDATA_VENCIMENTO, :PPREVISAO_CARTORIO, '+
     ' :PVALOR_NOMINAL, :PMOEDA, :PCARTEIRA, :PCODIGO_BARRAS, :PCONTRATO, :PPARCELA, '+
     ' :POBSERVACAO, :PVALOR_ANTECIPADO, :PIDUSUARIO, :PIDLOTE_PAGAMENTO, '+
     ' :PDATA_ULTIMA_ATUALIZACAO, :PIDCONTA_CONTABIL_CREDITO, :PIDCONTA_CONTABIL_DEBITO, '+
     ' :PREGISTRO_PROVISAO, :PIS_PROVISAO ) ' ;


    qryInsert.Close;
    qryInsert.Connection := dmConexao.conn;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(cmdSql);

    qryInsert.ParamByName('PIS_PROVISAO').AsInteger               := titulo.FisProvisao;
    qryInsert.ParamByName('PIDTITULO_PAGAR').AsString             := titulo.FID;
    qryInsert.ParamByName('PIDORGANIZACAO').AsString              := titulo.FIDorganizacao;
    qryInsert.ParamByName('PIDUSUARIO').AsInteger                 := StrToInt(uutil.SoNumeros(titulo.FIDUsuario));
    qryInsert.ParamByName('PIDRESPONSAVEL').AsString              := titulo.FIDResponsavel;
//    qryInsert.ParamByName('PIDLOTE_CONTABIL').AsString            := titulo.FIDLoteContabil;
    qryInsert.ParamByName('PIDHISTORICO').AsString                := titulo.FIDHistorico;
    qryInsert.ParamByName('PIDCEDENTE').AsString                  := titulo.FIDCedente;
//    qryInsert.ParamByName('PIDLOTE_TPB').AsString                 := titulo.FIDLoteTPB;
    qryInsert.ParamByName('PIDTIPO_COBRANCA').AsString            := titulo.FIDTipoCobranca;
    qryInsert.ParamByName('PIDLOCAL_PAGAMENTO').AsString          := titulo.FIDLocalPagamento;
    qryInsert.ParamByName('PIDTIPO_STATUS').AsString              := titulo.FIDTipoStatus;
    qryInsert.ParamByName('PIDCENTRO_CUSTO').AsString             := titulo.FIDCentroCusto;
    qryInsert.ParamByName('PIDNOTA_FISCAL_ENTRADA').AsString      := titulo.FIDNotaFiscalEntrada;
    qryInsert.ParamByName('PIDTITULO_GERADOR').AsString           := titulo.FIDTituloPagarAnterior;
    qryInsert.ParamByName('PIDLOTE_PAGAMENTO').AsString           := titulo.FIDLotePagamento;
    qryInsert.ParamByName('PIDCONTA_CONTABIL_DEBITO').AsString    := titulo.FIDContaContabilDebito;
    qryInsert.ParamByName('PIDCONTA_CONTABIL_CREDITO').AsString   := titulo.FIDContaContabilCredito;
//    qryInsert.ParamByName('PIDCONTA_BANCARIA_CHEQUE').AsString    := titulo.FIDCBChequeVinculado;
    qryInsert.ParamByName('PDESCRICAO').AsString                  := UpperCase(titulo.Fdescricao);
    qryInsert.ParamByName('POBSERVACAO').AsString                 := titulo.Fobservacao;
    qryInsert.ParamByName('PPARCELA').AsString                    := titulo.Fparcela;
    qryInsert.ParamByName('PCONTRATO').AsString                   := titulo.Fcontrato;
    qryInsert.ParamByName('PCODIGO_BARRAS').AsString              := titulo.FcodigoBarras;
    qryInsert.ParamByName('PCARTEIRA').AsString                   := titulo.Fcarteira;
    qryInsert.ParamByName('PMOEDA').AsString                      := titulo.Fmoeda;
    qryInsert.ParamByName('PREGISTRO_PROVISAO').AsString          := titulo.FregistroProvisao;
    qryInsert.ParamByName('PNUMERO_DOCUMENTO').AsString           := titulo.FnumeroDocumento;

    qryInsert.ParamByName('PDATA_REGISTRO').AsDateTime            := titulo.FdataRegistro;
    qryInsert.ParamByName('PDATA_ULTIMA_ATUALIZACAO').AsDateTime  := titulo.FdataUltimaAtualizacao;
    qryInsert.ParamByName('PPREVISAO_CARTORIO').AsDateTime        := titulo.FprevisaoCartorio;
//    qryInsert.ParamByName('PDATA_PAGAMENTO').AsDateTime           := titulo.FdataPagamento;
    qryInsert.ParamByName('PDATA_VENCIMENTO').AsDateTime          := titulo.FdataVencimento;
    qryInsert.ParamByName('PDATA_PROTOCOLO').AsDateTime           := titulo.FdataProtocolo;
    qryInsert.ParamByName('PDATA_EMISSAO').AsDateTime             := titulo.FdataEmissao;

    qryInsert.ParamByName('PVALOR_NOMINAL').AsCurrency            := titulo.FvalorNominal;
    qryInsert.ParamByName('PVALOR_ANTECIPADO').AsCurrency         := titulo.FvalorAntecipado;

    if uUtil.Empty(titulo.FIDContaContabilDebito) then
    begin
      qryInsert.ParamByName('PIDCONTA_CONTABIL_DEBITO').Value := null;
     end;
    if uUtil.Empty(titulo.FIDContaContabilCredito) then
    begin
      qryInsert.ParamByName('PIDCONTA_CONTABIL_CREDITO').Value := null;
     end;
    if uUtil.Empty(titulo.FIDTituloPagarAnterior) then
    begin
      qryInsert.ParamByName('PIDTITULO_GERADOR').Value := null;
     end;
    if uUtil.Empty(titulo.FIDNotaFiscalEntrada) then
    begin
      qryInsert.ParamByName('PIDNOTA_FISCAL_ENTRADA').Value := null;
     end;

     if not IsToday(titulo.FdataRegistro) then begin
        titulo.FdataRegistro := Now;
     end;

     if not IsToday(titulo.FdataUltimaAtualizacao) then begin
        titulo.FdataUltimaAtualizacao := Now;
     end;

    if uUtil.Empty(titulo.FIDLotePagamento) then
    begin
      qryInsert.ParamByName('PIDLOTE_PAGAMENTO').Value := null;
    end;
     if uUtil.Empty(titulo.FregistroProvisao) then
    begin
      qryInsert.ParamByName('PREGISTRO_PROVISAO').Value := null;
    end;



    if titulo.FvalorAntecipado = 0 then begin
      qryInsert.ParamByName('PVALOR_ANTECIPADO').AsCurrency         := 0;
    end;

    if uUtil.Empty(titulo.Fcarteira) then
    begin
      qryInsert.ParamByName('PCARTEIRA').Value := null;
    end;

    if uUtil.Empty(titulo.Fcontrato) then
    begin
      qryInsert.ParamByName('PCONTRATO').Value := null;
    end;

    if uUtil.Empty(titulo.FcodigoBarras) then
    begin
      qryInsert.ParamByName('PCODIGO_BARRAS').Value := null;
    end;

    if uUtil.Empty(titulo.Fobservacao) then
    begin
      qryInsert.ParamByName('POBSERVACAO').Value := null;
    end;


        qryInsert.ExecSQL;

     if qryInsert.RowsAffected >0 then begin

      //checagem das listas
        if titulo.listaHistorico.Count < 1 then
        begin
          sucesso := False;
          raise Exception.Create('Erro ao tentar inserir o rateio de historico: lista rateio historico vazia');
        end;

        if titulo.listaCustos.Count < 1 then
        begin
          sucesso := False;
          raise Exception.Create('Erro ao tentar inserir o rateio de custos: lista rateio centro custos vazia');

        end;

     //insere os novos rateios
        for I := 0 to titulo.listaHistorico.Count - 1 do
        begin
          titulo.listaHistorico[I].FIDTP := titulo.FID;
          titulo.listaHistorico[I].FID   := dmConexao.obterNewID;
          sucesso := TTituloPagarHistoricoDAO.Insert(titulo.listaHistorico[I]);
        end;

        for I := 0 to titulo.listaCustos.Count - 1 do
        begin
          titulo.listaCustos[I].FID   := dmConexao.obterNewID;
          titulo.listaCustos[I].FIDTP := titulo.FID;
          sucesso := TTituloPagarCentroCustoDAO.Insert(titulo.listaCustos[I]);
        end;



    //nota fiscal. o form atualza o objeto
        if not uUtil.Empty(titulo.FIDNotaFiscalEntrada) then
        begin
    //salvar nota fiscal
          if not titulo.FNotaFiscalEntrada.Fnovo then
          begin //já existe
            TNotaFiscalEntradaDAO.Insert(titulo.FNotaFiscalEntrada);
          end;
        end;

        //nota fiscal. o form atualza o objeto
        if sucesso then
        begin
          registroMD(titulo, 'TP', 'CAD TP ' + titulo.FnumeroDocumento + ' ' + titulo.Fdescricao, titulo.FIDTipoStatus);
        end;

        dmConexao.conn.CommitRetaining;

     end;


    except
      on e: Exception do begin
      Result := False;
      dmConexao.conn.RollbackRetaining;
       raise Exception.Create('Erro ao tentar Inserir TITULO ' + e.Message);

      end;

    end;

    Result := sucesso;
  finally
    if Assigned(qryInsert) then
    begin
      FreeAndNil(qryInsert);
    end;
  end;
end;

class function TTituloPagarDAO.InsertParcelados(var titulos: TObjectList<TTituloPagarParceladoModel>): Boolean;
  var
  sucesso : Boolean;
  I: Integer;
  titulo  : TTituloPagarModel;
  registro :string;
begin
I:=0;
  dmConexao.conectarBanco;
  sucesso := False;
  registro := titulos[(titulos.Count -1)].FTituloPagar.FID;
// registroMD( titulos[(titulos.Count -1)].FTituloPagar, 'TP', 'CAD TP ' + IntToStr(titulos.Count) + ' PARCELAS ' + titulos[(titulos.Count -1)].FTituloPagar.FnumeroDocumento + ' ' + titulos[(titulos.Count -1)].FTituloPagar.Fdescricao, titulo.FIDTipoStatus);


  for I := 0 to titulos.Count - 1 do
  begin

    titulo := TTituloPagarModel.Create;
    titulo := titulos[I].FTituloPagar;
    titulo.FregistroProvisao := registro;
    titulo.FisProvisao := 1;

    sucesso := Insert(titulo);

  end;


Result := sucesso;
end;

class function TTituloPagarDAO.obterBaixasPorContrato(
  titulo: TTituloPagarModel): TFDQuery;
var
qryPesquisa : TFDQuery;
cmd :string;

begin
dmConexao.conectarBanco;
try
   cmd := ' SELECT * FROM TITULO_PAGAR TP '+
          ' WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
          ' AND  (TP.ID_CEDENTE     = :PIDCENTE) '+
          ' AND  (TP.CONTRATO       = :PCONTRATO) '+
          ' AND  (TP.ID_TIPO_STATUS IN (''QUITADO'', ''PARCIAL'')) ';   ;

    qryPesquisa := TFDQuery.Create(nil);
    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add(cmd);

    qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
    qryPesquisa.ParamByName('PIDCENTE').AsString := titulo.FIDCedente;
    qryPesquisa.ParamByName('PCONTRATO').AsString := titulo.Fcontrato;

    qryPesquisa.Open;


except
raise Exception.Create('Erro ao tentar obter BAIXAS por CONTRATO');

end;

 Result := qryPesquisa;

end;


class function TTituloPagarDAO.obterPorID(titulo: TTituloPagarModel): TTituloPagarModel;
var
qryPesquisa : TFDQuery;
tituloPagar: TTituloPagarModel;

begin
dmConexao.conectarBanco;

tituloPagar := TTituloPagarModel.Create;
qryPesquisa := TFDQuery.Create(nil);

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_PAGAR  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := titulo.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin


      tituloPagar := getTP(qryPesquisa);

  end;


except
raise Exception.Create('Erro ao tentar obter TITULO');

end;

 Result := tituloPagar;
end;

class function TTituloPagarDAO.obterPorNumeroDocumento(titulo: TTituloPagarModel): TTituloPagarModel;
var
qryPesquisa : TFDQuery;
tituloPagar: TTituloPagarModel;

begin
dmConexao.conectarBanco;
 qryPesquisa := TFDQuery.Create(nil);
 tituloPagar := TTituloPagarModel.Create;


try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_PAGAR  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND NUMERO_DOCUMENTO = :PDOC '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PDOC').AsString := titulo.FnumeroDocumento;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin


      tituloPagar := getTP(qryPesquisa);

  end;


except
raise Exception.Create('Erro ao tentar obter TITULO');

end;

 Result := tituloPagar;
end;

class function TTituloPagarDAO.obterRateioCC(titulo: TTituloPagarModel): TObjectList<TTituloPagarCentroCustoModel>;
var
qryPesquisa : TFDQuery;
centroCusto: TTituloPagarCentroCustoModel;
I :Integer;
 listaCC : TObjectList<TTituloPagarCentroCustoModel> ;
 cmd :string;

begin
  listaCC := TObjectList<TTituloPagarCentroCustoModel>.Create;
  listaCC.clear;

  dmConexao.conectarBanco;
try


    cmd := ' SELECT * FROM TITULO_PAGAR_RATEIO_CC TPH ' +
           ' WHERE (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TPH.ID_TITULO_PAGAR = :PIDTP)';

  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);


  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString  := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PIDTP').AsString           := titulo.FID;

  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
         qryPesquisa.First;

     while not qryPesquisa.Eof do begin

       centroCusto := TTituloPagarCentroCustoModel.Create;
       centroCusto.FID            := qryPesquisa.FieldByName('ID_TITULO_PAGAR_RATEIO_CC').AsString;
       centroCusto.FIDorganizacao := qryPesquisa.FieldByName('ID_ORGANIZACAO').AsString;
       centroCusto := TTituloPagarCentroCustoDAO.obterPorID(centroCusto);

        listaCC.Add(TTituloPagarCentroCustoModel.Create);

        I := listaCC.Count -1;

        listaCC[I].FID                := centroCusto.FID;
        listaCC[I].FIDorganizacao     := centroCusto.FIDorganizacao;
        listaCC[I].FIDCentroCusto     := centroCusto.FIDCentroCusto;
        listaCC[I].FIDTP              := centroCusto.FIDTP;
        listaCC[I].Fvalor             := centroCusto.Fvalor;

       qryPesquisa.Next;
     end;

  end;


except
raise Exception.Create('Erro ao tentar obter RATEIO CENTRO DE CUSTOS');

end;

 Result := listaCC;
end;

class function TTituloPagarDAO.obterRateioHistorico( titulo: TTituloPagarModel): TObjectList<TTituloPagarHistoricoModel>;
var
qryPesquisa : TFDQuery;
historico: TTituloPagarHistoricoModel;
I :Integer;
 listaHistorico : TObjectList<TTituloPagarHistoricoModel> ;
 cmd :string;

begin
  listaHistorico := TObjectList<TTituloPagarHistoricoModel>.Create;
  listaHistorico.clear;

  dmConexao.conectarBanco;
try

    cmd := ' SELECT * FROM TITULO_PAGAR_HISTORICO TPH ' +
           ' WHERE (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TPH.ID_TITULO_PAGAR = :PIDTP)';

  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString  := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PIDTP').AsString           := titulo.FID;

  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
         qryPesquisa.First;


     while not qryPesquisa.Eof do begin

       historico := TTituloPagarHistoricoModel.Create;
       historico.FID            := qryPesquisa.FieldByName('ID_TITULO_PAGAR_HISTORICO').AsString;
       historico.FIDorganizacao := qryPesquisa.FieldByName('ID_ORGANIZACAO').AsString;
       historico := TTituloPagarHistoricoDAO.obterPorID(historico);


        listaHistorico.Add(TTituloPagarHistoricoModel.Create);

        I := listaHistorico.Count -1;

        listaHistorico[I].FID                     := historico.FID;
        listaHistorico[I].FIDorganizacao          := historico.FIDorganizacao;
        listaHistorico[I].FIDContaContabilDebito  := historico.FIDContaContabilDebito;
        listaHistorico[I].FIDHistorico            := historico.FIDHistorico;
        listaHistorico[I].FIDTP                   := historico.FIDTP;
        listaHistorico[I].Fvalor                  := historico.Fvalor;
        listaHistorico[I].FHistorico              := historico.FHistorico;


       qryPesquisa.Next;
     end;

  end;


except
raise Exception.Create('Erro ao tentar obter RATEIO HISTORICO');

end;

 Result := listaHistorico
end;


class function TTituloPagarDAO.obterTodosFilhos( titulo: TTituloPagarModel): TFDQuery;
var
qryPesquisa : TFDQuery;
cmd :string;

begin
dmConexao.conectarBanco;
try
   cmd := 'SELECT *  FROM TITULO_PAGAR  WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND ID_TITULO_GERADOR = :PFILHO' ;


  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PFILHO').AsString := titulo.FID;

  qryPesquisa.Open;


except
raise Exception.Create('Erro ao tentar obter FILHOS por TP');

end;

 Result := qryPesquisa;
end;




class function TTituloPagarDAO.obterTodosPagar(pDataInicio, pDataFim :TDateTime; pIDorganizacao :string ) :  TObjectList<TTituloPagarModel>;
var
qryPesquisa : TFDQuery;
tituloPagar: TTituloPagarModel;
I :Integer;
 listaTP : TObjectList<TTituloPagarModel> ;
 cmd :string;

begin
  listaTP := TObjectList<TTituloPagarModel>.Create;
  listaTP.clear;
  dmConexao.conectarBanco;

try

    cmd := ' SELECT ID_TITULO_PAGAR, ID_ORGANIZACAO FROM TITULO_PAGAR '+
           ' WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)  '+
           ' AND (DATA_VENCIMENTO BETWEEN :pDTINICIO AND :pDTFINAL )' +
           ' AND (ID_TIPO_STATUS = ''ABERTO'') '+
          // ' AND (REGISTRO_PROVISAO IS NULL) '+ RETIRADO EM 20/03/20 PQ N SABE O MOTIVO DO CAMPO
           ' ORDER BY DATA_VENCIMENTO DESC ';



  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);


  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString  := pIDorganizacao;
  qryPesquisa.ParamByName('pDTINICIO').AsDateTime     := pDataInicio;
  qryPesquisa.ParamByName('pDTFINAL').AsDateTime      := pDataFim;

  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
         qryPesquisa.First;

     while not qryPesquisa.Eof do begin

       tituloPagar := TTituloPagarModel.Create;
       tituloPagar.FID            := qryPesquisa.FieldByName('ID_TITULO_PAGAR').AsString;
       tituloPagar.FIDorganizacao := qryPesquisa.FieldByName('ID_ORGANIZACAO').AsString;
       tituloPagar := TTituloPagarDAO.obterPorID(tituloPagar);


        listaTP.Add(TTituloPagarModel.Create);

        I := listaTP.Count -1;

        listaTP[I].FID              := tituloPagar.FID;
        listaTP[I].FIDorganizacao   := tituloPagar.FIDorganizacao;
        listaTP[I].FvalorNominal    := tituloPagar.FvalorNominal;
        listaTP[I].FIDCedente       := tituloPagar.FIDCedente;
        listaTP[I].FdataEmissao     := tituloPagar.FdataEmissao;
        listaTP[I].FnumeroDocumento := tituloPagar.FnumeroDocumento;
        listaTP[I].FdataVencimento  := tituloPagar.FdataVencimento;
        listaTP[I].Fdescricao       := tituloPagar.Fdescricao;
        listaTP[I].FIDHistorico     := tituloPagar.FIDHistorico;


       qryPesquisa.Next;
     end;

  end;


except
raise Exception.Create('Erro ao tentar obter TP EM ABERTO código: TPABT-01');

end;

 Result := listaTP
end;


class function TTituloPagarDAO.obterTodosPagarExport(pDataInicio, pDataFim :TDateTime; pIDorganizacao :string ) :  TObjectList<TTituloPagarModel>;
var
qryPesquisa : TFDQuery;
tituloPagar: TTituloPagarModel;
I :Integer;
 listaTP : TObjectList<TTituloPagarModel> ;
 cmd :string;

begin
  listaTP := TObjectList<TTituloPagarModel>.Create;
  listaTP.clear;
  dmConexao.conectarBanco;

try

    cmd := ' SELECT ID_TITULO_PAGAR, ID_ORGANIZACAO FROM TITULO_PAGAR '+
           ' WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)  '+
           ' AND (DATA_VENCIMENTO BETWEEN :pDTINICIO AND :pDTFINAL )' +
           ' AND (ID_TIPO_STATUS = ''ABERTO'') '+
           ' AND (REGISTRO_PROVISAO IS NULL) '+
           ' ORDER BY DATA_VENCIMENTO DESC ';



  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);


  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString  := pIDorganizacao;
  qryPesquisa.ParamByName('pDTINICIO').AsDateTime     := pDataInicio;
  qryPesquisa.ParamByName('pDTFINAL').AsDateTime      := pDataFim;

  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
         qryPesquisa.First;

     while not qryPesquisa.Eof do begin

       tituloPagar := TTituloPagarModel.Create;
       tituloPagar.FID            := qryPesquisa.FieldByName('ID_TITULO_PAGAR').AsString;
       tituloPagar.FIDorganizacao := qryPesquisa.FieldByName('ID_ORGANIZACAO').AsString;
       tituloPagar := TTituloPagarDAO.obterPorID(tituloPagar);


        listaTP.Add(TTituloPagarModel.Create);

        I := listaTP.Count -1;

        listaTP[I].FID              := tituloPagar.FID;
        listaTP[I].FIDorganizacao   := tituloPagar.FIDorganizacao;
        listaTP[I].FvalorNominal    := tituloPagar.FvalorNominal;
        listaTP[I].FIDCedente       := tituloPagar.FIDCedente;
        listaTP[I].FdataEmissao     := tituloPagar.FdataEmissao;
        listaTP[I].FnumeroDocumento := tituloPagar.FnumeroDocumento;
        listaTP[I].FdataVencimento  := tituloPagar.FdataVencimento;
        listaTP[I].Fdescricao       := tituloPagar.Fdescricao;
        listaTP[I].FIDHistorico     := tituloPagar.FIDHistorico;


       qryPesquisa.Next;
     end;

  end;


except
raise Exception.Create('Erro ao tentar obter TP EM ABERTO código: TPABT-01');

end;

 Result := listaTP
end;




class function TTituloPagarDAO.obterTodosPagarQry(pDataInicio, pDataFim: TDate; pIDorganizacao: string): TFDQuery;
  var
qryPesquisa : TFDQuery;
I :Integer;
 cmd :string;

begin
    dmConexao.conectarBanco;
    qryPesquisa := TFDQuery.Create(nil);

    //CONSULTA PARA MOSTRAR OS DADOS DOS TITULOS A PAGAR EM TELA. REQUER CONSULTA A OBJETO

try

    cmd := ' SELECT TP.ID_TITULO_PAGAR AS ID, '+
           ' TP.ID_ORGANIZACAO, '+
           ' TP.ID_CEDENTE, '+
           ' TP.ID_HISTORICO, '+
           ' TP.NUMERO_DOCUMENTO,'+
           ' TP.VALOR_NOMINAL, '+
           ' TP.DESCRICAO as DSC_TP, '+
           ' TP.DATA_VENCIMENTO, '+
           ' C.NOME as FORNECEDOR, '+
           ' H.DESCRICAO as DSC_HST '+
           ' FROM TITULO_PAGAR TP '+
           ' LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND (C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) '+
           ' LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO) AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) '+
           ' WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)  '+
           ' AND   (TP.ID_TIPO_STATUS = ''ABERTO'') '+
           ' AND   (TP.DATA_VENCIMENTO BETWEEN :pDTINICIO AND :pDTFINAL )' +
           ' ORDER BY TP.DATA_VENCIMENTO DESC ';


  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString  := pIDorganizacao;
  qryPesquisa.ParamByName('pDTINICIO').AsDateTime     := pDataInicio;
  qryPesquisa.ParamByName('pDTFINAL').AsDateTime      := pDataFim;

  qryPesquisa.Open;
except
raise Exception.Create('Erro ao tentar obter TP EM ABERTO código: TPABT-02 ');

end;

 Result := qryPesquisa;
end;

class function TTituloPagarDAO.obterTodosPagosPorLote( titulo: TTituloPagarModel): TFDQuery;
var
qryPesquisa : TFDQuery;
cmd :string;

begin
dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);

try
   cmd := ' SELECT TP.ID_TITULO_PAGAR,'+
          ' TP.NUMERO_DOCUMENTO, '+
          ' TP.valor_nominal,  '+
          ' TP.DESCRICAO,    '+
          ' TP.id_lote_pagamento,    '+
          ' C.nome,  C.id_cedente    '+
          ' FROM TITULO_PAGAR TP    '+
          ' LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND (C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) '+
          ' WHERE TP.ID_ORGANIZACAO = :PIDORGANIZACAO  AND TP.ID_LOTE_PAGAMENTO = :PIDLOTE ' +
          ' ORDER BY TP.VALOR_NOMINAL ' ;


  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PIDLOTE').AsString := titulo.FIDLotePagamento;


  qryPesquisa.Open;


except

raise Exception.Create('Erro ao tentar obter TITULO POR LOTE PAGTO');

end;

 Result := qryPesquisa;
end;


class function TTituloPagarDAO.obterTodosPorStatus( titulo: TTituloPagarModel): TFDQuery;
var
qryPesquisa : TFDQuery;
cmd :string;

begin
dmConexao.conectarBanco;
try
   cmd := 'SELECT *  FROM TITULO_PAGAR  WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND ID_TIPO_STATUS = :PSTATUS ' ;


  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PSTATUS').AsString := titulo.FIDTipoStatus;


   if titulo.FIDTipoStatus.Equals('QUITADO') then begin

   cmd := 'SELECT *  FROM TITULO_PAGAR  WHERE ID_ORGANIZACAO = :PIDORGANIZACAO '+
          ' AND ID_LOTE_CONTABIL IS NULL '+
        // SABER PQ ESSA DATA  ' AND DATA_PAGAMENTO > ''01.01.2019'' '+
          ' AND ID_TIPO_STATUS IN (''QUITADO'', ''PARCIAL'')' ;

      qryPesquisa := TFDQuery.Create(nil);
      qryPesquisa.Close;
      qryPesquisa.Connection := dmConexao.conn;
      qryPesquisa.SQL.Clear;
      qryPesquisa.SQL.Add(cmd);
      qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;

   end;


   if titulo.FIDTipoStatus.Equals('TODOS') then begin

   cmd := 'SELECT *  FROM TITULO_PAGAR  WHERE ID_ORGANIZACAO = :PIDORGANIZACAO '+
          ' AND ID_LOTE_CONTABIL IS NULL '+
          ' AND ID_TIPO_STATUS <> ''EXCLUIDO'' ';

      qryPesquisa := TFDQuery.Create(nil);
      qryPesquisa.Close;
      qryPesquisa.Connection := dmConexao.conn;
      qryPesquisa.SQL.Clear;
      qryPesquisa.SQL.Add(cmd);
      qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;

   end;





  qryPesquisa.Open;
  qryPesquisa.Last;


except
raise Exception.Create('Erro ao tentar obter TITULO POR STATUS');

end;

 Result := qryPesquisa;
end;


class function TTituloPagarDAO.particionar(tituloNovo,  tituloAntigo: TTituloPagarModel): Boolean;
begin
   Result := System.False;
  try
    dmConexao.conn.StartTransaction;

    if Update(tituloAntigo) then
    begin
      Insert(tituloNovo);
    end;

    dmConexao.conn.CommitRetaining;

  except
    dmConexao.conn.RollbackRetaining;
    raise Exception.Create('Erro ao tentar particionar o TP ' + tituloAntigo.FnumeroDocumento);

  end;

  Result := System.True;

end;

class function TTituloPagarDAO.Update(titulo: TTituloPagarModel): Boolean;
var
qryUpdate : TFDQuery;
cmdSql :string;
sucesso :Boolean;
I :Integer;
rateioHst : TTituloPagarHistoricoModel;
rateioCC : TTituloPagarCentroCustoModel;

begin
sucesso := true;
dmConexao.conectarBanco;
qryUpdate := TFDQuery.Create(nil);

  try
    try


   cmdSql := ' UPDATE TITULO_PAGAR '+
            ' SET ID_HISTORICO                = :PIDHISTORICO, '+
            ' ID_CEDENTE                      = :PIDCEDENTE, '+
            ' ID_TIPO_COBRANCA                = :PIDTIPO_COBRANCA, '+
            ' ID_RESPONSAVEL                  = :PIDRESPONSAVEL, '+
            ' ID_LOCAL_PAGAMENTO              = :PIDLOCAL_PAGAMENTO,'+
            ' ID_TIPO_STATUS                  = :PIDTIPO_STATUS, '+
            ' ID_CENTRO_CUSTO                 = :PIDCENTRO_CUSTO,'+
            ' ID_TITULO_GERADOR               = :PIDTITULO_GERADOR,'+
            ' ID_NOTA_FISCAL_ENTRADA          = :PIDNOTA_FISCAL_ENTRADA,'+
            ' NUMERO_DOCUMENTO                = :PNUMERO_DOCUMENTO, '+
            ' DESCRICAO                       = :PDESCRICAO, '+
            ' DATA_REGISTRO                   = :PDATA_REGISTRO, '+
            ' DATA_EMISSAO                    = :PDATA_EMISSAO, '+
            ' DATA_PROTOCOLO                  = :PDATA_PROTOCOLO,'+
            ' DATA_VENCIMENTO                 = :PDATA_VENCIMENTO,'+
            ' DATA_PAGAMENTO                  = :PDATA_PAGAMENTO,'+
            ' PREVISAO_CARTORIO               = :PPREVISAO_CARTORIO,'+
            ' DATA_ULTIMA_ATUALIZACAO         = :PDATA_ULTIMA_ATUALIZACAO,'+
            ' VALOR_NOMINAL                   = :PVALOR_NOMINAL, '+
            ' MOEDA                           = :PMOEDA, '+
            ' CARTEIRA                        = :PCARTEIRA, '+
            ' CODIGO_BARRAS                   = :PCODIGO_BARRAS, '+
            ' CONTRATO                        = :PCONTRATO, '+
            ' PARCELA                         = :PPARCELA, '+
            ' OBSERVACAO                      = :POBSERVACAO, '+
            ' VALOR_ANTECIPADO                = :PVALOR_ANTECIPADO, '+
            ' ID_LOTE_CONTABIL                = :PIDLOTE_CONTABIL, '+
            ' ID_USUARIO                      = :PIDUSUARIO, '+
            ' ID_LOTE_PAGAMENTO               = :PIDLOTE_PAGAMENTO, '+
            ' ID_CONTA_BANCARIA_CHEQUE        = :PIDCONTA_BANCARIA_CHEQUE, '+
            ' ID_CONTA_CONTABIL_CREDITO       = :PIDCONTA_CONTABIL_CREDITO, '+
            ' ID_CONTA_CONTABIL_DEBITO        = :PIDCONTA_CONTABIL_DEBITO, '+
            ' REGISTRO_PROVISAO               = :PREGISTRO_PROVISAO, '+
            ' REGISTRO_LOTE_DELETADO          = :PREGISTRO_LOTE, '+

            ' IS_PROVISAO                     = :PIS_PROVISAO, '+
            ' ID_LOTE_TPB                     = :PIDLOTE_TPB '+

         ' WHERE (ID_TITULO_PAGAR = :PID ) AND (ID_ORGANIZACAO = :PIDORGANIZACAO ) ' ;



    qryUpdate.Close;
    qryUpdate.Connection := dmConexao.conn;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(cmdSql);
    qryUpdate.ParamByName('PIS_PROVISAO').AsInteger               := titulo.FisProvisao;
    qryUpdate.ParamByName('PID').AsString                         := titulo.FID;
    qryUpdate.ParamByName('PIDORGANIZACAO').AsString              := titulo.FIDorganizacao;
    qryUpdate.ParamByName('PIDUSUARIO').AsString                  := titulo.FIDUsuario;
    qryUpdate.ParamByName('PIDRESPONSAVEL').AsString              := titulo.FIDResponsavel;
    qryUpdate.ParamByName('PIDLOTE_CONTABIL').AsString            := titulo.FIDLoteContabil;
    qryUpdate.ParamByName('PIDHISTORICO').AsString                := titulo.FIDHistorico;
    qryUpdate.ParamByName('PIDCEDENTE').AsString                  := titulo.FIDCedente;
    qryUpdate.ParamByName('PIDLOTE_TPB').AsString                 := titulo.FIDLoteTPB;
    qryUpdate.ParamByName('PIDTIPO_COBRANCA').AsString            := titulo.FIDTipoCobranca;
    qryUpdate.ParamByName('PIDLOCAL_PAGAMENTO').AsString          := titulo.FIDLocalPagamento;
    qryUpdate.ParamByName('PIDTIPO_STATUS').AsString              := titulo.FIDTipoStatus;
    qryUpdate.ParamByName('PIDCENTRO_CUSTO').AsString             := titulo.FIDCentroCusto;
    qryUpdate.ParamByName('PIDNOTA_FISCAL_ENTRADA').AsString      := titulo.FIDNotaFiscalEntrada;
    qryUpdate.ParamByName('PIDTITULO_GERADOR').AsString           := titulo.FIDTituloPagarAnterior;
    qryUpdate.ParamByName('PIDLOTE_PAGAMENTO').AsString           := titulo.FIDLotePagamento;
    qryUpdate.ParamByName('PIDCONTA_CONTABIL_DEBITO').AsString    := titulo.FIDContaContabilDebito;
    qryUpdate.ParamByName('PIDCONTA_CONTABIL_CREDITO').AsString   := titulo.FIDContaContabilCredito;
    qryUpdate.ParamByName('PIDCONTA_BANCARIA_CHEQUE').AsString    := titulo.FIDCBChequeVinculado;

    qryUpdate.ParamByName('PDESCRICAO').AsString                  := uppercase(titulo.Fdescricao);
    qryUpdate.ParamByName('POBSERVACAO').AsString                 := titulo.Fobservacao;
    qryUpdate.ParamByName('PPARCELA').AsString                    := titulo.Fparcela;
    qryUpdate.ParamByName('PCONTRATO').AsString                   := titulo.Fcontrato;
    qryUpdate.ParamByName('PCODIGO_BARRAS').AsString              := titulo.FcodigoBarras;
    qryUpdate.ParamByName('PCARTEIRA').AsString                   := titulo.Fcarteira;
    qryUpdate.ParamByName('PMOEDA').AsString                      := titulo.Fmoeda;
    qryUpdate.ParamByName('PREGISTRO_PROVISAO').AsString          := titulo.FregistroProvisao;
    qryUpdate.ParamByName('PREGISTRO_LOTE').AsString              := titulo.FregistroLoteDeletado;

    qryUpdate.ParamByName('PNUMERO_DOCUMENTO').AsString           := titulo.FnumeroDocumento;

    qryUpdate.ParamByName('PDATA_REGISTRO').AsDateTime            := titulo.FdataRegistro;
    qryUpdate.ParamByName('PDATA_ULTIMA_ATUALIZACAO').AsDateTime  := titulo.FdataUltimaAtualizacao;
    qryUpdate.ParamByName('PPREVISAO_CARTORIO').AsDateTime        := titulo.FprevisaoCartorio;

    qryUpdate.ParamByName('PDATA_PAGAMENTO').AsDateTime           := titulo.FdataPagamento;

    qryUpdate.ParamByName('PDATA_VENCIMENTO').AsDateTime          := titulo.FdataVencimento;
    qryUpdate.ParamByName('PDATA_PROTOCOLO').AsDateTime           := titulo.FdataProtocolo;
    qryUpdate.ParamByName('PDATA_EMISSAO').AsDateTime             := titulo.FdataEmissao;

    qryUpdate.ParamByName('PVALOR_NOMINAL').AsCurrency            := titulo.FvalorNominal;
    qryUpdate.ParamByName('PVALOR_ANTECIPADO').AsCurrency         := titulo.FvalorAntecipado;

    if uUtil.Empty(titulo.FIDContaContabilDebito) then
    begin
      qryUpdate.ParamByName('PIDCONTA_CONTABIL_DEBITO').Value := null;
     end;
    if uUtil.Empty(titulo.FIDContaContabilCredito) then
    begin
      qryUpdate.ParamByName('PIDCONTA_CONTABIL_CREDITO').Value := null;
     end;
    if uUtil.Empty(titulo.FIDTituloPagarAnterior) then
    begin
      qryUpdate.ParamByName('PIDTITULO_GERADOR').Value := null;
     end;
    if uUtil.Empty(titulo.FIDNotaFiscalEntrada) then
    begin
      qryUpdate.ParamByName('PIDNOTA_FISCAL_ENTRADA').Value := null;
     end;
    if uUtil.Empty(titulo.FIDLoteContabil) then
    begin
      qryUpdate.ParamByName('PIDLOTE_CONTABIL').Value := null;
     end;
    if uUtil.Empty(titulo.FIDLoteTPB) then
    begin
      qryUpdate.ParamByName('PIDLOTE_TPB').Value := null;
    end;
    if uUtil.Empty(titulo.FIDLotePagamento) then
    begin
      qryUpdate.ParamByName('PIDLOTE_PAGAMENTO').Value := null;
    end;

    if uUtil.Empty(titulo.FIDCBChequeVinculado) then
    begin
      qryUpdate.ParamByName('PIDCONTA_BANCARIA_CHEQUE').Value := null;
    end;

    if uUtil.Empty(titulo.FregistroProvisao) then
    begin
      qryUpdate.ParamByName('PREGISTRO_PROVISAO').Value := null;
    end;

    if uUtil.Empty(titulo.FregistroLoteDeletado) then
    begin
      qryUpdate.ParamByName('PREGISTRO_LOTE').Value := null;
    end;

    if titulo.FdataEmissao < IncMonth(Now, -24) then //nao pode ser menor que o ano
    begin
    qryUpdate.ParamByName('PDATA_EMISSAO').AsDateTime          := Now;
    end;

     if titulo.FdataRegistro < titulo.FdataEmissao  then
    begin
     qryUpdate.ParamByName('PDATA_REGISTRO').AsDateTime  := Now;
    end;


    if titulo.FvalorAntecipado = 0 then begin
      qryUpdate.ParamByName('PVALOR_ANTECIPADO').AsCurrency         := 0;
    end;

    if uUtil.Empty(titulo.Fcarteira) then
    begin
      qryUpdate.ParamByName('PCARTEIRA').Value := null;
    end;

    if uUtil.Empty(titulo.Fcontrato) then
    begin
      qryUpdate.ParamByName('PCONTRATO').Value := null;
    end;

    if uUtil.Empty(titulo.FcodigoBarras) then
    begin
      qryUpdate.ParamByName('PCODIGO_BARRAS').Value := null;
    end;

    if uUtil.Empty(titulo.Fobservacao) then
    begin
      qryUpdate.ParamByName('POBSERVACAO').Value := null;
    end;


    if titulo.FdataUltimaAtualizacao < titulo.FdataRegistro  then
    begin
    qryUpdate.ParamByName('PDATA_ULTIMA_ATUALIZACAO').AsDateTime  := Now;
    end;

    {//suspenso em 080520 devido a erro em titulo sem data pagto
    if titulo.FdataPagamento < titulo.FdataEmissao then
    begin
    qryUpdate.ParamByName('PDATA_PAGAMENTO').Value    := null;
    end;  }

    if titulo.FIDTipoStatus.Equals('ABERTO') then
    begin
    qryUpdate.ParamByName('PDATA_PAGAMENTO').Value    := null;
    end;

    if titulo.FdataProtocolo < titulo.FdataEmissao then
    begin
    qryUpdate.ParamByName('PDATA_PROTOCOLO').AsDateTime          := Now;
    end;


    qryUpdate.ExecSQL;

    if qryUpdate.RowsAffected > 0 then
    begin
      sucesso := True;
     // dmConexao.conn.CommitRetaining;
    end;

     //rateio de CENTRO CUSTOS
      rateioCC := TTituloPagarCentroCustoModel.Create;
      rateioCC.FIDorganizacao := titulo.FIDorganizacao;
      rateioCC.FIDTP := titulo.FID;

       //deletar os que já existem vinculados AO TP
      rateioHst := TTituloPagarHistoricoModel.Create;
      rateioHst.FIDorganizacao := titulo.FIDorganizacao;
      rateioHst.FIDTP := titulo.FID;

    if titulo.FIDTipoStatus.Equals('EXCLUIDO') then begin
        //rateio de CENTRO CUSTOS
       TTituloPagarHistoricoDAO.DeletePorIDTP(rateioHst);
       TTituloPagarCentroCustoDAO.DeletePorIDTP(rateioCC);
       qryUpdate.ParamByName('PDATA_PAGAMENTO').Value    := null;

       end;


     if not titulo.FIDTipoStatus.Equals('EXCLUIDO') then begin
    //checagem das listas
      if titulo.listaHistorico.Count < 1 then begin
            sucesso := False;
            raise Exception.Create('Erro ao tentar inserir o rateio de historico: lista rateio historico vazia');

        end;

        if titulo.listaCustos.Count < 1 then begin
            sucesso := False;
            raise Exception.Create('Erro ao tentar inserir o rateio de custos: lista rateio centro custos vazia');

        end;

        if TTituloPagarHistoricoDAO.DeletePorIDTP(rateioHst) then
        begin

          //insere os novos rateios

          for I := 0 to titulo.listaHistorico.Count - 1 do
          begin

            TTituloPagarHistoricoDAO.Insert(titulo.listaHistorico[I]);

          end;

        end;

        if TTituloPagarCentroCustoDAO.DeletePorIDTP(rateioCC) then
        begin
          for I := 0 to titulo.listaCustos.Count - 1 do
          begin
              sucesso := TTituloPagarCentroCustoDAO.Insert(titulo.listaCustos[I]);
          end;
        end;

    //nota fiscal. o form atualza o objeto
        if not uUtil.Empty(titulo.FIDNotaFiscalEntrada) then
        begin
    //salvar nota fiscal
          if not titulo.FNotaFiscalEntrada.Fnovo then
          begin //já existe
            sucesso := TNotaFiscalEntradaDAO.Update(titulo.FNotaFiscalEntrada);
          end
          else
          begin
            sucesso := TNotaFiscalEntradaDAO.Insert(titulo.FNotaFiscalEntrada);
          end;
        end;


    end;
    Result := sucesso;

  except
    dmConexao.conn.RollbackRetaining;
    Result :=System.False;
    raise Exception.Create('Não foi possível salvar a baixa do título ' + titulo.FnumeroDocumento);

  end;
  finally
    if Assigned(qryUpdate) then
    begin
      FreeAndNil(qryUpdate);
    end;
  end;


end;


//verifica se tem TP com tituo_gerador. indica que foi particionado ou pagto parcial

class function TTituloPagarDAO.existFilhos(titulo: TTituloPagarModel): Boolean;
var
qryPesquisa : TFDQuery;
cmd :string;

begin
Result := False;


dmConexao.conectarBanco;
try
   cmd := 'SELECT  ID_TITULO_PAGAR  FROM TITULO_PAGAR  WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND ID_TITULO_GERADOR = :PFILHO' ;


  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PFILHO').AsString := titulo.FID;

  qryPesquisa.Open;


except
raise Exception.Create('Erro ao tentar consultar o filho do TP');

end;

 Result := not qryPesquisa.IsEmpty;

end;


class function TTituloPagarDAO.getTP(query: TFDQuery): TTituloPagarModel;
var
tituloPagar     : TTituloPagarModel;
cedente         : TCedenteModel;
loteContabil    : TLoteContabilModel;
lotePagto       : TLotePagamentoModel;
historico       : THistoricoModel;
centroCusto     : TCentroCustoModel;
responsavel     : TFuncionarioModel;
status          : TTipoStatusModel;
notafiscal      : TNotaFiscalEntradaModel;

begin
  tituloPagar     := TTituloPagarModel.Create;
  cedente         := TCedenteModel.Create;
  loteContabil    := TLoteContabilModel.Create ;
  lotePagto       := TLotePagamentoModel.Create ;
  historico       := THistoricoModel.Create ;
  centroCusto     := TCentroCustoModel.Create ;
  responsavel     := TFuncionarioModel.Create ;
  status          := TTipoStatusModel.Create;
  notafiscal      := TNotaFiscalEntradaModel.Create;

  tituloPagar.listaHistorico := TObjectList<TTituloPagarHistoricoModel>.Create;
  tituloPagar.listaCustos := TObjectList<TTituloPagarCentroCustoModel>.Create;


  if not query.IsEmpty then begin

      tituloPagar.FID                     := query.FieldByName('ID_TITULO_PAGAR').AsString;
      tituloPagar.FIDorganizacao          := query.FieldByName('ID_ORGANIZACAO').AsString;
      tituloPagar.FIDusuario              := query.FieldByName('ID_USUARIO').AsString;
      tituloPagar.FIDResponsavel          := query.FieldByName('ID_RESPONSAVEL').AsString;
      tituloPagar.FIDloteContabil         := query.FieldByName('ID_LOTE_CONTABIL').AsString;
      tituloPagar.FIDLoteTPB              := query.FieldByName('ID_LOTE_TPB').AsString;
      tituloPagar.FIDHistorico            := query.FieldByName('ID_HISTORICO').AsString;
      tituloPagar.FIDCedente              := query.FieldByName('ID_CEDENTE').AsString;
      tituloPagar.FIDTipoCobranca         := query.FieldByName('ID_TIPO_COBRANCA').AsString;
      tituloPagar.FIDLocalPagamento       := query.FieldByName('ID_LOCAL_PAGAMENTO').AsString;
      tituloPagar.FIDTipoStatus           := query.FieldByName('ID_TIPO_STATUS').AsString;
      tituloPagar.FIDCentroCusto          := query.FieldByName('ID_CENTRO_CUSTO').AsString;
      tituloPagar.FIDNotaFiscalEntrada    := query.FieldByName('ID_NOTA_FISCAL_ENTRADA').AsString;
      tituloPagar.FIDTituloPagarAnterior  := query.FieldByName('ID_TITULO_GERADOR').AsString;
      tituloPagar.FIDLotePagamento        := query.FieldByName('ID_LOTE_PAGAMENTO').AsString;
      tituloPagar.FIDContaContabilDebito  := query.FieldByName('ID_CONTA_CONTABIL_DEBITO').AsString;
      tituloPagar.FIDContaContabilCredito := query.FieldByName('ID_CONTA_CONTABIL_CREDITO').AsString;
      tituloPagar.FIDCBChequeVinculado    := query.FieldByName('ID_CONTA_BANCARIA_CHEQUE').AsString;
      tituloPagar.Fdescricao              := UpperCase(query.FieldByName('DESCRICAO').AsString);
      tituloPagar.Fobservacao             := query.FieldByName('OBSERVACAO').AsString;
      tituloPagar.Fparcela                := query.FieldByName('PARCELA').AsString;
      tituloPagar.Fcontrato               := query.FieldByName('CONTRATO').AsString;
      tituloPagar.FcodigoBarras           := query.FieldByName('CODIGO_BARRAS').AsString;
      tituloPagar.Fcarteira               := query.FieldByName('CARTEIRA').AsString;
      tituloPagar.Fmoeda                  := query.FieldByName('MOEDA').AsString;
      tituloPagar.FregistroProvisao       := query.FieldByName('REGISTRO_PROVISAO').AsString;
      tituloPagar.FregistroLoteDeletado   := query.FieldByName('REGISTRO_LOTE_DELETADO').AsString;
      tituloPagar.FnumeroDocumento        := query.FieldByName('NUMERO_DOCUMENTO').AsString;

      tituloPagar.FdataRegistro           := query.FieldByName('DATA_REGISTRO').AsDateTime;
      tituloPagar.FdataUltimaAtualizacao  := query.FieldByName('DATA_ULTIMA_ATUALIZACAO').AsDateTime;
      tituloPagar.FprevisaoCartorio       := query.FieldByName('PREVISAO_CARTORIO').AsDateTime;
      tituloPagar.FdataPagamento          := query.FieldByName('DATA_PAGAMENTO').AsDateTime;
      tituloPagar.FdataVencimento         := query.FieldByName('DATA_VENCIMENTO').AsDateTime;
      tituloPagar.FdataProtocolo          := query.FieldByName('DATA_PROTOCOLO').AsDateTime;
      tituloPagar.FdataEmissao            := query.FieldByName('DATA_EMISSAO').AsDateTime;

      tituloPagar.FvalorNominal           := query.FieldByName('VALOR_NOMINAL').AsCurrency;
      tituloPagar.FvalorAntecipado        := query.FieldByName('VALOR_ANTECIPADO').AsCurrency;
      tituloPagar.Fnovo                   := False;
      tituloPagar.FisProvisao             := query.FieldByName('IS_PROVISAO').AsInteger;

    try

      cedente.FID            := tituloPagar.FIDCedente;
      cedente.FIDorganizacao := tituloPagar.FIDorganizacao;
      tituloPagar.FCedente   := TCedenteDAO.obterPorID(cedente);


      tituloPagar.listaHistorico.Clear;
      tituloPagar.listaHistorico := obterRateioHistorico(tituloPagar);

      tituloPagar.listaCustos.Clear;
      tituloPagar.listaCustos := obterRateioCC(tituloPagar);


      lotePagto.FID               := tituloPagar.FIDLotePagamento;
      lotePagto.FIDorganizacao    := tituloPagar.FIDorganizacao;
      tituloPagar.FLotePagamento  := TLotePagamentoDAO.obterPorID(lotePagto);


      loteContabil.FID            := tituloPagar.FIDLoteContabil;
      loteContabil.FIDorganizacao := tituloPagar.FIDorganizacao;
      tituloPagar.FLoteContabil   := TLoteContabilDAO.obterPorID(loteContabil);

      if uutil.Empty(loteContabil.FID) then begin
        if not uutil.Empty(tituloPagar.FIDLoteTPB) then begin

          loteContabil.FID            := tituloPagar.FIDLoteTPB;
          loteContabil.FIDorganizacao := tituloPagar.FIDorganizacao;
          tituloPagar.FLoteContabil   := TLoteContabilDAO.obterPorID(loteContabil);

        end;

      end;


      historico.FID               := tituloPagar.FIDHistorico;
      historico.FIdOrganizacao    := tituloPagar.FIDorganizacao;
      tituloPagar.FHistorico      := THistoricoDAO.obterPorID(historico);

      centroCusto.FID             := tituloPagar.FIDCentroCusto;
      centroCusto.FIdOrganizacao  := tituloPagar.FIDorganizacao;
      tituloPagar.FCentroCustos   := TCentroCustoDAO.obterPorID(centroCusto);


      responsavel.FID             := tituloPagar.FIDResponsavel;
      responsavel.FIdOrganizacao  := tituloPagar.FIDorganizacao;
      tituloPagar.FResponsavel    := TFuncionarioDAO.obterPorID(responsavel);

      status.FID                  := tituloPagar.FIDTipoStatus;
      status.FIdOrganizacao       := tituloPagar.FIDorganizacao;
      tituloPagar.FTipoStatus     := TTipoStatusDAO.obterPorID(status);

      notafiscal.FID              := tituloPagar.FIDNotaFiscalEntrada;
      notafiscal.FIDorganizacao   := tituloPagar.FIDorganizacao;
      tituloPagar.FNotaFiscalEntrada := TNotaFiscalEntradaDAO.obterPorID(notafiscal);



    except
      raise Exception.Create('Erro ao tentar obter detalhes por TP.');

    end;



  end;


  Result := tituloPagar;

end;


class function TTituloPagarDAO.registroMD(value: TTituloPagarModel; pAcao, pDsc,pStatus: string): Boolean;
var
md :TMDModel;
org : TOrganizacaoModel;
begin
  org := TOrganizacaoModel.Create;
  org.FID := value.FIDorganizacao;
  org :=  TOrganizacaoDAO.obterPorID(org);

   md                   := TMDModel.Create;
   md.FID               := dmConexao.obterNewID;
   md.FIDorganizacao    := uUtil.TOrgAtual.getId;
   md.FIDusuario        := uutil.TUserAtual.userID;
   md.FdataRegistro     := uutil.getDataServer;
   md.FvalorOperacao    := value.FvalorNominal;
   md.FnumeroMovimento  := StrToInt(dmConexao.obterIdentificador('',md.FIDorganizacao,'MD'));
   md.Fcodigo           := value.FnumeroDocumento;
   md.Facao             := pAcao;
   md.Fobjeto           := pTable;
   md.Fdescricao        := pDsc;
   md.Fstatus           := pStatus;
   md.Festacao          := uutil.GetComputerNetName;
   md.FipEstacao        := uUtil.GetIp;
   md.Fserver           := org.FNAMESERVERBD  + ' IP ' + org.FIPSERVERBD;

   TMDDAO.Insert(md);

end;

end.
