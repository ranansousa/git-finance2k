unit uContaBancariaChequeDAO;
interface
uses
  Winapi.Windows, Winapi.Messages, System.DateUtils, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uContaBancariaChequeModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uContaContabilModel, uContaBancariaDAO,
  uContaBancariaModel, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  uBancoDAO, uBancoModel, FireDAC.Comp.DataSet, FireDAC.Comp.Client  ;

  const
   pTable : string = 'CONTA_BANCARIA_CHEQUE';

type
 TContaBancariaChequeDAO = class
  private
   class function getCheque (query :TFDQuery) : TContaBancariaChequeModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}

    class function Insert(value :TContaBancariaChequeModel): Boolean;
    class function obterPorID(value :TContaBancariaChequeModel): TContaBancariaChequeModel;
    class function obterPorNumero(value :TContaBancariaChequeModel): TContaBancariaChequeModel;
    class function Delete(value :TContaBancariaChequeModel): Boolean;
    class function Update(value :TContaBancariaChequeModel): Boolean;
    class function compensar(value :TContaBancariaChequeModel) : Boolean;
    class function estornarCompensado(value :TContaBancariaChequeModel) : Boolean;


    class function gerarCheques (qtd :Integer; value :TContaBancariaChequeModel): Boolean;

  end;


implementation
uses
uContaBancariaDBModel,uContaBancariaDebitoDAO;

{ TContaBancariaChequeDAO }

class function TContaBancariaChequeDAO.compensar( value: TContaBancariaChequeModel): Boolean;
var
sucesso :Boolean;
//chequeCompensar : TContaBancariaChequeModel;
 contaBancoDB: TContaBancariaDBModel;
begin
sucesso := False;

 dmConexao.conectarBanco;

if not dmConexao.conn.InTransaction then
         dmConexao.conn.StartTransaction;


  try
    value.FIDtipoStatus    := 'COMPENSADO';
    value.FdataCompensacao := value.FdataCompensacao;


    if Update(value) then
       begin
      sucesso := True;
    end;


    if sucesso then
    begin

      //CBD
      contaBancoDB := TContaBancariaDBModel.Create;
      contaBancoDB.FIDorganizacao := value.FIDorganizacao;
      contaBancoDB.FID := dmConexao.obterNewID;
      contaBancoDB.Fidentificacao := dmConexao.obterIdentificador('', value.FIDorganizacao, 'CBD');
      contaBancoDB.FIDusuario := uutil.TUserAtual.userID;
      contaBancoDB.FIDResponsavel := value.FIDresponsavel;
      contaBancoDB.FIDTOB := value.FIDTOB;
      contaBancoDB.FIDTP := value.FIDTP;
      contaBancoDB.FtipoLancamento := value.FtipoLancamento;
      contaBancoDB.Fdescricao := value.Fdescricao + '- CH  ' + value.FNumero;
      contaBancoDB.FIDcontaBancaria := value.FIDcontaBancaria;
      contaBancoDB.Fvalor := value.Fvalor;
      contaBancoDB.FdataMovimento := value.FdataCompensacao;
      contaBancoDB.FdataRegistro := Now;
      contaBancoDB.FIDCheque   := value.FID;


      sucesso := TContaBancariaDebitoDAO.Insert(contaBancoDB);
    end;

    if sucesso then
    begin

      if dmConexao.conn.InTransaction then
        dmConexao.conn.CommitRetaining;

    end;

     Result :=sucesso;


  except
   if dmConexao.conn.InTransaction then
      dmConexao.conn.RollbackRetaining;

   raise Exception.Create('N�o foi poss�vel compensar o cheque.' + 'updateChequeEmitido' );

  end;


end;





class function TContaBancariaChequeDAO.Delete(value: TContaBancariaChequeModel): Boolean;
var
qryDelete : TFDQuery;
sucesso :Boolean;
chequeDeletar :TContaBancariaChequeModel;
begin
sucesso := False;
 dmConexao.conectarBanco;
 try

    chequeDeletar :=TContaBancariaChequeModel.Create;
    chequeDeletar.FID              := value.FID;
    chequeDeletar.FIDorganizacao   := value.FIDorganizacao;
    chequeDeletar.FIDcontaBancaria := value.FIDcontaBancaria;
    chequeDeletar.FIDtipoStatus    := 'DESATIVADO';
    chequeDeletar.FIDusuario       := uutil.TUserAtual.getUserId;
    chequeDeletar.Fobservacao      := 'Deletado por : ' + uutil.TUserAtual.getNameUser ;


    if Update(value) then
    begin

      sucesso := True;
    end;

 except
 sucesso := False;
 raise Exception.Create('Erro ao tentar DELETAR CHEQUE');

 end;

  Result := sucesso;
