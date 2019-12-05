unit uImportacaoViaEfd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uFormBaseMaster, Vcl.StdCtrls, ENumEd, Vcl.Buttons, uMostraErros,
  udmConexao, Data.FMTBcd, Data.DB, Data.SqlExpr, Util, uFUtil, ELibFnc,
  LibMega, Constants, udmImportacaoViaEfd, ComObj, EGauge, uFConsts,
  uVariaveisMegaFiscal, IBase, uLancamentosEntradas, uEnumeratoresGlobais,
  uLancamentosEntradasAnalitico, uVarGlobais, uLancamentosSaidas,
  uLancamentosSaidasAnalitico, uLancamentosSaidasEcf, uParticipante,
  uLancamentosSaidasEcfAnalitico, EMsgDlg, uLotes, Vcl.DBCtrls,
  FireDAC.Comp.Client, uControleSistemas, uLancamentosSaidasM2,
  uLancamentosSaidasM2Analitico, EChkGrp, frxClass, frxExportPDF,
  uEnumeratoresMegaFiscal, uDecoratorEnumAttribute;

type
  TEntradaSaida = (tes_entrada, tes_saida);


//  {Alíquota da Operação}
//  TAliquotaOperacao = record
//    dblInternaIcms : Currency;
//    dblIcms        : Currency;
//    dblIss         : Currency;
//    dblPis         : Currency;
//    dblCofins      : Currency;
//    dblIR          : Currency;
//  end;
  {Atividades exercidas pela empresa}
  TAtividade = record
    bIndustria        : Boolean;
    bComercio         : Boolean;
    bTransporte       : Boolean;
    bComunicacao      : Boolean;
    bVendaCombustivel : Boolean;
    bEnergiaEletrica  : Boolean;
    bProducaoRural    : Boolean;
  end;

  TFImportacaoViaEfd = class(TFormBaseMaster)
    edtLoteEntradas: TEvNumEdit;
    lblLtLoteEntradas: TLabel;
    lblLtSaidasModelo2: TLabel;
    edtLoteSaidasModelo2: TEvNumEdit;
    lblLtSaidasEcf: TLabel;
    edtLoteSaidasECF: TEvNumEdit;
    btnImportar: TBitBtn;
    qryVerifica: TSQLQuery;
    OpenDialog1: TOpenDialog;
    NGauge: TEvGauge;
    lblProgresso: TLabel;
    MsgDlg: TEvMsgDlg;
    dsCstPisCofinsSaidas: TDataSource;
    lblCstPisCofins: TLabel;
    cbxCstPisCofinsSaidas: TDBLookupComboBox;
    edtLoteSaidas: TEvNumEdit;
    lblLtSaidas: TLabel;
    dsCstPisCofinsEntradas: TDataSource;
    cbxCstPisCofinsEntradas: TDBLookupComboBox;
    lblCstPisCofinsEntradas: TLabel;
    lblCstPisCofinsSaidas: TLabel;
    lblCstIpi: TLabel;
    cbxCstIpiSaidas: TDBLookupComboBox;
    lblIpiSaidas: TLabel;
    dsCstIpiSaidas: TDataSource;
    edtNaturezaReceita: TEdit;
    lblNaturezaReceita: TLabel;
    procedure btnImportarClick(Sender: TObject);
    procedure CriarDataSets();
    procedure Importar();
    procedure ImportarParticipantes(psLinha: String);
    procedure ImportarRegistroC100(psLinha: String; piNumeroLinha: Integer); {NF Modelos 01-Nota Fiscal Modelo 1 e 1-A ,04-Produtor Rural e 55-NF-e}
    procedure ImportarRegistroC300(psLinha: String; piNumeroLinha: Integer); {NF Modelo 02}
    procedure ImportarRegistroC400(psLinha: String; piNumeroLinha: Integer); {ECF}
    procedure ImportarRegistroC500(psLinha: String; piNumeroLinha: Integer); {NF/Conta Energia Elétrica/Água Canalizada/Gás}
    procedure ImportarRegistroD100(psLinha: String; piNumeroLinha: Integer); {Serviços de Transporte}
    procedure ImportarRegistroD500(psLinha: String; piNumeroLinha: Integer); {Serviços de Comunicação/Telecomunicacao}
    procedure Gravar();

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsCstPisCofinsSaidasDataChange(Sender: TObject; Field: TField);
    procedure edtLoteSaidasECFExit(Sender: TObject);
    function  LocalizaAliquotaInProdutos(psCodigoProduto: String; pdData: TDate): Currency;
    procedure dsCstIpiSaidasDataChange(Sender: TObject; Field: TField);
    procedure edtLoteSaidasChange(Sender: TObject);
  private
    { Private declarations }
    FoStrLstErros: TFMostraErros;
    FoStrLstAvisos: TFMostraErros;
    FoStrLstEfd: TStringList;
    FoStrLstProdutos: TStringList;

    FsIdLoteDFE: string;
    FsIdLoteDFS: string;
    FsIdLoteDFS_M2: string;
    FsIdLoteDFS_ECF: string;
    FiLinhaDFE: Integer;
    FiLinhaDFS: Integer;
    FiLinhaDFS_M2: Integer;
    FiLinhaDFS_ECF: Integer;
    FeRegimeFederal: TTipoRegimeFederal;
    FdDataOperacao: TDate;
    FsFiltroCfop: string;
//    FdblTotalLoteEntradas: Currency;
//    FdblTotalLoteSaidas: Currency;
//    FdblTotalLoteSaidasM2: Currency;
//    FdblTotalLoteSaidasEcf: Currency;
    FbAtualizaCstPisCofins: Boolean;
    FbAtualizaCstIpi: Boolean;
    FsUFPessoa: string;
    FsIdUfPessoa: string;
    FsCodigoMunicipioPessoa: string;

    {FoEvCheckGroupAtividades é inicializado no OnCreate e guarda a definição de
    todas as atividades que são ou não praticadas pela empresa. Ele é usado
    pelos métodos PreencheCdsCtsIcms, PreencheCdsCtsIpiSaidas e
    getCfopPermitidoParaAtividade}
    FoEvCheckGroupAtividades  : TEvCheckGroup;
  public
    { Public declarations }
  end;

var
  FImportacaoViaEfd: TFImportacaoViaEfd;
  rAliquotaOperacao: TAliquotaOperacao;
  rAtividade: TAtividade;

implementation

{$R *.dfm}

procedure TFImportacaoViaEfd.btnImportarClick(Sender: TObject);
var
  loFMostraErros: TFMostraErros;
  lsInscMf: string;
  ldDataArquivo: TDate;
begin
  inherited;
  loFMostraErros   := TFMostraErros.Create(Self);
  FoStrLstErros    := TFMostraErros.Create(Self);
  FoStrLstAvisos   := TFMostraErros.Create(Self);
  FoStrLstEfd      := TStringList.Create;
  FoStrLstProdutos := TStringList.Create;
  try
    fDesabilita(Self);
    lblProgresso.Caption := '';
    lblProgresso.Visible := True;

    FdDataOperacao := EndOfMonth(TFUtil.getDataOperacao(TUtil.getIDPessoa));
    dmImportacaoViaEfd.qryPessoaFiscalParametros.Close;
//    dmImportacaoViaEfd.qryPessoaFiscalParametros.FetchParams;
    dmImportacaoViaEfd.qryPessoaFiscalParametros.ParamByName('pIdPessoa').AsString := TUtil.getIDPessoa;
    dmImportacaoViaEfd.qryPessoaFiscalParametros.ParamByName('pData'    ).AsDate   := EndOfMonth(FdDataOperacao);
    dmImportacaoViaEfd.qryPessoaFiscalParametros.Open;

    if (dmImportacaoViaEfd.qryPessoaFiscalParametros.IsEmpty) then begin
      loFMostraErros.Add('Não existe registro em Cadastro/Parâmetros Históricos para a data igual ou anterior a '+DateToStr(FdDataOperacao)+'.');
    end;

    TFUtil.inicializaAliquotas(FdDataOperacao);
    FeRegimeFederal := TTipoRegimeFederal(TUtil.getTipoRegime(TUtil.getIDPessoa,FdDataOperacao,opFederal));

    if (FeRegimeFederal in ([TTipoRegimeFederal.trf_lucro_real,TTipoRegimeFederal.trf_lucro_presumido])) then begin
      if (dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('PIS_INCIDENCIA_TRIBUTARIA').AsInteger in ([rInfoConstantes.iPisIncidenciaTributariaNaoCumulativo,rInfoConstantes.iPisIncidenciaTributariaAmbos])) then begin
        rAliquotaOperacao.dblPis    := rInfoImposto.iPisAliquotaNaoCumulativo;
        rAliquotaOperacao.dblCofins := rInfoImposto.iCofinsAliquotaNaoCumulativo;
      end else begin
        rAliquotaOperacao.dblPis    := rInfoImposto.iPisAliquotaCumulativo;
        rAliquotaOperacao.dblCofins := rInfoImposto.iCofinsAliquotaCumulativo;
      end;
      rAliquotaOperacao.dblIR := rInfoImposto.iIrAliquota;
    end else begin
      rAliquotaOperacao.dblPis    := 0;
      rAliquotaOperacao.dblCofins := 0;
      rAliquotaOperacao.dblIR     := 0;
    end;
    TFUtil.getAliquotasPadroes(FeRegimeFederal,TUtil.getCNAE(TUtil.getIDPessoa,FdDataOperacao),0,
      tpOprSaida,rAliquotaOperacao,EndOfMonth(TFUtil.getDataOperacao(TUtil.getIDPessoa)));

    if (edtLoteEntradas.Value < 0) then begin
      loFMostraErros.Add('-Número do lote de entradas inválido.',True);
    end else if (edtLoteEntradas.Value > 0) then begin
      qryVerifica.Close;
      qryVerifica.SQL.Clear;
      qryVerifica.SQL.Add('SELECT L.ID_FLOTE_ENTRADA FROM FLOTE_ENTRADA L WHERE (L.FK_PESSOA = :pIdPessoa) AND (L.ANO = :pAno) AND (L.NUMERO = :pNumero)');
      qryVerifica.ParamByName('pIdPessoa').AsString  := TUtil.getIDPessoa;
      qryVerifica.ParamByName('pAno'     ).AsInteger := Year(FdDataOperacao);
      qryVerifica.ParamByName('pNumero'  ).AsInteger := Trunc(edtLoteEntradas.Value);
      qryVerifica.Open;
      if (not qryVerifica.IsEmpty) then begin
        loFMostraErros.Add('-O número do lote de entradas já está sendo utilizado.',True);
      end;
    end;
    if (edtLoteSaidas.Value < 0) then begin
      loFMostraErros.Add('-Número do lote de saídas inválido.',True);
    end else if (edtLoteSaidas.Value > 0) then begin
      qryVerifica.Close;
      qryVerifica.SQL.Clear;
      qryVerifica.SQL.Add('SELECT L.ID_FLOTE_SAIDA FROM FLOTE_SAIDA L WHERE (L.FK_PESSOA = :pIdPessoa) AND (L.ANO = :pAno) AND (L.NUMERO = :pNumero)');
      qryVerifica.ParamByName('pIdPessoa').AsString  := TUtil.getIDPessoa;
      qryVerifica.ParamByName('pAno'     ).AsInteger := Year(FdDataOperacao);
      qryVerifica.ParamByName('pNumero'  ).AsInteger := Trunc(edtLoteSaidas.Value);
      qryVerifica.Open;
      if (not qryVerifica.IsEmpty) then begin
        loFMostraErros.Add('-O número do lote de saídas já está sendo utilizado.',True);
      end;
    end;
    if (edtLoteSaidasModelo2.Value < 0) then begin
      loFMostraErros.Add('-Número do lote de saídas modelo 2 inválido.',True);
    end else if (edtLoteSaidasModelo2.Value > 0) then begin
      qryVerifica.Close;
      qryVerifica.SQL.Clear;
      qryVerifica.SQL.Add('SELECT L.ID_FLOTE_SAIDA_M2 FROM FLOTE_SAIDA_M2 L WHERE (L.FK_PESSOA = :pIdPessoa) AND (L.ANO = :pAno) AND (L.NUMERO = :pNumero)');
      qryVerifica.ParamByName('pIdPessoa').AsString  := TUtil.getIDPessoa;
      qryVerifica.ParamByName('pAno'     ).AsInteger := Year(FdDataOperacao);
      qryVerifica.ParamByName('pNumero'  ).AsInteger := Trunc(edtLoteSaidasModelo2.Value);
      qryVerifica.Open;
      if (not qryVerifica.IsEmpty) then begin
        loFMostraErros.Add('-O número do lote de saídas modelo 2 já está sendo utilizado.',True);
      end;
    end;
    if (edtLoteSaidasECF.Value < 0) then begin
      loFMostraErros.Add('-Número do lote de saídas ECF inválido.',True);
    end else if (edtLoteSaidasECF.Value > 0) then begin
      qryVerifica.Close;
      qryVerifica.SQL.Clear;
      qryVerifica.SQL.Add('SELECT L.ID_FLOTE_SAIDA_ECF FROM FLOTE_SAIDA_ECF L WHERE (L.FK_PESSOA = :pIdPessoa) AND (L.ANO = :pAno) AND (L.NUMERO = :pNumero)');
      qryVerifica.ParamByName('pIdPessoa').AsString  := TUtil.getIDPessoa;
      qryVerifica.ParamByName('pAno'     ).AsInteger := Year(FdDataOperacao);
      qryVerifica.ParamByName('pNumero'  ).AsInteger := Trunc(edtLoteSaidasECF.Value);
      qryVerifica.Open;
      if (not qryVerifica.IsEmpty) then begin
        loFMostraErros.Add('-O número do lote de saídas ECF já está sendo utilizado.',True);
      end;
    end;
    if ((edtLoteEntradas.Value+edtLoteSaidas.Value+edtLoteSaidasModelo2.Value+edtLoteSaidasECF.Value) = 0) then begin
      loFMostraErros.Add('-Informe o número do lote que deseja importar.',True);
    end;
    if (loFMostraErros.Count = 0) then begin
      if OpenDialog1.Execute then begin
        try
          FoStrLstEfd.LoadFromFile(OpenDialog1.FileName);

          if (FoStrLstEfd.Count = 0) then begin
            loFMostraErros.Add('-Arquivo vazio.',True);
          end else begin
            if (StrTokenCount(FoStrLstEfd.Strings[0],'|') <> 17) then begin
              loFMostraErros.Add('-Registro 0000 inválido.',True);
            end else begin
              lsInscMf := StrToken(FoStrLstEfd.Strings[0],'|',8);
              if (lsInscMf <> fSoNumeros(TUtil.getInscMfPessoa)) then begin
                loFMostraErros.Add('-Esse arquivo não perterce a essa empresa.',True);
              end;
//              try
                ldDataArquivo := StrSemBarrasToDate(StrToken(FoStrLstEfd.Strings[0],'|',5));
//              except
//                ldDataArquivo := 0;
//              end;
              if (MesAno(ldDataArquivo,False) <> MesAno(FdDataOperacao,False)) then begin
                loFMostraErros.Add('-Esse arquivo não perterce a esse mês.',True);
              end;
            end;
          end;
        except
          loFMostraErros.Add('-Arquivo inválido.',True);
        end;

        if (loFMostraErros.Count > 0) then begin
          loFMostraErros.ShowModal;
        end else begin
          Screen.Cursor := crHourGlass;
          dmImportacaoViaEfd.qryVerificaDFE.Close;
          dmImportacaoViaEfd.qryVerificaDFE.Open;
          dmImportacaoViaEfd.qryVerificaDFS.Close;
          dmImportacaoViaEfd.qryVerificaDFS.Open;
          dmImportacaoViaEfd.qryParticipante.Close;
//          dmImportacaoViaEfd.qryParticipante.FetchParams;
          dmImportacaoViaEfd.qryParticipante.ParamByName('pIdPessoa').AsString := TUtil.getIDPessoa;
          dmImportacaoViaEfd.qryParticipante.Open;

          NGauge.MaxValue := FoStrLstEfd.Count-1;
          NGauge.Progress := 0;
          Application.ProcessMessages;

          CriarDataSets;
          Importar;
          Screen.Cursor := crDefault;

          if (FoStrLstErros.Count > 0) then begin
            FoStrLstErros.Caption := 'ERROS';
            FoStrLstErros.ShowModal;
          end else begin
            Gravar;
            if (FoStrLstErros.Count > 0) then begin
              FoStrLstErros.Caption := 'ERROS';
              FoStrLstErros.ShowModal;
            end;

            MsgDlg.MsgInformation('Arquivo EFD importado.')
          end;

          if (FoStrLstAvisos.Count > 0) then begin
            FoStrLstAvisos.Caption := 'AVISOS';
            FoStrLstAvisos.ShowModal;
          end;
        end;
      end;
    end else begin
      loFMostraErros.ShowModal;
    end;
  finally
    FreeAndNil(loFMostraErros);
    FreeAndNil(FoStrLstErros);
    FreeAndNil(FoStrLstAvisos);
    FreeAndNil(FoStrLstEfd);
    FreeAndNil(FoStrLstProdutos);
    lblProgresso.Visible := False;
    NGauge.Progress := 0;
    fHabilita(Self);
    Screen.Cursor := crDefault;
  end;
end;

procedure TFImportacaoViaEfd.CriarDataSets;
begin
  dmImportacaoViaEfd.qryNFMod_02_65.Open;
  dmImportacaoViaEfd.qryDFE.Open;
  dmImportacaoViaEfd.qryDFEAnalitico.Open;
  dmImportacaoViaEfd.qryDFS.Open;
  dmImportacaoViaEfd.qryDFSAnalitico.Open;
  dmImportacaoViaEfd.qryDFSM2.Open;
  dmImportacaoViaEfd.qryDFSM2Analitico.Open;
  dmImportacaoViaEfd.qryDFSEcf.Open;
  dmImportacaoViaEfd.qryDFSEcfAnalitico.Open;
  dmImportacaoViaEfd.cdsParticipanteTemp.Close;
  dmImportacaoViaEfd.cdsParticipanteTemp.CreateDataSet;
  TUtilDataSet.CriaCds(dmImportacaoViaEfd.qryDFE,dmImportacaoViaEfd.cdsDFETemp);
  TUtilDataSet.CriaCds(dmImportacaoViaEfd.qryDFEAnalitico,dmImportacaoViaEfd.cdsDFEAnaliticoTemp);
  TUtilDataSet.CriaCds(dmImportacaoViaEfd.qryDFS,dmImportacaoViaEfd.cdsDFSTemp);
  TUtilDataSet.CriaCds(dmImportacaoViaEfd.qryDFSAnalitico,dmImportacaoViaEfd.cdsDFSAnaliticoTemp);
  TUtilDataSet.CriaCds(dmImportacaoViaEfd.qryDFSM2,dmImportacaoViaEfd.cdsDFSM2Temp);
  TUtilDataSet.CriaCds(dmImportacaoViaEfd.qryDFSM2Analitico,dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp);
  TUtilDataSet.CriaCds(dmImportacaoViaEfd.qryNFMod_02_65,dmImportacaoViaEfd.cdsNFMod_02_65_Temp);

//  TUtilDataSet.CriaCds(dmImportacaoViaEfd.qryDFSM2,dmImportacaoViaEfd.cdsDFSM2TempCondensado);
//  TUtilDataSet.CriaCds(dmImportacaoViaEfd.qryDFSM2Analitico,dmImportacaoViaEfd.cdsDFSM2AnaliticoTempCondensado);

  TUtilDataSet.CriaCds(dmImportacaoViaEfd.qryDFSEcf,dmImportacaoViaEfd.cdsDFSEcfTemp);
  TUtilDataSet.CriaCds(dmImportacaoViaEfd.qryDFSEcfAnalitico,dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp);
end;

procedure TFImportacaoViaEfd.dsCstIpiSaidasDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if FbAtualizaCstIpi then begin
    if (not dmImportacaoViaEfd.cdsCstIpi.IsEmpty) then begin
      cbxCstIpiSaidas.KeyValue := dmImportacaoViaEfd.cdsCstIpi.FieldByName('CODIGO').AsString;
    end;
  end;
end;

procedure TFImportacaoViaEfd.dsCstPisCofinsSaidasDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if FbAtualizaCstPisCofins then begin
    if (not dmImportacaoViaEfd.cdsCstPisCofinsEntradas.IsEmpty) then begin
      cbxCstPisCofinsEntradas.KeyValue := dmImportacaoViaEfd.cdsCstPisCofinsEntradas.FieldByName('CODIGO').AsString;
    end;
    if (not dmImportacaoViaEfd.cdsCstPisCofinsSaidas.IsEmpty) then begin
      cbxCstPisCofinsSaidas.KeyValue := dmImportacaoViaEfd.cdsCstPisCofinsSaidas.FieldByName('CODIGO').AsString;
    end;
  end;
end;

procedure TFImportacaoViaEfd.edtLoteSaidasChange(Sender: TObject);
begin
  inherited;
  if ((edtLoteSaidas.Value+edtLoteSaidasECF.Value+edtLoteSaidasModelo2.Value) > 0) then begin
    edtNaturezaReceita.Enabled := True;
  end else begin
    edtNaturezaReceita.Enabled := False;
    edtNaturezaReceita.Text    := '';
  end;
end;

procedure TFImportacaoViaEfd.edtLoteSaidasECFExit(Sender: TObject);
begin
  inherited;
  if (edtLoteEntradas.Value > 0) then begin
    if (dmImportacaoViaEfd.cdsCstPisCofinsEntradas.IsEmpty) then begin
      FbAtualizaCstPisCofins := False;
//      TFUtil.PreencheCdsCtsPisCofinsEntradas(dmImportacaoViaEfd.cdsCstPisCofinsEntradas,0,0);
      TFUtil.PreencheCdsCtsPisCofinsEntradas(dmImportacaoViaEfd.cdsCstPisCofinsEntradas);
      cbxCstPisCofinsEntradas.KeyValue := dmImportacaoViaEfd.cdsCstPisCofinsEntradas.FieldByName('CODIGO').AsString;
      FbAtualizaCstPisCofins := True;
    end;
  end else begin
    dmImportacaoViaEfd.cdsCstPisCofinsEntradas.Close;
  end;
  if (edtLoteSaidasECF.Value > 0)
    or (edtLoteSaidas.Value > 0)
  then begin
    if (dmImportacaoViaEfd.cdsCstPisCofinsSaidas.IsEmpty) then begin
      FbAtualizaCstPisCofins := False;
//      TFUtil.PreencheCdsCtsPisCofinsSaidas(dmImportacaoViaEfd.cdsCstPisCofinsSaidas,0);
      TFUtil.PreencheCdsCtsPisCofinsSaidas(dmImportacaoViaEfd.cdsCstPisCofinsSaidas);
      cbxCstPisCofinsSaidas.KeyValue := dmImportacaoViaEfd.cdsCstPisCofinsSaidas.FieldByName('CODIGO').AsString;
      FbAtualizaCstPisCofins := True;
    end;

    if (dmImportacaoViaEfd.cdsCstIpi.IsEmpty) then begin
      FbAtualizaCstIpi := False;
      TFUtil.PreencheCdsCtsIpiSaidas(FoEvCheckGroupAtividades,dmImportacaoViaEfd.cdsCstIpi);
      cbxCstIpiSaidas.KeyValue := dmImportacaoViaEfd.cdsCstIpi.FieldByName('CODIGO').AsString;
      FbAtualizaCstIpi := True;
    end;
  end else begin
    dmImportacaoViaEfd.cdsCstPisCofinsSaidas.Close;
  end;
end;

procedure TFImportacaoViaEfd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if (Assigned(dmImportacaoViaEfd)) then begin
    FreeAndNil(dmImportacaoViaEfd);
  end;
end;

procedure TFImportacaoViaEfd.FormCreate(Sender: TObject);
var
  lsBinario: string;
begin
  inherited;
  if (not Assigned(dmImportacaoViaEfd)) then begin
    dmImportacaoViaEfd := TdmImportacaoViaEfd.Create(Self);
  end;
  FsIdUfPessoa            := TUtil.getIdCidadePessoa(TUtil.getIDPessoa);
  FsUFPessoa              := TUtil.getEstadoPessoa(TUtil.getIDPessoa,false);
  FsCodigoMunicipioPessoa := TUtil.getCodigoMunicipioIBGE(TUtil.getIDPessoa);

  dmImportacaoViaEfd.qryPessoaFiscalParametros.Close;
