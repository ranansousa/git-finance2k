unit uDMHistoricoConsulta;

interface

uses
  System.SysUtils, System.Classes, udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmHistoricoConsulta = class(TDataModule)
    qryObterHistoricoSemContaContabil: TFDQuery;
    qryObterTPHistoricoPorTitulo: TFDQuery;
    qryHstSemCC: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
  public
    { Public declarations }
    function obterListaHistoricoSemContaContabil(pIdOrganizacao
      : String): Boolean;

  end;

var
  dmHistoricoConsulta: TdmHistoricoConsulta;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TdmHistoricoConsulta }

procedure TdmHistoricoConsulta.freeAndNilDM(Sender: TObject);
begin
  if Assigned(dmConexao) then
  begin
    FreeAndNil(dmConexao);
  end;
end;

procedure TdmHistoricoConsulta.inicializarDM(Sender: TObject);
begin
  if not(Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
    dmConexao.conectarBanco;
  end;
end;

function TdmHistoricoConsulta.obterListaHistoricoSemContaContabil
  (pIdOrganizacao: String): Boolean;
begin
  Result := False;
  //inicializarDM(Self);
  if dmConexao.conectarBanco then
  begin


    qryHstSemCC.Close;
    qryHstSemCC.Connection := dmConexao.Conn;
    qryHstSemCC.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
    qryHstSemCC.Open;

    Result := not qryHstSemCC.IsEmpty;

  end;
end;


end.
