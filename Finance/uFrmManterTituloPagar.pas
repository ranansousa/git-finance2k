unit uFrmManterTituloPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.DateUtils, System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, udmConexao, uOrganizacaoModel, uDMOrganizacao,uUtil,
  uTituloPagarModel, uTituloPagarDAO, uContaContabilModel, uContaContabilDAO,
  uLoteContabilModel, uLoteContabilDAO, uLotePagamentoModel, uLotePagamentoDAO,uCentroCustoModel, uCentroCustoDAO,
    dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxControls, uCedenteModel,uCedenteDAO,  cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins, uTipoStatusModel, uTipoStatusDAO,  dxRibbonCustomizationForm, dxBarBuiltInMenu, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, dxBar, cxClasses, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, uFrameTipoCobranca,
  uFrameCentroCusto, ENumEd, Vcl.ComCtrls, Vcl.Buttons, uFrameResponsavel,
  uFrameGeneric, uFrameHistorico, uFrameCedente, uFrameLocalPagamento, uFrameTP,
  cxPC, dxStatusBar, dxRibbon,  uContaBancariaDBModel, uContaBancariaDebitoDAO,
  uHistoricoModel, uHistoricoDAO, uFuncionarioModel, uFuncionarioDAO,
 uTituloPagarHistoricoDAO, uFrmEspelhoTP,uFrmBaixaFP, uFrmReciboTP,
 uTituloPagarHistoricoModel, uTituloPagarCentroCustoModel, uTituloPagarCentroCustoDAO, uNotaFiscalEntradaModel, uNotaFiscalEntradaDAO,
 uFrmTituloPagarParcelado, uFrameTipoNotaFiscal,  uContaBancariaChequeModel, uContaBancariaChequeDAO, uTesourariaDBModel, uTesourariaDBDAO,
 uTPBaixaModel, uTPBaixaChequeModel, uTPBaixaFPModel, uTPBaixaACModel, uTPBaixaDEModel, uTPBaixaInternetModel,
 uTPBaixaDAO, uTPBaixaChequeDAO, uTPBaixaFPDAO, uTPBaixaACDAO, uTPBaixaDEDAO, uTPBaixaInternetDAO,
  EMsgDlg;

type
  TfrmManterTituloPagar = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar3: TdxBar;
    dxBarManager1Bar4: TdxBar;
    dxBarManager1Bar6: TdxBar;
    dxBarManager1Bar7: TdxBar;
    dxBarBtnSair: TdxBarLargeButton;
    dxBtnLimpar: TdxBarLargeButton;
    dxStatusBar: TdxStatusBar;
    dxBtnProvisao: TdxBarLargeButton;
    dxBtnEdit: TdxBarLargeButton;
    dxBtnSave: TdxBarLargeButton;
    dxBtnDelet: TdxBarLargeButton;
    dxBarLargeButton5: TdxBarLargeButton;
    pgTitulo: TcxPageControl;
    tbBasica: TcxTabSheet;
    tbComplemento: TcxTabSheet;
    tbNotaFiscal: TcxTabSheet;
    tbRateioHistoricos: TcxTabSheet;
    tbRateioCentroCusto: TcxTabSheet;
    Label1: TLabel;
    frameTP1: TframeTP;
    frmLocalPagto1: TfrmLocalPagto;
    frameCedente1: TframeCedente;
    frameHistorico1: TframeHistorico;
    frameResponsavel1: TframeResponsavel;
    edtLotePagamento: TEdit;
    edtLoteContabil: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    BtnGerarDOC: TBitBtn;
    Label4: TLabel;
    edtCEDConta: TEdit;
    edtCEDReduz: TEdit;
    lblResponsavel: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtHISTConta: TEdit;
    edtHISTReduz: TEdit;
    edtCodigoHist: TEdit;
    Label7: TLabel;
    edtValorMainTP: TEvNumEdit;
    edtDescricao: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    dtPagamento: TDateTimePicker;
    dtProtocolo: TDateTimePicker;
    dtEmissao: TDateTimePicker;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtParcela: TEdit;
    Label13: TLabel;
    edtStatus: TEdit;
    Label14: TLabel;
    edtValorAntecipado: TEvNumEdit;
    Label15: TLabel;
    dxBarManager1Bar5: TdxBar;
    dxBtnPagar: TdxBarLargeButton;
    dxBarManager1Bar8: TdxBar;
    dxBarManager1Bar9: TdxBar;
    dxBtnRecibo: TdxBarLargeButton;
    dxBtnEspelho: TdxBarLargeButton;
    gridRateioHist: TDBGrid;
    dbgridHistorico: TDBGrid;
    dsHistorico: TDataSource;
    qryPreencheGridHistorico: TFDQuery;
    frameHistorico2: TframeHistorico;
    fdmHistorico: TFDMemTable;
    dsFdmHistorico: TDataSource;
    btnLimparRateioHist: TButton;
    btnSelectTHST: TButton;
    edtValorRateioHist: TEvNumEdit;
    EdtTotalRateioHist: TEvNumEdit;
    Label16: TLabel;
    edtValorTP: TEvNumEdit;
    Label17: TLabel;
    edtDifHistorico: TEvNumEdit;
    Label18: TLabel;
    frameCentroCusto2: TframeCentroCusto;
    edtValorRateioCC: TEvNumEdit;
    btnSelectTCC: TButton;
    gridRateioCC: TDBGrid;
    dbgridCC: TDBGrid;
    dsCentroCusto: TDataSource;
    fdmCentroCusto: TFDMemTable;
    qryPreencheGridCentroC: TFDQuery;
    Label19: TLabel;
    edtValorTPCC: TEvNumEdit;
    Label20: TLabel;
    edtTotalRateioCC: TEvNumEdit;
    Label21: TLabel;
    edtDifRateioCC: TEvNumEdit;
    btnLimparRateioCC: TButton;
    dsFdmCC: TDataSource;
    Label22: TLabel;
    dtPrevisaoCartorio: TDateTimePicker;
    Label23: TLabel;
    edtUltimoUpdate: TEdit;
    edtCodigoBarras: TEdit;
    Label24: TLabel;
    edtCarteira: TEdit;
    edtContrato: TEdit;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtObervacao: TEdit;
    frmTipoNF1: TfrmTipoNF;
    edtValorNF: TEvNumEdit;
    edtValorISS: TEvNumEdit;
    edtBaseCalculo: TEvNumEdit;
    dtNFEmissao: TDateTimePicker;
    dtNFProtocolo: TDateTimePicker;
    dtNFRetencaoISS: TDateTimePicker;
    edtNFObservacao: TEdit;
    edtNFNumero: TEdit;
    edtNFDescricao: TEdit;
    edtNFAliquotaISS: TEdit;
    edtNFSerie: TEdit;
    edtNFSubSerie: TEdit;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    frameCentroCusto1: TframeCentroCusto;
    frmTipoCobranca1: TfrmTipoCobranca;
    edtProvisao: TEdit;
    Label41: TLabel;
    dxBarManager1Bar10: TdxBar;
    dxBtnCancelBaixaTP: TdxBarLargeButton;
    PempecMsg: TEvMsgDlg;
    procedure dxBarBtnSairClick(Sender: TObject);
    procedure dxBtnLimparClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frameTP1cbbTPExit(Sender: TObject);
    procedure frameCedente1cbbcomboChange(Sender: TObject);
    procedure frameHistorico1cbbcomboChange(Sender: TObject);
    procedure BtnGerarDOCClick(Sender: TObject);
    procedure frameTP1cbbTPChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxBtnProvisaoClick(Sender: TObject);
    procedure frameResponsavel1cbbcomboChange(Sender: TObject);
    procedure dxBtnEspelhoClick(Sender: TObject);
    procedure dxBtnPagarClick(Sender: TObject);
    procedure dxBtnReciboClick(Sender: TObject);
    procedure btnLimparRateioHistClick(Sender: TObject);
    procedure btnSelectTHSTClick(Sender: TObject);
    procedure tbRateioHistoricosShow(Sender: TObject);
    procedure edtValorRateioHistChange(Sender: TObject);
    procedure edtValorMainTPChange(Sender: TObject);
    procedure frameHistorico2cbbcomboChange(Sender: TObject);
    procedure btnSelectTCCClick(Sender: TObject);
    procedure tbRateioCentroCustoShow(Sender: TObject);
    procedure btnLimparRateioCCClick(Sender: TObject);
    procedure edtValorRateioCCChange(Sender: TObject);
    procedure dtPagamentoChange(Sender: TObject);
    procedure edtCarteiraChange(Sender: TObject);
    procedure tbComplementoExit(Sender: TObject);
    procedure frmTipoNF1cbbTipoNFChange(Sender: TObject);
    procedure tbNotaFiscalExit(Sender: TObject);
    procedure dxBtnSaveClick(Sender: TObject);
    procedure dxBtnDeletClick(Sender: TObject);
    procedure dxBtnEditClick(Sender: TObject);
    procedure tbNotaFiscalShow(Sender: TObject);
    procedure frameCentroCusto1cbbcomboChange(Sender: TObject);
    procedure dxBtnCancelBaixaTPClick(Sender: TObject);
  private
    { Private declarations }
   pIDNotaFiscal, pIDTipoNotaFiscal, pIDorganizacao :string;
   msg,  pIDusuario :string;
    FRateioHistorico: TObjectList<TTituloPagarHistoricoModel>;
    FRateioCustos: TObjectList<TTituloPagarCentroCustoModel>;

    tituloPagarModel  : TTituloPagarModel;
    cedenteModel      : TCedenteModel;
    historicoModel    : THistoricoModel;
    centroCustoModel  : TCentroCustoModel;
    responsavelModel  : TFuncionarioModel;
    statusModel       : TTipoStatusModel;
    modo :Integer;

    FSlistaTipoCobranca,    FSlistaIdContaContabil, FSlistaResponsavel, FSlistaLocalPagamento : TStringList;
    FSlistaCentroCusto, FSlistaTipoNF, FSlistaHistorico, FSlistaTitulos, FSlistaCedente  : TStringList;


    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    procedure carregarCombos(titulo :TTituloPagarModel) ;
    function obterLoteContabil (value :TLoteContabilModel) : TLoteContabilModel;
    function obterLotePagamento (value :TLotePagamentoModel) : TLotePagamentoModel;
    function obterIndiceLista(pId :string; lista :TStringList) : Integer;
    procedure popularCedente(cedente :TCedenteModel);
    procedure popularHistorico(historico: THistoricoModel);
    procedure popularCentroCusto(centroCusto: TCentroCustoModel);
    procedure popularResponsavel(responsavel: TFuncionarioModel);
    procedure popularStatus(status: TTipoStatusModel);
    procedure preencheGridHistorico;
    procedure preencheGridCedntroC;

    procedure createTable;
    function obterValorRateioHistorico: Currency;
    procedure limpaRateioHistorico;
    function atualizarRateio(pTipo: string): Currency;
    procedure preencheAbaRateioHistorico(      listaH: TObjectList<TTituloPagarHistoricoModel>);
    procedure preencheAbaBasica(titulo: TTituloPagarModel);
    procedure preencheAbaRateioCC(listaCC: TObjectList<TTituloPagarCentroCustoModel>);
    function obterValorRateioCC: Currency;
    procedure limpaRateioCC;
    procedure StatusBotoes(value: Integer);
    procedure preencheDatas(titulo: TTituloPagarModel);
    procedure preencheAbaComplementar(titulo: TTituloPagarModel);
    procedure preencheAbaNotaFiscal(nota: TNotaFiscalEntradaModel);
    function createTitulo : Boolean;
    procedure bloqueiaCampos(Form: TForm; status: Boolean);
    function validarForm(Form :TForm) : Boolean;
    function calcularISS(pValue, pAliquota: Currency): Currency;
    procedure atualizarTitulo;
    function salvarTitulo(titulo: TTituloPagarModel): Boolean;
    procedure limpaAbaNF;
    procedure ajustaComboForm;
    procedure retiraOrdemCampo(Form: TForm);

  public
    { Public declarations }
  end;

