unit uFrmTelaPagamentoLoteTP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,uUtil, System.DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxRibbonSkins, dxRibbonCustomizationForm, cxClasses,
  dxRibbon, dxBar, dxStatusBar, Data.DB, Vcl.Grids, Vcl.DBGrids, udmConexao, uDMOrganizacao,uTituloPagarModel, uTituloPagarDAO,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,  uFrmBaixaTPLoteFP,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  cxTextEdit, cxBarEditItem, dxBarExtItems, EMsgDlg, cxCalendar, cxButtonEdit,
  Data.FMTBcd, Data.SqlExpr ;

type
  TfrmPagamentoLoteTitulos = class(TForm)
    dxBarManager1: TdxBarManager;
    menuBaixaTP: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    dbgrdMain: TDBGrid;
    dsTitulos: TDataSource;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar3: TdxBar;
    cxbrdtmPesquisa: TcxBarEditItem;
    dxBtnFechar: TdxBarLargeButton;
    dxBtnPagar: TdxBarLargeButton;
    dxBtnPagarAV: TdxBarLargeButton;
    qryPreencheGrid: TFDQuery;
    dxBarManager1Bar4: TdxBar;
    PempecMsg: TEvMsgDlg;
    dtInicial: TcxBarEditItem;
    dtFinal: TcxBarEditItem;
    cxBarEditItem1: TcxBarEditItem;
    dxBtnConsulta: TdxBarButton;
    fdmLoteTP: TFDMemTable;
    dxBarEdit1: TdxBarEdit;
    cxBarPesquisaCedente: TcxBarEditItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cxbrdtmPesquisaCurChange(Sender: TObject);
    procedure dxBtnFecharClick(Sender: TObject);
    procedure dbgrdMainTitleClick(Column: TColumn);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dsTitulosDataChange(Sender: TObject; Field: TField);
    procedure dxBtnPagarClick(Sender: TObject);
    procedure dxBtnPagarAVClick(Sender: TObject);
    procedure dtInicialChange(Sender: TObject);
    procedure dtFinalChange(Sender: TObject);
    procedure dxBtnConsultaClick(Sender: TObject);
    procedure dbgrdMainDblClick(Sender: TObject);
    procedure cxBarPesquisaCedenteCurChange(Sender: TObject);
  private
    { Private declarations }
    FSListaIDTP :TStringList;
    pIdTP,  pIdOrganizacao, pIdUsuario :string;
      vlrDevido : Currency;
      pTitulo :TTituloPagarModel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    procedure LimpaTela(Form: TForm);
    procedure preencherGrid;
    procedure limpar;
    function preencheGrid(pIdOrganizacao: string; pDataInicio, pDataFim :TDateTime) :Boolean;
    procedure createTable;
    function calcularValorDevido : string;
  public
    { Public declarations }
  end;

var
  frmPagamentoLoteTitulos: TfrmPagamentoLoteTitulos;

implementation

{$R *.dfm}

procedure TfrmPagamentoLoteTitulos.cxBarPesquisaCedenteCurChange(
  Sender: TObject);
begin
 dbgrdMain.DataSource.DataSet.Locate('FORNECEDOR',UpperCase(cxBarPesquisaCedente.CurEditValue),[loPartialKey]);
end;

procedure TfrmPagamentoLoteTitulos.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
 dbgrdMain.DataSource.DataSet.Locate('NUMERO_DOCUMENTO',UpperCase(cxbrdtmPesquisa.CurEditValue),[loPartialKey]);
end;

procedure TfrmPagamentoLoteTitulos.dbgrdMainDblClick(Sender: TObject);
begin
 dbgrdMain.Fields[0].Value := 'SIM';
 //PempecMsg.MsgInformation(' pagar o ' + (dbgrdMain.DataSource.DataSet as TFDQuery).FieldByName('NUMERO_DOCUMENTO').AsString);
end;

