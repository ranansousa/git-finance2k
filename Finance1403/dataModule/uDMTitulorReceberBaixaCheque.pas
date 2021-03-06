unit uDMTitulorReceberBaixaCheque;

interface

uses
  System.SysUtils, System.Classes,udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmTRBCheque = class(TDataModule)
    qryObterPorTRB: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
  public
    { Public declarations }
    function obterPorTRB(pIdOrganizacao, pIdTitutloReceberBaixa
  : String): Boolean;
  end;

var
  dmTRBCheque: TdmTRBCheque;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure TdmTRBCheque.inicializarDM(Sender: TObject);
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

function TdmTRBCheque.obterPorTRB(pIdOrganizacao, pIdTitutloReceberBaixa
  : String): Boolean;
begin

  Result := false;

  inicializarDM(Self);

  if not qryObterPorTRB.Connection.Connected then
  begin
    qryObterPorTRB.Connection := dmConexao.Conn;
  end;

  qryObterPorTRB.Close;
  qryObterPorTRB.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryObterPorTRB.ParamByName('PIDTITULORECEBERBAIXA').AsString :=pIdTitutloReceberBaixa;
  qryObterPorTRB.Open;

  Result := not qryObterPorTRB.IsEmpty;
end;


end.