var
  frmManterTituloPagar : TfrmManterTituloPagar;

  implementation

{$R *.dfm}

procedure TfrmManterTituloPagar.BtnGerarDOCClick(Sender: TObject);
var
nDOC:string;
dtVenctoCartaoCredito : TDateTime;
begin



 if modo = 1 then begin

   StatusBotoes(0);

    nDOC := dmConexao.obterIdentificador('',pIDorganizacao, 'TP');

    tituloPagarModel := TTituloPagarModel.Create;
    tituloPagarModel.Fnovo := True;
    tituloPagarModel.FIDorganizacao := pIDorganizacao;
    tituloPagarModel.FID := dmConexao.obterNewID;
    tituloPagarModel.FnumeroDocumento := nDOC;
    tituloPagarModel.FIDTipoStatus := 'ABERTO';
    tituloPagarModel.listaHistorico := TObjectList<TTituloPagarHistoricoModel>.Create;
    tituloPagarModel.listaCustos := TObjectList<TTituloPagarCentroCustoModel>.Create;
    tituloPagarModel.listaHistorico.Clear;
    tituloPagarModel.listaCustos.Clear;
    tituloPagarModel.Fparcela := '1';
    tituloPagarModel.FdataRegistro           := Now;
    tituloPagarModel.FdataUltimaAtualizacao  := Now;

    frameTP1.cbbTP.Items.Add(nDOC);
    FSlistaTitulos.Add(tituloPagarModel.FID);
    frameTP1.cbbTP.ItemIndex := obterIndiceLista(tituloPagarModel.FID, FSlistaTitulos);

    edtStatus.Text                              := tituloPagarModel.FIDTipoStatus;
    edtParcela.Text                             := tituloPagarModel.Fparcela;
    edtDescricao.Text                           := 'PG REF: ' ;
    edtUltimoUpdate.Text                        := DateToStr(now);
    frmTipoCobranca1.cbbTipoCobranca.ItemIndex  := 1;
    frmLocalPagto1.cbbcombo.ItemIndex      := FSlistaLocalPagamento.Count -1;

   dxBtnPagar.Enabled :=True;

 end;


end;

procedure TfrmManterTituloPagar.btnLimparRateioCCClick(Sender: TObject);
begin
 limpaRateioCC;
 frameCentroCusto2.cbbcombo.ItemIndex := frameCentroCusto1.cbbcombo.ItemIndex;
 edtValorRateioCC.Enabled := True;
 edtValorRateioCC.SetFocus;
  //obs lembrar de setar o CC  principal novamente.

  atualizarRateio('C');
end;

procedure TfrmManterTituloPagar.btnLimparRateioHistClick(Sender: TObject);
begin

  limpaRateioHistorico;
  frameHistorico2.cbbcombo.ItemIndex           := 0;
  gridRateioHist.Refresh;
  edtValorRateioHist.Clear;

   frameHistorico2.cbbcombo.ItemIndex := frameHistorico1.cbbcombo.ItemIndex;
   edtValorRateioHist.Enabled := True;
   edtValorRateioHist.SetFocus;


  //obs lembrar de setar o historico principal novamente.

  atualizarRateio('H');
end;


procedure TfrmManterTituloPagar.limpaRateioHistorico;
begin
  fdmHistorico.Open;
  fdmHistorico.First;
  while not fdmHistorico.Eof do
  begin
    fdmHistorico.Delete;
    fdmHistorico.Next;
  end;
    gridRateioHist.DataSource.DataSet.Close;
    gridRateioHist.Refresh;

   if Assigned(tituloPagarModel.listaHistorico) then begin
     tituloPagarModel.listaHistorico.Clear;
   end;

   frameHistorico2.cbbcombo.ItemIndex :=0;
   edtValorRateioHist.Clear;
   atualizarRateio('H');

    //obs lembrar de setar o historico principal novamente.
end;

procedure TfrmManterTituloPagar.limpaRateioCC;
begin
  fdmCentroCusto.Open;
  fdmCentroCusto.First;
  while not fdmCentroCusto.Eof do
  begin
    fdmCentroCusto.Delete;
    fdmCentroCusto.Next;
  end;
    gridRateioCC.DataSource.DataSet.Close;
    gridRateioCC.Refresh;


 {  if Assigned(tituloPagarModel.listaHistorico) then begin
     tituloPagarModel.listaHistorico.Clear;
   end;  }

   frameCentroCusto2.cbbcombo.ItemIndex :=0;
   edtValorRateioCC.Clear;
   atualizarRateio('C');

    //obs lembrar de setar o CC principal novamente.
end;



procedure TfrmManterTituloPagar.ajustaComboForm;
begin
frameTP1.cbbTP.Left := 11;
frameTP1.cbbTP.Top  := 11;



end;

function TfrmManterTituloPagar.atualizarRateio(pTipo :string) : Currency;
var
totalRateio : Currency;
begin
  totalRateio:=0;
  if pTipo.Equals('H') then
  begin //atualiza saldo do rateio historico
    totalRateio := obterValorRateioHistorico;
    EdtTotalRateioHist.Value := totalRateio  ;
    edtDifHistorico.Value := edtValorMainTP.Value - totalRateio; //total do titulo menos o total do rateio

  end;

  totalRateio:=0;
  if pTipo.Equals('C') then
  begin //atualiza saldo do rateio CC
    totalRateio := obterValorRateioCC;
    edtTotalRateioCC.Value := totalRateio  ;
    edtDifRateioCC.Value := edtValorMainTP.Value - totalRateio; //total do titulo menos o total do rateio

  end;


end;

function TfrmManterTituloPagar.obterValorRateioCC: Currency;
var
total :Currency;
  I: Integer;
begin
 total :=0;
 fdmCentroCusto.Open;
 fdmCentroCusto.First;
 while not fdmCentroCusto.Eof do begin

 total := total + fdmCentroCusto.FieldByName('VALOR').AsCurrency;

 fdmCentroCusto.Next;
 end;


  Result := total;

end;


function TfrmManterTituloPagar.obterValorRateioHistorico: Currency;
var
total :Currency;
  I: Integer;
begin
 total :=0;
 fdmHistorico.Open;
 fdmHistorico.First;
 while not fdmHistorico.Eof do begin

 total := total + fdmHistorico.FieldByName('VALOR').AsCurrency;

 fdmHistorico.Next;
 end;


  Result := total;

end;


procedure TfrmManterTituloPagar.createTable;
begin

    fdmHistorico.FieldDefs.Add('DESCRICAO', ftString, 60, false);
    fdmHistorico.FieldDefs.Add('VALOR', ftCurrency, 0, false);
    fdmHistorico.FieldDefs.Add('ID_HISTORICO', ftString, 36, false);
    fdmHistorico.CreateDataSet;

    fdmCentroCusto.FieldDefs.Add('DESCRICAO', ftString, 60, false);
    fdmCentroCusto.FieldDefs.Add('VALOR', ftCurrency, 0, false);
    fdmCentroCusto.FieldDefs.Add('ID_CENTRO_CUSTO', ftString, 36, false);
    fdmCentroCusto.CreateDataSet;


end;


procedure TfrmManterTituloPagar.btnSelectTCCClick(Sender: TObject);
var
  rateioCC: TTituloPagarCentroCustoModel;
  ccValidado: Boolean;
begin
  //botao seleciona novo centro de custo
  //cria novo rateio

  rateioCC := TTituloPagarCentroCustoModel.Create;
  ccValidado := False;

  centroCustoModel := TCentroCustoModel.Create;
  centroCustoModel.FIDorganizacao := pIDorganizacao;
  centroCustoModel.FID := FSlistaCentroCusto[frameCentroCusto2.cbbcombo.ItemIndex];
  centroCustoModel := TCentroCustoDAO.obterPorID(centroCustoModel);

  if uUtil.Empty(centroCustoModel.FID) then
  begin
    PempecMsg.MsgInformation('O centro de custo n�o pode ser utilizado. Poss�vel problema com a consulta . ');
    frameCentroCusto2.cbbcombo.ItemIndex := 0;
  end
  else
  begin
    ccValidado := True;
  end;

  if ccValidado then
  begin
    rateioCC.FIDorganizacao := pIDorganizacao;
    rateioCC.FID := dmConexao.obterNewID;
    rateioCC.FIDCentroCusto := centroCustoModel.FID;
    rateioCC.FIDTP := tituloPagarModel.FID;
    rateioCC.Fvalor := edtValorRateioCC.Value;
    rateioCC.FCentroCusto := centroCustoModel;

    tituloPagarModel.AdicionarCC(rateioCC);
    fdmCentroCusto.Open;
    fdmCentroCusto.InsertRecord([centroCustoModel.FDescricao, edtValorRateioCC.Value]);
    edtTotalRateioCC.Value := obterValorRateioCC;

    frameCentroCusto2.cbbcombo.ItemIndex := 0;
    edtValorRateioCC.Value := 0;
    btnSelectTCC.Enabled := False;

  end;

  atualizarRateio('C');
