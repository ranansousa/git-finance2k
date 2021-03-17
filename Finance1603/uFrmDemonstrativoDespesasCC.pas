unit uFrmDemonstrativoDespesasCC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, udmConexao,uUtil,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters, dxRibbonSkins, uCentroCustoDAO, uCentroCustoModel,
  dxRibbonCustomizationForm, cxClasses, dxRibbon, dxBar, EMsgDlg, dxStatusBar, uOrganizacaoDAO, uOrganizacaoModel,
  dxBarExtItems, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,uFrmEnviaMail,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  frxClass, frxDBSet, frxExportBaseDialog, frxExportPDF;

type
  TfrmDemonstrativoDespesasCC = class(TForm)
    dxStatusBar: TdxStatusBar;
    PempecMsg: TEvMsgDlg;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBarDataInicial: TdxBarDateCombo;
    dxBarDataFinal: TdxBarDateCombo;
    dxBarCbxCentroCusto: TdxBarCombo;
    qryCentroCusto: TFDQuery;
    dxBarBtnFechar: TdxBarLargeButton;
    dxBarManager1Bar3: TdxBar;
    dxBarBtnConsulta: TdxBarLargeButton;
    qryPreencheGrid: TFDQuery;
    dbGrid: TDBGrid;
    dtsGrid: TDataSource;
    panelTotal: TPanel;
    frxRelatorio: TfrxReport;
    frxDBDTitulos: TfrxDBDataset;
    dxBarManager1Bar4: TdxBar;
    dxBarBtnImprimir: TdxBarLargeButton;
    dxBarManager1Bar5: TdxBar;
    dxBarBtnEnviarEmail: TdxBarLargeButton;
    qryImprimeCC: TFDQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dxBarBtnFecharClick(Sender: TObject);
    procedure dxBarBtnConsultaClick(Sender: TObject);
    procedure dxBarBtnImprimirClick(Sender: TObject);
    procedure dxBarBtnEnviarEmailClick(Sender: TObject);
    procedure dxBarCbxCentroCustoChange(Sender: TObject);
    procedure dxBarDataInicialChange(Sender: TObject);
    procedure dxBarDataFinalChange(Sender: TObject);
    procedure dbGridTitleClick(Column: TColumn);
  private
    { Private declarations }

    FsListaIdCentrosCusto: TStringList;
    idOrganizacao: string;
    organizacaoModel : TOrganizacaoModel;
    sucesso : Boolean;
    pDataInicial, pDataFinal :TDate;

    function preencheGrid (pidOrganizacao, pIdCentroCusto :string; pDataInicial, pDataFinal :TDateTime) :Boolean;
    procedure atualizarValorDespesa;
    function validarFormulario : Boolean;
    procedure limpaPanel;
    procedure inicializarVariaveisRelatorio;
    function retornarCaminhoRelatorio: string;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    function obterDadosRelatorio(pidOrganizacao, pIdCentroCusto: string;
      pDataInicial, pDataFinal: TDateTime): Boolean;



  public
    { Public declarations }
  end;

var
  frmDemonstrativoDespesasCC: TfrmDemonstrativoDespesasCC;

implementation

{$R *.dfm}

procedure TfrmDemonstrativoDespesasCC.atualizarValorDespesa;
var
totalDespesa: Currency;
begin
totalDespesa := 0;


 if qryPreencheGrid.RecordCount >0 then begin
    qryPreencheGrid.First;

    while not qryPreencheGrid.Eof do begin

      totalDespesa := totalDespesa + qryPreencheGrid.FieldByName('VALOR_RATEIO').AsCurrency;

      qryPreencheGrid.Next;


    end;



 end;

  panelTotal.Caption := 'Total das despesas    ' + uutil.TFormat.formatCurToReal(totalDespesa);

end;

