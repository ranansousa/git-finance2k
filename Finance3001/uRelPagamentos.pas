unit uRelPagamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,uDMOrganizacao,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands,uDMContasPagar,udmConexao, FireDAC.Stan.Util, FireDAC.Comp.Script, Vcl.Grids, Vcl.DBGrids, frxClass,
  frxDBSet, frxExportPDF, frxExportCSV;

  //uDM está aqui temporariamente


type
  TFRelPagamentos = class(TForm)
    dtDataInicial: TDateTimePicker;
    dtDataFinal: TDateTimePicker;
    cbxOrganizacoes: TComboBox;
    cbxCentrosCusto: TComboBox;
    cbxStatus: TComboBox;
    cbxOrdem: TComboBox;
    Button1: TButton;
    DBGridMain: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    frxRelContasPagar: TfrxReport;
    frxDBTitulos: TfrxDBDataset;
    frxDBCentroCusto: TfrxDBDataset;
    frxCSVExport1: TfrxCSVExport;
    frxPDFExport1: TfrxPDFExport;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FsListaIdOrganizacoes: TStringList;
    FsListaIdCentrosCusto: TStringList;

    function carregarCentrosCusto: Boolean;
    procedure preencherListaCentrosCusto;
    function montarSQL: Boolean;
    function retornarCampoOrdenacao: string;
    procedure exibirRelatorio;
    procedure inicializarVariaveisRelatorio;
    function validarFormulario: boolean;
    procedure carregarDadosEmpresa;
    function retornarCaminhoRelatorio: string;
  public
    { Public declarations }
        procedure preencherListaOrganizacoes;
        function carregarDadosPagamentos: boolean;

  end;

var
  FRelPagamentos: TFRelPagamentos;

implementation

{$R *.dfm}



procedure TFRelPagamentos.Button1Click(Sender: TObject);
begin
  //Verificar se precisa fazer alguma validação da informações do formulário
  if validarFormulario then begin
    carregarDadosEmpresa;

    if carregarDadosPagamentos then begin
      exibirRelatorio;

    end else begin
      //Mensagem para sem dados para apresentar
    end;
  end;
end;

function TFRelPagamentos.carregarCentrosCusto: Boolean;
begin
  dmContasPagar.qryCentroCusto.Close;
  dmContasPagar.qryCentroCusto.Open;
  Result := not dmContasPagar.qryCentroCusto.IsEmpty;
end;

procedure TFRelPagamentos.carregarDadosEmpresa;
begin
    dmOrganizacao.qryDadosEmpresa.Close;
    dmOrganizacao.qryDadosEmpresa.ParamByName('pIdOrganizacao').AsString := FsListaIdOrganizacoes[cbxOrganizacoes.ItemIndex];
    dmOrganizacao.qryDadosEmpresa.Open;
end;

function TFRelPagamentos.carregarDadosPagamentos: Boolean;
begin
  Result := false;
  if montarSQL then begin
    dmContasPagar.qryRelPagamentos.Close;
    dmContasPagar.qryRelPagamentos.Open;
    Result := not dmContasPagar.qryRelPagamentos.IsEmpty;
  end;
end;


procedure TFRelPagamentos.exibirRelatorio;
begin
  frxRelContasPagar.Clear;
  if not (frxRelContasPagar.LoadFromFile(retornarCaminhoRelatorio)) then begin
    //Mensagem não encontrou o arquivo do relatorio. Fazer


  end else begin
    inicializarVariaveisRelatorio;
    frxRelContasPagar.OldStyleProgress := True;
    frxRelContasPagar.ShowProgress     := True;
    frxRelContasPagar.ShowReport;
  end;
end;

procedure TFRelPagamentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FsListaIdOrganizacoes) then begin
    FsListaIdOrganizacoes := nil;
  end;
  if Assigned(FsListaIdCentrosCusto) then begin
    FsListaIdCentrosCusto := nil;
  end;

  if Assigned(dmContasPagar) then begin
   FreeAndNil(dmContasPagar) ;
  end;

end;

procedure TFRelPagamentos.FormCreate(Sender: TObject);
begin
  //Obs.: Me lembre de falar do uses UBackup macoronada e da forma que a conexão está sendo feita
  //iniciar aplicação com uma tab específica

     if not (Assigned(dmContasPagar)) then begin
          dmContasPagar := TdmContasPagar.Create(Self);
     end;


  if dmOrganizacao.carregarOrganizacoes then begin
    preencherListaOrganizacoes;
    dtDataInicial.Date := now;
    dtDataFinal.Date := now;

  end;
  if carregarCentrosCusto then begin
    preencherListaCentrosCusto;
  end;
end;

procedure TFRelPagamentos.inicializarVariaveisRelatorio;
begin
  with frxRelContasPagar.Variables do begin
    Variables['strRazaoSocial'] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL').AsString);
    Variables['strCNPJ'       ] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ'        ).AsString);
    Variables['strEndereco'   ] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('ENDERECO'    ).AsString);
    Variables['strCEP'        ] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CEP'         ).AsString);
    Variables['strCidade'     ] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CIDADE'      ).AsString);
    Variables['strUF'         ] := QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF'          ).AsString);
    Variables['strTipoStatus' ] := QuotedStr(cbxStatus.Items[cbxStatus.ItemIndex]);

  end;
