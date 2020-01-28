unit uDMTransfBancoCaixa;

interface

uses
  System.SysUtils, udmConexao, uUtil, System.Classes, FireDAC.Stan.Intf, System.DateUtils,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,uContaBancariaChequeModel,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxClass, frxDBSet;

type
  TdmTransfBancoCaixa = class(TDataModule)
    qryExisteIdentificacao: TFDQuery;
    qryObterGUID: TFDQuery;
    qryObterTOB: TFDQuery;
    qryChequePorID: TFDQuery;
    qryObterCBD: TFDQuery;
    qryObterTC: TFDQuery;
    qryDeletaCBD: TFDQuery;
    qryDeletaTC: TFDQuery;
    qryUpdateCheque: TFDQuery;

  private
    { Private declarations }
  public
    { Public declarations }
    function obterCheque(pIdOrganizacao, pContaBancaria, pIdCheque :string) :TContaBancariaChequeModel;
    function obterTipoOperacaoBancaria(pIdOrganizacao, pIdTOB: string): TFDQuery;
    function transferenciaBancoCaixa ( pIdOrganizacao,pContaBancaria, pTOB,pResponsavel,pIDCheque, pDescricao, pIdentificacao :string; pValor :Currency; pDataMovimento :TDate) : Boolean;

    //parte do estorno
    function obterCBD(pIdOrganizacao :string; pDataInicial, pDataFinal :TDate):Boolean;
    function obterTC(pIdOrganizacao, pIdCBD :string):Boolean;
    function deletarCBD(pIdOrganizacao, pIdCBD :string):Boolean;
    function deletarTC(pIdOrganizacao, pIdCbd, pIdTC :string) :Boolean;
    function alteraCheque(pIdOrganizacao, pContaBancaria, pIdCheque :string) :Boolean;






  end;

var
  dmTransfBancoCaixa: TdmTransfBancoCaixa;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdmTransfBancoCaixa.alteraCheque(pIdOrganizacao, pContaBancaria,
  pIdCheque: string): Boolean;
begin

   dmConexao.conectarBanco;

   try

    qryUpdateCheque.Close;
    qryUpdateCheque.Connection := dmConexao.conn;
    qryUpdateCheque.ParamByName('PIDCONTA').AsString := pContaBancaria;
    qryUpdateCheque.ParamByName('PIDORGANIZACAO').AsString := pIDOrganizacao;
    qryUpdateCheque.ParamByName('PIDCHEQUE').AsString := pIdCheque;
    qryUpdateCheque.ExecSQL;


     dmConexao.conn.CommitRetaining;

   except
        dmConexao.conn.RollbackRetaining;
        Result :=False;
   raise Exception.Create('Erro alterar dados do cheque ');
   end;
   Result :=True;
end;


function TdmTransfBancoCaixa.obterTC(pIdOrganizacao, pIdCBD: string): Boolean;
begin

  dmConexao.conectarBanco;
  try
    qryObterTC.Close;
    qryObterTC.Connection := dmConexao.conn;
    qryObterTC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterTC.ParamByName('PIDCBD').AsString := pIdCBD;
    qryObterTC.Open;
  except
    raise Exception.Create('Erro ao obter TC');

  end;

  Result := not qryObterTC.IsEmpty;

end;

function TdmTransfBancoCaixa.obterTipoOperacaoBancaria(pIdOrganizacao, pIdTOB: string): TFDQuery;
begin
dmConexao.conectarBanco;
 try

    qryObterTOB.Close;
    qryObterTOB.Connection := dmConexao.Conn;
    qryObterTOB.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterTOB.ParamByName('PIDTOB').AsString := pIdTOB;
    qryObterTOB.Open;


 except
 raise Exception.Create('Erro ao obter TOB');

 end;


 Result := qryObterTOB;


end;

function TdmTransfBancoCaixa.transferenciaBancoCaixa(pIdOrganizacao,
  pContaBancaria, pTOB, pResponsavel, pIDCheque, pDescricao,
  pIdentificacao: string; pValor: Currency; pDataMovimento: TDate): Boolean;
  var
pIDHistorico, pOBS, IDCBD, IDTC, idUsuario, tipoLanc, tipoTOB, cmdCheque, cmdCBD, cmdTC :string;
pDataRegistro :TDate;
qryCBD, qryTC,qryUpdateCheque :TFDQuery;
chequeLiberado :Boolean;
 cheque :TContaBancariaChequeModel;

