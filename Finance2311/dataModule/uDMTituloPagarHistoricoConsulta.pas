unit uDMTituloPagarHistoricoConsulta;

interface

uses
  uTituloPagarHistoricoModel, System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmTPHistoricoConsulta = class(TDataModule)
    qryObterTPHistoricoPorTP: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
  public
    { Public declarations }
    function obterListaTituloPagarHistoricoPorTitulo(pIdorganizacao, pIdTituloPagar: string): Boolean;
    function obterListaExportacao: TList;
  end;

var
  dmTPHistoricoConsulta: TdmTPHistoricoConsulta;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TdmTPHistoricoConsulta }

function TdmTPHistoricoConsulta.obterListaExportacao: TList;
var
  lista: TList;
  tPHistorico: TTituloPagarHistoricoModel;
begin
  lista.Create;

  while (not qryObterTPHistoricoPorTP.Eof) do
  begin
   {
    tPHistorico.Create;
    tPHistorico.SetCodHistorico(qryObterTPHistoricoPorTP.FieldByName('CODIGO').AsInteger);
    tPHistorico.SetCodReduz(qryObterTPHistoricoPorTP.FieldByName('CODREDUZ').AsInteger);
    tPHistorico.SetDgCodReduz(qryObterTPHistoricoPorTP.FieldByName('DGREDUZ').AsString);
    tPHistorico.SetConta(qryObterTPHistoricoPorTP.FieldByName('CONTA').AsString);
    tPHistorico.SetDgVer(qryObterTPHistoricoPorTP.FieldByName('DGVER').AsString);
    tPHistorico.SetValor(qryObterTPHistoricoPorTP.FieldByName('VALOR').AsCurrency);
    tPHistorico.SetDescricao(qryObterTPHistoricoPorTP.FieldByName('DESCRICAO').AsString);

    lista.Add(tPHistorico);  }

  end;

  Result := lista;

end;

function TdmTPHistoricoConsulta.obterListaTituloPagarHistoricoPorTitulo(pIdorganizacao, pIdTituloPagar: string): Boolean;
begin
  Result := false;

  if not qryObterTPHistoricoPorTP.Connection.Connected then
  begin
    qryObterTPHistoricoPorTP.Connection := dmConexao.Conn;
  end;

  qryObterTPHistoricoPorTP.Close;
  qryObterTPHistoricoPorTP.ParamByName('pId_TITULO_PAGAR').AsString := pIdTituloPagar;
  qryObterTPHistoricoPorTP.ParamByName('pIdOrganizacao').AsString := pIdorganizacao;
  qryObterTPHistoricoPorTP.Open();

  Result := not qryObterTPHistoricoPorTP.IsEmpty;

end;

procedure TdmTPHistoricoConsulta.inicializarDM(Sender: TObject);
begin

  if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end
  else
  begin
    dmConexao.conectarBanco;
  end;
end;

end.