end;

procedure TfrmManterTituloPagar.btnSelectTHSTClick(Sender: TObject);
 var
 rateioHistorico  : TTituloPagarHistoricoModel;
 hstValidado : Boolean;

begin
  rateioHistorico := TTituloPagarHistoricoModel.Create;
  hstValidado := False;

  if edtValorRateioHist.Value > 0 then
  begin

      historicoModel                := THistoricoModel.Create;
      historicoModel.FID            := FSlistaHistorico[frameHistorico2.cbbcombo.ItemIndex];
      historicoModel.FIDorganizacao := pIDorganizacao;
      historicoModel := THistoricoDAO.obterPorID(historicoModel);

    if uutil.Empty(historicoModel.FIdContaContabil) then
    begin
      PempecMsg.MsgInformation('O hist�rico n�o pode ser utilizado. Poss�vel problema no campo conta cont�bil. ');
      frameHistorico2.cbbcombo.ItemIndex := 0;

    end
    else
    begin
      hstValidado := True;
    end;

      rateioHistorico.FID                     := dmConexao.obterNewID;
      rateioHistorico.FIDorganizacao          := pIDorganizacao;
      rateioHistorico.FIDHistorico            := historicoModel.FID;
      rateioHistorico.FIDContaContabilDebito  := historicoModel.FIdContaContabil;
      rateioHistorico.FIDTP                   := tituloPagarModel.FID;
      rateioHistorico.Fvalor                  := edtValorRateioHist.Value;

      if hstValidado then begin

      tituloPagarModel.AdicionarHST(rateioHistorico);

      fdmHistorico.Open;
      fdmHistorico.InsertRecord([historicoModel.FDescricao, edtValorRateioHist.Value]);
      EdtTotalRateioHist.Value := obterValorRateioHistorico;

      frameHistorico2.cbbcombo.ItemIndex := 0;
      edtValorRateioHist.Value := 0;
      btnSelectTHST.Enabled := False;
      end;

  end;

  atualizarRateio('H');

end;

procedure TfrmManterTituloPagar.carregarCombos (titulo :TTituloPagarModel) ;
var
pDataFinal, pDataInicial :TDateTime;

begin

   ajustaComboForm;

    if uutil.Empty(titulo.FID) then begin

                  pDataInicial  :=  StrToDate('01'  + '/'+ FormatDateTime('mm',Now) + '/' + FormatDateTime('YYYY',Now)) ;
                  pDataFinal    :=  EndOfTheMonth(pDataInicial);


  //    frameTP1.obterTodos(pIDorganizacao, frameTP1.cbbTP, FSlistaTitulos);
      frameTP1.obterTodosPorPeriodo(pIDorganizacao, pDataInicial,pDataFinal, frameTP1.cbbTP, FSlistaTitulos);


      frameCedente1.obterTodos(pIDorganizacao, frameCedente1.cbbcombo, FSlistaCedente);
      frameHistorico1.obterTodosPorTipo (pIDorganizacao,'P', frameHistorico1.cbbcombo, FSlistaHistorico);
      frameCentroCusto1.obterTodos(pIDorganizacao, frameCentroCusto1.cbbcombo, FSlistaCentroCusto);

      frameResponsavel1.obterTodosAtivos(pIDorganizacao, frameResponsavel1.cbbcombo, FSlistaResponsavel);

      frmTipoCobranca1.obterTodos(pIDorganizacao, frmTipoCobranca1.cbbTipoCobranca, FSlistaTipoCobranca);
      frmLocalPagto1.obterTodos(pIDorganizacao, frmLocalPagto1.cbbcombo, FSlistaLocalPagamento);
      frameHistorico2.obterTodosPorTipo (pIDorganizacao,'P', frameHistorico2.cbbcombo, FSlistaHistorico);
      frameCentroCusto2.obterTodos(pIDorganizacao, frameCentroCusto2.cbbcombo, FSlistaCentroCusto);
      frmTipoNF1.obterTodos(pIDorganizacao, frmTipoNF1.cbbTipoNF, FSlistaTipoNF);



       frameCedente1.cbbcombo.ItemIndex             := 0;
       frameHistorico1.cbbcombo.ItemIndex           := 0;
       frameHistorico2.cbbcombo.ItemIndex           := 0;
       frameCentroCusto1.cbbcombo.ItemIndex   := 0;
       frameCentroCusto2.cbbcombo.ItemIndex   := 0;
       frameResponsavel1.cbbcombo.ItemIndex         := 0;
       frmTipoCobranca1.cbbTipoCobranca.ItemIndex   := 0;
       frmLocalPagto1.cbbcombo.ItemIndex       := 0;
       frmTipoNF1.cbbTipoNF.ItemIndex               := 0;



    end else begin


       frameCedente1.cbbcombo.ItemIndex             := obterIndiceLista(titulo.FIDCedente, FSlistaCedente);
       frameHistorico1.cbbcombo.ItemIndex           := obterIndiceLista(titulo.FIDHistorico,FSlistaHistorico);
       frameHistorico2.cbbcombo.ItemIndex           := obterIndiceLista(titulo.FIDHistorico,FSlistaHistorico);
       frameCentroCusto1.cbbcombo.ItemIndex         := obterIndiceLista(titulo.FIDCentroCusto, FSlistaCentroCusto);
       frameCentroCusto2.cbbcombo.ItemIndex         := obterIndiceLista(titulo.FIDCentroCusto, FSlistaCentroCusto);
       frameResponsavel1.cbbcombo.ItemIndex         := obterIndiceLista(titulo.FIDResponsavel, FSlistaResponsavel);
       frmTipoCobranca1.cbbTipoCobranca.ItemIndex   := obterIndiceLista(titulo.FIDTipoCobranca, FSlistaTipoCobranca);
       frmLocalPagto1.cbbcombo.ItemIndex       := obterIndiceLista(titulo.FIDLocalPagamento, FSlistaLocalPagamento);
       frmTipoNF1.cbbTipoNF.ItemIndex              := obterIndiceLista(titulo.FIDNotaFiscalEntrada, FSlistaTipoNF);


    end;


    frameTP1.Enabled := True;

end;

procedure TfrmManterTituloPagar.preencheGridCedntroC;
begin
try
    qryPreencheGridCentroC.Close;
    qryPreencheGridCentroC.Connection := dmConexao.conn;
    qryPreencheGridCentroC.ParamByName('PIDORGANIZACAO').AsString := pIDorganizacao;
    qryPreencheGridCentroC.Open;

 except
 raise Exception.Create('Erro ao consultar a tabela de centro de custos.');

 end;

    dbgridCC.Refresh;

end;



procedure TfrmManterTituloPagar.preencheGridHistorico;
begin
 try
    qryPreencheGridHistorico.Close;
    qryPreencheGridHistorico.Connection := dmConexao.conn;
    qryPreencheGridHistorico.ParamByName('PIDORGANIZACAO').AsString := pIDorganizacao;
    qryPreencheGridHistorico.ParamByName('PTIPO').AsString := 'P';
    qryPreencheGridHistorico.Open;

 except
 raise Exception.Create('Erro ao consultar a tabela de historicos.');

 end;

    dbgridHistorico.Refresh;

end;


procedure TfrmManterTituloPagar.tbComplementoExit(Sender: TObject);
begin
 //setando a complementar no titulo
 tituloPagarModel.FcodigoBarras     := edtCodigoBarras.Text;
 tituloPagarModel.Fcontrato         := edtContrato.Text;
 tituloPagarModel.Fcarteira         := edtCarteira.Text;
 tituloPagarModel.Fobservacao       := edtObervacao.Text;
 tituloPagarModel.FprevisaoCartorio := dtPrevisaoCartorio.DateTime;

end;

procedure TfrmManterTituloPagar.tbNotaFiscalExit(Sender: TObject);
var
notaFiscal :TNotaFiscalEntradaModel;
begin

  notaFiscal :=TNotaFiscalEntradaModel.Create;

  if not uutil.Empty( edtNFNumero.Text ) then begin


  notaFiscal.FIDorganizacao := pIDorganizacao;
  notaFiscal.FID            := dmConexao.obterNewID;
  notaFiscal.FdataRegistro  := Now;
  notaFiscal.Fnovo          := True;

  if not uUtil.Empty(tituloPagarModel.FIDNotaFiscalEntrada) then begin
     notaFiscal.FIDorganizacao  := pIDorganizacao;
     notaFiscal.FID             := tituloPagarModel.FIDNotaFiscalEntrada;
     notaFiscal.FdataRegistro   := tituloPagarModel.FdataRegistro;
       notaFiscal.Fnovo         := False;
    end;

    pIDNotaFiscal := notaFiscal.FID;


    notaFiscal.FIDresponsavel     := tituloPagarModel.FIDResponsavel;
    notaFiscal.FIDtipoNotaFiscal  := pIDTipoNotaFiscal;
    notaFiscal.FIDusuario         := StrToInt(uutil.TUserAtual.getUserId);
    notaFiscal.Fnumero            := edtNFNumero.Text;
    notaFiscal.Fdescricao         := edtNFDescricao.Text;
    notaFiscal.Fobservacao        := edtNFObservacao.Text;
    notaFiscal.Fserie             := edtNFSerie.Text;
    notaFiscal.FsubSerie          := edtNFSubSerie.Text;
    notaFiscal.FaliquotaISS       := edtNFAliquotaISS.Text;
    notaFiscal.FdataRetenncaoISS  := dtNFRetencaoISS.Date;
    notaFiscal.FdataEmissao       := dtNFEmissao.Date;
    notaFiscal.FdataProtocolo     := dtNFProtocolo.Date;
    notaFiscal.Fvalor             := edtValorNF.Value;
    notaFiscal.FvalorISS          := edtValorISS.Value;

    tituloPagarModel.FIDNotaFiscalEntrada := notaFiscal.FID;
    tituloPagarModel.FNotaFiscalEntrada := notaFiscal;

  end;


 popularStatus(tituloPagarModel.FTipoStatus);