begin
  try
   chequeLiberado := False;

   IDCBD := dmConexao.obterNewID;
   idUsuario :=uutil.TUserAtual.getUserId;
   tipoLanc := 'D';

   pDataRegistro  := StrToDate(FormatDateTime('DD/MM/YYYY',now ));
   pOBS := ' TRANSF DO BCO P/ TES. ';


   //se for cheque precisa update no cheque

      if not (uUtil.Empty(pIDCheque)) then
      begin
        cheque := TContaBancariaChequeModel.Create;
        cheque := obterCheque(pIdOrganizacao, pContaBancaria, pIDCheque);
          if cheque.FID.Equals(pIDCheque) then
          begin
            if not cheque.FIdTipoStatus.Equals('COMPENSADO') then
            begin
              chequeLiberado := True;
            end;
          end;


            if chequeLiberado then
            begin

              cmdCheque := ' UPDATE CONTA_BANCARIA_CHEQUE ' + ' SET ID_TIPO_STATUS = ''COMPENSADO'', ' + ' VALOR = :PVALOR , ' +
                           ' DATA_EMISSAO = :PDTEMISSAO , ' + ' DATA_COMPENSACAO = :PDTCOMPENSADO , ' +
                           ' DATA_PREVISAO_COMPENSACAO = :PDTPREVISAO , ' + ' OBSERVACAO = :POBS ,' + ' PORTADOR = :PPORTADOR ' +
                           ' WHERE (ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE) ' +
                           ' AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';
                try
                qryUpdateCheque := TFDQuery.Create(Self);
                qryUpdateCheque.Close;
                qryUpdateCheque.Connection := dmConexao.conn;
                qryUpdateCheque.SQL.Clear;
                qryUpdateCheque.SQL.Add(cmdCheque);

                qryUpdateCheque.ParamByName('PIDCHEQUE').AsString := pIDCheque;
                qryUpdateCheque.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
                qryUpdateCheque.ParamByName('PVALOR').AsCurrency := pValor;

                qryUpdateCheque.ParamByName('POBS').AsString := pOBS;
                qryUpdateCheque.ParamByName('PPORTADOR').AsString := uutil.TOrgAtual.getRazaoSocial;
                qryUpdateCheque.ParamByName('PDTEMISSAO').AsDate := pDataMovimento;
                qryUpdateCheque.ParamByName('PDTCOMPENSADO').AsDate := pDataMovimento;
                qryUpdateCheque.ParamByName('PDTPREVISAO').AsDate := pDataMovimento;

                qryUpdateCheque.ExecSQL;
                 dmConexao.conn.CommitRetaining;

                except                                                     //chamar o DAO P fazer isso
                 dmConexao.conn.RollbackRetaining;
                 Result := False;
                raise Exception.Create('Erro ao alterar dados do cheque ' + cheque.FNumeroCheque );
                end;
            end; //fim do begin do cheque
      end; // fim da parte do cheque

   //insere CBD

    qryCBD := TFDQuery.Create(Self); //insere na conta bancaria debito

    cmdCBD := ' INSERT INTO CONTA_BANCARIA_DEBITO (ID_CONTA_BANCARIA_DEBITO, ID_ORGANIZACAO, ID_CONTA_BANCARIA,  '+
              ' ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, ID_CONTA_BANCARIA_CHEQUE, ID_USUARIO, '+
              ' TIPO_LANCAMENTO, OBSERVACAO, DESCRICAO, VALOR, DATA_REGISTRO, DATA_MOVIMENTO, IDENTIFICACAO ) ' +
              ' VALUES (:PID, :PIDORGANIZACAO, :PIDCONTA, :PIDTOB, :PIDRESPONSAVEL, :PIDCHEQUE, :PIDUSUARIO,  ' +
              ' :PTIPOLANC, :POBS, :PDESCRICAO, :PVALOR, :PDTREGISTRO, :PDTMOVIMENTO, :PIDENTIFICACAO );' ;

    try
      qryCBD.Close;
      qryCBD.Connection := dmConexao.conn;
      qryCBD.SQL.Clear;
      qryCBD.SQL.Add(cmdCBD);
      qryCBD.ParamByName('PVALOR').AsCurrency := pValor;
      qryCBD.ParamByName('PID').AsString := IDCBD;
      qryCBD.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryCBD.ParamByName('PIDCONTA').AsString := pContaBancaria;
      qryCBD.ParamByName('PIDTOB').AsString := pTOB;
      qryCBD.ParamByName('PIDRESPONSAVEL').AsString := pResponsavel;
      qryCBD.ParamByName('PDESCRICAO').AsString := pDescricao ;
      if not (uUtil.Empty(pIDCheque)) then  begin
        qryCBD.ParamByName('PIDCHEQUE').AsString := pIDCheque;
        qryCBD.ParamByName('PDESCRICAO').AsString := pDescricao + ' CH ' + cheque.FNumeroCheque;
      end;
      qryCBD.ParamByName('PIDUSUARIO').AsString := idUsuario;
      qryCBD.ParamByName('PTIPOLANC').AsString := tipoLanc;
      qryCBD.ParamByName('POBS').AsString := pOBS;
      qryCBD.ParamByName('PIDENTIFICACAO').AsString := dmConexao.obterIdentificador(pIdOrganizacao, 'CBD');
      qryCBD.ParamByName('PDTREGISTRO').AsDate := pDataRegistro;
      qryCBD.ParamByName('PDTMOVIMENTO').AsDate := pDataMovimento;

      qryCBD.ExecSQL;
      dmConexao.conn.CommitRetaining;
    except
      dmConexao.conn.RollbackRetaining;
      Result := False;
      raise Exception.Create('Erro ao debitar na conta bancária');
    end;

    try
      IDTC := dmConexao.obterNewID; //para a TC
      pIDHistorico := 'TRANSFERE BANCO/TESOURARIA';

      cmdTC := ' INSERT INTO TESOURARIA_CREDITO (ID_TESOURARIA_CREDITO, ID_ORGANIZACAO, ID_HISTORICO, ID_RESPONSAVEL, ' +
               ' DATA_REGISTRO, DATA_CONTABIL, DATA_MOVIMENTO, VALOR_NOMINAL, OBSERVACAO, NUMERO_DOCUMENTO, DESCRICAO, ' +
               ' TIPO_LANCAMENTO, ID_USUARIO, ID_CONTA_BANCARIA_DEBITO, ID_SACADO) ' +
               ' VALUES (:PIDTC, :PIDORGANIZACAO, :PIDHISTORICO, :PIDRESPONSAVEL, :PDTREGISTRO, :PDTCONTABIL, :PDTMOVIMENTO, '+
               ' :PVALOR, :POBS, :PNUMDOC, :PDESCRICAO, ''C'', :PIDUSUARIO, :PIDCBD, :PIDSACADO  )' ;


      qryTC := TFDQuery.Create(Self); // insere na tesouraria credito
      qryTC.Close;
      qryTC.Connection := dmConexao.conn;
      qryTC.SQL.Clear;
      qryTC.SQL.Add(cmdTC);

      qryTC.ParamByName('PVALOR').AsCurrency := pValor;
      qryTC.ParamByName('PIDTC').AsString := IDTC;
      qryTC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTC.ParamByName('PIDCBD').AsString := IDCBD;
      qryTC.ParamByName('PIDUSUARIO').AsString := uUtil.TUserAtual.getUserId;
      qryTC.ParamByName('PIDSACADO').AsString := pIdOrganizacao;

      qryTC.ParamByName('PIDHISTORICO').AsString := pIDHistorico;
      qryTC.ParamByName('PIDRESPONSAVEL').AsString := pResponsavel;
      qryTC.ParamByName('PDTREGISTRO').AsDate := pDataRegistro;
      qryTC.ParamByName('PDTMOVIMENTO').AsDate := pDataMovimento;
      qryTC.ParamByName('PDTCONTABIL').AsDate := pDataMovimento;
      qryTC.ParamByName('POBS').AsString := pOBS;
      qryTC.ParamByName('PDESCRICAO').AsString := pDescricao ;

      if not (uUtil.Empty(pIDCheque)) then  begin
       qryTC.ParamByName('PDESCRICAO').AsString := pDescricao + ' CH ' + cheque.FNumeroCheque;
      end;

      qryTC.ParamByName('PNUMDOC').AsString := dmConexao.obterIdentificador(pIdOrganizacao, 'TC');

      qryTC.ExecSQL;
      dmConexao.conn.CommitRetaining;

    except
      dmConexao.conn.RollbackRetaining;
      Result := False;
      raise Exception.Create('Erro ao creditar na tesouraria.');
    end;


  except
  dmConexao.conn.RollbackRetaining;
  Result :=False;
  raise Exception.Create(' Não foi possível realizar a transferência.');
  end;

    Result :=True;

