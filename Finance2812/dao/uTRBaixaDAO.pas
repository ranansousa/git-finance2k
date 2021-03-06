unit uTRBaixaDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, MDDAO,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,  uOrganizacaoDAO, uOrganizacaoModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,  uTRBaixaModel, uTRBaixaInternetModel, uTRBaixaInternetDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uTituloReceberModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,uTRBaixaChequeModel, uContaBancariaChequeModel, uContaBancariaChequeDAO,
  System.Generics.Collections, uTRBaixaFPModel, uTRBaixaFPDAO, uTRBaixaChequeDAO,uContaBancariaCRModel, uContaBancariaCreditoDAO,
  uTituloReceberDAO, uTRBaixaDEDAO, uTRBaixaDEModel, uTRBaixaACModel,uTRBaixaACDAO, uTesourariaCRModel, uTesourariaCRDAO,
  uTituloReceberHistoricoModel, uTituloReceberCentroCustoModel,   uTituloReceberHistoricoDAO, uTituloReceberCentroCustoDAO  ;


  const
   pTable : string = 'TITULO_RECEBER_BAIXA';

type
 TTRBaixaDAO = class
  private
    class function getModel (query :TFDQuery) : TTRBaixaModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}

    class function Insert(value :TTRBaixaModel): Boolean;
    class function obterPorTR(value :TTRBaixaModel): TTRBaixaModel;
    class function obterPorID (value :TTRBaixaModel): TTRBaixaModel;
    class function Delete(value :TTRBaixaModel): Boolean;
    class function salvarBaixa (baixa :TTRBaixaModel; titulo : TTituloReceberModel ): Boolean;
//    class function cancelarBaixa (baixa :TTRBaixaModel; titulo : TTituloReceberModel ): Boolean;



  end;

implementation

{ TTRBaixaDAO }

class function TTRBaixaDAO.Delete(value: TTRBaixaModel): Boolean;
var
qryDelete : TFDQuery;
sucesso :Boolean;
begin
sucesso := False;
 dmConexao.conectarBanco;
 qryDelete := TFDQuery.Create(nil);

  try
    try

      qryDelete.Close;
      qryDelete.Connection := dmConexao.conn;
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add(' DELETE FROM TITULO_RECEBER_BAIXA  ');
      qryDelete.SQL.Add(' WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_RECEBER_BAIXA = :PID ');
      qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qryDelete.ParamByName('PID').AsString := value.FID;

      qryDelete.ExecSQL;


      if qryDelete.RowsAffected > 0 then
      begin
        dmConexao.conn.CommitRetaining;

        TMDDAO.registroMD(value.FIDorganizacao, pTable, 'DEL TR', 'DELETE BX TR '+ value.FTituloReceber.FnumeroDocumento + ' ' + value.FTituloReceber.Fdescricao,'DELETADO');


        sucesso := True;
      end;



    except
      sucesso := False;
      dmConexao.conn.RollbackRetaining;
      raise Exception.Create('Erro ao tentar DELETAR TITULO Pago');

    end;

    Result := sucesso;
  finally
    if Assigned(qryDelete) then
    begin
      FreeAndNil(qryDelete);
    end;
  end;
end;



class function TTRBaixaDAO.Insert(value: TTRBaixaModel): Boolean;
var
qryInsert : TFDQuery;
cmdSql :string;
sucesso : Boolean;
begin
 sucesso := False;

  dmConexao.conectarBanco;
  qryInsert := TFDQuery.Create(nil); // rever

  try

   cmdSql := ' INSERT INTO TITULO_RECEBER_BAIXA '+
           ' (ID_TITULO_RECEBER_BAIXA, ID_ORGANIZACAO, ID_TITULO_RECEBER,'+
           ' ID_CENTRO_CUSTO, ID_USUARIO, ID_RESPONSAVEL, '+
           ' VALOR_PAGO, DATA_REGISTRO, TIPO_BAIXA ) ' +
           ' VALUES (:PID,:PIDORGANIZACAO,:PIDTITULO_RECEBER, '+
           ' :PIDCENTRO_CUSTO, :PIDUSUARIO, :PIDRESPONSAVEL, '+
           ' :PVALOR_PAGO,:PDATA_REGISTRO, :PTIPO_BAIXA )';

    qryInsert.Close;
    qryInsert.Connection := dmConexao.conn;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(cmdSql);
    qryInsert.ParamByName('PID').AsString                         := value.FID;
    qryInsert.ParamByName('PIDTITULO_RECEBER').AsString           := value.FIDtituloReceber;
    qryInsert.ParamByName('PIDORGANIZACAO').AsString              := value.FIDorganizacao;
    qryInsert.ParamByName('PIDUSUARIO').AsInteger                 := value.FIDUsuario;
    qryInsert.ParamByName('PIDRESPONSAVEL').AsString              := value.FIDResponsavel;
    qryInsert.ParamByName('PIDCENTRO_CUSTO').AsString             := value.FIDCentroCusto;
    qryInsert.ParamByName('PTIPO_BAIXA').AsString                 := value.FtipoBaixa;
    qryInsert.ParamByName('PDATA_REGISTRO').AsDateTime            := Now;
    qryInsert.ParamByName('PVALOR_PAGO').AsCurrency               := value.FvalorPago;
    if uUtil.Empty(value.FIDtituloReceber) then
    begin
      qryInsert.ParamByName('PIDTITULO_RECEBER').AsString := value.FTituloReceber.FID;
    end;

    qryInsert.ExecSQL;

    if qryInsert.RowsAffected > 0 then
    begin
     TMDDAO.registroMD(value.FIDorganizacao, pTable,'BAIXA TR', 'Baixa do TR '+ value.FTituloReceber.FnumeroDocumento + ' ' + value.FTituloReceber.Fdescricao,'PAGO');
      sucesso := True;
    end;

    Result := sucesso;

  finally
    if Assigned(qryInsert) then
    begin
      FreeAndNil(qryInsert);
    end;
  end;