end;


function TfrmManterTituloPagar.calcularISS(pValue, pAliquota :Currency) :Currency;
begin

 Result := (pValue * pAliquota)/100;

end;
procedure TfrmManterTituloPagar.tbNotaFiscalShow(Sender: TObject);
begin
{dxBtnSave.Enabled := False;
dxBtnEdit.Enabled := False;}
 StatusBotoes(0);

edtNFDescricao.Text   := edtDescricao.Text;
edtBaseCalculo.Value  := edtValorNF.Value;
edtNFAliquotaISS.Text :=  '5';
edtValorISS.Value     :=  (calcularISS( StrToCurr(edtBaseCalculo.Text), StrToFloat(edtNFAliquotaISS.Text) ));


msgStatusBar(3,'Modo de edi��o. Aba nota fiscal. Para Salvar retorne a aba b�sica.');

end;

procedure TfrmManterTituloPagar.tbRateioCentroCustoShow(Sender: TObject);
begin
preencheGridCedntroC;
end;

procedure TfrmManterTituloPagar.tbRateioHistoricosShow(Sender: TObject);
begin
 preencheGridHistorico;
end;

procedure TfrmManterTituloPagar.StatusBotoes(value :Integer);
var i :Integer;
ativar : Boolean;
begin
 ativar := True;   /// 1 = ativa e 0 = desativa

 if value = 0 then begin //desativar
   ativar := False;
 end;

  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TdxBarLargeButton then
    begin
      (Self.Components[i] as TdxBarLargeButton).Enabled := ativar;
    end;

  end;

  dxBtnLimpar.Enabled := True;
  dxBarBtnSair.Enabled := True;

end;

procedure TfrmManterTituloPagar.dtPagamentoChange(Sender: TObject);
begin
 dtPrevisaoCartorio.Date := IncMonth(dtPagamento.Date, 1);
 tituloPagarModel.FisProvisao := 0;
    dxBtnSave.Enabled := True;
    dxBtnProvisao.Enabled := False;
    dxBtnPagar.Enabled := True;

  if (tituloPagarModel.Fnovo) then
  begin

    if (IsToday(dtPagamento.Date) or (dtPagamento.Date < Now)) then
    begin
      Label10.Caption := 'Data pagamento';
      dxBtnPagar.Enabled := True;
      tituloPagarModel.FisProvisao := 0;

    end
    else
    begin
      dxBtnSave.Enabled := False;
      dxBtnProvisao.Enabled := True;
      dxBtnPagar.Enabled := False;

      Label10.Caption := 'Data provis�o';
      tituloPagarModel.FisProvisao := 1;
      tituloPagarModel.FregistroProvisao := tituloPagarModel.FID;

    end;

  end;

end;

procedure TfrmManterTituloPagar.dxBarBtnSairClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManterTituloPagar.dxBtnCancelBaixaTPClick(Sender: TObject);
var
  sucesso, permite: Boolean;
  tpModel :TTituloPagarModel;
  tpBaixaModel : TTPBaixaModel;
  deducao : TTPBaixaDEModel;
  acrescimo :TTPBaixaACModel;

  formaPagto    : TTPBaixaFPModel;
  pagtoCheque   : TTPBaixaChequeModel;
  pagtoWWW      : TTPBaixaInternetModel;
  cheque        : TContaBancariaChequeModel;
  debitoCaixa   : TTesourariaDBModel;
  contaDebito   : TContaBancariaDBModel;

  tpbCheques :TFDQuery;
  tpbWWW :TFDQuery;
  tpbFP :TFDQuery;

begin
  sucesso := False;
  permite := True;

  if not uUtil.Empty(edtLotePagamento.Text) then
  begin
    permite := False;
    msg := 'O t�tulo foi pago em lote. Primeiro deve remover o lote pagamento : ' + edtLotePagamento.Text;
    PempecMsg.MsgInformation(msg);
  end;

  if not uUtil.Empty(edtLoteContabil.Text) then
  begin
    permite := False;
    msg := 'O t�tulo j� foi exportado. Primeiro deve remover o lote cont�bil. ' + edtLoteContabil.Text;
    PempecMsg.MsgInformation(msg);


  end;

  if permite then
  begin
    dmConexao.conectarBanco;

    tituloPagarModel := TTituloPagarModel.Create;
    tituloPagarModel.FID := FSlistaTitulos[frameTP1.cbbTP.ItemIndex];
    tituloPagarModel.FIDorganizacao := pIDorganizacao;
    tituloPagarModel := TTituloPagarDAO.obterPorID(tituloPagarModel);

    if not uUtil.Empty(tituloPagarModel.FID) then
    begin
      if uutil.Empty(tituloPagarModel.FregistroProvisao) then
      begin
    //    if MessageDlg('O t�tulo ser� automaticamente provisionado. Deseja cancelar o pagamento? ', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
           msg := 'O t�tulo ser� automaticamente provisionado. Deseja cancelar o pagamento? ';
       if  PempecMsg.MsgInformation(msg) = 6 then

        begin
          permite := True;
          tituloPagarModel.FregistroProvisao := tituloPagarModel.FID;
          tituloPagarModel.FisProvisao := 1;

        end
        else
        begin
          permite := False;
        end;

      end;

    end;
  end;

 if permite then
  begin
    dmConexao.conectarBanco;

      tpBaixaModel                := TTPBaixaModel.Create;
      tpBaixaModel.FIDorganizacao := pIDorganizacao;
      tpBaixaModel.FIDtituloPagar := tituloPagarModel.FID;
      tpBaixaModel.FTituloPagar   := tituloPagarModel;

      tpBaixaModel := TTPBaixaDAO.obterPorTP(tpBaixaModel);


      if not uutil.Empty(tpBaixaModel.FID) then begin

        //deleta AC/DE
        deducao := TTPBaixaDEModel.Create;
        deducao.FIDOrganizacao := pIDorganizacao;
        deducao.FIDtituloPagarBaixa := tpBaixaModel.FID;

        TTPBaixaDEDAO.deletePorTPBaixa(deducao);

        acrescimo := TTPBaixaACModel.Create;
        acrescimo.FIDOrganizacao := pIDorganizacao;
        acrescimo.FIDtituloPagarBaixa := tpBaixaModel.FID;

        TTPBaixaACDAO.deletePorTPBaixa(acrescimo);

         // buscar os pagamentos realizados em CHEQUE
        pagtoCheque := TTPBaixaChequeModel.Create;
        pagtoCheque.FIDorganizacao := pIDorganizacao;
        pagtoCheque.FIDTPBaixa := tpBaixaModel.FID;

          tpbCheques := TFDQuery.Create(Self);
          tpbCheques := TTPBaixaChequeDAO.obterTodosPorBaixa(pagtoCheque) ;

       if not tpbCheques.IsEmpty then begin

           FreeAndNil(pagtoCheque);
           tpbCheques.First;
         while not tpbCheques.Eof do begin

            pagtoCheque := TTPBaixaChequeModel.Create;
            pagtoCheque.FIDorganizacao := pIDorganizacao;
            pagtoCheque.FID := tpbCheques.FieldByName('ID_TITULO_PAGAR_BAIXA_CHEQUE').AsString;
            pagtoCheque := TTPBaixaChequeDAO.obterPorID(pagtoCheque) ;

            if not uutil.Empty(pagtoCheque.FID) then begin
                cheque := TContaBancariaChequeModel.Create;
                cheque.FIDorganizacao := pIDorganizacao;
                cheque.Fid := pagtoCheque.FIDCheque;
                cheque := TContaBancariaChequeDAO.obterPorID(cheque);

                if not uutil.Empty(cheque.FID) then begin
                   cheque.FIDtipoStatus := 'BLOQUEADO';
                   cheque.Fvalor := 0;
                   cheque.FdataEstorno := Now;

                   TContaBancariaChequeDAO.Update(cheque);

                end;

               TTPBaixaChequeDAO.Delete(pagtoCheque);

            end;

            tpbCheques.Next;

        end;

        FreeAndNil(tpbCheques);

       end;

        //pagamentos via internet bank line
        pagtoWWW := TTPBaixaInternetModel.Create; //conta bancaria debito
        pagtoWWW.FIDorganizacao := pIDorganizacao;
        pagtoWWW.FIDTPB := tpBaixaModel.FID;

        tpbWWW := TFDQuery.Create(Self);
        tpbWWW := TTPBaixaInternetDAO.obterTodosPorBaixa(pagtoWWW);

         if not tpbWWW.IsEmpty then begin

            FreeAndNil(pagtoWWW);
           tpbWWW.First;
         while not tpbWWW.Eof do begin

            pagtoWWW := TTPBaixaInternetModel.Create; //conta bancaria debito
            pagtoWWW.FIDorganizacao := pIDorganizacao;
            pagtoWWW.FIDTPB := tpBaixaModel.FID;
            pagtoWWW.FID := tpbWWW.FieldByName('ID_TITULO_PAGAR_BAIXA_INTERNET').AsString;
            pagtoWWW := TTPBaixaInternetDAO.obterPorID(pagtoWWW) ;

            if not uUtil.Empty(pagtoWWW.FID) then begin

               TTPBaixaInternetDAO.Delete(pagtoWWW);

            end;
            tpbWWW.Next;
         end;
         FreeAndNil(tpbWWW);
         end;

        // deletar da CBD por titulo pagar  = TP
        contaDebito := TContaBancariaDBModel.Create;
        contaDebito.FIDorganizacao := pIDorganizacao;
        contaDebito.FIDTP := tpBaixaModel.FIDtituloPagar;

        TContaBancariaDebitoDAO.deleteTodosPorTP(contaDebito);

        //deletar da TD pot titulo pagar baixa = TPB
        debitoCaixa := TTesourariaDBModel.Create;
        debitoCaixa.FIDorganizacao := pIDorganizacao;
        debitoCaixa.FIDTPB := tpBaixaModel.FID;
        TTesourariaDBDAO.deleteTodosPorTPB(debitoCaixa);

        //deletar as formas de pagamento
        formaPagto := TTPBaixaFPModel.Create;
        formaPagto.FIDorganizacao := pIDorganizacao;
        formaPagto.FIDTPBaixa := tpBaixaModel.FID;

        if TTPBaixaFPDAO.deleteTodosPorTPB(formaPagto) then
        begin
         //alterar o tp
          tituloPagarModel.FIDTipoStatus := 'ABERTO';
          tituloPagarModel.FdataUltimaAtualizacao := Now;
          tituloPagarModel.FIDUsuario := uUtil.TUserAtual.getUserId;

          if TTituloPagarDAO.Update(tituloPagarModel) then
          begin
           //deletar o tpb
            sucesso := TTPBaixaDAO.Delete(tpBaixaModel);

          end;
        end;

      end;

    end;

    if sucesso then
    begin

      msg := 'A baixa do t�tulo foi cancelada com sucesso. ' + edtLoteContabil.Text;
      PempecMsg.MsgInformation(msg);
      limparPanel;

    end;

  end;

