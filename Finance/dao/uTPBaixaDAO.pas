unit uTPBaixaDAO;


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,  uTPBaixaModel, uTPBaixaInternetModel, uTPBaixaInternetDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uTituloPagarModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,uTPBaixaChequeModel, uContaBancariaChequeModel, uContaBancariaChequeDAO,
  System.Generics.Collections, uTPBaixaFPModel, uTPBaixaFPDAO, uTPBaixaChequeDAO,uContaBancariaDBModel, uContaBancariaDebitoDAO,
  uTituloPagarDAO, uTPBaixaDEDAO, uTPBaixaDEModel, uTPBaixaACModel,uTPBaixaACDAO, uTesourariaDBModel, uTesourariaDBDAO,
  uTituloPagarHistoricoModel, uTituloPagarCentroCustoModel,   uTituloPagarHistoricoDAO, uTituloPagarCentroCustoDAO,
   uOrganizacaoDAO, uOrganizacaoModel,  MDModel,MDDAO;

   const
   pTable : string = 'TITULO_PAGAR_BAIXA';

type
 TTPBaixaDAO = class
  private
    class function getTPB (query :TFDQuery) : TTPBaixaModel;
    class function registroMD(value: TTPBaixaModel; pAcao, pDsc,
      pStatus: string): Boolean; static;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}

    class function Insert(value :TTPBaixaModel): Boolean;
    class function obterPorTP(value :TTPBaixaModel): TTPBaixaModel;
    class function obterPorID (value :TTPBaixaModel): TTPBaixaModel;
    class function Delete(value :TTPBaixaModel): Boolean;
    class function salvarBaixa (baixa :TTPBaixaModel; titulo : TTituloPagarModel ): Boolean;

  end;

implementation

{ TTPBaixaDAO }

class function TTPBaixaDAO.Delete(value: TTPBaixaModel): Boolean;
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
      qryDelete.SQL.Add(' DELETE FROM TITULO_PAGAR_BAIXA  ');
      qryDelete.SQL.Add(' WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR_BAIXA = :PID ');
      qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qryDelete.ParamByName('PID').AsString := value.FID;

      qryDelete.ExecSQL;
      xResp := True;
      dmConexao.conn.CommitRetaining;


    except
      xResp := False;
      dmConexao.conn.RollbackRetaining;
      raise Exception.Create('Erro ao tentar DELETAR TITULO Pago');

    end;

    Result := xResp;
  finally
    if Assigned(qryDelete) then
    begin
      FreeAndNil(qryDelete);
    end;
  end;
end;



class function TTPBaixaDAO.Insert(value: TTPBaixaModel): Boolean;
var
qryInsert : TFDQuery;
cmdSql :string;
sucesso : Boolean;
begin
 sucesso := False;
  dmConexao.conectarBanco;
  qryInsert := TFDQuery.Create(nil);

  try

   cmdSql := ' INSERT INTO TITULO_PAGAR_BAIXA '+
           ' (ID_TITULO_PAGAR_BAIXA, ID_ORGANIZACAO, ID_TITULO_PAGAR,'+
           ' ID_CENTRO_CUSTO, ID_LOTE_CONTABIL, ID_USUARIO, ID_RESPONSAVEL, '+
           ' VALOR_PAGO, DATA_REGISTRO, TIPO_BAIXA, ID_LOTE_PAGAMENTO ) ' +
           ' VALUES (:PID,:PIDORGANIZACAO,:PIDTITULO_PAGAR, '+
           ' :PIDCENTRO_CUSTO, :PIDLOTE_CONTABIL, :PIDUSUARIO, :PIDRESPONSAVEL, '+
           ' :PVALOR_PAGO,:PDATA_REGISTRO, :PTIPO_BAIXA,:PIDLOTE_PAGAMENTO )';


    qryInsert.Close;
    qryInsert.Connection := dmConexao.conn;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(cmdSql);
    qryInsert.ParamByName('PID').AsString                         := value.FID;
    qryInsert.ParamByName('PIDTITULO_PAGAR').AsString             := value.FIDtituloPagar;
    qryInsert.ParamByName('PIDORGANIZACAO').AsString              := value.FIDorganizacao;
    qryInsert.ParamByName('PIDUSUARIO').AsInteger                  := value.FIDUsuario;
    qryInsert.ParamByName('PIDRESPONSAVEL').AsString              := value.FIDResponsavel;
    qryInsert.ParamByName('PIDLOTE_CONTABIL').AsString            := value.FIDLoteContabil;
    qryInsert.ParamByName('PIDCENTRO_CUSTO').AsString             := value.FIDCentroCusto;
    qryInsert.ParamByName('PTIPO_BAIXA').AsString                 := value.FtipoBaixa;
    qryInsert.ParamByName('PIDLOTE_PAGAMENTO').AsString           := value.FIDlotePagamento;
    qryInsert.ParamByName('PDATA_REGISTRO').AsDateTime            := Now;
    qryInsert.ParamByName('PVALOR_PAGO').AsCurrency               := value.FvalorPago;

      if uUtil.Empty(value.FIDloteContabil) then
      begin
        qryInsert.ParamByName('PIDLOTE_CONTABIL').Value := null;
      end;

      if uUtil.Empty(value.FIDtituloPagar) then
      begin
        qryInsert.ParamByName('PIDTITULO_PAGAR').AsString := value.FTituloPagar.FID;
      end;

      if uUtil.Empty(value.FIDlotePagamento) then
      begin
        qryInsert.ParamByName('PIDLOTE_PAGAMENTO').Value := null;
      end;

      qryInsert.ExecSQL;

    if qryInsert.RowsAffected > 0 then
    begin
      registroMD(value, 'BX TP', 'Baixa do TP ' + value.FTituloPagar.FnumeroDocumento + ' ' + value.FTituloPagar.Fdescricao, 'PAGO');
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