end;

class function TTRBaixaDAO.obterPorID(value: TTRBaixaModel): TTRBaixaModel;
var
qryPesquisa : TFDQuery;
tpb: TTRBaixaModel;
begin
dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
tpb := TTRBaixaModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_RECEBER_BAIXA  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_RECEBER_BAIXA = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
      tpb := getModel(qryPesquisa);
  end;


except
raise Exception.Create('Erro ao tentar obter TITULO RCBDO ID');

end;

 Result := tpb;
end;


class function TTRBaixaDAO.obterPorTR(value: TTRBaixaModel): TTRBaixaModel;
var
qryPesquisa : TFDQuery;
tpb: TTRBaixaModel;
begin
  dmConexao.conectarBanco;
 qryPesquisa := TFDQuery.Create(nil);
 tpb         := TTRBaixaModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_RECEBER_BAIXA  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_RECEBER = :PIDTR '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PIDTR').AsString := value.FIDtituloReceber;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      tpb := getModel(qryPesquisa);
  end;

except
raise Exception.Create('Erro ao tentar obter TITULO RCBDO IDTR');

end;

 Result := tpb;
end;


class function TTRBaixaDAO.salvarBaixa(baixa: TTRBaixaModel; titulo: TTituloReceberModel): Boolean;
var
  formaPagto    : TTRBaixaFPModel;
  acrescimo     : TTRBaixaACModel;
  deducao       : TTRBaixaDEModel;
  pagtoCheque   : TTRBaixaChequeModel;
  pagtoWWW      : TTRBaixaInternetModel;
  cheque        : TContaBancariaChequeModel;
  contaBancoCR  : TContaBancariaCRModel;
  debitoCaixa   : TTesourariaCRModel;

 A,D,FP : Integer;
listaHistorico :  TObjectList<TTituloReceberHistoricoModel>;
listaCustos    :  TObjectList<TTituloReceberCentroCustoModel>;
historico : TTituloReceberHistoricoModel  ;
centroCusto : TTituloReceberCentroCustoModel;
 qtdRateioC, qtdRateioH, I :Integer;
 valorNominal, valorAntecipado :Currency;