procedure TfrmManterTituloPagar.dxBtnDeletClick(Sender: TObject);
begin
 if frameTP1.cbbTP.ItemIndex >0  then begin

   if not uutil.Empty(tituloPagarModel.FID) then begin
     try
      tituloPagarModel.FIDTipoStatus := 'EXCLUIDO';
      tituloPagarModel.FdataUltimaAtualizacao := Now;
      tituloPagarModel.Fobservacao := 'TP deletado ' + uUtil.TUserAtual.getNameUser + '  PC ' + uutil.GetComputerNetName  ;

     if (TTituloPagarDAO.Update(tituloPagarModel)) then begin
         PempecMsg.MsgInformation('Titulo deletado com sucesso.');
     end;
     except
     raise Exception.Create('Erro ao tentar deletar o titulo ' + tituloPagarModel.FnumeroDocumento);
     end;

   end;
 end;

  dxBtnLimparClick(Self);

end;

procedure TfrmManterTituloPagar.dxBtnEditClick(Sender: TObject);
begin
    bloqueiaCampos(Self, True);
    dxBtnSave.Enabled :=True;
end;

procedure TfrmManterTituloPagar.dxBtnEspelhoClick(Sender: TObject);
begin

  try
    formEspelhoTP := TformEspelhoTP.Create(Self, tituloPagarModel.FnumeroDocumento);
    formEspelhoTP.ShowModal;
    FreeAndNil(formEspelhoTP);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte.  ' );
  end;
end;

procedure TfrmManterTituloPagar.dxBtnLimparClick(Sender: TObject);
begin
limparPanel;
limpaRateioHistorico;
limpaRateioCC;

end;

procedure TfrmManterTituloPagar.dxBtnProvisaoClick(Sender: TObject);
var
 sucesso : Boolean;
begin
  sucesso := True;

  if validarForm(Self) then
  begin

    if not uUtil.Empty(tituloPagarModel.FID) then
    begin

      atualizarTitulo;

      try

        //sucesso := salvarTitulo(tituloPagarModel); salva o primeiro

        frmTituloPagarParcelado := TFrmTituloPagarParcelado.Create(Self, tituloPagarModel);
        frmTituloPagarParcelado.ShowModal;
        sucesso := frmTituloPagarParcelado.getSucesso;
        FreeAndNil(frmTituloPagarParcelado);

      except
        on e: Exception do
        begin
          sucesso := False;
          PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. ');
        end;

      end;

    end;

    //  LimpaTela(Self);
    if sucesso then
       begin

      dxBtnLimpar.Click;

    end;


  end;




end;

procedure TfrmManterTituloPagar.dxBtnPagarClick(Sender: TObject);
 var
 sucesso : Boolean;

 aux : Integer;
begin
  sucesso := True;
  aux :=0;

  if validarForm(Self) then
  begin

    if not uUtil.Empty(tituloPagarModel.FID) then
    begin
     try
        atualizarTitulo;

        if tituloPagarModel.Fnovo then
        begin
          sucesso := TTituloPagarDAO.Insert(tituloPagarModel);
        end;

        if sucesso then
        begin

          frmBaixa := TFrmBaixaFP.Create(Self, tituloPagarModel);
          frmBaixa.ShowModal;
          FreeAndNil(frmBaixa);

        end;

      except
        on e: Exception do
        begin
          sucesso := False;
          PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + e.Message);
        end;
      end;

    end;


    if sucesso then
    begin

      dxBtnLimpar.Click;

    end;


  end;

end;

procedure TfrmManterTituloPagar.dxBtnReciboClick(Sender: TObject);
begin

  try
      frmReciboTP := TFrmReciboTP.Create(Self, tituloPagarModel.FID);
      frmReciboTP.ShowModal;
      FreeAndNil(frmReciboTP);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;
end;

function TfrmManterTituloPagar.createTitulo : Boolean;
 var
hst : THistoricoModel;
ced : TCedenteModel;

begin

  //historico principal
  hst := THistoricoModel.Create;
  //centro de custos principal

  ced  := TCedenteModel.Create;
  //ambos irao fazer parte da lista
   {

  //chaves obrigatorias



  tituloPagarModel.FdataVencimento    := dtPagamento.Date;
  tituloPagarModel.FdataRegistro
  tituloPagarModel.FdataEmissao
  tituloPagarModel.FdataProtocolo
  tituloPagarModel.FdataUltimaAtualizacao
  tituloPagarModel.FprevisaoCartorio
  tituloPagarModel.FdataPagamento
  tituloPagarModel.FvalorNominal  := edtValor.Value;
  tituloPagarModel.FvalorAntecipado

  tituloPagarModel.Fparcela       := edtParcela.Text;
  tituloPagarModel.Fdescricao     := edtDescricao.Text;

  tituloPagarModel.FnumeroDocumento
  tituloPagarModel.FregistroProvisao
   tituloPagarModel.Fmoeda
   tituloPagarModel.Fcarteira
    tituloPagarModel.FcodigoBarras
    tituloPagarModel.Fcontrato
    tituloPagarModel.Fobservacao
                                      }
 //

 //objetos
 {

    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetFForganizacao;

    property FCedente: TCedenteModel read getFFCedente write SetFFCedente;
    property FTipoCobranca: TTipoCobrancaModel read getFFTipoCobranca write SetFFTipoCobranca;
    property FResponsavel: TFuncionarioModel read getFFResponsavel write SetFFResponsavel;
    property FLocalPagamento: TLocalPagamentoModel read getFFLocalPagamento write SetFFLocalPagamento;
    property FLotePagamento: TLotePagamentoModel read getFFLotePagamento write SetFFLotePagamento;
    property FTipoStatus: TTipoStatusModel read getFFTipoStatus write SetFFTipoStatus;
    property FCentroCustos: TCentroCustoModel read getFFCentroCustos write SetFFCentroCustos;
    property FTituloPagar: TTituloPagarModel read getFFTituloPagar write SetFFTituloPagar;
    property FNotaFiscalEntrada: TNotaFiscalEntradaModel read getFFNotaFiscalEntrada write SetFFNotaFiscalEntrada;
    property FLoteContabil: TLoteContabilModel read getFFLoteContabil write SetFFLoteContabil;
    property FUsuario: TUsuarioModel read getFFUsuario write SetFFUsuario;
    property FCheque: TContaBancariaChequeModel read getFFCheque write SetFFCheque;

     property FHistorico: THistoricoModel read getFFHistorico write SetFFHistorico;


    property listaHistorico   : TObjectList<TTituloPagarHistoricoModel> read FSlistaHistorico  write FSlistaHistorico;
    property listaCustos      : TObjectList<TTituloPagarCentroCustoModel> read FSlistaCustos      write FSlistaCustos;

       }


 //



 //objetos
  hst.FIdOrganizacao := pIDorganizacao;
  hst.FID := tituloPagarModel.FIDHistorico;
  hst := THistoricoDAO.obterPorID(hst);
  tituloPagarModel.FHistorico := hst;

  ced.FIdOrganizacao := pIDorganizacao;
  ced.FID := tituloPagarModel.FIDCedente;
  ced := TCedenteDAO.obterPorID(ced);
  tituloPagarModel.FCedente := ced;


  Result := True;

end;

procedure TfrmManterTituloPagar.atualizarTitulo;
 var
 Value :Integer;
begin
   //  pega os dados do form e seta no titulo
    tituloPagarModel.FIDCedente             := FSlistaCedente[frameCedente1.cbbcombo.ItemIndex];
    tituloPagarModel.FIDHistorico           := FSlistaHistorico[frameHistorico1.cbbcombo.ItemIndex];
    tituloPagarModel.FIDCentroCusto         := FSlistaCentroCusto[frameCentroCusto1.cbbcombo.ItemIndex];
    tituloPagarModel.FIDResponsavel         := FSlistaResponsavel[frameResponsavel1.cbbcombo.ItemIndex];
    tituloPagarModel.FIDTipoStatus          := edtStatus.Text;
    tituloPagarModel.FIDUsuario             := uutil.TUserAtual.getUserId;
    tituloPagarModel.FIDorganizacao         := uUtil.TOrgAtual.getId;
    tituloPagarModel.FIDTipoCobranca        := FSlistaTipoCobranca[frmTipoCobranca1.cbbTipoCobranca.ItemIndex];
    tituloPagarModel.FIDLocalPagamento      := FSlistaLocalPagamento[frmLocalPagto1.cbbcombo.ItemIndex] ;
    tituloPagarModel.FdataVencimento        := dtPagamento.Date;
    tituloPagarModel.FCedente   := cedenteModel;
    tituloPagarModel.FIDContaContabilCredito := cedenteModel.FIDcontaContabil;

    tituloPagarModel.FdataUltimaAtualizacao := Now;
    tituloPagarModel.FdataEmissao           := dtEmissao.Date;
    tituloPagarModel.FdataProtocolo         := dtProtocolo.Date;
    tituloPagarModel.FprevisaoCartorio      := dtPrevisaoCartorio.Date;
    tituloPagarModel.Fdescricao             := edtDescricao.Text;
    tituloPagarModel.Fparcela               := edtParcela.Text;
    tituloPagarModel.FvalorNominal          := edtValorMainTP.Value;
    tituloPagarModel.FcodigoBarras          := edtCodigoBarras.Text;
    tituloPagarModel.Fcontrato              := edtContrato.Text;
    tituloPagarModel.Fcarteira              := edtCarteira.Text;
    tituloPagarModel.Fobservacao            := edtObervacao.Text;
    tituloPagarModel.FvalorAntecipado       := edtValorAntecipado.Value;

