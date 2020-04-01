unit uDMTituloReceberCentroCustoConsulta;

interface

uses
  System.SysUtils, System.Classes, udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmTRCentroCustoConsulta = class(TDataModule)
    qryObterCentroCustoPorTR: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
  public
    { Public declarations }
    function obterRateioCentroCustoPorTitulo(pIdOrganizacao,
      pIdTitulo: String): Boolean;

  end;

var
  dmTRCentroCustoConsulta: TdmTRCentroCustoConsulta;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TDataModule1 }

procedure TdmTRCentroCustoConsulta.inicializarDM(Sender: TObject);
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

function TdmTRCentroCustoConsulta.obterRateioCentroCustoPorTitulo
  (pIdOrganizacao, pIdTitulo: String): Boolean;
begin
  inicializarDM(Self);
  Result := False;


  if not   qryObterCentroCustoPorTR.Connection.Connected then
  begin
      qryObterCentroCustoPorTR.Connection := dmConexao.Conn;
  end;

    qryObterCentroCustoPorTR.Close;
    qryObterCentroCustoPorTR.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao ;
    qryObterCentroCustoPorTR.ParamByName('PIDTITULORECEBER').AsString := pIdTitulo;
    qryObterCentroCustoPorTR.Open();

  Result := not   qryObterCentroCustoPorTR.IsEmpty;

end;

end.
