unit uFrmBaixaTRFP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ENumEd, uUtil, Data.DB,udmConexao,uTRBaixaInternetModel,
  uFrmBaixaTRFPInternet,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, uTRBaixaFPModel, uFormaPagamentoDAO,
  dxSkinsDefaultPainters, FireDAC.Stan.Intf, FireDAC.Stan.Option, uContaBancariaChequeModel,uFrmBaixaTRFPCheque,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  uSacadoModel,uSacadoDAO,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, dxStatusBar, uTituloReceberModel,uTituloReceberDAO,
    uFormaPagamentoModel,
  Vcl.Grids, Vcl.DBGrids, uFrameFormaPagamento, Vcl.ComCtrls, uFrameGeneric, uTRBaixaDAO, uTRBaixaModel,uTRBaixaChequeModel,
  uFrameResponsavel, dxBarBuiltInMenu,System.Generics.Collections, cxPC, uLoteContabilModel, uLoteContabilDAO,
  uFrameTipoAcrescimo, uTipoAcrescimoModel,  uTipoAcrescimoDAO , uTRBaixaACModel,uFrmTituloReceberClone,
  uTituloReceberHistoricoDAO,uTituloReceberCentroCustoDAO,
  uTRBaixaDEModel , uTipoDeducaoModel,  uTipoDeducaoDAO, FireDAC.Stan.Async,
uTituloReceberHistoricoModel, uTituloReceberCentroCustoModel,
  FireDAC.DApt, uFrameTipoDeducao, EMsgDlg, MDDAO, MDModel ;


type
  TfrmBaixaTRFP = class(TForm)
    frmFormaPagto1: TfrmFormaPagto;
    edtValorPago: TEvNumEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    btnSelect: TButton;
    dbgrdFP: TDBGrid;
    dxStatusBar: TdxStatusBar;
    fdmFP: TFDMemTable;
    dsGridFP: TDataSource;
    btnDin: TButton;
    btnCheque: TButton;
    btnWEB: TButton;
    btnLimpar: TButton;
    btnCancelar: TButton;
    edtDoc: TEdit;
    cbbTipoPagto: TComboBox;
    edtDescricao: TEdit;
    edtVcto: TEdit;
    edtParcela: TEdit;
    edtValotTR: TEvNumEdit;
    edtSacado: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    dtpPagto: TDateTimePicker;
    lbl10: TLabel;
    frameResponsavel1: TframeResponsavel;
    edtCNPJ: TEdit;
    lbl11: TLabel;
    cxpgcntrlFP: TcxPageControl;
    tbTransfereFP: TcxTabSheet;
    tbTransfereAC: TcxTabSheet;
    tbTransfereDE: TcxTabSheet;
    btnPagamento: TButton;
    edtValorAC: TEvNumEdit;
    dbgrdAC: TDBGrid;
    dsGridAC: TDataSource;
    fdmAC: TFDMemTable;
    btnSelectTAC: TButton;
    btnLimparAC: TButton;
    dbgrdTAC: TDBGrid;
    dsGridTA: TDataSource;
    qryTodosTAC: TFDQuery;
    frameTipoDeducao1: TframeTipoDeducao;
    frameTipoAcrescimo1: TframeTipoAcrescimo;
    edtValorDE: TEvNumEdit;
    btnSelectTDE: TButton;
    fdmDE: TFDMemTable;
    dsGridDE: TDataSource;
    dbgrdDE: TDBGrid;
    dsGridTDE: TDataSource;
    qryTodosTDE: TFDQuery;
    dbgrdTDE: TDBGrid;
    btnLimpaListaDE: TButton;
    PempecMsg: TEvMsgDlg;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectClick(Sender: TObject);
    procedure btnDinClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnChequeClick(Sender: TObject);
    procedure btnWEBClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure cbbTipoPagtoChange(Sender: TObject);
    procedure frameResponsavel1cbbcomboChange(Sender: TObject);
    procedure dtpPagtoChange(Sender: TObject);
    procedure tbTransfereFPShow(Sender: TObject);
    procedure btnPagamentoClick(Sender: TObject);
    procedure btnSelectTACClick(Sender: TObject);
    procedure btnLimparACClick(Sender: TObject);
    procedure btnSelectTDEClick(Sender: TObject);
    procedure btnLimpaListaDEClick(Sender: TObject);
    procedure tbTransfereACShow(Sender: TObject);
    procedure tbTransfereDEShow(Sender: TObject);

  private
    { Private declarations }

    baixaModel  :TTRBaixaModel;
    FSListaIDResp, FSListaIDFP :TStringList;
    FSListaIDTAC, FSListaIDTDE :TStringList;
    pIdOrganizacao :string;
    valorDevido :Currency;
    totalFP, totalAC, totalDE : Currency;
    cheque : TContaBancariaChequeModel;
    tituloReceber :TTituloReceberModel;
    //FListaFormasPagto: TObjectList<TTRBaixaFPModel>;
    lote : TLoteContabilModel;
    msg :string;
    procedure createTable;
    procedure removeFP(pIndice :Integer);
    function  obterValorPago: Currency;
    procedure validarValor;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpar;
    procedure limparForm;
    procedure preencheForm(var pTP :TTituloReceberModel);
    procedure limparAba(aba: TcxTabSheet);
    procedure atualizaValoPagar;
    function baixarTitulo(pBaixa: TTRBaixaModel): Boolean;
    function  obterLoteContabil(pLote : TLoteContabilModel) : TLoteContabilModel;
    procedure carregarCombos;
    procedure insertClone(clone: TTituloReceberModel);
    function atualizaParcela (pParcela :string; qtd :Integer) : string;


  public
    { Public declarations }
  constructor Create (AOwner :TComponent; var pTitulo :TTituloReceberModel);
  end;