class function TTPBaixaDAO.obterPorID(value: TTPBaixaModel): TTPBaixaModel;
var
qryPesquisa : TFDQuery;
tpb: TTPBaixaModel;
begin
dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
tpb := TTPBaixaModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_PAGAR_BAIXA  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR_BAIXA = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      tpb := getTPB(qryPesquisa);
  end;


except
raise Exception.Create('Erro ao tentar obter TITULO PAGO ID');

end;

 Result := tpb;
end;


class function TTPBaixaDAO.obterPorTP(value: TTPBaixaModel): TTPBaixaModel;
var
qryPesquisa : TFDQuery;
tpb: TTPBaixaModel;
begin
dmConexao.conectarBanco;
 qryPesquisa := TFDQuery.Create(nil);
 tpb                         := TTPBaixaModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_PAGAR_BAIXA  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR = :PIDTP '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PIDTP').AsString := value.FIDtituloPagar;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      tpb := getTPB(qryPesquisa);
  end;

except
raise Exception.Create('Erro ao tentar obter TITULO PAGO IDTP');

end;

 Result := tpb;
end;


class function TTPBaixaDAO.salvarBaixa(baixa: TTPBaixaModel; titulo: TTituloPagarModel): Boolean;
var
  formaPagto    : TTPBaixaFPModel;
  acrescimo     : TTPBaixaACModel;
  deducao       : TTPbaixaDEModel;
  pagtoCheque   : TTPBaixaChequeModel;
  pagtoWWW      : TTPBaixaInternetModel;
  cheque        : TContaBancariaChequeModel;
  contaBancoDB  : TContaBancariaDBModel;
  debitoCaixa   : TTesourariaDBModel;

  A,D,FP : Integer;
listaHistorico :  TObjectList<TTituloPagarHistoricoModel>;
listaCustos    :  TObjectList<TTituloPagarCentroCustoModel>;
historico : TTituloPagarHistoricoModel  ;
centroCusto : TTituloPagarCentroCustoModel;
 qtdRateioC, qtdRateioH, I :Integer;
 valorNominal, valorAntecipado :Currency;

begin
  qtdRateioH :=0;
  qtdRateioC  :=0;
  I:=0;
  valorNominal     := titulo.FvalorNominal ;
  dmConexao.conectarBanco;


  if not dmConexao.conn.InTransaction then
    dmConexao.conn.StartTransaction;

  try
