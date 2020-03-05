unit uDMContaBancariaTransferencia;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, uUtil,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, System.DateUtils,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uContaBancariaDBModel,uContaBancariaDebitoDAO,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmCBT = class(TDataModule)
    qryObterPorPeriodo: TFDQuery;
    qryExisteIdentificacao: TFDQuery;
    qryObterIDContaBancaria: TFDQuery;
    qryInsereCBT: TFDQuery;
    qryInsereCBDESTINO: TFDQuery;
    qryObterGUID: TFDQuery;
    qryInsereCBORIGEM: TFDQuery;
    qryObterTRFPORID: TFDQuery;
    qryDeletaCBT: TFDQuery;
    qrySaldoCredito: TFDQuery;
    qrySaldoDebito: TFDQuery;
  private
    { Private declarations }

    pIdOrganizacao :string;
    procedure inicializarDM(Sender: TObject);
    function obterSaldoPorContaCredito(pIdOrganizacao, pIDConta: string;
      pDataInicial, pDataFinal: TDate): Currency;
    function obterSaldoPorContaDebito(pIdOrganizacao, pIDConta: string;
      pDataInicial, pDataFinal: TDate): Currency;


  public
    { Public declarations }
    function obterSaldoContaBancaria(pIdOrganizacao, pIDConta: string;   pDataInicial, pDataFinal: TDate): Currency;
    function obterPorPeriodo(pIdOrganizacao: String; dtDataInicial, dtDataFinal: TDateTime): Boolean;

    function obterIDContaBancaria(pIdOrganizacao,pIDConta :string): string;
    function obterTransferencia(pIdOrganizacao,pIDTRF :string): Boolean;
    function deletaTRF(pIdOrganizacao,pTable, pID :string): Boolean;


    function insereCBT(PID, PIDORGANIZACAO, PIDCONTDESTINO, PIDCONTAORIGEM, PIDTIPO, PIDRESP, PIDIDENT, POBS, PDESCRICAO :string; PIDUSUARIO:Integer; PVALOR: Currency; PDTREGISTRO, PDTMOVIMENTO :TDate) :Boolean;
    function insereCBDestino(ID_CONTA_BANCARIA_CREDITO, ID_ORGANIZACAO, ID_CONTA_BANCARIA, ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, TIPO_LANCAMENTO, DESCRICAO :string; ID_USUARIO :Integer; VALOR :Currency; DATA_REGISTRO, DATA_MOVIMENTO :TDate ) :Boolean;
    function insereCBOrigem (ID_CONTA_BANCARIA_DEBITO,  ID_ORGANIZACAO, ID_CONTA_BANCARIA, ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, TIPO_LANCAMENTO, DESCRICAO  :string; ID_USUARIO :Integer; VALOR :Currency; DATA_REGISTRO, DATA_MOVIMENTO :TDate ) :Boolean;

  end;

var
  dmCBT: TdmCBT;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TDataModule1 }

function TdmCBT.deletaTRF(pIdOrganizacao, pTable, pID: string): Boolean;
var
cmd :string;
begin
    cmd :=' DELETE FROM  CONTA_BANCARIA_TRANSFERENCIA CBT '+
          ' WHERE  (CBT.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
          ' AND  (CBT.ID_CONTA_BANCARIA_TRANSFERENCIA = :PID) ';


     if pTable.Equals('CONTA_BANCARIA_CREDITO') then begin

       cmd :=' DELETE FROM  CONTA_BANCARIA_CREDITO CBC '+
          ' WHERE  (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
          ' AND  (CBC.ID_CONTA_BANCARIA_CREDITO = :PID) ';
     end;


      if pTable.Equals('CONTA_BANCARIA_DEBITO') then begin

       cmd :=' DELETE FROM  CONTA_BANCARIA_DEBITO CBD '+
          ' WHERE  (CBD.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
          '   AND  (CBD.ID_CONTA_BANCARIA_DEBITO = :PID) ';
     end;

      try

        qryDeletaCBT.Close;
        qryDeletaCBT.SQL.Clear;
        qryDeletaCBT.SQL.Add(cmd);
        qryDeletaCBT.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryDeletaCBT.ParamByName('PID').AsString := PID;
        qryDeletaCBT.ExecSQL;

        dmConexao.conn.CommitRetaining;

      except
        dmConexao.conn.RollbackRetaining;
        raise Exception.Create('Erro ao deletar ' + pTable + ' ID ' + pID);

      end;

      Result := System.True;