var
  frmBaixaTRFP :TfrmBaixaTRFP ;

implementation

{$R *.dfm}

{ TfrmBaixaFP2 }

procedure TfrmBaixaTRFP.btnCancelarClick(Sender: TObject);
var
isFecha : Boolean;
begin

isFecha := True;

  if uutil.Empty(tituloReceber.FregistroProvisao) then
  begin
   isFecha := False;
    msg := 'Se o t�tulo n�o for baixado, ser� automaticamente provisionado. Deseja cancelar o reebimento? ';
   if PempecMsg.MsgConfirmation(msg) = 6 then
    begin
      tituloReceber := TTituloReceberDAO.obterPorID(tituloReceber);
      tituloReceber.FregistroProvisao := tituloReceber.FID;
      tituloReceber.FisProvisao := 1;
      tituloReceber.FdataEmissao := Now;
      tituloReceber.FdataRegistro := Now;
      tituloReceber.FdataProtocolo := Now;
      tituloReceber.FdataVencimento := dtpPagto.Date;

      if dtpPagto.DateTime < Now then begin
        tituloReceber.FdataVencimento := Now;
      end;

      TTituloReceberDAO.Update(tituloReceber);
      isFecha := True;
    end;

  end;

 if isFecha then begin
      btnLimpar.Click;
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
 end;

end;

procedure TfrmBaixaTRFP.btnChequeClick(Sender: TObject);
var
 posicao, I: Integer;
begin
      posicao := 0;

      for I := 0 to FSListaIDFP.Count - 1 do
      begin
        if FSListaIDFP[I].Equals('CHEQUE') then
        begin
          posicao := I;
          Break;
        end;
      end;

      frmFormaPagto1.cbbcombo.ItemIndex := posicao;
      btnSelect.Click;
      btnCheque.Enabled := False;

end;

procedure TfrmBaixaTRFP.btnDinClick(Sender: TObject);
var
 posicao, I: Integer;
begin
      posicao := 0;

      for I := 0 to FSListaIDFP.Count - 1 do
      begin
        if FSListaIDFP[I].Equals('ESPECIE') then
        begin
          posicao := I;
          Break;
        end;
      end;

      frmFormaPagto1.cbbcombo.ItemIndex := posicao;
      btnSelect.Click;
      btnDin.Enabled := False;

end;

procedure TfrmBaixaTRFP.btnLimpaListaDEClick(Sender: TObject);
begin
  edtValorDE.Value := 0;
  frameTipoDeducao1.cbbcombo.ItemIndex := 0;

  fdmDE.Open;
  fdmDE.First;
  while not fdmDE.Eof do
  begin
    fdmDE.Delete;
    fdmDE.Next;
  end;

  baixaModel.listaDeducao.Clear;

  dbgrdDE.Refresh;
  valorDevido := valorDevido - totalDE;
   msgStatusBar(2, 'Total de dedu��es');
   msgStatusBar(3, formatfloat('R$ ,0.00', (totalDE)));
  totalDE :=0;

  atualizaValoPagar;

end;

procedure TfrmBaixaTRFP.btnLimparACClick(Sender: TObject);
begin
  edtValorAC.Value := 0;
  frameTipoAcrescimo1.cbbcombo.ItemIndex := 0;

  fdmAC.Open;
  fdmAC.First;
  while not fdmAC.Eof do
  begin
    fdmAC.Delete;
    fdmAC.Next;
  end;
  baixaModel.listaAcrescimo.Clear;

  dbgrdAC.Refresh;
  valorDevido := valorDevido - totalAC;
  msgStatusBar(2, 'Total de acr�scimos');
  msgStatusBar(3, formatfloat('R$ ,0.00', (totalAC)));

  totalAC := 0;

  atualizaValoPagar;

end;


procedure TfrmBaixaTRFP.btnLimparClick(Sender: TObject);
begin
 limpar;

end;

procedure TfrmBaixaTRFP.btnPagamentoClick(Sender: TObject);
var
tituloClone :TTituloReceberModel;
qtdRateioC, qtdRateioH, I :Integer;