end;


function TfrmManterTituloPagar.salvarTitulo(titulo :TTituloPagarModel) :Boolean;
var
sucesso :Boolean;
begin
  dmConexao.conectarBanco;
  sucesso := True;

  if not (titulo.Fnovo) then  //j� existe.. ent�o atualiza
  begin
    try
     sucesso := TTituloPagarDAO.Update(titulo);
    except
      sucesso := False;
      raise Exception.Create('Erro ao atualizar o TP');

    end;
  end
  else
  begin
    try
      TTituloPagarDAO.Insert(titulo);
    except
      sucesso := False;
      raise Exception.Create('Erro ao inserir o TR');

    end;

  end;

  Result := sucesso;
end;
procedure TfrmManterTituloPagar.dxBtnSaveClick(Sender: TObject);

begin

  if validarForm(Self) then
  begin
  { if not dmConexao.conn.InTransaction then
          dmConexao.conn.StartTransaction;  }
    try
      //atualizando o titulo com dados do form
         atualizarTitulo;

      if salvarTitulo(tituloPagarModel) then begin
      // if not dmConexao.conn.InTransaction then  dmConexao.conn.CommitRetaining;
         dxBtnLimpar.Click;
      end;

    except
      on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: BTNSALVAR_TP ');
    end;

  end;

end;

procedure TfrmManterTituloPagar.edtCarteiraChange(Sender: TObject);
begin
tituloPagarModel.Fcarteira := edtCarteira.Text;
end;

procedure TfrmManterTituloPagar.edtValorMainTPChange(Sender: TObject);
begin
edtValorTP.Value    := edtValorMainTP.Value;
edtValorTPCC.Value  := edtValorMainTP.Value;
edtValorNF.Value    := edtValorMainTP.Value;
end;

procedure TfrmManterTituloPagar.edtValorRateioCCChange(Sender: TObject);
begin

if edtValorRateioCC.Value > 0 then begin
btnSelectTCC.Enabled := True;
end;
end;

procedure TfrmManterTituloPagar.edtValorRateioHistChange(Sender: TObject);
begin

if edtValorRateioHist.Value > 0 then begin
btnSelectTHST.Enabled := True;
end;
end;

procedure TfrmManterTituloPagar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  FreeAndNil(tituloPagarModel);
  FreeAndNil(cedenteModel);
  FreeAndNil(historicoModel);
  FreeAndNil(centroCustoModel);
  FreeAndNil(responsavelModel);


  Action := caFree;
end;

procedure TfrmManterTituloPagar.FormCreate(Sender: TObject);
begin

limparPanel;


end;

procedure TfrmManterTituloPagar.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

 case key of
  vk_f2: dxBtnEdit.Click;
//  vk_f4: dxBtnNew.Click;
  vk_f10: dxBtnSave.Click;
  VK_RETURN : BtnGerarDOC.Click;

  end;


   if ((Shift = [ssCtrl]) and (Key = VK_F12)) then begin
       frameTP1.obterTodos(pIDorganizacao, frameTP1.cbbTP, FSlistaTitulos);
   end;



  end;

procedure TfrmManterTituloPagar.popularCedente(cedente :TCedenteModel);
var
vctoCartao : string;
diaHoje, diaCompra, diaVcto : Integer;

begin
 dxBtnPagar.Enabled := True;
 dxBtnProvisao.Enabled := False;


 if tituloPagarModel.Fnovo then begin
  dtPagamento.Date :=  uUtil.TFormat.proximoDiaUtil(Now);
 end;


  if not uUtil.Empty(cedente.FID) then
  begin
      cedenteModel := TCedenteDAO.obterPorID(cedente);

    if not uutil.Empty(cedente.FcontaContabil.FID) then
    begin


       tituloPagarModel.FIDCedente := cedenteModel.FID;
       tituloPagarModel.FCedente   := cedenteModel;
       tituloPagarModel.FIDContaContabilCredito := cedenteModel.FIDcontaContabil;

      edtCEDConta.Text := cedenteModel.FcontaContabil.Fconta;
      edtCEDReduz.Text := cedenteModel.FcontaContabil.FcodigoReduzido;

      dxBtnPagar.Enabled :=True;


    end
    else
    begin
      edtCEDConta.Text := 'NC';
      edtCEDReduz.Text := 'NC';
    end;

  end;

  if not uUtil.Empty(cedenteModel.FIDcartaoCreditoModel) then begin
    diaCompra :=StrToInt(cedenteModel.FcartaoCredito.FDiaCompra);
    diaVcto   := StrToInt(cedenteModel.FcartaoCredito.FDiaVencimento);
    diaHoje   := DayOf(Now);

    vctoCartao := IntToStr(diaVcto) + '/' + IntToStr(MonthOf(IncMonth(Now, 0))) + '/' + IntToStr(yearOf(Now));


      if diaHoje >= diaCompra then
      begin
        vctoCartao := IntToStr(diaVcto) + '/' +IntToStr(MonthOf(IncMonth(Now, 1))) + '/' + IntToStr(yearOf(Now));

      end;


      dtPagamento.Date := uUtil.TFormat.proximoDiaUtil(StrToDate(vctoCartao));

      if not IsToday(dtPagamento.Date )then begin

         dxBtnSave.Enabled      := False;
         dxBtnProvisao.Enabled  := True;
         dxBtnPagar.Enabled     := False;

      end;



  end;





end;

procedure TfrmManterTituloPagar.popularCentroCusto( centroCusto: TCentroCustoModel);
begin
    centroCustoModel                := TCentroCustoModel.Create;
    centroCustoModel.FIDorganizacao := centroCusto.FIDorganizacao;
    centroCustoModel.FID            := centroCusto.FID;
    centroCustoModel                := TCentroCustoDAO.obterPorID(centroCusto);

  if not uUtil.Empty(centroCustoModel.FID) then
  begin

    frameCentroCusto1.cbbcombo.ItemIndex := obterIndiceLista(centroCustoModel.FID,FSlistaCentroCusto );

  end;

end;

procedure TfrmManterTituloPagar.popularHistorico(historico: THistoricoModel);
begin
    historicoModel                 := THistoricoModel.Create;
    historicoModel.FIDorganizacao := historico.FIDorganizacao;
    historicoModel.FID            := historico.FID;
    historicoModel                := THistoricoDAO.obterPorID(historico);

  if not uUtil.Empty(historicoModel.FID) then
  begin
    if not uutil.Empty(historicoModel.FcontaContabil.FID) then
    begin

      edtHISTConta.Text   := historicoModel.FcontaContabil.Fconta;
      edtHISTReduz.Text   := historicoModel.FcontaContabil.FcodigoReduzido;
      edtCodigoHist.Text  := IntToStr(historicoModel.FCodigo);

    end
    else
    begin
      edtHISTConta.Text := 'NC';
      edtHISTReduz.Text := 'NC';
      msgStatusBar(1, 'Verifique a conta cont�bil do hist�rico');
      dxBtnSave.Enabled := False;
    end;

  end;




end;


procedure TfrmManterTituloPagar.popularResponsavel(responsavel: TFuncionarioModel);
begin
    responsavelModel                := TFuncionarioModel.Create;
    responsavelModel.FIDorganizacao := responsavel.FIDorganizacao;
    responsavelModel.FID            := responsavel.FID;
    responsavelModel                := TFuncionarioDAO.obterPorID(responsavel);

  end;

procedure TfrmManterTituloPagar.popularStatus(status: TTipoStatusModel);

begin

   StatusBotoes(0);

    statusModel                     := TTipoStatusModel.Create;
    statusModel.FIDorganizacao      := status.FIDorganizacao;
    statusModel.FID                 := status.FID;
    statusModel                     := TTipoStatusDAO.obterPorID(status);

    if status.FID.Equals('ABERTO') then begin

            dxBtnPagar.Enabled      := True;
            dxBtnEdit.Enabled       := True;
            dxBtnDelet.Enabled      := True;
            dxBtnEspelho.Enabled    := True;
            dxBtnRecibo.Enabled     := False; //N�o permite emitir recibo com TP aberto

    end;


    if (status.FID.Equals('QUITADO') or status.FID.Equals('PARCIAL')) then begin

            dxBtnEspelho.Enabled        := True;
            dxBtnRecibo.Enabled         := True;
            dxBtnCancelBaixaTP.Enabled  := True;
    end;





  if status.FID.Equals('EXCLUIDO') then
  begin
    StatusBotoes(0);
  end;




end;

procedure TfrmManterTituloPagar.frameCedente1cbbcomboChange(Sender: TObject);

begin

if frameCedente1.cbbcombo.ItemIndex > 0 then begin

  cedenteModel                := TCedenteModel.Create;
  cedenteModel.FID            := FSlistaCedente[frameCedente1.cbbcombo.ItemIndex];
  cedenteModel.FIDorganizacao := pIDorganizacao;
  cedenteModel := TCedenteDAO.obterPorID(cedenteModel);

  popularCedente(cedenteModel);

 end ;


end;

procedure TfrmManterTituloPagar.frameCentroCusto1cbbcomboChange( Sender: TObject);
var
rateioCC : TTituloPagarCentroCustoModel;
I :Integer;