end;


function TdmTransfBancoCaixa.deletarCBD(pIdOrganizacao,
  pIdCBD: string): Boolean;
begin
  dmConexao.conectarBanco;
  try

    qryDeletaCBD.Close;
    qryDeletaCBD.Connection := dmConexao.conn;
    qryDeletaCBD.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryDeletaCBD.ParamByName('PIDCBD').AsString := pIdCBD;
    qryDeletaCBD.ExecSQL;

    dmConexao.conn.CommitRetaining;

  except
    dmConexao.conn.RollbackRetaining;
    Result := False;
    raise Exception.Create('Erro ao deletar CBD');

  end;
  Result := True;
end;




function TdmTransfBancoCaixa.deletarTC(pIdOrganizacao, pIdCbd,
  pIdTC: string): Boolean;
begin
 dmConexao.conectarBanco;
  try

    qryDeletaTC.Close;
    qryDeletaTC.Connection := dmConexao.conn;
    qryDeletaTC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryDeletaTC.ParamByName('PIDCBD').AsString := pIdCBD;
    qryDeletaTC.ParamByName('PIDTC').AsString := pIdTC;

    qryDeletaTC.ExecSQL;

    dmConexao.conn.CommitRetaining;

  except
    dmConexao.conn.RollbackRetaining;
    Result := False;
    raise Exception.Create('Erro ao deletar CBD');

  end;
  Result := True;


