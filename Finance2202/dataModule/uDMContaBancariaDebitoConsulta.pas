unit uDMContaBancariaDebitoConsulta;

interface

uses
  System.SysUtils, System.Classes, udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmCBDConsulta = class(TDataModule)
    qryObterPorTituloPagar: TFDQuery;
    qryObterPorTipoOperacao: TFDQuery;
    qryObterPorId: TFDQuery;
    qryObterTransfBancoTesourariaPeriodo: TFDQuery;
    fdqryObterTransferenciaBCDTC: TFDQuery;
  private
    procedure inicializarDM(Sender: TObject);

    { Private declarations }
  public
    { Public declarations }
    function obterPorTituloPagar(pIdOrganizacao, pIdTituloPagar
      : String): Boolean;

    function obterPorTipoOperacao(pIdOrganizacao, pIdTipoOperacao: String;
      dtDataInicial, dtDataFinal: TDateTime): Boolean;

    function obterPorId(pIdOrganizacao, PIDCONTABANCARIADEBITO: String)
      : Boolean;

    function obterTransfBancoTesouraria(pIdOrganizacao: String;
      dtDataInicial, dtDataFinal: TDateTime): Boolean;

  end;

var
  dmCBDConsulta: TdmCBDConsulta;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

function TdmCBDConsulta.obterPorId(pIdOrganizacao, PIDCONTABANCARIADEBITO
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
  qryObterPorId.ParamByName('PIDCONTABANCARIADEBITO').AsString :=
    PIDCONTABANCARIADEBITO;
  qryObterPorId.Open;

  Result := not qryObterPorId.IsEmpty;

end;

function TdmCBDConsulta.obterTransfBancoTesouraria(pIdOrganizacao: String;
  dtDataInicial, dtDataFinal: TDateTime): Boolean;
     var
     aux :string;
     dataIn, dataFim :TDate;
begin
  Result := false;

  inicializarDM(Self);

  dataIn := dtDataInicial;
  dataFim := dtDataFinal;


  if not qryObterTransfBancoTesourariaPeriodo.Connection.Connected then
  begin
    qryObterTransfBancoTesourariaPeriodo.Connection := dmConexao.Conn;
  end;

  qryObterTransfBancoTesourariaPeriodo.Close;

  qryObterTransfBancoTesourariaPeriodo.ParamByName('PIDORGANIZACAO').AsString :=
    pIdOrganizacao;
  qryObterTransfBancoTesourariaPeriodo.ParamByName('DTDATAINICIAL').AsDateTime
    := dataIn;
  qryObterTransfBancoTesourariaPeriodo.ParamByName('DTDATAFINAL').AsDateTime :=
    dataFim;
  qryObterTransfBancoTesourariaPeriodo.Open;

 aux := qryObterTransfBancoTesourariaPeriodo.SQL.ToString;

  qryObterTransfBancoTesourariaPeriodo.RecordCount ;

  Result := not qryObterTransfBancoTesourariaPeriodo.IsEmpty;

end;



function TdmCBDConsulta.obterPorTipoOperacao(pIdOrganizacao, pIdTipoOperacao
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

function TdmCBDConsulta.obterPorTituloPagar(pIdOrganizacao, pIdTituloPagar
  : String): Boolean;

begin
  Result := false;

  inicializarDM(Self);

  if not qryObterPorTituloPagar.Connection.Connected then
  begin
    qryObterPorTituloPagar.Connection := dmConexao.Conn;
  end;

  qryObterPorTituloPagar.Close;

  qryObterPorTituloPagar.ParamByName('pIdOrganizacao').AsString :=
    pIdOrganizacao;
  qryObterPorTituloPagar.ParamByName('PIDTITULOPAGAR').AsString :=
    pIdTituloPagar;
  qryObterPorTituloPagar.Open;

  Result := not qryObterPorTituloPagar.IsEmpty;

end;

procedure TdmCBDConsulta.inicializarDM(Sender: TObject);
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