sucesso : Boolean;
begin
 sucesso := False;

  qtdRateioH :=0;
  qtdRateioC  :=0;
  I:=0;
  valorNominal     := titulo.FvalorNominal ;
  dmConexao.conectarBanco;

  if not dmConexao.conn.InTransaction then
    dmConexao.conn.StartTransaction;

  try
     //TRBAIXA
    if Insert(baixa) then begin
         //inserido os acrescimos
         for A := 0 to baixa.listaAcrescimo.Count -1 do begin
             acrescimo     := TTRBaixaACModel.Create;
             acrescimo     := baixa.listaAcrescimo[A];
             TTRBaixaACDAO.Insert(acrescimo);
         end;

               //inserido as deducoes
         for D := 0 to baixa.listaDeducao.Count -1 do begin
             deducao     := TTRBaixaDEModel.Create;
             deducao     := baixa.listaDeducao[D];
             TTRBaixaDEDAO.Insert(deducao);

         end;

         for FP   := 0 to baixa.listaFormasPagto.Count -1 do begin
            if baixa.listaFormasPagto[FP].FFormaPagamento.FID.Equals('CHEQUE') then begin
              //TRBAIXA_CHEQUE   //SALVA O TPBAIXA_FP

              formaPagto                  :=  TTRBaixaFPModel.Create;
              formaPagto.FIDorganizacao   :=  baixa.FIDorganizacao;
              formaPagto.FID              :=  baixa.listaFormasPagto[FP].FID;
              formaPagto.FIDTRBaixa       :=  baixa.listaFormasPagto[FP].FIDTRBaixa;
              formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;
              formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

               if TTRBaixaFPDAO.Insert(formaPagto) then begin
               //PAGAMENTO REALIZADO EM CHEQUE
                pagtoCheque := TTRBaixaChequeModel.Create;
                pagtoCheque := baixa.FTRBaixaCheque;
            //    pagtoCheque.FIDCheque := baixa.FTRBaixaCheque.FIDCheque; //colocado em 04/03.
                sucesso:= TTRBaixaChequeDAO.Insert(pagtoCheque);

               end;

               if sucesso then
              begin
                //PAGAMENTO REALIZADO via CAIXA
                 //TESOURARIA_CREDITO
                debitoCaixa                   := TTesourariaCRModel.Create;
                debitoCaixa.FIDorganizacao    := baixa.FIDorganizacao;
                debitoCaixa.FID               := dmConexao.obterNewID;
                debitoCaixa.FIDcheque         := baixa.FTRBaixaCheque.FID;
                debitoCaixa.FnumeroDocumento  := dmConexao.obterIdentificador('',baixa.FIDorganizacao, 'TC');
                debitoCaixa.FIDHistorico      := 'CHEQUE RECEBIDO POR TITULO';  //ver isso
                debitoCaixa.FIDResponsavel    := baixa.FIDResponsavel;
                debitoCaixa.FIDUsuario        := baixa.FIDusuario;
                debitoCaixa.FIDSacado         := titulo.FIDSacado;
                //debitoCaixa.FIDTRB            := baixa.FID;
                debitoCaixa.FvalorNominal     := formaPagto.FValor;
                debitoCaixa.Fdescricao        := ' TIT ' + titulo.FnumeroDocumento + ' ' + titulo.Fdescricao;
                debitoCaixa.FtipoLancamento   := 'C';
                debitoCaixa.FdataRegistro     := Now;
                debitoCaixa.FdataContabil     := titulo.FdataPagamento;
                debitoCaixa.FdataMovimento    := titulo.FdataPagamento;
                 try
                 sucesso:= TTesourariaCRDAO.Insert(debitoCaixa);

                 except
                 raise Exception.Create('Verifique o Hist�rico :' + debitoCaixa.FIDHistorico);

                 end;
              end;

            end; // fim da FP em cheque
         end;

         for FP := 0 to baixa.listaFormasPagto.Count -1 do begin
          // INTERNET BANK

           if baixa.listaFormasPagto[FP].FFormaPagamento.FID.Equals('INTERNET BANK') then begin
            //TPBAIXA_CHEQUE   //SALVA O TPBAIXA_FP
            formaPagto                  :=  TTRBaixaFPModel.Create;
            formaPagto.FIDorganizacao   :=  baixa.FIDorganizacao;
            formaPagto.FID              :=  baixa.listaFormasPagto[FP].FID;
            formaPagto.FIDTRBaixa       :=  baixa.listaFormasPagto[FP].FIDTRBaixa;
            formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;
            formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

           if TTRBaixaFPDAO.Insert(formaPagto) then begin
              //PAGAMENTO REALIZADO via banco online
              // TITULO_RECEBER_BAIXA_INTERNET
               pagtoWWW := TTRBaixaInternetModel.Create;
               pagtoWWW := baixa.FTRBaixaWWW;

              if uUtil.Empty(pagtoWWW.FID) then begin
               pagtoWWW.FID := dmConexao.obterNewID;
              end;

               pagtoWWW.FIDTRB := baixa.FID;
                TTRBaixaInternetDAO.Insert(pagtoWWW);

               //CBC
               contaBancoCR                   := TContaBancariaCRModel.Create;

               contaBancoCR.FIDorganizacao    := baixa.FIDorganizacao;
               contaBancoCR.FID               := dmConexao.obterNewID;
               contaBancoCR.Fidentificacao    := dmConexao.obterIdentificador('',baixa.FIDorganizacao,'CBC');
               contaBancoCR.FIDusuario        := baixa.FIDusuario;
               contaBancoCR.FIDResponsavel    := baixa.FIDResponsavel;
               contaBancoCR.FIDTOB            := pagtoWWW.FIDTOB;
               contaBancoCR.FIDTR             := titulo.FID;
               contaBancoCR.FtipoLancamento   := 'C' ;
               contaBancoCR.Fdescricao        := 'RCBTO DOC ' + titulo.FnumeroDocumento ;
               contaBancoCR.FIDcontaBancaria  := pagtoWWW.FIDcontaBancaria; //confirmar isso
               contaBancoCR.Fvalor            := pagtoWWW.Fvalor;
               contaBancoCR.FdataMovimento    := pagtoWWW.FdataOperacao;
               contaBancoCR.FdataRegistro     := Now;


             sucesso:=   TContaBancariaCreditoDAO.Insert(contaBancoCR);


           end;

          end; // fim da FP via bank line

         end;


         for FP := 0 to baixa.listaFormasPagto.Count -1 do begin

            //ESPECIE
            if baixa.listaFormasPagto[FP].FFormaPagamento.FID.Equals('ESPECIE') then begin

              formaPagto                  :=  TTRBaixaFPModel.Create;
              formaPagto.FIDorganizacao   :=  baixa.FIDorganizacao;
              formaPagto.FID              :=  baixa.listaFormasPagto[FP].FID;
              formaPagto.FIDTRBaixa       :=  baixa.listaFormasPagto[FP].FIDTRBaixa;
              formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;
              formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

              if TTRBaixaFPDAO.Insert(formaPagto) then
              begin
                //PAGAMENTO REALIZADO via CAIXA
                 //TESOURARIA_CREDITO
                debitoCaixa                   := TTesourariaCRModel.Create;
                debitoCaixa.FIDorganizacao    := baixa.FIDorganizacao;
                debitoCaixa.FID               := dmConexao.obterNewID;
                debitoCaixa.FnumeroDocumento  := dmConexao.obterIdentificador('',baixa.FIDorganizacao, 'TC');
                debitoCaixa.FIDHistorico      := 'PAGTO TITULO ESPECIE';  //ver isso
                debitoCaixa.FIDResponsavel    := baixa.FIDResponsavel;
                debitoCaixa.FIDUsuario        := baixa.FIDusuario;
                debitoCaixa.FIDSacado        := titulo.FIDSacado;
                debitoCaixa.FIDTRB            := baixa.FID;
                debitoCaixa.FvalorNominal     := formaPagto.FValor;
                debitoCaixa.Fdescricao        := ' TIT ' + titulo.FnumeroDocumento + ' ' + titulo.Fdescricao;
                debitoCaixa.FtipoLancamento   := 'C';
                debitoCaixa.FdataRegistro     := Now;
                debitoCaixa.FdataContabil     := titulo.FdataPagamento;
                debitoCaixa.FdataMovimento    := titulo.FdataPagamento;

                 sucesso:= TTesourariaCRDAO.Insert(debitoCaixa);
              end;
        end; // fim da FP via tesouraria
      end;

      if TTituloReceberDAO.Update(titulo) then
      begin
        sucesso := True;

      end; //IF UPDATE TP


    end; //if INSERT BAIXA




    if dmConexao.conn.InTransaction then
      dmConexao.conn.CommitRetaining;

    except
    sucesso :=False;
      Result := sucesso;
      if dmConexao.conn.InTransaction then
        dmConexao.conn.RollbackRetaining;
    end;

  Result := sucesso;