end;

class function TContaBancariaChequeDAO.estornarCompensado( value: TContaBancariaChequeModel): Boolean;
var
sucesso :Boolean;
//chequeCompensar : TContaBancariaChequeModel;
 contaBancoDB: TContaBancariaDBModel;
begin
sucesso := False;

 dmConexao.conectarBanco;

if not dmConexao.conn.InTransaction then
         dmConexao.conn.StartTransaction;
  try
    value.FIDtipoStatus := 'BLOQUEADO';

    sucesso := Update(value) ;

    if sucesso then
    begin

      //CBD
      contaBancoDB := TContaBancariaDBModel.Create;
      contaBancoDB.FIDorganizacao := value.FIDorganizacao;
      contaBancoDB.FIDCheque := value.FID;
      contaBancoDB := TContaBancariaDebitoDAO.obterPorCheque(contaBancoDB);

      if not uutil.Empty(contaBancoDB.FID) then
      begin

        sucesso := TContaBancariaDebitoDAO.Delete(contaBancoDB);

      end;

    end;

    if sucesso then
    begin

      if dmConexao.conn.InTransaction then
        dmConexao.conn.CommitRetaining;

    end;

    Result := sucesso;

  except
    if dmConexao.conn.InTransaction then
      dmConexao.conn.RollbackRetaining;

    raise Exception.Create('N�o foi poss�vel compensar o cheque.' + 'updateChequeEmitido');

  end;


end;

class function TContaBancariaChequeDAO.gerarCheques(qtd: Integer;value: TContaBancariaChequeModel): Boolean;
var //o primeiro cheque precisa vir preenchido. o numero do cheque ser� incrementado
chequeGerado : TContaBancariaChequeModel;
existCheque, numero: Integer;
ausucesso : Boolean;

begin
 ausucesso :=False;
 existCheque :=1;;
 numero := StrToInt(value.FNumero);
 try

  while qtd > 0 do
  begin

    chequeGerado                  := TContaBancariaChequeModel.Create;
    chequeGerado.FIDorganizacao   := value.FIDorganizacao;
    chequeGerado.FIDcontaBancaria := value.FIDcontaBancaria;
    chequeGerado.FNumero          := IntToStr(numero);
    while existCheque > 0 do
    begin
      chequeGerado.FIDorganizacao := value.FIDorganizacao;
      chequeGerado.FIDcontaBancaria := value.FIDcontaBancaria;
      chequeGerado.FNumero := IntToStr(numero);

      chequeGerado := obterPorNumero(chequeGerado);

      if not uutil.Empty(chequeGerado.FID) then
      begin
        Inc(numero);
        Inc(existCheque);
        chequeGerado := TContaBancariaChequeModel.Create;
        chequeGerado.FIDorganizacao := value.FIDorganizacao;
        chequeGerado.FIDcontaBancaria := value.FIDcontaBancaria;
        chequeGerado.FNumero := IntToStr(numero);

      end
      else
      begin
        Dec(existCheque);
      end;

    end;

    chequeGerado.FIDorganizacao   := value.FIDorganizacao;
    chequeGerado.FIDcontaBancaria := value.FIDcontaBancaria;
    chequeGerado.FNumero          := IntToStr(numero);
    chequeGerado.FID              := dmConexao.obterNewID;
    chequeGerado.FIDresponsavel   := value.FIDresponsavel;
    chequeGerado.FIDusuario       := value.FIDusuario;
    chequeGerado.FIDtipoStatus    := 'BLOQUEADO';
    chequeGerado.Fvalor           := 0;
    chequeGerado.FdataRegistro    := Now;
    chequeGerado.FqtdImpressao    := 0;

    if Insert(chequeGerado) then
    begin
     ausucesso :=True;
     Dec(qtd);
     Inc(numero);
    end;

  end;

 except
 ausucesso :=False;
 raise Exception.Create('Erro ao tentar gerar cheques. ');
 end;

Result := ausucesso
end;

