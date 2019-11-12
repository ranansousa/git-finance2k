unit udmIBase;

interface

uses
  System.SysUtils, System.Classes, udmConexao,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, UCHistDataset, UCHist_Base;

type
  TdmIBase = class(TDataModule)
    UCHist_DataSet1: TUCHist_DataSet;
    qryLog: TFDQuery;
    qryPost: TFDQuery;
    qryPesquisaConteudoAnteriorCampo: TFDQuery;
    qryPesquisaFk: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmIBase: TdmIBase;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
