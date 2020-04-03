unit uDMContasReceber;

interface

uses
  System.SysUtils, System.Classes, udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmContasReceber = class(TDataModule)
    qryObterTRPendentes: TFDQuery;
    dtsPendentesImportados: TDataSource;
    qryDelPendentesAll: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function obterTRPendentesImportados(pIdOrganizacao: String): Boolean;
    function deletePendentesAll(pIdOrganizacao: String): Boolean;
    function dataSourceIsEmpty(var dts: TDataSource): Boolean;

  end;

var
  dmContasReceber: TdmContasReceber;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TdmContasReceber }

function TdmContasReceber.dataSourceIsEmpty(var dts: TDataSource): Boolean;
begin
  Result := dts.DataSet.IsEmpty;
end;

function TdmContasReceber.deletePendentesAll(pIdOrganizacao: String): Boolean;
begin
  Result := false;

  dmConexao.conectarBanco;

 try
    qryDelPendentesAll.Close;
    qryDelPendentesAll.Connection := dmConexao.Conn;
    qryDelPendentesAll.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
    qryDelPendentesAll.ExecSQL;
    dmConexao.conn.CommitRetaining;

 except
  dmConexao.conn.RollbackRetaining;
   raise Exception.Create('Não foi possível deletar os pendentes a receber');

 end;


  Result := System.True;

end;

function TdmContasReceber.obterTRPendentesImportados(pIdOrganizacao
  : String): Boolean;

begin
  Result := false;
  dmConexao.conectarBanco;


  qryObterTRPendentes.Close;
  qryObterTRPendentes.Connection := dmConexao.Conn;
  qryObterTRPendentes.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryObterTRPendentes.Open;

  Result := not qryObterTRPendentes.IsEmpty;

end;

end.