end;

procedure TdmCBT.inicializarDM(Sender: TObject);
begin
 dmConexao.conectarBanco;
 pIdOrganizacao := uUtil.TOrgAtual.getId;

end;

function TdmCBT.insereCBDestino(ID_CONTA_BANCARIA_CREDITO, ID_ORGANIZACAO,
  ID_CONTA_BANCARIA, ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, TIPO_LANCAMENTO,
  DESCRICAO: string; ID_USUARIO: Integer; VALOR: Currency;
  DATA_REGISTRO, DATA_MOVIMENTO: TDate): Boolean;
var
pIdentificadorCBC,cmdCBC :string;

begin
 dmConexao.conectarBanco;

 try

     pIdentificadorCBC := dmConexao.obterIdentificador('',ID_ORGANIZACAO,'CBC');
      //inserir cbc
      cmdCBC := ' INSERT INTO CONTA_BANCARIA_CREDITO (IDENTIFICACAO, ID_CONTA_BANCARIA_CREDITO, ID_ORGANIZACAO, ID_CONTA_BANCARIA, ID_TIPO_OPERACAO_BANCARIA, '+
                ' ID_RESPONSAVEL, TIPO_LANCAMENTO, DESCRICAO, VALOR, DATA_REGISTRO, DATA_MOVIMENTO,  ID_USUARIO) ' +
                ' VALUES (:PIDENT,:PID, :PIDORGANIZACAO, :PIDCONTABANCARIA, :PIDTIPO, :PIDRESP, :PTIPO, :PDESCRICAO, :PVALOR, :PDTREGISTRO, :PDTMOVIMENTO, :PUSUARIO) ' ;

    qryInsereCBDESTINO.Close;
    qryInsereCBDESTINO.Connection := dmConexao.conn;
    qryInsereCBDESTINO.SQL.Clear;
    qryInsereCBDESTINO.SQL.Add(cmdCBC);

    qryInsereCBDESTINO.ParamByName('PIDENT').AsString := pIdentificadorCBC;
    qryInsereCBDESTINO.ParamByName('PID').AsString := ID_CONTA_BANCARIA_CREDITO;
    qryInsereCBDESTINO.ParamByName('PIDORGANIZACAO').AsString := ID_ORGANIZACAO;
    qryInsereCBDESTINO.ParamByName('PIDCONTABANCARIA').AsString := ID_CONTA_BANCARIA;
    qryInsereCBDESTINO.ParamByName('PTIPO').AsString := TIPO_LANCAMENTO;
    qryInsereCBDESTINO.ParamByName('PIDTIPO').AsString := ID_TIPO_OPERACAO_BANCARIA;
    qryInsereCBDESTINO.ParamByName('PIDRESP').AsString := ID_RESPONSAVEL;
    qryInsereCBDESTINO.ParamByName('PDESCRICAO').AsString := DESCRICAO;
    qryInsereCBDESTINO.ParamByName('PVALOR').AsCurrency := VALOR;
    qryInsereCBDESTINO.ParamByName('PDTREGISTRO').AsDate := DATA_REGISTRO;
    qryInsereCBDESTINO.ParamByName('PDTMOVIMENTO').AsDate := DATA_MOVIMENTO;
    qryInsereCBDESTINO.ParamByName('PUSUARIO').AsInteger := ID_USUARIO;

    qryInsereCBDESTINO.ExecSQL;

    dmConexao.conn.CommitRetaining;

        Result := System.True;
 except
     dmConexao.conn.RollbackRetaining;

  raise Exception.Create('Erro ao inserir CBDESTINO');

 end;
end;