//  dmImportacaoViaEfd.cdsPessoaFiscalParametros.FetchParams;
  dmImportacaoViaEfd.qryPessoaFiscalParametros.ParamByName('pIdPessoa').AsString := TUtil.getIDPessoa;
  dmImportacaoViaEfd.qryPessoaFiscalParametros.ParamByName('pData'    ).AsDate   := EndOfMonth(TFUtil.getDataOperacao(TUtil.getIDPessoa));
  dmImportacaoViaEfd.qryPessoaFiscalParametros.Open;

  rAtividade.bIndustria        := IntToBoolean(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_INDUSTRIA'          ).AsInteger);
  rAtividade.bComercio         := IntToBoolean(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_COMERCIO'           ).AsInteger);
  rAtividade.bTransporte       := IntToBoolean(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_SERVICO_TRANSPORTE' ).AsInteger);
  rAtividade.bComunicacao      := IntToBoolean(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_SERVICO_COMUNICACAO').AsInteger);
  rAtividade.bVendaCombustivel := IntToBoolean(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_VENDA_COMBUSTIVEL'  ).AsInteger);
  rAtividade.bEnergiaEletrica  := IntToBoolean(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_ENERGIA_ELETRICA'   ).AsInteger);
  rAtividade.bProducaoRural    := IntToBoolean(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_PRODUCAO_RURAL'     ).AsInteger);

  {Cria uma sequencia binária, representativa de todas as atividades praticadas
  ou não pela empresa.}
  lsBinario :=           IntToStr(abs(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_PRODUCAO_RURAL'     ).AsInteger));
  lsBinario := lsBinario+IntToStr(abs(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_ENERGIA_ELETRICA'   ).AsInteger));
  lsBinario := lsBinario+IntToStr(abs(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_VENDA_COMBUSTIVEL'  ).AsInteger));
  lsBinario := lsBinario+IntToStr(abs(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_SERVICO_ISSQN'      ).AsInteger));
  lsBinario := lsBinario+IntToStr(abs(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_SERVICOS_OUTROS'    ).AsInteger));
  lsBinario := lsBinario+IntToStr(abs(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_SERVICO_COMUNICACAO').AsInteger));
  lsBinario := lsBinario+IntToStr(abs(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_SERVICO_TRANSPORTE' ).AsInteger));
  lsBinario := lsBinario+IntToStr(abs(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_COMERCIO'           ).AsInteger));
  lsBinario := lsBinario+IntToStr(abs(dmImportacaoViaEfd.qryPessoaFiscalParametros.FieldByName('ATIVIDADE_INDUSTRIA'          ).AsInteger));

  {Instancia o objeto FoEvCheckGroupAtividades}
  FoEvCheckGroupAtividades := TEvCheckGroup.Create(Self);
  {Adiciona as opções ao objeto FoEvCheckGroupAtividades}
  FoEvCheckGroupAtividades.Items.Add('TP_ATVIDADE_INDUSTRIA'          );
  FoEvCheckGroupAtividades.Items.Add('TP_ATVIDADE_COMERCIO'           );
  FoEvCheckGroupAtividades.Items.Add('TP_ATVIDADE_SERVICO_TRANSPORTE' );
  FoEvCheckGroupAtividades.Items.Add('TP_ATVIDADE_SERVICO_COMUNICACAO');
  FoEvCheckGroupAtividades.Items.Add('TP_ATVIDADE_SERVICOS_OUTROS'    );
  FoEvCheckGroupAtividades.Items.Add('TP_ATVIDADE_SERVICO_ISSQN'     );
  FoEvCheckGroupAtividades.Items.Add('TP_ATVIDADE_VENDA_COMBUSTIVEL'  );
  FoEvCheckGroupAtividades.Items.Add('TP_ATVIDADE_ENERGIA_ELETRICA'   );
  FoEvCheckGroupAtividades.Items.Add('TP_ATIVIDADE_PRODUTOR_RURAL'    );
  {Seta as definições do objeto FoEvCheckGroupAtividades, através da sequência
  binária contida em lsBinario}
  FoEvCheckGroupAtividades.SetStates(BinToDec(lsBinario));

  FsFiltroCfop := '(UTILIZACAO IN (0, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 22, 23, 24, 25';
  if (rAtividade.bIndustria) then begin
    FsFiltroCfop := FsFiltroCfop+', 1, 21';
  end;
  if (rAtividade.bComercio) then begin
    FsFiltroCfop := FsFiltroCfop+', 2';
  end;
  if (rAtividade.bProducaoRural) then begin
    FsFiltroCfop := FsFiltroCfop+', 7';
  end;
  FsFiltroCfop := FsFiltroCfop+'))';
end;

procedure TFImportacaoViaEfd.Gravar;
var
  liFor: Integer;
  loLancamentosEntradas: ITable;
  loLancamentosEntradasProvider: TLancamentosEntradasProvider;
  loLancamentosEntradasAnalitico: ITable;
  loLancamentosEntradasAnaliticoProvider: TLancamentosEntradasAnaliticoProvider;
  loLancamentosSaidas: ITable;
  loLancamentosSaidasProvider: TLancamentosSaidasProvider;
  loLancamentosSaidasAnalitico: ITable;
  loLancamentosSaidasAnaliticoProvider: TLancamentosSaidasAnaliticoProvider;
  loLancamentosSaidasM2: ITable;
  loLancamentosSaidasM2Provider: TLancamentosSaidasM2Provider;
  loLancamentosSaidasM2Analitico: ITable;
  loLancamentosSaidasM2AnaliticoProvider: TLancamentosSaidasM2AnaliticoProvider;
  loLancamentosSaidasEcf: ITable;
  loLancamentosSaidasEcfProvider: TLancamentosSaidasEcfProvider;
  loLancamentosSaidasEcfAnalitico: ITable;
  loLancamentosSaidasEcfAnaliticoProvider: TLancamentosSaidasEcfAnaliticoProvider;
  loLote: ITable;
  loLoteProvider: TLotesProvider;
  loParticipante: TParticipante;
  loParticipanteProvider: TParticipanteProvider;

  lsNomeCampo: string;
  loTipoCampo: Data.DB.TFieldType;
  ldblTotalLote: Currency;

  lbCondensa: Boolean;
  ldDataEmissao: TDate;
  lsIdDFM2,lsSerie,lsCodigoSituacao,lsFkModelo,lsFkCfop,lsCstIcms,
  lsCstPisCofins: string;
  liNumeroInicial,liNumeroFinal: NativeUInt;
  ldblValorTotal,ldblValorOperacao,ldblBaseIcms,ldblReducaoBaseIcms,
  ldblBasePiscofins,ldblAliquotaIcms,ldblAliquotaPis,ldblAliquotaCofins,
  ldblAliquotaIr: Currency;

begin
  try
    rInfoConexao.bFireDac := True;
    try
      TUtilConexaoFireDac.StartTransaction(TUtilConexaoFireDac.getConn);
      {Inclui os novos participantes}
      dmImportacaoViaEfd.cdsParticipanteTemp.First;
      NGauge.MaxValue      := dmImportacaoViaEfd.cdsParticipanteTemp.RecordCount;
      lblProgresso.Caption := 'Gravando Registros de participantes.';
      NGauge.Progress      := 0;
      Application.ProcessMessages;
      loParticipante         := TParticipante.Create(TUtilConexaoFireDac.getConn);
      loParticipanteProvider := TParticipanteProvider.Create;
      loParticipanteProvider.Conn  := TUtilConexaoFireDac.getConn;
      loParticipanteProvider.Table := loParticipante;

      while (not dmImportacaoViaEfd.cdsParticipanteTemp.Eof) do begin
        if (dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('EXISTE').AsInteger = 0) then begin
          lblProgresso.Caption := 'Gravando Registro do participante: '+dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('NOME').AsString;
          Application.ProcessMessages;

          loParticipante.FieldByName('ID_FPARTICIPANTE'           ).AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
          loParticipante.FieldByName('FK_PESSOA'                  ).AsString  := TUtil.getIDPessoa;
          loParticipante.FieldByName('CODIGO'                     ).AsInteger := 0;
          loParticipante.FieldByName('INSCMF'                     ).AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('INSCMF').AsString;
          loParticipante.FieldByName('NOME'                       ).AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('NOME').AsString;
          loParticipante.FieldByName('INSCRICAO_ESTADUAL'         ).AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('IE').AsString;
          loParticipante.FieldByName('FK_TP_LOGRADOURO'           ).AsString  := '{6FE348F1-F603-4871-8C2A-EC915D4BE645}'; {Logradouro Rua}
          loParticipante.FieldByName('LOGRADOURO'                 ).AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('END').AsString;
          loParticipante.FieldByName('NUMERO'                     ).AsString  := Copy(fSoNumeros(dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('NUMERO').AsString),1,6);
          loParticipante.FieldByName('COMPLEMENTO'                ).AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('COMPL').AsString;
          loParticipante.FieldByName('BAIRRO'                     ).AsString  := Copy(dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('BAIRRO').AsString,1,30);
          loParticipante.FieldByName('CODIGO_PARTICIPANTE_EMPRESA').AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('COD_PART').AsString;
          if (dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_CIDADE').AsString <> '') then begin
            loParticipante.FieldByName('FK_CIDADE').AsString := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_CIDADE').AsString;
          end else begin
            {Se o ID da cidade for igual a '', então pega o ID da cidade branco}
            loParticipante.FieldByName('FK_CIDADE').AsString := '{08DAC80A-2F40-484F-8591-619FC9497DE8}';
          end;

          if (not dmImportacaoViaEfd.qryPais.Active)
            or (dmImportacaoViaEfd.qryPais.FieldByName('CODIGO_IBGE').AsString <> dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('COD_PAIS').AsString)
          then begin
            dmImportacaoViaEfd.qryPais.Close;
            dmImportacaoViaEfd.qryPais.ParamByName('pCodigoPais').AsString := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('COD_PAIS').AsString;
            dmImportacaoViaEfd.qryPais.Open;
          end;
          loParticipante.FieldByName('FK_PAIS').AsString := dmImportacaoViaEfd.qryPais.FieldByName('ID_PAISES').AsString;

          loParticipanteProvider.Insert;
        end;
        dmImportacaoViaEfd.cdsParticipanteTemp.Next;
        NGauge.Progress := dmImportacaoViaEfd.cdsParticipanteTemp.RecNo;
        Application.ProcessMessages;
      end;

      {Inclusão do Lote de Entradas}
      if (edtLoteEntradas.Value > 0)
        and (FiLinhaDFE > 1)
      then begin
        ldblTotalLote := 0;
        while not dmImportacaoViaEfd.cdsDFETemp.Eof do begin
          ldblTotalLote := ldblTotalLote+dmImportacaoViaEfd.cdsDFETemp.FieldByName('VALOR').AsCurrency;
          dmImportacaoViaEfd.cdsDFETemp.Next;
        end;

        loLote := TLotes.Create(TUtilConexaoFireDac.getConn,'FLOTE_ENTRADA');
        loLoteProvider := TLotesProvider.Create;

        loLote.FieldByName('ID_FLOTE_ENTRADA').AsString   := FsIdLoteDFE;
        loLote.FieldByName('FK_PESSOA'       ).AsString   := TUtil.getIDPessoa;
        loLote.FieldByName('MES'             ).AsInteger  := Month(FdDataOperacao);
        loLote.FieldByName('ANO'             ).AsInteger  := Year(FdDataOperacao);
        loLote.FieldByName('NUMERO'          ).AsInteger  := Trunc(edtLoteEntradas.Value);
        loLote.FieldByName('VALOR_TOTAL'     ).AsCurrency := ldblTotalLote;

        loLoteProvider.Conn := TUtilConexaoFireDac.getConn;
        loLoteProvider.Table := loLote;
        loLoteProvider.Insert;

        loLoteProvider := nil;
        FreeAndNil(loLoteProvider);

        {Inclusão do registros DFE.}
        dmImportacaoViaEfd.cdsDFETemp.IndexFieldNames := 'DATA_ENTRADA;DATA_EMISSAO';
        dmImportacaoViaEfd.cdsDFETemp.First;
        NGauge.MaxValue      := dmImportacaoViaEfd.cdsDFETemp.RecordCount;
        lblProgresso.Caption := 'Gravando Registros de Documentos Fiscais de Entradas.';
        NGauge.Progress      := 0;
        Application.ProcessMessages;

        loLancamentosEntradas := TLancamentosEntradas.Create(TUtilConexaoFireDac.getConn);
        loLancamentosEntradasProvider := TLancamentosEntradasProvider.Create;

        while not dmImportacaoViaEfd.cdsDFETemp.Eof do begin
          for liFor := 0 to dmImportacaoViaEfd.qryDFE.FieldCount-1 do begin
            lsNomeCampo := dmImportacaoViaEfd.qryDFE.Fields[liFor].FieldName;
            loTipoCampo := dmImportacaoViaEfd.qryDFE.Fields[liFor].DataType;
            if (not dmImportacaoViaEfd.cdsDFETemp.Fields[liFor].IsNull) then begin
              if (loTipoCampo in [Data.DB.ftTimeStamp]) then begin
                loLancamentosEntradas.FieldByName(lsNomeCampo).AsDate  := EncodeDate(dmImportacaoViaEfd.cdsDFETemp.FieldByname(lsNomeCampo).AsSQLTimeStamp.Year,
                                                                                                                    dmImportacaoViaEfd.cdsDFETemp.FieldByname(lsNomeCampo).AsSQLTimeStamp.Month,
                                                                                                                    dmImportacaoViaEfd.cdsDFETemp.FieldByname(lsNomeCampo).AsSQLTimeStamp.Day);
              end else begin
                loLancamentosEntradas.FieldByName(lsNomeCampo).AsValue := dmImportacaoViaEfd.cdsDFETemp.FieldByName(lsNomeCampo).AsVariant;
              end;
            end else begin
              loLancamentosEntradas.FieldByName(lsNomeCampo).AsValue := null;
            end;
          end;
          loLancamentosEntradasProvider.Conn := TUtilConexaoFireDac.getConn;
          loLancamentosEntradasProvider.Table := loLancamentosEntradas;
          loLancamentosEntradasProvider.Insert;
          dmImportacaoViaEfd.cdsDFETemp.Next;
          NGauge.Progress := dmImportacaoViaEfd.cdsDFETemp.RecNo;
          Application.ProcessMessages;
        end;

        loLancamentosEntradas := nil;
        FreeAndNil(loLancamentosEntradasProvider);

        {Inclusão do registros DFEAnaliticos.}
        dmImportacaoViaEfd.cdsDFEAnaliticoTemp.First;
        NGauge.MaxValue      := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.RecordCount;
        lblProgresso.Caption := 'Gravando Registros Analíticos de Documentos Fiscais de Entradas.';
        NGauge.Progress      := 0;
        Application.ProcessMessages;
        loLancamentosEntradasAnalitico := TLancamentosEntradasAnalitico.Create(TUtilConexaoFireDac.getConn);
        loLancamentosEntradasAnaliticoProvider := TLancamentosEntradasAnaliticoProvider.Create;

        while not dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Eof do begin
          if (Trim(dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_DFE').AsString) = '') then begin
            MsgDlg.MsgError(dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_DFE').AsString);
          end;
          for liFor := 0 to dmImportacaoViaEfd.qryDFEAnalitico.FieldCount-1 do begin
            loLancamentosEntradasAnalitico.FieldByName(dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Fields[liFor].FieldName).AsString := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName(dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Fields[liFor].FieldName).AsString;
          end;
          loLancamentosEntradasAnaliticoProvider.Conn := TUtilConexaoFireDac.getConn;
          loLancamentosEntradasAnaliticoProvider.Table := loLancamentosEntradasAnalitico;
          loLancamentosEntradasAnaliticoProvider.Insert;

          if (TipoAtApDa(dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('TIPO_AT_AP_DA').AsInteger) in ([TipoAtApDa.tatapda_Ante_Tributaria,TipoAtApDa.tatapda_Ante_Parcial]))
            and (dmImportacaoViaEfd.cdsDFETemp.FieldByName('DATA_EMISSAO').AsDateTime < BeginOfMonth(FdDataOperacao))
            and (dmImportacaoViaEfd.cdsDFETemp.FieldByName('DATA_EMISSAO').AsDateTime >= StrToDate('01/11/2016'))
          then begin
            {A nova redação do Art. 332, § 2º do RICMS/2012, foi dada pelo Decreto
            nº 17.164, de 04/11/2016, DOE de 05/11/16, efeitos a partir de 01/11/2016.}
            FoStrLstAvisos.Add('-O lançamento desse documento fiscal nº '+IntToStr(dmImportacaoViaEfd.cdsDFETemp.FieldByName('NUMERO').AsInteger)+', com data de emissão '+dmImportacaoViaEfd.cdsDFETemp.FieldByName('DATA_EMISSAO').AsString+' modificará os valores de Atencipação Tributária/Parcial do ICMS do mês '+MesAno(dmImportacaoViaEfd.cdsDFETemp.FieldByName('DATA_EMISSAO').AsDateTime,False)+'. Emita nova listagem desse mês.');
          end;
          dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Next;

          NGauge.Progress := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.RecNo;
          Application.ProcessMessages;
        end;

        loLancamentosEntradasAnalitico := nil;
        FreeAndNil(loLancamentosEntradasAnaliticoProvider);
      end;

      {Inclusão do Lote de Saídas}
      if (edtLoteSaidas.Value > 0)
        and (FiLinhaDFS > 1)
      then begin
        ldblTotalLote := 0;
        while not dmImportacaoViaEfd.cdsDFSTemp.Eof do begin
          ldblTotalLote := ldblTotalLote+dmImportacaoViaEfd.cdsDFSTemp.FieldByName('VALOR').AsCurrency;
          dmImportacaoViaEfd.cdsDFSTemp.Next;
        end;

        loLote := TLotes.Create(TUtilConexaoFireDac.getConn,'FLOTE_SAIDA');
        loLoteProvider := TLotesProvider.Create;

        loLote.FieldByName('ID_FLOTE_SAIDA').AsString   := FsIdLoteDFS;
        loLote.FieldByName('FK_PESSOA'     ).AsString   := TUtil.getIDPessoa;
        loLote.FieldByName('MES'           ).AsInteger  := Month(FdDataOperacao);
        loLote.FieldByName('ANO'           ).AsInteger  := Year(FdDataOperacao);
        loLote.FieldByName('NUMERO'        ).AsInteger  := Trunc(edtLoteSaidas.Value);
        loLote.FieldByName('VALOR_TOTAL'   ).AsCurrency := ldblTotalLote;

        loLoteProvider.Conn := TUtilConexaoFireDac.getConn;
        loLoteProvider.Table := loLote;
        loLoteProvider.Insert;

        loLoteProvider := nil;
        FreeAndNil(loLoteProvider);

        {Inclusão do registros DFS.}
        dmImportacaoViaEfd.cdsDFSTemp.IndexFieldNames := 'DATA_EMISSAO;FK_DF_MODELO;SERIE;NUMERO';
        dmImportacaoViaEfd.cdsDFSTemp.First;
        NGauge.MaxValue      := dmImportacaoViaEfd.cdsDFSTemp.RecordCount;
        lblProgresso.Caption := 'Gravando Registros de Documentos Fiscais de Saídas.';
        NGauge.Progress      := 0;
        Application.ProcessMessages;
        loLancamentosSaidas := TLancamentosSaidas.Create(TUtilConexaoFireDac.getConn);
        loLancamentosSaidasProvider := TLancamentosSaidasProvider.Create;

          loLancamentosSaidasProvider.Conn := TUtilConexaoFireDac.getConn;
          loLancamentosSaidasProvider.Table := loLancamentosSaidas;


        while not dmImportacaoViaEfd.cdsDFSTemp.Eof do begin

          for liFor := 0 to dmImportacaoViaEfd.qryDFS.FieldCount-1 do begin
            lsNomeCampo := dmImportacaoViaEfd.qryDFS.Fields[liFor].FieldName;
            loTipoCampo := dmImportacaoViaEfd.qryDFS.Fields[liFor].DataType;
            if (not dmImportacaoViaEfd.cdsDFSTemp.Fields[liFor].IsNull) then begin
              if (loTipoCampo in [Data.DB.ftTimeStamp]) then begin
                loLancamentosSaidas.FieldByName(lsNomeCampo).AsDate  := EncodeDate(dmImportacaoViaEfd.cdsDFSTemp.FieldByname(lsNomeCampo).AsSQLTimeStamp.Year,
                                                                                                                    dmImportacaoViaEfd.cdsDFSTemp.FieldByname(lsNomeCampo).AsSQLTimeStamp.Month,
                                                                                                                    dmImportacaoViaEfd.cdsDFSTemp.FieldByname(lsNomeCampo).AsSQLTimeStamp.Day);
              end else begin
                loLancamentosSaidas.FieldByName(lsNomeCampo).AsValue := dmImportacaoViaEfd.cdsDFSTemp.FieldByName(lsNomeCampo).AsVariant;
              end;
            end else begin
              loLancamentosSaidas.FieldByName(lsNomeCampo).AsValue := null;
            end;
          end;
//          loLancamentosSaidasProvider.Conn := TUtilConexaoFireDac.getConn;
//          loLancamentosSaidasProvider.Table := loLancamentosSaidas;
          loLancamentosSaidasProvider.Insert;
          dmImportacaoViaEfd.cdsDFSTemp.Next;
          NGauge.Progress := dmImportacaoViaEfd.cdsDFSTemp.RecNo;
          Application.ProcessMessages;
        end;
        loLancamentosSaidasProvider.Conn := nil;
        FreeAndNil(loLancamentosSaidasProvider);

        {Inclusão do registros DFSAnaliticos.}
        dmImportacaoViaEfd.cdsDFSAnaliticoTemp.First;
        NGauge.MaxValue      := dmImportacaoViaEfd.cdsDFSAnaliticoTemp.RecordCount;
        lblProgresso.Caption := 'Gravando Registros Analíticos de Documentos Fiscais de Saídas.';
        NGauge.Progress      := 0;
        Application.ProcessMessages;
        loLancamentosSaidasAnalitico := TLancamentosSaidasAnalitico.Create(TUtilConexaoFireDac.getConn);
        loLancamentosSaidasAnaliticoProvider := TLancamentosSaidasAnaliticoProvider.Create;

        loLancamentosSaidasAnaliticoProvider.Conn := TUtilConexaoFireDac.getConn;
        loLancamentosSaidasAnaliticoProvider.Table := loLancamentosSaidasAnalitico;

        while not dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Eof do begin
          for liFor := 0 to dmImportacaoViaEfd.qryDFSAnalitico.FieldCount-1 do begin
            loLancamentosSaidasAnalitico.FieldByName(dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Fields[liFor].FieldName).AsString := dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName(dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Fields[liFor].FieldName).AsString;
          end;
          if (edtNaturezaReceita.Text <> '')
            and (pos(loLancamentosSaidasAnalitico.FieldByName('CST_PIS_COFINS').AsString,'04*05*06*07*09') > 0)
          then begin
            loLancamentosSaidasAnalitico.FieldByName('NATUREZA_RECEITA').AsString := edtNaturezaReceita.Text;
          end;
          loLancamentosSaidasAnaliticoProvider.Insert;
          dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Next;
          NGauge.Progress := dmImportacaoViaEfd.cdsDFSAnaliticoTemp.RecNo;
          Application.ProcessMessages;
        end;
        loLancamentosSaidasAnaliticoProvider := nil;
        FreeAndNil(loLancamentosSaidasAnaliticoProvider);
      end;

      {Inclusão do Lote de Saídas Modelo 02}
      if (edtLoteSaidasModelo2.Value > 0)
        and (FiLinhaDFS_M2 > 1)
      then begin
        if not dmImportacaoViaEfd.cdsNFMod_02_65_Temp.IsEmpty then begin
          TFUtil.CondencaNFMod_02_65(dmImportacaoViaEfd.cdsNFMod_02_65_Temp,dmImportacaoViaEfd.cdsDFSM2Temp,dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp,NGauge,lblProgresso,True);
       end;

        ldblTotalLote := 0;
        while not dmImportacaoViaEfd.cdsDFSM2Temp.Eof do begin
          ldblTotalLote := ldblTotalLote+dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('VALOR').AsCurrency;
          dmImportacaoViaEfd.cdsDFSM2Temp.Next;
        end;

        loLote := TLotes.Create(TUtilConexaoFireDac.getConn,'FLOTE_SAIDA_M2');
        loLoteProvider := TLotesProvider.Create;

        loLote.FieldByName('ID_FLOTE_SAIDA_M2').AsString   := FsIdLoteDFS_M2;
        loLote.FieldByName('FK_PESSOA'        ).AsString   := TUtil.getIDPessoa;
        loLote.FieldByName('MES'              ).AsInteger  := Month(FdDataOperacao);
        loLote.FieldByName('ANO'              ).AsInteger  := Year(FdDataOperacao);
        loLote.FieldByName('NUMERO'           ).AsInteger  := Trunc(edtLoteSaidasModelo2.Value);
        loLote.FieldByName('VALOR_TOTAL'      ).AsCurrency := ldblTotalLote;

        loLoteProvider.Conn := TUtilConexaoFireDac.getConn;
        loLoteProvider.Table := loLote;
        loLoteProvider.Insert;

        loLoteProvider := nil;
        FreeAndNil(loLoteProvider);

        {Inclusão do registros DFSM2.}
        dmImportacaoViaEfd.cdsDFSM2Temp.IndexFieldNames := 'DATA_EMISSAO;SERIE;NUMERO_INICIAL;FK_DF_MODELO;CODIGO_SITUACAO';
        dmImportacaoViaEfd.cdsDFSM2Temp.First;
        NGauge.MaxValue      := dmImportacaoViaEfd.cdsDFSM2Temp.RecordCount;

//        lbCondensa := True;
//        if lbCondensa then begin
//          while not dmImportacaoViaEfd.cdsDFSM2Temp.Eof do begin
//            lsIdDFM2         := dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('ID_FDFS_M2'     ).AsString;
//            ldDataEmissao    := dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('DATA_EMISSAO'   ).AsDateTime;
//            lsSerie          := dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('SERIE'          ).AsString;
//            lsCodigoSituacao := dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('CODIGO_SITUACAO').AsString;
//            lsFkModelo       := dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('FK_DF_MODELO'   ).AsString;
//            liNumeroInicial  := dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('NUMERO_INICIAL' ).AsInteger;
//            liNumeroFinal    := dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('NUMERO_FINAL'   ).AsInteger;
//            ldblValorTotal   := dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('VALOR'          ).AsCurrency;
//          end;
//        end;

        lblProgresso.Caption := 'Gravando Registros de Documentos Fiscais de Saídas Modelo 02.';
        NGauge.Progress      := 0;
        Application.ProcessMessages;
        loLancamentosSaidasM2 := TLancamentosSaidasM2.Create(TUtilConexaoFireDac.getConn);
        loLancamentosSaidasM2Provider := TLancamentosSaidasM2Provider.Create;
        while not dmImportacaoViaEfd.cdsDFSM2Temp.Eof do begin

          for liFor := 0 to dmImportacaoViaEfd.qryDFSM2.FieldCount-1 do begin
            lsNomeCampo := dmImportacaoViaEfd.qryDFSM2.Fields[liFor].FieldName;
            loTipoCampo := dmImportacaoViaEfd.qryDFSM2.Fields[liFor].DataType;
            if (not dmImportacaoViaEfd.cdsDFSM2Temp.Fields[liFor].IsNull) then begin
              if (loTipoCampo in [Data.DB.ftTimeStamp]) then begin
                loLancamentosSaidasM2.FieldByName(lsNomeCampo).AsDate  := EncodeDate(dmImportacaoViaEfd.cdsDFSM2Temp.FieldByname(lsNomeCampo).AsSQLTimeStamp.Year,
                                                                                                                    dmImportacaoViaEfd.cdsDFSM2Temp.FieldByname(lsNomeCampo).AsSQLTimeStamp.Month,
                                                                                                                    dmImportacaoViaEfd.cdsDFSM2Temp.FieldByname(lsNomeCampo).AsSQLTimeStamp.Day);
              end else begin
                loLancamentosSaidasM2.FieldByName(lsNomeCampo).AsValue := dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName(lsNomeCampo).AsVariant;
              end;
            end else begin
              loLancamentosSaidasM2.FieldByName(lsNomeCampo).AsValue := null;
            end;
          end;
          loLancamentosSaidasM2Provider.Conn := TUtilConexaoFireDac.getConn;
          loLancamentosSaidasM2Provider.Table := loLancamentosSaidasM2;
          loLancamentosSaidasM2Provider.Insert;
          dmImportacaoViaEfd.cdsDFSM2Temp.Next;
          NGauge.Progress := dmImportacaoViaEfd.cdsDFSM2Temp.RecNo;
          Application.ProcessMessages;
        end;
        loLancamentosSaidasM2Provider.Conn := nil;
        FreeAndNil(loLancamentosSaidasM2Provider);

        {Inclusão do registros DFSM2_Analiticos.}
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.First;
        NGauge.MaxValue      := dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.RecordCount;
        lblProgresso.Caption := 'Gravando Registros Analíticos de Documentos Fiscais de Saídas Modelo 02.';
        NGauge.Progress      := 0;
        Application.ProcessMessages;
        loLancamentosSaidasM2Analitico := TLancamentosSaidasM2Analitico.Create(TUtilConexaoFireDac.getConn);
        loLancamentosSaidasM2AnaliticoProvider := TLancamentosSaidasM2AnaliticoProvider.Create;
        while not dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Eof do begin

          for liFor := 0 to dmImportacaoViaEfd.qryDFSM2Analitico.FieldCount-1 do begin
            loLancamentosSaidasM2Analitico.FieldByName(dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Fields[liFor].FieldName).AsString := dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName(dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Fields[liFor].FieldName).AsString;
          end;
          if (edtNaturezaReceita.Text <> '') then begin
            loLancamentosSaidasM2Analitico.FieldByName('NATUREZA_RECEITA').AsString := edtNaturezaReceita.Text;
          end;
          loLancamentosSaidasM2AnaliticoProvider.Conn := TUtilConexaoFireDac.getConn;
          loLancamentosSaidasM2AnaliticoProvider.Table := loLancamentosSaidasM2Analitico;
          loLancamentosSaidasM2AnaliticoProvider.Insert;
          dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Next;
          NGauge.Progress := dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.RecNo;
          Application.ProcessMessages;
        end;
        loLancamentosSaidasM2AnaliticoProvider := nil;
        FreeAndNil(loLancamentosSaidasM2AnaliticoProvider);
      end;

      {Inclusão do Lote de Saídas ECF}
      if (edtLoteSaidasECF.Value > 0)
        and (FiLinhaDFS_ECF > 1)
      then begin
        ldblTotalLote := 0;
        while not dmImportacaoViaEfd.cdsDFSEcfTemp.Eof do begin
          ldblTotalLote := ldblTotalLote+dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName('VENDA_BRUTA').AsCurrency;
          dmImportacaoViaEfd.cdsDFSEcfTemp.Next;
        end;
        loLote := TLotes.Create(TUtilConexaoFireDac.getConn,'FLOTE_SAIDA_ECF');
        loLoteProvider := TLotesProvider.Create;

        loLote.FieldByName('ID_FLOTE_SAIDA_ECF').AsString   := FsIdLoteDFS_ECF;
        loLote.FieldByName('FK_PESSOA'         ).AsString   := TUtil.getIDPessoa;
        loLote.FieldByName('MES'               ).AsInteger  := Month(FdDataOperacao);
        loLote.FieldByName('ANO'               ).AsInteger  := Year(FdDataOperacao);
        loLote.FieldByName('NUMERO'            ).AsInteger  := Trunc(edtLoteSaidasECF.Value);
        loLote.FieldByName('VALOR_TOTAL'       ).AsCurrency := ldblTotalLote;

        loLoteProvider.Conn := TUtilConexaoFireDac.getConn;
        loLoteProvider.Table := loLote;
        loLoteProvider.Insert;

        loLoteProvider := nil;
        FreeAndNil(loLoteProvider);

        {Inclusão do registros DFSEcf.}
        dmImportacaoViaEfd.cdsDFSEcfTemp.IndexFieldNames := 'FK_EQUIP_ECF;DATA_EMISSAO;';
        dmImportacaoViaEfd.cdsDFSEcfTemp.First;
        NGauge.MaxValue      := dmImportacaoViaEfd.cdsDFSEcfTemp.RecordCount;
        lblProgresso.Caption := 'Gravando Registros de Documentos Fiscais de Saídas - ECF.';
        NGauge.Progress      := 0;
        Application.ProcessMessages;
        loLancamentosSaidasEcf := TLancamentosSaidasEcf.Create(TUtilConexaoFireDac.getConn);
        loLancamentosSaidasEcfProvider := TLancamentosSaidasEcfProvider.Create;
        while not dmImportacaoViaEfd.cdsDFSEcfTemp.Eof do begin
          for liFor := 0 to dmImportacaoViaEfd.qryDFSEcf.FieldCount-1 do begin
            lsNomeCampo := dmImportacaoViaEfd.qryDFSEcf.Fields[liFor].FieldName;
            loTipoCampo := dmImportacaoViaEfd.qryDFSEcf.Fields[liFor].DataType;
            if (not dmImportacaoViaEfd.cdsDFSEcfTemp.Fields[liFor].IsNull) then begin
              if (loTipoCampo in [Data.DB.ftTimeStamp]) then begin
                loLancamentosSaidasEcf.FieldByName(lsNomeCampo).AsDate  := EncodeDate(dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByname(lsNomeCampo).AsSQLTimeStamp.Year,
                                                                                                                    dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByname(lsNomeCampo).AsSQLTimeStamp.Month,
                                                                                                                    dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByname(lsNomeCampo).AsSQLTimeStamp.Day);
              end else begin
                loLancamentosSaidasEcf.FieldByName(lsNomeCampo).AsValue := dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName(lsNomeCampo).AsVariant;
              end;
            end else begin
              loLancamentosSaidasEcf.FieldByName(lsNomeCampo).AsValue := null;
            end;
          end;
          loLancamentosSaidasEcfProvider.Conn := TUtilConexaoFireDac.getConn;
          loLancamentosSaidasEcfProvider.Table := loLancamentosSaidasEcf;
          loLancamentosSaidasEcfProvider.Insert;
          dmImportacaoViaEfd.cdsDFSEcfTemp.Next;
          NGauge.Progress := dmImportacaoViaEfd.cdsDFSEcfTemp.RecNo;
          Application.ProcessMessages;
        end;
        loLancamentosSaidasEcfProvider := nil;
        FreeAndNil(loLancamentosSaidasEcfProvider);

        {Inclusão do registros DFSEcfAnalitico.}
        dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.First;
        NGauge.MaxValue      := dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.RecordCount;
        lblProgresso.Caption := 'Gravando Registros Analíticos de Documentos Fiscais de Saídas - ECF.';
        NGauge.Progress      := 0;
        Application.ProcessMessages;
        loLancamentosSaidasEcfAnalitico := TLancamentosSaidasEcfAnalitico.Create(TUtilConexaoFireDac.getConn);
        loLancamentosSaidasEcfAnaliticoProvider := TLancamentosSaidasEcfAnaliticoProvider.Create;
        while not dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.Eof do begin
          for liFor := 0 to dmImportacaoViaEfd.qryDFSEcfAnalitico.FieldCount-1 do begin
            loLancamentosSaidasEcfAnalitico.FieldByName(dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.Fields[liFor].FieldName).AsString := dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName(dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.Fields[liFor].FieldName).AsString;
          end;
          if (edtNaturezaReceita.Text <> '') then begin
            loLancamentosSaidasEcfAnalitico.FieldByName('NATUREZA_RECEITA').AsString := edtNaturezaReceita.Text;
          end;
          loLancamentosSaidasEcfAnaliticoProvider.Conn := TUtilConexaoFireDac.getConn;
          loLancamentosSaidasEcfAnaliticoProvider.Table := loLancamentosSaidasEcfAnalitico;
          loLancamentosSaidasEcfAnaliticoProvider.Insert;
          dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.Next;
          NGauge.Progress := dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.RecNo;
          Application.ProcessMessages;
        end;
        loLancamentosSaidasEcfAnaliticoProvider := nil;
        FreeAndNil(loLancamentosSaidasEcfAnaliticoProvider);
      end;

      if (FoStrLstErros.Count = 0) then begin
        TUtilConexaoFireDac.Commit(TUtilConexaoFireDac.getConn);
      end else begin
        TUtilConexaoFireDac.RollBack(TUtilConexaoFireDac.getConn);
        FoStrLstErros.Add('Erro ao gravar.');
      end;
    except on e: Exception do
      begin
        TUtilConexaoFireDac.RollBack(TUtilConexaoFireDac.getConn);
        MsgDlg.MsgError('-Erro ao importar a EFD: '+e.Message+'.');
      end;
    end;
  finally
    rInfoConexao.bFireDac := False;
  end;
end;

procedure TFImportacaoViaEfd.Importar;
var
  liForLinha: Integer;
  lsRegistro,lsLinha: string;
begin
  dmImportacaoViaEfd.qryDFModelo.Open;
  FsIdLoteDFE     := CreateClassID;
  FsIdLoteDFS     := CreateClassID;
  FsIdLoteDFS_M2  := CreateClassID;
  FsIdLoteDFS_ECF := CreateClassID;
  FiLinhaDFE      := 1;
  FiLinhaDFS      := 1;
  FiLinhaDFS_M2   := 1;
  FiLinhaDFS_ECF  := 1;
//  FdblTotalLoteEntradas  := 0;
//  FdblTotalLoteSaidas    := 0;
//  FdblTotalLoteSaidasM2  := 0;
//  FdblTotalLoteSaidasEcf := 0;

  for liForLinha := 0 to FoStrLstEfd.Count-1 do begin
    lsLinha := FoStrLstEfd.Strings[liForLinha];
    lsRegistro := StrToken(lsLinha,'|',2);
    lblProgresso.Caption := 'Importando Registro: '+lsRegistro+' Linha: '+IntToStr(liForLinha);
    NGauge.Progress      := liForLinha;
    Application.ProcessMessages;
    if (lsRegistro = '0150') and ((edtLoteEntradas.Value+edtLoteSaidas.Value) > 0) then begin
       ImportarParticipantes(lsLinha);
    end else if (lsRegistro = '0200') then begin
       FoStrLstProdutos.Add(lsLinha);
    end else if (lsRegistro = 'C100') and ((edtLoteEntradas.Value+edtLoteSaidas.Value+edtLoteSaidasModelo2.Value) > 0) then begin
      ImportarRegistroC100(lsLinha,liForLinha);
    end else if (lsRegistro = 'C300') and ((edtLoteSaidasModelo2.Value) > 0) then begin
      ImportarRegistroC300(lsLinha,liForLinha);
    end else if (lsRegistro = 'C400') and (edtLoteSaidasECF.Value > 0) then begin
      ImportarRegistroC400(lsLinha,liForLinha);
    end else if (lsRegistro = 'C500') and ((edtLoteEntradas.Value) > 0) then begin
      ImportarRegistroC500(lsLinha,liForLinha);
    end else if (lsRegistro = 'D100') and ((edtLoteEntradas.Value+edtLoteSaidas.Value) > 0) then begin
      ImportarRegistroD100(lsLinha,liForLinha);
    end else if (lsRegistro = 'D500') and ((edtLoteEntradas.Value) > 0) then begin
      ImportarRegistroD500(lsLinha,liForLinha);
    end;
  end;
end;

procedure TFImportacaoViaEfd.ImportarParticipantes(psLinha: String);
var
  lsIdParticipante,lsNomeParticipante,lsCodigoMunicipio,lsCodigoPais,lsInscMf,
  lsInscMfSemMasc,lsTipoInscMf,lsCodigoParticipante,lsUF,lsIdCidade,lsIdUF: string;
begin
  lsCodigoPais         := StrToken(psLinha,'|',5);
  lsCodigoMunicipio    := StrToken(psLinha,'|',9);
  lsInscMfSemMasc      := Trim(StrToken(psLinha,'|',6));
  lsCodigoParticipante := StrToken(psLinha,'|',3);
  lsNomeParticipante   := StrToken(psLinha,'|',4);
  if (Length(lsInscMfSemMasc) = 14) then begin
    lsTipoInscMf := 'CNPJ';
    lsInscMf     := InscMfCMasc(lsInscMfSemMasc,lsTipoInscMf);
  end else begin
    lsTipoInscMf := 'CPF';
    lsInscMfSemMasc := Trim(StrToken(psLinha,'|',7));
    if (Length(lsInscMfSemMasc) = 11) then begin
      lsInscMf := InscMfCMasc(lsInscMfSemMasc,lsTipoInscMf);
    end else begin
      lsInscMf := lsInscMfSemMasc;
    end;
  end;

//  if (lsInscMfSemMasc <> '')
//    and (dmImportacaoViaEfd.cdsParticipanteTemp.Locate('INSCMF',lsInscMf,[]))
//  then begin
//    FoStrLstErros.Add('Existe mais de um registro para o mesmo participante '+lsTipoInscMf+' '+lsInscMf+', com os códigos '+lsCodigoParticipante+' e '+dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('COD_PART').AsString+'.');
//  end else if (dmImportacaoViaEfd.cdsParticipanteTemp.Locate('COD_PART',lsCodigoParticipante,[])) then begin
  if (dmImportacaoViaEfd.cdsParticipanteTemp.Locate('COD_PART',lsCodigoParticipante,[])) then begin
    FoStrLstErros.Add('Existe mais de um registro para o mesmo participante com o código '+lsCodigoParticipante+'.',True);
  end else begin
    if (fSoNumeros(lsInscMf) <> '')
      and (dmImportacaoViaEfd.cdsParticipanteTemp.Locate('INSCMF',lsInscMf,[]))
    then begin
//      FoStrLstErros.Add('Existe mais de um registro para o mesmo participante com os códigos '+lsCodigoParticipante+' e '+dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('COD_PART').AsString+'.',True);
      {Se existir mais de um registro 0150 com o mesmo CNPJ, então, pega o ID
      e as informações de UF, ID da cidade e do estado, e marca o registro como
      já existente, para que não tente gravar o participante mais de uma vez na
      tabela FPARTICIPANTES}
      lsIdParticipante := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
      lsUF             := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('UF'              ).AsString;
      lsIdCidade       := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_CIDADE'       ).AsString;
      lsIdUF           := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_ESTADO'       ).AsString;
      dmImportacaoViaEfd.cdsParticipanteTemp.Insert;
      dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('EXISTE').AsInteger := -1;
    end else if (lsInscMfSemMasc <> '')
      and (dmImportacaoViaEfd.qryParticipante.Locate('INSCMF',lsInscMf,[]))
    then begin
      dmImportacaoViaEfd.cdsParticipanteTemp.Insert;
      lsIdParticipante := dmImportacaoViaEfd.qryParticipante.FieldByName('ID_FPARTICIPANTE').AsString;
      lsUF             := dmImportacaoViaEfd.qryParticipante.FieldByName('SIGLA_UF'        ).AsString;
      lsIdCidade       := dmImportacaoViaEfd.qryParticipante.FieldByName('ID_CIDADES'      ).AsString;
      lsIdUF           := dmImportacaoViaEfd.qryParticipante.FieldByName('ID_ESTADOS'      ).AsString;
      dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('EXISTE').AsInteger := -1;
    end else if (lsInscMfSemMasc = '')
      and (dmImportacaoViaEfd.qryParticipante.Locate('CODIGO_PARTICIPANTE_EMPRESA',lsCodigoParticipante,[]))
    then begin
      dmImportacaoViaEfd.cdsParticipanteTemp.Insert;
      lsIdParticipante := dmImportacaoViaEfd.qryParticipante.FieldByName('ID_FPARTICIPANTE').AsString;
      lsUF             := dmImportacaoViaEfd.qryParticipante.FieldByName('SIGLA_UF'        ).AsString;
      lsIdCidade       := dmImportacaoViaEfd.qryParticipante.FieldByName('ID_CIDADES'      ).AsString;
      lsIdUF           := dmImportacaoViaEfd.qryParticipante.FieldByName('ID_ESTADOS'      ).AsString;
      dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('EXISTE').AsInteger := -1;
    end else begin
      dmImportacaoViaEfd.qryCidadeEstado.Close;
      dmImportacaoViaEfd.qryCidadeEstado.ParamByName('pCodigoMunicipio').AsString := lsCodigoMunicipio;
      dmImportacaoViaEfd.qryCidadeEstado.Open;
      lsUF       := dmImportacaoViaEfd.qryCidadeEstado.FieldByName('SIGLA_UF'  ).AsString;
      lsIdCidade := dmImportacaoViaEfd.qryCidadeEstado.FieldByName('ID_CIDADES').AsString;
      lsIdUF     := dmImportacaoViaEfd.qryCidadeEstado.FieldByName('ID_ESTADOS').AsString;
      {Só grava esses dados na tabela cdsParticipanteTemp se ele não existir na
      base da empresa, pois será necessário para gravar o registro do participante.
      Caso ele já exista, só grava em cdsParticipanteTemp o ID da tabela
      persistente e o código do campo e do registro 0150 (porque é através dele
      que é feita a pesquisa na tabela cdsParticipanteTemp para associar os
      lançamentos dos recitros C100}
//      if (dmImportacaoViaEfd.cdsParticipanteTemp.Locate('INSCMF',lsInscMf,[])) then begin
//        lsIdParticipante := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
//      end else begin
        lsIdParticipante := CreateClassID;
//      end;
      dmImportacaoViaEfd.cdsParticipanteTemp.Insert;
      dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('EXISTE'  ).AsInteger := 0;
      dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('INSCMF'  ).AsString  := lsInscMf;
      dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('NOME'    ).AsString  := StrToken(psLinha,'|',4);
      dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('IE'      ).AsString  := StrToken(psLinha,'|',8);
      dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('END'     ).AsString  := StrToken(psLinha,'|',11);
      dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('NUMERO'  ).AsString  := StrToken(psLinha,'|',12);
      dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('COMPL'   ).AsString  := StrToken(psLinha,'|',13);
      dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('BAIRRO'  ).AsString  := StrToken(psLinha,'|',14);
      if (lsInscMfSemMasc.IsEmpty)
        and ((not lsUF.IsEmpty)
        or (lsCodigoPais = '1058')) {1058 - Brasil}
      then begin
        FoStrLstErros.Add('-Participante nacional: '+lsCodigoParticipante+'-'+lsNomeParticipante+'. Motivo: Sem inscrição no Ministério da Fazenda.',True);
        {Coloca o FLAG -1 no campo EXISTE que é para não deixar gravar na
        tabela FPARTICIPANTE}
        dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('EXISTE').AsInteger := -1;
      end;
    end;
    dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString  := lsIdParticipante;
    dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('UF'              ).AsString  := lsUF;
    dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_CIDADE'       ).AsString  := lsIdCidade;
    dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_ESTADO'       ).AsString  := lsIdUF;
    dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('COD_PART'        ).AsString  := lsCodigoParticipante;
    dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('COD_MUN'         ).AsString  := lsCodigoMunicipio;
    dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('COD_PAIS'        ).AsString  := lsCodigoPais;
    dmImportacaoViaEfd.cdsParticipanteTemp.Post;
  end;
end;

procedure TFImportacaoViaEfd.ImportarRegistroC100(psLinha: String;
  piNumeroLinha: Integer);
var
  lsLinha,lsLinha190,
//  lsEntradaSaida,
  lsCodigoSituacao,lsSerie,lsModelo,lsIdModelo,
  lsCstIcms,lsCstIcms190,lsCstIpi,lsCstPisCofins,lsInscMf,lsIdCfop,lsCfop,
  lsCodigoMunicipioParticipante,lsRegistro,lsCstIcmsOriginal,lsCstIpiOriginal,
  lsCstPisCofinsOriginal,lsIdParticipante,lsUfParticipante,lsIdUfParticipante,
  lsCodParticipante,lsIndicadorEmitente,lsIdDFE,lsIdDFS,lsDescricaoTipoDF,
  lsCodigoProduto: string;
  ldDataEmissao,ldDataEntradaSaida: TDate;
  liNumeroLinha,liNumeroLinha190,liNumero,liCfop,liIndicadorFrete,
  liIndicadorPgto,liCfopOperacao,liCfopUtilizacao: Integer;
  ldblVlTotalC100,ldblVlTotalItensC100,ldblVlOperacao,ldblAbatimento,
  ldblDesconto,ldblBaseIcms,ldblBaseIcmsDifAlq,ldblValorRedBC,ldblAliquotaIcms,
  ldblAliquotaIcms190,ldblValorIcms,ldblBaseIcmsST,ldblValorIcmsST,ldblBaseIpi,
  ldblValorIpi,ldblBasePisCofins,ldblAliquotaPis,ldblAliquotaCofins,
  ldblAliquotaIr,ldblAliqIcmsDifAlq,ldblVlOperacao190: Currency;
  lbExisteRegistroC170,lbExisteRegistroC190,lbRegistro190: Boolean;
  loStrLstCstIcms190: TStringList;
  leEntradaSaida: TEntradaSaida;
begin
  loStrLstCstIcms190 := TStringList.Create;
  try
    Application.ProcessMessages;
    lsRegistro          := StrToken(psLinha,'|',2);
//    lsEntradaSaida      := StrToken(psLinha,'|',3);
    if (StrToken(psLinha,'|',3) = '0') then begin
      leEntradaSaida := TEntradaSaida.tes_entrada;
    end else begin
      leEntradaSaida := TEntradaSaida.tes_saida;
    end;

    lsCodParticipante   := StrToken(psLinha,'|',5);
    lsCodigoSituacao    := StrToken(psLinha,'|',7);
    lsIndicadorEmitente := StrToken(psLinha,'|',4);
    liIndicadorFrete := 0;
    if (not TryStrToInt(StrToken(psLinha,'|',18),liIndicadorFrete)) then begin
      liIndicadorFrete := 0;
    end;
    if (liIndicadorFrete = 9) then begin
      liIndicadorFrete := 3;
    end;
    liIndicadorPgto := 0;
    TryStrToInt(StrToken(psLinha,'|',14),liIndicadorPgto);
    if (liIndicadorPgto = 9) then begin
      liIndicadorPgto := 2;
    end;

    lsModelo := StrToken(psLinha,'|',6);

    if (Pos(lsCodigoSituacao,'00*01*02*03*04*05*06*07*08') = 0) then begin {Ver ValidaTabela AB}
      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', conteúdo: '+lsCodigoSituacao+'. Código de situação do documento fiscal inválido.',True);
    end;
    ldDataEmissao := StrSemBarrasToDate(StrToken(psLinha,'|',11));
    if (ldDataEmissao = 0) then begin
      if (lsModelo = '65') then begin
        ldDataEmissao := BeginOfMonth(FdDataOperacao);
      end else begin
        ldDataEmissao := FdDataOperacao;
      end;
      if (Pos(lsCodigoSituacao,'02*03*04*05') = 0) then begin {Documento cancelado}
        FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', Data de emissão do documento fiscal inválida. ('+StrToken(psLinha,'|',11)+'.',True);
      end;
    end;
    ldDataEntradaSaida := StrSemBarrasToDate(StrToken(psLinha,'|',12));
    if (ldDataEntradaSaida = 0) then begin
      if (lsIndicadorEmitente = '0') then begin
        ldDataEntradaSaida := ldDataEmissao;
      end else begin
        ldDataEntradaSaida := FdDataOperacao;
        if (Pos(lsCodigoSituacao,'02*03*04*05') = 0) then begin {Documento cancelado}
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', data de entrada/saída do documento fiscal inválida. ('+StrToken(psLinha,'|',12)+'.',True);
        end;
      end;
    end;

    if (dmImportacaoViaEfd.qryDFModelo.Locate('CODIGO',lsModelo,[])) then begin
      lsIdModelo := dmImportacaoViaEfd.qryDFModelo.FieldByName('ID_FDF_MODELO').AsString;
    end else begin
      lsIdModelo := '';
    end;
    if (lsIdModelo.IsEmpty)
      or ((not (dmImportacaoViaEfd.qryDFModelo.FieldByName('TIPO_DE_USO').AsInteger in ([0,2])))
      and ((dmImportacaoViaEfd.qryDFModelo.FieldByName('MODELO').AsString <> '65')
      or (leEntradaSaida <> TEntradaSaida.tes_saida)))
    then begin
      {Na importação de registro C100 é permitido os tipos de uso 0 e 2 e as Modelo 65 - NFC-e de saídas}
      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', modelo do documento fiscal '+lsModelo+' inválido para o tipo de operação. ',True);
    end;

    lsSerie  := StrToken(psLinha,'|',8);

    liNumero := 0;
    TryStrToInt(StrToken(psLinha,'|',9),liNumero);
    if (liNumero <= 0) then begin
      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', Documento fiscal com número inválido.',True);
    end;

    if (pos(lsCodigoSituacao,'02*03*04*05') > 0)
      and (leEntradaSaida = TEntradaSaida.tes_entrada)
    then begin
//      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', Documento fiscal de entrada cancelado, denegado ou com numeração inutilizada, não ser lançado.',True);
      FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', Documento fiscal de entrada cancelado, denegado ou com numeração inutilizada, não ser lançado.',True);
    end;

    if (lsSerie = '') or (Length(lsSerie) > 3) then begin
      lsSerie := '1';
    end;

    ldblVlTotalC100 := 0;
    ldblDesconto    := 0;
    ldblAbatimento  := 0;

    TryStrToCurr(StrToken(psLinha,'|',13),ldblVlTotalC100);
    TryStrToCurr(StrToken(psLinha,'|',15),ldblDesconto);
    TryStrToCurr(StrToken(psLinha,'|',16),ldblAbatimento);

    if ((leEntradaSaida = TEntradaSaida.tes_entrada) and (edtLoteEntradas.Value > 0))
      or ((leEntradaSaida = TEntradaSaida.tes_saida) and (lsModelo <> '65') and (edtLoteSaidas.Value > 0))
      or ((leEntradaSaida = TEntradaSaida.tes_saida) and (lsModelo = '65') and (edtLoteSaidasModelo2.Value > 0))
    then begin
      if leEntradaSaida = TEntradaSaida.tes_entrada then begin {Entrada}
        if (pos(lsCodigoSituacao,'02*03*04*05') = 0) then begin
          if (ldDataEntradaSaida < ldDataEmissao) then begin
            FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', A data de entrada não pode ser inferior a data de emissão.',True);
          end;

          if (Pos(lsCodigoSituacao,'02,03,04,05') > 0) then begin {Documento cancelado, denegado, complementar, etc.}
            FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', documento fiscal Nº '+IntToStr(liNumero)+', não deve ser lançado na entrada.',True);
          end else if (ldblVlTotalC100 <= 0) and (Pos(lsCodigoSituacao,'06*07') = 0) then begin {Documento cancelado, denegado, etc.}
            FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', documento fiscal Nº '+IntToStr(liNumero)+', sem valor.',True);
          end;

          if (ldDataEntradaSaida < rInfoAplicacao.dDataInicioPessoa) then begin
            FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+', Documento fiscal '+IntToStr(liNumero)+' A data de entrada do documento fiscal não pode ser inferior a data que empresa iniciou o uso do MegaFiscal',True);
          end else if (rInfoAplicacao.dDataInicioParametros < TP_DATA_INICIAL)
            or (rInfoAplicacao.dDataInicioParametros > ldDataEntradaSaida)
          then begin
            FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+', Documento fiscal '+IntToStr(liNumero)+'-Não existem parâmetros cadastrados para a data de '+DateToStr(ldDataEntradaSaida)+'.',True);
          end;

          lsDescricaoTipoDF := 'Entrada';
          if (dmImportacaoViaEfd.cdsParticipanteTemp.Locate('COD_PART',lsCodParticipante,[])) then begin
            lsUfParticipante := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('UF').AsString;

            dmImportacaoViaEfd.qryVerificaDFE.Close;
            dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pIdPessoa'      ).AsString  := TUtil.getIDPessoa;
            dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pIdDFModelo'    ).AsString  := lsIdModelo;
            dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pSerie'         ).AsString  := lsSerie;
            dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pNumero'        ).AsInteger := liNumero;
            dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pIdParticipante').AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
            dmImportacaoViaEfd.qryVerificaDFE.Open;

            if (not dmImportacaoViaEfd.qryVerificaDFE.IsEmpty) then begin
              FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+', Documento fiscal '+IntToStr(liNumero)+' lançado em '+dmImportacaoViaEfd.qryVerificaDFE.FieldByName('DATA_ENTRADA').AsString+', no lote de entradas '+IntToStr(dmImportacaoViaEfd.qryVerificaDFE.FieldByName('NUMERO').AsInteger)+', Linha '+IntToStr(dmImportacaoViaEfd.qryVerificaDFE.FieldByName('LINHA').AsInteger)+'.',True);
            end;
            lsIdDFE := CreateClassID;
            dmImportacaoViaEfd.cdsDFETemp.Insert;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('ID_FDFE'           ).AsString   := lsIdDFE;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_PESSOA'         ).AsString   := TUtil.getIDPessoa;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_LOTE'           ).AsString   := FsIdLoteDFE;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('LINHA'             ).AsInteger  := FiLinhaDFE;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('INDICADOR_EMITENTE').AsString   := lsIndicadorEmitente;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_PARTICIPANTE'   ).AsString   := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_DF_MODELO'      ).AsString   := lsIdModelo;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('CODIGO_SITUACAO'   ).AsString   := lsCodigoSituacao;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('SERIE'             ).AsString   := lsSerie;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('NUMERO'            ).AsInteger  := liNumero;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('CHAVE_NFE'         ).AsString   := StrToken(psLinha,'|',10);
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('DATA_EMISSAO'      ).AsDateTime := ldDataEmissao;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('DATA_ENTRADA'      ).AsDateTime := ldDataEntradaSaida;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('VALOR'             ).AsCurrency := ldblVlTotalC100;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('INDICADOR_PGTO'    ).AsInteger  := liIndicadorPgto;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('INDICADOR_FRETE'   ).AsInteger  := liIndicadorFrete;
            dmImportacaoViaEfd.cdsDFETemp.FieldByName('ART_377_RICMS'     ).AsInteger  := 0;
            try
              dmImportacaoViaEfd.cdsDFETemp.Post;
            except
              dmImportacaoViaEfd.cdsDFETemp.Post;
            end;
            Inc(FiLinhaDFE);
          end else begin
            FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', participante código '+lsCodParticipante+' não consta no registro 0150.',True);
          end;
        end;
      end else begin  {Saída}
        lsIdParticipante   := '';
        lsUfParticipante   := '';
        lsIdUfParticipante := '';

        if (ldDataEntradaSaida < ldDataEmissao) then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', A data de saída não pode ser inferior a data de emissão.',True);
        end;
        if (ldDataEntradaSaida < rInfoAplicacao.dDataInicioPessoa) then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+', Documento fiscal '+IntToStr(liNumero)+' A data de emissão do documento fiscal não pode ser inferior a data que empresa iniciou o uso do MegaFiscal',True);
        end else if (rInfoAplicacao.dDataInicioParametros < TP_DATA_INICIAL)
          or (rInfoAplicacao.dDataInicioParametros > ldDataEmissao)
        then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+', Documento fiscal '+IntToStr(liNumero)+'-Não existem parâmetros cadastrados para a data de '+DateToStr(ldDataEntradaSaida)+'.',True);
        end;

        lsDescricaoTipoDF := 'Saída';
        if ((edtLoteSaidas.Value > 0) and (lsModelo <> '65'))
//          or ((edtLoteSaidasModelo2.Value > 0) and (lsModelo = '65'))
        then begin
          lsIdParticipante   := '';
          lsUfParticipante   := '';
          lsIdUfParticipante := '';
          if (dmImportacaoViaEfd.cdsParticipanteTemp.Locate('COD_PART',lsCodParticipante,[])) then begin
            lsCodigoMunicipioParticipante := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('COD_MUN').AsString;
            dmImportacaoViaEfd.qryVerificaDFS.Close;
            dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pIdPessoa'      ).AsString  := TUtil.getIDPessoa;
            dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pIdDFModelo'    ).AsString  := lsIdModelo;
            dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pSerie'         ).AsString  := lsSerie;
            dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pNumero'        ).AsInteger := liNumero;
            dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pIdParticipante').AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
            dmImportacaoViaEfd.qryVerificaDFS.Open;
            lsIdParticipante   := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
            lsUfParticipante   := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('UF'              ).AsString;
            lsIdUfParticipante := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_ESTADO'       ).AsString;
          end else if (lsModelo = '65') then begin
            lsCodigoMunicipioParticipante := FsCodigoMunicipioPessoa;
          end;
          if (not dmImportacaoViaEfd.qryVerificaDFS.IsEmpty) then begin
            FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+', Documento fiscal '+IntToStr(liNumero)+' lançado em '+dmImportacaoViaEfd.qryVerificaDFS.FieldByName('DATA_EMISSAO').AsString+', no lote de saídas '+IntToStr(dmImportacaoViaEfd.qryVerificaDFS.FieldByName('NUMERO').AsInteger)+', Linha '+IntToStr(dmImportacaoViaEfd.qryVerificaDFS.FieldByName('LINHA').AsInteger)+'.',True);
          end;

          if (lsIdUfParticipante.IsEmpty) then begin
            if (not dmImportacaoViaEfd.qryCidadeEstado.Active)
              or (dmImportacaoViaEfd.qryCidadeEstado.FieldByName('CODIGO_IBGE').AsString <> lsCodigoMunicipioParticipante)
            then begin
              dmImportacaoViaEfd.qryCidadeEstado.Close;
              dmImportacaoViaEfd.qryCidadeEstado.ParamByName('pCodigoMunicipio').AsString := lsCodigoMunicipioParticipante;
              dmImportacaoViaEfd.qryCidadeEstado.Open;
              lsUfParticipante := dmImportacaoViaEfd.qryCidadeEstado.FieldByName('SIGLA_UF').AsString;
            end;
            lsIdUfParticipante := dmImportacaoViaEfd.qryCidadeEstado.FieldByName('ID_ESTADOS').AsString;
            if (lsIdUfParticipante = '') then begin
              lsIdUfParticipante := '{08DAC80A-2F40-484F-8591-619FC9497DE8}';
  //            lsIdUfParticipante := FsIdUfPessoa;
  //            lsUfParticipante   := FsUFPessoa;
            end;
          end;

          lsIdDFS := CreateClassID;
//          if (lsModelo <> '65') then begin {NFc-e}
            dmImportacaoViaEfd.cdsDFSTemp.Insert;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('ID_FDFS'           ).AsString   := lsIdDFS;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_PESSOA'         ).AsString   := TUtil.getIDPessoa;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_LOTE'           ).AsString   := FsIdLoteDFS;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('LINHA'             ).AsInteger  := FiLinhaDFS;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('INDICADOR_EMITENTE').AsString   := lsIndicadorEmitente;
            if (lsIdParticipante <> '') then begin
              dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_PARTICIPANTE'   ).AsString   := lsIdParticipante;
            end;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_ESTADO'         ).AsString   := lsIdUfParticipante;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_DF_MODELO'      ).AsString   := lsIdModelo;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('CODIGO_SITUACAO'   ).AsString   := lsCodigoSituacao;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('SERIE'             ).AsString   := lsSerie;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('NUMERO'            ).AsInteger  := liNumero;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('CHAVE_NFE'         ).AsString   := StrToken(psLinha,'|',10);
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('DATA_EMISSAO'      ).AsDateTime := ldDataEmissao;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('DATA_SAIDA'        ).AsDateTime := ldDataEntradaSaida;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('VALOR'             ).AsCurrency := ldblVlTotalC100;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('INDICADOR_PGTO'    ).AsInteger  := liIndicadorPgto;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('INDICADOR_FRETE'   ).AsInteger  := liIndicadorFrete;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('ART_377_RICMS'     ).AsInteger  := 0;
            dmImportacaoViaEfd.cdsDFSTemp.Post;
            Inc(FiLinhaDFS);
//          end else begin
//            dmImportacaoViaEfd.cdsDFSM2Temp.Insert;
//            dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('ID_FDFS_M2'        ).AsString   := lsIdDFS;
//            dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('FK_PESSOA'         ).AsString   := TUtil.getIDPessoa;
//            dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('FK_LOTE'           ).AsString   := FsIdLoteDFS_M2;
//            dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('LINHA'             ).AsInteger  := FiLinhaDFS_M2;
//            dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('FK_DF_MODELO'      ).AsString   := lsIdModelo;
//            dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('CODIGO_SITUACAO'   ).AsString   := lsCodigoSituacao;
//            dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('SERIE'             ).AsString   := lsSerie;
//            dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('NUMERO_INICIAL'    ).AsInteger  := liNumero;
//            dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('NUMERO_FINAL'      ).AsInteger  := liNumero;
//            dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('DATA_EMISSAO'      ).AsDateTime := ldDataEmissao;
//            dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('VALOR'             ).AsCurrency := ldblVlTotalC100;
//            dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('ART_377_RICMS'     ).AsInteger  := 0;
//            dmImportacaoViaEfd.cdsDFSM2Temp.Post;
//            Inc(FiLinhaDFS_M2);
//          end;
        end;
      end;
      if (lsModelo = '') then begin
        FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', conteúdo: '+lsModelo+'. Modelo do documento fiscal inválido.',True);
      end;

      liNumeroLinha := piNumeroLinha+1;
      lsRegistro := StrToken(FoStrLstEfd.Strings[liNumeroLinha],'|',2);
      lbExisteRegistroC170 := False;
      lbExisteRegistroC190 := False;
      ldblVlTotalItensC100 := 0;
      {Limpa o loStrLstCstIcms190 que armazenará os CST ICMS C190 desse Documento
      Fiscal}
      loStrLstCstIcms190.Clear;

      if (pos(lsCodigoSituacao,'02*03*04*05') = 0) then begin
        {Se o documento não foi cancelado...}
        while (liNumeroLinha < FoStrLstEfd.Count-1) and (Copy(lsRegistro,1,2) = 'C1') and (lsRegistro <> 'C100') do begin
          lsLinha := FoStrLstEfd.Strings[liNumeroLinha];

          lblProgresso.Caption := 'Importando Registro: '+lsRegistro+'  '+IntToStr(liNumeroLinha);
          NGauge.Progress      := liNumeroLinha;
          Application.ProcessMessages;

          {ATENÇÃO: As NF de entrada, exceto devolução de vendas, utilizam o
          registro C170 para criar o registro analítico, enquanto as NF de saída e
          as NF de devolução de vendas, por não terem o registro C170, utilizam o
          registro C190. Para isso, o CST-PIS/COFINS deve ser selecionado no
          comboBox pelo usuário.

          OBS: NF de saídas e as devoluções de vendas, tributadas pelo IPI não são
          importadas porque no registro C190 não tem o CST-IPI. Nesse caso, se
          existir no arquivo EFD alguma NF de saída com destaque do IPI, nenhuma NF
          será importada.}

          if (leEntradaSaida = TEntradaSaida.tes_entrada)
            and (edtLoteEntradas.Value > 0)
          then begin {Entrada}
            if (lsRegistro = 'C170') then begin
              lbExisteRegistroC170 := True;
              lsCstIcms      := StrToken(lsLinha,'|',11);

  //            if (lsCstIcms = '101') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '00';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '102') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '41';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '201') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '60';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '202') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '60';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '203') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '60';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '300') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '41';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '400') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '41';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '500') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '60';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '900') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '90';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else begin
                lsCstIcms := Copy(lsCstIcms,2,2);
  //            end;

              lsCstIpi       := StrToken(lsLinha,'|',21);
              lsCstPisCofins := StrToken(lsLinha,'|',26);

              lsCstIcmsOriginal      := lsCstIcms;
              lsCstIpiOriginal       := lsCstIpi;
              lsCstPisCofinsOriginal := lsCstPisCofins;

              lsCfop := StrToken(lsLinha,'|',12);
              if not TryStrToInt(lsCfop,liCfop) then begin
                liCfop := 0;
                FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido.',True);
              end;
              if (not dmImportacaoViaEfd.qryCfop.Active)
                or (dmImportacaoViaEfd.qryCfop.Eof)
                or (dmImportacaoViaEfd.qryCfop.FieldByName('CODIGO').AsString <> lsCfop)
              then begin
                dmImportacaoViaEfd.qryCfop.Close;
                dmImportacaoViaEfd.qryCfop.ParamByName('pCfop').AsInteger := liCfop;
                dmImportacaoViaEfd.qryCfop.Open;
                dmImportacaoViaEfd.qryCfop.Filtered := False;
                dmImportacaoViaEfd.qryCfop.Filter   := FsFiltroCfop;
                dmImportacaoViaEfd.qryCfop.Filtered := True;
              end;
              lsIdCfop := dmImportacaoViaEfd.qryCfop.FieldByName('ID_FCFOP'  ).AsString;

              if (lsIdCfop = '') then begin
                FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido.',True);
              end else if ((lsUfParticipante = FsUFPessoa) and (Copy(lsCfop,1,1) <> '1'))
                or ((not lsUfParticipante.IsEmpty) and (lsUfParticipante <> FsUFPessoa) and (Copy(lsCfop,1,1) <> '2'))
                or ((lsUfParticipante.IsEmpty) and (Copy(lsCfop,1,1) <> '3'))
              then begin
                if (not lsUfParticipante.IsEmpty) then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido para aquisições de '+lsUfParticipante+'.',True);
                end else if (lsModelo <> '65') then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido para aquisições do exterior.',True);
                end;
              end;

              liCfopOperacao   := dmImportacaoViaEfd.qryCfop.FieldByName('OPERACAO'  ).AsInteger;
              liCfopUtilizacao := dmImportacaoViaEfd.qryCfop.FieldByName('UTILIZACAO').AsInteger;

              ldblVlOperacao     := 0;
              ldblDesconto       := 0;
              ldblBaseIcms       := 0;
              ldblAliquotaICMS   := 0;
              ldblValorIcms      := 0;
              ldblBaseIpi        := 0;
              ldblValorIpi       := 0;
              ldblBaseIcmsST     := 0;
              ldblValorIcmsST    := 0;
              ldblBasePisCofins  := 0;
              ldblAliquotaPis    := 0;
              ldblAliquotaCofins := 0;
              ldblValorRedBC     := 0;
              ldblBaseIcmsDifAlq := 0;
              ldblAliqIcmsDifAlq := 0;

              TryStrToCurr(StrToken(lsLinha,'|',08),ldblVlOperacao    );
              TryStrToCurr(StrToken(lsLinha,'|',09),ldblDesconto      );
              TryStrToCurr(StrToken(lsLinha,'|',14),ldblBaseIcms      );
              TryStrToCurr(StrToken(lsLinha,'|',15),ldblAliquotaIcms  );
              TryStrToCurr(StrToken(lsLinha,'|',16),ldblValorIcms     );
              TryStrToCurr(StrToken(lsLinha,'|',17),ldblBaseIcmsST    );
              TryStrToCurr(StrToken(lsLinha,'|',19),ldblValorIcmsST   );
              TryStrToCurr(StrToken(lsLinha,'|',23),ldblBaseIpi       );
              TryStrToCurr(StrToken(lsLinha,'|',25),ldblValorIpi      );
              TryStrToCurr(StrToken(lsLinha,'|',27),ldblBasePisCofins );
              TryStrToCurr(StrToken(lsLinha,'|',28),ldblAliquotaPis   );
              TryStrToCurr(StrToken(lsLinha,'|',34),ldblAliquotaCofins);

              if (Pos(lsCstIcms,'20*70') > 0) then begin
                ldblValorRedBC := ldblVlOperacao-(ldblDesconto+ldblBaseIcms+ldblValorIpi+ldblValorIcmsST);
                if (ldblValorRedBC < 0) then begin
                  ldblValorRedBC := 0;
                end;
              end else if (Pos(lsCstIcms,'00*10*30*40*41*50*51*60**90') = 0) then begin
                if (lsCstIcms <> '90') then begin
                  FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS 90.',True);
                end;
                lsCstIcms        := '90';
                ldblBaseIcms     := 0;
                ldblAliquotaIcms := 0;
                ldblValorIcms    := 0;
              end;

              if (Pos(lsCstIpi,'01*02*03*04*05*49') = 0)
                or (not TFUtil.getExerceAtividade(TEmpresaExerceAtividade.opIndustria,ldDataEntradaSaida))
                or (liCfopOperacao <> rInfoConstantes.iOprCompraAquisicaoVenda)
                or ((liCfopUtilizacao <> rInfoConstantes.iUtilIndustrializacao)
                and (liCfopUtilizacao <> rInfoConstantes.iUtilIndustrializacaoEncomenda))
              then begin
                ldblBaseIpi := 0;
                lsCstIpi    := '49';
              end;
              if (Pos(lsCstPisCofins,'50*51*52*53*54*55*56*60*61*62*63*64*65*66*67*70*71*72*73*74*75*98') = 0) then begin
                lsCstPisCofins     := '98';
                ldblBasePisCofins  := 0;
                ldblAliquotaPis    := 0;
                ldblAliquotaCofins := 0;
              end else if (Pos(lsCstPisCofins,'50*51*52*53*54*55*56*60*61*62*63*64*65*66*67') > 0)
                and ((FeRegimeFederal <> TTipoRegimeFederal.trf_lucro_real)
                or (liCfopOperacao <> rInfoConstantes.iOprDevolucaoAnulacao))
              then begin
                lsCstPisCofins     := '98';
                ldblBasePisCofins  := 0;
                ldblAliquotaPis    := 0;
                ldblAliquotaCofins := 0;
              end else begin
                lsCstPisCofins     := '98';
                ldblBasePisCofins  := 0;
                ldblAliquotaPis    := 0;
                ldblAliquotaCofins := 0;
              end;

              if (dmImportacaoViaEfd.qryCfop.FieldByName('OPERACAO').AsInteger = rInfoConstantes.iOprDevolucaoAnulacao) then begin
                ldblAliquotaIr := rAliquotaOperacao.dblIR;
              end else begin
                ldblAliquotaIr := 0;
              end;

              if (Pos(lsCodigoSituacao,'06*07') > 0)
                and ((ldblValorIcms+ldblValorIpi+ldblValorIcmsST) = 0)
              then begin
               FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Documento fiscal complementar é necessário possuir valor de ICMS, ICMS Subitituição Tributária ou IPI.',True);
              end;

              if (Pos(lsCfop,'2551*2552*2556*2557') > 0)
                and (Pos(lsCstIcms,'00*10*20') > 0)
              then begin
                lsCodigoProduto := StrToken(lsLinha,'|',4);
                ldblAliqIcmsDifAlq := LocalizaAliquotaInProdutos(lsCodigoProduto,ldDataEntradaSaida);

                if (ldblBaseIcms = 0) then begin
                  ldblBaseIcmsDifAlq := ldblVlOperacao;
                end else begin
                  ldblBaseIcmsDifAlq := ldblBaseIcms+ldblValorIpi;
                end;
                ldblBaseIcms := 0;
              end;

              if (ldblAliquotaIcms < 0)
                or (ldblAliquotaIcms > 38)
              then begin
                FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Alíquota do ICMS '+CurrToStr(ldblAliquotaIcms)+' inválida.',True);
              end;

              if (ldblBaseIcms = 0)
                and (Pos(lsCstIcms,'00*10*20') > 0)
              then begin
                FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', para CST/ICMS '+lsCstIcms+', é necessário informar a base de cálculo do ICMS.',True);
              end else if (ldblBaseIcms <> 0)
                and (Pos(lsCstIcms,'00*10*20') = 0)
              then begin
                FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', para CST/ICMS '+lsCstIcms+', não deve ser informada a base de cálculo do ICMS.',True);
              end;

              if (FeRegimeFederal in ([TTipoRegimeFederal.trf_simples_nacional,TTipoRegimeFederal.trf_mei]))
                and (lsCfop = '2551')
              then begin
                lsCstIcms      := '90';
                lsCstIpi       := '49';
                lsCstPisCofins := '98';
              end;

  //            if (lsModelo <> '65') then begin {NFC-e}
              if (FoStrLstErros.Count = 0) then begin
                if dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Locate('FK_DFE;FK_CFOP;CST_ICMS;CST_IPI;CST_PIS_COFINS;ALIQUOTA_ICMS;ALIQUOTA_PIS;ALIQUOTA_COFINS;ALIQUOTA_IR',VarArrayOf([lsIdDFE,lsIdCfop,lsCstIcms,lsCstIpi,lsCstPisCofins,ldblAliquotaIcms,ldblAliquotaPis,ldblAliquotaCofins,ldblAliquotaIr]),[]) then begin
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Edit;
                end else begin
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Insert;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ID_FDFE_ANALITICO'     ).AsString   := CreateClassID;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_DFE'                ).AsString   := lsIdDFE;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_PESSOA'             ).AsString   := TUtil.getIDPessoa;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_ICMS'              ).AsString   := lsCstIcms;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_IPI'               ).AsString   := lsCstIpi;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_PIS_COFINS'        ).AsString   := lsCstPisCofins;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_CFOP'               ).AsString   := lsIdCfop;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_ICMS'         ).AsCurrency := ldblAliquotaIcms;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_PIS'          ).AsCurrency := ldblAliquotaPis;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_COFINS'       ).AsCurrency := ldblAliquotaCofins;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_IR'           ).AsCurrency := ldblAliquotaIr;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('MVA'                   ).AsCurrency := 0;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('TIPO_CFOP'             ).AsString   := '00';
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_AT_AP_DA'    ).AsCurrency := ldblBaseIcmsDifAlq;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_ICMS_AT_AP_DA').AsCurrency := ldblAliqIcmsDifAlq;

                  if (Copy(lsCfop,1,1) = '2')
                    and ((liCfopOperacao = rInfoConstantes.iOprCompraAquisicaoVenda)
                    and (liCfopUtilizacao in ([rInfoConstantes.iUtilComercializacao,rInfoConstantes.iUtilImobilizado,rInfoConstantes.iUtilMaterialConsumo])))
                    or ((rAtividade.bComercio)
                    and (liCfopUtilizacao = rInfoConstantes.iUtilBonificacaoDoacaoBrinde))
                  then begin
                    {Antecipação parcial/Diferencial de Alíquotas}
                    if (liCfopUtilizacao in ([rInfoConstantes.iUtilImobilizado,rInfoConstantes.iUtilMaterialConsumo])) then begin
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('TIPO_AT_AP_DA').AsInteger  := 2;
                    end else begin
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('TIPO_AT_AP_DA').AsInteger  := 1;
                    end;
                    dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_ICMS_AT_AP_DA').AsCurrency := TFUtil.getAliquotaInternaIcms(TUtil.getIDPessoa,ldDataEntradaSaida);
                  end else begin
                    dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('TIPO_AT_AP_DA').AsInteger  := 0;
                  end;
                end;
                ldblVlTotalItensC100 := (ldblVlTotalItensC100+(ldblVlOperacao+ldblValorIpi+ldblValorIcmsST))-ldblDesconto;

                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('REDUCAO_BASE_ICMS').AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('REDUCAO_BASE_ICMS').AsCurrency+ldblValorRedBC;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_OPERACAO'   ).AsCurrency := (dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_OPERACAO'   ).AsCurrency+(ldblVlOperacao+ldblValorIpi+ldblValorIcmsST))-ldblDesconto;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS'        ).AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS'        ).AsCurrency+ldblBaseIcms;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_ICMS'       ).AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_ICMS'       ).AsCurrency+ldblValorIcms;
                if (liCfopOperacao = rInfoConstantes.iOprDevolucaoAnulacao) then begin
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_ST'     ).AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_ST'     ).AsCurrency+ldblBaseIcmsST;
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_ICMS_ST'    ).AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_ICMS_ST'    ).AsCurrency+ldblValorIcmsST;
                end;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_IPI'         ).AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_IPI'         ).AsCurrency+ldblBaseIpi;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_IPI'        ).AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_IPI'        ).AsCurrency+ldblValorIpi;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_PIS_COFINS'  ).AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_PIS_COFINS'  ).AsCurrency+ldblBasePisCofins;

                if (Copy(lsCfop,1,1) = '2')
                  and ((liCfopOperacao = rInfoConstantes.iOprCompraAquisicaoVenda)
                  and (liCfopUtilizacao in ([rInfoConstantes.iUtilComercializacao,rInfoConstantes.iUtilImobilizado,rInfoConstantes.iUtilMaterialConsumo])))
                  or ((rAtividade.bComercio)
                  and (liCfopUtilizacao = rInfoConstantes.iUtilBonificacaoDoacaoBrinde))
                then begin
                  {Antecipação parcial/Diferencial de Alíquotas}
                  dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_AT_AP_DA').AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_AT_AP_DA').AsCurrency+(ldblBaseIcms+ldblValorIpi);
                  if (FeRegimeFederal <> TTipoRegimeFederal.trf_simples_nacional)
                    and (not (liCfopUtilizacao in ([rInfoConstantes.iUtilImobilizado,rInfoConstantes.iUtilMaterialConsumo])))
                  then begin
                    dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CREDITO_ICMS_AT_AP_DA').AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CREDITO_ICMS_AT_AP_DA').AsCurrency+ldblValorIcms;
                  end;
                end;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Post;
              end;
  //            end else begin
  //              {Modelo 65}
  //              if dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Locate('FK_DFS_M2;FK_CFOP;CST_ICMS;CST_PIS_COFINS;ALIQUOTA_ICMS;ALIQUOTA_PIS;ALIQUOTA_COFINS;ALIQUOTA_IR',VarArrayOf([lsIdDFS,lsIdCfop,lsCstIcms,lsCstPisCofins,ldblAliquotaIcms,rAliquotaOperacao.dblPis,rAliquotaOperacao.dblCofins,rAliquotaOperacao.dblIr]),[]) then begin
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Edit;
  //              end else begin
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Insert;
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ID_FDFS_M2_ANALITICO').AsString   := CreateClassID;
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('FK_DFS_M2'           ).AsString   := lsIdDFS;
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('FK_PESSOA'           ).AsString   := TUtil.getIDPessoa;
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('CST_ICMS'            ).AsString   := lsCstIcms;
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('CST_PIS_COFINS'      ).AsString   := lsCstPisCofins;
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('FK_CFOP'             ).AsString   := lsIdCfop;
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_PIS'        ).AsCurrency := rAliquotaOperacao.dblPis;
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_COFINS'     ).AsCurrency := rAliquotaOperacao.dblCofins;
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_IR'         ).AsCurrency := ldblAliquotaIr;
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_ICMS'       ).AsCurrency := ldblAliquotaIcms;
  //              end;
  //              dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('VALOR_OPERACAO' ).AsCurrency := dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('VALOR_OPERACAO' ).AsCurrency+ldblVlOperacao;
  //              dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('BASE_ICMS'      ).AsCurrency := dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('BASE_ICMS'      ).AsCurrency+ldblBaseIcms;
  //              dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('BASE_PIS_COFINS').AsCurrency := dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('BASE_PIS_COFINS').AsCurrency+ldblBasePisCofins;
  //              dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Post;
  //            end;
            end else if (lsRegistro = 'C190') then begin
              if (lbExisteRegistroC170) then begin
                lsCfop := StrToken(lsLinha,'|',4);
                if not TryStrToInt(lsCfop,liCfop) then begin
                  liCfop := 0;
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido.',True);
                end;
                if (not dmImportacaoViaEfd.qryCfop.Active)
                  or (dmImportacaoViaEfd.qryCfop.Eof)
                  or (dmImportacaoViaEfd.qryCfop.FieldByName('CODIGO').AsString <> lsCfop)
                then begin
                  dmImportacaoViaEfd.qryCfop.Close;
                  dmImportacaoViaEfd.qryCfop.ParamByName('pCfop').AsInteger := liCfop;
                  dmImportacaoViaEfd.qryCfop.Open;
                  dmImportacaoViaEfd.qryCfop.Filtered := False;
                  dmImportacaoViaEfd.qryCfop.Filter   := FsFiltroCfop;
                  dmImportacaoViaEfd.qryCfop.Filtered := True;
                end;
                lsIdCfop := dmImportacaoViaEfd.qryCfop.FieldByName('ID_FCFOP'  ).AsString;

                if (lsIdCfop = '') then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido.',True);
                end;

                liNumeroLinha190  := liNumeroLinha;
                lsLinha190        := FoStrLstEfd.Strings[liNumeroLinha190];
                lsCstIcms         := StrToken(lsLinha190,'|',3);
                lsCstIcms         := Copy(lsCstIcms,2,2);

                {Se não foi verificado se o valor dos registros C190, para o
                lsCstIcms corrente, bate com os valores do mesmo lsCstIcms,
                extraídos dos registros C170 e gravados em cdsDFEAnaliticoTemp,
                então, adiciona o lsCstIcms a loStrLstCstIcms190 para que não seja
                mais verificado no próximo loop (caso exista), e verifica.}
                if (loStrLstCstIcms190.IndexOf(lsCstIcms) < 0) then begin
                  loStrLstCstIcms190.Add(lsCstIcms);

                  ldblVlOperacao190 := 0;
                  ldblAliquotaIcms  := 0;
                  TryStrToCurr(StrToken(lsLinha190,'|',5),ldblAliquotaIcms);

                  lbRegistro190 := True;
                  while (lbRegistro190) do begin
                    {Soma os VALOR_OPERACAO de todos os registro C190 (filhos do C100)
                    que tenham o mesmo lsCstIcms e a mesma alíquota do ICMS. Essa
                    operação é necessária porque para o MegaFiscal só está sendo
                    utilizado os dois últimos caractere do CST_ICMS, ou seja a tabela
                    B. Ex: Podem existir 060, 160, 260, 560, etc.}
                    lsCstIcms190        := StrToken(lsLinha190,'|',3);
                    lsCstIcms190        := Copy(lsCstIcms190,2,2);
                    ldblAliquotaIcms190 := 0;
                    TryStrToCurr(StrToken(lsLinha190,'|',5),ldblAliquotaIcms190);

                    if (lsCstIcms190 = lsCstIcms)
                      and (ldblAliquotaIcms190 = ldblAliquotaIcms)
                    then begin
                      ldblVlOperacao := 0;
                      TryStrToCurr(StrToken(lsLinha190,'|',6),ldblVlOperacao);
                      ldblVlOperacao190 := ldblVlOperacao190+ldblVlOperacao;
                    end;
                    Inc(liNumeroLinha190);
                    lsLinha190 := FoStrLstEfd.Strings[liNumeroLinha190];
                    if (StrToken(FoStrLstEfd.Strings[liNumeroLinha190],'|',2) <> 'C190') then begin
                      lbRegistro190 := False;
                    end;
                  end;

                  if (lsModelo <> '65') then begin {NFC-e}
                    if (dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Locate('FK_DFE;FK_CFOP;CST_ICMS;ALIQUOTA_ICMS',VarArrayOf([lsIdDFE,lsIdCfop,lsCstIcms,ldblAliquotaIcms]),[])) then begin
                      if (dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_OPERACAO').AsCurrency <> ldblVlOperacao190) then begin
                        {Se o valor da operação do registro C190 for diferente do valor
                        da operação da soma dos itens, troca o valor da operação da soma
                        dos itens pelo valor da operação do registro C190.}
                        ldblVlTotalItensC100 := (ldblVlTotalItensC100-dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_OPERACAO').AsCurrency)+ldblVlOperacao190;
                        dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Edit;
                        dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_OPERACAO').AsCurrency := ldblVlOperacao190;
                        dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Post;
                      end;
                    end;
                  end else begin
                    if dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Locate('FK_DFS_M2;FK_CFOP;CST_ICMS;CST_PIS_COFINS;ALIQUOTA_ICMS;ALIQUOTA_PIS;ALIQUOTA_COFINS;ALIQUOTA_IR',VarArrayOf([lsIdDFS,lsIdCfop,lsCstIcms,lsCstPisCofins,ldblAliquotaIcms,rAliquotaOperacao.dblPis,rAliquotaOperacao.dblCofins,rAliquotaOperacao.dblIr]),[]) then begin
                      if (dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('VALOR_OPERACAO').AsCurrency <> ldblVlOperacao190) then begin
                        {Se o valor da operação do registro C190 for diferente do valor
                        da operação da soma dos itens, troca o valor da operação da soma
                        dos itens pelo valor da operação do registro C190.}
                        ldblVlTotalItensC100 := (ldblVlTotalItensC100-dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_OPERACAO').AsCurrency)+ldblVlOperacao190;
                        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Edit;
                        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('VALOR_OPERACAO').AsCurrency := ldblVlOperacao190;
                        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Post;
                      end;
                    end;
                  end;
                end;
              end else begin
                lbExisteRegistroC190 := True;

                ldblValorIpi := 0;
                TryStrToCurr(StrToken(lsLinha,'|',12),ldblValorIpi);

                if (ldblValorIpi > 0) then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Não é possível importar, via EFD, NF de devolução de vendas que tenha destaque do IPI porque na EFD não tem o registro C170 e no registro C190 não tem o CST-IPI.',True);
                end;

                lsCstIcms      := StrToken(lsLinha,'|',3);

  //              if (lsCstIcms = '101') then begin
  //                lsCstIcmsOriginal := lsCstIcms;
  //                lsCstIcms := '00';
  //                FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //              end else if (lsCstIcms = '102') then begin
  //                lsCstIcmsOriginal := lsCstIcms;
  //                lsCstIcms := '41';
  //                FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //              end else if (lsCstIcms = '201') then begin
  //                lsCstIcmsOriginal := lsCstIcms;
  //                lsCstIcms := '60';
  //                FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //              end else if (lsCstIcms = '202') then begin
  //                lsCstIcmsOriginal := lsCstIcms;
  //                lsCstIcms := '60';
  //                FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //              end else if (lsCstIcms = '203') then begin
  //                lsCstIcmsOriginal := lsCstIcms;
  //                lsCstIcms := '60';
  //                FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //              end else if (lsCstIcms = '300') then begin
  //                lsCstIcmsOriginal := lsCstIcms;
  //                lsCstIcms := '41';
  //                FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //              end else if (lsCstIcms = '400') then begin
  //                lsCstIcmsOriginal := lsCstIcms;
  //                lsCstIcms := '41';
  //                FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //              end else if (lsCstIcms = '500') then begin
  //                lsCstIcmsOriginal := lsCstIcms;
  //                lsCstIcms := '60';
  //                FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //              end else if (lsCstIcms = '900') then begin
  //                lsCstIcmsOriginal := lsCstIcms;
  //                lsCstIcms := '90';
  //                FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //              end else begin
                  lsCstIcms := Copy(lsCstIcms,2,2);
  //              end;

                lsCstIpi       := '49';
                lsCstPisCofins := dmImportacaoViaEfd.cdsCstPisCofinsEntradas.FieldByName('CODIGO').AsString;

                lsCfop := StrToken(lsLinha,'|',4);
                if not TryStrToInt(lsCfop,liCfop) then begin
                  liCfop := 0;
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido.',True);
                end;
                if (not dmImportacaoViaEfd.qryCfop.Active)
                  or (dmImportacaoViaEfd.qryCfop.Eof)
                  or (dmImportacaoViaEfd.qryCfop.FieldByName('CODIGO').AsString <> lsCfop)
                then begin
                  dmImportacaoViaEfd.qryCfop.Close;
                  dmImportacaoViaEfd.qryCfop.ParamByName('pCfop').AsInteger := liCfop;
                  dmImportacaoViaEfd.qryCfop.Open;
                  dmImportacaoViaEfd.qryCfop.Filtered := False;
                  dmImportacaoViaEfd.qryCfop.Filter   := FsFiltroCfop;
                  dmImportacaoViaEfd.qryCfop.Filtered := True;
                end;
                lsIdCfop := dmImportacaoViaEfd.qryCfop.FieldByName('ID_FCFOP'  ).AsString;

                if (lsIdCfop = '') then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido.',True);
                end;

                liCfopOperacao   := dmImportacaoViaEfd.qryCfop.FieldByName('OPERACAO'  ).AsInteger;
                liCfopUtilizacao := dmImportacaoViaEfd.qryCfop.FieldByName('UTILIZACAO').AsInteger;

                ldblVlOperacao     := 0;
                ldblDesconto       := 0;
                ldblBaseIcms       := 0;
                ldblAliquotaICMS   := 0;
                ldblValorIcms      := 0;
                ldblBaseIpi        := 0;
                ldblValorIpi       := 0;
                ldblBaseIcmsST     := 0;
                ldblValorIcmsST    := 0;
                ldblBasePisCofins  := 0;
                ldblAliquotaPis    := 0;
                ldblAliquotaCofins := 0;
                ldblValorRedBC     := 0;

                TryStrToCurr(StrToken(lsLinha,'|',06),ldblVlOperacao    );
                TryStrToCurr(StrToken(lsLinha,'|',07),ldblBaseIcms      );
                TryStrToCurr(StrToken(lsLinha,'|',05),ldblAliquotaIcms  );
                TryStrToCurr(StrToken(lsLinha,'|',08),ldblValorIcms     );
                TryStrToCurr(StrToken(lsLinha,'|',09),ldblBaseIcmsST    );
                TryStrToCurr(StrToken(lsLinha,'|',10),ldblValorIcmsST   );
                if (lsCstPisCofins <= '04') then begin
                  ldblBasePisCofins := ldblVlOperacao-(ldblValorIcmsST+ldblValorIpi);
                  if (lsCstPisCofins <> '04') then begin
                    ldblAliquotaPis    := rAliquotaOperacao.dblPis;
                    ldblAliquotaCofins := rAliquotaOperacao.dblCofins;
                  end;
                end;
                if (Pos(lsCstIcms,'20*70') > 0) then begin
                  TryStrToCurr(StrToken(lsLinha,'|',11),ldblValorRedBC);
                end;

                ldblAliquotaIr := rAliquotaOperacao.dblIR;

                if (lsCstIcms = '40')
                  and (FeRegimeFederal = TTipoRegimeFederal.trf_simples_nacional)
                then begin
                  {Empresas enquadradas no Simples Nacional tributam mercadorias
                  isentas.}
                  lsCstIcms := '00';
                  ldblBaseIcms := ldblVlOperacao;
                end;

                if (Pos(lsCodigoSituacao,'06*07') > 0)
                  and ((ldblValorIcms+ldblValorIpi+ldblValorIcmsST) = 0)
                then begin
                 FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Documento fiscal complementar é necessário possuir valor de ICMS, ICMS Subitituição Tributária ou IPI.',True);
                end;

                if (ldblAliquotaIcms < 0)
                  or (ldblAliquotaIcms > 38)
                then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Alíquota do ICMS '+CurrToStr(ldblAliquotaIcms)+' inválida.',True);
                end;

                if (ldblBaseIcms = 0)
                  and (Pos(lsCstIcms,'00*10*20') > 0)
                then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', para CST/ICMS '+lsCstIcms+', é necessário informar a base de cálculo do ICMS.',True);
                end else if (ldblBaseIcms <> 0)
                  and (Pos(lsCstIcms,'00*10*20') = 0)
                then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', para CST/ICMS '+lsCstIcms+', não deve ser informada a base de cálculo do ICMS.',True);
                end;

                if (FoStrLstErros.Count = 0) then begin
                  if (FeRegimeFederal in ([TTipoRegimeFederal.trf_simples_nacional,TTipoRegimeFederal.trf_mei]))
                    and (lsCfop = '2551')
                  then begin
                    lsCstIcms      := '90';
                    lsCstIpi       := '49';
                    lsCstPisCofins := '98';
                  end;

  //                if (lsModelo <> '65') then begin
                  if (FoStrLstErros.Count = 0) then begin
                    if dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Locate('FK_DFE;FK_CFOP;CST_ICMS;CST_IPI;CST_PIS_COFINS;ALIQUOTA_ICMS;ALIQUOTA_PIS;ALIQUOTA_COFINS;ALIQUOTA_IR',VarArrayOf([lsIdDFE,lsIdCfop,lsCstIcms,lsCstIpi,lsCstPisCofins,ldblAliquotaIcms,ldblAliquotaPis,ldblAliquotaCofins,ldblAliquotaIr]),[]) then begin
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Edit;
                    end else begin
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Insert;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ID_FDFE_ANALITICO').AsString   := CreateClassID;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_DFE'           ).AsString   := lsIdDFE;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_PESSOA'        ).AsString   := TUtil.getIDPessoa;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_ICMS'         ).AsString   := lsCstIcms;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_IPI'          ).AsString   := lsCstIpi;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_PIS_COFINS'   ).AsString   := lsCstPisCofins;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_CFOP'          ).AsString   := lsIdCfop;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_ICMS'    ).AsCurrency := ldblAliquotaIcms;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_PIS'     ).AsCurrency := ldblAliquotaPis;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_COFINS'  ).AsCurrency := ldblAliquotaCofins;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_IR'      ).AsCurrency := ldblAliquotaIr;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('MVA'              ).AsCurrency := 0;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('TIPO_CFOP'        ).AsString   := '00';
                    end;

                    if (Copy(lsCfop,1,1) = '2')
                      and ((liCfopOperacao = rInfoConstantes.iOprCompraAquisicaoVenda)
                      and (liCfopUtilizacao in ([rInfoConstantes.iUtilComercializacao,rInfoConstantes.iUtilImobilizado,rInfoConstantes.iUtilMaterialConsumo])))
                      or ((rAtividade.bComercio)
                      and (liCfopUtilizacao = rInfoConstantes.iUtilBonificacaoDoacaoBrinde))
                    then begin
                      {Antecipação parcial/Diferencial de Alíquotas}
                      if (liCfopUtilizacao in ([rInfoConstantes.iUtilImobilizado,rInfoConstantes.iUtilMaterialConsumo])) then begin
                        dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('TIPO_AT_AP_DA').AsInteger  := 2;
                      end else begin
                        dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('TIPO_AT_AP_DA').AsInteger  := 1;
                      end;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_ICMS_AT_AP_DA').AsCurrency := TFUtil.getAliquotaInternaIcms(TUtil.getIDPessoa,ldDataEntradaSaida);
                    end else begin
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('TIPO_AT_AP_DA').AsInteger  := 0;
                    end;

                    dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('REDUCAO_BASE_ICMS').AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('REDUCAO_BASE_ICMS').AsCurrency+ldblValorRedBC;
                    dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_OPERACAO'   ).AsCurrency := (dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_OPERACAO'  ).AsCurrency+(ldblVlOperacao+ldblValorIpi+ldblValorIcmsST))-ldblDesconto;
                    dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS'        ).AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS'        ).AsCurrency+ldblBaseIcms;
                    dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_ICMS'       ).AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_ICMS'       ).AsCurrency+ldblValorIcms;
                    if (liCfopOperacao = rInfoConstantes.iOprDevolucaoAnulacao) then begin
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_ST'     ).AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_ST'     ).AsCurrency+ldblBaseIcmsST;
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_ICMS_ST'    ).AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_ICMS_ST'    ).AsCurrency+ldblValorIcmsST;
                    end;
                    dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_IPI'         ).AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_IPI'         ).AsCurrency+ldblBaseIpi;
                    dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_IPI'        ).AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_IPI'        ).AsCurrency+ldblValorIpi;
                    dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_PIS_COFINS'  ).AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_PIS_COFINS'  ).AsCurrency+ldblBasePisCofins;
                    if (Copy(lsCfop,1,1) = '2')
                      and ((liCfopOperacao = rInfoConstantes.iOprCompraAquisicaoVenda)
                      and (liCfopUtilizacao in ([rInfoConstantes.iUtilComercializacao,rInfoConstantes.iUtilImobilizado,rInfoConstantes.iUtilMaterialConsumo])))
                      or ((rAtividade.bComercio)
                      and (liCfopUtilizacao = rInfoConstantes.iUtilBonificacaoDoacaoBrinde))
                    then begin
                      {Antecipação parcial/Diferencial de Alíquotas}
                      dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_AT_AP_DA').AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_AT_AP_DA').AsCurrency+(ldblBaseIcms+ldblValorIpi);
                      if (FeRegimeFederal <> TTipoRegimeFederal.trf_simples_nacional)
                        and (not (liCfopUtilizacao in ([rInfoConstantes.iUtilImobilizado,rInfoConstantes.iUtilMaterialConsumo])))
                      then begin
                        dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CREDITO_ICMS_AT_AP_DA').AsCurrency := dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CREDITO_ICMS_AT_AP_DA').AsCurrency+ldblValorIcms;
                      end;
                    end;
                    dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Post;
  //                end else begin
  //                  if dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Locate('FK_DFS_M2;FK_CFOP;CST_ICMS;CST_PIS_COFINS;ALIQUOTA_ICMS;ALIQUOTA_PIS;ALIQUOTA_COFINS;ALIQUOTA_IR',VarArrayOf([lsIdDFS,lsIdCfop,lsCstIcms,lsCstPisCofins,ldblAliquotaIcms,rAliquotaOperacao.dblPis,rAliquotaOperacao.dblCofins,rAliquotaOperacao.dblIr]),[]) then begin
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Edit;
  //                  end else begin
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Insert;
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ID_FDFS_M2_ANALITICO').AsString   := CreateClassID;
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('FK_DFS_M2'           ).AsString   := lsIdDFS;
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('FK_PESSOA'           ).AsString   := TUtil.getIDPessoa;
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('CST_ICMS'            ).AsString   := lsCstIcms;
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('CST_PIS_COFINS'      ).AsString   := lsCstPisCofins;
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('FK_CFOP'             ).AsString   := lsIdCfop;
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('VALOR_OPERACAO'      ).AsCurrency := ldblVlOperacao;
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_PIS'        ).AsCurrency := rAliquotaOperacao.dblPis;
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('BASE_ICMS'           ).AsCurrency := ldblBaseIcms;
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('BASE_PIS_COFINS'     ).AsCurrency := ldblBasePisCofins;
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_COFINS'     ).AsCurrency := rAliquotaOperacao.dblCofins;
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_IR'         ).AsCurrency := ldblAliquotaIr;
  //                    dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_ICMS'       ).AsCurrency := ldblAliquotaIcms;
  //                  end;
  //                  dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Post;
                  end;
                end;
                ldblVlTotalItensC100 := (ldblVlTotalItensC100+(ldblVlOperacao+ldblValorIpi+ldblValorIcmsST))-ldblDesconto;
              end;
            end;
          end else if ((edtLoteSaidas.Value > 0) and (lsModelo <> '65'))
            or ((edtLoteSaidasModelo2.Value > 0) and (lsModelo = '65'))
          then begin {Saída}
            if (lsRegistro = 'C190') then begin
              ldblValorIpi := 0;
              TryStrToCurr(StrToken(lsLinha,'|',12),ldblValorIpi);

              lsCstIcms      := StrToken(lsLinha,'|',3);

  //            if (lsCstIcms = '101') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '00';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '102') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '41';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '201') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '60';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '202') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '60';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '203') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '60';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '300') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '41';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '400') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '41';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '500') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '60';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else if (lsCstIcms = '900') then begin
  //              lsCstIcmsOriginal := lsCstIcms;
  //              lsCstIcms := '90';
  //              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS '+lsCstIcms +'.',True);
  //            end else begin
                lsCstIcms := Copy(lsCstIcms,2,2);
  //            end;

              lsCstPisCofins := dmImportacaoViaEfd.cdsCstPisCofinsSaidas.FieldByName('CODIGO').AsString;

              if (lsCstPisCofins = '') then begin
                lsCstPisCofins := '49';
              end;

              lsCfop := StrToken(lsLinha,'|',4);
              if not TryStrToInt(lsCfop,liCfop) then begin
                liCfop := 0;
                FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido.',True);
              end;
              if (not dmImportacaoViaEfd.qryCfop.Active)
                or (dmImportacaoViaEfd.qryCfop.Eof)
                or (dmImportacaoViaEfd.qryCfop.FieldByName('CODIGO').AsString <> lsCfop)
              then begin
                dmImportacaoViaEfd.qryCfop.Close;
                dmImportacaoViaEfd.qryCfop.ParamByName('pCfop').AsInteger := liCfop;
                dmImportacaoViaEfd.qryCfop.Open;
                dmImportacaoViaEfd.qryCfop.Filtered := False;
                dmImportacaoViaEfd.qryCfop.Filter   := FsFiltroCfop;
                dmImportacaoViaEfd.qryCfop.Filtered := True;
              end;
              lsIdCfop := dmImportacaoViaEfd.qryCfop.FieldByName('ID_FCFOP'  ).AsString;

              if (lsIdCfop = '') then begin
                FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido.',True);
              end else if ((lsUfParticipante = FsUFPessoa) and (Copy(lsCfop,1,1) <> '5'))
                or ((not lsUfParticipante.IsEmpty) and (lsUfParticipante <> FsUFPessoa) and (Copy(lsCfop,1,1) <> '6'))
                or ((lsUfParticipante.IsEmpty) and (Copy(lsCfop,1,1) <> '7'))
              then begin
                if (not lsUfParticipante.IsEmpty) then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido para saídas para '+lsUfParticipante+'.',True);
                end else if (lsModelo <> '65') then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido para saídas para o exterior.',True);
                end;
              end;

              liCfopOperacao   := dmImportacaoViaEfd.qryCfop.FieldByName('OPERACAO'  ).AsInteger;
              liCfopUtilizacao := dmImportacaoViaEfd.qryCfop.FieldByName('UTILIZACAO').AsInteger;

              ldblVlOperacao     := 0;
              ldblDesconto       := 0;
              ldblBaseIcms       := 0;
              ldblAliquotaICMS   := 0;
              ldblValorIcms      := 0;
              ldblBaseIpi        := 0;
              ldblBaseIcmsST     := 0;
              ldblValorIcmsST    := 0;
              ldblBasePisCofins  := 0;
              ldblAliquotaPis    := 0;
              ldblAliquotaCofins := 0;
              ldblValorRedBC     := 0;

              TryStrToCurr(StrToken(lsLinha,'|',06),ldblVlOperacao    );
              TryStrToCurr(StrToken(lsLinha,'|',07),ldblBaseIcms      );
              TryStrToCurr(StrToken(lsLinha,'|',05),ldblAliquotaIcms  );
              TryStrToCurr(StrToken(lsLinha,'|',08),ldblValorIcms     );
              TryStrToCurr(StrToken(lsLinha,'|',09),ldblBaseIcmsST    );
              TryStrToCurr(StrToken(lsLinha,'|',10),ldblValorIcmsST   );

              {Como nas saídas da EFD não existe o registro C170 e no registro C190
              não existe o valor da base de cálculo do IPI, ou seja, só existe o
              valor do IPI, se ldblValorIpi for maior que zero, a operação estiver
              no contexto de aquisição de produtos para industrialização, então,
              atribui o CST-IPI selecionado no combobox a lsCstIpi e, caso o CST-IPI
              permita o crédito, atribui a ldblBaseIpi o valor da operação menos o
              valor do IPI e do ICMS Substituição Tributária.
              OBS: Caso a venda seja efetuada a consumidor final, após a importação,
              o valor da base de cálculo do IPI deve ser alterada}
              if (ldblValorIpi > 0)
    //            and (rAtividade.bIndustria)
                and (liCfopOperacao in ([rInfoConstantes.iOprCompraAquisicaoVenda,rInfoConstantes.iOprTransferencia,rInfoConstantes.iOprDevolucaoAnulacao]))
    //            and (liCfopUtilizacao in ([rInfoConstantes.iUtilIndustrializacao,rInfoConstantes.iUtilComercializacao,rInfoConstantes.iUtilVendaOrdem,rInfoConstantes.iUtilConsignacao,rInfoConstantes.iUtilConsumidorFinal,rInfoConstantes.iUtilBonificacaoDoacaoBrinde,rInfoConstantes.iUtilVendaOrdem,rInfoConstantes.iUtilIndustrializacaoEncomenda,rInfoConstantes.iUtilSimplesFaturamento,rInfoConstantes.iUtilVendaOrigEntregaFutura]))
              then begin
                lsCstIpi    := dmImportacaoViaEfd.cdsCstIpi.FieldByName('CODIGO').AsString;
                if (lsCstIpi < '52') then begin
                  ldblBaseIpi := ldblVlOperacao-(ldblValorIpi+ldblValorIcmsST);
                end else begin
                  ldblBaseIpi := 0;
                end;
              end else begin
                lsCstIpi    := '99';
                ldblBaseIpi := 0;
    //            FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Não é possível importar, via EFD, NF de saída que tenha destaque do IPI porque na EFD não tem o registro C170 e no registro C190 não tem o CST-IPI.',True);
              end;

              if (ldblVlTotalC100 <= 0)
                and (Pos(lsCodigoSituacao,'02,03,04,05,06*07') = 0) {Documento cancelado, denegado, complementar, etc.}
                and (lsCfop <> '5929')
                and (lsCfop <> '6929')
             then begin
                {Ver Nota 1 no final dessa Unit}
                FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', documento fiscal Nº '+IntToStr(liNumero)+', sem valor.',True);
                ldblVlTotalC100 := 99; {Esse valor é atribuido somente para não dar erro na tentativa de gravação. Porém, nada será gravado porque existe erro.}
              end;

              if (ldblVlOperacao = 0)
                and (ldblVlTotalC100 > 0)
                and ((lsCfop = '5929')
                or (lsCfop = '6929'))
              then begin
                {Ver Nota 1 no final dessa Unit}
                 ldblVlOperacao := ldblVlTotalC100;
              end;

              if (lsCstPisCofins <= '04') then begin
                ldblBasePisCofins := ldblVlOperacao-(ldblValorIcmsST+ldblValorIpi);
                if (lsCstPisCofins <> '04') then begin
                  ldblAliquotaPis    := rAliquotaOperacao.dblPis;
                  ldblAliquotaCofins := rAliquotaOperacao.dblCofins;
                end;
              end;
              if (Pos(lsCstIcms,'20*70') > 0) then begin
                TryStrToCurr(StrToken(lsLinha,'|',11),ldblValorRedBC);
              end;

              if (dmImportacaoViaEfd.qryCfop.FieldByName('OPERACAO').AsInteger = rInfoConstantes.iOprCompraAquisicaoVenda) then begin
                ldblAliquotaIr := rAliquotaOperacao.dblIR;
              end else begin
                ldblAliquotaIr := 0;
              end;

              if (lsCstIcms = '40')
                and (FeRegimeFederal = TTipoRegimeFederal.trf_simples_nacional)
              then begin
                {Empresas enquadradas no Simples Nacional tributam mercadorias
                isentas.}
                lsCstIcms := '00';
                ldblBaseIcms := ldblVlOperacao;
              end;

              if (Pos(lsCodigoSituacao,'06*07') > 0)
                and ((ldblValorIcms+ldblValorIpi+ldblValorIcmsST) = 0)
              then begin
               FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Documento fiscal complementar é necessário possuir valor de ICMS, ICMS Subitituição Tributária ou IPI.',True);
              end;

              if (ldblAliquotaIcms < 0)
                or (ldblAliquotaIcms > 38)
              then begin
                FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Alíquota do ICMS '+CurrToStr(ldblAliquotaIcms)+' inválida.',True);
              end;

              if (Copy(lsCfop,2,3) <> '929') then begin
                if (ldblBaseIcms = 0)
                  and (Pos(lsCstIcms,'00*10*20*70') > 0)
                then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', para CST/ICMS '+lsCstIcms+', é necessário informar a base de cálculo do ICMS.',True);
                end else if (ldblBaseIcms <> 0)
                  and (Pos(lsCstIcms,'00*10*20*70') = 0)
                then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', para CST/ICMS '+lsCstIcms+', não deve ser informada a base de cálculo do ICMS.',True);
                end;
              end;

              if (FoStrLstErros.Count = 0) then begin
                if (lsModelo <> '65') then begin
                  if dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Locate('FK_DFS;FK_CFOP;CST_ICMS;CST_IPI;CST_PIS_COFINS;ALIQUOTA;ALIQUOTA_PIS;ALIQUOTA_COFINS;ALIQUOTA_IR',VarArrayOf([lsIdDFS,lsIdCfop,lsCstIcms,lsCstIpi,lsCstPisCofins,ldblAliquotaIcms,ldblAliquotaPis,ldblAliquotaCofins,ldblAliquotaIr]),[]) then begin
                    dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Edit;
                  end else begin
                    dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Insert;
                    dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ID_FDFS_ANALITICO').AsString   := CreateClassID;
                    dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('FK_DFS'           ).AsString   := lsIdDFS;
                    dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('FK_PESSOA'        ).AsString   := TUtil.getIDPessoa;
                    dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('CST_ICMS'         ).AsString   := lsCstIcms;
                    dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('CST_IPI'          ).AsString   := lsCstIpi;
                    dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('CST_PIS_COFINS'   ).AsString   := lsCstPisCofins;
                    dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('FK_CFOP'          ).AsString   := lsIdCfop;
                    dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA_PIS'     ).AsCurrency := ldblAliquotaPis;
                    dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA_COFINS'  ).AsCurrency := ldblAliquotaCofins;
                    dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA_IR'      ).AsCurrency := ldblAliquotaIr;
                    dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA'         ).AsCurrency := ldblAliquotaIcms;
                    dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('TIPO_CFOP'        ).AsString   := '00';
                  end;
                  dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_OPERACAO'   ).AsCurrency := dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_OPERACAO'   ).AsCurrency+(ldblVlOperacao-ldblDesconto);
                  dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_CALCULO'     ).AsCurrency := dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_CALCULO'     ).AsCurrency+ldblBaseIcms;
                  dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_ICMS'       ).AsCurrency := dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_ICMS'       ).AsCurrency+ldblValorIcms;
                  dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_ICMS_ST'     ).AsCurrency := dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_ICMS_ST'     ).AsCurrency+ldblBaseIcmsST;
                  dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_ICMS_ST'    ).AsCurrency := dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_ICMS_ST'    ).AsCurrency+ldblValorIcmsST;
                  dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('REDUCAO_BASE_ICMS').AsCurrency := dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('REDUCAO_BASE_ICMS').AsCurrency+ldblValorRedBC;
                  dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_IPI'         ).AsCurrency := dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_IPI'         ).AsCurrency+ldblBaseIpi;
                  dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_IPI'        ).AsCurrency := dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_IPI'        ).AsCurrency+ldblValorIpi;
                  dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_PIS_COFINS'  ).AsCurrency := dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_PIS_COFINS'  ).AsCurrency+ldblBasePisCofins;
                  dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Post;
                end else begin
  //                if dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Locate('FK_DFS_M2;FK_CFOP;CST_ICMS;CST_PIS_COFINS;ALIQUOTA_ICMS;ALIQUOTA_PIS;ALIQUOTA_COFINS;ALIQUOTA_IR',VarArrayOf([lsIdDFS,lsIdCfop,lsCstIcms,lsCstPisCofins,ldblAliquotaIcms,rAliquotaOperacao.dblPis,rAliquotaOperacao.dblCofins,rAliquotaOperacao.dblIr]),[]) then begin
  //                  dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Edit;
  //                end else begin
  //                  dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Insert;
  //                  dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ID_FDFS_M2_ANALITICO').AsString   := CreateClassID;
  //                  dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('FK_DFS_M2'           ).AsString   := lsIdDFS;
  //                  dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('FK_PESSOA'           ).AsString   := TUtil.getIDPessoa;
  //                  dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('CST_ICMS'            ).AsString   := lsCstIcms;
  //                  dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('CST_PIS_COFINS'      ).AsString   := lsCstPisCofins;
  //                  dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('FK_CFOP'             ).AsString   := lsIdCfop;
  //                  dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_IR'         ).AsCurrency := ldblAliquotaIr;
  //                  dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_ICMS'       ).AsCurrency := ldblAliquotaIcms;
  //                  dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_PIS'        ).AsCurrency := rAliquotaOperacao.dblPis;
  //                  dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_COFINS'     ).AsCurrency := rAliquotaOperacao.dblCofins;
  //                end;
  //
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('VALOR_OPERACAO' ).AsCurrency := dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('VALOR_OPERACAO' ).AsCurrency+ldblVlOperacao;
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('BASE_ICMS'      ).AsCurrency := dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('BASE_ICMS'      ).AsCurrency+ldblBaseIcms;
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('BASE_PIS_COFINS').AsCurrency := dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('BASE_PIS_COFINS').AsCurrency+ldblBasePisCofins;
  //                dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Post;

                  if dmImportacaoViaEfd.cdsNFMod_02_65_Temp.Locate('FK_DF_MODELO;CODIGO_SITUACAO;SERIE;NUMERO_INICIAL;DATA_EMISSAO;FK_CFOP;CST_ICMS;CST_PIS_COFINS;ALIQUOTA_ICMS;ALIQUOTA_PIS;ALIQUOTA_COFINS;ALIQUOTA_IR',VarArrayOf([lsIdModelo,lsCodigoSituacao,lsSerie,liNumero,ldDataEmissao,lsIdCfop,lsCstIcms,lsCstPisCofins,ldblAliquotaIcms,rAliquotaOperacao.dblPis,rAliquotaOperacao.dblCofins,rAliquotaOperacao.dblIr]),[]) then begin
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.Edit;
                  end else begin
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.Insert;
                    {Head da NF Modelo 65}
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('ID_FDFS_M2'          ).AsString   := CreateClassID;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('FK_PESSOA'           ).AsString   := TUtil.getIDPessoa;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('FK_LOTE'             ).AsString   := FsIdLoteDFS_M2;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('LINHA'               ).AsInteger  := FiLinhaDFS_M2;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('FK_DF_MODELO'        ).AsString   := lsIdModelo;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('CODIGO_SITUACAO'     ).AsString   := lsCodigoSituacao;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('SERIE'               ).AsString   := lsSerie;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('NUMERO_INICIAL'      ).AsInteger  := liNumero;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('NUMERO_FINAL'        ).AsInteger  := liNumero;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('DATA_EMISSAO'        ).AsDateTime := ldDataEmissao;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('VALOR'               ).AsCurrency := ldblVlTotalC100;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('ART_377_RICMS'       ).AsInteger  := 0;
                    {Analítico da NF Modelo 65}
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('ID_FDFS_M2_ANALITICO').AsString   := CreateClassID;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('FK_DFS_M2'           ).AsString   := lsIdDFS;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('CST_ICMS'            ).AsString   := lsCstIcms;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('CST_PIS_COFINS'      ).AsString   := lsCstPisCofins;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('FK_CFOP'             ).AsString   := lsIdCfop;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('ALIQUOTA_IR'         ).AsCurrency := ldblAliquotaIr;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('ALIQUOTA_ICMS'       ).AsCurrency := ldblAliquotaIcms;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('ALIQUOTA_PIS'        ).AsCurrency := rAliquotaOperacao.dblPis;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('ALIQUOTA_COFINS'     ).AsCurrency := rAliquotaOperacao.dblCofins;
                    dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('NATUREZA_RECEITA'    ).AsString   := edtNaturezaReceita.Text;
                    inc(FiLinhaDFS_M2);
                  end;
                  dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('VALOR_OPERACAO'   ).AsCurrency := dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('VALOR_OPERACAO'   ).AsCurrency+ldblVlOperacao;
                  dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('REDUCAO_BASE_ICMS').AsCurrency := dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('REDUCAO_BASE_ICMS').AsCurrency+ldblValorRedBC;
                  dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('BASE_ICMS'        ).AsCurrency := dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('BASE_ICMS'        ).AsCurrency+ldblBaseIcms;
                  dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('BASE_PIS_COFINS'  ).AsCurrency := dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('BASE_PIS_COFINS'  ).AsCurrency+ldblBasePisCofins;
                  dmImportacaoViaEfd.cdsNFMod_02_65_Temp.Post;
                end;
              end;

              ldblVlTotalItensC100 := ldblVlTotalItensC100+(ldblVlOperacao-ldblDesconto);
            end;
          end;
          inc(liNumeroLinha);
          lsRegistro := StrToken(FoStrLstEfd.Strings[liNumeroLinha],'|',2);
        end;
      end else begin
        if (FoStrLstErros.Count = 0) then begin
          {Modelo 65 Cancelado}
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.Insert;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('ID_FDFS_M2'          ).AsString   := CreateClassID;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('FK_PESSOA'           ).AsString   := TUtil.getIDPessoa;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('FK_LOTE'             ).AsString   := FsIdLoteDFS_M2;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('LINHA'               ).AsInteger  := FiLinhaDFS_M2;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('FK_DF_MODELO'        ).AsString   := lsIdModelo;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('CODIGO_SITUACAO'     ).AsString   := lsCodigoSituacao;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('SERIE'               ).AsString   := lsSerie;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('NUMERO_INICIAL'      ).AsInteger  := liNumero;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('NUMERO_FINAL'        ).AsInteger  := liNumero;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('DATA_EMISSAO'        ).AsDateTime := ldDataEmissao;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('VALOR'               ).AsCurrency := ldblVlTotalC100;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('ART_377_RICMS'       ).AsInteger  := 0;
          {Analítico da NF Modelo 65}
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('ID_FDFS_M2_ANALITICO').AsString   := CreateClassID;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('FK_DFS_M2'           ).AsString   := CreateClassID;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('CST_ICMS'            ).AsString   := '00';
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('CST_PIS_COFINS'      ).AsString   := '49';
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('FK_CFOP'             ).AsString   := CreateClassID;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('ALIQUOTA_IR'         ).AsCurrency := 0;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('ALIQUOTA_ICMS'       ).AsCurrency := 0;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('ALIQUOTA_PIS'        ).AsCurrency := 0;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('ALIQUOTA_COFINS'     ).AsCurrency := 0;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('NATUREZA_RECEITA'    ).AsString   := '';
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('VALOR_OPERACAO'      ).AsCurrency := 0;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('REDUCAO_BASE_ICMS'   ).AsCurrency := 0;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('BASE_ICMS'           ).AsCurrency := 0;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.FieldByName('BASE_PIS_COFINS'     ).AsCurrency := 0;
          dmImportacaoViaEfd.cdsNFMod_02_65_Temp.Post;
        end;
        inc(FiLinhaDFS_M2);
      end;

  //    if (not lbExisteRegistroC170) then begin
  //      FoStrLstAvisos.Add('-Não foi possível importar o Documento Fiscal de '+lsDescricaoTipoDF+' Nº '+IntToStr(liNumero+1)+' porque não foi localizado registro C170 correspondente.');
  //      if (lsEntradaSaida = '0') then begin {Entrada}
  //        if dmImportacaoViaEfd.cdsDFETemp.Locate('ID_FDFE',lsIdDFE,[]) then begin
  //          dmImportacaoViaEfd.cdsDFETemp.Delete;
  //          if dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Locate('FK_DFE',lsIdDFE,[]) then begin
  //            while (not dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Eof) do begin
  //              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Delete;
  //              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Locate('FK_DFE',lsIdDFE,[]);
  //            end;
  //          end;
  //        end;
  //      end else begin {Saida}
  //        if dmImportacaoViaEfd.cdsDFSTemp.Locate('ID_FDFS',lsIdDFS,[]) then begin
  //          dmImportacaoViaEfd.cdsDFSTemp.Delete;
  //          if dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Locate('FK_DFS',lsIdDFS,[]) then begin
  //            while (not dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Eof) do begin
  //              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Delete;
  //              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Locate('FK_DFS',lsIdDFS,[]);
  //            end;
  //          end;
  //        end;
  //      end;
  //    end;
      if (leEntradaSaida = TEntradaSaida.tes_entrada) {Entrada}
        and (not lbExisteRegistroC170)
        and (not lbExisteRegistroC190)
      then begin
        FoStrLstAvisos.Add('-Não foi possível importar o Documento Fiscal de '+lsDescricaoTipoDF+' Nº '+IntToStr(liNumero)+' porque não foi localizado registro C170 correspondente.');
        if dmImportacaoViaEfd.cdsDFETemp.Locate('ID_FDFE',lsIdDFE,[]) then begin
          dmImportacaoViaEfd.cdsDFETemp.Delete;
          if dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Locate('FK_DFE',lsIdDFE,[]) then begin
            while (not dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Eof) do begin
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Delete;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Locate('FK_DFE',lsIdDFE,[]);
            end;
          end;
        end;
      end else if (ldblVlTotalC100 <> ldblVlTotalItensC100)
        and (lsCfop = '5929')
        and (lsCfop = '6929')
      then begin
        {Ver Nota 1 no final dessa Unit}
        FoStrLstAvisos.Add('-Documento Fiscal de '+lsDescricaoTipoDF+' Nº '+IntToStr(liNumero)+' incorreto: Valor total do documento fiscal '+FormatSettings.CurrencyString+' '+FormatCurr('###,###,##0.00',ldblVlTotalC100)+' é diferente do valor total dos itens '+FormatSettings.CurrencyString+' '+FormatCurr('###,###,##0.00',ldblVlTotalItensC100)+'.');
      end;
    end else begin
      inc(liNumeroLinha);
    end;
  finally
    FreeAndNil(loStrLstCstIcms190);
  end;
