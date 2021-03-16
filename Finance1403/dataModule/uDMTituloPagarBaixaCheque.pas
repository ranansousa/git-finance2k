unit uDMTituloPagarBaixaCheque;


interface

uses
  System.SysUtils, System.Classes,udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmTPBCheque = class(TDataModule)
    qryObterPorTPB: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
  public
    { Public declarations }
    function obterPorTPB(pIdOrganizacao, pIdTitutloPagarBaixa : String): Boolean;
  end;

var
  dmTPBCheque: TdmTPBCheque;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmTPBCheque.inicializarDM(Sender: TObject);
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

function TdmTPBCheque.obterPorTPB(pIdOrganizacao, pIdTitutloPagarBaixa
  : String): Boolean;
begin

  Result := false;

  inicializarDM(Self);

  if not qryObterPorTPB.Connection.Connected then
  begin
    qryObterPorTPB.Connection := dmConexao.Conn;
  end;

  qryObterPorTPB.Close;

  qryObterPorTPB.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryObterPorTPB.ParamByName('PIDTITULOPAGARBAIXA').AsString :=pIdTitutloPagarBaixa;
  qryObterPorTPB.Open;

  Result := not qryObterPorTPB.IsEmpty;
end;

end.
