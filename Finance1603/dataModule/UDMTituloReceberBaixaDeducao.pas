unit UDMTituloReceberBaixaDeducao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,udmConexao;

type
  TdmTRBDeducao = class(TDataModule)
    qryObterPorTRB: TFDQuery;
  private
    procedure inicializarDM(Sender: TObject);

    { Private declarations }
  public
    { Public declarations }
    function obterPorTRB(pIdOrganizacao,
      pIdTitutloReceberBaixa: String): Boolean;
  end;

var
  dmTRBDeducao: TdmTRBDeducao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


function TdmTRBDeducao.obterPorTRB(pIdOrganizacao, pIdTitutloReceberBaixa
  : String): Boolean;
begin

  Result := false;

  inicializarDM(Self);

  if not qryObterPorTRB.Connection.Connected then
  begin
    qryObterPorTRB.Connection := dmConexao.Conn;
  end;

  qryObterPorTRB.Close;

  qryObterPorTRB.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterPorTRB.ParamByName('PIDTITULORECEBERBAIXA').AsString :=pIdTitutloReceberBaixa;
  qryObterPorTRB.Open;

  Result := not qryObterPorTRB.IsEmpty;
end;




procedure TdmTRBDeducao.inicializarDM(Sender: TObject);
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
