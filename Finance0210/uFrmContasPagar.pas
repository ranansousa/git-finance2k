unit uFrmContasPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.DBCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids,uDMContasPagar,udmConexao,uDMEspelhoTP,  uTituloPagarDAO, System.Generics.Collections,
  Vcl.ComCtrls, Vcl.StdCtrls, uUtil, FireDAC.Stan.Intf, FireDAC.Stan.Option, uTituloPagarModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons;

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
    dsPreencheGrid: TDataSource;
    dsTituloPagar: TDataSource;
    btnFechar: TBitBtn;
    btn1: TButton;

    procedure btnConsultarClick(Sender: TObject);
    procedure dbgTPDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtConsultaChange(Sender: TObject);
    procedure btnTodosClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    idOrganizacao : string;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM();
    function liberaExibirRelatorio: Integer;


  public
    { Public declarations }
  end;

var
  frmContasPagar: TfrmContasPagar;

implementation




{$R *.dfm}

procedure TfrmContasPagar.btn1Click(Sender: TObject);
var lista : TObjectList<TTituloPagarModel>;
dataInicio, dataFim :TDateTime;
qtd :Integer;
begin
qtd:=0;

  dataInicio := IncMonth(Now, -10);
  dataFim := IncMonth(Now, 1);

  lista := TTituloPagarDAO.obterTodosPagar( dataInicio, dataFim,idOrganizacao);


   qtd := lista.Count;


end;

procedure TfrmContasPagar.btnConsultarClick(Sender: TObject);
var
  sql,coluna:string;
  i : Integer;
begin
  sql := ' SELECT TP.ID_TITULO_PAGAR, TP.ID_ORGANIZACAO, TP.NUMERO_DOCUMENTO, TP.VALOR_NOMINAL, TP.DESCRICAO, TP.DATA_EMISSAO, '+
         ' TP.DATA_VENCIMENTO, TP.DATA_PAGAMENTO, TP.DATA_PROTOCOLO, TP.PARCELA, C.NOME AS FORNECEDOR  FROM  TITULO_PAGAR TP ' +
         ' LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND (C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) ';
  coluna := EmptyStr;
  for i := 0 to Pred(dsTituloPagar.DataSet.FieldCount) do
  begin
    if dsTituloPagar.DataSet.Fields[i].DisplayLabel = cbbColunas.Text then
       coluna := dsTituloPagar.DataSet.Fields[i].FieldName;
  end;

    dsTituloPagar.DataSet.Close();
    (dsTituloPagar.DataSet as TFDQuery).SQL.Clear;
    (dsTituloPagar.DataSet as TFDQuery).SQL.Text := sql + ' WHERE (TP.ID_ORGANIZACAO  = :PIDORGANIZACAO) '+
                                                          ' AND ' + coluna+ ' = :valor ';
    (dsTituloPagar.DataSet as TFDQuery).ParamByName('valor').AsString := edtConsulta.Text;
    (dsTituloPagar.DataSet as TFDQuery).ParamByName('PIDORGANIZACAO').AsString := TOrgAtual.getId;
    dsTituloPagar.DataSet.Open();

  if not dsTituloPagar.DataSet.IsEmpty then begin
     btnImprimir.Enabled :=True;
  end;

end;

procedure TfrmContasPagar.btnFecharClick(Sender: TObject);
begin
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmContasPagar.btnImprimirClick(Sender: TObject);
begin

 if (dmEspelhoTP.obterPorNumeroDocumento(TOrgAtual.getId, edtConsulta.Text)) then begin
          if (liberaExibirRelatorio > 0) then        begin

         dmEspelhoTP.exibirRelatorio(uutil.getDataServer, uutil.getDataServer);
      end
      else
      begin
        btnImprimir.Enabled := false;
        ShowMessage('Não existem dados para imprimir.');
      end

  end;

    btnTodosClick(Self); //carrega o dbgrid novamente

end;

procedure TfrmContasPagar.btnTodosClick(Sender: TObject);
var
  sql,coluna:string;
begin
   sql := 'SELECT TP.ID_TITULO_PAGAR, TP.ID_ORGANIZACAO, TP.NUMERO_DOCUMENTO, TP.VALOR_NOMINAL, TP.DESCRICAO, TP.DATA_EMISSAO, TP.DATA_VENCIMENTO, TP.DATA_PAGAMENTO, TP.DATA_PROTOCOLO, TP.PARCELA, C.NOME AS FORNECEDOR FROM  TITULO_PAGAR TP ' +
         ' LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND (C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) ';

   dsTituloPagar.DataSet.Close();
  (dsTituloPagar.DataSet as TFDQuery).SQL.Clear;
  (dsTituloPagar.DataSet as TFDQuery).SQL.Text := sql + ' WHERE (TP.ID_ORGANIZACAO  = :PIDORGANIZACAO) '+
                                                        ' AND  (TP.ID_TIPO_STATUS in (''ABERTO'',''QUITADO'',''PARCIAL'')) ' +
                                                        ' ORDER BY TP.DATA_VENCIMENTO DESC, TP.VALOR_NOMINAL ';

   (dsTituloPagar.DataSet as TFDQuery).ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
   dsTituloPagar.DataSet.Open();

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
 Action := caFree;

end;

procedure TfrmContasPagar.FormCreate(Sender: TObject);
var
i : Integer;
begin
inicializarDM(Self);

  dmContasPagar.obterTodos(idOrganizacao);

  for i := 0 to Pred(dsTituloPagar.DataSet.FieldCount) do
  begin
    if dsTituloPagar.DataSet.Fields[i].DisplayLabel = 'NUMERO_DOCUMENTO' then
       cbbColunas.Items.Add(dsTituloPagar.DataSet.Fields[i].DisplayLabel);
  end;
  cbbColunas.ItemIndex :=0;
  btnConsultar.Enabled :=False;
  btnImprimir.Enabled :=False;
end;


procedure TfrmContasPagar.freeAndNilDM;
begin

  if  (Assigned(dmContasPagar)) then
  begin
    FreeAndNil(dmContasPagar);
  end;

  if  (Assigned(dmEspelhoTP)) then
  begin
    FreeAndNil(dmEspelhoTP);
  end;


end;

procedure TfrmContasPagar.inicializarDM(Sender: TObject);
begin
   if not(Assigned(dmContasPagar)) then
  begin
    dmContasPagar := TdmContasPagar.Create(Self);
  end  ;


  if not(Assigned(dmEspelhoTP)) then
  begin
    dmEspelhoTP := TdmEspelhoTP.Create(Self);
  end  ;

  idOrganizacao := TOrgAtual.getId;


end;


function TfrmContasPagar.liberaExibirRelatorio: Integer;
begin
Result :=1;
end;

end.