listaHistorico  : TObjectList<TTituloReceberHistoricoModel>;
listaCustos     : TObjectList<TTituloReceberCentroCustoModel>;
historico       : TTituloReceberHistoricoModel  ;
centroCusto     : TTituloReceberCentroCustoModel;
sucesso : Boolean;
 begin


 sucesso := True;
  try

   if baixaModel.FtipoBaixa.Equals('PARCIAL') then begin
    //clonar titulo com o novo

      tituloClone :=  TTituloReceberModel.Create;
      tituloClone.FID               := tituloReceber.FID;
      tituloClone.FIDorganizacao    := tituloReceber.FIDorganizacao;
      tituloClone.FvalorNominal     := (tituloReceber.FvalorNominal - totalFP);
      tituloClone.FvalorAntecipado  := totalFP + tituloReceber.FvalorAntecipado;


      frmTituloReceberClone := TFrmTituloReceberClone.Create(Self, tituloClone);
      frmTituloReceberClone.ShowModal;
      tituloClone := frmTituloReceberClone.getTitulo;
      tituloReceber.FvalorNominal := baixaModel.FvalorPago;

      try
      insertClone(tituloClone);
      except
      sucesso := False;
      raise Exception.Create('Erro ao tentar inserir o titulo clonado');
      end;

       tituloReceber.FvalorNominal := baixaModel.FvalorPago;

      qtdRateioH := tituloReceber.listaHistorico.Count;
      qtdRateioC := tituloReceber.listaCustos.Count;

      for I := 0 to qtdRateioH - 1 do
      begin

        historico := TTituloReceberHistoricoModel.Create;
        historico.FID := dmConexao.obterNewID;
        historico.FIDorganizacao := tituloReceber.listaHistorico[I].FIDorganizacao;
        historico.FIDHistorico := tituloReceber.listaHistorico[I].FIDHistorico;
        historico.FIDContaContabilDebito := tituloReceber.listaHistorico[I].FIDContaContabilDebito;
        historico.FIDTR := tituloReceber.FID;
        historico.Fvalor := tituloReceber.FvalorNominal;

        tituloReceber.listaHistorico.Clear;
        tituloReceber.AdicionarHST(historico);

      end;

      for I := 0 to qtdRateioC - 1 do
      begin

        centroCusto := TTituloReceberCentroCustoModel.Create;

        centroCusto.FID := dmConexao.obterNewID;
        centroCusto.FIDorganizacao := tituloReceber.listaCustos[I].FIDorganizacao;
        centroCusto.FIDCentroCusto := tituloReceber.listaCustos[I].FIDCentroCusto;
        centroCusto.FIDTR := tituloReceber.FID;
        centroCusto.Fvalor := tituloReceber.FvalorNominal;


        tituloReceber.listaCustos.Clear;
        tituloReceber.AdicionarCC(centroCusto);

      end;


    end;

   if baixaModel.FtipoBaixa.Equals('TOTAL') then begin
    if baixaModel.FvalorPago <> valorDevido then
    begin
     sucesso := False;
     msg := 'Valor recebido est� diferente do valor devido. Verifique!';
     PempecMsg.MsgInformation(msg);
    end;

   end;

    try
      if sucesso then
      begin

        if TTRBaixaDAO.salvarBaixa(baixaModel, tituloReceber) then
        begin
          msg := 'Recebimento efetuado com sucesso!';
          PempecMsg.MsgInformation(msg);

          btnLimpar.Click;
          PostMessage(Self.Handle, WM_CLOSE, 0, 0);

        end;
      end;
    except
      on e: Exception do
        ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
    end;

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;



procedure TfrmBaixaTRFP.insertClone(clone :TTituloReceberModel);
begin
 dmConexao.conectarBanco;

  try

  dmConexao.conn.StartTransaction ;

    //insetir o TR

      TTituloReceberDAO.Insert(clone);
   // inserir o historico
   //   TTituloReceberHistoricoDAO.Insert(clone.listaHistorico[0]);
   //  inserir o centro custo
   //   TTituloReceberCentroCustoDAO.Insert(clone.listaCustos[0]);

  dmConexao.conn.CommitRetaining;

  except
  raise Exception.Create('Erro ao tentar clonar um titulo ');

  end;

end;

procedure TfrmBaixaTRFP.btnSelectClick(Sender: TObject);
var
idFormaPagto :string;
baixaCheque  : TTRBaixaChequeModel;
baixaWWW      :TTRBaixaInternetModel;
baixaFP      : TTRBaixaFPModel;
formaPagto   : TFormaPagamentoModel;

