unit uDMTituloPagarCentroCustoConsulta;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, udmConexao;

type
  TdmTPCentroCustoConsulta = class(TDataModule)
    qryObterCentroCustoPorTP: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
  public
    { Public declarations }
    function obterRateioCentroCustoPorTitulo(pIdOrganizacao,
      pIdTitulo: String): Boolean;
  end;

var
  dmTPCentroCustoConsulta: TdmTPCentroCustoConsulta;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

function TdmTPCentroCustoConsulta.obterRateioCentroCustoPorTitulo
  (pIdOrganizacao, pIdTitulo: String): Boolean;
begin

  inicializarDM(Self);
  Result := False;

  if not qryObterCentroCustoPorTP.Connection.Connected then
  begin
    qryObterCentroCustoPorTP.Connection := dmConexao.Conn;
  end;

  qryObterCentroCustoPorTP.Close;
  qryObterCentroCustoPorTP.ParamByName('pId_TITULO_PAGAR').AsString :=
    pIdTitulo;
  qryObterCentroCustoPorTP.ParamByName('pIdOrganizacao').AsString :=
    pIdOrganizacao;
  qryObterCentroCustoPorTP.Open();

  Result := not qryObterCentroCustoPorTP.IsEmpty;

end;

procedure TdmTPCentroCustoConsulta.inicializarDM(Sender: TObject);
begin

  if not(Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end
  else
  begin
    dmConexao.conectarBanco;
    dmConexao.conectarMega;
  end;

end;

end.
