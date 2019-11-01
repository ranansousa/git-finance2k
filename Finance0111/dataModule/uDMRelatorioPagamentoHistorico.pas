unit uDMRelatorioPagamentoHistorico;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,uDMContasPagar,uDMCedenteConsulta, frxClass, frxDBSet,
  frxExportCSV, frxExportPDF;

type
  TdmRelTPDetalhado = class(TDataModule)
    procedure DTSTituloPorCedenteDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmRelTPDetalhado: TdmRelTPDetalhado;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmRelTPDetalhado.DTSTituloPorCedenteDataChange(Sender: TObject;
  Field: TField);
begin
//carrega os titulos

end;

end.