end;

procedure TFImportacaoViaEfd.ImportarRegistroC300(psLinha: String;
  piNumeroLinha: Integer);
var
  lsLinha,lsSerie,lsModelo,lsIdModelo,
  lsCstIcms,lsCstIpi,lsCstPisCofins,lsInscMf,lsIdCfop,lsCfop,
  lsRegistro,lsCstIcmsOriginal,lsCstIpiOriginal,
  lsCstPisCofinsOriginal,lsIdDFS,lsNFCanceladas: string;
  ldDataEmissao: TDate;
  liNumeroLinha,liNumeroInicial,liNumeroFinal,liCfop: Integer;
  ldblVlTotalC300,ldblVlTotalItensC300,ldblVlOperacao,
  ldblBaseIcms,ldblValorRedBC,ldblAliquotaIcms,ldblValorIcms,
  ldblBasePisCofins,ldblValorPis,
  ldblValorCofins,ldblValorPisItem,ldblValorCofinsItem,ldblAliquotaIr,
  ldblReducaoBC: Currency;

begin
  Application.ProcessMessages;

  lsLinha       := psLinha;
  lsRegistro    := StrToken(lsLinha,'|',2);
  liNumeroLinha := piNumeroLinha;

  {Notas Fiscais Modelo 02 - Documento Regular}
  lsModelo            := StrToken(lsLinha,'|',3);
  if (dmImportacaoViaEfd.qryDFModelo.Locate('CODIGO',lsModelo,[])) then begin
    lsIdModelo := dmImportacaoViaEfd.qryDFModelo.FieldByName('ID_FDF_MODELO').AsString;
  end else begin
    lsIdModelo := '';
  end;
  if (lsModelo = '') then begin
    FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha)+', conteúdo: '+lsModelo+'. Modelo do documento fiscal inválido.',True);
  end;

  lsSerie  := StrToken(lsLinha,'|',4)+StrToken(lsLinha,'|',5);
  if (lsSerie = '') or (Length(lsSerie) > 3) then begin
