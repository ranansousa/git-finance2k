unit uDMTesourariaDebittoConsulta;

interface

uses
  System.SysUtils, System.Classes, udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmTDConsulta = class(TDataModule)
    FDQuery1: TFDQuery;
    FDQuery2: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmTDConsulta: TdmTDConsulta;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



procedure TdmTDConsulta.inicializarDM(Sender: TObject);
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
