unit uDMContaBancariaTransferencia;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmCBT = class(TDataModule)
    qryObterPorPeriodo: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
  public
    { Public declarations }
    function obterPorPeriodo(pIdOrganizacao: String;
      dtDataInicial, dtDataFinal: TDateTime): Boolean;
  end;

var
  dmCBT: TdmCBT;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TDataModule1 }

procedure TdmCBT.inicializarDM(Sender: TObject);
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

function TdmCBT.obterPorPeriodo(pIdOrganizacao: String;
  dtDataInicial, dtDataFinal: TDateTime): Boolean;
begin

  Result := false;

  inicializarDM(Self);

  if not qryObterPorPeriodo.Connection.Connected then
  begin
    qryObterPorPeriodo.Connection := dmConexao.Conn;
  end;

  qryObterPorPeriodo.Close;

  qryObterPorPeriodo.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterPorPeriodo.ParamByName('DTDATAINICIAL').AsDateTime := dtDataInicial;
  qryObterPorPeriodo.ParamByName('DTDATAFINAL').AsDateTime := dtDataFinal;
  qryObterPorPeriodo.Open;

  Result := not qryObterPorPeriodo.IsEmpty;

end;

end.