//    FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', documento fiscal Nº '+IntToStr(liNumeroInicial)+', com a série '+lsSerie+', foi substituida pela série D1.',True);
    lsSerie := 'D1';
  end;

  liNumeroInicial := StrToInt(StrToken(lsLinha,'|',6));
  if (liNumeroInicial <= 0) then begin
    FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Documento fiscal com número inicial inválido.',True);
  end;
  liNumeroFinal := StrToInt(StrToken(lsLinha,'|',7));
  if (liNumeroFinal <= 0) then begin
    FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Documento fiscal com número final inválido.',True);
  end;

  ldDataEmissao := StrSemBarrasToDate(StrToken(lsLinha,'|',8));
  if (ldDataEmissao = 0) then begin
    FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Data de emissão do documento fiscal inválida. ('+StrToken(lsLinha,'|',11)+'.',True);
  end;

  ldblVlTotalC300  := 0;
  ldblAliquotaIcms := 0;
  ldblVlOperacao   := 0;
  ldblBaseIcms     := 0;
  ldblValorIcms    := 0;
  ldblReducaoBC    := 0;
  ldblValorPis     := 0;
  ldblValorCofins  := 0;
  TryStrToCurr(StrToken(lsLinha,'|',9 ),ldblVlTotalC300);

  dmImportacaoViaEfd.qryVerificaDFSM2.Close;
  dmImportacaoViaEfd.qryVerificaDFSM2.ParamByName('pIdPessoa'      ).AsString  := TUtil.getIDPessoa;
  dmImportacaoViaEfd.qryVerificaDFSM2.ParamByName('pSerie'         ).AsString  := lsSerie;
  dmImportacaoViaEfd.qryVerificaDFSM2.ParamByName('pNumeroInicial' ).AsInteger := liNumeroInicial;
  dmImportacaoViaEfd.qryVerificaDFSM2.ParamByName('pNumeroFinal'   ).AsInteger := liNumeroFinal;
  dmImportacaoViaEfd.qryVerificaDFSM2.Open;

  if (not dmImportacaoViaEfd.qryVerificaDFSM2.IsEmpty) then begin
    FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha)+', Documento fiscal '+IntToStr(liNumeroInicial)+' lançado em '+dmImportacaoViaEfd.qryVerificaDFSM2.FieldByName('DATA_EMISSAO').AsString+', no lote de saídas modelo 02 '+IntToStr(dmImportacaoViaEfd.qryVerificaDFSM2.FieldByName('NUMERO_INICIAL').AsInteger)+', Linha '+IntToStr(dmImportacaoViaEfd.qryVerificaDFSM2.FieldByName('LINHA').AsInteger)+'.',True);
  end;

  lsIdDFS := CreateClassID;
  dmImportacaoViaEfd.cdsDFSM2Temp.Insert;
  dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('ID_FDFS_M2'        ).AsString   := lsIdDFS;
  dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('FK_PESSOA'         ).AsString   := TUtil.getIDPessoa;
  dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('FK_LOTE'           ).AsString   := FsIdLoteDFS_M2;
  dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('LINHA'             ).AsInteger  := FiLinhaDFS_M2;
  dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('FK_DF_MODELO'      ).AsString   := lsIdModelo;
  dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('CODIGO_SITUACAO'   ).AsInteger  := 0;
  dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('SERIE'             ).AsString   := lsSerie;
  dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('NUMERO_INICIAL'    ).AsInteger  := liNumeroInicial;
  dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('NUMERO_FINAL'      ).AsInteger  := liNumeroFinal;
  dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('DATA_EMISSAO'      ).AsDateTime := ldDataEmissao;
  dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('VALOR'             ).AsCurrency := ldblVlTotalC300;
  dmImportacaoViaEfd.cdsDFSM2Temp.FieldByName('ART_377_RICMS'     ).AsInteger  := 0;
  dmImportacaoViaEfd.cdsDFSM2Temp.Post;
  Inc(FiLinhaDFS_M2);
  Inc(liNumeroLinha);

  lsLinha    := FoStrLstEfd.Strings[liNumeroLinha];
  lsRegistro := StrToken(lsLinha,'|',2);

  lsNFCanceladas := '';
  while (liNumeroLinha < FoStrLstEfd.Count-1) and (Copy(lsRegistro,1,2) = 'C3') and (lsRegistro <> 'C300') and (lsRegistro <= 'C321') do begin
    lblProgresso.Caption := 'Importando Registro: '+lsRegistro+'  '+IntToStr(liNumeroLinha);
    NGauge.Progress := liNumeroLinha;
    Application.ProcessMessages;

    if (lsRegistro = 'C310') then begin
      {Notas Fiscais Modelo 02 - Documento Cancelado}
      while (liNumeroLinha < FoStrLstEfd.Count-1) and (lsRegistro <= 'C310') do begin
        if (lsNFCanceladas.IsEmpty) then begin
          lsNFCanceladas := lsNFCanceladas+StrToken(lsLinha,'|',3);
        end else begin
          lsNFCanceladas := ','+lsNFCanceladas+StrToken(lsLinha,'|',3);
        end;
        Inc(liNumeroLinha);
        lsLinha    := FoStrLstEfd.Strings[liNumeroLinha];
        lsRegistro := StrToken(lsLinha,'|',2);
      end;
    end else if (lsRegistro = 'C320') then begin
      lsCstIcms := Copy(StrToken(lsLinha,'|',3),2,2);
      lsCfop    := StrToken(lsLinha,'|',4);

      if not TryStrToInt(lsCfop,liCfop) then begin
        liCfop := 0;
        FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha)+', CFOP '+lsCfop+', inválido.',True);
      end;
      if (not dmImportacaoViaEfd.qryCfop.Active)
        or (dmImportacaoViaEfd.qryCfop.Eof)
        or (dmImportacaoViaEfd.qryCfop.FieldByName('CODIGO').AsString <> lsCfop)
      then begin
        dmImportacaoViaEfd.qryCfop.Close;
        dmImportacaoViaEfd.qryCfop.ParamByName('pCfop').AsInteger := liCfop;
        dmImportacaoViaEfd.qryCfop.Open;
        dmImportacaoViaEfd.qryCfop.Filtered := False;
        dmImportacaoViaEfd.qryCfop.Filter   := FsFiltroCfop;
        dmImportacaoViaEfd.qryCfop.Filtered := True;
      end;
      lsIdCfop := dmImportacaoViaEfd.qryCfop.FieldByName('ID_FCFOP'  ).AsString;

      if (lsIdCfop = '') then begin
        FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido.',True);
      end else if (not IntToBoolean(dmImportacaoViaEfd.qryCfop.FieldByName('USO_MODELO_02').AsInteger)) then begin
        FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido para uso por documento fiscal modelo 02.',True);
      end;

      ldblAliquotaIcms := 0;
      ldblVlOperacao   := 0;
      ldblBaseIcms     := 0;
      ldblValorIcms    := 0;
      ldblReducaoBC    := 0;
      TryStrToCurr(StrToken(lsLinha,'|',5 ),ldblAliquotaIcms);
      TryStrToCurr(StrToken(lsLinha,'|',6 ),ldblVlOperacao);
      TryStrToCurr(StrToken(lsLinha,'|',7 ),ldblBaseIcms);
      TryStrToCurr(StrToken(lsLinha,'|',8 ),ldblValorIcms);
      TryStrToCurr(StrToken(lsLinha,'|',9 ),ldblReducaoBC);
      Inc(liNumeroLinha);
    end else if (lsRegistro = 'C321') then begin
      ldblValorPis    := 0;
      ldblValorCofins := 0;
      while (lsRegistro = 'C321') do begin
        ldblValorPisItem    := 0;
        ldblValorCofinsItem := 0;
        TryStrToCurr(StrToken(lsLinha,'|',10),ldblValorPisItem);
        TryStrToCurr(StrToken(lsLinha,'|',11),ldblValorCofinsItem);
        ldblValorPis    := ldblValorPis   +ldblValorPisItem;
        ldblValorCofins := ldblValorCofins+ldblValorCofinsItem;
        Inc(liNumeroLinha);
        lsLinha    := FoStrLstEfd.Strings[liNumeroLinha];
        lsRegistro := StrToken(lsLinha,'|',2);
      end;
      if (ldblValorPis > 0)
        and (rAliquotaOperacao.dblPis > 0)
      then begin
        lsCstPisCofins    := '01';
        ldblBasePisCofins := (ldblValorPis*100)/rAliquotaOperacao.dblPis;
        if (ldblBasePisCofins > ldblVlOperacao) then begin
          ldblBasePisCofins := ldblVlOperacao;
        end;
      end else begin
        lsCstPisCofins    := '49';
        ldblBasePisCofins := 0;
      end;

      if (ldblAliquotaIcms < 0)
        or (ldblAliquotaIcms > 38)
      then begin
        FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Alíquota do ICMS '+CurrToStr(ldblAliquotaIcms)+' inválida.',True);
      end;

      if (ldblBaseIcms = 0)
        and (Pos(lsCstIcms,'00*10*20') > 0)
      then begin
        FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', para CST/ICMS '+lsCstIcms+', é necessário informar a base de cálculo do ICMS.',True);
      end else if (ldblBaseIcms <> 0)
        and (Pos(lsCstIcms,'00*10*20') = 0)
      then begin
        FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', para CST/ICMS '+lsCstIcms+', não deve ser informada a base de cálculo do ICMS.',True);
      end;

      if dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Locate('FK_DFS_M2;FK_CFOP;CST_ICMS;CST_PIS_COFINS;ALIQUOTA_ICMS;ALIQUOTA_PIS;ALIQUOTA_COFINS;ALIQUOTA_IR',VarArrayOf([lsIdDFS,lsIdCfop,lsCstIcms,lsCstPisCofins,ldblAliquotaIcms,rAliquotaOperacao.dblPis,rAliquotaOperacao.dblCofins,rAliquotaOperacao.dblIr]),[]) then begin
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Edit;
      end else begin
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Insert;
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ID_FDFS_M2_ANALITICO').AsString   := CreateClassID;
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('FK_DFS_M2'           ).AsString   := lsIdDFS;
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('FK_PESSOA'           ).AsString   := TUtil.getIDPessoa;
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('CST_ICMS'            ).AsString   := lsCstIcms;
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('CST_PIS_COFINS'      ).AsString   := lsCstPisCofins;
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('FK_CFOP'             ).AsString   := lsIdCfop;
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('VALOR_OPERACAO'      ).AsCurrency := ldblVlOperacao;
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_PIS'        ).AsCurrency := rAliquotaOperacao.dblPis;
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('BASE_ICMS'           ).AsCurrency := ldblBaseIcms;
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('BASE_PIS_COFINS'     ).AsCurrency := ldblBasePisCofins;
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_COFINS'     ).AsCurrency := rAliquotaOperacao.dblCofins;
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_IR'         ).AsCurrency := ldblAliquotaIr;
        dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('ALIQUOTA_ICMS'       ).AsCurrency := ldblAliquotaIcms;
        if (not lsNFCanceladas.IsEmpty) then begin
          dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.FieldByName('OBS').AsString := 'NF Cancelada(s) '+lsNFCanceladas;
          lsNFCanceladas := '';
        end;
      end;
      dmImportacaoViaEfd.cdsDFSM2AnaliticoTemp.Post;
    end;

    lsLinha    := FoStrLstEfd.Strings[liNumeroLinha];
    lsRegistro := StrToken(lsLinha,'|',2);
  end;