end;

function TdmTransfBancoCaixa.obterCBD(pIdOrganizacao: string; pDataInicial,
  pDataFinal: TDate): Boolean;
begin
   dmConexao.conectarBanco;
try

  qryObterCBD.Close;
  qryObterCBD.Connection := dmConexao.conn;
  qryObterCBD.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterCBD.ParamByName('PDTINICIAL').AsDate := pDataInicial;
  qryObterCBD.ParamByName('PDTFINAL').AsDate := pDataFinal;
  qryObterCBD.Open;


except
raise Exception.Create('Erro ao obter CBD');

end;


  Result := not qryObterCBD.IsEmpty;
end;

function TdmTransfBancoCaixa.obterCheque(pIdOrganizacao, pContaBancaria, pIdCheque: string): TContaBancariaChequeModel;
var
cheque : TContaBancariaChequeModel;

begin
   cheque :=TContaBancariaChequeModel.Create;
   dmConexao.conectarBanco;

   try

    qryChequePorID.Close;
    qryChequePorID.Connection := dmConexao.conn;
    qryChequePorID.ParamByName('PIDCONTA').AsString := pContaBancaria;
    qryChequePorID.ParamByName('PIDORGANIZACAO').AsString := pIDOrganizacao;
    qryChequePorID.ParamByName('PIDCHEQUE').AsString := pIdCheque;

    qryChequePorID.Open;

     if not  qryChequePorID.IsEmpty then begin
      cheque.FIdCheque                := (qryChequePorID.FieldByName('id_conta_bancaria_cheque').AsString);
      cheque.FIdOrganizacao           := (qryChequePorID.FieldByName('id_organizacao').AsString);
      cheque.FIdContaBancaria         := (qryChequePorID.FieldByName('id_conta_bancaria').AsString);
      cheque.FIdFuncionario           := (qryChequePorID.FieldByName('id_funcionario').AsString);
      cheque.FIdTipoStatus            := (qryChequePorID.FieldByName('id_tipo_status').AsString);
      cheque.FNumeroCheque            := (qryChequePorID.FieldByName('numero_cheque').AsString);
      cheque.FObservacao              := (qryChequePorID.FieldByName('observacao').AsString);
      cheque.FPortador                := (qryChequePorID.FieldByName('portador').AsString);
      cheque.FIdUsuario               := (qryChequePorID.FieldByName('id_usuario').AsString);
      cheque.FDataPrevisaoCompensacao := (qryChequePorID.FieldByName('data_previsao_compensacao').AsDateTime);
      cheque.FDataEstorno             := (qryChequePorID.FieldByName('data_estorno').AsDateTime);
      cheque.FDataRegistro            := (qryChequePorID.FieldByName('data_registro').AsDateTime);
      cheque.FDataEmissao             := (qryChequePorID.FieldByName('data_emissao').AsDateTime);
      cheque.FDataCompensacao         := (qryChequePorID.FieldByName('data_compensacao').AsDateTime);
      cheque.FValor                   := (qryChequePorID.FieldByName('valor').AsCurrency);
      cheque.FQtdImpressao            := (qryChequePorID.FieldByName('qtd_impressao').AsInteger);

     end;


   except
   raise Exception.Create('Erro ao obter cheque por ID');

   end;

   Result := cheque;
end;








end.