begin
   tbTransfereAC.Enabled := False;
   tbTransfereDE.Enabled := False;

   tituloReceber.FdataPagamento := dtpPagto.DateTime;

 if frmFormaPagto1.cbbcombo.ItemIndex >0 then begin
    idFormaPagto := FSListaIDFP[frmFormaPagto1.cbbcombo.ItemIndex];

    if idFormaPagto.Equals('CHEQUE') then
    begin

     formaPagto := TFormaPagamentoModel.Create;
     formaPagto.FID := idFormaPagto;
     formaPagto.FIDorganizacao := pIdOrganizacao;
     formaPagto := TFormaPagamentoDAO.obterPorID(formaPagto);

      // TITULO_RECEBER_BAIXA_CHEQUE
      baixaCheque                := TTRBaixaChequeModel.Create;
      baixaCheque.FID            := dmConexao.obterNewID;
      baixaCheque.FIDorganizacao := pIdOrganizacao;
      baixaCheque.Fvalor         := edtValorPago.Value;
     // baixaCheque.fidt

      frmBaixaTRFPCheque := TfrmBaixaTRFPCheque.Create(Self, baixaCheque);
      frmBaixaTRFPCheque.ShowModal;

      if not uutil.Empty(frmBaixaTRFPCheque.getCheque.FID) then
      begin

        baixaCheque := frmBaixaTRFPCheque.getCheque;
        baixaCheque.FIDTRBaixa := baixaModel.FID;

        if baixaCheque.Fvalor > 0 then
        begin
          fdmFP.Open;
          fdmFP.InsertRecord([frmFormaPagto1.cbbcombo.Text + ' ' + baixaCheque.FnumeroCheque, edtValorPago.Value]);
        end;




     // TITULO_RECEBER_BAIXA_FP
        baixaFP := TTRBaixaFPModel.Create;
        baixaFP.FID := dmConexao.obterNewID;
        baixaFP.FIDorganizacao := pIdOrganizacao;
        baixaFP.FFormaPagamento := formaPagto;
        baixaFP.FValor := baixaCheque.Fvalor;
        baixaFP.FIDTRBaixa := baixaModel.FID;

        totalFP := totalFP + baixaFP.FValor;

        baixaModel.AdicionarFP(baixaFP); //coloca esse pagto dentro do model de baixa
        baixaModel.FTRBaixaCheque := baixaCheque;   //seta o cheque na baixa

      end;

    end;


    if idFormaPagto.Equals('ESPECIE') then
    begin

     formaPagto := TFormaPagamentoModel.Create;
     formaPagto.FID := idFormaPagto;
     formaPagto.FIDorganizacao := pIdOrganizacao;
     formaPagto := TFormaPagamentoDAO.obterPorID(formaPagto);

      fdmFP.Open;
      fdmFP.InsertRecord([frmFormaPagto1.cbbcombo.Text ,  edtValorPago.Value]);

     // TITULO_RECEBER_BAIXA_FP
     baixaFP := TTRBaixaFPModel.Create;
     baixaFP.FID := dmConexao.obterNewID;
     baixaFP.FIDorganizacao := pIdOrganizacao;
     baixaFP.FFormaPagamento := formaPagto;
     baixaFP.FValor := edtValorPago.Value; //ver isso
     baixaFP.FIDTRBaixa := baixaModel.FID;

     totalFP := totalFP + baixaFP.FValor;

     baixaModel.AdicionarFP(baixaFP); //coloca esse pagto dentro do model de baixa

    end;

    if idFormaPagto.Equals('INTERNET BANK') then
    begin

     formaPagto := TFormaPagamentoModel.Create;
     formaPagto.FID := idFormaPagto;
     formaPagto.FIDorganizacao := pIdOrganizacao;
     formaPagto := TFormaPagamentoDAO.obterPorID(formaPagto);

     baixaWWW                       := TTRBaixaInternetModel.Create;
     baixaWWW.FIDorganizacao        := pIdOrganizacao;
     baixaWWW.FID                   := dmConexao.obterNewID;
     baixaWWW.Fvalor                := edtValorPago.Value;
     baixaWWW.FIDTRB                := baixaModel.FID;
     baixaWWW.Fdetalhamento         := 'RCBTO TR ' + tituloReceber.FnumeroDocumento ;
     baixaWWW.FdataOperacao         := dtpPagto.DateTime;

      frmBaixaTRFPInternet := TfrmBaixaTRFPInternet.Create(Self, baixaWWW);
      frmBaixaTRFPInternet.ShowModal;
      baixaWWW := frmBaixaTRFPInternet.getBaixaWWW;

      if baixaWWW.Fvalor > 0 then
      begin
        fdmFP.Open;
        fdmFP.InsertRecord([frmFormaPagto1.cbbcombo.Text, edtValorPago.Value]);
      end;

     // TITULO_RECEBER_BAIXA_FP
     baixaFP := TTRBaixaFPModel.Create;
     baixaFP.FID := dmConexao.obterNewID;
     baixaFP.FIDorganizacao := pIdOrganizacao;
     baixaFP.FFormaPagamento := formaPagto;
     baixaFP.FValor := edtValorPago.Value; //ver isso
     baixaFP.FIDTRBaixa := baixaModel.FID;

     totalFP := totalFP + baixaFP.FValor;

     baixaModel.AdicionarFP(baixaFP); //coloca esse pagto dentro do model de baixa
     baixaModel.FTRBaixaWWW := baixaWWW;

    end;

  //  fdmFP.InsertRecord([frmFormaPagto1.cbbcombo.Text,edtValor.Value]);
//    frmFormaPagto1.cbbcombo.DeleteSelected;
    dbgrdFP.Refresh;
    msgStatusBar(3, formatfloat('R$ ,0.00', (valorDevido)));
    msgStatusBar(3, formatfloat('R$ ,0.00', (obterValorPago)));
    frmFormaPagto1.cbbcombo.ItemIndex := 0;
    edtValorPago.Clear;
    Application.ProcessMessages;

    edtValorPago.Value := ( valorDevido - obterValorPago );

    if obterValorPago = valorDevido then begin

      frmFormaPagto1.cbbcombo.Enabled :=False;
      btnDin.Enabled :=False;
      btnWEB.Enabled :=False;
      btnCheque.Enabled :=False;
      edtValorPago.Enabled :=False;

    end;


     //TPBAIXA
   baixaModel.FvalorPago := totalFP; // ver se est� pegando valor principal + ac + de



 end;

end;

procedure TfrmBaixaTRFP.btnSelectTACClick(Sender: TObject);
var
tipoAC : TTipoAcrescimoModel;
tpBaixaAC : TTRBaixaACModel;