procedure TfrmDemonstrativoDespesasCC.dbGridTitleClick(Column: TColumn);
begin
   (dbGrid.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

procedure TfrmDemonstrativoDespesasCC.dxBarBtnConsultaClick(Sender: TObject);
var
idCentroCusto :string;
begin
idCentroCusto := '';

  if dxBarCbxCentroCusto.ItemIndex >0  then begin

     idCentroCusto := FsListaIdCentrosCusto[dxBarCbxCentroCusto.ItemIndex];

  end;

  if preencheGrid(idOrganizacao, idCentroCusto, dxBarDataInicial.Date, dxBarDataFinal.Date) then
  begin

    atualizarValorDespesa;
    dxBarBtnConsulta.Enabled := False;
    dxBarBtnImprimir.Enabled := True;
    dxBarBtnEnviarEmail.Enabled := True;

  end;

end;

procedure TfrmDemonstrativoDespesasCC.dxBarBtnEnviarEmailClick(Sender: TObject);
var
localFile, assunto, arquivo :string;
//frxPDFExport : TfrxPDFExport;
begin

  pDataInicial := dxBarDataInicial.Date;
  pDataFinal := dxBarDataFinal.Date;


  if (qryPreencheGrid.RecordCount > 0) then
  begin


  if validarFormulario then
  begin

    frxRelatorio.Clear;
    if not (frxRelatorio.LoadFromFile(retornarCaminhoRelatorio)) then
    begin
      PempecMsg.MsgError('N�o foi poss�vel imprimir. Informe ao suporte : FALTA FR3 ');
    end
    else
    begin

      //enviar por PDF
      arquivo := 'REL_DESPESAS_C_C_' + FormatDateTime('dd.MM.yyyy_hh.mm.ss', now)  + '.PDF';
      localFile := GetCurrentDir + '\rel\tp\'; //informa a pasta onde o arquivo ser� gravado
      dmConexao.frxPDFExport := TfrxPDFexport.Create(Self);

      dmConexao.frxPDFExport.FileName := arquivo;
      dmconexao.frxPDFExport.DefaultPath := localFile;
      dmconexao.frxPDFExport.ShowDialog := False;
      dmconexao.frxPDFExport.ShowProgress := False;
      dmconexao.frxPDFExport.OverwritePrompt := True;


      inicializarVariaveisRelatorio;

      frxRelatorio.OldStyleProgress := True;
      frxRelatorio.ShowProgress := True;
      frxRelatorio.PrepareReport(True);

      frxRelatorio.Export(dmconexao.frxPDFExport);

      if Assigned(dmConexao.frxPDFExport) then
      begin
        dmConexao.frxPDFExport.Free;
      end;


      assunto := arquivo;
      arquivo := localFile + arquivo;

     frmEnviaMail := TfrmEnviaMail.Create(Self, arquivo, assunto);
     frmEnviaMail.ShowModal;
     FreeAndNil(frmEnviaMail);

    end;

  end;


  end;

  msgStatusBar(1, 'Relat�rio sendo impresso.');


end;

procedure TfrmDemonstrativoDespesasCC.dxBarBtnFecharClick(Sender: TObject);
begin
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;


function TfrmDemonstrativoDespesasCC.retornarCaminhoRelatorio: string;
begin
 Result := uUtil.TPathRelatorio.getRelatorioDespesasCC;
end;

procedure TfrmDemonstrativoDespesasCC.dxBarBtnImprimirClick(Sender: TObject);
var
idCentroCusto :string;
sucesso : Boolean;

begin
idCentroCusto := '';
sucesso :=False;

  if dxBarCbxCentroCusto.ItemIndex >0  then begin

     idCentroCusto := FsListaIdCentrosCusto[dxBarCbxCentroCusto.ItemIndex];

  end;

  if  obterDadosRelatorio(idOrganizacao, idCentroCusto, dxBarDataInicial.Date, dxBarDataFinal.Date) then
  begin
     sucesso :=True;

  end;
  if sucesso then
  begin

    if (validarFormulario) then
    begin

      frxRelatorio.Clear;
      if not (frxRelatorio.LoadFromFile(retornarCaminhoRelatorio)) then
      begin
        PempecMsg.MsgError('N�o foi poss�vel imprimir. Informe ao suporte : FALTA FR3 ');
      end
      else
      begin
        inicializarVariaveisRelatorio;
        frxRelatorio.OldStyleProgress := True;
        frxRelatorio.ShowProgress := True;
        frxRelatorio.ShowReport;

      end;
    end;
  end
  else
  begin

    PempecMsg.MsgInformation('N�o existem dados a serem impressos ');

  end;

end;



procedure TfrmDemonstrativoDespesasCC.dxBarCbxCentroCustoChange(
  Sender: TObject);
begin
 if dxBarCbxCentroCusto.ItemIndex >0  then
    dxBarBtnConsulta.Enabled := True;

end;

procedure TfrmDemonstrativoDespesasCC.dxBarDataFinalChange(Sender: TObject);
begin
  if dxBarCbxCentroCusto.ItemIndex >0  then begin dxBarBtnConsulta.Enabled := True; end;
end;

procedure TfrmDemonstrativoDespesasCC.dxBarDataInicialChange(Sender: TObject);
begin
 if dxBarCbxCentroCusto.ItemIndex >0  then begin dxBarBtnConsulta.Enabled := True; end;
 
end;

procedure TfrmDemonstrativoDespesasCC.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;

end;



procedure TfrmDemonstrativoDespesasCC.FormCreate(Sender: TObject);
begin
 sucesso := False;
 idOrganizacao := uutil.TOrgAtual.getId;
 organizacaoModel := TOrganizacaoModel.Create;
 organizacaoModel.FID := idOrganizacao;
 organizacaoModel := TOrganizacaoDAO.obterPorID(organizacaoModel);
  if not uUtil.Empty(organizacaoModel.FID) then
  begin
    // organizacaoModel.Fvinculada := True;
    sucesso := organizacaoModel.Fvinculada;

  end;

 limpaPanel;
end;

procedure TfrmDemonstrativoDespesasCC.limpaPanel;
begin

  dxBarDataFinal.Date := Now;
  dxBarDataInicial.Date := Now;

  TCentroCustoDAO.comboGenerico(dxBarCbxCentroCusto, FsListaIdCentrosCusto);
  dxBarCbxCentroCusto.ItemIndex := 0;
  dxBarBtnConsulta.Enabled := False;
  dxBarBtnImprimir.Enabled := False;
  dxBarBtnEnviarEmail.Enabled := False;

end;

function TfrmDemonstrativoDespesasCC.preencheGrid(pidOrganizacao,
  pIdCentroCusto: string; pDataInicial, pDataFinal: TDateTime): Boolean;
begin
  pDataFinal := StrToDate(FormatDateTime('dd/MM/yyyy', pDataFinal));
  pDataInicial := StrToDate(FormatDateTime('dd/MM/yyyy', pDataInicial));

  qryPreencheGrid.Close;
  qryPreencheGrid.Connection := dmConexao.conn;
  qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pidOrganizacao;
  qryPreencheGrid.ParamByName('PID').AsString := pIdCentroCusto;
  qryPreencheGrid.ParamByName('DTINICIAL').AsDateTime := pDataInicial;
  qryPreencheGrid.ParamByName('DTFINAL').AsDateTime := pDataFinal;
  qryPreencheGrid.Open ;



  Result := not qryPreencheGrid.IsEmpty;

end;


function TfrmDemonstrativoDespesasCC.obterDadosRelatorio(pidOrganizacao,
  pIdCentroCusto: string; pDataInicial, pDataFinal: TDateTime): Boolean;
begin
  pDataFinal := StrToDate(FormatDateTime('dd/MM/yyyy', pDataFinal));
  pDataInicial := StrToDate(FormatDateTime('dd/MM/yyyy', pDataInicial));

  qryImprimeCC.Close;
  qryImprimeCC.Connection := dmConexao.conn;
  qryImprimeCC.ParamByName('PIDORGANIZACAO').AsString := pidOrganizacao;
  qryImprimeCC.ParamByName('PID').AsString := pIdCentroCusto;
  qryImprimeCC.ParamByName('DTINICIAL').AsDateTime := pDataInicial;
  qryImprimeCC.ParamByName('DTFINAL').AsDateTime := pDataFinal;
  qryImprimeCC.Open ;



  Result := not qryImprimeCC.IsEmpty;

end;



function TfrmDemonstrativoDespesasCC.validarFormulario: Boolean;
begin


Result := System.True;

end;

procedure TfrmDemonstrativoDespesasCC.inicializarVariaveisRelatorio;
begin

  if (organizacaoModel.Fvinculada) then
  begin
    sucesso := True;
  end
  else
  begin
    sucesso := False;
    organizacaoModel.FID := uutil.TOrgAtual.getId;
    organizacaoModel := TOrganizacaoDAO.obterPorID(organizacaoModel);
    sucesso := organizacaoModel.Fvinculada;

  end;

  if sucesso then
  begin


     with frxRelatorio.Variables do
    begin
      Variables['strRazaoSocial'] := QuotedStr(organizacaoModel.FRazaoSocial);
      Variables['strCNPJ'] := QuotedStr(organizacaoModel.FCNPJ);
      Variables['strEndereco'] := QuotedStr(organizacaoModel.FLOGRADOURO +' '+ organizacaoModel.FCOMPLEMENTO + ' ' + organizacaoModel.FBairro.Fbairro);
      Variables['strCEP'] := QuotedStr(organizacaoModel.FCEP);
      Variables['strCidade'] := QuotedStr(organizacaoModel.FCidade.Fcidade);
      Variables['strUF'] := QuotedStr(organizacaoModel.FIDESTADO);
      Variables['strTipoStatus'] := QuotedStr(dxBarCbxCentroCusto.Items[dxBarCbxCentroCusto.ItemIndex]);
      Variables['strPeriodo'] :=QuotedStr( ' De  ' + DateToStr(dxBarDataInicial.Date) + '  at�  ' + DateToStr(dxBarDataFinal.Date));

    end;




  end;
end;

procedure TfrmDemonstrativoDespesasCC.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;



end.