class function TContaBancariaChequeDAO.getCheque(query: TFDQuery): TContaBancariaChequeModel;
var cConta :TContaBancariaModel;
cheque : TContaBancariaChequeModel;
begin

    cheque                  := TContaBancariaChequeModel.Create;
    cheque.FcontaBancaria  := TContaBancariaModel.Create;


    if not query.IsEmpty then begin


       if not  query.IsEmpty then begin
        cheque.FID                      := (query.FieldByName('id_conta_bancaria_cheque').AsString);
        cheque.FIDorganizacao           := (query.FieldByName('id_organizacao').AsString);
        cheque.FIDcontaBancaria         := (query.FieldByName('id_conta_bancaria').AsString);
        cheque.FIDresponsavel           := (query.FieldByName('id_funcionario').AsString);
        cheque.FIDtipoStatus            := (query.FieldByName('id_tipo_status').AsString);
        cheque.FNumero                  := (query.FieldByName('numero_cheque').AsString);
        cheque.Fobservacao              := (query.FieldByName('observacao').AsString);
        cheque.Fportador                := (query.FieldByName('portador').AsString);
        cheque.FIDusuario               := (query.FieldByName('id_usuario').AsString);
        cheque.FdataPrevisaoCompensacao := (query.FieldByName('data_previsao_compensacao').AsDateTime);
        cheque.FdataEstorno             := (query.FieldByName('data_estorno').AsDateTime);
        cheque.FdataRegistro            := (query.FieldByName('data_registro').AsDateTime);
        cheque.FdataEmissao             := (query.FieldByName('data_emissao').AsDateTime);
        cheque.FdataCompensacao         := (query.FieldByName('data_compensacao').AsDateTime);
        cheque.Fvalor                   := (query.FieldByName('valor').AsCurrency);
        cheque.FqtdImpressao            := (query.FieldByName('qtd_impressao').AsInteger);

       end;



         cheque.FcontaBancaria.FID            := cheque.FIDcontaBancaria;
         cheque.FcontaBancaria.FIDorganizacao := cheque.FIDorganizacao;
         cheque.FcontaBancaria  := TContaBancariaDAO.obterPorID(cheque.FcontaBancaria);


  end;


   Result := cheque;

end;

class function TContaBancariaChequeDAO.Insert(value: TContaBancariaChequeModel): Boolean;
var
qryInsert : TFDQuery;
cmdSql :string;
begin
dmConexao.conectarBanco;
//cheque inserido por funcao gerar cheques

try
     cmdSql := ' INSERT INTO CONTA_BANCARIA_CHEQUE ' +
               '(ID_CONTA_BANCARIA_CHEQUE, ID_ORGANIZACAO, ID_CONTA_BANCARIA, ' +
               ' ID_FUNCIONARIO, ID_USUARIO, ID_TIPO_STATUS, NUMERO_CHEQUE, ' +
               ' DATA_REGISTRO, QTD_IMPRESSAO )' +
               ' VALUES (:PID, :PIDORGANIZACAO, :PIDCONTA_BANCARIA, '+
               ' :PIDFUNCIONARIO, :PIDUSUARIO, :PIDTIPO_STATUS, :PNUMERO_CHEQUE, '+
               ' :PDATA_REGISTRO, :PQTD_IMPRESSAO)';


    qryInsert := TFDQuery.Create(nil);
    qryInsert.Close;
    qryInsert.Connection := dmConexao.conn;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(cmdSql);
    qryInsert.ParamByName('PID').AsString               := value.FID;
    qryInsert.ParamByName('PIDORGANIZACAO').AsString    := value.FIDorganizacao;
    qryInsert.ParamByName('PIDCONTA_BANCARIA').AsString := value.FIDcontaBancaria;
    qryInsert.ParamByName('PIDFUNCIONARIO').AsString    := value.FIDresponsavel;
    qryInsert.ParamByName('PIDUSUARIO').AsString        := value.FIDusuario;
    qryInsert.ParamByName('PIDTIPO_STATUS').AsString    := value.FIDtipoStatus;
    qryInsert.ParamByName('PNUMERO_CHEQUE').AsString    := value.FNumero;
    qryInsert.ParamByName('PDATA_REGISTRO').AsDateTime  := value.FdataRegistro;
    qryInsert.ParamByName('PQTD_IMPRESSAO').AsInteger   := 0;

    qryInsert.ExecSQL;


except
Result :=False;

raise Exception.Create('Erro ao tentar alterar CHEQUE');

end;

 Result := System.True;