function TdmCBT.insereCBOrigem(ID_CONTA_BANCARIA_DEBITO, ID_ORGANIZACAO,
  ID_CONTA_BANCARIA, ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, TIPO_LANCAMENTO,
  DESCRICAO: string; ID_USUARIO: Integer; VALOR: Currency; DATA_REGISTRO,
  DATA_MOVIMENTO: TDate): Boolean;
var
pIdentificadorCBD, cmdCBD :string;
 contaDebito : TContaBancariaDBModel;
begin
 dmConexao.conectarBanco;

 try



  pIdentificadorCBD := dmConexao.obterIdentificador('',ID_ORGANIZACAO,'CBD');
      //inserir cbd
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

   // qryInsereCBORIGEM.ExecSQL;  //suspenso em 18/01 p testar o DAO

    contaDebito := TContaBancariaDBModel.Create;
    contaDebito.FID               := ID_CONTA_BANCARIA_DEBITO;
    contaDebito.FIDorganizacao    := ID_ORGANIZACAO;
    contaDebito.FIDcontaBancaria  := ID_CONTA_BANCARIA;
    contaDebito.FIDTOB            := ID_TIPO_OPERACAO_BANCARIA;
    contaDebito.FIDResponsavel    := ID_RESPONSAVEL;
    contaDebito.Fidentificacao    := pIdentificadorCBD;
    contaDebito.FtipoLancamento   := TIPO_LANCAMENTO;
    contaDebito.Fdescricao        := DESCRICAO;
    contaDebito.Fvalor            := VALOR;
    contaDebito.FdataRegistro     := DATA_REGISTRO;
    contaDebito.FdataMovimento    := DATA_MOVIMENTO;
    contaDebito.FIDusuario        := IntToStr(ID_USUARIO);

   if  TContaBancariaDebitoDAO.Insert(contaDebito) then begin

      Result := System.True;

   end;



    dmConexao.conn.CommitRetaining;



 except
     dmConexao.conn.RollbackRetaining;

  raise Exception.Create('Erro ao inserir CBDESTINO');

 end;
end;



function TdmCBT.insereCBT(PID, PIDORGANIZACAO, PIDCONTDESTINO, PIDCONTAORIGEM, PIDTIPO,
  PIDRESP, PIDIDENT, POBS, PDESCRICAO: string; PIDUSUARIO: Integer; PVALOR: Currency;
  PDTREGISTRO, PDTMOVIMENTO: TDate): Boolean;

  var
  cmdCBT, pIdCBOrigem,pIdCBDestino :string;
  pIdentificadorCBT, pIdentificadorCBC, pIdentificadorCBD :string;