begin
  dmConexao.conectarBanco;
  limpaRateioCC;

  if edtValorMainTP.Value = 0 then
  begin
    frameCentroCusto1.cbbcombo.ItemIndex := 0;
    msg := 'O valor do t�tulo n�o pode ser 0 ';
    PempecMsg.MsgInformation(msg);
  end;


  if frameCentroCusto1.cbbcombo.ItemIndex > 0 then
  begin


   centroCustoModel                 := TCentroCustoModel.Create;
   centroCustoModel.FID             := FSlistaCentroCusto[frameCentroCusto1.cbbcombo.ItemIndex];
   centroCustoModel.FIDorganizacao  := pIDorganizacao;
   popularCentroCusto(centroCustoModel);

    rateioCC := TTituloPagarCentroCustoModel.Create;
    rateioCC.FIDorganizacao := pIDorganizacao;
    rateioCC.FID := dmConexao.obterNewID;
    rateioCC.FIDCentroCusto := centroCustoModel.FID;
    rateioCC.FIDTP := tituloPagarModel.FID;
    rateioCC.Fvalor := edtValorMainTP.Value;
    rateioCC.FCentroCusto := centroCustoModel;

    tituloPagarModel.listaCustos.Clear; //zera todos os historicos existentes.. tem que refazer o rateio
    tituloPagarModel.AdicionarCC(rateioCC);
    fdmCentroCusto.Open;
    fdmCentroCusto.InsertRecord([centroCustoModel.FDescricao, edtValorMainTP.Value]);

  end
  else
  begin
   msg :='Voc� precisa selecionar um centro de Custos. ';
   PempecMsg.MsgInformation(msg);

  end;


  atualizarRateio('C');


end;

procedure TfrmManterTituloPagar.frameHistorico1cbbcomboChange(Sender: TObject);
var
rateioHistorico : TTituloPagarHistoricoModel;
hstValidado : Boolean;
I,J :Integer;
begin
dmConexao.conectarBanco;
   hstValidado := False;


   limpaRateioHistorico; //sempre limpa a lista do TP

  if edtValorMainTP.Value = 0 then
  begin
    frameHistorico1.cbbcombo.ItemIndex := 0;
    msg := 'O valor do t�tulo n�o pode ser 0 ';
    PempecMsg.MsgInformation(msg);
  end
  else
  begin

     if frameHistorico1.cbbcombo.ItemIndex >0 then begin
          historicoModel                := THistoricoModel.Create;
          historicoModel.FID            := FSlistaHistorico[frameHistorico1.cbbcombo.ItemIndex];
          historicoModel.FIDorganizacao := pIDorganizacao;
          popularHistorico(historicoModel);

          rateioHistorico                         := TTituloPagarHistoricoModel.Create;
          rateioHistorico.FID                     := dmConexao.obterNewID;
          rateioHistorico.FIDorganizacao          := pIDorganizacao;
          rateioHistorico.FIDHistorico            := historicoModel.FID;
          rateioHistorico.FIDContaContabilDebito  := historicoModel.FIdContaContabil;
          rateioHistorico.FIDTP                   := tituloPagarModel.FID;
          rateioHistorico.Fvalor                  := edtValorMainTP.Value; //valor total do TP

          tituloPagarModel.listaHistorico.Clear; //zera todos os historicos existentes.. tem que refazer o rateio
          tituloPagarModel.AdicionarHST(rateioHistorico);

          fdmHistorico.Open;
          fdmHistorico.InsertRecord([historicoModel.FDescricao, edtValorMainTP.Value]);
          atualizarRateio('H');

     end;

 end;

end;

procedure TfrmManterTituloPagar.frameHistorico2cbbcomboChange(Sender: TObject);
begin

  if frameHistorico2.cbbcombo.ItemIndex > 0 then
  begin
    edtValorRateioHist.Enabled := True;
  end
  else
  begin
    edtValorRateioHist.Enabled := False;
  end;


end;

procedure TfrmManterTituloPagar.frameResponsavel1cbbcomboChange(  Sender: TObject);
begin

if frameResponsavel1.cbbcombo.ItemIndex >0 then begin

  responsavelModel                := TFuncionarioModel.Create;
  responsavelModel.FID            := FSlistaResponsavel[frameResponsavel1.cbbcombo.ItemIndex];
  responsavelModel.FIDorganizacao := pIDorganizacao;
  popularResponsavel(responsavelModel);

 end else begin PempecMsg.MsgInformation('Selecione um respons�vel.'); end;


end;

procedure TfrmManterTituloPagar.frameTP1cbbTPChange(Sender: TObject);
begin
 limpaRateioHistorico;
 limpaRateioCC;
 modo :=0; //modo de consulta

 if modo = 0  then begin
    BtnGerarDOC.Caption := 'Consultar';
    BtnGerarDOC.Enabled := True;
  end;
end;


procedure TfrmManterTituloPagar.bloqueiaCampos(Form :TForm; status :Boolean);
var
i :Integer;
begin

  for i := 0 to Form.ComponentCount - 1 do
  begin

      if Form.Components[i] is TCustomEdit then
      begin
        (Form.Components[i] as TCustomEdit).Enabled := status;
      end;

       if Form.Components[i] is TButton then
      begin
        (Form.Components[i] as TButton).Enabled := status;
      end;


       if Form.Components[i] is TFrame then
      begin
        (Form.Components[i] as TFrame).Enabled := status;
      end;

      if Form.Components[i] is TEdit then
      begin
        TEdit(Form.Components[i]).Enabled := status;
      end;


      if Form.Components[i] is TComboBox then
      begin

        TComboBox(Form.Components[i]).Enabled := status;
      end;


      if Form.Components[i] is TDateTimePicker then
      begin
        TDateTimePicker(Form.Components[i]).Enabled := status;
      end;


  end;

end;

procedure TfrmManterTituloPagar.frameTP1cbbTPExit(Sender: TObject);
begin
 // limparPanel;

  limpaRateioHistorico;
  limpaRateioCC;
  StatusBotoes(0);
  tituloPagarModel := TTituloPagarModel.Create;
  BtnGerarDOC.Enabled := True;


 if frameTP1.cbbTP.ItemIndex >0 then begin
   //verifica se tem lotes (contabil e pagametno)
   //titulo veio da consulta
    bloqueiaCampos(Self, False); //seta False na propriedade enabled do componente

   tituloPagarModel.FID := FSlistaTitulos[frameTP1.cbbTP.ItemIndex];
   tituloPagarModel.FIDorganizacao := pIDorganizacao;
   tituloPagarModel := TTituloPagarDAO.obterPorID(tituloPagarModel);

    if not uutil.Empty(tituloPagarModel.FID) then
    begin
      Self.Caption := 'Manuten��o de t�tulo a pagar  NUM.  : ' + tituloPagarModel.FnumeroDocumento + ' FORN. : ' + tituloPagarModel.FCedente.Fnome;
      tituloPagarModel.Fnovo := False;
      preencheAbaBasica(tituloPagarModel);
      preencheDatas(tituloPagarModel);
      preencheAbaComplementar(tituloPagarModel);
      carregarCombos(tituloPagarModel); //carrega com o objeto que vem do BD
      popularCedente(tituloPagarModel.FCedente);
      popularHistorico(tituloPagarModel.FHistorico);
      preencheAbaRateioHistorico(tituloPagarModel.listaHistorico);
      preencheAbaNotaFiscal(tituloPagarModel.FNotaFiscalEntrada);
      preencheAbaRateioCC(tituloPagarModel.listaCustos);
      popularCentroCusto(tituloPagarModel.FCentroCustos);
      popularResponsavel(tituloPagarModel.FResponsavel);
      popularStatus(tituloPagarModel.FTipoStatus); //libera os botoes

      msgStatusBar(3, 'Para liberar os campos, clique em Editar.');

    end else
    begin
      PempecMsg.MsgInformation('T�tulo n�o localizado... ');
      FreeAndNil(tituloPagarModel)
    end; 
    BtnGerarDOC.Caption := 'Consultar';
 end;

  msgStatusBar(2, 'ATENC�O :' );
  msgStatusBar(3, 'CTRL + F12 carrega todos os t�tulos ' );


end;

procedure TfrmManterTituloPagar.frmTipoNF1cbbTipoNFChange(Sender: TObject);
begin
  if frmTipoNF1.cbbTipoNF.ItemIndex > 0 then
  begin

    pIDTipoNotaFiscal := FSlistaTipoNF[frmTipoNF1.cbbTipoNF.ItemIndex];

  end;
end;

procedure TfrmManterTituloPagar.preencheAbaComplementar(titulo : TTituloPagarModel);
begin
 edtUltimoUpdate.Text     := DateToStr(titulo.FdataUltimaAtualizacao);
 dtPrevisaoCartorio.Date  := (titulo.FprevisaoCartorio);
 edtCodigoBarras.Text     := titulo.FcodigoBarras;
 edtContrato.Text         := titulo.Fcontrato;
 edtCarteira.Text         := titulo.Fcarteira;
 edtObervacao.Text        := titulo.Fobservacao;
end;

procedure TfrmManterTituloPagar.preencheAbaBasica(titulo : TTituloPagarModel);
var
loteCC : TLoteContabilModel;
lotePP : TLotePagamentoModel;
begin
   loteCC := TLoteContabilModel.Create;
   lotePP := TLotePagamentoModel.Create;

   edtLotePagamento.Clear;
   edtLoteContabil.Clear;


   loteCC := obterLoteContabil(titulo.FLoteContabil);
   lotePP := obterLotePagamento(titulo.FLotePagamento);

   if not uutil.Empty(loteCC.FID) then begin
     edtLoteContabil.Text   := 'DATA '+ DateToStr(titulo.FLoteContabil.FdataRegistro) + ' LOTE :' + titulo.FLoteContabil.Flote;
   end;

   if not uutil.Empty(lotePP.FID) then begin
     edtLotePagamento.Text   :=  titulo.FLotePagamento.Flote;
   end;

   edtValorMainTP.Value     := titulo.FvalorNominal;
   edtValorAntecipado.Value := titulo.FvalorAntecipado;
   edtParcela.Text          := titulo.Fparcela;
   edtStatus.Text           := titulo.FTipoStatus.Fdescricao;
   edtDescricao.Text        := titulo.Fdescricao;
   edtProvisao.Text         := titulo.FregistroProvisao;

   if not (titulo.FIDTipoStatus = 'ABERTO') then begin

   if not uutil.Empty(loteCC.FID) then begin
     edtLoteContabil.Text   := 'DATA '+ DateToStr(titulo.FLoteContabil.FdataRegistro) + ' LOTE :' + titulo.FLoteContabil.Flote;
   end;

   end;


   FreeAndNil(loteCC);
   FreeAndNil(lotePP);


end;

