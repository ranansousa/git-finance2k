unit uDMExportaFinanceTR;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, udmConexao;

type
  TdmExportFinanceTR = class(TDataModule)
    qryTRProvisionados: TFDQuery;
    qryTitulosQuitados: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
  public
    { Public declarations }
    function obterTRProvisionados(pIdOrganizacao, pIdStatus: String;
      pDataInicial, pDataFinal: TDateTime; pProvisao: Integer): Boolean;
      function obterTRQuitados(pIdOrganizacao, pIdStatus: String;
      pDataInicial, pDataFinal: TDateTime): Boolean;

  end;

var
  dmExportFinanceTR: TdmExportFinanceTR;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TdmExportFinanceTR }



procedure TdmExportFinanceTR.inicializarDM(Sender: TObject);
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

function TdmExportFinanceTR.obterTRProvisionados(pIdOrganizacao,
  pIdStatus: String; pDataInicial, pDataFinal: TDateTime;
  pProvisao: Integer): Boolean;
begin
  inicializarDM(Self);
  Result := false;

  qryTRProvisionados.Close;
  if not qryTRProvisionados.Connection.Connected then
  begin
    qryTRProvisionados.Connection := dmConexao.Conn;
  end;
  qryTRProvisionados.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryTRProvisionados.ParamByName('pIdStatus').AsString := pIdStatus;
  qryTRProvisionados.ParamByName('pDataInicial').AsDate := pDataInicial;
  qryTRProvisionados.ParamByName('pDataFinal').AsDate := pDataFinal;
  qryTRProvisionados.ParamByName('pProvisao').AsInteger := pProvisao;
  qryTRProvisionados.Open;

  Result := not qryTRProvisionados.IsEmpty;
end;

function TdmExportFinanceTR.obterTRQuitados(pIdOrganizacao,
  pIdStatus: String; pDataInicial, pDataFinal: TDateTime): Boolean;
begin
  inicializarDM(Self);
  Result := false;

  qryTitulosQuitados.Close;
  if not qryTitulosQuitados.Connection.Connected then
  begin
    qryTitulosQuitados.Connection := dmConexao.Conn;
  end;
  qryTitulosQuitados.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryTitulosQuitados.ParamByName('pIdStatus').AsString := pIdStatus;
  qryTitulosQuitados.ParamByName('pDataInicial').AsDate := pDataInicial;
  qryTitulosQuitados.ParamByName('pDataFinal').AsDate := pDataFinal;
  qryTRProvisionados.Open;

  Result := not qryTRProvisionados.IsEmpty;
end;

end.