end;



class function TTRBaixaDAO.getModel(query: TFDQuery): TTRBaixaModel;
var
tpb: TTRBaixaModel;
begin
  tpb := TTRBaixaModel.Create;
 try

  if not query.IsEmpty then begin


      tpb.FID                     := query.FieldByName('ID_TITULO_RECEBER_BAIXA').AsString;
      tpb.FIDorganizacao          := query.FieldByName('ID_ORGANIZACAO').AsString;
      tpb.FIDCentroCusto          := query.FieldByName('ID_CENTRO_CUSTO').AsString;
      tpb.FIDusuario              := query.FieldByName('ID_USUARIO').AsInteger;
      tpb.FIDResponsavel          := query.FieldByName('ID_RESPONSAVEL').AsString;
      tpb.FIDloteContabil         := query.FieldByName('ID_LOTE_CONTABIL').AsString;
      tpb.FIDtituloReceber        := query.FieldByName('ID_TITULO_RECEBER').AsString; //ver como montar o objeto
      tpb.FtipoBaixa              := query.FieldByName('TIPO_BAIXA').AsString;
      tpb.FdataRegistro           := query.FieldByName('DATA_REGISTRO').AsDateTime;
      tpb.FvalorPago              := query.FieldByName('VALOR_PAGO').AsCurrency;

      //preencher as cole��es
     // property listaFormasPagto: TObjectList<TTRBaixaFPModel> read FListaFormasPagto  write FListaFormasPagto;

   // property listaDeducao: TObjectList<TTRBaixaDEModel> read FlistaDeducao  write FlistaDeducao;
   // property listaAcrescimo: TObjectList<TTRBaixaACModel> read FlistaAcrescimo  write FlistaAcrescimo;

  end;

 except
 raise Exception.Create('Erro ao tentar converter o tpb em DAO. Informe erro ao suporte. ');
 end;

  Result := tpb;

end;



end.
