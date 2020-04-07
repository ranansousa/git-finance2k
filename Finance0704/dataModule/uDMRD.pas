unit uDMRD;

interface

uses
  System.SysUtils, System.Classes, udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxClass, frxExportCSV,
  frxExportPDF, frxDBSet, frxExportBaseDialog;

type
  TdmRD = class(TDataModule)
    qryDespesas: TFDQuery;
    frxPDFExport1: TfrxPDFExport;
    frxCSVExport1: TfrxCSVExport;
    frxReportRD: TfrxReport;
    qryReceitas: TFDQuery;
    frxDespesas: TfrxDBDataset;
    frxReceitas: TfrxDBDataset;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    //todos os dados serão por centro de custos
    function obterReceitas(pIdOrganizacao: string; pDataInicial, pDataFinal: TDate): Boolean;
    function obterDespesas(pIdOrganizacao: string; pDataInicial, pDataFinal: TDate): Boolean;


  end;

var
  dmRD: TdmRD;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmRD }

procedure TdmRD.DataModuleCreate(Sender: TObject);
begin
 dmConexao.conectarBanco ;
end;

function TdmRD.obterDespesas(pIdOrganizacao: string; pDataInicial,
  pDataFinal: TDate): Boolean;
begin

  try
        qryDespesas.Connection := dmConexao.Conn;
        qryDespesas.Close;
        qryDespesas.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryDespesas.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', pDataInicial);
        qryDespesas.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', pDataFinal);

        qryDespesas.Open;

  except
    raise(Exception).Create('Problemas ao consultar despesas por centro de custos ');
  end;

  Result := not qryDespesas.IsEmpty;


end;

function TdmRD.obterReceitas(pIdOrganizacao: string; pDataInicial,
  pDataFinal: TDate): Boolean;
begin

  try
        qryReceitas.Connection := dmConexao.Conn;
        qryReceitas.Close;
        qryReceitas.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryReceitas.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', pDataInicial);
        qryReceitas.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', pDataFinal);

        qryReceitas.Open;

  except
    raise(Exception).Create('Problemas ao consultar receitas por centro de custos ');
  end;

  Result := not qryReceitas.IsEmpty;


end;

end.
