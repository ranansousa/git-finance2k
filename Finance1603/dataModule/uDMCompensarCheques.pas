unit uDMCompensarCheques;

interface

uses
  System.SysUtils, System.Classes, udmConexao, uUtil, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmCompensarCheques = class(TDataModule)
    qryObterCheque: TFDQuery;
    qryListaChequesPorCB: TFDQuery;
    qryTPBBAIXA: TFDQuery;
    qryInsereCBD: TFDQuery;
    qryCheckIdent: TFDQuery;
    qryUpdateCheque: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
   idUser, iDOrganizacao :string;
    function compensarCheque(pIdOrganizacao, pIdCheque, pIdContaBancaria,
      pIdTipoOPeracao, pIdResponsavel, pIdTP, pDescricaoTP: string;
      pValor: Currency; pDataMovimento: TDate): Boolean;
    function gerarIdentificador(pDate: TDate): string;

  public
    { Public declarations }
    function obterChequePorId(pIdOrganizacao, pIdCheque: string): Boolean;
    function obterDadosBaixaTP(pIdOrganizacao, pIdCheque: string): Boolean;
    function updateChequeEmitido(pIdCheque: string;pDataCompensado: TDateTime): Boolean;
    function verificaSeExistIdentificador(pIdent: string): Integer;

  end;

var
  dmCompensarCheques: TdmCompensarCheques;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmCompensarCheques.DataModuleCreate(Sender: TObject);
begin

  dmConexao.conectarBanco;
    iDOrganizacao := TOrgAtual.getId;
    idUser := IntToStr(uutil.TUserAtual.getUserId);

end;


function TdmCompensarCheques.obterChequePorId(pIdOrganizacao,
  pIdCheque: string): Boolean;
begin
dmConexao.conectarBanco;

      qryObterCheque.Close;
      qryObterCheque.Connection :=dmConexao.conn;
      qryObterCheque.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterCheque.ParamByName('PIDCHEQUE').AsString := pIdCheque;
      qryObterCheque.Open;

  Result := not qryObterCheque.IsEmpty;
end;


function TdmCompensarCheques.obterDadosBaixaTP(pIdOrganizacao,  pIdCheque: string): Boolean;
begin
dmConexao.conectarBanco;
  //obtem dados do TP em que o cheque foi usado

      qryTPBBAIXA.Close;
      qryTPBBAIXA.Connection :=dmConexao.conn;
      qryTPBBAIXA.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTPBBAIXA.ParamByName('PIDCHEQUE').AsString := pIdCheque;
      qryTPBBAIXA.Open;


  Result := not qryTPBBAIXA.IsEmpty;

end;

function TdmCompensarCheques.verificaSeExistIdentificador(
  pIdent: string): Integer;

begin
  dmConexao.conectarBanco;

   qryCheckIdent.Close;
   qryCheckIdent.Connection := dmConexao.conn;
   qryCheckIdent.ParamByName('PIDENT').AsString := pIdent;
   qryCheckIdent.Open;


   Result := qryCheckIdent.FieldByName('QTD').AsInteger;


end;

function TdmCompensarCheques.updateChequeEmitido(pIdCheque :string; pDataCompensado :TDateTime) : Boolean;
begin

   dmConexao.conectarBanco;
  try
    qryUpdateCheque.Close;
    qryUpdateCheque.Connection := dmConexao.conn;
    qryUpdateCheque.ParamByName('PIDORGANIZACAO').AsString := iDOrganizacao;
    qryUpdateCheque.ParamByName('PIDCHEQUE').AsString      := pIdCheque;
    qryUpdateCheque.ParamByName('PDATACOMPENSADO').AsDate  := pDataCompensado;
    qryUpdateCheque.ParamByName('PSTATUS').AsString  := 'COMPENSADO';


    qryUpdateCheque.ExecSQL;


    Result :=System.True;

  except
   qryUpdateCheque.Connection.RollbackRetaining;
   raise Exception.Create('Não foi possível compensar o cheque.' + 'updateChequeEmitido' );

  end;

end;


function TdmCompensarCheques.compensarCheque(pIdOrganizacao, pIdCheque,pIdContaBancaria, pIdTipoOPeracao, pIdResponsavel, pIdTP,
  pDescricaoTP: string; pValor: Currency; pDataMovimento: TDate): Boolean;
  var