// dmConexao.conn.StartTransaction;

 // Atualizar ou Inserir o TP
   if TTituloPagarDAO.Update(titulo) then begin
     //TPBAIXA
    if Insert(baixa) then begin
        //inserido os acrescimos
        if Assigned(baixa.listaAcrescimo) then
        begin
          for A := 0 to baixa.listaAcrescimo.Count - 1 do
          begin
            acrescimo := TTPBaixaACModel.Create;
            acrescimo := baixa.listaAcrescimo[A];
            TTPBaixaACDAO.Insert(acrescimo);
          end;
        end;

        //inserido as deducoes
        if Assigned(baixa.listaDeducao) then
        begin
          for D := 0 to baixa.listaDeducao.Count - 1 do
          begin
            deducao := TTPBaixaDEModel.Create;
            deducao := baixa.listaDeducao[D];
            TTPBaixaDEDAO.Insert(deducao);
          end;
        end;

         for FP   := 0 to baixa.listaFormasPagto.Count -1 do begin
            if baixa.listaFormasPagto[FP].FFormaPagamento.FID.Equals('CHEQUE') then begin
              //TPBAIXA_CHEQUE   //SALVA O TPBAIXA_FP
              formaPagto                  :=  TTPBaixaFPModel.Create;
              formaPagto.FIDorganizacao   :=  baixa.FIDorganizacao;
              formaPagto.FID              := dmConexao.obterNewID; //  baixa.listaFormasPagto[FP].FID;
      //        formaPagto.FIDTPBaixa       :=  baixa.listaFormasPagto[FP].FIDTPBaixa; mudado em 23/03 pq do pagto em lote
              formaPagto.FIDTPBaixa       :=  baixa.FID;

              formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;
              if not uUtil.Empty(titulo.FIDLotePagamento) then begin //o valro muda qdo o titulo � pago em lote.
                 formaPagto.FValor           :=  titulo.FvalorNominal;
              end;

              formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

               if TTPBaixaFPDAO.Insert(formaPagto) then begin
               //PAGAMENTO REALIZADO EM CHEQUE
                pagtoCheque := TTPBaixaChequeModel.Create;
                pagtoCheque := baixa.FTPBaixaCheque;
                pagtoCheque.FIDCheque := baixa.FTPBaixaCheque.FIDCheque; //colocado em 04/03.
                pagtoCheque.FIDTPBaixa := baixa.FID;

                TTPBaixaChequeDAO.Insert(pagtoCheque);

                cheque := TContaBancariaChequeModel.Create;
                cheque := pagtoCheque.FCheque;

                TContaBancariaChequeDAO.Update(cheque);
               end;

            end; // fim da FP em cheque
         end;

         for FP := 0 to baixa.listaFormasPagto.Count -1 do begin
          // INTERNET BANK

           if baixa.listaFormasPagto[FP].FFormaPagamento.FID.Equals('INTERNET BANK') then begin
            //TPBAIXA_CHEQUE   //SALVA O TPBAIXA_FP
            formaPagto                  :=  TTPBaixaFPModel.Create;
            formaPagto.FIDorganizacao   :=  baixa.FIDorganizacao;
            formaPagto.FID              :=  dmConexao.obterNewID; //  baixa.listaFormasPagto[FP].FID;
           // formaPagto.FIDTPBaixa       :=  baixa.listaFormasPagto[FP].FIDTPBaixa;
            formaPagto.FIDTPBaixa       :=  baixa.FID;
            formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;

            if not uUtil.Empty(titulo.FIDLotePagamento) then begin
                 formaPagto.FValor           :=  titulo.FvalorNominal;
              end;

            formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

           if TTPBaixaFPDAO.Insert(formaPagto) then begin
              //PAGAMENTO REALIZADO via banco online
              // TITULO_RECEBER_BAIXA_INTERNET
               pagtoWWW := TTPBaixaInternetModel.Create;
               pagtoWWW := baixa.FTPBaixaWWW;
               pagtoWWW.FID := dmConexao.obterNewID;
               pagtoWWW.FIDTPB := baixa.FID;

                TTPBaixaInternetDAO.Insert(pagtoWWW);

               //CBD
               contaBancoDB                   := TContaBancariaDBModel.Create;
               contaBancoDB.FIDorganizacao    := baixa.FIDorganizacao;
               contaBancoDB.FID               := dmConexao.obterNewID;
               contaBancoDB.Fidentificacao    := dmConexao.obterIdentificador('',baixa.FIDorganizacao,'CBD');
               contaBancoDB.FIDusuario        := baixa.FIDusuario;
               contaBancoDB.FIDResponsavel    := baixa.FIDResponsavel;
               contaBancoDB.FIDTOB            := pagtoWWW.FIDTOB;
               contaBancoDB.FIDTP             := titulo.FID;
               contaBancoDB.FtipoLancamento   := 'D' ;
               contaBancoDB.Fdescricao        := 'PAGTO DOC ' + titulo.FnumeroDocumento ;
               contaBancoDB.FIDcontaBancaria  := pagtoWWW.FIDcontaBancariaOrigem;
               contaBancoDB.Fvalor            := pagtoWWW.Fvalor;
               contaBancoDB.FdataMovimento    := pagtoWWW.FdataOperacao;
               contaBancoDB.FdataRegistro     := Now;


                TContaBancariaDebitoDAO.Insert(contaBancoDB);


           end;

          end; // fim da FP via bank line

         end;


         for FP := 0 to baixa.listaFormasPagto.Count -1 do begin

            //ESPECIE
            if baixa.listaFormasPagto[FP].FFormaPagamento.FID.Equals('ESPECIE') then begin
              //TPBAIXA_CHEQUE   //SALVA O TPBAIXA_FP
              formaPagto                  :=  TTPBaixaFPModel.Create;
              formaPagto.FIDorganizacao   :=  baixa.FIDorganizacao;
              formaPagto.FID              :=  dmConexao.obterNewID; //  baixa.listaFormasPagto[FP].FID;
             // formaPagto.FIDTPBaixa       :=  baixa.listaFormasPagto[FP].FIDTPBaixa;
              formaPagto.FIDTPBaixa       :=  baixa.FID;
              formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;

              if not uUtil.Empty(titulo.FIDLotePagamento) then begin
                 formaPagto.FValor           :=  titulo.FvalorNominal;
              end;

              formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

              if TTPBaixaFPDAO.Insert(formaPagto) then
              begin
                //PAGAMENTO REALIZADO via CAIXA
                 //TESOURARIA_DEBITO
                debitoCaixa                   := TTesourariaDBModel.Create;
                debitoCaixa.FIDorganizacao    := baixa.FIDorganizacao;
                debitoCaixa.FID               := dmConexao.obterNewID;
                debitoCaixa.FnumeroDocumento  := dmConexao.obterIdentificador('',baixa.FIDorganizacao, 'TD');
                debitoCaixa.FIDHistorico      := 'PAGTO TITULO ESPECIE';
                debitoCaixa.FIDResponsavel    := baixa.FIDResponsavel;
                debitoCaixa.FIDUsuario        := baixa.FIDusuario;
                debitoCaixa.FIDCedente        := titulo.FIDCedente;
                debitoCaixa.FIDTPB            := baixa.FID;
                debitoCaixa.FvalorNominal     := formaPagto.FValor;
                debitoCaixa.Fdescricao        := ' TIT ' + titulo.FnumeroDocumento + ' ' + titulo.Fdescricao;
                debitoCaixa.FtipoLancamento   := 'D';
                debitoCaixa.FdataRegistro     := Now;
                debitoCaixa.FdataContabil     := titulo.FdataPagamento;
                debitoCaixa.FdataMovimento    := titulo.FdataPagamento;

                  TTesourariaDBDAO.Insert(debitoCaixa);
              end;
            end; // fim da FP via tesouraria
        end;



    end; //if INSERT BAIXA


   end; //IF UPDATE TP
    if dmConexao.conn.InTransaction then
      dmConexao.conn.CommitRetaining;

  except
    if dmConexao.conn.InTransaction then
    begin
      dmConexao.conn.RollbackRetaining;
    end;
    Result := System.FAlse;
    raise Exception.Create('Erro ao tentar o pagamento do titulo ' + titulo.FnumeroDocumento);
  end;

  Result := System.True;

