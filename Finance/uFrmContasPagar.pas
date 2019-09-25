unit uFrmContasPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.DBCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids,uDMContasPagar,uDMContasPagarManter,uDMContasPagarDTS,udmConexao,
  Vcl.ComCtrls, Vcl.StdCtrls, uUtil, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmContasPagar = class(TForm)
    barNavegaTP: TDBNavigator;
    dbgTP: TDBGrid;
    pgcTiuloPagar: TPageControl;
    tsConsulta: TTabSheet;
    tsCadastro: TTabSheet;
    cbbColunas: TComboBox;
    edtConsulta: TEdit;
    btnConsultar: TButton;
    btnTodos: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    btnImprimir: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure dbgTPDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtConsultaChange(Sender: TObject);
    procedure btnTodosClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM();
  public
    { Public declarations }
  end;

var
  frmContasPagar: TfrmContasPagar;

implementation




{$R *.dfm}

procedure TfrmContasPagar.btnConsultarClick(Sender: TObject);
var
  sql,coluna:string;
  i : Integer;
begin
  sql := 'SELECT TP.ID_TITULO_PAGAR, TP.ID_ORGANIZACAO, TP.NUMERO_DOCUMENTO, TP.VALOR_NOMINAL, TP.DESCRICAO, TP.DATA_EMISSAO, TP.DATA_VENCIMENTO, TP.DATA_PAGAMENTO, TP.DATA_PROTOCOLO, TP.PARCELA, C.NOME AS FORNECEDOR  FROM  TITULO_PAGAR TP ' +
         ' LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND (C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) ';
  coluna := EmptyStr;
  for i := 0 to Pred(dmContasPagarDTS.dtsTituloPagar.DataSet.FieldCount) do
  begin
    if dmContasPagarDTS.dtsTituloPagar.DataSet.Fields[i].DisplayLabel = cbbColunas.Text then
       coluna := dmContasPagarDTS.dtsTituloPagar.DataSet.Fields[i].FieldName;
  end;
  dmContasPagarDTS.dtsTituloPagar.DataSet.Close();
   (dmContasPagarDTS.dtsTituloPagar.DataSet as TFDQuery).SQL.Clear;
  (dmContasPagarDTS.dtsTituloPagar.DataSet as TFDQuery).SQL.Text := sql + ' WHERE (TP.ID_ORGANIZACAO  = :PIDORGANIZACAO)'+
   ' AND ' + coluna+ ' = :valor ';
  (dmContasPagarDTS.dtsTituloPagar.DataSet as TFDQuery).ParamByName('valor').AsString := edtConsulta.Text;
    (dmContasPagarDTS.dtsTituloPagar.DataSet as TFDQuery).ParamByName('PIDORGANIZACAO').AsString := TOrgAtual.getId;
  dmContasPagarDTS.dtsTituloPagar.DataSet.Open();

  if not dmContasPagarDTS.dtsTituloPagar.DataSet.IsEmpty then begin
     btnImprimir.Enabled :=True;
  end;

end;

procedure TfrmContasPagar.btnImprimirClick(Sender: TObject);
begin

 if ( dmContasPagar.obterPorNumeroDocumento(TOrgAtual.getId, edtConsulta.Text)) then begin
      ShowMessage('ACEHIEIIIIII');
 end;

    btnTodosClick(Self); //carrega o dbgrid novamente

end;

procedure TfrmContasPagar.btnTodosClick(Sender: TObject);
var
  sql,coluna:string;
begin
   sql := 'SELECT TP.ID_TITULO_PAGAR, TP.ID_ORGANIZACAO, TP.NUMERO_DOCUMENTO, TP.VALOR_NOMINAL, TP.DESCRICAO, TP.DATA_EMISSAO, TP.DATA_VENCIMENTO, TP.DATA_PAGAMENTO, TP.DATA_PROTOCOLO, TP.PARCELA, C.NOME AS FORNECEDOR FROM  TITULO_PAGAR TP ' +
         ' LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND (C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) ';

   dmContasPagarDTS.dtsTituloPagar.DataSet.Close();
   (dmContasPagarDTS.dtsTituloPagar.DataSet as TFDQuery).SQL.Clear;
  (dmContasPagarDTS.dtsTituloPagar.DataSet as TFDQuery).SQL.Text := sql + ' WHERE (TP.ID_ORGANIZACAO  = :PIDORGANIZACAO) '+
   ' AND  (TP.ID_TIPO_STATUS in (''ABERTO'',''QUITADO'',''PARCIAL'')) ORDER BY TP.DATA_VENCIMENTO DESC, TP.VALOR_NOMINAL ';
    (dmContasPagarDTS.dtsTituloPagar.DataSet as TFDQuery).ParamByName('PIDORGANIZACAO').AsString := TOrgAtual.getId;
  dmContasPagarDTS.dtsTituloPagar.DataSet.Open();

end;

procedure TfrmContasPagar.dbgTPDblClick(Sender: TObject);
begin
pgcTiuloPagar.ActivePageIndex := 1;
end;

procedure TfrmContasPagar.edtConsultaChange(Sender: TObject);
begin
btnConsultar.Enabled :=True;

end;

procedure TfrmContasPagar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freeAndNilDM();
 Action := caFree; // sempre como ultimo comando

end;

procedure TfrmContasPagar.FormCreate(Sender: TObject);
begin
inicializarDM(Self);

btnConsultar.Enabled :=False;
btnImprimir.Enabled :=False;
end;

procedure TfrmContasPagar.FormShow(Sender: TObject);
var
  i:Integer;
begin

 dmContasPagar.obterTodos(TOrgAtual.getId);


  for i := 0 to Pred(dmContasPagarDTS.dtsTituloPagar.DataSet.FieldCount) do
  begin
    if dmContasPagarDTS.dtsTituloPagar.DataSet.Fields[i].DisplayLabel = 'NUMERO_DOCUMENTO' then
      cbbColunas.Items.Add(dmContasPagarDTS.dtsTituloPagar.DataSet.Fields[i].DisplayLabel);
       cbbColunas.ItemIndex :=0;

  end;

 // SQL := (dsGeral.DataSet as TADOQuery).SQL.Text;

end;

procedure TfrmContasPagar.freeAndNilDM;
begin
if  (Assigned(dmContasPagarDTS)) then
  begin
    FreeAndNil(dmContasPagarDTS);
  end;


  if  (Assigned(dmContasPagarManter)) then
  begin
    FreeAndNil(dmContasPagarManter);
  end;


  if  (Assigned(dmContasPagar)) then
  begin
    FreeAndNil(dmContasPagar);
  end;

end;

procedure TfrmContasPagar.inicializarDM(Sender: TObject);
begin

  if not(Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end ;


  if not(Assigned(dmContasPagarManter)) then
  begin
    dmContasPagarManter := TdmContasPagarManter.Create(Self);
  end ;


   if not(Assigned(dmContasPagar)) then
  begin
    dmContasPagar := TdmContasPagar.Create(Self);
  end  ;

  if not(Assigned(dmContasPagarDTS)) then
  begin
    dmContasPagarDTS := TdmContasPagarDTS.Create(Self);
  end  ;

end;


end.