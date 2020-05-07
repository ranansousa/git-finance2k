unit uDMTesourariaCreditoConsulta;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,udmConexao;

type
  TdmTCConsulta = class(TDataModule)
    qryObterPorTituloReceberBaixa: TFDQuery;
    qryObterPorContaBancariaDebito: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
  public
    { Public declarations }
    function obterPorTRB(pIdOrganizacao,pIdTRB: String): Boolean;
    function obterPorContaBancariaDebito(pIdOrganizacao,pIdCBD: String): Boolean;

  end;

var
  dmTCConsulta: TdmTCConsulta;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


function TdmTCConsulta.obterPorContaBancariaDebito(pIdOrganizacao,
  pIdCBD: String): Boolean;
begin
   Result := false;

  inicializarDM(Self);

  if not qryObterPorContaBancariaDebito .Connection.Connected then
  begin
    qryObterPorContaBancariaDebito.Connection := dmConexao.Conn;
  end;

  qryObterPorContaBancariaDebito.Close;

  qryObterPorContaBancariaDebito.ParamByName('PIDORGANIZACAO').AsString :=pIdOrganizacao;
  qryObterPorContaBancariaDebito.ParamByName('PIDCONTABANCODEBITO').AsString :=pIdCBD;
  qryObterPorContaBancariaDebito.Open;

  Result := not qryObterPorContaBancariaDebito.IsEmpty;


end;

function TdmTCConsulta.obterPorTRB(pIdOrganizacao,pIdTRB: String): Boolean;
begin
  Result := false;

  inicializarDM(Self);

  if not qryObterPorTituloReceberBaixa .Connection.Connected then
  begin
    qryObterPorTituloReceberBaixa.Connection := dmConexao.Conn;
  end;

  qryObterPorTituloReceberBaixa.Close;

  qryObterPorTituloReceberBaixa.ParamByName('PIDORGANIZACAO').AsString :=pIdOrganizacao;
  qryObterPorTituloReceberBaixa.ParamByName('PIDTITULORECEBERBAIXA').AsString :=pIdTRB;
  qryObterPorTituloReceberBaixa.Open;

  Result := not qryObterPorTituloReceberBaixa.IsEmpty;

end;

procedure TdmTCConsulta.inicializarDM(Sender: TObject);
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