end;

procedure TFImportacaoViaEfd.ImportarRegistroC400(psLinha: String;
  piNumeroLinha: Integer);
var
  lsIdEquipamentoEcf,lsLinha,lsNumero,lsSerie,lsModelo,lsRegistro,
  lsCfop,lsIdCFOP,lsCSTIcmsOriginal,lsCSTIcms,lsCSTPisCofins,
  lsOBS,lsInscMf,lsInscEstadual,lsECFFabricacao,lsIdDfsEcf: string;
  ldDataEmissao: TDate;
  liEcfCaixa,liNumeroLinha,liCRO,liCRZ,liCooInicial,liCooFinal,liLinhaC405: Integer;
  ldblGT,ldblVendaBruta,ldblExclusaoPIS,ldblTotalExclusaoPIS,ldblVlOperacao,
  ldblCancelamentos,ldblDescontos,ldblTotalCancelamentos,ldblTotalDescontos,
  ldblAliquotaIcms,ldblVlBcIcms,ldblBasePisCofins,ldblAliquotaPis,
  ldblAliquotaCofins, ldblValorPis: Currency;
  liCfop,liCfopTabela,liCstIcmsOrigem: Integer;

begin
  lsRegistro := StrToken(psLinha,'|',2);
  Application.ProcessMessages;
  lsModelo        := StrToken(psLinha,'|',3);
  lsECFFabricacao := StrToken(psLinha,'|',5);
  liEcfCaixa      := StrToInt(StrToken(psLinha,'|',6));

  if (not dmImportacaoViaEfd.qryEquipamentoECF.Active)
    or (dmImportacaoViaEfd.qryEquipamentoECF.FieldByName('SERIE_EQUIPAMENTO').AsString <> lsECFFabricacao)
  then begin
    dmImportacaoViaEfd.qryEquipamentoECF.Close;
    dmImportacaoViaEfd.qryEquipamentoECF.ParamByName('pIdPessoa').AsString := TUtil.getIDPessoa;
    dmImportacaoViaEfd.qryEquipamentoECF.ParamByName('pEcfFab'  ).AsString := lsECFFabricacao;
    dmImportacaoViaEfd.qryEquipamentoECF.Open;
  end;
  lsIdEquipamentoEcf := dmImportacaoViaEfd.qryEquipamentoECF.FieldByName('ID_FEQUIP_ECF').AsString;

  if (lsIdEquipamentoEcf = '') then begin
    FoStrLstErros.Add('Registro: '+lsRegistro+' - Linha: '+IntToStr(piNumeroLinha+1)+' - Equipamento nº série '+lsECFFabricacao+', não cadastrado no MegaFiscal.',True);
  end else begin
    liNumeroLinha := piNumeroLinha+1;
    lsLinha    := FoStrLstEfd.Strings[liNumeroLinha];
    lsRegistro := StrToken(lsLinha,'|',2);
    while (liNumeroLinha < FoStrLstEfd.Count-1) and (Copy(lsRegistro,1,2) = 'C4') and (lsRegistro <> 'C400') do begin
      lblProgresso.Caption := 'Importando Registro: '+lsRegistro+'  '+IntToStr(liNumeroLinha);
      Application.ProcessMessages;
      ldblCancelamentos := 0;
      ldblDescontos     := 0;
      ldblValorPis      := 0;
      ldblExclusaoPIS   := 0;
      ldblAliquotaICMS  := 0;
      ldblVlOperacao    := 0;
      ldblVlBcIcms      := 0;

      if (lsRegistro = 'C405') then begin {Redução Z}
        ldblTotalDescontos     := 0;
        ldblTotalCancelamentos := 0;

        ldDataEmissao  := StrSemBarrasToDate(StrToken(lsLinha,'|',3));

        if (ldDataEmissao < rInfoAplicacao.dDataInicioPessoa) then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+' A data de emissão do documento fiscal não pode ser inferior a data que empresa iniciou o uso do MegaFiscal',True);
        end else if (rInfoAplicacao.dDataInicioParametros < TP_DATA_INICIAL)
          or (rInfoAplicacao.dDataInicioParametros > ldDataEmissao)
        then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+'-Não existem parâmetros cadastrados para a data de '+DateToStr(ldDataEmissao)+'.',True);
        end;

        liCRO          := StrToInt(StrToken(lsLinha,'|',4));
        liCRZ          := StrToInt(StrToken(lsLinha,'|',5));
        liCooInicial   := StrToInt(StrToken(lsLinha,'|',6));
        liCooFinal     := StrToInt(StrToken(lsLinha,'|',6));

        ldblGT         := 0;
        ldblVendaBruta := 0;
        TryStrToCurr(StrToken(lsLinha,'|',7),ldblGT        );
        TryStrToCurr(StrToken(lsLinha,'|',8),ldblVendaBruta);
        inc(liNumeroLinha);
      end else if (lsRegistro = 'C420') then begin {Cancelamentos/Descontos}
        if (Pos(Copy(StrToken(lsLinha,'|',3),1,2),'DT*DS*DO') > 0)  then begin {Descontos}
          if TryStrToCurr(StrToken(lsLinha,'|',4),ldblDescontos) then begin
            ldblTotalDescontos := ldblTotalDescontos+ldblDescontos;
          end;
        end else if (Copy(StrToken(lsLinha,'|',3),1,3) = 'Can') then begin {Cancelamento}
          if TryStrToCurr(StrToken(lsLinha,'|',4),ldblCancelamentos) then begin
            ldblTotalCancelamentos := ldblTotalCancelamentos+ldblCancelamentos;
          end;
        end;
        inc(liNumeroLinha);
      end else if (lsRegistro = 'C425') then begin {Exclusão da Base PIS/COFINS}
        TryStrToCurr(StrToken(lsLinha,'|',7),ldblValorPis);
        if (ldblValorPis = 0) then begin
          {Todo valor importado de ECF é definido com a alíquota básica para o
          PIS/COFINS. Porém, os valores cujos itens do registro C425, constar
          valor zero no campo 06, VL_PIS, são excluidos da BASE PIS/COFINS}
          if TryStrToCurr(StrToken(lsLinha,'|',6),ldblExclusaoPIS) then begin
            ldblTotalExclusaoPIS := ldblTotalExclusaoPIS+ldblExclusaoPIS;
          end;
        end;
        inc(liNumeroLinha);
      end else if (lsRegistro = 'C490') then begin {Movimento do DIA}
        lsIdDfsEcf     := CreateClassID;

        dmImportacaoViaEfd.qryVerificaDFSEcf.Close;
        dmImportacaoViaEfd.qryVerificaDFSEcf.ParamByName('pIdPessoa'   ).AsString  := TUtil.getIDPessoa;
        dmImportacaoViaEfd.qryVerificaDFSEcf.ParamByName('pIdEquipEcf' ).AsString  := lsIdEquipamentoEcf;
        dmImportacaoViaEfd.qryVerificaDFSEcf.ParamByName('pCRZ'        ).AsInteger := liCRZ;
        dmImportacaoViaEfd.qryVerificaDFSEcf.ParamByName('pCRO'        ).AsInteger := liCRO;
        dmImportacaoViaEfd.qryVerificaDFSEcf.ParamByName('pCooFinal'   ).AsInteger := liCooFinal;
        dmImportacaoViaEfd.qryVerificaDFSEcf.ParamByName('pDataEmissao').AsDate    := ldDataEmissao;
        dmImportacaoViaEfd.qryVerificaDFSEcf.Open;

        if (not dmImportacaoViaEfd.qryVerificaDFSEcf.IsEmpty) then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+', Redução Z '+IntToStr(liCRZ)+' lançado em '+dmImportacaoViaEfd.qryVerificaDFSEcf.FieldByName('DATA_EMISSAO').AsString+', no lote de saídas '+IntToStr(dmImportacaoViaEfd.qryVerificaDFSEcf.FieldByName('NUMERO').AsInteger)+', Linha '+IntToStr(dmImportacaoViaEfd.qryVerificaDFSEcf.FieldByName('LINHA').AsInteger)+'.',True);
          Inc(liNumeroLinha);
        end else begin
          dmImportacaoViaEfd.cdsDFSEcfTemp.Insert;
          dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName('ID_FDFS_ECF' ).AsString   := lsIdDfsEcf;
          dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName('FK_PESSOA'   ).AsString   := TUtil.getIDPessoa;
          dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName('DATA_EMISSAO').AsDateTime := ldDataEmissao;
          dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName('FK_LOTE'     ).AsString   := FsIdLoteDFS_ECF;
          dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName('LINHA'       ).AsInteger  := FiLinhaDFS_ECF;
          dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName('FK_EQUIP_ECF').AsString   := lsIdEquipamentoEcf;
          dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName('CRO'         ).AsInteger  := liCRO;
          dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName('CRZ'         ).AsInteger  := liCRZ;
          dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName('COO_INICIAL' ).AsInteger  := liCooInicial;
          dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName('COO_FINAL'   ).AsInteger  := liCooFinal;
          dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName('VENDA_BRUTA' ).AsCurrency := ldblVendaBruta;
          dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName('CANCELAMENTO').AsCurrency := ldblTotalCancelamentos;
          dmImportacaoViaEfd.cdsDFSEcfTemp.FieldByName('DESCONTO'    ).AsCurrency := ldblTotalDescontos;
          dmImportacaoViaEfd.cdsDFSEcfTemp.Post;
          Inc(FiLinhaDFS_ECF);

          while (lsRegistro = 'C490') do begin
            liCstIcmsOrigem   := 0;
            TryStrToInt(Copy(StrToken(lsLinha,'|',3),1,1),liCstIcmsOrigem);
            if (liCstIcmsOrigem > 2) then begin
              liCstIcmsOrigem := 0; {Origem Nacional}
            end;

            lsCSTIcmsOriginal := Copy(StrToken(lsLinha,'|',3),2,2);
            lsCSTIcms         := lsCSTIcmsOriginal;
            if (Pos(lsCstIcms,'00*10*20*30*40*41*50*51*60**70*90') = 0) then begin
              lsCstIcms := '90';
              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS 90.',True);
            end;
            lsCFOP := StrToken(lsLinha,'|',4);

            ldblAliquotaICMS := 0;
            ldblVlOperacao   := 0;
            ldblVlBcIcms     := 0;

            TryStrToCurr(StrToken(lsLinha,'|',5),ldblAliquotaICMS);
            TryStrToCurr(StrToken(lsLinha,'|',6),ldblVlOperacao  );
            TryStrToCurr(StrToken(lsLinha,'|',7),ldblVlBcIcms    );

            if (ldblVlOperacao > 0) then begin
              if (ldblExclusaoPIS = 0) then begin
                ldblBasePisCofins := ldblVlOperacao;
              end else if (ldblExclusaoPIS <= ldblVlOperacao) then begin
                ldblBasePisCofins := (ldblVlOperacao-ldblExclusaoPIS);
                ldblExclusaoPIS   := 0;
              end else begin
                ldblBasePisCofins := 0;
                ldblExclusaoPIS   := (ldblExclusaoPIS-ldblVlOperacao);
              end;
              if (ldblBasePisCofins > 0) then begin
  //              lsCSTPisCofins := '01';
                lsCSTPisCofins := dmImportacaoViaEfd.cdsCstPisCofinsSaidas.FieldByName('CODIGO').AsString;
                if (lsCSTPisCofins > '05') then begin
                  if (lsCSTPisCofins <> '06') then begin
                    ldblBasePisCofins  := 0;
                  end;
                  ldblAliquotaPis    := 0;
                  ldblAliquotaCofins := 0;
                end else begin
                  ldblAliquotaPis    := rAliquotaOperacao.dblPis;
                  ldblAliquotaCofins := rAliquotaOperacao.dblCofins;
                end;
              end else begin
                lsCSTPisCofins := '05';
              end;

              if not TryStrToInt(lsCfop,liCfop) then begin
                liCfop := 0;
                FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha)+', CFOP '+lsCfop+', inválido.',True);
              end;

              Try
                liCfopTabela := dmImportacaoViaEfd.qryCfop.FieldByName('CODIGO').AsInteger;
              except
                liCfopTabela := 0;
              end;

              if (not dmImportacaoViaEfd.qryCfop.Active)
                or (dmImportacaoViaEfd.qryCfop.Eof)
                or (liCfopTabela <> liCfop)
              then begin
                dmImportacaoViaEfd.qryCfop.Close;
                dmImportacaoViaEfd.qryCfop.ParamByName('pCfop').AsInteger := liCfop;
                dmImportacaoViaEfd.qryCfop.Open;

                if (dmImportacaoViaEfd.qryCfop.IsEmpty) then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inexistente.',True);
                end else begin
                  dmImportacaoViaEfd.qryCfop.Filtered := False;
                  dmImportacaoViaEfd.qryCfop.Filter   := FsFiltroCfop;
                  dmImportacaoViaEfd.qryCfop.Filtered := True;
                end;
              end;
              lsIdCfop := dmImportacaoViaEfd.qryCfop.FieldByName('ID_FCFOP').AsString;

              if (not dmImportacaoViaEfd.qryCfop.IsEmpty) then begin
                if (lsIdCfop = '') then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido para uso por essa empresa.',True);
                end else if (not IntToBoolean(dmImportacaoViaEfd.qryCfop.FieldByName('USO_ECF').AsInteger)) then begin
                  FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido para uso em ECF.',True);
                end;
              end;

              if (ldblAliquotaIcms < 0)
                or (ldblAliquotaIcms > 38)
              then begin
                FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Alíquota do ICMS '+CurrToStr(ldblAliquotaIcms)+' inválida.',True);
              end;

              if (FoStrLstErros.Count = 0) then begin
                if dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.Locate('FK_DFS_ECF;FK_CFOP;CST_ICMS;CST_ICMS_ORIGEM;CST_PIS_COFINS;ALIQUOTA;ALIQUOTA_PIS;ALIQUOTA_COFINS;ALIQUOTA_IR',VarArrayOf([lsIdDfsEcf,lsIdCfop,lsCstIcms,liCstIcmsOrigem,lsCstPisCofins,ldblAliquotaIcms,ldblAliquotaPis,ldblAliquotaCofins,rAliquotaOperacao.dblIR]),[]) then begin
                  dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.Edit;
                end else begin
                  dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.Insert;
                  dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('ID_FDFS_ECF_ANALITICO').AsString   := CreateClassID;
                  dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('FK_PESSOA'            ).AsString   := TUtil.getIDPessoa;
                  dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('FK_DFS_ECF'           ).AsString   := lsIdDfsEcf;
                  dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('CST_ICMS'             ).AsString   := lsCSTIcms;
                  dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('CST_ICMS_ORIGEM'      ).AsInteger  := liCstIcmsOrigem;
                  dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('CST_PIS_COFINS'       ).AsString   := lsCSTPisCofins;
                  dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('FK_CFOP'              ).AsString   := lsIdCFOP;
                  dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('ALIQUOTA'             ).AsCurrency := ldblAliquotaIcms;
                  dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('ALIQUOTA_PIS'         ).AsCurrency := ldblAliquotaPis;
                  dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('ALIQUOTA_COFINS'      ).AsCurrency := ldblAliquotaCofins;
                  dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('ALIQUOTA_IR'          ).AsCurrency := rAliquotaOperacao.dblIR;
                end;
                dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('VALOR_OPERACAO'       ).AsCurrency := dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('VALOR_OPERACAO' ).AsCurrency+ldblVlOperacao;
                dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('BASE_PIS_COFINS'      ).AsCurrency := dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.FieldByName('BASE_PIS_COFINS').AsCurrency+ldblBasePisCofins;
                dmImportacaoViaEfd.cdsDFSEcfAnaliticoTemp.Post;
              end;
            end else begin
              FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', com valor da operação zero não foi importado.',True);
            end;
            Inc(liNumeroLinha);
            lsLinha    := FoStrLstEfd.Strings[liNumeroLinha];
            lsRegistro := StrToken(lsLinha,'|',2);
          end;
        end;
      end else begin
        Inc(liNumeroLinha);
      end;
      lsLinha    := FoStrLstEfd.Strings[liNumeroLinha];
      lsRegistro := StrToken(lsLinha,'|',2);
    end;
  end;