end;

class function TContaBancariaChequeDAO.obterPorID(value: TContaBancariaChequeModel): TContaBancariaChequeModel;
var
 cheque : TContaBancariaChequeModel;
 qryPesquisa : TFDQuery;
 cmdSql : string;
begin
   cheque :=TContaBancariaChequeModel.Create;
   dmConexao.conectarBanco;

   try
    cmdSql := ' SELECT * FROM CONTA_BANCARIA_CHEQUE CBC '+
              ' WHERE (CBC.ID_ORGANIZACAO =:PIDORGANIZACAO)AND (CBC.ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE) ';

    qryPesquisa := TFDQuery.Create(nil);
    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add(cmdSql);
    qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qryPesquisa.ParamByName('PIDCHEQUE').AsString := value.FID;

    qryPesquisa.Open;

     if not  qryPesquisa.IsEmpty then begin
      
      cheque := getCheque(qryPesquisa);

     end;


   except
   raise Exception.Create('Erro ao obter cheque por ID');

   end;

   Result := cheque;
end;


class function TContaBancariaChequeDAO.obterPorNumero(value: TContaBancariaChequeModel): TContaBancariaChequeModel;
var
cheque : TContaBancariaChequeModel;
 qryPesquisa : TFDQuery;
 cmdSql : string;
begin
   cheque :=TContaBancariaChequeModel.Create;
   dmConexao.conectarBanco;

   try
    cmdSql := ' SELECT * FROM CONTA_BANCARIA_CHEQUE CBC '+
              ' WHERE (CBC.ID_ORGANIZACAO   = :PIDORGANIZACAO) '+
              ' AND (CBC.ID_CONTA_BANCARIA  = :PIDCONTA) ' +
              ' AND (CBC.NUMERO_CHEQUE      = :PNUMERO) ' ;



    qryPesquisa := TFDQuery.Create(nil);
    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add(cmdSql);
    qryPesquisa.ParamByName('PIDCONTA').AsString := value.FIDcontaBancaria;
    qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qryPesquisa.ParamByName('PNUMERO').AsString := value.FNumero;

    qryPesquisa.Open;

     if not  qryPesquisa.IsEmpty then begin
      cheque.FID                      := (qryPesquisa.FieldByName('id_conta_bancaria_cheque').AsString);
      cheque.FIDorganizacao           := (qryPesquisa.FieldByName('id_organizacao').AsString);
      cheque.FIDcontaBancaria         := (qryPesquisa.FieldByName('id_conta_bancaria').AsString);
      cheque.FIDresponsavel           := (qryPesquisa.FieldByName('id_funcionario').AsString);
      cheque.FIDtipoStatus            := (qryPesquisa.FieldByName('id_tipo_status').AsString);
      cheque.FNumero                  := (qryPesquisa.FieldByName('numero_cheque').AsString);
      cheque.Fobservacao              := (qryPesquisa.FieldByName('observacao').AsString);
      cheque.Fportador                := (qryPesquisa.FieldByName('portador').AsString);
      cheque.FIDusuario               := (qryPesquisa.FieldByName('id_usuario').AsString);
      cheque.FdataPrevisaoCompensacao := (qryPesquisa.FieldByName('data_previsao_compensacao').AsDateTime);
      cheque.FdataEstorno             := (qryPesquisa.FieldByName('data_estorno').AsDateTime);
      cheque.FdataRegistro            := (qryPesquisa.FieldByName('data_registro').AsDateTime);
      cheque.FdataEmissao             := (qryPesquisa.FieldByName('data_emissao').AsDateTime);
      cheque.FdataCompensacao         := (qryPesquisa.FieldByName('data_compensacao').AsDateTime);
      cheque.Fvalor                   := (qryPesquisa.FieldByName('valor').AsCurrency);
      cheque.FqtdImpressao            := (qryPesquisa.FieldByName('qtd_impressao').AsInteger);

     end;


   except
   raise Exception.Create('Erro ao obter cheque por NUMERO');

   end;

   Result := cheque;
end;


class function TContaBancariaChequeDAO.Update(value: TContaBancariaChequeModel): Boolean;
var
qryUpdate : TFDQuery;
cmdSql :string;
sucesso :Boolean;
begin
sucesso := False;
dmConexao.conectarBanco;


