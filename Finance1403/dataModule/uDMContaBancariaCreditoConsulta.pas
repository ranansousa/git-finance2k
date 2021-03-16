unit uDMContaBancariaCreditoConsulta;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, udmConexao;

type
  TdmCBCConsulta = class(TDataModule)
    qryObterPorTituloReceber: TFDQuery;
    qryObterPorTipoOperacao: TFDQuery;
    qryObterPorId: TFDQuery;
    qryObterTransfTesourariaBancoPeriodo: TFDQuery;
    qryObterQtdLancamentosPeriodo: TFDQuery;
  private
    procedure inicializarDM(Sender: TObject);

    { Private declarations }
  public
    { Public declarations }
    function obterPorTRB(pIdOrganizacao, pIdTituloReceber: String): Boolean;
    function obterPorTipoOperacao(pIdOrganizacao, pIdTipoOperacao: String;
      dtDataInicial, dtDataFinal: TDateTime): Boolean;
    function obterPorId(pIdOrganizacao, PIDCONTABANCARIACREDITO
      : String): Boolean;
    function obterTransfTesourariaBanco(pIdOrganizacao: String;
      dataInicial, dataFinal: TDate): Boolean;
    function qtdLancamentosPeriodo(pIdOrganizacao: String;
      dtDataInicial, dtDataFinal: TDateTime): Integer;
  end;

var
  dmCBCConsulta: TdmCBCConsulta;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

function TdmCBCConsulta.obterTransfTesourariaBanco(pIdOrganizacao: String;
  dataInicial, dataFinal: TDate): Boolean;

begin
  Result := false;

  inicializarDM(Self);

  if not qryObterTransfTesourariaBancoPeriodo.Connection.Connected then
  begin
    qryObterTransfTesourariaBancoPeriodo.Connection := dmConexao.Conn;
  end;

  qryObterTransfTesourariaBancoPeriodo.Close;

  qryObterTransfTesourariaBancoPeriodo.ParamByName('PIDORGANIZACAO').AsString :=
    pIdOrganizacao;
  qryObterTransfTesourariaBancoPeriodo.ParamByName('DTDATAINICIAL').AsDate
    := dataInicial;
  qryObterTransfTesourariaBancoPeriodo.ParamByName('DTDATAFINAL').AsDate :=
    dataFinal;
  qryObterTransfTesourariaBancoPeriodo.Open;


  Result := not qryObterTransfTesourariaBancoPeriodo.IsEmpty;

end;

function TdmCBCConsulta.obterPorTRB(pIdOrganizacao, pIdTituloReceber
  : String): Boolean;

begin
  Result := false;

  inicializarDM(Self);

  if not qryObterPorTituloReceber.Connection.Connected then
  begin
    qryObterPorTituloReceber.Connection := dmConexao.Conn;
  end;

  qryObterPorTituloReceber.Close;

  qryObterPorTituloReceber.ParamByName('pIdOrganizacao').AsString :=
    pIdOrganizacao;
  qryObterPorTituloReceber.ParamByName('PIDTITULORECEBER').AsString :=
    pIdTituloReceber;
  qryObterPorTituloReceber.Open;

  Result := not qryObterPorTituloReceber.IsEmpty;

end;

function TdmCBCConsulta.obterPorTipoOperacao(pIdOrganizacao, pIdTipoOperacao
  : String; dtDataInicial, dtDataFinal: TDateTime): Boolean;

begin
  Result := false;

  inicializarDM(Self);

  if not qryObterPorTipoOperacao.Connection.Connected then
  begin
    qryObterPorTipoOperacao.Connection := dmConexao.Conn;
  end;

  qryObterPorTipoOperacao.Close;

  qryObterPorTipoOperacao.ParamByName('PIDORGANIZACAO').AsString :=
    pIdOrganizacao;
  qryObterPorTipoOperacao.ParamByName('PIDTIPOOPERACAO').AsString :=
    pIdTipoOperacao;
  qryObterPorTipoOperacao.ParamByName('DTDATAINICIAL').AsDateTime :=
    dtDataInicial;
  qryObterPorTipoOperacao.ParamByName('DTDATAFINAL').AsDateTime := dtDataFinal;
  qryObterPorTipoOperacao.Open;

  Result := not qryObterPorTipoOperacao.IsEmpty;

end;
 function TdmCBCConsulta.qtdLancamentosPeriodo(pIdOrganizacao
  : String; dtDataInicial, dtDataFinal: TDateTime): Integer;

begin
  Result := 0;

  inicializarDM(Self);

  if not qryObterQtdLancamentosPeriodo.Connection.Connected then
  begin
    qryObterQtdLancamentosPeriodo.Connection := dmConexao.Conn;
  end;

  qryObterQtdLancamentosPeriodo.Close;

  qryObterQtdLancamentosPeriodo.ParamByName('PIDORGANIZACAO').AsString :=
    pIdOrganizacao;
  qryObterQtdLancamentosPeriodo.ParamByName('DTDATAINICIAL').AsDateTime :=
    dtDataInicial;
  qryObterQtdLancamentosPeriodo.ParamByName('DTDATAFINAL').AsDateTime := dtDataFinal;
  qryObterQtdLancamentosPeriodo.Open;

  Result := qryObterQtdLancamentosPeriodo.Fields[0].AsInteger;

end;



    //fim

function TdmCBCConsulta.obterPorId(pIdOrganizacao, PIDCONTABANCARIACREDITO
  : String): Boolean;

begin
  Result := false;

  inicializarDM(Self);

  if not qryObterPorId.Connection.Connected then
  begin
    qryObterPorId.Connection := dmConexao.Conn;
  end;

  qryObterPorId.Close;

  qryObterPorId.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterPorId.ParamByName('PIDCONTABANCARIACREDITO').AsString :=
    PIDCONTABANCARIACREDITO;
  qryObterPorId.Open;

  Result := not qryObterPorId.IsEmpty;

end;

procedure TdmCBCConsulta.inicializarDM(Sender: TObject);
begin
  if not(Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end
  else
  begin
    dmConexao.conectarBanco;
  end;

end;

end.