end;

procedure TFImportacaoViaEfd.ImportarRegistroC500(psLinha: String;
  piNumeroLinha: Integer);
var
  lsLinha,lsEntradaSaida,lsCodigoSituacao,lsSerie,lsModelo,lsIdModelo,
  lsCstPisCofins,lsInscMf,lsCfop,
  lsIdEstado,lsIdCfop,lsCodigoMunicipioParticipante,lsCstIcmsOriginal,lsCstIcms,
  lsRegistro,lsCodParticipante,lsIndicadorEmitente,lsIdDFE,lsIdDFS: string;
  ldDataEmissao,ldDataEntradaSaida: TDate;
  liNumeroLinha,liNumero,liLinha,liCfop,liCodigoConsumo,liCfopOperacao: Integer;
  ldblVlTotalC500,ldblDesconto,ldblVlOperacao,ldblBaseIcms,ldblValorIcms,
  ldblBaseIcmsSt,ldblValorIcmsSt,ldblAliquotaICMS,ldblValorRedBC,ldblValorPis,
  ldblValorCofins: Currency;

begin
  Application.ProcessMessages;

  lsRegistro          := StrToken(psLinha,'|',2);
  lsEntradaSaida      := StrToken(psLinha,'|',3);
  lsCodParticipante   := StrToken(psLinha,'|',5);
  lsCodigoSituacao    := StrToken(psLinha,'|',7);
  lsIndicadorEmitente := StrToken(psLinha,'|',4);

  if (Pos(lsCodigoSituacao,'00*01*02*03*04*05*06*07*08') = 0 ) then begin {Ver ValidaTabela AB}
    FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', conteúdo: '+lsCodigoSituacao+'. Código de situação do documento fiscal inválido.',True);
  end;
