unit uFrmExportacaoComGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs,uUtil, uDMRelatorioExportacaoMega, udmConexao, uDMExportaFinance,
  uDMOrganizacao, uDMHistoricoConsulta,
  uDMExportaFinanceDTS, uDMMegaContabil,uDMExportaFinanceTP,
  uDMExportaFinanceTR, uDMExportaFinanceManter,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmExportacao = class(TForm)
    lblStatusSistemaContabil: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    cbxAnoLote: TComboBox;
    cbxMesLote: TComboBox;
    edtLote: TEdit;
    dtDataInicial: TDateTimePicker;
    dtDataFinal: TDateTimePicker;
    lblGeneratorID: TLabel;
    lblStatusExp: TLabel;
    btnGeraLote: TButton;
    imgGreen: TImage;
    btnImprimir: TBitBtn;
    imgRed: TImage;
    dbgTitulo: TDBGrid;
    dbgTR: TDBGrid;
    dbgHistorico: TDBGrid;
    DBGTRHIST: TDBGrid;
    dbgCentroCusto: TDBGrid;
    DBGTRCC: TDBGrid;
    lblIdOrganizacao: TLabel;
    lblHistoricoSemConta: TLabel;
    dbTPB: TDBGrid;
    dbgTPQuidatoCaixa: TDBGrid;
    dbgTPQuitadoBanco: TDBGrid;
    dbGTituloQuitado: TDBGrid;

    procedure FormCreate(Sender: TObject);
    procedure btnGeraLoteClick(Sender: TObject);
    procedure cbxAnoLoteClick(Sender: TObject);
    procedure cbxMesLoteChange(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    idOrganizacao: String; // guarda o id da Organziacao em uso
    FsListaIdOrganizacoes: TStringList;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure statusExportar(sinal: Integer);
    function liberaExibirRelatorio: Integer;
    procedure obterIdMega;

  public
    { Public declarations }
  end;

var
  frmExportacao: TfrmExportacao;

implementation

{$R *.dfm}

procedure TfrmExportacao.btnGeraLoteClick(Sender: TObject);
var
  IdFechamento, idLote, ano: String;
  codEmpresa, lote, loteInicial: Integer;
  fechamento: Boolean;
begin
  fechamento := true;
  // verifica se existe o lote
  codEmpresa := StrToInt(LerRegistro('Pempec Enterprise', 'Mega',
    'CODIGO_EMPRESA'));
  lote := StrToInt(edtLote.Text);
  loteInicial := lote;

  if dmConexao.baseDadosMegaregistrada then
  begin
    dmMegaContabil.VerificaSeExistLote(codEmpresa, lote, ano);
  end;

  ano := cbxAnoLote.Text;
  // idLote := dmMegaContabil.qryExistLote.FieldByName('ID').AsString;

  // verifica se tem ID_ORGANIZACAO Selecionada

  if idOrganizacao = '' then
  begin
    ShowMessage('Será preciso selecionar uma Organização antes de prosseguir.');
    fechamento := false;
    btnImprimir.Enabled := false;
    Limpatela(Self);

  end
  else
  begin

    // verifica se tem fechamento apos a data inicial até 2020 e impede importar
    // recebe o ID EMPRESA e a data incial
    if dmConexao.baseDadosMegaregistrada then
    begin
      IdFechamento := dmMegaContabil.verificaFechamento(codEmpresa,
        DateToStr(dtDataInicial.Date));
    end;
    if not(IdFechamento = String.Empty) then
    begin
      ShowMessage
        ('Tem fechamndo. Não será possívem continuar. Verifique o periodo. ' +
        IdFechamento);
    end;
    if dmConexao.baseDadosMegaregistrada then
    begin

      if (dmMegaContabil.lotesRestritos(lote)) then
      begin
        edtLote.Text := 'LOTE RESTRITO';
        cbxAnoLote.ItemIndex := 0;
        cbxMesLote.ItemIndex := 0;
        idLote := '';

      end
      else
      begin
        while dmMegaContabil.VerificaSeExistLote(codEmpresa, lote, ano) do
        begin
          lote := lote + 1;
          if ((lote = 65) OR (lote = 75)) then
          begin
            lote := lote + 2;
          end;
          edtLote.Text := IntToStr(lote);
          fechamento := true;
        end;
      end;
    end;
    // so permite ate 10 lotes no mes de referencia
    if (lote > (loteInicial + 9)) then
    begin
      ShowMessage('Problemas com o numero do lote.  Verifique!');
      Limpatela(Self);
      fechamento := false;

    end;
    // se passou pelas validacoes acima,
    // gravar na table CLOTES
    // gravar parte 1 de LOTE_CONTABIL
    // pegar os lancamentos no FINANCE
    // gravar na table CLANCAMENTOS
    // VERIFICAR SE DEU ERRO EM CLOTES_ERROR
    // gravar parte 2 de LOTE_CONTABIL

    if fechamento then
    begin
      statusExportar(1); // ativa export  com verde
      // verifica se existem historicos sem conta contabil e avisa no label
      if dmHistoricoConsulta.obterListaHistoricoSemContaContabil(TOrgAtual.getId)
      then
      begin
        lblHistoricoSemConta.Visible := true;
        lblHistoricoSemConta.Caption :=
          'Existem Históricos sem Conta Contábil. Verifique antes de exportar!';
      end;
      // pega o generator da tabela CLOTES
      lblGeneratorID.Caption :=
        IntToStr(dmMegaContabil.retornarIDPorTabela('CLOTES'));

      dmOrganizacao.carregarDadosEmpresa(idOrganizacao);
      // TP carrega os TITULOS A PAGAR PROVISIONADOS // preenche dbgrid
      dmExportFinanceTP.obterTPProvisionados(idOrganizacao, 'ABERTO',
        dtDataInicial.Date, dtDataFinal.Date, 1);

      // TPB carrega os TITULOS A PAGOS  // preenche dbgrid
      // Obs. Aqui a data inicial/final ta relacionada com data Pagto
      dmExportFinanceTP.obterTPQuitados(idOrganizacao, 'QUITADO',
        dtDataInicial.Date, dtDataFinal.Date);

      // TR carrega os TITULOS A RECEBER PROVISIONADOS // preenche dbgrid
      dmExportFinanceTR.obterTRProvisionados(idOrganizacao, 'ABERTO',
        dtDataInicial.Date, dtDataFinal.Date, 1);

        //TRB carrega os titulos a receber quitados
        dmExportFinanceTR.obterTRQuitados(idOrganizacao, 'QUITADO',
        dtDataInicial.Date, dtDataFinal.Date);



      btnImprimir.Enabled := true;

    end;

  end;

  { colocar isso dentro de um botao
    o lote contabil sera gravado em duas partes:
    1 - dados basicos obrigatorios.
    2 - estatisticas do que foi exportado.
    PRIMEIRO
    ID_LOTE_CONTABIL = ID criado no generator de CLOTES do MEGA
    ID_ORGANIZADO = ID da ORG selecionada
    LOTE = ano de referencia + o index do combo de mes de referncia + lote

  }

end;

procedure TfrmExportacao.btnImprimirClick(Sender: TObject);
begin

  if (liberaExibirRelatorio > 0) then
  begin
    dmRelExportacaoMega.exibirRelatorioExportacao;
  end
  else
  begin
    btnImprimir.Enabled := false;
    ShowMessage('Não existem dados para imprimir.');
  end
end;

procedure TfrmExportacao.obterIdMega;
var
  pid: string;
begin

  if dmConexao.baseDadosMegaregistrada then
  begin
    if not(dmConexao.ConnMega.Connected) then
    begin
      dmConexao.conectarMega;
    end;
  end;

  if (dmConexao.baseDadosMegaregistrada) then
  begin
    if (dmMegaContabil.carregarDadosEmpresaMega(TOrgAtual.getCNPJ)) then
    begin
      pid := IntToStr(dmMegaContabil.qryDadosEmpresaMega.FieldByName('ID')
        .AsInteger);
    end
    else
    begin
      ShowMessage('Não foi possível obter o Identificador contábil.');
    end;

    if not(pid = '') then
    begin
      GravarRegistros('Pempec Enterprise', 'Mega', 'CODIGO_EMPRESA', pid);
    end;
  end
  else
  begin
    ShowMessage
      ('Impossível gravar Identificador Contábil. Base Contábil não registrada.');
  end;

end;

procedure TfrmExportacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  freeAndNilDM(Self);
  Action := caFree; // sempre como ultimo comando
end;

procedure TfrmExportacao.FormCreate(Sender: TObject);
begin
  // LimpaTela(Self);
  inicializarDM(Self);
  cbxAnoLote.Enabled := true;
  cbxMesLote.ItemIndex := 0;
  cbxAnoLote.ItemIndex := 0;
  btnGeraLote.Enabled := false;
  cbxMesLote.Enabled := false;
  statusExportar(0);
  idOrganizacao := TOrgAtual.getId;
  dtDataInicial.Date := now;
  dtDataFinal.Date := now;


  obterIdMega;

end;

procedure TfrmExportacao.inicializarDM(Sender: TObject);
begin

  if not(Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end
  else
  begin
    dmConexao.conectarBanco;
    dmConexao.conectarMega;
  end;

  if not(Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;

  if not(Assigned(dmMegaContabil)) then
  begin
    dmMegaContabil := TdmMegaContabil.Create(Self);
  end;

  if not(Assigned(dmRelExportacaoMega)) then
  begin
    dmRelExportacaoMega := TdmRelExportacaoMega.Create(Self);
  end;

  if not(Assigned(dmExportaFinance)) then
  begin
    dmExportaFinance := TdmExportaFinance.Create(Self);
  end;

  if not(Assigned(dmTPDTS)) then
  begin
    dmTPDTS := TdmTPDTS.Create(Self);
  end;

  if not(Assigned(dmHistoricoConsulta)) then
  begin
    dmHistoricoConsulta := TdmHistoricoConsulta.Create(Self);
  end;

  if not(Assigned(dmExportFinanceTP)) then
  begin
    dmExportFinanceTP := TdmExportFinanceTP.Create(Self);
  end;

  if not(Assigned(dmExportFinanceTR)) then
  begin
    dmExportFinanceTR := TdmExportFinanceTR.Create(Self);
  end;

end;

// tipo:  cbt = 1 ; cbd=2; cbc = 3; tp = 4; tpb=5; tr=6; trb=7
function TfrmExportacao.liberaExibirRelatorio: Integer;
var
  valor: Integer;
begin
  valor := 0;

  if not dbgTitulo.DataSource.DataSet.IsEmpty then
  begin
    valor := 1;
  end;

  if not dbgTR.DataSource.DataSet.IsEmpty then
  begin
    valor := 2;
  end;

  if not dbTPB.DataSource.DataSet.IsEmpty then
  begin
    valor := 2;
  end;

  if not dbGTituloQuitado.DataSource.DataSet.IsEmpty then
  begin
    valor := 2;
  end;

  if not dbgTPQuidatoCaixa.DataSource.DataSet.IsEmpty then
  begin
    valor := 2;
  end;

  if not dbgTPQuitadoBanco.DataSource.DataSet.IsEmpty then
  begin
    valor := 2;
  end;

  Result := valor;

end;

procedure TfrmExportacao.freeAndNilDM(Sender: TObject);
begin

  if (Assigned(dmConexao)) then
  begin
    FreeAndNil(dmConexao);
  end;

  if (Assigned(dmTPDTS)) then
  begin
    FreeAndNil(dmTPDTS);
  end;

  if (Assigned(dmOrganizacao)) then
  begin
    FreeAndNil(dmOrganizacao);
  end;

  if (Assigned(dmMegaContabil)) then
  begin
    FreeAndNil(dmMegaContabil);
  end;

  if (Assigned(dmExportaFinance)) then
  begin
    FreeAndNil(dmExportaFinance);
  end;

  if (Assigned(dmHistoricoConsulta)) then
  begin
    FreeAndNil(dmHistoricoConsulta);
  end;

end;

procedure TfrmExportacao.statusExportar(sinal: Integer);
begin

  // So ativa o sinal verde
  if sinal = 1 then
  begin
    imgGreen.Visible := true;
    imgGreen.Top := 117;
    imgRed.Visible := false;
    imgRed.Top := 117;
  end;

  // So 10ativa o sinal verde
  if sinal = 0 then
  begin
    imgGreen.Visible := false;
    imgGreen.Top := 117;
    imgRed.Visible := true;
    imgRed.Top := 117;
  end;

end;

procedure TfrmExportacao.cbxAnoLoteClick(Sender: TObject);
begin

  if cbxAnoLote.ItemIndex > 0 then
  begin
    cbxMesLote.Enabled := true;
  end
  else
  begin
    cbxMesLote.Enabled := false;
    edtLote.Enabled := false;
    dtDataInicial.Enabled := false;
    dtDataFinal.Enabled := false;
    btnGeraLote.Enabled := false;

  end;

end;

procedure TfrmExportacao.cbxMesLoteChange(Sender: TObject);
begin
  case cbxMesLote.ItemIndex of

    0:
      edtLote.Text := '';
    1:
      edtLote.Text := IntToStr(10);
    2:
      edtLote.Text := IntToStr(20);
    3:
      edtLote.Text := IntToStr(30);
    4:
      edtLote.Text := IntToStr(40);
    5:
      edtLote.Text := IntToStr(50);
    6:
      edtLote.Text := IntToStr(60);
    7:
      edtLote.Text := IntToStr(70);
    8:
      edtLote.Text := IntToStr(80);
    9:
      edtLote.Text := IntToStr(90);
    10:
      edtLote.Text := IntToStr(100);
    11:
      edtLote.Text := IntToStr(110);
    12:
      edtLote.Text := IntToStr(120);
  end;

  if cbxMesLote.ItemIndex > 0 then
  begin
    dtDataInicial.Enabled := true;
    btnGeraLote.Enabled := true;
  end
  else
  begin
    edtLote.Enabled := false;
    btnGeraLote.Enabled := false;
  end;
end;

end.
