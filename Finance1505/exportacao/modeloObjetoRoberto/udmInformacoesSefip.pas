unit udmInformacoesSefip;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmInformacoesSefip = class(TDataModule)
    qryColaboradores: TFDQuery;
    qryColaboradoresSefip650: TFDQuery;
    qryFuncionarioSituacaoLinha32: TFDQuery;
    qrySpDiasTrabalhados: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmInformacoesSefip: TdmInformacoesSefip;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