end;



function TFRelPagamentos.montarSQL: Boolean;
var
  lsSQL: TStringList;
begin
  lsSQL := TStringList.Create;
  lsSQL.AddStrings(dmContasPagar.sqlScriptContainer.SQLScripts.FindScript('sqlRelPagamentos').SQL);
  lsSQL.Add('WHERE');
  lsSQL.Add(Format('  (TP.DATA_VENCIMENTO BETWEEN %s AND %s)',[QuotedStr(FormatDateTime('dd.mm.yyyy',dtDataInicial.Date)),QuotedStr(FormatDateTime('dd.mm.yyyy',dtDataFinal.Date))]));
  lsSQL.Add('AND');
  lsSQL.Add(Format('  (TP.ID_ORGANIZACAO = %s)',[QuotedStr(FsListaIdOrganizacoes[cbxOrganizacoes.ItemIndex])]));
  if (cbxCentrosCusto.ItemIndex > 0) then begin
    lsSQL.Add('AND');
    lsSQL.Add(Format('  (TP.ID_CENTRO_CUSTO = %s)',[QuotedStr(FsListaIdCentrosCusto[cbxCentrosCusto.ItemIndex])]));
  end;
  if (cbxStatus.ItemIndex > 0) then begin
    lsSQL.Add('AND');
    lsSQL.Add(Format('  (TP.ID_TIPO_STATUS = %s)',[QuotedStr(cbxStatus.Items[cbxStatus.ItemIndex])]));
  end;
  lsSQL.Add('ORDER BY');
  lsSQL.Add('  ' + retornarCampoOrdenacao);

  dmContasPagar.qryRelPagamentos.SQL.Clear;
  dmContasPagar.qryRelPagamentos.SQL.Assign(lsSQL);

  Result := (lsSQL.Count > 0);
  lsSql := nil;
end;

procedure TFRelPagamentos.preencherListaCentrosCusto;
begin
  FsListaIdCentrosCusto := TStringList.Create;
  FsListaIdCentrosCusto.Clear;
  FsListaIdCentrosCusto.Add('Sem ID'); //Linha adicionada somente para combatibilizar com os itens do ComboBox cbxCentrosCusto
  cbxCentrosCusto.Clear;
  cbxCentrosCusto.Items.Add('TODOS');
  dmContasPagar.qryCentroCusto.First;
  while not dmContasPagar.qryCentroCusto.Eof do begin
    cbxCentrosCusto.Items.Add(dmContasPagar.qryCentroCusto.FieldByName('DESCRICAO'     ).AsString);
    FsListaIdCentrosCusto.Add(dmContasPagar.qryCentroCusto.FieldByName('ID_CENTRO_CUSTO').AsString);
    dmContasPagar.qryCentroCusto.Next;
  end;
  dmContasPagar.qryCentroCusto.Close;
  cbxCentrosCusto.ItemIndex := 0;
end;

procedure TFRelPagamentos.preencherListaOrganizacoes;
begin
  FsListaIdOrganizacoes := TStringList.Create;
  FsListaIdOrganizacoes.Clear;
  cbxOrganizacoes.Clear;
  dmOrganizacao.qryOrganizacoes.First;
  while not dmOrganizacao.qryOrganizacoes.Eof do begin
    cbxOrganizacoes.Items.Add(dmOrganizacao.qryOrganizacoes.FieldByName('NOME'          ).AsString);
    FsListaIdOrganizacoes.Add(dmOrganizacao.qryOrganizacoes.FieldByName('ID_ORGANIZACAO').AsString);
    dmOrganizacao.qryOrganizacoes.Next;
  end;
  dmOrganizacao.qryOrganizacoes.Close;
  cbxOrganizacoes.ItemIndex := 0;
end;

function TFRelPagamentos.retornarCaminhoRelatorio: string;
begin
  if (cbxStatus.Items[cbxStatus.ItemIndex].ToUpper.Equals('QUITADO')) then begin
    Result := ExtractFilePath(Application.ExeName) + 'relContasPagarQuitadoAnalitico.fr3';
  end else begin
    Result := ExtractFilePath(Application.ExeName) + 'relContasPagarQuitadoAnalitico.fr3';
  end;
end;

function TFRelPagamentos.retornarCampoOrdenacao: string;
begin
  case cbxOrdem.ItemIndex of
    0: Result := 'TP.VALOR_NOMINAL';
    1: Result := 'C.NOME';
    2: Result := 'CC.DESCRICAO';
    3: Result := 'TP.DATA_PAGAMENTO';
    4: Result := 'TP.DATA_VENCIMENTO';
    5: Result := 'H.DESCRICAO';
    6: Result := 'T.DESCRICAO';
  end;
end;

function TFRelPagamentos.validarFormulario: boolean;
begin
  Result := true;
end;

end.