//  if Pos(lsCodigoSituacao,'00*01*06*07') > 0 then begin {Documento regular/Complementar - Ver Nota 1}
    ldDataEmissao      := StrSemBarrasToDate(StrToken(psLinha,'|',12));
    if (ldDataEmissao < rInfoAplicacao.dDataInicioPessoa) then begin
      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+' A data de emissão do documento fiscal não pode ser inferior a data que empresa iniciou o uso do MegaFiscal',True);
    end else if (rInfoAplicacao.dDataInicioParametros < TP_DATA_INICIAL)
      or (rInfoAplicacao.dDataInicioParametros > ldDataEmissao)
    then begin
      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+'-Não existem parâmetros cadastrados para a data de '+DateToStr(ldDataEmissao)+'.',True);
    end;

    ldDataEntradaSaida := StrSemBarrasToDate(StrToken(psLinha,'|',13));
    lsModelo           := StrToken(psLinha,'|',6);
    if (dmImportacaoViaEfd.qryDFModelo.Locate('CODIGO',lsModelo,[])) then begin
      lsIdModelo := dmImportacaoViaEfd.qryDFModelo.FieldByName('ID_FDF_MODELO').AsString;
    end else begin
      lsIdModelo := '';
    end;
    liNumero := StrToInt(StrToken(psLinha,'|',11));
    if (liNumero <= 0) then begin
      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', Documento fiscal com número inválido.',True);
    end;
    lsSerie  := StrToken(psLinha,'|',8);
    if (lsSerie = '') or (Length(lsSerie) > 3) then begin
//      FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', documento fiscal Nº '+IntToStr(liNumero)+', com a série '+lsSerie+' inválida. Foi substituida pela série 1.',True);
      lsSerie := '1';
    end;
    liCodigoConsumo := 0;
    TryStrToInt(StrToken(psLinha,'|',10),liCodigoConsumo);
//    try
//      liCodigoConsumo := StrToInt(StrToken(psLinha,'|',10));
//    except
//      liCodigoConsumo := 0;
//    end;

    if ((liCodigoConsumo = 4) and (FeRegimeFederal = TTipoRegimeFederal.trf_lucro_real)) then begin {Consumo Industrial para Lucro Real}
      lsCstPisCofins  := '50';
      ldblValorPis    := 0;
      ldblValorCofins := 0;
      TryStrToCurr(StrToken(psLinha,'|',25),ldblValorPis   );
      TryStrToCurr(StrToken(psLinha,'|',26),ldblValorCofins);
    end else begin
      lsCstPisCofins  := '70';
      ldblValorPis    := 0;
      ldblValorCofins := 0;
    end;

    {O ldblVlTotalC500 é total do DF menos descontos}
    ldblVlTotalC500 := 0;
    ldblDesconto    := 0;
    TryStrToCurr(StrToken(psLinha,'|',14),ldblVlTotalC500);
    TryStrToCurr(StrToken(psLinha,'|',15),ldblDesconto   );
    ldblVlTotalC500 := ldblVlTotalC500-ldblDesconto;

    if lsEntradaSaida = '0' then begin {Entrada}
      if (edtLoteEntradas.Value > 0) then begin
        if (dmImportacaoViaEfd.cdsParticipanteTemp.Locate('COD_PART',lsCodParticipante,[])) then begin
//          FdblTotalLoteEntradas := FdblTotalLoteEntradas+ldblVlTotalC500;
          dmImportacaoViaEfd.qryVerificaDFE.Close;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pIdPessoa'      ).AsString  := TUtil.getIDPessoa;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pIdDFModelo'    ).AsString  := lsIdModelo;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pSerie'         ).AsString  := lsSerie;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pNumero'        ).AsInteger := liNumero;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pIdParticipante').AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
          dmImportacaoViaEfd.qryVerificaDFE.Open;

          if (not dmImportacaoViaEfd.qryVerificaDFE.IsEmpty) then begin
            FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+', Documento fiscal '+IntToStr(liNumero)+' lançado em '+dmImportacaoViaEfd.qryVerificaDFE.FieldByName('DATA_ENTRADA').AsString+', no lote de entradas '+IntToStr(dmImportacaoViaEfd.qryVerificaDFE.FieldByName('NUMERO').AsInteger)+', Linha '+IntToStr(dmImportacaoViaEfd.qryVerificaDFE.FieldByName('LINHA').AsInteger)+'.',True);
          end;
          lsIdDFE := CreateClassID;
          dmImportacaoViaEfd.cdsDFETemp.Insert;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('ID_FDFE'           ).AsString   := lsIdDFE;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_PESSOA'         ).AsString   := TUtil.getIDPessoa;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_LOTE'           ).AsString   := FsIdLoteDFE;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('LINHA'             ).AsInteger  := FiLinhaDFE;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('INDICADOR_EMITENTE').AsString   := lsIndicadorEmitente;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_PARTICIPANTE'   ).AsString   := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_DF_MODELO'      ).AsString   := lsIdModelo;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('CODIGO_SITUACAO'   ).AsString   := lsCodigoSituacao;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('SERIE'             ).AsString   := lsSerie;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('NUMERO'            ).AsInteger  := liNumero;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('CHAVE_NFE'         ).AsString   := '';
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('DATA_EMISSAO'      ).AsDateTime := ldDataEmissao;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('DATA_ENTRADA'      ).AsDateTime := ldDataEntradaSaida;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('VALOR'             ).AsCurrency := ldblVlTotalC500;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('INDICADOR_PGTO'    ).AsInteger  := 0;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('INDICADOR_FRETE'   ).AsInteger  := 3;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('ART_377_RICMS'     ).AsInteger  := 0;
          Inc(FiLinhaDFE);
        end;
      end;
    end else begin  {Saída}
//      if (edtLoteSaidas.Value > 0) then begin
//        if (dmImportacaoViaEfd.cdsParticipanteTemp.Locate('COD_PART',lsCodParticipante,[])) then begin
//          FdblTotalLoteSaidas := FdblTotalLoteSaidas+ldblVlTotalC500;
//          lsCodigoMunicipioParticipante := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('COD_MUN').AsString;
////          ldData   := ldDataEmissao;
//          dmImportacaoViaEfd.qryVerificaDFS.Close;
//          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pIdPessoa'      ).AsString  := TUtil.getIDPessoa;
//          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pIdDFModelo'    ).AsString  := lsIdModelo;
//          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pSerie'         ).AsString  := lsSerie;
//          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pNumero'        ).AsInteger := liNumero;
//          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pIdParticipante').AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
//          dmImportacaoViaEfd.qryVerificaDFS.Open;
//
//          if (not dmImportacaoViaEfd.qryVerificaDFS.IsEmpty) then begin
//            FoStrLstInconsistencias.Add('Registro C100, linha: '+IntToStr(piNumeroLinha)+', Documento fiscal '+IntToStr(liNumero)+' lançado em '+dmImportacaoViaEfd.qryVerificaDFS.FieldByName('DATA_EMISSAO').AsString+', no lote de saídas '+IntToStr(dmImportacaoViaEfd.qryVerificaDFS.FieldByName('NUMERO').AsInteger)+', Linha '+IntToStr(dmImportacaoViaEfd.qryVerificaDFS.FieldByName('LINHA').AsInteger)+'.',True);
//          end else begin
//            if (not dmImportacaoViaEfd.qryCidadeEstado.Active)
//              or (dmImportacaoViaEfd.qryCidadeEstado.FieldByName('CODIGO_IBGE').AsString <> lsCodigoMunicipioParticipante)
//            then begin
//              dmImportacaoViaEfd.qryCidadeEstado.Close;
//              dmImportacaoViaEfd.qryCidadeEstado.ParamByName('pCodigoMunicipio').AsString := lsCodigoMunicipioParticipante;
//              dmImportacaoViaEfd.qryCidadeEstado.Open;
//            end;
//            lsIdEstado := dmImportacaoViaEfd.qryCidadeEstado.FieldByName('ID_ESTADOS').AsString;
//
//            lsIdDFS := CreateClassID;
//            dmImportacaoViaEfd.cdsDFSTemp.Insert;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('ID_FDFS'           ).AsString   := lsIdDFS;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_PESSOA'         ).AsString   := TUtil.getIDPessoa;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_LOTE'           ).AsString   := FsIdLoteDFS;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('LINHA'             ).AsInteger  := FiLinhaDFS;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('INDICADOR_EMITENTE').AsString   := lsIndicadorEmitente;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_PARTICIPANTE'   ).AsString   := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_ESTADO'         ).AsString   := lsIdEstado;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_DF_MODELO'      ).AsString   := lsIdModelo;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('CODIGO_SITUACAO'   ).AsString   := lsCodigoSituacao;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('SERIE'             ).AsString   := lsSerie;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('NUMERO'            ).AsInteger  := liNumero;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('CHAVE_NFE'         ).AsString   := StrToken(psLinha,'|',9);
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('DATA_EMISSAO'      ).AsDateTime := ldDataEmissao;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('DATA_SAIDA'        ).AsDateTime := ldDataEntradaSaida;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('VALOR'             ).AsCurrency := ldblVlTotalC100;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('INDICADOR_PGTO'    ).AsInteger  := StrToInt(StrToken(psLinha,'|',13));
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('INDICADOR_FRETE'   ).AsInteger  := ;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('ART_377_RICMS'     ).AsInteger  := 0;
//            dmImportacaoViaEfd.cdsDFSTemp.Post;
//            Inc(FiLinhaDFE);
//          end;
//        end;
//      end;
    end;
    if (lsModelo = '') then begin
      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', conteúdo: '+lsModelo+'. Modelo do documento fiscal inválido.',True);
    end;

    liNumeroLinha := piNumeroLinha+1;
    lsRegistro := StrToken(FoStrLstEfd.Strings[liNumeroLinha],'|',2);
    while (liNumeroLinha < FoStrLstEfd.Count-1) and (Copy(lsRegistro,1,2) = 'C5') and (lsRegistro <> 'C500') do begin
      lblProgresso.Caption := 'Importando Registro: '+lsRegistro+'  '+IntToStr(liNumeroLinha);
      NGauge.Progress := liNumeroLinha;
      Application.ProcessMessages;
      lsLinha := FoStrLstEfd.Strings[liNumeroLinha];
      if (lsRegistro = 'C590') then begin
        lsCstIcmsOriginal := Copy(StrToken(lsLinha,'|',3),2,2);
        lsCstIcms         := lsCstIcmsOriginal;
        if (Pos(lsCstIcms,'00*10*20*30*40*41*50*51*60**70*90') = 0) then begin
          lsCstIcms := '90';
          FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS 90.',True);
        end;

        lsCfop := StrToken(lsLinha,'|',4);
        liCfop := StrToInt(lsCfop);
        if (not dmImportacaoViaEfd.qryCfop.Active)
          or (dmImportacaoViaEfd.qryCfop.Eof)
          or (dmImportacaoViaEfd.qryCfop.FieldByName('CODIGO').AsInteger <> liCfop)
        then begin
          dmImportacaoViaEfd.qryCfop.Close;
          dmImportacaoViaEfd.qryCfop.ParamByName('pCfop').AsInteger := liCfop;
          dmImportacaoViaEfd.qryCfop.Open;
          dmImportacaoViaEfd.qryCfop.Filtered := False;
          dmImportacaoViaEfd.qryCfop.Filter   := FsFiltroCfop;
          dmImportacaoViaEfd.qryCfop.Filtered := True;
        end;
        lsIdCfop := dmImportacaoViaEfd.qryCfop.FieldByName('ID_FCFOP').AsString;
        if (lsIdCfop = '') then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido.',True);
        end;
        liCfopOperacao   := dmImportacaoViaEfd.qryCfop.FieldByName('OPERACAO'  ).AsInteger;

        ldblVlOperacao   := 0;
        ldblBaseIcms     := 0;
        ldblValorIcms    := 0;
        ldblBaseIcmsSt   := 0;
        ldblValorIcmsSt  := 0;
        ldblAliquotaICMS := 0;
        ldblValorRedBC   := 0;

        TryStrToCurr(StrToken(lsLinha,'|',06),ldblVlOperacao  );
        TryStrToCurr(StrToken(lsLinha,'|',07),ldblBaseIcms    );
        TryStrToCurr(StrToken(lsLinha,'|',05),ldblAliquotaICMS);
        TryStrToCurr(StrToken(lsLinha,'|',07),ldblValorIcms   );
        TryStrToCurr(StrToken(lsLinha,'|',09),ldblBaseIcmsSt  );
        TryStrToCurr(StrToken(lsLinha,'|',10),ldblValorIcmsSt );
        TryStrToCurr(StrToken(lsLinha,'|',11),ldblValorRedBC  );

        if (ldblAliquotaIcms < 0)
          or (ldblAliquotaIcms > 38)
        then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Alíquota do ICMS '+CurrToStr(ldblAliquotaIcms)+' inválida.',True);
        end;

        if (ldblBaseIcms = 0)
          and (Pos(lsCstIcms,'00*10*20') > 0)
        then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', para CST/ICMS '+lsCstIcms+', é necessário informar a base de cálculo do ICMS.',True);
        end else if (ldblBaseIcms <> 0)
          and (Pos(lsCstIcms,'00*10*20') = 0)
        then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', para CST/ICMS '+lsCstIcms+', não deve ser informada a base de cálculo do ICMS.',True);
        end;

        if lsEntradaSaida = '0' then begin {C590 - Entrada}
          if (edtLoteEntradas.Value > 0) then begin
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Insert;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ID_FDFE_ANALITICO'     ).AsString   := CreateClassID;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_DFE'                ).AsString   := lsIdDFE;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_PESSOA'             ).AsString   := TUtil.getIDPessoa;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_ICMS'              ).AsString   := lsCstIcms;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_IPI'               ).AsString   := '49';
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_PIS_COFINS'        ).AsString   := lsCstPisCofins;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_CFOP'               ).AsString   := lsIdCfop;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_OPERACAO'        ).AsCurrency := ldblVlOperacao;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS'             ).AsCurrency := ldblBaseIcms;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_ICMS'         ).AsCurrency := ldblAliquotaICMS;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_ICMS'            ).AsCurrency := ldblValorIcms;
            if (liCfopOperacao = rInfoConstantes.iOprDevolucaoAnulacao) then begin
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_ST'          ).AsCurrency := ldblBaseIcmsSt;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_ICMS_ST'         ).AsCurrency := ldblValorIcmsSt;
            end;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('REDUCAO_BASE_ICMS'     ).AsCurrency := ldblValorRedBC;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_IPI'              ).AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_IPI'             ).AsCurrency := 0;
            if (lsCstPisCofins = '50') then begin
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_PIS_COFINS'       ).AsCurrency := ldblVlOperacao;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_PIS'          ).AsCurrency := (ldblValorPis   *100)/ldblVlOperacao;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_COFINS'       ).AsCurrency := (ldblValorCofins*100)/ldblVlOperacao;
            end else begin
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_PIS_COFINS'       ).AsCurrency := 0;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_PIS'          ).AsCurrency := 0;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_COFINS'       ).AsCurrency := 0;
            end;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_AT_AP_DA'    ).AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CREDITO_ICMS_AT_AP_DA' ).AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_ICMS_AT_AP_DA').AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('MVA'                   ).AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_IR'           ).AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('TIPO_CFOP'             ).AsString   := '00';
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Post;
          end;
        end else begin {C590 - Saída}
//          if (edtLoteSaidas.Value > 0) then begin
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Insert;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ID_FDFS_ANALITICO'     ).AsString   := CreateClassID;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('FK_DFE'                ).AsString   := lsIdDFE;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('FK_PESSOA'             ).AsString   := TUtil.getIDPessoa;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('CST_ICMS'              ).AsString   := StrToken(lsLinha,'|',10);
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('CST_IPI'               ).AsString   := StrToken(lsLinha,'|',20);
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('CST_PIS_COFINS'        ).AsString   := StrToken(lsLinha,'|',25);
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('FK_CFOP'               ).AsString   := lsIdCfop;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_OPERACAO'        ).AsCurrency := 0;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_CALCULO'          ).AsCurrency := StrToCurr(StrToken(lsLinha,'|',13));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA'              ).AsCurrency := StrToCurr(StrToken(lsLinha,'|',14));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_ICMS'            ).AsCurrency := StrToCurr(StrToken(lsLinha,'|',15));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_ICMS_ST'          ).AsCurrency := StrToCurr(StrToken(lsLinha,'|',16));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_ICMS_ST'         ).AsCurrency := StrToCurr(StrToken(lsLinha,'|',18));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('REDUCAO_BASE_ICMS'     ).AsCurrency := 0;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_IPI'              ).AsCurrency := StrToCurr(StrToken(lsLinha,'|',22));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_IPI'             ).AsCurrency := StrToCurr(StrToken(lsLinha,'|',24));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_PIS_COFINS'       ).AsCurrency := StrToCurr(StrToken(lsLinha,'|',26));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA_PIS'          ).AsCurrency := StrToCurr(StrToken(lsLinha,'|',27));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA_COFINS'       ).AsCurrency := StrToCurr(StrToken(lsLinha,'|',33));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA_IR'           ).AsCurrency := rAliquotaOperacao.dblIR;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Post;
//          end;
        end;
      end;
      inc(liNumeroLinha);
      lsRegistro := StrToken(FoStrLstEfd.Strings[liNumeroLinha],'|',2);
    end;
//  end;
end;

procedure TFImportacaoViaEfd.ImportarRegistroD100(psLinha: String;
  piNumeroLinha: Integer);
var
  lsLinha,lsEntradaSaida,lsCodigoSituacao,lsSerie,lsModelo,lsIdModelo,
  lsCodTriIcm,lsCodTriIpi,lsInscMf,lsIdEstado,lsCfop,lsIdCfop,
  lsCodigoMunicipioParticipante,lsCstIcmsOriginal,lsCstIcms,lsRegistro,
  lsCodParticipante,lsIndicadorEmitente,lsIdDFE,lsIdDFS,
  lsCstPisCofinsEntradas: string;
//  ldData
  ldDataEmissao,ldDataEntradaSaida: TDate;
  liNumeroLinha,liNumero,liLinha,liCfop,liCfopOperacao,liIndicadorFrete: Integer;
  ldblVlTotalD100,ldblVlOperacao,ldblBaseIcms,ldblValorIcms,ldblAliquotaICMS,
  ldblValorRedBC,ldblDesconto: Currency;

begin
  Application.ProcessMessages;
  lsRegistro          := StrToken(psLinha,'|',2);
  lsEntradaSaida      := StrToken(psLinha,'|',3);
  lsCodParticipante   := StrToken(psLinha,'|',5);
  lsCodigoSituacao    := StrToken(psLinha,'|',7);
  lsIndicadorEmitente := StrToken(psLinha,'|',4);
  liIndicadorFrete := 0;
  TryStrToInt(StrToken(psLinha,'|',18),liIndicadorFrete);

  if (liIndicadorFrete = 9) then begin
    liIndicadorFrete := 3;
  end;

  if (Pos(lsCodigoSituacao,'00*01*02*03*04*05*06*07*08') = 0 ) then begin {Ver ValidaTabela AB}
    FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', conteúdo: '+lsCodigoSituacao+'. Código de situação do documento fiscal inválido.',True);
  end;

  if ((FeRegimeFederal = TTipoRegimeFederal.trf_lucro_real)) then begin {Consumo Industrial para Lucro Real}
    lsCstPisCofinsEntradas := '50';
  end else begin
    lsCstPisCofinsEntradas := '98';
  end;

  if ((lsEntradaSaida = '0')
    and (edtLoteEntradas.Value > 0))
      or ((lsEntradaSaida = '1')
      and (edtLoteSaidas.Value > 0))
  then begin
    ldDataEmissao      := StrSemBarrasToDate(StrToken(psLinha,'|',12));
    ldDataEntradaSaida := StrSemBarrasToDate(StrToken(psLinha,'|',13));
    if (lsEntradaSaida = '0') then begin
      if (rInfoAplicacao.dDataInicioParametros < TP_DATA_INICIAL)
        or (rInfoAplicacao.dDataInicioParametros > ldDataEntradaSaida)
      then begin
        FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+'-Não existem parâmetros cadastrados para a data de '+DateToStr(ldDataEntradaSaida)+'.',True);
      end;
    end else begin
      if (ldDataEmissao < rInfoAplicacao.dDataInicioPessoa) then begin
        FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+' A data de emissão do documento fiscal não pode ser inferior a data que empresa iniciou o uso do MegaFiscal',True);
      end else if (rInfoAplicacao.dDataInicioParametros < TP_DATA_INICIAL)
        or (rInfoAplicacao.dDataInicioParametros > ldDataEmissao)
      then begin
        FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+'-Não existem parâmetros cadastrados para a data de '+DateToStr(ldDataEmissao)+'.',True);
      end;
    end;
    lsModelo           := StrToken(psLinha,'|',6);
    if (dmImportacaoViaEfd.qryDFModelo.Locate('CODIGO',lsModelo,[])) then begin
      lsIdModelo := dmImportacaoViaEfd.qryDFModelo.FieldByName('ID_FDF_MODELO').AsString;
    end else begin
      lsIdModelo := '';
    end;
    lsSerie         := StrToken(psLinha,'|',8);
    liNumero        := StrToInt(StrToken(psLinha,'|',10));
    if (liNumero <= 0) then begin
      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', Documento fiscal com número inválido.',True);
    end;
    if (lsSerie = '') or (Length(lsSerie) > 3) then begin
//      FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', documento fiscal Nº '+IntToStr(liNumero)+', com a série '+lsSerie+' inválida. Foi substituida pela série 1.',True);
      lsSerie := '1';
    end;

    {O ldblVlTotalD100 é total do DF menos descontos}
    ldblVlTotalD100 := 0;
    TryStrToCurr(StrToken(psLinha,'|',16),ldblVlTotalD100);
    ldblDesconto := 0;
    TryStrToCurr(StrToken(psLinha,'|',17),ldblDesconto);
    ldblVlTotalD100 := (ldblVlTotalD100-ldblDesconto);
    if (ldblVlTotalD100 <= 0)
      and (Pos(lsCodigoSituacao,'00*01*06*07') > 0)
    then begin
      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', documento fiscal Nº '+IntToStr(liNumero)+', falta valor total.',True);
    end;

    if lsEntradaSaida = '0' then begin {Entrada}
      if (edtLoteEntradas.Value > 0) then begin
        if (dmImportacaoViaEfd.cdsParticipanteTemp.Locate('COD_PART',lsCodParticipante,[])) then begin
//          FdblTotalLoteEntradas := FdblTotalLoteEntradas+ldblVlTotalD100;
          dmImportacaoViaEfd.qryVerificaDFE.Close;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pIdPessoa'      ).AsString  := TUtil.getIDPessoa;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pIdDFModelo'    ).AsString  := lsIdModelo;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pSerie'         ).AsString  := lsSerie;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pNumero'        ).AsInteger := liNumero;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pIdParticipante').AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
          dmImportacaoViaEfd.qryVerificaDFE.Open;

          if (not dmImportacaoViaEfd.qryVerificaDFE.IsEmpty) then begin
            FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', Documento fiscal '+IntToStr(liNumero)+' lançado em '+dmImportacaoViaEfd.qryVerificaDFE.FieldByName('DATA_ENTRADA').AsString+', no lote de entradas '+IntToStr(dmImportacaoViaEfd.qryVerificaDFE.FieldByName('NUMERO').AsInteger)+', Linha '+IntToStr(dmImportacaoViaEfd.qryVerificaDFE.FieldByName('LINHA').AsInteger)+'.',True);
          end;
          lsIdDFE := CreateClassID;
          dmImportacaoViaEfd.cdsDFETemp.Insert;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('ID_FDFE'           ).AsString   := lsIdDFE;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_PESSOA'         ).AsString   := TUtil.getIDPessoa;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_LOTE'           ).AsString   := FsIdLoteDFE;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('LINHA'             ).AsInteger  := FiLinhaDFE;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('INDICADOR_EMITENTE').AsString   := lsIndicadorEmitente;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_PARTICIPANTE'   ).AsString   := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_DF_MODELO'      ).AsString   := lsIdModelo;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('CODIGO_SITUACAO'   ).AsString   := lsCodigoSituacao;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('SERIE'             ).AsString   := lsSerie;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('NUMERO'            ).AsInteger  := liNumero;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('CHAVE_NFE'         ).AsString   := StrToken(psLinha,'|',15);
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('DATA_EMISSAO'      ).AsDateTime := ldDataEmissao;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('DATA_ENTRADA'      ).AsDateTime := ldDataEntradaSaida;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('VALOR'             ).AsCurrency := ldblVlTotalD100;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('INDICADOR_PGTO'    ).AsInteger  := 0;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('INDICADOR_FRETE'   ).AsInteger  := liIndicadorFrete;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('ART_377_RICMS'     ).AsInteger  := 0;
          dmImportacaoViaEfd.cdsDFETemp.Post;
          Inc(FiLinhaDFE);
        end else begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', Documento fiscal '+IntToStr(liNumero)+', não foi localizado o código do participante '+lsCodParticipante+' nos registros 0150.',True);
        end;
      end;
    end else begin  {Saída}
      if (edtLoteSaidas.Value > 0) then begin
        if (dmImportacaoViaEfd.cdsParticipanteTemp.Locate('COD_PART',lsCodParticipante,[])) then begin
//          FdblTotalLoteSaidas := FdblTotalLoteSaidas+ldblVlTotalD100;
          lsCodigoMunicipioParticipante := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('COD_MUN').AsString;