procedure TfrmManterTituloPagar.preencheDatas(titulo : TTituloPagarModel);
begin
  bloqueiaCampos(Self, true);

   Label10.Caption := 'Data pagamento';
   dtPagamento.DateTime     := titulo.FdataPagamento;
   dtEmissao.DateTime       := titulo.FdataEmissao;
   dtProtocolo.DateTime     := titulo.FdataProtocolo;
   dtPrevisaoCartorio.DateTime := titulo.FprevisaoCartorio;
   edtUltimoUpdate.Text        := DateToStr(titulo.FdataUltimaAtualizacao);

   if titulo.FIDTipoStatus.Equals('ABERTO') then begin
    Label10.Caption := 'Data vencimento';
    dtPagamento.DateTime   := titulo.FdataVencimento;
    dxBtnPagar.Enabled := True;
   end;
    if titulo.FIDTipoStatus.Equals('EXCLUIDO') then begin
    Label10.Caption := 'Data vencimento';
    dtPagamento.DateTime   := titulo.FdataVencimento;
   end;

     bloqueiaCampos(Self, False);

end;

procedure TfrmManterTituloPagar.preencheAbaRateioCC(listaCC :TObjectList<TTituloPagarCentroCustoModel>);
 var
I :Integer;
centroCusto : TCentroCustoModel;
TPCCModel : TTituloPagarCentroCustoModel;
begin
  for I := 0 to listaCC.Count-1 do begin

        TPCCModel := TTituloPagarCentroCustoModel.Create;
        TPCCModel := TTituloPagarCentroCustoModel(listaCC[I]);
        TPCCModel := TTituloPagarCentroCustoDAO.obterPorID(TPCCModel);

     fdmCentroCusto.Open;
     fdmCentroCusto.InsertRecord([TPCCModel.FCentroCusto.FDescricao, TPCCModel.Fvalor]);

   end;

  atualizarRateio('C');


end;

procedure TfrmManterTituloPagar.limpaAbaNF;
begin

   edtNFObservacao.Clear;
   edtNFNumero.Clear;
   edtNFDescricao.Clear;
   edtNFAliquotaISS.Clear;
   edtNFSerie.Clear;
   edtNFSubSerie.Clear;
   dtNFEmissao.Date := Now;
   dtNFProtocolo.Date := Now;
   dtNFRetencaoISS.Date :=Now;
   edtValorNF.Value           := 0;
   edtBaseCalculo.Value     := 0;
   edtValorISS.Value        := 0;

   pIDTipoNotaFiscal := '';
   pIDNotaFiscal := '';

end;
procedure TfrmManterTituloPagar.preencheAbaNotaFiscal(nota :TNotaFiscalEntradaModel);
begin
 //limpar aba
 limpaAbaNF;

 if not uUtil.Empty(nota.FID) then begin
     frmTipoNF1.cbbTipoNF.ItemIndex := obterIndiceLista(nota.FIDtipoNotaFiscal, FSlistaTipoNF);


   edtNFObservacao.Text     := nota.Fobservacao;
   edtNFNumero.Text         := nota.Fnumero;
   edtNFDescricao.Text      := nota.Fdescricao;
   edtNFAliquotaISS.Text    := nota.FaliquotaISS;
   edtNFSerie.Text          := nota.Fserie;
   edtNFSubSerie.Text       := nota.FsubSerie;
   dtNFEmissao.Date         := nota.FdataEmissao;
   dtNFProtocolo.Date       := nota.FdataProtocolo;
   dtNFRetencaoISS.Date     := nota.FdataRetenncaoISS;
   edtValorNF.Value         := nota.Fvalor;
   edtBaseCalculo.Value     := nota.FbaseCalculoISS;
   edtValorISS.Value        := nota.FvalorISS;

   pIDTipoNotaFiscal := nota.FIDtipoNotaFiscal;
   pIDNotaFiscal := nota.FID;

 end;

end;


procedure TfrmManterTituloPagar.preencheAbaRateioHistorico(listaH :TObjectList<TTituloPagarHistoricoModel>);
var
I :Integer;
historico : THistoricoModel;
TPHModel : TTituloPagarHistoricoModel;begin

   for I := 0 to listaH.Count-1 do begin

        TPHModel := TTituloPagarHistoricoModel.Create;
        TPHModel := TTituloPagarHistoricoModel(listaH[I]);
        TPHModel := TTituloPagarHistoricoDAO.obterPorID(TPHModel);

     fdmHistorico.Open;
     fdmHistorico.InsertRecord([TPHModel.FHistorico.FDescricao, TPHModel.Fvalor]);

   end;

  atualizarRateio('H');

end;


procedure TfrmManterTituloPagar.limparPanel;
begin
  modo :=1;//modo de titulo novo. altera quando clica no combo de TP para pesquisar TP existente
  retiraOrdemCampo(Self);
  bloqueiaCampos(Self, True);

  dxBtnSave.Caption := 'Salvar';
  BtnGerarDOC.Caption := 'Gerar';
  dxBtnPagar.Enabled := True;
 // LimpaTela(Self); dando erro

 limpaStatusBar;

 if Assigned(tituloPagarModel) then begin FreeAndNil(tituloPagarModel); end;

 tituloPagarModel := TTituloPagarModel.Create;
 BtnGerarDOC.Enabled := True;
 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdUsuario :=uutil.TUserAtual.getUserId;

 carregarCombos(tituloPagarModel);


  pgTitulo.ActivePageIndex :=0;
  btnSelectTHST.Enabled := False; //tb rateio historico
  edtValorRateioHist.Enabled := False; //tb rateio historico
  btnSelectTCC.Enabled := False; //tb rateio CC
  edtValorRateioCC.Enabled := False; //tb rateio CC

  LimpaTela(Self);


  msgStatusBar(2, 'ATENC�O :' );
  msgStatusBar(3, 'CTRL + F12 carrega todos os t�tulos ' );


end;

procedure TfrmManterTituloPagar.limpaStatusBar;
begin
msgStatusBar(0, 'Status ');
msgStatusBar(1, 'Ativo ');

//dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ';
end;

procedure TfrmManterTituloPagar.msgStatusBar(pPosicao: Integer; msg: string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;

end;

function TfrmManterTituloPagar.obterIndiceLista(pId: string;  lista: TStringList): Integer;
var
  I: Integer;
begin
 Result :=0;

  for I := 0 to lista.Count-1 do begin
    if(lista[I].Equals(pId)) then begin
       Result := I;
       Break;
    end;

  end;

end;

function TfrmManterTituloPagar.obterLoteContabil( value: TLoteContabilModel): TLoteContabilModel;
var
lote :TLoteContabilModel;
begin
 lote := TLoteContabilModel.Create;

 try
   lote := TLoteContabilDAO.obterPorID(value);
 except
 on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' );

 end;


 Result := lote;
end;

function TfrmManterTituloPagar.obterLotePagamento(value: TLotePagamentoModel): TLotePagamentoModel;
var
lote :TLotePagamentoModel;
begin
 lote := TLotePagamentoModel.Create;

 try
   lote := TLotePagamentoDAO.obterPorID(value);
 except
 on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' );
 end;

 Result := lote;
end;

procedure TfrmManterTituloPagar.retiraOrdemCampo(Form: TForm);
var
  I: Integer;
begin
  for I := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[I].ClassType = TEdit then
      if not (TEdit(Form.Components[I]).Enabled) then
      begin
        TEdit(Form.Components[I]).TabOrder := 1000 ;
      end;
  end;
end;


function TfrmManterTituloPagar.validarForm(Form :TForm ) : Boolean;
var
I :Integer;
begin
 Result := True;
  bloqueiaCampos(Self, True);

  for I := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[I].ClassType = TEdit then
      if (TEdit(Form.Components[I]).Text = '') and (TEdit(Form.Components[I]).Tag = 1) then
      begin
        Result := False;
        TEdit(Form.Components[I]).Enabled := True;
        TEdit(Form.Components[I]).SetFocus;
        TEdit(Form.Components[I]).TextHint := 'Campo Obrigat�rio';
      end;


  end;

  if frameCedente1.cbbcombo.ItemIndex > 0  then begin
       if uutil.Empty( cedenteModel.FIDcontaContabil ) then        
        Result := False;
        frameCedente1.cbbcombo.Enabled := True;
        frameCedente1.cbbcombo.SetFocus;
  end;


  if frameCedente1.cbbcombo.ItemIndex < 1 then begin

        Result := False;
        frameCedente1.cbbcombo.Enabled := True;
        frameCedente1.cbbcombo.SetFocus;
  end;

  if frameHistorico1.cbbcombo.ItemIndex < 1 then begin
        Result := False;
        frameHistorico1.cbbcombo.Enabled := True;
        frameHistorico1.cbbcombo.SetFocus;
  end;

   if frameCentroCusto1.cbbcombo.ItemIndex < 1 then begin
        Result := False;
        frameCentroCusto1.cbbcombo.Enabled := True;
        frameCentroCusto1.cbbcombo.SetFocus;
  end;

   if frameResponsavel1.cbbcombo.ItemIndex < 1 then begin
        Result := False;
        frameResponsavel1.cbbcombo.Enabled := True;
        frameResponsavel1.cbbcombo.SetFocus;
  end;

  if frmTipoCobranca1.cbbTipoCobranca.ItemIndex < 1 then begin
        Result := False;
        frmTipoCobranca1.cbbTipoCobranca.Enabled := True;
        frmTipoCobranca1.cbbTipoCobranca.SetFocus;
  end;

   if frmLocalPagto1.cbbcombo.ItemIndex < 1 then begin
        Result := False;
        frmLocalPagto1.cbbcombo.Enabled := True;
        frmLocalPagto1.cbbcombo.SetFocus;
  end;

  if edtCEDConta.Text = 'NC' then
  begin

    msgStatusBar(1, 'Verifique a conta cont�bil do cedente/fornecedor.');
    frameCedente1.cbbcombo.Enabled := True;
    frameCedente1.cbbcombo.SetFocus;
    msg := 'Fornecedor sem conta cont�bil. Favor corrigir o problema. ';
    PempecMsg.MsgInformation(msg);

     // StatusBotoes(0);
    Result := False;
  end;

  if edtValorMainTP.Value = 0  then begin
        Result := False;
        edtValorMainTP.Enabled := True;
        edtValorMainTP.SetFocus;
    msg := 'O valor do t�tulo n�o pode ser 0 ';
    PempecMsg.MsgInformation(msg);



  end;



   bloqueiaCampos(Self, False);

end;




end.



