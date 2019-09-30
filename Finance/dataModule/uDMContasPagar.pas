unit uDMContasPagar;

interface

uses
  // System.SysUtils, System.Classes,uDM, Data.DB;
  System.SysUtils, System.Variants, Vcl.Forms,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, uUtil, uDMOrganizacao,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands, udmConexao, FireDAC.Stan.Util,
  FireDAC.Comp.Script,
  System.Classes;

type
  TdmContasPagar = class(TDataModule)
    qryRelPagamentos: TFDQuery;
    qryCentroCusto: TFDQuery;
    sqlScriptContainer: TFDScript;
    qryObterTPHistoricoPorTitulo: TFDQuery;
    qryObterCentroCustoPorTitulo: TFDQuery;
    qryTotalDebitoPorFornecedor: TFDQuery;
    qryTotalQuitadoPorFornecedor: TFDQuery;
    dtsTitulosPagarAll: TDataSource;
    qryTitulosPorFornecedor: TFDQuery;
    qryObterTodos: TFDQuery;
    qryObterPorNumeroDocumento: TFDQuery;
    qryTitulosExcel: TFDQuery;
    dtsTitulosExcel: TDataSource;
    dtsTituloPagarExcel: TDataSource;
    qryObterTotalPorStatus: TFDQuery;
    qryDeletaExcluidos: TFDQuery;
    qryAlteraNumDoc: TFDQuery;


  private
    { Private declarations }
    codigoErro :string;
    procedure inicializarDM(Sender: TObject);

  public
 {   { Public declarations }
    procedure DataModuleCreate(Sender: TObject);
    function dataSourceIsEmpty(var dts: TDataSource): Boolean;

    function obterTotalPorFornecedor(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
    function obterTotalQuitadoPorFornecedor(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
    function obterTitulosPorFornecedor(pIdOrganizacao, pIdCedente, campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;

    function obterTodos(pIdOrganizacao: string): Boolean;
    function obterPorNumeroDocumento(pIdOrganizacao, pNumDoc: string): Boolean;
    function obterTitulosExcel(pIdOrganizacao: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
    function obterTotalPorStatus(pIdOrganizacao, pIdStatus: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
    function obterHistoricoPorTP(pIdOrganizacao, pIdTitulo: string): Boolean;
    function obterCentroCustoPorTP(pIdOrganizacao, pIdTitulo: string): Boolean;



    function obterRelPagamentos(pIdOrganizacao: string): Boolean;

    function deletarTitulosPorTipoStatus(pidOrganizacao,
      status: String): Boolean;

      function alterarNumDocTP(pidOrganizacao,
      pId, pNumero: String): Boolean;



  {
    //TP PRovisionado
    function obterTPProBase(pIdOrganizacao : string; pDataInicial, pDataFinal: TDate ): Boolean;
    function obterTPProvCR(pIdOrganizacao,pRegistroProvisao : string ): Boolean;
    function obterTPProvDB(pIdOrganizacao,pRegistroProvisao : string ): Boolean;
//TP BAIXA
    function obterTPQuitados(pIdOrganizacao, pIdStatus: string; pDataInicial, pDataFinal: TDate): Boolean;
    function obterTPBaixaPorTitulo(pIdOrganizacao, pIdtituloPagar: String): Boolean;
    function obterTPBCaixa(pIdOrganizacao, pIdTPB: String): Boolean;
    function obterTPBCheque(pIdOrganizacao, pIdTPB  : String): Boolean;
    function obterTPBBanco(pIdOrganizacao, pIdTPB  : String): Boolean;
    function obterTPBAC(pIdOrganizacao, pIdTPB : String): Boolean;
    function obterTPBDE(pIdOrganizacao, pIdTPB : String): Boolean;
    function obterTPBHistorico(pIdorganizacao, tituloPagarQuitado : string): Boolean;    }

  end;

var
  dmContasPagar: TdmContasPagar;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
function TdmContasPagar.alterarNumDocTP(pidOrganizacao, pId,
  pNumero: String): Boolean;
   var
  cmd: string;
begin
   codigoErro := 'TP-01';

cmd := 'UPDATE TITULO_PAGAR TP SET TP.NUMERO_DOCUMENTO = :pNumero ' +
       'WHERE (TP.ID_TITULO_PAGAR = :PID) AND ' +
       '(TP.ID_ORGANIZACAO = :PIDORGANIZACAO)' ;
  try
      qryAlteraNumDoc.Close;
      qryAlteraNumDoc.Connection := dmConexao.Conn;
      qryAlteraNumDoc.SQL.Clear;
      qryAlteraNumDoc.SQL.Add(cmd) ;
      qryAlteraNumDoc.ParamByName('PID').AsString := pId;
      qryAlteraNumDoc.ParamByName('PIDORGANIZACAO').AsString := pidOrganizacao;
      qryAlteraNumDoc.ParamByName('PNUMERO').AsString := pNumero;
      //qryAlteraNumDoc.SQL.SaveToFile(ExtractFilePath(Application.ExeName) + 'ALTNUMDOCTP.log');

        qryAlteraNumDoc.ExecSQL;
  Except
    dmConexao.Conn.RollbackRetaining;
    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : ALTNUMDOCTP ' + codigoErro );
  end;

  dmConexao.Conn.CommitRetaining;

  Result := System.True;
end;

procedure TdmContasPagar.DataModuleCreate(Sender: TObject);
begin
   obterRelPagamentos(TOrgAtual.getId);
   //gerar o dataChange do DTS

end;

function TdmContasPagar.dataSourceIsEmpty(var dts: TDataSource): Boolean;
begin
  Result := dts.DataSet.IsEmpty;
end;

function TdmContasPagar.deletarTitulosPorTipoStatus(pidOrganizacao,
  status: String): Boolean;
begin
      codigoErro := 'TP-02';
  try
      qryDeletaExcluidos.Close;
      qryDeletaExcluidos.Connection := dmConexao.Conn;
      qryDeletaExcluidos.ParamByName('PIDSTATUS').AsString := status;
      qryDeletaExcluidos.ParamByName('PIDORGANIZACAO').AsString := pidOrganizacao;
      qryDeletaExcluidos.ExecSQL;

  Except
    dmConexao.Conn.RollbackRetaining;
    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : DELTP-2 ' + codigoErro);
  end;

  dmConexao.Conn.CommitRetaining;

  Result := System.True;
end;




procedure TdmContasPagar.inicializarDM(Sender: TObject);
begin

 if not(Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end ;

end;

function TdmContasPagar.obterTitulosExcel(pIdOrganizacao: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
begin
codigoErro := 'TP-04';
  try
      qryTitulosExcel.Connection := dmConexao.Conn;
      qryTitulosExcel.Close;
      qryTitulosExcel.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTitulosExcel.ParamByName('DTDATAINICIAL').AsString := (FormatDateTime('mm/dd/yyyy', dtDataInicial));   //ver pq pega com hora
      qryTitulosExcel.ParamByName('DTDATAFINAL').AsString := (FormatDateTime('mm/dd/yyyy', dtDataFinal));
      qryTitulosExcel.Open();
  Except

    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : TP_EXCEL' + codigoErro);
  end;
  //qryTitulosExcel.SQL.SaveToFile('c:\finance\debug.log');

  Result := not qryTitulosExcel.IsEmpty;

end;

function TdmContasPagar.obterTitulosPorFornecedor(pIdOrganizacao, pIdCedente, campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
var
  cmd: string;
begin
  codigoErro := 'TP-05';

  cmd := 'SELECT * FROM  TITULO_PAGAR TP ' + 'WHERE (TP.ID_CEDENTE = :PIDCEDENTE) AND ' + '(TP.ID_TIPO_STATUS in ' + '(''ABERTO'',''QUITADO'',''PARCIAL'')) AND ' + '(TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' + '(TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) ' + ' ORDER BY ' + campoOrdem;

  try
    qryTitulosPorFornecedor.Connection := dmConexao.Conn;
    qryTitulosPorFornecedor.Close;
    qryTitulosPorFornecedor.SQL.Clear;
    qryTitulosPorFornecedor.SQL.Add(cmd);

    qryTitulosPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTitulosPorFornecedor.ParamByName('PIDCEDENTE').AsString := pIdCedente;

    //qryTitulosPorFornecedor.ParamByName('PORDEM').AsString :=campoOrdem;

    qryTitulosPorFornecedor.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
    qryTitulosPorFornecedor.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

    qryTitulosPorFornecedor.Open;
  Except
    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : TP_FORN ' + codigoErro);
  end;

  Result := not qryTitulosPorFornecedor.IsEmpty;

end;

function TdmContasPagar.obterTotalPorFornecedor(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
begin
    codigoErro := 'TP-06';
  try
      qryTotalDebitoPorFornecedor.Connection := dmConexao.Conn;
      qryTotalDebitoPorFornecedor.Close;
      qryTotalDebitoPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTotalDebitoPorFornecedor.ParamByName('PIDCEDENTE').AsString := pIdCedente;
      qryTotalDebitoPorFornecedor.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
      qryTotalDebitoPorFornecedor.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

      qryTotalDebitoPorFornecedor.Open;
  Except

    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : ' + codigoErro );
  end;

  Result := qryTotalDebitoPorFornecedor.Fields[0].AsCurrency;
end;

function TdmContasPagar.obterTotalPorStatus(pIdOrganizacao, pIdStatus: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
begin
codigoErro := 'TP-07';

  try
      qryObterTotalPorStatus.Connection := dmConexao.Conn;
      qryObterTotalPorStatus.Close;
      qryObterTotalPorStatus.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterTotalPorStatus.ParamByName('PIDSTATUS').AsString := pIdStatus;
      qryObterTotalPorStatus.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
      qryObterTotalPorStatus.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

      qryObterTotalPorStatus.Open;
  Except
    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : TOTAL_TP_STATUS ' + codigoErro);
  end;

  Result := qryObterTotalPorStatus.Fields[0].AsCurrency;
end;

function TdmContasPagar.obterTotalQuitadoPorFornecedor(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
begin
codigoErro := 'TP-08';

  try
      qryTotalQuitadoPorFornecedor.Connection := dmConexao.Conn;
      qryTotalQuitadoPorFornecedor.Close;
      qryTotalQuitadoPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTotalQuitadoPorFornecedor.ParamByName('PIDCEDENTE').AsString := pIdCedente;
      qryTotalQuitadoPorFornecedor.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
      qryTotalQuitadoPorFornecedor.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

      qryTotalQuitadoPorFornecedor.Open;

  Except

    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : TOTAL_TP_QUITADO ' + codigoErro);
  end;

  Result := qryTotalQuitadoPorFornecedor.Fields[0].AsCurrency;

end;



function TdmContasPagar.obterTodos(pIdOrganizacao: string): Boolean;
begin
codigoErro := 'TP-09';
   try
      qryObterTodos.Close;
      qryObterTodos.Connection := dmConexao.Conn;
      qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      //qryObterTodos.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
      //qryObterTodos.ParamByName('DTDATAFINAL').AsString :=  FormatDateTime('mm/dd/yyyy', dtDataFinal);

      qryObterTodos.Open;
  except

  raise(Exception).Create('Erro ao tentar Obter todos os TPs ' + codigoErro );

  end;
  Result := not qryObterTodos.IsEmpty;
end;

function TdmContasPagar.obterCentroCustoPorTP(pIdOrganizacao,
  pIdTitulo: string): Boolean;
begin
    codigoErro := 'TP-13';
    try
    // carrega os centros de custos .. sv jrg
      qryObterCentroCustoPorTitulo.Close;
      qryObterCentroCustoPorTitulo.ParamByName('PIDTITULOPAGAR').AsString := pIdTitulo;
      qryObterCentroCustoPorTitulo.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterCentroCustoPorTitulo.Open();

    except
     raise(Exception).Create('Erro ao tentar consultar o TP CENTRO_C '  + codigoErro);

    end;

  Result := not qryObterCentroCustoPorTitulo.IsEmpty;
end;

function TdmContasPagar.obterHistoricoPorTP(pIdOrganizacao, pIdTitulo: string): Boolean;
begin
   codigoErro := 'TP-12';
  try
   // carrega os historicos
      qryObterTPHistoricoPorTitulo.Close;
      qryObterTPHistoricoPorTitulo.ParamByName('PIDTITULOPAGAR').AsString := pIdTitulo;
      qryObterTPHistoricoPorTitulo.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterTPHistoricoPorTitulo.Open();
except
  raise(Exception).Create('Erro ao tentar consultar o TP HST '  + codigoErro);

  end;

  Result := not qryObterTPHistoricoPorTitulo.IsEmpty;
end;
function TdmContasPagar.obterPorNumeroDocumento(pIdOrganizacao, pNumDoc: string): Boolean;
begin
codigoErro := 'TP-10';
  try

      qryObterPorNumeroDocumento.Close;
      qryObterPorNumeroDocumento.Connection := dmConexao.Conn;
      qryObterPorNumeroDocumento.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterPorNumeroDocumento.ParamByName('PNUMDOC').AsString := pNumDoc;

      qryObterPorNumeroDocumento.Open;

  except
  raise(Exception).Create('Erro ao tentar consultar o TP DOC ' + pNumDoc  + ' CD ERRO ' + codigoErro);

  end;

  Result := not qryObterPorNumeroDocumento.IsEmpty;
end;

function TdmContasPagar.obterRelPagamentos(pIdOrganizacao: string): Boolean;
begin
codigoErro := 'TP-11';
 try
     qryRelPagamentos.Connection := dmConexao.Conn;
     qryRelPagamentos.Close;
     qryRelPagamentos.ParamByName('PIDORGANIZACAO').AsString :=pIdOrganizacao;
     qryRelPagamentos.Open();

 except

  raise(Exception).Create('Erro ao tentar  ' + 'obterRelPagamentos ' + codigoErro );


  end;

  Result := not qryRelPagamentos.IsEmpty;

end;

end.


