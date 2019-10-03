unit uDMRelatoriosPagamentos;

interface

uses
  System.SysUtils, System.Classes, uUtil,
  udmConexao, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Util, FireDAC.Comp.Script;

type
  TdmRelPagamentos = class(TDataModule)
    qryTitulosExcel: TFDQuery;
    qryCentroCusto: TFDQuery;
    sqlScriptContainer: TFDScript;
    qryObterCentroCustoPorTitulo: TFDQuery;
    qryTotalDebitoPorFornecedor: TFDQuery;
    qryTotalQuitadoPorFornecedor: TFDQuery;
    dsTitulosPagarAll: TDataSource;
    qryTitulosPorFornecedor: TFDQuery;
    qryRelPagamentos: TFDQuery;
    dsTituloPagarExcel: TDataSource;
    qryObterTodos: TFDQuery;
    qryObterPorNumeroDocumento: TFDQuery;
    qryObterTotalPorStatus: TFDQuery;
    dsTitulosExcel: TDataSource;
    qryObterTPHistoricoPorTitulo: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);

  private

    { Private declarations }

        idOrgzanizacao :string;

  public
    { Public declarations }
     function obterHistoricoPorTP(pIdOrganizacao, pIdTitulo: string): Boolean;
    function obterCentroCustoPorTP(pIdOrganizacao, pIdTitulo: string): Boolean;
    function obterTitulosExcel(pIdOrganizacao: string; dtDataInicial,
      dtDataFinal: TDateTime): Boolean;

    function dataSourceIsEmpty(var dts: TDataSource): Boolean;
    function obterPorNumeroDocumento(pIdOrganizacao, pNumDoc: string): Boolean;
    function obterTitulosPorFornecedor(pIdOrganizacao, pIdCedente,
      campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
    function obterTodos(pIdOrganizacao: string): Boolean;
    function obterTotalPorFornecedor(pIdOrganizacao, pIdCedente: string;
      dtDataInicial, dtDataFinal: TDateTime): Currency;
    function obterTotalPorStatus(pIdOrganizacao, pIdStatus: string;
      dtDataInicial, dtDataFinal: TDateTime): Currency;
    function obterTotalQuitadoPorFornecedor(pIdOrganizacao, pIdCedente: string;
      dtDataInicial, dtDataFinal: TDateTime): Currency;
      function obterTodosCentroCustos(pIdOrganizacao : string) :Boolean;
      function obterTodosPagamentos(sql :TStringList; pIdOrganizacao :string; dtDataInicial, dtDataFinal: TDate ) :Boolean;



  end;

var
  dmRelPagamentos: TdmRelPagamentos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

 function TdmRelPagamentos.obterCentroCustoPorTP(pIdOrganizacao,
  pIdTitulo: string): Boolean;
begin
   // codigoErro := 'TP-13';
    try
    // carrega os centros de custos .. sv jrg
      qryObterCentroCustoPorTitulo.Connection := dmConexao.Conn;
      qryObterCentroCustoPorTitulo.Close;
      qryObterCentroCustoPorTitulo.ParamByName('PIDTITULOPAGAR').AsString := pIdTitulo;
      qryObterCentroCustoPorTitulo.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterCentroCustoPorTitulo.Open();

    except
     raise(Exception).Create('Erro ao tentar consultar o TP CENTRO_C '  );

    end;

  Result := not qryObterCentroCustoPorTitulo.IsEmpty;
end;

function TdmRelPagamentos.obterHistoricoPorTP(pIdOrganizacao, pIdTitulo: string): Boolean;
begin
  try
      qryObterTPHistoricoPorTitulo.Connection := dmConexao.Conn;
      qryObterTPHistoricoPorTitulo.Close;
      qryObterTPHistoricoPorTitulo.ParamByName('PIDTITULOPAGAR').AsString := pIdTitulo;
      qryObterTPHistoricoPorTitulo.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterTPHistoricoPorTitulo.Open();

      qryObterTPHistoricoPorTitulo.Open();
  except
  raise(Exception).Create('Erro ao tentar Obter Historicos por TP '  );
  end;

  Result := not qryObterTPHistoricoPorTitulo.IsEmpty;
end;



function TdmRelPagamentos.obterTitulosExcel(pIdOrganizacao: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
begin
  try
      qryTitulosExcel.Connection := dmConexao.Conn;
      qryTitulosExcel.Close;
      qryTitulosExcel.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTitulosExcel.ParamByName('DTDATAINICIAL').AsString := (FormatDateTime('mm/dd/yyyy', dtDataInicial));   //ver pq pega com hora
      qryTitulosExcel.ParamByName('DTDATAFINAL').AsString := (FormatDateTime('mm/dd/yyyy', dtDataFinal));
      qryTitulosExcel.Open();
  except
  raise(Exception).Create('Erro ao tentar Obter todos os TPs Excel '  );
  end;

  Result := not qryTitulosExcel.IsEmpty;
end;
//

procedure TdmRelPagamentos.DataModuleCreate(Sender: TObject);
var
aux : string;
begin
  dmConexao.conectarBanco;

  aux := '';
  idOrgzanizacao := TOrgAtual.getId;
//  qryRelPagamentos.Open();
end;

function TdmRelPagamentos.dataSourceIsEmpty(var dts: TDataSource): Boolean;
begin
  Result := dts.DataSet.IsEmpty;
end;

function TdmRelPagamentos.obterTitulosPorFornecedor(pIdOrganizacao, pIdCedente, campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
var
  cmd: string;
begin
  cmd := 'SELECT * FROM  TITULO_PAGAR TP ' + 'WHERE (TP.ID_CEDENTE = :PIDCEDENTE) AND ' + '(TP.ID_TIPO_STATUS in ' + '(''ABERTO'',''QUITADO'',''PARCIAL'')) AND ' + '(TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' + '(TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) ' + ' ORDER BY ' + campoOrdem;

  try
    qryTitulosPorFornecedor.Connection := dmConexao.Conn;
    qryTitulosPorFornecedor.Close;
    qryTitulosPorFornecedor.SQL.Clear;
    qryTitulosPorFornecedor.SQL.Add(cmd);
    qryTitulosPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTitulosPorFornecedor.ParamByName('PIDCEDENTE').AsString := pIdCedente;
    qryTitulosPorFornecedor.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
    qryTitulosPorFornecedor.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);
    qryTitulosPorFornecedor.Open;
  except

  raise(Exception).Create('Erro ao tentar Obter todos os TPs '  );


  end;

  Result := not qryTitulosPorFornecedor.IsEmpty;

end;

function TdmRelPagamentos.obterTotalPorFornecedor(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
begin

  try
      qryTotalDebitoPorFornecedor.Connection := dmConexao.Conn;
      qryTotalDebitoPorFornecedor.Close;
      qryTotalDebitoPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTotalDebitoPorFornecedor.ParamByName('PIDCEDENTE').AsString := pIdCedente;
      qryTotalDebitoPorFornecedor.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
      qryTotalDebitoPorFornecedor.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

      qryTotalDebitoPorFornecedor.Open;
  except

  raise(Exception).Create('Erro ao tentar Obter todos os TPs '  );


  end;

  Result := qryTotalDebitoPorFornecedor.Fields[0].AsCurrency;
end;

function TdmRelPagamentos.obterTotalPorStatus(pIdOrganizacao, pIdStatus: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
begin

  try
    qryObterTotalPorStatus.Connection := dmConexao.Conn;
    qryObterTotalPorStatus.Close;
    qryObterTotalPorStatus.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterTotalPorStatus.ParamByName('PIDSTATUS').AsString := pIdStatus;
    qryObterTotalPorStatus.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
    qryObterTotalPorStatus.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

    qryObterTotalPorStatus.Open;
  except

  raise(Exception).Create('Erro ao tentar Obter total por status '  );


  end;

  Result := qryObterTotalPorStatus.Fields[0].AsCurrency;
end;

function TdmRelPagamentos.obterTotalQuitadoPorFornecedor(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
begin
  try
      qryTotalQuitadoPorFornecedor.Connection := dmConexao.Conn;
      qryTotalQuitadoPorFornecedor.Close;
      qryTotalQuitadoPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTotalQuitadoPorFornecedor.ParamByName('PIDCEDENTE').AsString := pIdCedente;
      qryTotalQuitadoPorFornecedor.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
      qryTotalQuitadoPorFornecedor.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

      qryTotalQuitadoPorFornecedor.Open;
  except

  raise(Exception).Create('Erro ao tentar Obter todos os TPB POR FORN '  );


  end;

  Result := qryTotalQuitadoPorFornecedor.Fields[0].AsCurrency;

end;




function TdmRelPagamentos.obterTodos(pIdOrganizacao: string): Boolean;
begin
   try
      qryObterTodos.Close;
      qryObterTodos.Connection := dmConexao.Conn;
      qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;

      qryObterTodos.Open;
  except

  raise(Exception).Create('Erro ao tentar Obter todos os TPs '  );


  end;
  Result := not qryObterTodos.IsEmpty;
end;

function TdmRelPagamentos.obterTodosCentroCustos(
  pIdOrganizacao: string): Boolean;
begin

  try
      qryCentroCusto.Close;
      qryCentroCusto.Connection := dmConexao.Conn;
      qryCentroCusto.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryCentroCusto.Open();
  except
  raise(Exception).Create('Erro ao tentar obter todos os Centro de Custos. ');
  end;

  Result := not qryCentroCusto.IsEmpty;

end;

function TdmRelPagamentos.obterTodosPagamentos(sql :TStringList; pIdOrganizacao : string; dtDataInicial, dtDataFinal: TDate): Boolean;
var
aux :Integer;
begin
  if sql.Count >0  then begin

      try

      qryRelPagamentos.Close;
      qryRelPagamentos.Connection := dmConexao.Conn;
      qryRelPagamentos.SQL.Clear;
      qryRelPagamentos.SQL.Assign(sql);
      qryRelPagamentos.Open;

      except
      raise(Exception).Create('Erro ao tentar  consultar os Titulos ' + ' obterTodosPagamentos ' );
      end;
  end;
   aux :=qryRelPagamentos.RecordCount;

  Result := not qryRelPagamentos.IsEmpty;

end;

function TdmRelPagamentos.obterPorNumeroDocumento(pIdOrganizacao, pNumDoc: string): Boolean;
begin
  try

      qryObterPorNumeroDocumento.Close;
      qryObterPorNumeroDocumento.Connection := dmConexao.Conn;
      qryObterPorNumeroDocumento.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterPorNumeroDocumento.ParamByName('PNUMDOC').AsString := pNumDoc;

      qryObterPorNumeroDocumento.Open;

  except

  raise(Exception).Create('Erro ao tentar consultar o TP DOC ' + pNumDoc );


  end;

  Result := not qryObterPorNumeroDocumento.IsEmpty;
end;



end.
