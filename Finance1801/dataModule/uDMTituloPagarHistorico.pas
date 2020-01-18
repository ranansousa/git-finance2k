unit uDMTituloPagarHistorico;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmTPHistoricoConsulta = class(TDataModule)
    qryObterTPHistoricoPorTitulo: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmTPHistoricoConsulta: TdmTPHistoricoConsulta;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