comando,  tipoLancamento, chequeDescricao, idCBD, userId, idTipoStatus, identificacao : string;
  pDataRegistro : TDateTime;
begin

  userId := IntToStr(uutil.TUserAtual.getUserId);
  idCBD  := dmConexao.obterNewID;
  idTipoStatus  :='COMPENSADO';
  identificacao := gerarIdentificador(Now);
  chequeDescricao := ' Documento ' +  pDescricaoTP;
  pDataRegistro := Now;
  tipoLancamento := 'D';

   dmConexao.conectarBanco;


   try
    dmConexao.conn.StartTransaction;

  //altera o status do cheque

    if (updateChequeEmitido(pIdCheque, pDataMovimento)) then begin


    comando :=' INSERT INTO CONTA_BANCARIA_DEBITO (ID_CONTA_BANCARIA_DEBITO, ID_ORGANIZACAO, ID_CONTA_BANCARIA, ' +
              ' ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, ID_TITULO_PAGAR, ID_CONTA_BANCARIA_CHEQUE, ' +
              ' TIPO_LANCAMENTO, DESCRICAO, VALOR, DATA_REGISTRO, DATA_MOVIMENTO, IDENTIFICACAO, ID_USUARIO) ' +
              ' VALUES (:PID, :PIDORGANIZACAO, :PIDCONTABANCARIA, :PIDTOB, :PIDRESPONSAVEL, :PIDTP, :PIDCHEQUE, ' +
              ' :PLANCAMENTO, :PDESC, :PVALOR, :PDTREGISTRO, :PDTMOVIMENTO, :PIDENTIFICACAO, :PIDUSER )' ;


        // insere lancamento em CBD

         qryInsereCBD.Close;
         qryInsereCBD.Connection := dmConexao.Conn;
         qryInsereCBD.SQL.Clear;
         qryInsereCBD.SQL.Add(comando);

         qryInsereCBD.ParamByName('PID').AsString := idCBD;
         qryInsereCBD.ParamByName('PIDORGANIZACAO').AsString := iDOrganizacao;
         qryInsereCBD.ParamByName('PIDCONTABANCARIA').AsString := pIdContaBancaria;
         qryInsereCBD.ParamByName('PIDTOB').AsString := pIdTipoOPeracao;
         qryInsereCBD.ParamByName('PIDRESPONSAVEL').AsString := pIdResponsavel;
         qryInsereCBD.ParamByName('PIDTP').AsString := pIdTP;
         qryInsereCBD.ParamByName('PIDCHEQUE').AsString := pIdCheque;
         qryInsereCBD.ParamByName('PLANCAMENTO').AsString := tipoLancamento;
         qryInsereCBD.ParamByName('PDESC').AsString := pDescricaoTP;
         qryInsereCBD.ParamByName('PVALOR').AsCurrency := pValor;
         qryInsereCBD.ParamByName('PDTREGISTRO').AsDate := pDataRegistro;
         qryInsereCBD.ParamByName('PDTMOVIMENTO').AsDate:= pDataMovimento;
         qryInsereCBD.ParamByName('PIDENTIFICACAO').AsString := identificacao;
         qryInsereCBD.ParamByName('PIDUSER').AsString := userId;

         qryInsereCBD.ExecSQL;
         dmConexao.conn.CommitRetaining;
       //  dmConexao.conn.Transaction.CommitRetaining;

    end;

   except
        raise Exception.Create('Problemas ao tentar gerar CBD');
//        dmConexao.conn.RollbackRetaining;
            dmConexao.conn.RollbackRetaining;

   end;

end;

function TdmCompensarCheques.gerarIdentificador(pDate: TDate): string;
var
 dia,mes,ano, ident :string;
 identAux : Integer;
begin
      // gera e verifica se existe esse identificador na table CBD

   dia := formatdatetime('dd', pDate);
   mes := formatdatetime('mm', pDate);
   ano := formatdatetime('yy', pDate);

   ident := dia  + mes + ano + '0'+'1';
   identAux := StrToInt(ident);

   while (verificaSeExistIdentificador(ident)) > 0 do begin
          Inc(identAux);
          ident := IntToStr(identAux);
   end;


 Result := ident;
end;



end.