procedure TfrmPagamentoLoteTitulos.dbgrdMainTitleClick(Column: TColumn);
begin
 (dbgrdMain.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

procedure TfrmPagamentoLoteTitulos.dsTitulosDataChange(Sender: TObject;
  Field: TField);
begin
  pIdTP := (dbgrdMain.DataSource.DataSet as TFDQuery).FieldByName('ID').AsString;

  pTitulo := TTituloPagarModel.Create;
  pTitulo.FIDorganizacao := pIdOrganizacao;
  pTitulo.FID := pIdTP;

 msgStatusBar(3,' Título '+ (dbgrdMain.DataSource.DataSet as TFDQuery).FieldByName('NUMERO_DOCUMENTO').AsString + ' pronto para ser pago. ' );

end;


procedure TfrmPagamentoLoteTitulos.dtFinalChange(Sender: TObject);
var
  libera: Boolean;
begin
  libera := True;

  if dtFinal.EditValue < dtInicial.EditValue then begin
     libera := False;
     dtInicial.EditValue := StrToDate(FormatDateTime('dd/mm/yyyy', Now)); // IncYear(Now, -1);
     PempecMsg.MsgWarning('A data final não pode ser maior que ' + DateToStr(dtInicial.EditValue) );

 end;

  dxBtnConsulta.Enabled := libera;

end;

procedure TfrmPagamentoLoteTitulos.dtInicialChange(Sender: TObject);
var
libera :Boolean;
begin
 libera := True;

 if dtInicial.EditValue > Now then begin
     libera := False;
     dtInicial.EditValue := StrToDate(FormatDateTime('dd/mm/yyyy', Now)); // IncYear(Now, -1);
     PempecMsg.MsgWarning('A data de início não pode ser maior que hoje.');
 end;

 dtFinal.Enabled := libera; // depende da data de inicio

end;

procedure TfrmPagamentoLoteTitulos.dxBtnConsultaClick(Sender: TObject);
var
dataIni, dataFim :TDate;
teste : TFDQuery;
begin

   dataIni := StrToDate(FormatDateTime('dd/mm/yyyy', dtInicial.EditValue));
   dataFim := StrToDate(FormatDateTime('dd/mm/yyyy', dtFinal.EditValue));
   msgStatusBar(3,'Consulta sendo processada, por favor, aguarde...');

   preencheGrid(pIdOrganizacao, dataIni, dataFim);

  //dbgrdMain.DataSource.DataSet.Close;
 //(dbgrdMain.DataSource.DataSet as TFDQuery).FormatOptions.FmtDisplayNumeric := '###,##0.00';
 // dbgrdMain.DataSource.DataSet := TTituloPagarDAO.obterTodosPagarQry(dataIni, dataFim, pIdOrganizacao);
  dbgrdMain.Refresh;

  msgStatusBar(2, calcularValorDevido) ;
  msgStatusBar(3, IntToStr((dbgrdMain.DataSource.DataSet as TFDQuery).RecordCount)  + ' registros.' );



end;

procedure TfrmPagamentoLoteTitulos.dxBtnFecharClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmPagamentoLoteTitulos.dxBtnPagarAVClick(Sender: TObject);
begin
 PempecMsg.MsgInformation('Ainda não é possível pagar com acréscimos e deduções.');

end;



function TfrmPagamentoLoteTitulos.calcularValorDevido: string;
begin
 vlrDevido := 0;

 //(dbgrdMain.DataSource.DataSet as TFDQuery)

 (dbgrdMain.DataSource.DataSet as TFDQuery).First;
  while not (dbgrdMain.DataSource.DataSet as TFDQuery).Eof do
  begin
    vlrDevido := vlrDevido + (dbgrdMain.DataSource.DataSet as TFDQuery).FieldByName('VALOR_NOMINAL').AsCurrency;
    (dbgrdMain.DataSource.DataSet as TFDQuery).Next;
  end;


  Result := FormatCurr('R$ ,0.00', vlrDevido) ;


end;

procedure TfrmPagamentoLoteTitulos.createTable;
begin

   if not Assigned(fdmLoteTP) then begin
      fdmLoteTP := TFDMemTable.Create(Self);
   end;


    fdmLoteTP.FieldDefs.Add('ID_TITULO_PAGAR', ftString, 36, false);
    fdmLoteTP.FieldDefs.Add('ID_ORGANIZACAO', ftString, 36, false);
    fdmLoteTP.FieldDefs.Add('NUMERO_DOCUMENTO', ftString, 50, false);
    fdmLoteTP.FieldDefs.Add('VALOR_NOMINAL', ftCurrency, 0, false);
    fdmLoteTP.FieldDefs.Add('FORNECEDOR', ftString, 80, false);



    fdmLoteTP.CreateDataSet;


end;


procedure TfrmPagamentoLoteTitulos.dxBtnPagarClick(Sender: TObject);
var
I :Integer;
begin
  createTable;
 // dbgrdMain.Enabled := False;
 // dbgrdMain.DataSource.DataSet.Close;

 if dbgrdMain.SelectedRows.Count >0 then begin

    with dbgrdMain.DataSource.DataSet do
    begin
      for I := 0 to dbgrdMain.SelectedRows.Count - 1 do
      begin

        GotoBookmark(pointer(dbgrdMain.SelectedRows.Items[I]));
      //  ShowMessage((Fields[4].AsString));
        fdmLoteTP.Open;
        fdmLoteTP.InsertRecord([Fields[0].AsString, Fields[1].AsString, Fields[4].AsString,  Fields[5].AsCurrency,Fields[8].AsString]);

        //criar uma table virutal com os campos que irao aparecer no outro form para pagametno
         //campos na seguinte ordem :
          { TP.ID_TITULO_PAGAR  0;
           TP.ID_ORGANIZACAO,   1
           TP.NUMERO_DOCUMENTO   4
           TP.VALOR_NOMINAL      5
           C.FORNECEDOR      8
                     }
      end;
    end;

    try
      frmBaixaTPLoteFP  := TfrmBaixaTPLoteFP.Create(Self, fdmLoteTP);
      frmBaixaTPLoteFP.ShowModal;
      FreeAndNil(frmBaixaTPLoteFP);
      FreeAndNil(fdmLoteTP);

    except
      on e: Exception do
        ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + ' TfrmBaixaFP ');
    end;




  end;

  LimpaTela(Self);
  limpar;