begin

 if frameTipoAcrescimo1.cbbcombo.ItemIndex >0 then begin

 if edtValorAC.Value > 0 then begin

   totalAC := totalAC + edtValorAC.Value;

   tipoAC := TTipoAcrescimoModel.Create;
   tipoAC.FIDOrganizacao := pIdOrganizacao;
   tipoAC.FID := frameTipoAcrescimo1.getComboID;
   tipoAC := TTipoAcrescimoDAO.obterPorID(tipoAC);

      begin
        fdmAC.Open;
        fdmAC.InsertRecord([frameTipoAcrescimo1.cbbcombo.Text , edtValorAC.Value]);
      end;


   tpBaixaAC                      := TTRBaixaACModel.Create;
   tpBaixaAC.FID                  := dmConexao.obterNewID;
   tpBaixaAC.FIDOrganizacao       := pIdOrganizacao;
   tpBaixaAC.FIDtipoAcrescimo     := tipoAC.FID;
   tpBaixaAC.FIDtituloReceberBaixa  := baixaModel.FID;
   tpBaixaAC.Fvalor               := edtValorAC.Value;
   tpBaixaAC.FtipoAcrescimo       := tipoAC;

   baixaModel.AdicionarAC(tpBaixaAC);

      dbgrdAC.Refresh;
      msgStatusBar(2, 'Total de acr�scimos');
      msgStatusBar(3, formatfloat('R$ ,0.00', (totalAC)));

      valorDevido := valorDevido + edtValorAC.Value;
      msgStatusBar(1, formatfloat('R$ ,0.00', (valorDevido)));
      frameTipoAcrescimo1.cbbcombo.ItemIndex := 0;
      edtValorAC.Clear;
      Application.ProcessMessages;

 end;

 end else begin  msgStatusBar(3,' Selecione um tipo acr�scimo ou cancele a op��o'); end;

end;

procedure TfrmBaixaTRFP.btnSelectTDEClick(Sender: TObject);
var
tipoDE : TTipoDeducaoModel;
tpBaixaDE : TTRBaixaDEModel;

begin

 if frameTipoDeducao1.cbbcombo.ItemIndex >0 then begin

 if edtValorDE.Value > 0 then begin
        totalDE := totalDE + edtValorDE.Value;

        tipoDE := TTipoDeducaoModel.Create;
        tipoDE.FIDOrganizacao := pIdOrganizacao;
        tipoDE.FID := frameTipoDeducao1.getComboID;
        tipoDE := TTipoDeducaoDAO.obterPorID(tipoDE);

        begin
          fdmDE.Open;
          fdmDE.InsertRecord([frameTipoDeducao1.cbbcombo.Text, edtValorDE.Value]);
        end;

         tpBaixaDE                      := TTRBaixaDEModel.Create;
         tpBaixaDE.FID                  := dmConexao.obterNewID;
         tpBaixaDE.FIDOrganizacao       := pIdOrganizacao;
         tpBaixaDE.FIDtipoDeducao       := tipoDE.FID;
         tpBaixaDE.FIDtituloReceberBaixa  := baixaModel.FID;
         tpBaixaDE.Fvalor               := edtValorDE.Value;
         tpBaixaDE.FtipoDeducao         := tipoDE;

        baixaModel.AdicionarDE(tpBaixaDE);

        dbgrdDE.Refresh;

        msgStatusBar(2, 'Total de dedu��es');
        msgStatusBar(3, formatfloat('R$ ,0.00', (totalDE)));

        valorDevido := valorDevido - edtValorDE.Value;
        msgStatusBar(1, formatfloat('R$ ,0.00', (valorDevido)));
        frameTipoDeducao1.cbbcombo.ItemIndex := 0;
        edtValorDE.Clear;
        Application.ProcessMessages;

 end;

 end else begin  msgStatusBar(3,' Selecione um tipo dedu��o ou cancele a op��o'); end;

end;

procedure TfrmBaixaTRFP.btnWEBClick(Sender: TObject);
var
 posicao, I: Integer;
begin
      posicao := 0;

      for I := 0 to FSListaIDFP.Count - 1 do
      begin
        if FSListaIDFP[I].Equals('INTERNET BANK') then
        begin
          posicao := I;
          Break;
        end;
      end;

      frmFormaPagto1.cbbcombo.ItemIndex := posicao;
      btnSelect.Click;
      btnWEB.Enabled := False;


end;

procedure TfrmBaixaTRFP.cbbTipoPagtoChange(Sender: TObject);
begin
 msg := '';
 tituloReceber.FIDTipoStatus := 'QUITADO';

 if cbbTipoPagto.ItemIndex >= 0 then begin

    baixaModel.FTipoBaixa := cbbTipoPagto.Text;
 end;

 if baixaModel.FtipoBaixa.Equals('PARCIAL')  then begin

   tituloReceber.FIDTipoStatus := 'PARCIAL';

 end;

 if not uutil.Empty(tituloReceber.FIDLoteTRB)  then begin

    cbbTipoPagto.ItemIndex := 0;
    msg := 'O t�tulo est� provisionado e foi exportado. O sistema n�o permite pagamento parcial.';
    PempecMsg.MsgInformation(msg);
    tituloReceber.FIDTipoStatus := 'QUITADO';
 end;


 if not uutil.Empty(tituloReceber.FIDLoteContabil)  then begin

   cbbTipoPagto.ItemIndex := 0;
    msg := 'O titulo foi exportado. O sistema n�o permite pagamento parcial.';
    PempecMsg.MsgInformation(msg);

    tituloReceber.FIDTipoStatus := 'QUITADO';
 end;

  if cbbTipoPagto.ItemIndex = 1 then begin
  edtValorPago.Value := 0;
 end else begin edtValorPago.Value := tituloReceber.FvalorNominal; end;


end;

