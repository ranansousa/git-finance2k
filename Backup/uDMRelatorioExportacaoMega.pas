unit uDMRelatorioExportacaoMega;

interface

uses
  System.SysUtils, ShellApi,System.Classes, frxClass, frxDBSet,
  Winapi.Windows, Winapi.Messages, Vcl.Forms,System.Variants,
  udmConexao, uDMOrganizacao,uDMExportaFinance, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmRelExportacaoMega = class(TDataModule)
    frxRelatorioExportacaoMega: TfrxReport;
    frxDBTitulos: TfrxDBDataset;
    frxDBHistoricos: TfrxDBDataset;
    frxDBCentroCusto: TfrxDBDataset;
    frxDBTRProv: TfrxDBDataset;
    frxDBHistTR: TfrxDBDataset;
    frxDBCCustoTR: TfrxDBDataset;
    qryTRProvisionados: TFDQuery;
    qryHistoricoTR: TFDQuery;
    qryCentroCustoTR: TFDQuery;
  private
    { Private declarations }

  public
    { Public declarations }
    function retornarCaminhoRelatorio: string;
    procedure inicializarVariaveisRelatorio;
    procedure exibirRelatorioExportacao;
    function obterTRProvisionados(pIdOrganizacao,pIdStatus :String; pDataInicial, pDataFinal:TDateTime;pProvisao :Integer): Boolean;
  end;

var
  dmRelExportacaoMega: TdmRelExportacaoMega;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdmRelExportacaoMega.retornarCaminhoRelatorio: string;
begin
  Result := ExtractFilePath(Application.ExeName) + 'relExportacaoMegaContabil.fr3';
end;

procedure TdmRelExportacaoMega.inicializarVariaveisRelatorio;
var
tipo:String;
begin
tipo := 'TPPROV';
  with frxRelatorioExportacaoMega.Variables do begin
    Variables['strRazaoSocial'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL').AsString);
    Variables['strCNPJ'       ] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ'        ).AsString);
    Variables['strEndereco'   ] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('ENDERECO'    ).AsString);
    Variables['strCEP'        ] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CEP'         ).AsString);
    Variables['strCidade'     ] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CIDADE'      ).AsString);
    Variables['strUF'         ] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF'          ).AsString);
    Variables['strTipo'       ] := QuotedStr(tipo); //muda a depender do lancamento


   end;

end;

procedure TdmRelExportacaoMega.exibirRelatorioExportacao;
begin

  frxRelatorioExportacaoMega.Clear;
  if not (frxRelatorioExportacaoMega.LoadFromFile(retornarCaminhoRelatorio)) then begin
    //Mensagem não encontrou o arquivo do relatorio. Fazer try p levantar erros

  end else begin
    inicializarVariaveisRelatorio;

    frxRelatorioExportacaoMega.OldStyleProgress := True;
    frxRelatorioExportacaoMega.ShowProgress     := True;
    frxRelatorioExportacaoMega.ShowReport;
  end;
end;


  //carrega titulos a receber provisionados
function TdmRelExportacaoMega.obterTRProvisionados(pIdOrganizacao,pIdStatus :String; pDataInicial, pDataFinal:TDateTime;pProvisao :Integer): Boolean;
 begin
  Result := false;

   qryTRProvisionados .Close;
   if not qryTRProvisionados.Connection.Connected then begin
         qryTRProvisionados.Connection := dmConexao.Conn;
   end;
    qryTRProvisionados.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
    qryTRProvisionados.ParamByName('pIdStatus').AsString := pIdStatus;
    qryTRProvisionados.ParamByName('pDataInicial').AsDate := pDataInicial;
    qryTRProvisionados.ParamByName('pDataFinal').AsDate := pDataFinal;
    qryTRProvisionados.ParamByName('pProvisao').AsInteger := pProvisao;
    qryTRProvisionados.Open;

    Result := not qryTRProvisionados.IsEmpty;

 end;



end.