end;

procedure TfrmPagamentoLoteTitulos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin


  Action := caFree;

end;

procedure TfrmPagamentoLoteTitulos.limpar;
begin

  dbgrdMain.Enabled := True;
  preencherGrid;
  limpaStatusBar;

  dtInicial.EditValue := StrToDate(FormatDateTime('dd/mm/yyyy', IncDay(Now, -7)));
  dtFinal.EditValue := StrToDate(FormatDateTime('dd/mm/yyyy', Now));
  dtFinal.Enabled := False;
//  dxBtnConsulta.Enabled := False; mudando em 31/03 pq qdo clica na datafinal nao tava liberando
//  msgStatusBar(3,'A consulta retornou ' + IntToStr((dbgrdMain.DataSource.DataSet as TFDQuery).RecordCount) + ' registros.' );
 vlrDevido := 0;

  ;

  msgStatusBar(2, calcularValorDevido) ;// currToStr(calcularValorDevido));
  msgStatusBar(3, IntToStr((dbgrdMain.DataSource.DataSet as TFDQuery).RecordCount)  + ' registros.' );



end;


procedure TfrmPagamentoLoteTitulos.FormCreate(Sender: TObject);
begin
  pIdOrganizacao := uUtil.TOrgAtual.getId;
  limpar;

end;

procedure TfrmPagamentoLoteTitulos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F10: dxBtnPagar.Click;
    VK_F12: dxBtnPagarAV.Click;

  end;
end;

procedure TfrmPagamentoLoteTitulos.preencherGrid;
 var
 dtI, dtF :TDateTime;
begin
   dtI := IncYear(Now, -5);
   dtF := EndOfTheMonth(Now);

  if preencheGrid(pIdOrganizacao, dtI, dtF)  then
  begin
   // (dbgrdMain.DataSource.DataSet as TFDQuery).Last;
   // (dbgrdMain.DataSource.DataSet as TFDQuery).First;
   msgStatusBar(3, 'Consultamos dados de ' + DateToStr(dtI) + ' até '+ DateToStr(dtF));
  end;


end;
procedure TfrmPagamentoLoteTitulos.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmPagamentoLoteTitulos.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F10] = Pagar [CTRL+P] Consulta ';
dxStatusBar.Panels[2].Text := ' Consulta ';
end;

procedure TfrmPagamentoLoteTitulos.LimpaTela(Form: TForm);
var
  i: Integer;
begin

  for i := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[i] is TCustomEdit then
    begin
      (Form.Components[i] as TCustomEdit).Clear;
    end;

    if Form.Components[i] is TLabel then
    begin
      TLabel(Form.Components[i]).Caption := '';
    end;

    if Form.Components[i] is TEdit then
    begin
      TEdit(Form.Components[i]).Clear;
    end;

   { if Form.Components[i] is TEvNumEdit then
    begin
      TEvNumEdit(Form.Components[i]).Clear ;
    end;  }

    if Form.Components[i] is TComboBox then
    begin
      TComboBox(Form.Components[i]).Clear ;
      TComboBox(Form.Components[i]).ItemIndex := 0;
    end;



   end;
end;


function TfrmPagamentoLoteTitulos.preencheGrid(pIdOrganizacao: string; pDataInicio, pDataFim :TDateTime) :Boolean;
var
sqlCmd :string;
begin

dmConexao.conectarBanco;
 try
    qryPreencheGrid.Close;
    qryPreencheGrid.Connection := dmConexao.conn;
    qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryPreencheGrid.ParamByName('DTDINICIAL').AsDate := pDataInicio;
    qryPreencheGrid.ParamByName('DTFINAL').AsDate := pDataFim;
    qryPreencheGrid.Open;

    qryPreencheGrid.Last;
    qryPreencheGrid.First;

 except
 raise Exception.Create('Erro ao obter lista de títulos...' );

 end;

 Result := not qryPreencheGrid.IsEmpty;

end;





end.