constructor TfrmBaixaTRFP.Create(AOwner: TComponent; var pTitulo :TTituloReceberModel);
begin

 inherited Create(AOwner);
  createTable;
  pIdOrganizacao := uutil.TOrgAtual.getId;

  tituloReceber := TTituloReceberModel.Create;
  tituloReceber := TTituloReceberDAO.obterPorID(pTitulo);

  if uutil.Empty(tituloReceber.FID) then begin

    tituloReceber := pTitulo;
    tituloReceber.FdataPagamento := Now;
    tituloReceber.FdataUltimaAtualizacao := Now;


  end;

  lote := TLoteContabilModel.Create;
  lote.FIDorganizacao := tituloReceber.FIDorganizacao;
  lote.FID := tituloReceber.FIDLoteContabil;
  lote := obterLoteContabil(lote);

  if uutil.Empty(lote.fid) then
  begin
    lote.FIDorganizacao := tituloReceber.FIDorganizacao;
    lote.FID := tituloReceber.FIDLoteTRB;
    lote := obterLoteContabil(lote);

  end;

  if not uUtil.Empty(tituloReceber.FID) then
  begin

    tituloReceber.FdataUltimaAtualizacao := Now;
    tituloReceber.FdataPagamento := Now;
    tituloReceber.FdataUltimaAtualizacao := Now;

    if tituloReceber.FdataRegistro < IncYear(tituloReceber.FdataEmissao, 2) then
    begin
      tituloReceber.FdataRegistro := pTitulo.FdataEmissao;

    end;

  tituloReceber.FIDTipoStatus  := 'QUITADO';



   baixaModel                   := TTRBaixaModel.Create;
   baixaModel.listaFormasPagto  := TObjectList<TTRBaixaFPModel>.Create;
   baixaModel.listaFormasPagto.Clear;

   baixaModel.listaAcrescimo    := TObjectList<TTRBaixaACModel>.Create;
   baixaModel.listaAcrescimo.Clear;
   baixaModel.listaDeducao      := TObjectList<TTRBaixaDEModel>.Create;
   baixaModel.listaDeducao.Clear;

   baixaModel.FID            := dmConexao.obterNewID;
   baixaModel.FIDorganizacao := pIdOrganizacao;
   baixaModel.FTituloReceber   := tituloReceber;
   baixaModel.FIDtituloReceber := tituloReceber.FID;
   baixaModel.FIDCentroCusto := tituloReceber.FIDCentroCusto;
   baixaModel.FIDusuario     := uutil.TUserAtual.getUserId;
   baixaModel.FTipoBaixa     := 'TOTAL';

   preencheForm(tituloReceber);

//   inicializaRegistro;

  end;

  msgStatusBar(1,formatfloat('R$ ,0.00', (tituloReceber.FvalorNominal)));
  edtValorPago.MinValue := 0.1;
  edtValorPago.MaxValue := tituloReceber.FvalorNominal;
  valorDevido := tituloReceber.FvalorNominal ;

  carregarCombos;


  edtValorPago.Value := (valorDevido);


  cbbTipoPagto.ItemIndex := 0;
  totalAC :=0;
  totalFP :=0;
  totalDE :=0;



end;

function  TfrmBaixaTRFP.obterLoteContabil(pLote : TLoteContabilModel) : TLoteContabilModel;
begin
 lote := TLoteContabilModel.Create;

 lote := TLoteContabilDAO.obterPorMes(pLote);

 Result := lote;

end;

procedure TfrmBaixaTRFP.preencheForm(var pTP :TTituloReceberModel);
var
sacado :TSacadoModel;
qtdDateio : Integer;
begin
  qtdDateio := 0;

  sacado                := TSacadoModel.Create;
  sacado.FIDorganizacao := pTP.FIDorganizacao;
  sacado.FID            := pTP.FIDSacado;
  sacado                := TSacadoDAO.obterPorID(sacado);


  edtValotTr.Value  := pTP.FvalorNominal;
  edtDoc.Text       := pTP.FnumeroDocumento;
  edtDescricao.Text := pTP.Fdescricao;
  edtVcto.Text      := DateToStr(pTP.FdataVencimento);
  edtParcela.Text   := pTP.Fparcela;
  edtSacado.Text    := sacado.Fnome;
  edtCNPJ.Text      := sacado.FcpfCnpj;
  dtpPagto.DateTime := pTP.FdataPagamento;

  qtdDateio :=  pTP.listaHistorico.Count;

  if qtdDateio = 1  then begin
    qtdDateio :=  pTP.listaCustos.Count;
  end;

  if qtdDateio > 1 then begin

    cbbTipoPagto.ItemIndex := 0;
    cbbTipoPagto.Enabled := False;

  end;

   if not uUtil.Empty (lote.FID) then begin

     edtDescricao.Text :=' LOTE CONTABIL ' + lote.Flote;

  end;


end;


procedure TfrmBaixaTRFP.createTable;
begin

    fdmFP.FieldDefs.Add('DESCRICAO', ftString, 60, false);
    fdmFP.FieldDefs.Add('VALOR', ftCurrency, 0, false);
    fdmFP.FieldDefs.Add('ID_FORMA_PAGAMENTO', ftString, 36, false);
    fdmFP.CreateDataSet;


    fdmAC.FieldDefs.Add('DESCRICAO', ftString, 60, false);
    fdmAC.FieldDefs.Add('VALOR', ftCurrency, 0, false);
    fdmAC.FieldDefs.Add('ID_TIPO_ACRESCIMO', ftString, 36, false);
    fdmAC.CreateDataSet;


    fdmDE.FieldDefs.Add('DESCRICAO', ftString, 60, false);
    fdmDE.FieldDefs.Add('VALOR', ftCurrency, 0, false);
    fdmDE.FieldDefs.Add('ID_TIPO_DEDUCAO', ftString, 36, false);
    fdmDE.CreateDataSet;

