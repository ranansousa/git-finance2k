unit uDMTituloReceberHistoricoConsulta;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, udmConexao;

type
  TdmTRHistoricoConsulta = class(TDataModule)
    qryObterTRHistoricoPorTR: TFDQuery;
  private
    procedure inicializarDM(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    function obterRateioHIstoricoPorTitulo(pIdOrganizacao,
      pIdTitulo: String): Boolean;

  end;

var
  dmTRHistoricoConsulta: TdmTRHistoricoConsulta;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

function TdmTRHistoricoConsulta.obterRateioHIstoricoPorTitulo(pIdOrganizacao,
  pIdTitulo: String): Boolean;
  var
  aux :Integer;
begin
  inicializarDM(Self);
  Result := False;


  if not qryObterTRHistoricoPorTR.Connection.Connected then
  begin
    qryObterTRHistoricoPorTR.Connection := dmConexao.Conn;
  end;

  qryObterTRHistoricoPorTR.Close;
  qryObterTRHistoricoPorTR.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterTRHistoricoPorTR.ParamByName('PID_TITULO_RECEBER').AsString := pIdTitulo;
  qryObterTRHistoricoPorTR.Open();

  Result := not qryObterTRHistoricoPorTR.IsEmpty;

end;

procedure TdmTRHistoricoConsulta.inicializarDM(Sender: TObject);
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
