unit uFrmExtratoBancario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.DateUtils,
  System.Classes, Vcl.Graphics, uDMExtratoBancario, uUtil, udmConexao, uDMOrganizacao,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFramePeriodo, uFrameContaBancaria, MDDAO,
  uContaBancariaModel, uContaBancariaDAO, uContaBancariaCRModel, uContaBancariaCreditoDAO,uContaBancariaDBModel, uContaBancariaDebitoDAO,
  Vcl.StdCtrls, frxClass, frxDBSet, frxExportCSV, frxExportPDF, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, frxExportBaseDialog, EMsgDlg, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, dxStatusBar, dxRibbonSkins, dxRibbonCustomizationForm,
  cxClasses, dxRibbon, dxBar, cxCalendar, cxBarEditItem, cxCheckBox;

type
  TfrmExtratoBancario = class(TForm)
    frmContaBancaria1: TfrmContaBancaria;
    frmPeriodo1: TfrmPeriodo;
    frxExtratoBancario: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    frxCSVExport1: TfrxCSVExport;
    frxExtrato: TfrxDBDataset;
    PempecMsg: TEvMsgDlg;
    dxStatusBar: TdxStatusBar;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dtInicial: TcxBarEditItem;
    dtFinal: TcxBarEditItem;
    dxBtnConsulta: TdxBarButton;
    dxBarManager1Bar2: TdxBar;
    chkTipo: TcxBarEditItem;
    chkCheque: TcxBarEditItem;
    cxBarEditItem1: TcxBarEditItem;
    dxBarSubItem1: TdxBarSubItem;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar3: TdxBar;
    dxBtnImprimir: TdxBarLargeButton;
    dxBtnFechar: TdxBarLargeButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure frmContaBancaria1cbbContaChange(Sender: TObject);
    procedure frmPeriodo1dtpDataInicialChange(Sender: TObject);
    procedure frmPeriodo1dtpDataFinalChange(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure dxBtnFecharClick(Sender: TObject);
    procedure dxBtnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    FsListaIdContas : TStringList;
    idConta, idOrganizacao :string;
    saldoAnteriorRelatorio :Currency;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure limpaPanel();
     function retornarCaminhoRelatorio: string;
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    procedure exibirRelatorio(dtInicial, dtFinal: TDate);
    function obterSaldoAnterior(pIdOrganizacao, pIDConta: string; pDataInicial,
      pDataFinal: TDate): Currency;
    procedure registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;



    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmExtratoBancario: TfrmExtratoBancario;

implementation

{$R *.dfm}


procedure TfrmExtratoBancario.btnFecharClick(Sender: TObject);
begin
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmExtratoBancario.btnImprimirClick(Sender: TObject);
var vlrSaldoAnterior, vlrCr, vlrDb : Currency;
pDataInicial, pDataFinal :TDate;
liberaRelatorio : Integer;
descConta,tipoSaldo :String;
contaBancaria : TContaBancariaModel;
begin
   liberaRelatorio :=0;
   tipoSaldo :='D';

  if frmPeriodo1.validarPeriodo then begin
      //   pDataInicial :=  StrToDate('01/01/1990');
       //  pDataFinal   := IncDay(frmPeriodo1.getDataInicial, -1); //pega o saldo at� o dia de ontem

         pDataInicial := frmPeriodo1.getDataInicial;
         pDataFinal   := frmPeriodo1.getDataFinal ;



     if frmContaBancaria1.cbbConta.ItemIndex >0  then begin
       idConta := FsListaIdContas[frmContaBancaria1.cbbConta.ItemIndex];
       contaBancaria := TContaBancariaModel.Create;
       contaBancaria.FIDorganizacao := idOrganizacao;
       contaBancaria.FID := idConta;
       contaBancaria := TContaBancariaDAO.obterPorID(contaBancaria);

       registraMovimentacao(idOrganizacao, 'CONTA_BANCARIA', 'EXTRATO BANCARIO', uutil.TUserAtual.getNameUser + ' solicitou EXTRATO DA CONTA '+ contaBancaria.Fconta  , 'SOLICITADO');


//      descConta := frmContaBancaria1.cbbConta.Items[frmContaBancaria1.cbbConta.ItemIndex];
      descConta := contaBancaria.Fconta;

      vlrSaldoAnterior := obterSaldoAnterior(idOrganizacao, idConta, pDataInicial, pDataFinal);
      liberaRelatorio :=  Trunc(vlrSaldoAnterior);

      if vlrSaldoAnterior > 0 then
      begin
        tipoSaldo := 'C';
      end;



       liberaRelatorio := liberaRelatorio + dmExtratoBancario.obterLancamentosCredito(idOrganizacao,idConta, pDataInicial, pDataFinal);
       liberaRelatorio := liberaRelatorio + dmExtratoBancario.obterLancamentosDebito(idOrganizacao,idConta, pDataInicial, frmPeriodo1.getDataFinal );

       liberaRelatorio := 1; //ver como fazer .. pq nao estava exibindo o relatorio

     end;
  end;

  if ((liberaRelatorio) > 0) then
  begin

   if  dmExtratoBancario.montarTabelaTemp(IncDay(frmPeriodo1.getDataInicial, -1),'SALDO ANTERIOR DA CONTA ' + descConta , tipoSaldo, vlrSaldoAnterior)  then begin
       dmExtratoBancario.qryExtrato.Close;
       dmExtratoBancario.qryExtrato.Open;
       //ver como fazer com procedure


    exibirRelatorio( pDataInicial, pDataFinal);

   end else begin PempecMsg.MsgWarning('N�o foi poss�vel exibir o extrato banc�rio ...'); end;


  end
  else
  begin
    PempecMsg.MsgWarning('N�o existem dados para imprimir.');
  end


end;

procedure TfrmExtratoBancario.dxBtnFecharClick(Sender: TObject);
begin
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmExtratoBancario.dxBtnImprimirClick(Sender: TObject);
var vlrSaldoAnterior, vlrCr, vlrDb : Currency;
pDataInicial, pDataFinal :TDate;
liberaRelatorio : Integer;
descConta,tipoSaldo :String;
contaBancaria : TContaBancariaModel;
begin
   liberaRelatorio :=0;
   tipoSaldo :='D';

  if frmPeriodo1.validarPeriodo then begin
      //   pDataInicial :=  StrToDate('01/01/1990');
       //  pDataFinal   := IncDay(frmPeriodo1.getDataInicial, -1); //pega o saldo at� o dia de ontem

         pDataInicial := frmPeriodo1.getDataInicial;
         pDataFinal   := frmPeriodo1.getDataFinal ;



     if frmContaBancaria1.cbbConta.ItemIndex >0  then begin
       idConta := FsListaIdContas[frmContaBancaria1.cbbConta.ItemIndex];
       contaBancaria := TContaBancariaModel.Create;
       contaBancaria.FIDorganizacao := idOrganizacao;
       contaBancaria.FID := idConta;
       contaBancaria := TContaBancariaDAO.obterPorID(contaBancaria);

       registraMovimentacao(idOrganizacao, 'CONTA_BANCARIA', 'EXTRATO BANCARIO', uutil.TUserAtual.getNameUser + ' solicitou EXTRATO DA CONTA '+ contaBancaria.Fconta  , 'SOLICITADO');


//      descConta := frmContaBancaria1.cbbConta.Items[frmContaBancaria1.cbbConta.ItemIndex];
      descConta := contaBancaria.Fconta;

      vlrSaldoAnterior := obterSaldoAnterior(idOrganizacao, idConta, pDataInicial, pDataFinal);
      liberaRelatorio :=  Trunc(vlrSaldoAnterior);

      if vlrSaldoAnterior > 0 then
      begin
        tipoSaldo := 'C';
      end;



       liberaRelatorio := liberaRelatorio + dmExtratoBancario.obterLancamentosCredito(idOrganizacao,idConta, pDataInicial, pDataFinal);
       liberaRelatorio := liberaRelatorio + dmExtratoBancario.obterLancamentosDebito(idOrganizacao,idConta, pDataInicial, frmPeriodo1.getDataFinal );

       liberaRelatorio := 1; //ver como fazer .. pq nao estava exibindo o relatorio

     end;
  end;

  if ((liberaRelatorio) > 0) then
  begin

   if  dmExtratoBancario.montarTabelaTemp(IncDay(frmPeriodo1.getDataInicial, -1),'SALDO ANTERIOR DA CONTA ' + descConta , tipoSaldo, vlrSaldoAnterior)  then begin
       dmExtratoBancario.qryExtrato.Close;
       dmExtratoBancario.qryExtrato.Open;
       //ver como fazer com procedure
    exibirRelatorio( pDataInicial, pDataFinal);


   end else begin PempecMsg.MsgWarning('N�o foi poss�vel exibir o extrato banc�rio ...'); end;


  end
  else
  begin
    PempecMsg.MsgWarning('N�o existem dados para imprimir.');
  end

end;

procedure TfrmExtratoBancario.exibirRelatorio(dtInicial, dtFinal: TDate);
begin
  frxExtratoBancario.Clear;

  try
    if not (frxExtratoBancario.LoadFromFile(retornarCaminhoRelatorio)) then
    begin
      PempecMsg.MsgError('Relat�rio interno n�o localizado...');
    end
    else
    begin
      inicializarVariaveisRelatorio(dtInicial, dtFinal);
      frxExtratoBancario.OldStyleProgress := True;
      frxExtratoBancario.ShowProgress := True;
      frxExtratoBancario.ShowReport;
    end;

  finally
    FreeAndNil(dmExtratoBancario.qryDeletaTemp);
  end;

 limpaPanel;

end;

procedure TfrmExtratoBancario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freeAndNilDM(Self);
 Action := caFree;
end;

procedure TfrmExtratoBancario.FormCreate(Sender: TObject);
begin
 inicializarDM(Self);
  limpaPanel;
end;

procedure TfrmExtratoBancario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

case key of
//  vk_f2: dxBtnEditar.Click;
 // vk_f4: dxBtnNovo.Click;
  vk_f10: dxBtnImprimir.Click;
end;


end;

procedure TfrmExtratoBancario.freeAndNilDM(Sender: TObject);
begin
 // nada
 if Assigned(dmExtratoBancario) then begin
    FreeAndNil(dmExtratoBancario);
 end;

end;

procedure TfrmExtratoBancario.frmContaBancaria1cbbContaChange(Sender: TObject);
var
idconta :string;
pDataInicial, pDataFinal :TDate;
sucesso : Boolean;
begin
  sucesso := True;

  if not frmPeriodo1.validarPeriodo then
  begin
    sucesso := False;
    PempecMsg.MsgError('Favor corrigir a data');

  end;

  if sucesso then
  begin

    if frmContaBancaria1.cbbConta.ItemIndex > 0 then
    begin

      dxBtnImprimir.Enabled := True;

    end else begin dxBtnImprimir.Enabled := False; end;
  end;



end;

procedure TfrmExtratoBancario.frmPeriodo1dtpDataFinalChange(Sender: TObject);
begin
 frmContaBancaria1.cbbConta.Enabled := True;
end;

procedure TfrmExtratoBancario.frmPeriodo1dtpDataInicialChange(Sender: TObject);
begin
 frmContaBancaria1.cbbConta.Enabled := True;
end;


procedure TfrmExtratoBancario.inicializarDM(Sender: TObject);
begin
  if not (Assigned(dmExtratoBancario)) then
  begin
    dmExtratoBancario := TdmExtratoBancario.Create(Self);
  end;

   if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;


  dmConexao.conectarBanco;

  if not uUtil.Empty(TOrgAtual.getId) then begin

        iDOrganizacao := TOrgAtual.getId;
  end;

 limpaPanel;


end;


procedure TfrmExtratoBancario.inicializarVariaveisRelatorio(dtInicial,  dtFinal: TDate);
begin

  with frxExtratoBancario.Variables do
  begin

    if dmOrganizacao.qryDadosEmpresa.RecordCount < 1 then begin

       dmOrganizacao.carregarDadosOrganizacao(idOrganizacao);

    end;

    Variables['strRazaoSocial'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL')
      .AsString);
    Variables['strCNPJ'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
    Variables['strEndereco'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('ENDERECO').AsString);
    Variables['strCEP'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CEP').AsString);
    Variables['strCidade'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CIDADE').AsString);
    Variables['strUF'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strPeriodo'] :=QuotedStr( ' de  ' + DateToStr(dtInicial) + '  at�  ' + DateToStr(dtFinal));
  end;
end;

procedure TfrmExtratoBancario.limpaPanel;
begin

 FsListaIdContas := TStringList.Create;
 frmContaBancaria1.obterTodos(iDOrganizacao, frmContaBancaria1.cbbConta, FsListaIdContas);
 frmPeriodo1.inicializa(Now,Now);
 frmContaBancaria1.cbbConta.Enabled := False;

 chkTipo.EditValue := True;
 chkCheque.EditValue := False;
 dxBtnImprimir.Enabled := False;
 limpaStatusBar;


end;

function TfrmExtratoBancario.retornarCaminhoRelatorio: string;
var tipo : Integer;
begin
 tipo := 0;
 // Result := ExtractFilePath(Application.ExeName) + '\extratoBancario.fr3';
//  tipo = 0 =comum = se for 1 exibe o rel com totalizador diario

  if chkTipo.EditValue = True then begin
     tipo := 1;
  end;


 Result := uUtil.TPathRelatorio.getExtratoBancario(tipo);


end;


function TfrmExtratoBancario.obterSaldoAnterior(pIdOrganizacao, pIDConta: string;   pDataInicial, pDataFinal: TDate): Currency;
  var
  valorDB, valorCR,  vlrSaldo : Currency;
  pDataInicio: TDate  ;
  conta :TContaBancariaModel;
begin
  valorDB :=0; valorCR :=0;  vlrSaldo :=0;

   conta := TContaBancariaModel.Create;
   conta.FIDorganizacao := pIdOrganizacao;
   conta.FID := pIDConta;
   conta := TContaBancariaDAO.obterPorID(conta);

  try

      valorDB := TContaBancariaDebitoDAO.obterSaldoAnterior(conta, pDataInicial) ;
      valorCR := TContaBancariaCreditoDAO.obterSaldoAnterior(conta, pDataInicial);

      vlrSaldo := valorCR - valorDB;

  except
  raise Exception.Create('Erro ao obter saldo anterior...');

  end;

   Result := vlrSaldo;
end;


procedure TfrmExtratoBancario.registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
begin
  TMDDAO.registroMD(pOrg, pTable, pAcao, pDsc, pStatus);

end;

procedure TfrmExtratoBancario.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmExtratoBancario.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. ';
dxStatusBar.Panels[2].Text := ' Painel:  ';
dxStatusBar.Panels[3].Text := 'Teclas de atalho:  [F10] = Imprime  ';

end;

end.