end;


procedure TfrmBaixaTRFP.dtpPagtoChange(Sender: TObject);
var
  validarData :Integer;
begin

  //se movimento < hoje = -1
  // se movimento > hoje =  1
  validarData := compareDate(dtpPagto.Date, now);

  baixaModel.FdataRegistro := Now;
  tituloReceber.FdataUltimaAtualizacao := Now;
  tituloReceber.FdataPagamento := dtpPagto.Date;
  tituloReceber.FIDTipoStatus  := 'QUITADO';

  if validarData = 1 then
  begin // a data do pagto � maior que a data de hoje
    msg := 'A data do pagamento n�o pode ser maior que a data de hoje.!';
    PempecMsg.MsgInformation(msg);
    msgStatusBar(1, 'Data pagamento incorreta.');
    dtpPagto.Date := Now;
    dtpPagto.SetFocus;
  end else begin
   atualizaValoPagar;
   msgStatusBar(1, CurrToStr(totalFP));
  end;
end;

procedure TfrmBaixaTRFP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;


procedure TfrmBaixaTRFP.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;


procedure TfrmBaixaTRFP.FormCreate(Sender: TObject);
begin

 pIdOrganizacao := uutil.TOrgAtual.getId;

  msgStatusBar(0, 'Valor devido ');
  msgStatusBar(2, 'Valor pago ');


  cxpgcntrlFP.ActivePageIndex :=0;

  tbTransfereFP.Enabled := False;
  tbTransfereAC.Enabled := False;
  tbTransfereDE.Enabled := False;

totalAC :=0;
totalFP :=0;
totalDE :=0;

dtpPagto.DateTime := Now;

cbbTipoPagto.Enabled := False;


end;

procedure TfrmBaixaTRFP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F6  : btnDin.Click;
    VK_F7  : btnCheque.Click;
    VK_F8  : btnWEB.Click;
    VK_F10 : btnPagamento.Click;

  end;
end;

procedure TfrmBaixaTRFP.frameResponsavel1cbbcomboChange(Sender: TObject);
begin
 if frameResponsavel1.cbbcombo.ItemIndex >0 then begin
     baixaModel.FIDResponsavel := FSListaIDResp[frameResponsavel1.cbbcombo.ItemIndex];
     tbTransfereFP.Enabled := True;

   if cbbTipoPagto.ItemIndex = 0 then begin
     tbTransfereAC.Enabled := True;
     tbTransfereDE.Enabled := True;
   end else begin
     tbTransfereAC.Enabled := False;
     tbTransfereDE.Enabled := False;
     msgStatusBar(3, 'Pagamento parcial n�o pode ter dedu��o ou acr�scimo.');
     msg := 'Pagamento parcial n�o pode ter dedu��o ou acr�scimo.';
     PempecMsg.MsgInformation(msg);
   end;
 end;
end;


function TfrmBaixaTRFP.obterValorPago: Currency;
var
total :Currency;
  I: Integer;
begin
 total :=0;
 fdmFP.Open;
 fdmFP.First;
 while not fdmFP.Eof do begin

 total := total + fdmFP.FieldByName('VALOR').AsCurrency;

 fdmFP.Next;
 end;


  Result := total;

end;

procedure TfrmBaixaTRFP.removeFP(pIndice: Integer);
begin
if pIndice >0 then begin
     frmFormaPagto1.cbbcombo.DeleteSelected ;
 end;

end;

procedure TfrmBaixaTRFP.tbTransfereACShow(Sender: TObject);
begin
 msgStatusBar(2, 'Total de acr�scimos');
 msgStatusBar(3, formatfloat('R$ ,0.00', (totalAC)));

end;

procedure TfrmBaixaTRFP.tbTransfereDEShow(Sender: TObject);
begin
      msgStatusBar(2, 'Total de dedu��es');
      msgStatusBar(3, formatfloat('R$ ,0.00', (totalDE)));
end;

procedure TfrmBaixaTRFP.tbTransfereFPShow(Sender: TObject);
begin
   atualizaValoPagar;
   msgStatusBar(2, 'Valor pago ');
   msgStatusBar(3, '0');
end;

function TfrmBaixaTRFP.atualizaParcela(pParcela: string; qtd :Integer): string;
var parcela :string;
auxParcela :Integer;
begin

  auxParcela := StrToInt(uutil.SoNumeros(pParcela));


 //parcela pode vir 1 ou pode x/x
  if qtd = 0 then begin // atualiza o tp principal

  if pParcela.Equals('1') then begin
   //  parcela := '1/' + intoToStr(qtd);
  end;

  end;

  if qtd > 0 then
  begin // atualiza o tp clonado
    if pParcela.Equals('1') then
    begin
      parcela := IntToStr(qtd) + '/' + IntToStr(qtd + 1);
    end;

    parcela := IntToStr(qtd) + '/' + IntToStr(auxParcela + 1);

  end;

  Result := parcela;
end;

