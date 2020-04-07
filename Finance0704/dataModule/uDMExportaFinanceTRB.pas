unit uDMExportaFinanceTRB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, udmConexao;

type
  TdmExportFinanceTRB = class(TDataModule)
    qryObterBaixaPorTitulo: TFDQuery;
  private
    procedure inicializarDM(Sender: TObject);

    { Private declarations }
  public
    { Public declarations }
    function obterBaixaPorTitulo(pIdOrganizacao, pIdtituloReceber
      : String): Boolean;
  end;

var
  dmExportFinanceTRB: TdmExportFinanceTRB;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

function TdmExportFinanceTRB.obterBaixaPorTitulo(pIdOrganizacao,
  pIdtituloReceber: String): Boolean;
begin
  Result := false;

  inicializarDM(Self);

  if not qryObterBaixaPorTitulo.Connection.Connected then
  begin
    qryObterBaixaPorTitulo.Connection := dmConexao.Conn;
  end;

  qryObterBaixaPorTitulo.Close;
  qryObterBaixaPorTitulo.ParamByName('PIDORGANIZACAO').AsString :=
    pIdOrganizacao;
  qryObterBaixaPorTitulo.ParamByName('pIdtituloReceber').AsString :=
    pIdtituloReceber;
  qryObterBaixaPorTitulo.Open;

  Result := not qryObterBaixaPorTitulo.IsEmpty;

end;

procedure TdmExportFinanceTRB.inicializarDM(Sender: TObject);
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