begin
 dmConexao.conectarBanco;

 try
    dmConexao.conn.StartTransaction;
    PIDORGANIZACAO := uUtil.TOrgAtual.getId;

     pIdCBDestino      := dmConexao.obterNewID;
     pIdentificadorCBT := dmConexao.obterIdentificador('',PIDORGANIZACAO,'CBT');


    if insereCBDestino(pIdCBDestino,PIDORGANIZACAO, PIDCONTDESTINO, PIDTIPO,PIDRESP,'C',PDESCRICAO,PIDUSUARIO, PVALOR, PDTREGISTRO, PDTMOVIMENTO ) then begin
       pIdCBOrigem  := dmConexao.obterNewID;

       if insereCBOrigem (pIdCBOrigem,PIDORGANIZACAO, PIDCONTAORIGEM, PIDTIPO,PIDRESP,'D',PDESCRICAO,PIDUSUARIO, PVALOR, PDTREGISTRO, PDTMOVIMENTO )   then begin

          //inserir cbt
            cmdCBT := ' INSERT INTO CONTA_BANCARIA_TRANSFERENCIA  (ID_CONTA_BANCARIA_TRANSFERENCIA, ID_ORGANIZACAO, ' +
                      ' ID_CONTA_BANCARIA_CREDITO, ID_CONTA_BANCARIA_DEBITO, ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, '+
                      ' ID_USUARIO, IDENTIFICACAO,  OBSERVACAO, VALOR, DATA_REGISTRO, DATA_MOVIMENTO ) '+
                      ' VALUES (:PID, :PIDORGANIZACAO, :PIDCONTACR, :PIDCONTADB, :PIDTIPO, :PIDRESP, :PIDUSUARIO, :PIDIDENT, '+
                      ' :POBS,:PVALOR, :PDTREGISTRO, :PDTMOVIMENTO)';

                    qryInsereCBT.Close;
                    qryInsereCBT.Close;
                    qryInsereCBT.Connection := dmConexao.conn;
                    qryInsereCBT.SQL.Clear;
                    qryInsereCBT.SQL.Add(cmdCBT);
                    qryInsereCBT.ParamByName('PID').AsString := PID;
                    qryInsereCBT.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
                    qryInsereCBT.ParamByName('PIDCONTACR').AsString := pIdCBDestino;
                    qryInsereCBT.ParamByName('PIDCONTADB').AsString := pIdCBOrigem;
                    qryInsereCBT.ParamByName('PIDTIPO').AsString := PIDTIPO;
                    qryInsereCBT.ParamByName('PIDRESP').AsString := PIDRESP;
                    qryInsereCBT.ParamByName('PIDIDENT').AsString := pIdentificadorCBT;
                    qryInsereCBT.ParamByName('POBS').AsString := POBS;
                    qryInsereCBT.ParamByName('PVALOR').AsCurrency := PVALOR;
                    qryInsereCBT.ParamByName('PDTREGISTRO').AsDate := PDTREGISTRO;
                    qryInsereCBT.ParamByName('PDTMOVIMENTO').AsDate := PDTMOVIMENTO;
                    qryInsereCBT.ParamByName('PIDUSUARIO').AsInteger :=  PIDUSUARIO;

                    qryInsereCBT.ExecSQL;




       end; // fim insere origem


    end; // fim do insere destino



    dmConexao.conn.CommitRetaining;


 except
     dmConexao.conn.RollbackRetaining;

  raise Exception.Create('Erro ao inserir CBT');

 end;

end;


function TdmCBT.obterIDContaBancaria(pIdOrganizacao, pIDConta: string): string;
var
pID:string;
begin


try
  qryObterIDContaBancaria.Close;
  qryObterIDContaBancaria.Connection := dmConexao.Conn;
  qryObterIDContaBancaria.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterIDContaBancaria.ParamByName('PIDCB').AsString := pIDConta;
  qryObterIDContaBancaria.Open;

  pID := qryObterIDContaBancaria.FieldByName('ID').AsString;

except
  raise Exception.Create('Erro ao obter ID da conta bancária.');

end;
  Result :=pID;
end;

function TdmCBT.obterPorPeriodo(pIdOrganizacao: String;
  dtDataInicial, dtDataFinal: TDateTime): Boolean;
begin

try
  qryObterPorPeriodo.Close;
  qryObterPorPeriodo.Connection := dmConexao.Conn;

  qryObterPorPeriodo.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterPorPeriodo.ParamByName('DTDATAINICIAL').AsDateTime := dtDataInicial;
  qryObterPorPeriodo.ParamByName('DTDATAFINAL').AsDateTime := dtDataFinal;
  qryObterPorPeriodo.Open;
  qryObterPorPeriodo.Last;

except
  raise Exception.Create('Erro ao obter transferências no período.');

end;

  Result := not qryObterPorPeriodo.IsEmpty;

end;

function TdmCBT.obterTransferencia(pIdOrganizacao, pIDTRF: string): Boolean;
begin

try
  qryObterTRFPORID.Close;
  qryObterTRFPORID.Connection := dmConexao.Conn;
  qryObterTRFPORID.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterTRFPORID.ParamByName('PIDCBT').AsString := pIDTRF;
  qryObterTRFPORID.Open;

except
  raise Exception.Create('Erro ao obter transferências por chave.');

end;

  Result := not qryObterTRFPORID.IsEmpty;


end;


function TdmCBT.obterSaldoContaBancaria(pIdOrganizacao, pIDConta: string;  pDataInicial, pDataFinal: TDate): Currency;
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

function TdmCBT.obterSaldoPorContaCredito(pIdOrganizacao, pIDConta: string;
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



function TdmCBT.obterSaldoPorContaDebito(pIdOrganizacao, pIDConta: string;
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