procedure TfrmBaixaTRFP.atualizaValoPagar;
begin

edtValorPago.Value := (edtValotTR.Value +  totalAC) - totalDE;
msgStatusBar(1, formatfloat('R$ ,0.00', (valorDevido)));

end;

procedure TfrmBaixaTRFP.validarValor;
begin
  btnSelect.Enabled := False;
  frmFormaPagto1.Enabled := False;
  edtValorPago.Enabled := False;

  if obterValorPago < valorDevido then
  begin

    btnSelect.Enabled := True;
    frmFormaPagto1.Enabled := True;
    edtValorPago.Enabled := True;
  end;

end;


procedure TfrmBaixaTRFP.carregarCombos;
begin

  frameTipoAcrescimo1.obterTodos(pIdOrganizacao, frameTipoAcrescimo1.cbbcombo, FSListaIDTAC);
  frameTipoAcrescimo1.cbbcombo.Enabled := True;

  frameTipoDeducao1.obterTodos(pIdOrganizacao, frameTipoDeducao1.cbbcombo, FSListaIDTDE);
  frameTipoDeducao1.cbbcombo.Enabled := True;

  frmFormaPagto1.obterTodos(pIdOrganizacao, frmFormaPagto1.cbbcombo, FSListaIDFP);
  frmFormaPagto1.cbbcombo.Enabled := True;

  frameResponsavel1.obterTodosAtivos(pIdOrganizacao, frameResponsavel1.cbbcombo, FSListaIDResp);


  dbgrdTAC.DataSource.DataSet  := frameTipoAcrescimo1.preencheDBGrid(pIdOrganizacao);
  dbgrdTDE.DataSource.DataSet  := frameTipoDeducao1.preencheDBGrid(pIdOrganizacao);


end;


procedure TfrmBaixaTRFP.limpar;
begin
     totalFP :=0;
     totalAC :=0;
     totalDE :=0;

   baixaModel.listaFormasPagto.Clear;
   tbTransfereAC.Enabled := True;
   tbTransfereDE.Enabled := True;

  fdmFP.Open;
  fdmFP.First;
  while not fdmFP.Eof do
  begin
    fdmFP.Delete;
    fdmFP.Next;
  end;

  dbgrdFP.DataSource.DataSet.Close;
  dbgrdFP.Refresh;
  btnDin.Enabled := True;
  btnCheque.Enabled := True;
  btnWEB.Enabled := True;
  msgStatusBar(3, '0');
  carregarCombos;

  edtValorPago.Value := (valorDevido);
  msgStatusBar(0, 'Valor devido ');
  msgStatusBar(2, 'Valor pago ');

  cbbTipoPagto.ItemIndex := 0;

  Application.ProcessMessages;
  validarValor;

end;

procedure TfrmBaixaTRFP.limparForm;
var
 i: Integer;
begin


  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TCustomEdit then
    begin
         (Components[i] as TCustomEdit).Clear;
    end;

    if Components[i] is TEdit then
    begin
         TEdit(Components[i]).Clear;
    end;

     if Components[i] is TComboBox then
    begin
       TComboBox(Components[i]).ItemIndex := 0;
    end;

   end;


end;

procedure TfrmBaixaTRFP.limparAba(aba :TcxTabSheet );
var
 j, i: Integer;
begin
 // limpa os componentes da aba q chegou

  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TCustomEdit then
    begin
       if TCustomEdit(Components[i]).Parent = aba then
         (Components[i] as TCustomEdit).Clear;
    end;

    if Components[i] is TEdit then
    begin
      if TEdit(Components[i]).Parent = aba then
         TEdit(Components[i]).Clear;
    end;

     if Components[i] is TComboBox then
    begin
       TComboBox(Components[i]).ItemIndex := 0;
    if TComboBox(Components[i]).Parent = aba then
      // TComboBox(Components[i]).Clear;
      TComboBox(Components[i]).ItemIndex := 0;
    end;

   end;


end;

function TfrmBaixaTRFP.baixarTitulo( pBaixa :TTRBaixaModel) : Boolean;
var
qtdFP :Integer;
 begin
 dmConexao.conectarBanco;
  qtdFP :=0; //indica apenas a quantidade de formas de pagamentos do tp
  qtdFP := pBaixa.listaFormasPagto.Count ;


  try
    dmConexao.conn.StartTransaction;

    //falta list a de AC e lista de DE


    { baixa de TR pago em cheque
    1 - altera o TP (DATA_ULTIMA_ATUALIZACAO, DATA_PAGAMENTO)
    2 - salva o TPB
    3 - salva o TPB_FP
    4 - salva o TPB_Cheque
    5 - altera o cheque ( ID_TIPO_STATUS, VALOR, DATA_EMISSAO, OBSERVACAO,PORTADOR,  DATA_PREVISAO_COMPENSACAO, QTD_IMPRESSAO )
    6 - salvar CBD
    }

    if not uutil.Empty(pBaixa.FID) then begin //o TP tem  pagto em cheque

       TTRBaixaDAO.salvarBaixa(pBaixa, tituloReceber);

        Inc(qtdFP);

    end;





    dmConexao.conn.CommitRetaining;

  except
    Result := False;
    dmConexao.conn.RollbackRetaining;

    raise Exception.Create('Erro ao tentar baixar o titulo : ' + pBaixa.FTituloReceber.FnumeroDocumento);

  end;

    Result := True;

 end;



end.