cmdSql := ' UPDATE CONTA_BANCARIA_CHEQUE '+
          ' SET NUMERO_CHEQUE                 = :PNUMERO_CHEQUE, '+
            ' ID_USUARIO                      = :PIDUSUARIO, '+
            ' ID_FUNCIONARIO                  = :PIDRESPONSAVEL, '+
            ' ID_TIPO_STATUS                  = :PIDTIPO_STATUS,'+
            ' VALOR                           = :PVALOR,'+
            ' DATA_EMISSAO                    = :PDATA_EMISSAO, '+
            ' DATA_COMPENSACAO                = :PDATA_COMPENSACAO,'+
            ' DATA_REGISTRO                   = :PDATA_REGISTRO, '+
            ' DATA_PREVISAO_COMPENSACAO       = :PDATA_PREVISAO_COMPENSACAO,'+
            ' DATA_ESTORNO                    = :PDATA_ESTORNO,'+
            ' OBSERVACAO                      = :POBSERVACAO,'+
            ' PORTADOR                        = :PPORTADOR,'+
            ' QTD_IMPRESSAO                   = :PQTD_IMPRESSAO '+
          ' WHERE (ID_CONTA_BANCARIA_CHEQUE = :PID ) '+
          '   AND (ID_ORGANIZACAO = :PIDORGANIZACAO ) ' ;


    qryUpdate := TFDQuery.Create(nil);
    qryUpdate.Close;
    qryUpdate.Connection := dmConexao.conn;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(cmdSql);

    qryUpdate.ParamByName('PID').AsString                           := value.FID;
    qryUpdate.ParamByName('PNUMERO_CHEQUE').AsString                := value.FNumero;
    qryUpdate.ParamByName('PIDORGANIZACAO').AsString                := value.FIDorganizacao;
    qryUpdate.ParamByName('PIDUSUARIO').AsString                    := value.FIDUsuario;
    qryUpdate.ParamByName('PIDRESPONSAVEL').AsString                := value.FIDResponsavel;
    qryUpdate.ParamByName('PIDTIPO_STATUS').AsString                := value.FIDTipoStatus;

    qryUpdate.ParamByName('POBSERVACAO').AsString                   := value.Fobservacao;
    qryUpdate.ParamByName('PPORTADOR').AsString                     := value.Fportador;
    qryUpdate.ParamByName('PQTD_IMPRESSAO').AsInteger               := value.FqtdImpressao;
    qryUpdate.ParamByName('PVALOR').AsCurrency                      := value.Fvalor;

    qryUpdate.ParamByName('PDATA_EMISSAO').AsDateTime               := value.FdataEmissao;
    qryUpdate.ParamByName('PDATA_PREVISAO_COMPENSACAO').AsDateTime  := value.FdataPrevisaoCompensacao;
    qryUpdate.ParamByName('PDATA_REGISTRO').AsDateTime              := value.FdataRegistro;
    qryUpdate.ParamByName('PDATA_COMPENSACAO').AsDateTime           := value.FdataCompensacao;
    qryUpdate.ParamByName('PDATA_ESTORNO').AsDateTime               := value.FdataEstorno;

    if (compareDate(value.FdataCompensacao, value.FdataEmissao) < 0 ) then begin
      qryUpdate.ParamByName('PDATA_COMPENSACAO').Value         := null ;
    end;

    if (compareDate(value.FdataEstorno, value.FdataEmissao) < 0 ) then begin
      qryUpdate.ParamByName('PDATA_ESTORNO').Value         := null ;
    end;


     if (value.FIDtipoStatus = 'BLOQUEADO') then begin

      qryUpdate.ParamByName('PDATA_EMISSAO').Value         := null;
      qryUpdate.ParamByName('PDATA_COMPENSACAO').Value         := null;
      qryUpdate.ParamByName('PDATA_PREVISAO_COMPENSACAO').Value         := null;
      qryUpdate.ParamByName('PPORTADOR').Value         := null;
      qryUpdate.ParamByName('PVALOR').Value         := 0;
      qryUpdate.ParamByName('PDATA_ESTORNO').Value         := Now ;
      qryUpdate.ParamByName('POBSERVACAO').Value         := null ;

    end;


  if (value.FIDtipoStatus = 'COMPENSADO') then
  begin

    qryUpdate.ParamByName('PDATA_ESTORNO').value := null;

  end;

  qryUpdate.ExecSQL;

  if qryUpdate.RowsAffected > 0 then
  begin
    sucesso := True;
  end;

  Result := sucesso;

end;

end.