//          ldData   := ldDataEmissao;
          dmImportacaoViaEfd.qryVerificaDFS.Close;
          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pIdPessoa'      ).AsString  := TUtil.getIDPessoa;
          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pIdDFModelo'    ).AsString  := lsIdModelo;
          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pSerie'         ).AsString  := lsSerie;
          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pNumero'        ).AsInteger := liNumero;
          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pIdParticipante').AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
          dmImportacaoViaEfd.qryVerificaDFS.Open;

          if (not dmImportacaoViaEfd.qryVerificaDFS.IsEmpty) then begin
            FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', Documento fiscal '+IntToStr(liNumero)+' lançado em '+dmImportacaoViaEfd.qryVerificaDFS.FieldByName('DATA_EMISSAO').AsString+', no lote de saídas '+IntToStr(dmImportacaoViaEfd.qryVerificaDFS.FieldByName('NUMERO').AsInteger)+', Linha '+IntToStr(dmImportacaoViaEfd.qryVerificaDFS.FieldByName('LINHA').AsInteger)+'.',True);
          end else begin
            if (not dmImportacaoViaEfd.qryCidadeEstado.Active)
              or (dmImportacaoViaEfd.qryCidadeEstado.FieldByName('CODIGO_IBGE').AsString <> lsCodigoMunicipioParticipante)
            then begin
              dmImportacaoViaEfd.qryCidadeEstado.Close;
              dmImportacaoViaEfd.qryCidadeEstado.ParamByName('pCodigoMunicipio').AsString := lsCodigoMunicipioParticipante;
              dmImportacaoViaEfd.qryCidadeEstado.Open;
            end;
            lsIdEstado := dmImportacaoViaEfd.qryCidadeEstado.FieldByName('ID_ESTADOS').AsString;

            lsIdDFS := CreateClassID;
            dmImportacaoViaEfd.cdsDFSTemp.Insert;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('ID_FDFS'           ).AsString   := lsIdDFS;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_PESSOA'         ).AsString   := TUtil.getIDPessoa;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_LOTE'           ).AsString   := FsIdLoteDFS;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('LINHA'             ).AsInteger  := FiLinhaDFS;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('INDICADOR_EMITENTE').AsString   := lsIndicadorEmitente;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_PARTICIPANTE'   ).AsString   := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_ESTADO'         ).AsString   := lsIdEstado;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_DF_MODELO'      ).AsString   := lsIdModelo;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('CODIGO_SITUACAO'   ).AsString   := lsCodigoSituacao;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('SERIE'             ).AsString   := lsSerie;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('NUMERO'            ).AsInteger  := liNumero;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('CHAVE_NFE'         ).AsString   := StrToken(psLinha,'|',15);
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('DATA_EMISSAO'      ).AsDateTime := ldDataEmissao;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('DATA_SAIDA'        ).AsDateTime := ldDataEntradaSaida;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('VALOR'             ).AsCurrency := ldblVlTotalD100;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('INDICADOR_PGTO'    ).AsInteger  := 0;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('INDICADOR_FRETE'   ).AsInteger  := liIndicadorFrete;
            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('ART_377_RICMS'     ).AsInteger  := 0;

            dmImportacaoViaEfd.cdsDFSTemp.Post;
            Inc(FiLinhaDFS);
          end;
        end;
      end;
    end;

    if (lsModelo = '') then begin
      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', conteúdo: '+lsModelo+'. Modelo do documento fiscal inválido.',True);
    end;

    liNumeroLinha := piNumeroLinha+1;
    lsRegistro := StrToken(FoStrLstEfd.Strings[liNumeroLinha],'|',2);
    while (liNumeroLinha < FoStrLstEfd.Count-1) and (Copy(lsRegistro,1,2) = 'D1') and (lsRegistro <> 'D100') do begin
      lblProgresso.Caption := 'Importando Registro: '+lsRegistro+'  '+IntToStr(liNumeroLinha);
      NGauge.Progress := liNumeroLinha;
      Application.ProcessMessages;

      lsLinha := FoStrLstEfd.Strings[liNumeroLinha];
      if (lsRegistro = 'D190') then begin
        lsCstIcmsOriginal := Copy(StrToken(lsLinha,'|',3),2,2);
        lsCstIcms         := lsCstIcmsOriginal;
        if (Pos(lsCstIcms,'00*10*20*30*40*41*50*51*60**70*90') = 0) then begin
          lsCstIcms := '90';
          FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS 90.',True);
        end;

        lsCfop := StrToken(lsLinha,'|',4);
        liCfop := StrToInt(lsCfop);
        if (not dmImportacaoViaEfd.qryCfop.Active)
          or (dmImportacaoViaEfd.qryCfop.Eof)
          or (dmImportacaoViaEfd.qryCfop.FieldByName('CODIGO').AsInteger <> liCfop)
        then begin
          dmImportacaoViaEfd.qryCfop.Close;
          dmImportacaoViaEfd.qryCfop.ParamByName('pCfop').AsInteger := liCfop;
          dmImportacaoViaEfd.qryCfop.Open;
          dmImportacaoViaEfd.qryCfop.Filtered := False;
          dmImportacaoViaEfd.qryCfop.Filter   := FsFiltroCfop;
          dmImportacaoViaEfd.qryCfop.Filtered := True;
        end;
        lsIdCfop := dmImportacaoViaEfd.qryCfop.FieldByName('ID_FCFOP').AsString;
        if (lsIdCfop = '') then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido.',True);
        end;
        liCfopOperacao   := dmImportacaoViaEfd.qryCfop.FieldByName('OPERACAO'  ).AsInteger;

        ldblVlOperacao   := 0;
        ldblBaseIcms     := 0;
        ldblValorIcms    := 0;
        ldblAliquotaICMS := 0;
        ldblValorRedBC   := 0;

        TryStrToCurr(StrToken(lsLinha,'|',6),ldblVlOperacao  );
        TryStrToCurr(StrToken(lsLinha,'|',7),ldblBaseIcms    );
        TryStrToCurr(StrToken(lsLinha,'|',5),ldblAliquotaICMS);
        TryStrToCurr(StrToken(lsLinha,'|',8),ldblValorIcms   );
        TryStrToCurr(StrToken(lsLinha,'|',9),ldblValorRedBC  );

        if (ldblAliquotaIcms < 0)
          or (ldblAliquotaIcms > 38)
        then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Alíquota do ICMS '+CurrToStr(ldblAliquotaIcms)+' inválida.',True);
        end;

        if (ldblBaseIcms = 0)
          and (Pos(lsCstIcms,'00*10*20') > 0)
        then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', para CST/ICMS '+lsCstIcms+', é necessário informar a base de cálculo do ICMS.',True);
        end else if (ldblBaseIcms <> 0)
          and (Pos(lsCstIcms,'00*10*20') = 0)
        then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', para CST/ICMS '+lsCstIcms+', não deve ser informada a base de cálculo do ICMS.',True);
        end;

        if (FoStrLstErros.Count = 0) then begin
          if lsEntradaSaida = '0' then begin {D190 - Entrada}
            if (edtLoteEntradas.Value > 0) then begin
              if (trim(lsIdDFE) = '') then begin
                MsgDlg.MsgError('aqui');
              end;

              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Insert;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ID_FDFE_ANALITICO'     ).AsString   := CreateClassID;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_DFE'                ).AsString   := lsIdDFE;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_PESSOA'             ).AsString   := TUtil.getIDPessoa;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_ICMS'              ).AsString   := lsCstIcms;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_IPI'               ).AsString   := '49';
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_PIS_COFINS'        ).AsString   := lsCstPisCofinsEntradas;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_CFOP'               ).AsString   := lsIdCfop;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_OPERACAO'        ).AsCurrency := ldblVlOperacao;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS'             ).AsCurrency := ldblBaseIcms;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_ICMS'         ).AsCurrency := ldblAliquotaICMS;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_ICMS'            ).AsCurrency := ldblValorIcms;
              if (liCfopOperacao = rInfoConstantes.iOprDevolucaoAnulacao) then begin
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_ST'          ).AsCurrency := 0;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_ICMS_ST'         ).AsCurrency := 0;
              end;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('REDUCAO_BASE_ICMS'     ).AsCurrency := ldblValorRedBC;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_IPI'              ).AsCurrency := 0;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_IPI'             ).AsCurrency := 0;
              if (lsCstPisCofinsEntradas = '50') then begin
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_PIS_COFINS').AsCurrency := ldblVlOperacao;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_PIS'   ).AsCurrency := rAliquotaOperacao.dblPis;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_COFINS').AsCurrency := rAliquotaOperacao.dblCofins;
              end else begin
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_PIS_COFINS').AsCurrency := 0;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_PIS'   ).AsCurrency := 0;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_COFINS').AsCurrency := 0;
              end;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('MVA').AsCurrency := 0;
              if (Copy(lsCFOP,1,2) = '2')
                and (liCfop = rInfoConstantes.iUtilComercializacao)
                or (liCfop = rInfoConstantes.iUtilImobilizado)
              then begin
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_AT_AP_DA'    ).AsCurrency := ldblVlOperacao;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CREDITO_ICMS_AT_AP_DA' ).AsCurrency := ldblValorIcms;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_ICMS_AT_AP_DA').AsCurrency := 17;
              end else begin
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_AT_AP_DA'    ).AsCurrency := 0;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CREDITO_ICMS_AT_AP_DA' ).AsCurrency := 0;
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_ICMS_AT_AP_DA').AsCurrency := 0;
              end;
              if (dmImportacaoViaEfd.qryCfop.FieldByName('OPERACAO').AsInteger = rInfoConstantes.iOprDevolucaoAnulacao) then begin
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_IR').AsCurrency := rAliquotaOperacao.dblIR;
              end else begin
                dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_IR').AsCurrency := 0;
              end;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('TIPO_CFOP').AsString   := '00';
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Post;
            end;
          end else begin {D190 - Saída}
            if (edtLoteSaidas.Value > 0) then begin
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Insert;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ID_FDFS_ANALITICO'     ).AsString   := CreateClassID;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('FK_DFS'                ).AsString   := lsIdDFS;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('FK_PESSOA'             ).AsString   := TUtil.getIDPessoa;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('CST_ICMS'              ).AsString   := Copy(StrToken(lsLinha,'|',3),2,2);
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('CST_IPI'               ).AsString   := '99';
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('CST_PIS_COFINS'        ).AsString   := '01';
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('FK_CFOP'               ).AsString   := lsIdCfop;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_OPERACAO'        ).AsCurrency := ldblVlOperacao;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_CALCULO'          ).AsCurrency := ldblBaseIcms;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA'              ).AsCurrency := ldblAliquotaICMS;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_ICMS'            ).AsCurrency := ldblValorIcms;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_ICMS_ST'          ).AsCurrency := 0;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_ICMS_ST'         ).AsCurrency := 0;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('REDUCAO_BASE_ICMS'     ).AsCurrency := ldblValorRedBC;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_IPI'              ).AsCurrency := 0;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_IPI'             ).AsCurrency := 0;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_PIS_COFINS'       ).AsCurrency := ldblVlOperacao;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA_PIS'          ).AsCurrency := rAliquotaOperacao.dblPis;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA_COFINS'       ).AsCurrency := rAliquotaOperacao.dblCofins;
              if (dmImportacaoViaEfd.qryCfop.FieldByName('OPERACAO').AsInteger = rInfoConstantes.iOprCompraAquisicaoVenda) then begin
                dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA_IR').AsCurrency := rAliquotaOperacao.dblIR;
              end else begin
                dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA_IR').AsCurrency := 0;
              end;
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('TIPO_CFOP').AsString   := '00';
              dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Post;
            end;
          end;
        end;
      end;
      inc(liNumeroLinha);
      lsRegistro := StrToken(FoStrLstEfd.Strings[liNumeroLinha],'|',2);
    end;
  end;
end;

procedure TFImportacaoViaEfd.ImportarRegistroD500(psLinha: String;
  piNumeroLinha: Integer);
var
  lsLinha,lsEntradaSaida,lsCodigoSituacao,lsSerie,lsModelo,lsIdModelo,
  lsCstPisCofins,lsCodTriIcm,lsCodTriIpi,lsInscMf,lsIdEstado,lsCfop,lsIdCfop,
  lsCodigoMunicipioParticipante,lsCstIcmsOriginal,lsCstIcms,lsRegistro,
  lsCodParticipante,lsIndicadorEmitente,lsIdDFE,lsIdDFS: string;
  ldDataEmissao,ldDataEntradaSaida: TDate;
  liNumeroLinha,liNumero,liLinha,liCfop,liCfopOperacao,liCodigoConsumo: Integer;
  ldblVlTotalD500,ldblVlOperacao,ldblBaseIcms,ldblValorIcms,
  ldblAliquotaICMS,ldblValorRedBC,ldblDesconto: Currency;

begin
  Application.ProcessMessages;

  lsRegistro          := StrToken(psLinha,'|',2);
  lsEntradaSaida      := StrToken(psLinha,'|',3);
  lsIndicadorEmitente := StrToken(psLinha,'|',4);
  lsCodParticipante   := StrToken(psLinha,'|',5);
  lsModelo            := StrToken(psLinha,'|',6);
  lsCodigoSituacao    := StrToken(psLinha,'|',7);

  if (Pos(lsCodigoSituacao,'00*01*02*03*04*05*06*07*08') = 0 ) then begin {Ver ValidaTabela AB}
    FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', conteúdo: '+lsCodigoSituacao+'. Código de situação do documento fiscal inválido.',True);
  end;
//  if Pos(lsCodigoSituacao,'00*01*06*07') > 0 then begin {Documento regular/Complementar - Ver Nota 1}
    ldDataEmissao      := StrSemBarrasToDate(StrToken(psLinha,'|',11));
    if (ldDataEmissao < rInfoAplicacao.dDataInicioPessoa) then begin
      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+' A data de emissão do documento fiscal não pode ser inferior a data que empresa iniciou o uso do MegaFiscal',True);
    end else if (rInfoAplicacao.dDataInicioParametros < TP_DATA_INICIAL)
      or (rInfoAplicacao.dDataInicioParametros > ldDataEmissao)
    then begin
      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha)+'-Não existem parâmetros cadastrados para a data de '+DateToStr(ldDataEmissao)+'.',True);
    end;
    ldDataEntradaSaida := StrSemBarrasToDate(StrToken(psLinha,'|',12));
    if (dmImportacaoViaEfd.qryDFModelo.Locate('CODIGO',lsModelo,[])) then begin
      lsIdModelo := dmImportacaoViaEfd.qryDFModelo.FieldByName('ID_FDF_MODELO').AsString;
    end else begin
      lsIdModelo := '';
    end;
    lsSerie         := StrToken(psLinha,'|',8);
    liNumero        := StrToInt(StrToken(psLinha,'|',10));
    if (liNumero <= 0) then begin
      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', Documento fiscal com número inválido.',True);
    end;
    if (lsSerie = '') or (Length(lsSerie) > 3) then begin
//      FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', documento fiscal Nº '+IntToStr(liNumero)+', com a série '+lsSerie+' inválida. Foi substituida pela série 1.',True);
      lsSerie := '1';
    end;

    {O ldblVlTotalD500 é total do DF menos descontos}
    ldblVlTotalD500 := 0;
    TryStrToCurr(StrToken(psLinha,'|',13),ldblVlTotalD500);
    ldblDesconto := 0;
    TryStrToCurr(StrToken(psLinha,'|',14),ldblDesconto);;
    ldblVlTotalD500 := ldblVlTotalD500-ldblDesconto;

    if lsEntradaSaida = '0' then begin {Entrada}
      if (edtLoteEntradas.Value > 0) then begin
        if (dmImportacaoViaEfd.cdsParticipanteTemp.Locate('COD_PART',lsCodParticipante,[])) then begin
//          FdblTotalLoteEntradas := FdblTotalLoteEntradas+ldblVlTotalD500;
          dmImportacaoViaEfd.qryVerificaDFE.Close;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pIdPessoa'      ).AsString  := TUtil.getIDPessoa;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pIdDFModelo'    ).AsString  := lsIdModelo;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pSerie'         ).AsString  := lsSerie;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pNumero'        ).AsInteger := liNumero;
          dmImportacaoViaEfd.qryVerificaDFE.ParamByName('pIdParticipante').AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
          dmImportacaoViaEfd.qryVerificaDFE.Open;

          if (not dmImportacaoViaEfd.qryVerificaDFE.IsEmpty) then begin
            FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', Documento fiscal '+IntToStr(liNumero)+' lançado em '+dmImportacaoViaEfd.qryVerificaDFE.FieldByName('DATA_ENTRADA').AsString+', no lote de entradas '+IntToStr(dmImportacaoViaEfd.qryVerificaDFE.FieldByName('NUMERO').AsInteger)+', Linha '+IntToStr(dmImportacaoViaEfd.qryVerificaDFE.FieldByName('LINHA').AsInteger)+'.',True);
          end; 

          lsIdDFE := CreateClassID;
          dmImportacaoViaEfd.cdsDFETemp.Insert;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('ID_FDFE'           ).AsString   := lsIdDFE;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_PESSOA'         ).AsString   := TUtil.getIDPessoa;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_LOTE'           ).AsString   := FsIdLoteDFE;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('LINHA'             ).AsInteger  := FiLinhaDFE;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('INDICADOR_EMITENTE').AsString   := lsIndicadorEmitente;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_PARTICIPANTE'   ).AsString   := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('FK_DF_MODELO'      ).AsString   := lsIdModelo;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('CODIGO_SITUACAO'   ).AsString   := lsCodigoSituacao;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('SERIE'             ).AsString   := lsSerie;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('NUMERO'            ).AsInteger  := liNumero;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('CHAVE_NFE'         ).AsString   := '';
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('DATA_EMISSAO'      ).AsDateTime := ldDataEmissao;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('DATA_ENTRADA'      ).AsDateTime := ldDataEntradaSaida;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('VALOR'             ).AsCurrency := ldblVlTotalD500;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('INDICADOR_PGTO'    ).AsInteger  := 0;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('INDICADOR_FRETE'   ).AsInteger  := 3;
          dmImportacaoViaEfd.cdsDFETemp.FieldByName('ART_377_RICMS'     ).AsInteger  := 0;
          dmImportacaoViaEfd.cdsDFETemp.Post;
          Inc(FiLinhaDFE);
        end;
      end;
    end else begin  {Saída}
//      if (edtLoteSaidas.Value > 0) then begin
//        if (dmImportacaoViaEfd.cdsParticipanteTemp.Locate('COD_PART',lsCodParticipante,[])) then begin
//          FdblTotalLoteSaidas := FdblTotalLoteSaidas+ldblVlTotalD500;
//          lsCodigoMunicipioParticipante := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('COD_MUN').AsString;
////          ldData   := ldDataEmissao;
//          dmImportacaoViaEfd.qryVerificaDFS.Close;
//          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pIdPessoa'      ).AsString  := TUtil.getIDPessoa;
//          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pIdDFModelo'    ).AsString  := lsIdModelo;
//          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pSerie'         ).AsString  := lsSerie;
//          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pNumero'        ).AsInteger := liNumero;
//          dmImportacaoViaEfd.qryVerificaDFS.ParamByName('pIdParticipante').AsString  := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
//          dmImportacaoViaEfd.qryVerificaDFS.Open;
//
//          if (not dmImportacaoViaEfd.qryVerificaDFS.IsEmpty) then begin
//            FoStrLstInconsistencias.Add('Registro C100, linha: '+IntToStr(piNumeroLinha)+', Documento fiscal '+IntToStr(liNumero)+' lançado em '+dmImportacaoViaEfd.qryVerificaDFS.FieldByName('DATA_EMISSAO').AsString+', no lote de saídas '+IntToStr(dmImportacaoViaEfd.qryVerificaDFS.FieldByName('NUMERO').AsInteger)+', Linha '+IntToStr(dmImportacaoViaEfd.qryVerificaDFS.FieldByName('LINHA').AsInteger)+'.',True);
//          end else begin
//            if (not dmImportacaoViaEfd.qryCidadeEstado.Active)
//              or (dmImportacaoViaEfd.qryCidadeEstado.FieldByName('CODIGO_IBGE').AsString <> lsCodigoMunicipioParticipante)
//            then begin
//              dmImportacaoViaEfd.qryCidadeEstado.Close;
//              dmImportacaoViaEfd.qryCidadeEstado.ParamByName('pCodigoMunicipio').AsString := lsCodigoMunicipioParticipante;
//              dmImportacaoViaEfd.qryCidadeEstado.Open;
//            end;
//            lsIdEstado := dmImportacaoViaEfd.qryCidadeEstado.FieldByName('ID_ESTADOS').AsString;
//
//            lsIdDFS := CreateClassID;
//            dmImportacaoViaEfd.cdsDFSTemp.Insert;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('ID_FDFS'           ).AsString   := lsIdDFS;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_PESSOA'         ).AsString   := TUtil.getIDPessoa;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_LOTE'           ).AsString   := FsIdLoteDFS;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('LINHA'             ).AsInteger  := FiLinhaDFS;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('INDICADOR_EMITENTE').AsString   := lsIndicadorEmitente;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_PARTICIPANTE'   ).AsString   := dmImportacaoViaEfd.cdsParticipanteTemp.FieldByName('ID_FPARTICIPANTE').AsString;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_ESTADO'         ).AsString   := lsIdEstado;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('FK_DF_MODELO'      ).AsString   := lsIdModelo;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('CODIGO_SITUACAO'   ).AsString   := lsCodigoSituacao;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('SERIE'             ).AsString   := lsSerie;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('NUMERO'            ).AsInteger  := liNumero;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('CHAVE_NFE'         ).AsString   := StrToken(psLinha,'|',9);
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('DATA_EMISSAO'      ).AsDateTime := ldDataEmissao;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('DATA_SAIDA'        ).AsDateTime := ldDataEntradaSaida;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('VALOR'             ).AsCurrency := ldblVlTotalC100;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('INDICADOR_PGTO'    ).AsInteger  := StrToInt(StrToken(psLinha,'|',13));
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('INDICADOR_FRETE'   ).AsInteger  := ;
//            dmImportacaoViaEfd.cdsDFSTemp.FieldByName('ART_377_RICMS'     ).AsInteger  := 0;
//            dmImportacaoViaEfd.cdsDFSTemp.Post;
//            Inc(FiLinhaDFS);
//          end;
//        end;
//      end;
    end;
    if (lsModelo = '') then begin
      FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(piNumeroLinha+1)+', conteúdo: '+lsModelo+'. Modelo do documento fiscal inválido.',True);
    end;

    liNumeroLinha := piNumeroLinha+1;
    lsRegistro := StrToken(FoStrLstEfd.Strings[liNumeroLinha],'|',2);
    while (liNumeroLinha < FoStrLstEfd.Count-1) and (Copy(lsRegistro,1,2) = 'D5') and (lsRegistro <> 'D500') do begin
      lblProgresso.Caption := 'Importando Registro: '+lsRegistro+'  '+IntToStr(liNumeroLinha);
      NGauge.Progress := liNumeroLinha;
      Application.ProcessMessages;

      lsLinha := FoStrLstEfd.Strings[liNumeroLinha];
      if (lsRegistro = 'D590') then begin
        lsCstIcmsOriginal := Copy(StrToken(lsLinha,'|',3),2,2);
        lsCstIcms         := lsCstIcmsOriginal;
        if (Pos(lsCstIcms,'00*10*20*30*40*41*50*51*60**70*90') = 0) then begin
          lsCstIcms := '90';
          FoStrLstAvisos.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CST ICMS '+lsCstIcmsOriginal+', inválido. Susbtituido pelo CST ICMS 90.',True);
        end;

        ldblVlOperacao   := 0;
        ldblBaseIcms     := 0;
        ldblValorIcms    := 0;
        ldblAliquotaICMS := 0;
        ldblValorRedBC   := 0;

        TryStrToCurr(StrToken(lsLinha,'|',06),ldblVlOperacao  );
        TryStrToCurr(StrToken(lsLinha,'|',07),ldblBaseIcms    );
        TryStrToCurr(StrToken(lsLinha,'|',05),ldblAliquotaICMS);
        TryStrToCurr(StrToken(lsLinha,'|',08),ldblValorIcms   );
        TryStrToCurr(StrToken(lsLinha,'|',11),ldblValorRedBC  );

        lsCfop := StrToken(lsLinha,'|',4);
        liCfop := StrToInt(lsCfop);
        if (not dmImportacaoViaEfd.qryCfop.Active)
          or (dmImportacaoViaEfd.qryCfop.Eof)
          or (dmImportacaoViaEfd.qryCfop.FieldByName('CODIGO').AsString <> lsCfop)
        then begin
          dmImportacaoViaEfd.qryCfop.Close;
          dmImportacaoViaEfd.qryCfop.ParamByName('pCfop').AsInteger := liCfop;
          dmImportacaoViaEfd.qryCfop.Open;
          dmImportacaoViaEfd.qryCfop.Filtered := False;
          dmImportacaoViaEfd.qryCfop.Filter   := FsFiltroCfop;
          dmImportacaoViaEfd.qryCfop.Filtered := True;
        end;
        lsIdCfop := dmImportacaoViaEfd.qryCfop.FieldByName('ID_FCFOP').AsString;
        if (lsIdCfop = '') then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', CFOP '+lsCfop+', inválido.',True);
        end;
        liCfopOperacao   := dmImportacaoViaEfd.qryCfop.FieldByName('OPERACAO'  ).AsInteger;

        if (ldblAliquotaIcms < 0)
          or (ldblAliquotaIcms > 38)
        then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', Alíquota do ICMS '+CurrToStr(ldblAliquotaIcms)+' inválida.',True);
        end;

        if (ldblBaseIcms = 0)
          and (Pos(lsCstIcms,'00*10*20') > 0)
        then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', para CST/ICMS '+lsCstIcms+', é necessário informar a base de cálculo do ICMS.',True);
        end else if (ldblBaseIcms <> 0)
          and (Pos(lsCstIcms,'00*10*20') = 0)
        then begin
          FoStrLstErros.Add('Registro '+lsRegistro+', linha: '+IntToStr(liNumeroLinha+1)+', para CST/ICMS '+lsCstIcms+', não deve ser informada a base de cálculo do ICMS.',True);
        end;

        if lsEntradaSaida = '0' then begin {C590 - Entrada}
          if (edtLoteEntradas.Value > 0) then begin
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Insert;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ID_FDFE_ANALITICO'     ).AsString   := CreateClassID;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_DFE'                ).AsString   := lsIdDFE;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_PESSOA'             ).AsString   := TUtil.getIDPessoa;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_ICMS'              ).AsString   := lsCstIcms;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_IPI'               ).AsString   := '49';
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CST_PIS_COFINS'        ).AsString   := '98';
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('FK_CFOP'               ).AsString   := lsIdCfop;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_OPERACAO'        ).AsCurrency := ldblVlOperacao;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS'             ).AsCurrency := ldblBaseIcms;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_ICMS'         ).AsCurrency := ldblAliquotaICMS;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_ICMS'            ).AsCurrency := ldblValorIcms;
            if (liCfopOperacao = rInfoConstantes.iOprDevolucaoAnulacao) then begin
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_ST'          ).AsCurrency := 0;
              dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_ICMS_ST'         ).AsCurrency := 0;
            end;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('REDUCAO_BASE_ICMS'     ).AsCurrency := ldblValorRedBC;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_IPI'              ).AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('VALOR_IPI'             ).AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_PIS_COFINS'       ).AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_PIS'          ).AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_COFINS'       ).AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('BASE_ICMS_AT_AP_DA'    ).AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('CREDITO_ICMS_AT_AP_DA' ).AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_ICMS_AT_AP_DA').AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('MVA'                   ).AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('ALIQUOTA_IR'           ).AsCurrency := 0;
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.FieldByName('TIPO_CFOP'             ).AsString   := '00';
            dmImportacaoViaEfd.cdsDFEAnaliticoTemp.Post;
          end;
        end else begin {C170 - Saída}
//          if (edtLoteSaidas.Value > 0) then begin
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Insert;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ID_FDFS_ANALITICO'     ).AsString   := CreateClassID;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('FK_DFE'                ).AsString   := lsIdDFE;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('FK_PESSOA'             ).AsString   := TUtil.getIDPessoa;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('CST_ICMS'              ).AsString   := StrToken(lsLinha,'|',10);
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('CST_IPI'               ).AsString   := StrToken(lsLinha,'|',20);
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('CST_PIS_COFINS'        ).AsString   := StrToken(lsLinha,'|',25);
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('FK_CFOP'               ).AsString   := lsIdCfop;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_OPERACAO'        ).AsCurrency := 0;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_CALCULO'          ).AsCurrency := StrToCurr(StrToken(psLinha,'|',13));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA'              ).AsCurrency := StrToCurr(StrToken(psLinha,'|',14));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_ICMS'            ).AsCurrency := StrToCurr(StrToken(psLinha,'|',15));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_ICMS_ST'          ).AsCurrency := StrToCurr(StrToken(psLinha,'|',16));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_ICMS_ST'         ).AsCurrency := StrToCurr(StrToken(psLinha,'|',18));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('REDUCAO_BASE_ICMS'     ).AsCurrency := 0;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_IPI'              ).AsCurrency := StrToCurr(StrToken(psLinha,'|',22));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('VALOR_IPI'             ).AsCurrency := StrToCurr(StrToken(psLinha,'|',24));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('BASE_PIS_COFINS'       ).AsCurrency := StrToCurr(StrToken(psLinha,'|',26));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA_PIS'          ).AsCurrency := StrToCurr(StrToken(psLinha,'|',27));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA_COFINS'       ).AsCurrency := StrToCurr(StrToken(psLinha,'|',33));
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.FieldByName('ALIQUOTA_IR'           ).AsCurrency := rAliquotaOperacao.dblIR;
//            dmImportacaoViaEfd.cdsDFSAnaliticoTemp.Post;
//          end;
        end;
      end;
      inc(liNumeroLinha);
      lsRegistro := StrToken(FoStrLstEfd.Strings[liNumeroLinha],'|',2);
    end;
//  end;
end;

function TFImportacaoViaEfd.LocalizaAliquotaInProdutos(
  psCodigoProduto: String; pdData: TDate): Currency;
var
  liFor: Integer;
  lsCodigoProdutoReg0200: string;
begin
  Result := 0;
  for liFor := 0 to FoStrLstProdutos.Count-1 do begin
    lsCodigoProdutoReg0200 := StrToken(FoStrLstProdutos.Strings[liFor],'|',3);
    if (psCodigoProduto = lsCodigoProdutoReg0200) then begin
      TryStrToCurr(StrToken(FoStrLstProdutos.Strings[liFor],'|',13),Result);
      Break;
    end;
  end;
  if (Result = 0) then begin
    Result := TFUtil.getAliquotaInternaIcms(TUtil.getIDPessoa,pdData);
  end;
end;

end.

{Nota 1:
 CFOP 5.929/6.929 - Lançamento efetuado em decorrência de emissão
 de documento fiscal relativo a operação ou prestação também
 registrada em equipamento Emissor de Cupom Fiscal - ECF.
 Os programas geradores da EFD estão informando, na maioria das
 vezes, zero no campo 05-VL_OPR. Nessa situação, é atribuido
 ldblVlTotalC100 a ldblVlOperacao, caso ele seja maior que zero.
 Se ldblVlTotalC100 também for zero, o registro será gravado com
 valor zero mesmo.}