end;

class function TTPBaixaDAO.getTPB(query: TFDQuery): TTPBaixaModel;
var
tpb: TTPBaixaModel;
begin
  tpb := TTPBaixaModel.Create;
 try

  if not query.IsEmpty then begin


      tpb.FID                     := query.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString;
      tpb.FIDorganizacao          := query.FieldByName('ID_ORGANIZACAO').AsString;
      tpb.FIDCentroCusto          := query.FieldByName('ID_CENTRO_CUSTO').AsString;
      tpb.FIDusuario              := query.FieldByName('ID_USUARIO').AsInteger;
      tpb.FIDResponsavel          := query.FieldByName('ID_RESPONSAVEL').AsString;
      tpb.FIDloteContabil         := query.FieldByName('ID_LOTE_CONTABIL').AsString;
      tpb.FIDlotePagamento        := query.FieldByName('ID_LOTE_PAGAMENTO').AsString;
      tpb.FIDtituloPagar          := query.FieldByName('ID_TITULO_PAGAR').AsString; //ver como montar o objeto
      tpb.FtipoBaixa              := query.FieldByName('TIPO_BAIXA').AsString;
      tpb.FdataRegistro           := query.FieldByName('DATA_REGISTRO').AsDateTime;
      tpb.FvalorPago              := query.FieldByName('VALOR_PAGO').AsCurrency;

      //preencher as cole��es
     // property listaFormasPagto: TObjectList<TTPBaixaFPModel> read FListaFormasPagto  write FListaFormasPagto;

   // property listaDeducao: TObjectList<TTPBaixaDEModel> read FlistaDeducao  write FlistaDeducao;
   // property listaAcrescimo: TObjectList<TTPBaixaACModel> read FlistaAcrescimo  write FlistaAcrescimo;







  end;

 except
 raise Exception.Create('Erro ao tentar converter o tpb em DAO. Informe erro ao suporte. ');
 end;

  Result := tpb;

end;


class function TTPBaixaDAO.registroMD(value: TTPBaixaModel; pAcao, pDsc,pStatus: string): Boolean;
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
   md.FvalorOperacao    := value.FvalorPago;
   md.FnumeroMovimento  := StrToInt(dmConexao.obterIdentificador('',md.FIDorganizacao,'MD'));
   md.Fcodigo           := value.FTituloPagar.FnumeroDocumento;
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