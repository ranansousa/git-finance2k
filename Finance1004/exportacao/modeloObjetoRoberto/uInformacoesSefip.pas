unit uInformacoesSefip;

interface

uses
  classes, sysutils, SqlExpr, DB, Controls, LibMega, StdCtrls, Forms,
  EGauge, uPConsts, Util, Provider, DBClient, CheckDoc, Constants,
  uMostraErros, uFuncoesMegaPessoal, Variants, dialogs, ELibFnc, uVarGlobais,
  uEnumeratoresMegaPessoal, udmInformacoesSefip, uDecoratorEnumAttribute;

type
  TGfip = class;

  TEmpresa = class;

  TColaborador = class(TObject)
  private
    FOwner: TEmpresa;
    FoCdsColaboradores: TClientDataSet;
//    FIdColaborador: String;
    FsIdsColaboradores: String;
    FiMatriculaESocial: Integer;
    FeTipoColaborador: TTipoColaborador;
    FsDescricaoTipoColaborador: String;
    FIdTomador: String;
    FTipoInscMfTomador: String;
    FInscMfTomador: String;
    FDataInicioTomador: TDate;
    FDataFimTomador: TDate;
    FPisInscInss: String;
    FDataAdmissao: TDate;
    FDataSaida: TDateTime;
    FCategoria: Integer;
    FNome: String;
//    FMatricula: String;
    FCTPS: String;
    FSerieCTPS: String;
    FDataOpcao: TDate;
    FDataNascimento: TDate;
    FCbo: String;
    FRemuneracao: Currency;
    FRemuneracao13: Currency;
    FBase13Rescisao: Currency;
    FBase13Movimento: Currency; {Registro 30, Campo 22}
    FBase13Gps13: Currency;     {Registro 30, Campo 23}

    FOcorrencia: Integer;
//    FVlAdto13: Currency;
    FRemuneracaoOutrasEmpresas: Currency;
    FDescontoPrevSoc: Currency;
    FDescontoPrevSoc13Rescisao: Currency;
    FDescontoPrevSoc13Diferenca: Currency;
    FBasePrevSocAcidente: Currency;
    FVlDiferenca13: Currency;
    FCodigoMovimentacao: String;

    procedure getLinhas30();
    procedure getLinhas32(var psCodigoMovimentacaoFgts: string;
      var pdDataInicioAfastamento, pdDataFimAfastamento,
      pdDataInicioBeneficio: TDate);
    function getMaternidade(): Boolean;
  public
//    constructor Create(lOwner: TEmpresa; lsIdColaborador: String;
    constructor Create(lOwner: TEmpresa;
      var NGaugeColaborador: TEvGauge; var lblColaborador: TLabel;
      loCdsColaboradores: TClientDataSet);
    destructor Destroy; override;
  end;

  TEmpresa = class(TObject)
  private
    FOwner: TGfip;
    FIdPessoa: String;
    FTipoInscMf: String;
    FInscMf: String;
    FNome: String;
    FRegimeFederal: Integer;
    FCodigoGps: String;
    FoQryGps: TSQLQuery;
    FListaColaboradores: TList;
    FReceitaEventoDesportivo: Currency;
    FOrigemReceitaEventoDesportivo: String;
    FComProducaoPessoaFisica: Currency;
    FComProducaoPessoaJuridica: Currency;

    procedure PreencheListaColaboradores(lsIdPessoa: String;
      var NGaugeColaborador: TEvGauge; var lblColaborador: TLabel;
      poCdsColaboradores: TClientDataSet);
    procedure getLinhas20();
    function getSalarioFamiliaPago(): Currency;Overload;
    function getSalarioFamiliaPago(psIdTomador: String): Currency;Overload;
    function getMaternidadePago(): Currency;
    function get13MaternidadePago(): Currency;
    function getDadosCompensacao(psInscMfTomador: String): String;
    function getRecCompetenciasAnteriores(psInscMfTomador: String): String;
    function getValoresPagosCooperativas(): Currency;
  public
    constructor Create(pOwner: TGfip; psInscMfPessoa: String;
      var pNGaugeColaborador: TEvGauge; var plblColaborador: TLabel);
    destructor Destroy; override;
  end;

  TGfip = class(TObject)
  private
    FTipoInscMfResponsavel: String;
    FInscMfResponsavel: String;
    FNomeResponsavel: String;
    FPessoaContatoResponsavel: String;
    FBairroResponsavel: String;
    FCepResponsavel: String;
    FCidadeResponsavel: String;
    FUfResponsavel: String;
    FTelefoneResponsavel: String;
    FEmailResponsavel: String;
    FEnderecoResponsavel: String;
    FPath: String;
    FoCdsSefip10: TClientDataSet;
    FoCdsSefip20: TClientDataSet;
    FoCdsSefip30: TClientDataSet;
//    FoCdsSefip30Clone: TClientDataSet;
    FoCdsSefip32: TClientDataSet;
    {Lista contendo a INSCMF de todas as empresas que deseja
     gerar o arquivo para a SEFIP}
    FListaEmpresas: TList;
    FCompetencia: TDate;
    FCompetencia13: Boolean;
    {Indicador de recolhimento do FGTS = 1 (GRF no prazo), 2 (GRF em atraso),
     3 (GRF em atraso – Ação Fiscal), 5 (Individualização)
     6 (Individualização – Ação Fiscal) ou branco. Não pode ser informado na
     competência 13.}
    FIndicadorRecFgts: SmallInt;
    {Indicador de recolhimento do INSS = 1 (no prazo), 2 (em atraso) ou
     3 (não gera GPS). Deve ser igual a 3, para competência anterior a 10/1998 e
     para os códigos de recolhimento exclusivos do FGTS (145, 307, 317, 327,
     337, 345, 640 e 660).}
    FIndicadorRecPrevSoc: SmallInt;
    {Data de recolhimento do FGTS. Deve ser informada sempre que o recolhimento
     for realizado em atraso (Indicador 2 e 3) e no caso de individualização
     (Indicador 5 e 6)). Não pode ser informado quando o indicador de
     recolhimento do FGTS for igual a 1 (GRF no prazo). Sempre que não informado
     o campo deve ficar em branco.}
    FDataRecFgts: TDate;
    {Data de recolhimento do Previdência Social. Só pode ser informado se
     Indicador de Recolhimento Previdência Social for igual a 2-Em atraso, e a
     data informada for posterior ao dia 10 do mês seguinte ao da competência.}
    FDataRecPrevSoc: TDate;
    {FObraPropria guarda a informação se o arquivo a ser gerado para o SEFIP é
     com o código de recolhimento 155 - Empreitada Total ou Obra própria.}
    FObraPropria: Boolean;
    FInconsistencias: TStringList;
    FTemTomador: Boolean;
    FCodigoRecolhimentoGfip: String;
    FGfipComFuncionarios: Boolean;
    FExcluiPisZero: Boolean;
    FeTipoRecolhimentoSefip: TTipoRecolhimentoSefip;
    FdDataInicial: TDate;
    FdDataFinal: TDate;
    FsProcesso: string;
    FsVara: string;

    Procedure PreencheListaEmpresas(lStrInscMfEmpresas: TStringList;
      var NGaugeEmpresa,NGaugeColaborador: TEvGauge;
      var lblEmpresa,lblColaborador: TLabel);
    procedure CriaDataSets;
  public
    constructor Create(psIdEmpresaResponsavel,psPath,psProcesso,psVara: String;
      poStrInscMfEmpresas: TStringList; pdCompetencia,pdDataRecFgts,
      pdDataRecPrevSoc: TDate; piIndicadorRecFgts,
      piIndicadorRecPrevSoc: SmallInt; pbCompetencia13: Boolean;
      var poNGaugeEmpresa,poNGaugeColaborador: TEvGauge;
      var polblEmpresa,polblColaborador: TLabel; pbObraPropria,pbExcluiPisZero: Boolean;
      peTipoRecolhimento: TTipoRecolhimentoSefip; pdDataInicial,pDataFinal: TDate);
    destructor Destroy; override;

    procedure GeraArquivoSefip();

    property Inconsistencias: TStringList read FInconsistencias;
  end;

implementation

{ TColaborador }

//constructor TColaborador.Create(lOwner: TEmpresa; lsIdColaborador: String;
constructor TColaborador.Create(lOwner: TEmpresa;
  var NGaugeColaborador: TEvGauge; var lblColaborador: TLabel;
  loCdsColaboradores: TClientDataSet);
var
  CheckDoc: TCheckDoc;
  loQryDiasMaternidade: TSQLQuery;
  liQtdeDiasMaternidadeAno,liQtdeDiasMaternidadeAnoAdocao,liPos: SmallInt;
  lsIds,lsDatasSaida,lsDataSaida: string;
begin
  loQryDiasMaternidade := TSQLQuery.Create(nil);
  CheckDoc             := TCheckDoc.Create(nil);
  try
    FOwner                     := lOwner;
    FoCdsColaboradores         := loCdsColaboradores;
    FeTipoColaborador          := TTipoColaborador(loCdsColaboradores.FieldByName('R_TIPO_COLABORADOR').AsInteger);
    FiMatriculaESocial         := loCdsColaboradores.FieldByName('R_MATRICULA_E_SOCIAL').AsInteger;

    FsDescricaoTipoColaborador := TUtilEnumerator<TTipoColaborador>.GetAtributoEnum(FeTipoColaborador,TAtributoEnum.taNomeCompleto);

    if (FeTipoColaborador = TTipoColaborador.tc_funcionario) then begin
//      FsDescricaoTipoColaborador := TP_DESC_COLABORADOR_FUNCIONARIO;
      lOwner.FOwner.FGfipComFuncionarios := True;
//    end else if FeTipoColaborador = TP_COLABORADOR_SOCIO then begin
//      FsDescricaoTipoColaborador := TP_DESC_COLABORADOR_SOCIO;
//    end else if FeTipoColaborador = TP_COLABORADOR_AUTONOMO then begin
//      FsDescricaoTipoColaborador := TP_DESC_COLABORADOR_AUTONOMO;
//    end else if FeTipoColaborador = TP_COLABORADOR_TRANSPORTADOR then begin
//      FsDescricaoTipoColaborador := TP_DESC_COLABORADOR_TRANSPORTADOR;
    end;
    if (lOwner.FOwner.FeTipoRecolhimentoSefip <> TTipoRecolhimentoSefip.trs_somente_diferencas_650) then begin
      FIdTomador                  := loCdsColaboradores.FieldByName('R_ID_TOMADOR').AsString;
      FInscMfTomador              := loCdsColaboradores.FieldByName('R_INSCMF_TOMADOR').AsString;
      FDataInicioTomador          := loCdsColaboradores.FieldByName('R_DATA_INICIAL_TOMADOR').AsDateTime;
      FDataFimTomador             := loCdsColaboradores.FieldByName('R_DATA_FINAL_TOMADOR').AsDateTime;
    end else begin
      FIdTomador                  := '';
      FInscMfTomador              := '';
    end;
    FPisInscInss  := loCdsColaboradores.FieldByName('R_PIS_INSS'      ).AsString;
    FDataAdmissao := loCdsColaboradores.FieldByName('R_DATA_ADMISSAO' ).AsDateTime;
    FDataOpcao    := loCdsColaboradores.FieldByName('R_DATA_OPCAO'    ).AsDateTime;
    FCategoria    := loCdsColaboradores.FieldByName('R_CATEGORIA_FGTS').AsInteger;
    lsDatasSaida  := loCdsColaboradores.FieldByName('R_DATA_SAIDA'    ).AsString;

    for liPos := 1 to StrTokenCount(lsDatasSaida,',') do begin
      if (fSoNumeros(StrToken(lsDatasSaida,',',liPos)) <> '') then begin
        lsDataSaida := StrToken(lsDatasSaida,',',liPos);
        lsDataSaida := Copy(lsDataSaida,9,2)+'/'+Copy(lsDataSaida,6,2)+'/'+Copy(lsDataSaida,1,4);
        TryStrToDate(lsDataSaida,FDataSaida);
        Break;
      end;
    end;

    FNome                       := StrLPad(trim(copy(loCdsColaboradores.FieldByName('R_NOME').AsString,1,70)),70);
//    FMatricula                  := loCdsColaboradores.FieldByName('R_MATRICULA').AsString;
    FCTPS                       := fSoNumeros(loCdsColaboradores.FieldByName('R_CTPS').AsString);
    if FCategoria in ([1,2,3,4,6,7,26]) then begin
      if Length(FCTPS) > 7 then begin
        {Já existe CTPS com 8 números/ Porém a SEFIP e Seguro desemprego só aceitam
        7. Nesse caso, fomos orientados pelo suporte da CEF a desconsiderar o
        primeiro dígito. Quando a CEF e o Ministério do Trabalho se entenderem,
        corrigir esse problema na SP_PSEGURO_DESEMPREGO e em uInformacoesSefip.pas}
        FCTPS := Copy(FCTPS,2,7);
      end else if Length(FCTPS) > 0 then begin
        FCTPS := Copy(StrZero(StrToInt(fSoNumeros(FCTPS)),7,0),1,7);
      end else begin
//        Self.FOwner.FOwner.FInconsistencias.Append('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' '+FMatricula+'-'+trim(FNome)+'. Motivo: Falta série da CTPS no cadastro do colaborador.');
        Self.FOwner.FOwner.FInconsistencias.Append('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+'-'+trim(FNome)+'. Motivo: Falta série da CTPS no cadastro do colaborador.');
      end;
      FSerieCTPS := loCdsColaboradores.FieldByName('R_SERIE_CTPS').AsString;
    end else begin
      FCTPS      := '';
      FSerieCTPS := '';
    end;
    FDataNascimento             := loCdsColaboradores.FieldByName('R_DATA_NASCIMENTO').AsDateTime;
    FCbo                        := StrToken(loCdsColaboradores.FieldByName('R_CBO').AsString,',',1);
    FRemuneracao                := IIF(loCdsColaboradores.FieldByName('R_REMUNERACAO').AsCurrency > 0,loCdsColaboradores.FieldByName('R_REMUNERACAO').AsCurrency,0);
    FRemuneracao13              := IIF(loCdsColaboradores.FieldByName('R_REMUNERACAO13').AsCurrency > 0,loCdsColaboradores.FieldByName('R_REMUNERACAO13').AsCurrency,0);
    if ((FRemuneracao+FRemuneracao13) = 0) then begin
      FRemuneracao := 0.01;
    end;
    FBase13Movimento            := loCdsColaboradores.FieldByName('R_13_MOVIMENTO').AsCurrency;
    FBase13Gps13                := loCdsColaboradores.FieldByName('R_13_GPS13').AsCurrency;
    FBase13Rescisao             := loCdsColaboradores.FieldByName('R_13_RESCISAO').AsCurrency;

    FsIdsColaboradores := Self.FoCdsColaboradores.FieldByName('R_IDS').AsString;
//    FsIdsColaboradores := Copy(FsIdsColaboradores,2,length(FsIdsColaboradores)-2);

//    FsIdsColaboradores := QuotedStr(StrToken(lsIds,',',1));
//    for liPos := 2 to StrTokenCount(lsIds,',') do begin
//      FsIdsColaboradores := FsIdsColaboradores+','+QuotedStr(StrToken(lsIds,',',1));
//    end;

    if (Self.FOwner.FOwner.FCompetencia13)
//      and (loCdsColaboradores.FieldByName('R_SEXO').AsInteger = TP_SEXO_FEMININO)
    then begin
      liQtdeDiasMaternidadeAno       := 0;
      liQtdeDiasMaternidadeAnoAdocao := 0;
      loQryDiasMaternidade.SQLConnection := TUtil.getConn;
      loQryDiasMaternidade.SQL.Add('SELECT R_DIAS_MATERNIDADE_ANO,R_DIAS_MATERNIDADE_ANO_ADOCAO FROM SP_PDIASTRAB(:pDataInicial,:pDataFinal,:pIdFuncionario)');

      for liPos := 2 to StrTokenCount(lsIds,',') do begin
        loQryDiasMaternidade.Close;
        loQryDiasMaternidade.ParamByName('pDataInicial'  ).AsDate   := BeginOfMOnth(Self.FOwner.FOwner.FCompetencia);
        loQryDiasMaternidade.ParamByName('pDataFinal'    ).AsDate   := EndOfMonth(Self.FOwner.FOwner.FCompetencia);
        loQryDiasMaternidade.ParamByName('pIdFuncionario').AsString := StrToken(lsIds,',',liPos);
        loQryDiasMaternidade.Open;

        liQtdeDiasMaternidadeAno       := liQtdeDiasMaternidadeAno+loQryDiasMaternidade.FieldByName('R_DIAS_MATERNIDADE_ANO'       ).AsInteger;
        liQtdeDiasMaternidadeAnoAdocao := liQtdeDiasMaternidadeAno+loQryDiasMaternidade.FieldByName('R_DIAS_MATERNIDADE_ANO_ADOCAO').AsInteger;
      end;

      if (liQtdeDiasMaternidadeAnoAdocao > 0)
        or ((Self.FOwner.FRegimeFederal = TP_REGIME_FEDERAL_MEI)
        and (liQtdeDiasMaternidadeAno > 0))
      then begin
        FOcorrencia := 5;
      end else begin
        FOcorrencia := loCdsColaboradores.FieldByName('R_OCORRENCIA').AsInteger;
      end;
    end else begin
      if (FeTipoColaborador <> TTipoColaborador.tc_mei) then begin
        FOcorrencia := loCdsColaboradores.FieldByName('R_OCORRENCIA').AsInteger;
      end else begin
        FOcorrencia := 5;
      end;
    end;
    FRemuneracaoOutrasEmpresas  := loCdsColaboradores.FieldByName('R_REMUNERACAO_OUTRAS_EMPRESAS').AsCurrency;
    FDescontoPrevSoc            := loCdsColaboradores.FieldByName('R_DESCONTO_PREVIDENCIA'       ).AsCurrency;
    FDescontoPrevSoc13Rescisao  := loCdsColaboradores.FieldByName('R_INSS_13_RESCISAO'           ).AsCurrency;
    FDescontoPrevSoc13Diferenca := loCdsColaboradores.FieldByName('R_INSS_13_SALARIO_DIFERENCA'  ).AsCurrency;
    FBasePrevSocAcidente        := loCdsColaboradores.FieldByName('R_BASE_PREVIDENCIA_ACIDENTE'  ).AsCurrency;
    FVlDiferenca13              := loCdsColaboradores.FieldByName('R_13_DIFERENCA'               ).AsCurrency;
    FCodigoMovimentacao         := loCdsColaboradores.FieldByName('R_CODIGO_MOVIMENTACAO'        ).AsString;
    if fSoNumeros(FInscMfTomador) <> '' then begin
      CheckDoc.Mode := moAutoDetect;
      CheckDoc.Input := FInscMfTomador;
      if CheckDoc.ModeResult = moCGC then begin
        FTipoInscMfTomador := '1';
      end else if CheckDoc.ModeResult = moCEI then begin
        FTipoInscMfTomador := '2';
      end else if CheckDoc.ModeResult = moCPF then begin
        FTipoInscMfTomador := '3';
        lOwner.FOwner.FInconsistencias.Add('Tomador CPF: '+FInscMfTomador+'. Motivo: Tomador não pode ser inscrito no CPF.');
        lOwner.FOwner.FInconsistencias.Add(' ');
      end;
    end else begin
      FTipoInscMfTomador := ' ';
    end;
    getLinhas30();
  finally
    FreeAndNil(CheckDoc);
    FreeAndNil(loQryDiasMaternidade);
  end;
end;

destructor TColaborador.Destroy;
begin
  inherited;
end;

procedure TColaborador.getLinhas30;
var
  loQryMaternidadeAdocao: TSQLQuery;
  lsLinha,lsLinhaAnterior,lsCodigoMovimentacaoFgts,lsTipoInscMfEmpresa,
  lsInscMfEmpresa,lsTipoInscMfTomador,lsInscMfTomador,lsPis,lsCategoria: string;
  ldDataAdmissao: TDate;
  liIncDataAdmissao: SmallInt;
  ldblBase13PrevSocial,ldblBasePrevComp13: Currency;
  lbDesligado,lbMaternidadeAdocao: Boolean;
  liPis: Int64;
  ldDataInicioAfastamento,ldDataFimAfastamento,ldDataInicioBeneficio: TDate;
  liId,liQtdeDiasTrabalhados: Integer;

begin
  loQryMaternidadeAdocao := TSQLQuery.Create(nil);
  try
    lbMaternidadeAdocao := True;
    liPis := 0;
    TryStrToInt64(FPisInscInss,liPis);

    if (liPis > 0) or (not Self.FOwner.FOwner.FExcluiPisZero) then begin
      {O funcionário é incluido na SEFIP se ele tem PIS OU não estiver marcado
      para excluir.}
      lbDesligado := false;
      if (FDataSaida >= BeginOfMonth(Self.FOwner.FOwner.FCompetencia))
        and (FDataSaida <= Self.FOwner.FOwner.FCompetencia)
        and (Trim(FCodigoMovimentacao) <> TP_APOSENTADORIA_INVALIDEZ)
      then begin
        lbDesligado := true;
      end;
      Self.FOwner.FOwner.FoCdsSefip20.Filtered := false;

      {Verifica se existe outro vínculo do funcionário com o mesmo empregador
      e a mesma data de admissão. Caso exista, acrescenta um dia a data de
      admissão e opção.}
      Self.FOwner.FOwner.FoCdsSefip30.IndexName := 'PRINCIPAL';
      if (Trim(FInscMfTomador) <> '') then begin
        {Verifica se existe outro vínculo do funcionário com o mesmo empregador
         e a mesma data de admissão.}
        if Self.FOwner.FOwner.FoCdsSefip30.Locate('TIPO_INSCMF_EMPRESA;INSCMF_EMPRESA;TIPO_INSCMF_TOMADOR;INSCMF_TOMADOR;PIS;DATA_ADMISSAO;CATEGORIA',VarArrayOf([Self.FOwner.FTipoInscMf,Self.FOwner.FInscMf,FTipoInscMfTomador,FInscMfTomador,FPisInscInss,FDataAdmissao,StrZero(Self.FCategoria,2,0)]),[]) then begin
          while (not Self.FOwner.FOwner.FoCdsSefip30.eof) do begin
            {Acrescenta 1 dia a data de admissão conforme determina o manual da
            SEFIP.}
            FDataAdmissao := FDataAdmissao+1;
            {Verifica se também, existe outro vínculo do funcionário com o mesmo
            empregador e com a data de admissão + 1}
            if (not Self.FOwner.FOwner.FoCdsSefip30.Locate('TIPO_INSCMF_EMPRESA;INSCMF_EMPRESA;TIPO_INSCMF_TOMADOR;INSCMF_TOMADOR;PIS;DATA_ADMISSAO;CATEGORIA',VarArrayOf([Self.FOwner.FTipoInscMf,Self.FOwner.FInscMf,FTipoInscMfTomador,FInscMfTomador,FPisInscInss,FDataAdmissao,StrZero(Self.FCategoria,2,0)]),[])) then begin
              Break;
            end;
          end;
          FDataOpcao := FDataAdmissao;
        end;
      end else begin
        {Verifica se existe outro vínculo do funcionário com o mesmo empregador
         e a mesma data de admissão.}
        if Self.FOwner.FOwner.FoCdsSefip30.Locate('TIPO_INSCMF_EMPRESA;INSCMF_EMPRESA;PIS;DATA_ADMISSAO;CATEGORIA',VarArrayOf([Self.FOwner.FTipoInscMf,Self.FOwner.FInscMf,FPisInscInss,FDataAdmissao,StrZero(Self.FCategoria,2,0)]),[]) then begin
          while (not Self.FOwner.FOwner.FoCdsSefip30.eof) do begin
            {Acrescenta 1 dia a data de admissão conforme determina o manual da
            SEFIP.}
            FDataAdmissao := FDataAdmissao+1;
            {Verifica se também, existe outro vínculo do funcionário com o mesmo
            empregador e com a data de admissão + 1}
            if (not Self.FOwner.FOwner.FoCdsSefip30.Locate('TIPO_INSCMF_EMPRESA;INSCMF_EMPRESA;PIS;DATA_ADMISSAO;CATEGORIA',VarArrayOf([Self.FOwner.FTipoInscMf,Self.FOwner.FInscMf,FPisInscInss,FDataAdmissao,StrZero(Self.FCategoria,2,0)]),[])) then begin
              Break;
            end;
          end;
          FDataOpcao := FDataAdmissao;
        end;
      end;

      {Chama getLinhas32 logo após a atribuição a FDataAdmissao, 30 porque é
      necessário a FDataAdmissao no registro 32 (e caso o funcionário tenha mais
      de um vínculo com o mesmo empregador, a data de admissão é incrementada
      em 1 dia no loop logo acioma) e é necessário saber se
      lsCodigoMovimentacaoFgts in ('01','02','R'). Pois, em caso positivo, mais
      abaixo é informada a base de INSS, porque ela poderá ser diferente da base
      do FGTS.}
      if (not FOwner.FOwner.FCompetencia13)
        and (FOwner.FOwner.FeTipoRecolhimentoSefip <> TTipoRecolhimentoSefip.trs_somente_diferencas_650)
      then begin
        getLinhas32(lsCodigoMovimentacaoFgts,ldDataInicioAfastamento,ldDataFimAfastamento,ldDataInicioBeneficio);
      end;

      lsLinha := '30';
      lsLinha := lsLinha+Self.FOwner.FTipoInscMf;
      lsLinha := lsLinha+StrZero(StrToInt64(fSoNumeros(Self.FOwner.FInscMf)),14,0);
      if (fSoNumeros(FInscMfTomador) <> '')
        and (FOwner.FOwner.FeTipoRecolhimentoSefip <> TTipoRecolhimentoSefip.trs_somente_diferencas_650)
      then begin
        lsLinha := lsLinha+FTipoInscMfTomador;
        lsLinha := lsLinha+StrZero(StrToInt64(fSoNumeros(FInscMfTomador)),14,0);
        if not Self.FOwner.FOwner.FoCdsSefip20.Locate('INSCMF_EMPRESA;INSCMF_TOMADOR',VarArrayOf([Self.FOwner.FInscMf,Trim(FInscMfTomador)]),[]) then begin
          Self.FOwner.FOwner.FTemTomador := True;
          Self.FOwner.FOwner.FoCdsSefip20.Insert;
          Self.FOwner.FOwner.FoCdsSefip20.FieldByName('FK_TOMADOR'         ).AsString := Self.FIdTomador;
          Self.FOwner.FOwner.FoCdsSefip20.FieldByName('TIPO_INSCMF_EMPRESA').AsString := Self.FOwner.FTipoInscMf;
          Self.FOwner.FOwner.FoCdsSefip20.FieldByName('INSCMF_EMPRESA'     ).AsString := Self.FOwner.FInscMf;
          Self.FOwner.FOwner.FoCdsSefip20.FieldByName('TIPO_INSCMF_TOMADOR').AsString := FTipoInscMfTomador;
          Self.FOwner.FOwner.FoCdsSefip20.FieldByName('INSCMF_TOMADOR'     ).AsString := FInscMfTomador;
          Self.FOwner.FOwner.FoCdsSefip20.FieldByName('LINHA20'            ).AsString := 'LINHA20';
          Self.FOwner.FOwner.FoCdsSefip20.FieldByName('LINHA21'            ).AsString := 'LINHA21';
          Self.FOwner.FOwner.FoCdsSefip20.Post;
        end;
      end else begin
        lsLinha := lsLinha+StrSpace(15);
      end;
      lsLinha := lsLinha+FPisInscInss;
      if FCategoria in ([1,3,4,5,6,7,11,12,19,20,21,26]) then begin
        lsLinha := lsLinha+DateStr(FDataAdmissao,dtsDMY);
      end else begin
        lsLinha := lsLinha+StrSpace(8);
      end;
      lsLinha := lsLinha+StrZero(FCategoria,2,0);
      lsLinha := lsLinha+Valid_Caracter(FNome,false);
      lsLinha := lsLinha+StrSpace(11); {Matrícula}
      if FCategoria in ([1,2,3,4,6,7,26]) then begin
        lsLinha := lsLinha+FCTPS;
        if fSoNumeros(FSerieCTPS) <> '' then begin
          lsLinha := lsLinha+StrZero(StrToInt(fSoNumeros(FSerieCTPS)),5,0);
        end else begin
          Self.FOwner.FOwner.FInconsistencias.Append('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Falta série da CTPS no cadastro do colaborador.');
        end;
      end else begin
        lsLinha := lsLinha+StrSpace(12); {Número e Série da CTPS}
      end;
      if FCategoria in ([1,3,4,5,6,7]) then begin
        lsLinha := lsLinha+DateStr(FDataOpcao,dtsDMY);
        if (FCategoria in ([1,3])) then begin
          if (FDataAdmissao < StrToDate('05/10/1988')) and (FDataOpcao > StrToDate('05/10/1988')) then begin
            Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', com data de admissão inferior a 05.10.1988 não pode ter data de opção superior a 05.10.1988. Consulte o manual da SEFIP.');
            Self.FOwner.FOwner.FInconsistencias.Add(' ');
          end else if (FDataAdmissao >= StrToDate('05/10/1988')) and (FDataOpcao <> FDataAdmissao) then begin
            Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', com data de admissão igual ou maior a 05.10.1988, a data de opção tem que ser igual a data de admissao. Consulte o manual da SEFIP.');
            Self.FOwner.FOwner.FInconsistencias.Add(' ');
          end;
        end else if (FCategoria = 4) then begin
          FDataOpcao := FDataAdmissao;
        end else if (FCategoria = 5) and (FDataOpcao < StrToDate('02/06/1981')) then begin
          Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', a data de opção deve ser igual ou maior 02.06.1981. Consulte o manual da SEFIP.');
          Self.FOwner.FOwner.FInconsistencias.Add(' ');
        end else if (FCategoria = 6) and (FDataOpcao < StrToDate('01/03/2000')) then begin
          Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', a data de opção deve ser igual ou maior 01.03.2000. Consulte o manual da SEFIP.');
          Self.FOwner.FOwner.FInconsistencias.Add(' ');
        end else if (FCategoria = 7) and ((FDataOpcao < StrToDate('20/12/2000')) or (FDataOpcao <> FDataAdmissao)) then begin
          Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', a data de opção deve ser igual ou maior 20.12.2000 e igual a data de admissão. Consulte o manual da SEFIP.');
          Self.FOwner.FOwner.FInconsistencias.Add(' ');
        end else if (FDataOpcao < StrToDate('01/01/1967')) then begin
          Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', a data de opção deve ser igual ou maior 01.01.1967. Consulte o manual da SEFIP.');
          Self.FOwner.FOwner.FInconsistencias.Add(' ');
        end;
      end else begin
        lsLinha := lsLinha+StrSpace(8); {Data de Opção}
      end;

      if FCategoria in ([1,2,3,4,5,6,7,12,19,20,21,26]) then begin
        lsLinha := lsLinha+DateStr(FDataNascimento,dtsDMY);
        if (FDataNascimento < StrToDate('01/01/1900')) then begin
          Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', a data de nascimento deve ser igual ou maior 01.01.1900. Consulte o manual da SEFIP.');
          Self.FOwner.FOwner.FInconsistencias.Add(' ');
        end else if (FDataNascimento >= FDataAdmissao) then begin
          Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', a data de nascimento deve ser igual ou maior 01.01.1900. Consulte o manual da SEFIP.');
          Self.FOwner.FOwner.FInconsistencias.Add(' ');
        end;
      end else begin
        lsLinha := lsLinha+StrSpace(8); {Data de Nascimento}
      end;
      if Length(Trim(FCbo)) < 4 then begin
        Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Falta informar o CBO.');
        Self.FOwner.FOwner.FInconsistencias.Add(' ');
        FCbo := StrSpace(4);
      end;
      lsLinha := lsLinha+'0'+copy(FCbo,1,4);
      if (FCategoria = 6) and (copy(FCbo,1,4) <> '5121') then begin
        Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', os 4 primeiros dígitos do CBO devem ser 5121. Consulte o manual da SEFIP.');
        Self.FOwner.FOwner.FInconsistencias.Add(' ');
      end;

      if (FRemuneracao < 0) then begin
        Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', a remuneração não pode ser negativa. Valor da Remuneração '+FormatSettings.CurrencyString+' '+CurrToStr(FRemuneracao)+'.');
        Self.FOwner.FOwner.FInconsistencias.Add(' ');
      end else if (FCategoria in ([5,11,13,14,15,16,17,18,22,23,24,25])) and (FRemuneracao = 0) then begin
        Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', a remuneração não pode ser zero. Consulte o manual da SEFIP.');
        Self.FOwner.FOwner.FInconsistencias.Add(' ');
      end;
      if (Self.FOwner.FOwner.FCompetencia13) and (FCategoria <> 2) then begin
        lsLinha := lsLinha+StrZero(0,15,0);
      end else begin
        lsLinha := lsLinha+MyCurrToStr(FRemuneracao,15,2,false);
      end;

      if (FCategoria = 2) and (FRemuneracao13 = 0) then begin
        Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', a remuneração para o 13o Salário não pode ser zero. Consulte o manual da SEFIP.');
        Self.FOwner.FOwner.FInconsistencias.Add(' ');
      end;
      if (Self.FOwner.FOwner.FCompetencia13) and (FCategoria <> 2) then begin
        lsLinha := lsLinha+StrZero(0,15,0);
      end else begin
        if (FRemuneracao13 > 0) then begin
          lsLinha := lsLinha+MyCurrToStr(FRemuneracao13,15,2,false);
        end else begin
          lsLinha := lsLinha+MyCurrToStr(0,15,2,false);
        end;
      end;
      lsLinha := lsLinha+StrSpace(2); {Classe de contribuição}

      if (FCategoria in ([5,11])) and ((FOcorrencia <> 0) and (FOcorrencia <> 5)) then begin
        Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', a ocorrência só pode ser branco ou 05. Consulte o manual da SEFIP.');
        Self.FOwner.FOwner.FInconsistencias.Add(' ');
      end else if (FCategoria in ([2,22,23])) and (FOcorrencia > 4) then begin
        Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', a ocorrência só pode ser branco 01,02,03 ou 04. Consulte o manual da SEFIP.');
        Self.FOwner.FOwner.FInconsistencias.Add(' ');
      end else if (FCategoria = 26) and (FOcorrencia < 5) then begin
        Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', a ocorrência só pode ser branco 05,06,07 ou 08. Consulte o manual da SEFIP.');
        Self.FOwner.FOwner.FInconsistencias.Add(' ');
      end else if (FCategoria in ([1,2,3,4,5,6,7,11,12,13,15,17,18,19,20,21,22,23,24,25])) then begin
        if (FOcorrencia < 5) and (FRemuneracaoOutrasEmpresas > 0) then begin
          FOcorrencia := 5;
        end;
      end else if (FOcorrencia > 8) then begin
        Self.FOwner.FOwner.FInconsistencias.Add('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Categoria '+StrZero(FCategoria,2,0)+', a ocorrência não pode ser maior que 08. Consulte o manual da SEFIP.');
        Self.FOwner.FOwner.FInconsistencias.Add(' ');
      end else begin
        FOcorrencia := 0;
      end;

      if FOcorrencia = 0 then begin
        lsLinha := lsLinha+StrSpace(2); {Ocorrência}
      end else begin
        lsLinha := lsLinha+StrZero(FOcorrencia,2,0);
      end;

      if (FRemuneracaoOutrasEmpresas > 0)
        or (FOcorrencia = 5)
        or (Self.FOwner.FOwner.FeTipoRecolhimentoSefip = TTipoRecolhimentoSefip.trs_somente_diferencas_650)
      then begin
        lsLinha := lsLinha+MyCurrToStr(FDescontoPrevSoc+FDescontoPrevSoc13Rescisao+FDescontoPrevSoc13Diferenca,15,2,false);
      end else begin
        lsLinha := lsLinha+StrZero(0,15,0);
      end;

      if (FOcorrencia >= 5) and (FRemuneracaoOutrasEmpresas = 0) and (Self.FOwner.FRegimeFederal <> TP_REGIME_FEDERAL_MEI) then begin
        if (FOcorrencia = 5) and (FRemuneracaoOutrasEmpresas = 0) and (Self.FOwner.FRegimeFederal <> TP_REGIME_FEDERAL_MEI) then begin
          {Verifica se a funcionária está em licença maternidade por adoção. Pois
          matenidade por adoção é paga diretamente pela previdência e a ocorrência
          deve ser 5, porém não tem remuneração em outras empresas.}
          loQryMaternidadeAdocao.SQLConnection := TUtil.getConn;
          loQryMaternidadeAdocao.SQL.Clear;
          loQryMaternidadeAdocao.SQL.Add('SELECT FS.DATA FROM PFUNCIONARIO_SITUACAO FS ');
          loQryMaternidadeAdocao.SQL.Add('JOIN PFUNCIONARIO_SITUACAO_COD FSC ON (FS.FK_CODIGO_SITUACAO = FSC.ID_PFUNCIONARIO_SITUACAO_COD) ');
          loQryMaternidadeAdocao.SQL.Add('WHERE (FS.FK_FUNCIONARIO IN (SELECT * FROM SP_SPLIT (:pIdsFuncionarios,'+QuotedStr(',')+'))) AND (FSC.CODIGO = :pMaternidade) ');
          loQryMaternidadeAdocao.SQL.Add('AND (FSC.SUB_CODIGO BETWEEN :pAdocao120Dias AND :pAdocao30Dias) ');
          loQryMaternidadeAdocao.SQL.Add('AND (FS.DATA <= :pDataFinal) AND (FS.DATA >= :pDataInicial) ');
          loQryMaternidadeAdocao.ParamByName('pIdsFuncionarios').AsString  := Self.FoCdsColaboradores.FieldByName('R_IDS').AsString;
          loQryMaternidadeAdocao.ParamByName('pMaternidade'    ).AsInteger := TP_CD_FGTS_MATERNIDADE;
          loQryMaternidadeAdocao.ParamByName('pAdocao120Dias'  ).AsInteger := TP_CD_FGTS_MATERNIDADE_Q4;
          loQryMaternidadeAdocao.ParamByName('pAdocao30Dias'   ).AsInteger := TP_CD_FGTS_MATERNIDADE_Q6;
          loQryMaternidadeAdocao.ParamByName('pDataInicial'    ).AsDate    := BeginOfMonth(Self.FOwner.FOwner.FCompetencia);
          loQryMaternidadeAdocao.ParamByName('pDataFinal'      ).AsDate    := EndOfMonth(Self.FOwner.FOwner.FCompetencia);
          loQryMaternidadeAdocao.Open;
          if not loQryMaternidadeAdocao.IsEmpty then begin
            lbMaternidadeAdocao := true;
          end;
        end;

        if (not lbMaternidadeAdocao) then begin
          if Self.FOwner.FOwner.FCompetencia13 then begin
            Self.FOwner.FOwner.FInconsistencias.Append('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Funcionário com ocorrência '+IntToStr(FOcorrencia)+' sem informação de remuneração para o 13o Salário em outras empresas.');
          end else if (Self.FOwner.FRegimeFederal <> TP_REGIME_FEDERAL_MEI) then begin
            {No caso de funcionário de empresa MEI que esteja em maternidade, a
            ocorrência deve ser 5, porém, sem remuneração em outras empresas.
            (MEI - Ato Declaratório Executivo Codac 21/2012)}
            Self.FOwner.FOwner.FInconsistencias.Append('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: Funcionário com ocorrência '+IntToStr(FOcorrencia)+' sem informação de remuneração em outras empresas.');
          end;
        end;
      end;

      if (Self.FOwner.FOwner.FCompetencia13) then begin
        FBasePrevSocAcidente := 0;
      end else if (Pos(trim(lsCodigoMovimentacaoFgts),'O1*O2*R*') > 0) then begin
        if (FBasePrevSocAcidente = 0)
          and (ldDataInicioBeneficio >= EndOfMonth(ldDataInicioAfastamento))
          and (ldDataInicioBeneficio >= BeginOfMonth(Self.FOwner.FOwner.FCompetencia))
        then begin
          {Caso o funcionário esteja afastado por acidente ou serviço militar
          e FBasePrevSocAcidente = 0, atribui a FBasePrevSocAcidente o valor de
          FRemuneracao. Isso acontece no seguinte caso: Funcionário saiu de
          acidente em 09.09, então, o início dos primeiros 15 dias se dá em
          24.08. Nesse caso, para o MegaPessoal, como ele não estava afastado no
          mês 08, o sistema calcula normalmente, mas, para a SEFIP a informação de
          afastatamento vai com data de 24.08 e, nesse caso, se não informar qual
          é a base da previdência (que nesse caso é a própria remuneração do mês),
          a SEFIP não calcula a previdência, calcula somente o FGTS.
          OBS: Esse problema não ocorre quando o afastamento é por doença. (Não me
          pergunte o motivo rsrsrs (RCS)))}
          FBasePrevSocAcidente := FRemuneracao;
        end else if (FBasePrevSocAcidente = 0)
          and (((MesAno(ldDataInicioBeneficio,False) = MesAno(Self.FOwner.FOwner.FCompetencia,False))
          and (ldDataInicioBeneficio > (BeginOfMonth(Self.FOwner.FOwner.FCompetencia)+1)))
          or ((MesAno(ldDataFimAfastamento,False) = MesAno(Self.FOwner.FOwner.FCompetencia,False))
          and (ldDataFimAfastamento < Self.FOwner.FOwner.FCompetencia)))
        then begin
          liQtdeDiasTrabalhados := 0;
          for liId := 1 to StrTokenCount(FsIdsColaboradores,',') do begin
            dmInformacoesSefip.qrySpDiasTrabalhados.Close;
            dmInformacoesSefip.qrySpDiasTrabalhados.Connection := TUtilConexaoFireDac.getConn;
            dmInformacoesSefip.qrySpDiasTrabalhados.ParamByName('pDataInicial'  ).AsDate   := BeginOfMonth(Self.FOwner.FOwner.FCompetencia);
            dmInformacoesSefip.qrySpDiasTrabalhados.ParamByName('pDataFinal'    ).AsDate   := EndOfMonth(Self.FOwner.FOwner.FCompetencia);
            dmInformacoesSefip.qrySpDiasTrabalhados.ParamByName('pIdFuncionario').AsString := StrSubst(StrToken(FsIdsColaboradores,',',liId),Char(39),'',0);
            dmInformacoesSefip.qrySpDiasTrabalhados.Open;
            liQtdeDiasTrabalhados := liQtdeDiasTrabalhados+dmInformacoesSefip.qrySpDiasTrabalhados.FieldByName('R_DIAS_TRABALHADOS').AsInteger+dmInformacoesSefip.qrySpDiasTrabalhados.FieldByName('R_DIAS_AFASTAMENTO_EMPRESA').AsInteger;
          end;
          if (liQtdeDiasTrabalhados > 0)
            and (liQtdeDiasTrabalhados <> dmInformacoesSefip.qrySpDiasTrabalhados.FieldByName('R_DIAS_MES').AsInteger)
          then begin
            {Se o funcionário está saindo ou retornando de acidente de trabalho e
            tem dias trabalhados no mês, é necessário informar o valor da base de
            cálculo para a previdência social}
            Self.FOwner.FOwner.FInconsistencias.Append('Empresa: '+trim(FOwner.FNome)+'-'+FsDescricaoTipoColaborador+' - '+trim(FNome)+'. Motivo: É necessário informar o valor da base de cálculo para a previdência em caso de benefício por acidente de trabalho.');
          end else if (liQtdeDiasTrabalhados = dmInformacoesSefip.qrySpDiasTrabalhados.FieldByName('R_DIAS_MES').AsInteger) then begin
            FBasePrevSocAcidente := FRemuneracao;
          end;
        end;
      end;
      lsLinha := lsLinha+MyCurrToStr(FBasePrevSocAcidente,15,2,false);

      ldblBase13PrevSocial := 0;
      if (Self.FOwner.FOwner.FCompetencia13) then begin
        ldblBase13PrevSocial := FBase13Movimento;
        if ldblBase13PrevSocial <= 0 then begin
          ldblBase13PrevSocial := 0.01;
        end;
      end else if lbDesligado then begin
        ldblBase13PrevSocial := FBase13Rescisao;
        if (Trim(FCodigoMovimentacao) <> TP_RESCISAO_JUSTA_CAUSA_EMPREGADOR)
          and (ldblBase13PrevSocial <= 0)
          and (((Year(FDataAdmissao) < Year(Self.FOwner.FOwner.FCompetencia)) and ((DaysBetween(BeginOfYear(Self.FOwner.FOwner.FCompetencia),Self.FDataSaida)+1) >= 15))
          or ((Year(FDataAdmissao) = Year(Self.FOwner.FOwner.FCompetencia)) and ((DaysBetween(FDataAdmissao,Self.FDataSaida)+1) >= 15)))
        then begin
          ldblBase13PrevSocial := 0.01;
        end;
      end else if (Month(Self.FOwner.FOwner.FCompetencia) = 12) then begin
        ldblBase13PrevSocial := FVlDiferenca13;
      end;
      lsLinha := lsLinha+MyCurrToStr(ldblBase13PrevSocial,15,2,false);

      if (FVlDiferenca13 = 0) or (FOwner.FOwner.FCompetencia13) or (Month(Self.FOwner.FOwner.FCompetencia) <> 12) or (not FCategoria in ([1,4,6,7,12,19,20,21,26])) then begin
        ldblBasePrevComp13 := 0;
      end else begin
        ldblBasePrevComp13 := FBase13Gps13;
        if (ldblBasePrevComp13 = 0) and (FVlDiferenca13 > 0) then begin
          ldblBasePrevComp13 := 0.01;
        end;
      end;
      lsLinha := lsLinha+MyCurrToStr(ldblBasePrevComp13,15,2,false);
      lsLinha := lsLinha+StrSpace(98);
      lsLinha := lsLinha+'*';

//      if (Self.FOwner.FOwner.FoCdsSefip30.Locate('INSCMF_EMPRESA;INSCMF_TOMADOR;PIS;DATA_ADMISSAO;CATEGORIA',VarArrayOf([Self.FOwner.FInscMf,Self.FInscMfTomador,Self.FPisInscInss,Self.FDataAdmissao,StrZero(Self.FCategoria,2,0)]),[])) then begin
//        lsLinhaAnterior := Self.FOwner.FOwner.FoCdsSefip30.FieldByName('LINHA').AsString;
//        ldbl
//
//
//
//        Self.FOwner.FOwner.FoCdsSefip30.Edit;
//      end else begin
        Self.FOwner.FOwner.FoCdsSefip30.Insert;
        Self.FOwner.FOwner.FoCdsSefip30.FieldByName('MATRICULA_E_SOCIAL' ).AsInteger  := Self.FiMatriculaESocial;
        Self.FOwner.FOwner.FoCdsSefip30.FieldByName('TIPO_INSCMF_EMPRESA').AsString   := Self.FOwner.FTipoInscMf;
        Self.FOwner.FOwner.FoCdsSefip30.FieldByName('INSCMF_EMPRESA'     ).AsString   := Self.FOwner.FInscMf;
        Self.FOwner.FOwner.FoCdsSefip30.FieldByName('TIPO_INSCMF_TOMADOR').AsString   := Self.FTipoInscMfTomador;
        Self.FOwner.FOwner.FoCdsSefip30.FieldByName('INSCMF_TOMADOR'     ).AsString   := Self.FInscMfTomador;
        Self.FOwner.FOwner.FoCdsSefip30.FieldByName('NOME'               ).AsString   := Self.FNome;
        Self.FOwner.FOwner.FoCdsSefip30.FieldByName('PIS'                ).AsString   := Self.FPisInscInss;
        Self.FOwner.FOwner.FoCdsSefip30.FieldByName('DATA_ADMISSAO'      ).AsDateTime := Self.FDataAdmissao;
        Self.FOwner.FOwner.FoCdsSefip30.FieldByName('CATEGORIA'          ).AsString   := StrZero(Self.FCategoria,2,0);
        Self.FOwner.FOwner.FoCdsSefip30.FieldByName('LINHA'              ).AsString   := lsLinha;
//      end;
      Self.FOwner.FOwner.FoCdsSefip30.Post;
//      if not FOwner.FOwner.FCompetencia13 then begin
//        getLinhas32();
//      end;
    end;
  finally
    FreeAndNil(loQryMaternidadeAdocao);
  end;
end;

procedure TColaborador.getLinhas32(var psCodigoMovimentacaoFgts: string;
      var pdDataInicioAfastamento, pdDataFimAfastamento,
      pdDataInicioBeneficio: TDate);
var
  loQryFuncionarioSituacao: TSQLQuery;
  lsLinha,lsIndicativoRecolhimentoFgts: String;
  liFor,liCount: Integer;
begin
  psCodigoMovimentacaoFgts := EmptyStr;
  loQryFuncionarioSituacao:= TSQLQuery.Create(nil);
  try
    loQryFuncionarioSituacao.SQLConnection := TUtil.getConn;
    loQryFuncionarioSituacao.SQL.Add('SELECT FS.ID_PFUNCIONARIO_SITUACAO,FS.DATA,FS.DATAFIN,FSC.CODIGO_MOVIMENTACAO_FGTS,FSC.CODIGO,FSC.SUB_CODIGO,FSR.EMITE_GRFC ');
    loQryFuncionarioSituacao.SQL.Add('FROM PFUNCIONARIO F LEFT JOIN PFUNCIONARIO_SITUACAO FS ON (FS.FK_FUNCIONARIO = F.ID_PFUNCIONARIO) ');
    loQryFuncionarioSituacao.SQL.Add('LEFT JOIN PFUNCIONARIO_SITUACAO_COD FSC ON (FS.FK_CODIGO_SITUACAO = FSC.ID_PFUNCIONARIO_SITUACAO_COD) ');
    loQryFuncionarioSituacao.SQL.Add('LEFT JOIN PFUNCIONARIO_SITUACAO_RE FSR ON (FS.ID_PFUNCIONARIO_SITUACAO = FSR.FK_FUNCIONARIO_SITUACAO) ');
    loQryFuncionarioSituacao.SQL.Add('WHERE (FS.FK_FUNCIONARIO IN ('+FsIdsColaboradores+')) AND (F.MATRICULA_E_SOCIAL = :pMatriculaESocial) ');
    loQryFuncionarioSituacao.SQL.Add('AND (((FSC.CODIGO = 2) AND (FS.DATA <= :pDataFinal) AND ((FS.DATAFIN IS NULL) OR (FS.DATAFIN >= :pDataInicial))) ');
    loQryFuncionarioSituacao.SQL.Add('OR ((FSC.CODIGO BETWEEN 4 AND 9) AND (FS.DATA <= :pDataFinalAfastamento) AND (FS.DATA <= :pDataFinal) AND ((FS.DATAFIN IS NULL) OR (FS.DATAFIN >= :pDataInicial))) ');
    loQryFuncionarioSituacao.SQL.Add('OR ((FSC.CODIGO BETWEEN 50 AND 90) AND (FS.DATA BETWEEN :pDataInicial AND :pDataFinal))) ORDER BY FS.DATA');
    loQryFuncionarioSituacao.ParamByName('pMatriculaESocial').AsInteger := Self.FiMatriculaESocial;
    loQryFuncionarioSituacao.ParamByName('pDataInicial'     ).AsDate    := BeginOfMonth(Self.FOwner.FOwner.FCompetencia);
    loQryFuncionarioSituacao.ParamByName('pDataFinal'       ).AsDate    := EndOfMonth(Self.FOwner.FOwner.FCompetencia);

    if BeginOfMonth(Self.FOwner.FOwner.FCompetencia) >= StrToDate('01/03/2015') then begin
      loQryFuncionarioSituacao.ParamByName('pDataFinalAfastamento').AsDate   := EndOfMonth(Self.FOwner.FOwner.FCompetencia);
    end else begin
      loQryFuncionarioSituacao.ParamByName('pDataFinalAfastamento').AsDate   := EndOfMonth(Self.FOwner.FOwner.FCompetencia)+15;
    end;
    loQryFuncionarioSituacao.Open;

    while not loQryFuncionarioSituacao.Eof do begin
      psCodigoMovimentacaoFgts := Trim(loQryFuncionarioSituacao.FieldByName('CODIGO_MOVIMENTACAO_FGTS').AsString);
      if (loQryFuncionarioSituacao.FieldByName('CODIGO').AsInteger < TP_CD_FGTS_RESCISAO) and (DateStr(loQryFuncionarioSituacao.FieldByName('DATAFIN').AsDateTime,dtsMY) = DateStr(Self.FOwner.FOwner.FCompetencia,dtsMY)) then begin
        liCount := 2;
      end else begin
        liCount := 1;
      end;
      for liFor := 1 to liCount do begin
        lsLinha := '32';
        lsLinha := lsLinha+Self.FOwner.FTipoInscMf;
        lsLinha := lsLinha+StrZero(StrToInt64(fSoNumeros(Self.FOwner.FInscMf)),14,0);
        lsLinha := lsLinha+FTipoInscMfTomador;
        if (fSoNumeros(FInscMfTomador) <> '') then begin
          lsLinha := lsLinha+StrZero(StrToInt64(fSoNumeros(FInscMfTomador)),14,0);
        end else begin
          lsLinha := lsLinha+StrSpace(14);
        end;
        lsLinha := lsLinha+FPisInscInss;
        lsLinha := lsLinha+DateStr(FDataAdmissao,dtsDMY);
        lsLinha := lsLinha+StrZero(FCategoria,2,0);
        lsLinha := lsLinha+Valid_Caracter(FNome,false);
        if liFor = 1 then begin
          lsLinha           := lsLinha+StrLPad(psCodigoMovimentacaoFgts,2);
          pdDataInicioAfastamento := loQryFuncionarioSituacao.FieldByName('DATA'   ).AsDateTime;
          pdDataFimAfastamento    := loQryFuncionarioSituacao.FieldByName('DATAFIN').AsDateTime;
          pdDataInicioBeneficio   := pdDataInicioAfastamento;
          if (loQryFuncionarioSituacao.FieldByName('CODIGO').AsInteger >= TP_CD_FGTS_RESCISAO) then begin
//            lsLinha := lsLinha+DateStr(loQryFuncionarioSituacao.FieldByName('DATA').AsDateTime,dtsDMY);
            lsLinha := lsLinha+DateStr(pdDataInicioAfastamento,dtsDMY);
          end else if (loQryFuncionarioSituacao.FieldByName('CODIGO').AsInteger = TP_CD_FGTS_MATERNIDADE) then begin
            pdDataInicioBeneficio := pdDataInicioAfastamento-1;
            lsLinha := lsLinha+DateStr(pdDataInicioBeneficio,dtsDMY);
          end else if ((loQryFuncionarioSituacao.FieldByName('CODIGO').AsInteger = TP_CD_FGTS_OUTROS_AFASTAMENTOS)
            and (loQryFuncionarioSituacao.FieldByName('SUB_CODIGO').AsInteger = TP_CD_FGTS_OUTROS_AFAST_PROROG_MATERNIDADE)) {Sub-codigo = 1 - Prorrogação Maternidade}
          then begin
            {Prorrogação Maternidade - Informar o código de afastamento
            "Y - Outros motivos de afastamento temporário", e a data
            correspondente ao dia imediatamente anterior ao início da
            prorrogação (mesma data informada no retorno Z1),
            para a empregada que requerer a prorrogação.
            Ato Declaratório Executivo Codac nº 58, de 17 de agosto de 2010
            http://www.receita.fazenda.gov.br/Legislacao/AtosExecutivos/2010/CODAC/ADCodac058.htm}
            pdDataInicioBeneficio := pdDataInicioAfastamento-1;
            lsLinha := lsLinha+DateStr(pdDataInicioBeneficio,dtsDMY);
          end else if (Self.FCategoria = 6)
            or (loQryFuncionarioSituacao.FieldByName('SUB_CODIGO').AsInteger = 2) {Sub-codigo = 2 - Novo afastamento pelo mesmo problema}
          then begin
            {Novo afastamento pelo mesmo problema o empregador não paga os
            primeiros 15/30 dias.
            Empregador doméstico também não paga os primeiros 15/30 dias de
            auxilio doença ou acidente. O benefício é totalmente pago pela
            previdência.
            Decreto nº 3.048 de 06 de maio de 1999, artigo 72, inciso II.}
            lsLinha := lsLinha+DateStr(pdDataInicioBeneficio,dtsDMY);
          end else if (Pos(psCodigoMovimentacaoFgts,'O1*P1') > 0) then begin
            {Afastamentos até 15 para afastamentos até 28.02.2015 e 30 dias a
            apartir de 01.03.2015 até 18.06.2015, MP nº 664 de 30 de dezembro de
            2014, convertida na Lei na Lei 13.135/2015, com vetos, publicada no
            DOU em 18.06.2015, que voltou a 15 dias}
            if (loQryFuncionarioSituacao.FieldByName('SUB_CODIGO').AsInteger = 1) then begin
              if (pdDataInicioBeneficio > StrToDate('18/06/2015')) then begin
                {Conforme manual da versão 8.0 da SEFIP, deve ser informado o dia
                imediatamente anterior ao efetivo afastamento}
                pdDataInicioBeneficio := pdDataInicioAfastamento-1;
                lsLinha := lsLinha+DateStr(pdDataInicioBeneficio,dtsDMY);
                pdDataInicioBeneficio := pdDataInicioBeneficio+15;
              end else begin
                pdDataInicioBeneficio := pdDataInicioAfastamento-16;
                lsLinha := lsLinha+DateStr(pdDataInicioBeneficio,dtsDMY);
              end;
            end else begin
              {Até 28.02.2015, a data inicial informada no MegaPessoal para os
              afastamentos doença/acidente a partir do dia que INSS assumia o
              paramento, ou seja, 15 dias após o efetivo afastamento do trabalho.
              A partir de 01.03.2015, a data de início a ser informada é a
              efetiva data do afastamento.}
              {Conforme manual da versão 8.0 da SEFIP, deve ser informado o dia
              imediatamente anterior ao efetivo afastamento}
              pdDataInicioBeneficio := pdDataInicioAfastamento-1;
              lsLinha := lsLinha+DateStr(pdDataInicioBeneficio,dtsDMY);
              pdDataInicioBeneficio := pdDataInicioBeneficio+30;
            end;
          end else begin
            pdDataInicioBeneficio := pdDataInicioAfastamento-1;
            lsLinha := lsLinha+DateStr(pdDataInicioBeneficio,dtsDMY);
          end;
        end else begin
          if Copy(psCodigoMovimentacaoFgts,1,1) = 'Q' then begin
            lsLinha  := lsLinha+'Z1';
          end else if psCodigoMovimentacaoFgts = 'O1' then begin
            lsLinha := lsLinha+'Z2';
          end else if psCodigoMovimentacaoFgts = 'O2' then begin
            lsLinha := lsLinha+'Z3';
          end else if psCodigoMovimentacaoFgts = 'O3' then begin
            lsLinha := lsLinha+'Z6';
          end else if psCodigoMovimentacaoFgts = 'R' then begin
            lsLinha := lsLinha+'Z4';
          end else begin
            lsLinha := lsLinha+'Z5';
          end;
          lsLinha := lsLinha+DateStr(pdDataFimAfastamento,dtsDMY);
        end;
        lsIndicativoRecolhimentoFgts := ' ';
        if (pos(psCodigoMovimentacaoFgts,'I1*I2*I3*I4*L') > 0) then begin
          if (loQryFuncionarioSituacao.FieldByName('EMITE_GRFC').AsInteger = -1) and (FCategoria in ([1,2,3,4,5,6,7])) then begin
            lsIndicativoRecolhimentoFgts := 'S';
          end else begin
            lsIndicativoRecolhimentoFgts := 'N';
          end;
        end else begin
          lsIndicativoRecolhimentoFgts := ' ';
        end;
        lsLinha := lsLinha+lsIndicativoRecolhimentoFgts;
        lsLinha := lsLinha+StrSpace(225);
        lsLinha := lsLinha+'*';

        Self.FOwner.FOwner.FoCdsSefip32.Insert;
        Self.FOwner.FOwner.FoCdsSefip32.FieldByName('MATRICULA_E_SOCIAL' ).AsInteger  := Self.FiMatriculaESocial;
        Self.FOwner.FOwner.FoCdsSefip32.FieldByName('TIPO_INSCMF_EMPRESA').AsString   := Self.FOwner.FTipoInscMf;
        Self.FOwner.FOwner.FoCdsSefip32.FieldByName('INSCMF_EMPRESA'     ).AsString   := Self.FOwner.FInscMf;
        Self.FOwner.FOwner.FoCdsSefip32.FieldByName('TIPO_INSCMF_TOMADOR').AsString   := Self.FTipoInscMfTomador;
        Self.FOwner.FOwner.FoCdsSefip32.FieldByName('INSCMF_TOMADOR'     ).AsString   := Self.FInscMfTomador;
//        Self.FOwner.FOwner.FoCdsSefip32.FieldByName('NOME'               ).AsString   := Self.FNome;
//        Self.FOwner.FOwner.FoCdsSefip32.FieldByName('PIS'                ).AsString   := Self.FPisInscInss;
//        Self.FOwner.FOwner.FoCdsSefip32.FieldByName('DATA_ADMISSAO'      ).AsDateTime := Self.FDataAdmissao;
//        Self.FOwner.FOwner.FoCdsSefip32.FieldByName('CATEGORIA'          ).AsString   := StrZero(Self.FCategoria,2,0);
        Self.FOwner.FOwner.FoCdsSefip32.FieldByName('LINHA'              ).AsString   := lsLinha;
        Self.FOwner.FOwner.FoCdsSefip32.Post;
      end;
      loQryFuncionarioSituacao.Next;
    end;
  finally
    FreeAndNil(loQryFuncionarioSituacao);
  end;
end;

function TColaborador.getMaternidade: Boolean;
var
  loQryFuncionarioSituacao: TSQLQuery;
begin
  {Retorna se a funcionária está em maternidade para que o sistema informe
   o valor do INSS descontado no campo 20 do registro 30.}
  Result := false;
  loQryFuncionarioSituacao:= TSQLQuery.Create(nil);
  try
    loQryFuncionarioSituacao.SQLConnection := TUtil.getConn;
    loQryFuncionarioSituacao.SQL.Add('SELECT FIRST 1 ID_PFUNCIONARIO_SITUACAO ');
    loQryFuncionarioSituacao.SQL.Add('FROM PFUNCIONARIO_SITUACAO FS ');
    loQryFuncionarioSituacao.SQL.Add('LEFT JOIN PFUNCIONARIO_SITUACAO_COD FSC ON (FS.FK_CODIGO_SITUACAO = FSC.ID_PFUNCIONARIO_SITUACAO_COD) ');
//    loQryFuncionarioSituacao.SQL.Add('WHERE (FS.FK_FUNCIONARIO = :pIdFuncionario) ');
    loQryFuncionarioSituacao.SQL.Add('WHERE (FS.FK_FUNCIONARIO IN (:pIdsFuncionarios)) ');
    loQryFuncionarioSituacao.SQL.Add('AND (FS.DATA <= :pDataFinal) ');
    loQryFuncionarioSituacao.SQL.Add('AND ((FS.DATAFIN IS NULL) OR (FS.DATAFIN >= :pDataFinal)) ');
    loQryFuncionarioSituacao.SQL.Add('AND (FSC.CODIGO = :pTpCdFgtsMaternidade)');
//    loQryFuncionarioSituacao.ParamByName('pIdFuncionario'      ).AsString  := Self.FIdColaborador;
    loQryFuncionarioSituacao.ParamByName('pIdsFuncionarios'    ).AsString  := Self.FoCdsColaboradores.FieldByName('R_IDS').AsString;
    loQryFuncionarioSituacao.ParamByName('pDataFinal'          ).AsDate    := Self.FOwner.FOwner.FCompetencia;
    loQryFuncionarioSituacao.ParamByName('pTpCdFgtsMaternidade').AsInteger := TP_CD_FGTS_MATERNIDADE;
    loQryFuncionarioSituacao.Open;

    if (not loQryFuncionarioSituacao.IsEmpty) then begin
      Result := true;
    end;
  finally
    FreeAndNil(loQryFuncionarioSituacao);
  end;
end;

{ TEmpresa }

constructor TEmpresa.Create(pOwner: TGfip; psInscMfPessoa: String;
      var pNGaugeColaborador: TEvGauge; var plblColaborador: TLabel);
var
  loQryEmpresa,loQrySomaGps: TSQLQuery;
  CheckDoc: TCheckDoc;
  lsIdPessoa,lsLinha10,lsLinha12,lsEndereco,lsFpas,lsTelefone,sTipoFolhaPagamento: String;
  liQtdeEventosDesportivos: Integer;
  lDataCalculo: TDate;
  loQryColaboradores: TSQLQuery;
  loDspColaboradores: TDataSetProvider;
  loCdsColaboradores: TClientDataSet;

begin
  FOwner              := pOwner;
  FListaColaboradores := TList.Create;
  FInscMf             := psInscMfPessoa;

  loQryEmpresa:= TSQLQuery.Create(nil);
  FoQryGps    := TSQLQuery.Create(nil);
  loQrySomaGps:= TSQLQuery.Create(nil);
  CheckDoc := TCheckDoc.Create(nil);
  loQryColaboradores := TSQLQuery.Create(nil);
  loDspColaboradores := TDataSetProvider.Create(Application); {Com parâmetro nil dá erro.}
  loCdsColaboradores := TClientDataSet  .Create(Application); {Com parâmetro nil dá erro.}
  try
    loQryEmpresa.SQLConnection := TUtil.getConn;
    loQryEmpresa.SQL.Add('SELECT ID_PESSOA FROM PESSOA P WHERE (P.INSCMF = :pInscMfPessoa)');
    loQryEmpresa.ParamByName('pInscMfPessoa').AsString := psInscMfPessoa;
    loQryEmpresa.Open;
    lsIdPessoa := loQryEmpresa.FieldByName('ID_PESSOA').AsString;

    loQryEmpresa.Close;
    loQryEmpresa.SQL.Clear;
    loQryEmpresa.SQL.Add('SELECT PD.R_P_ID_PESSOA AS ID_PESSOA, PD.R_P_NOME AS NOME,PD.R_P_INSCMF AS INSCMF,PD.R_PP_CONTATO AS PESSOA_CONTATO,PD.R_TPLP_SIGLA AS TIPO_LOGRADOURO,');
    loQryEmpresa.SQL.Add('PD.R_P_LOGRADOURO AS LOGRADOURO,PD.R_P_NUMERO AS NUMERO,PD.R_P_COMPLEMENTO AS COMPLEMENTO,');
    loQryEmpresa.SQL.Add('PD.R_P_BAIRRO AS BAIRRO,PD.R_PCID_DESCRICAO AS CIDADE,PD.R_PEST_SIGLA AS UF,PD.R_P_CEP AS CEP,');
    loQryEmpresa.SQL.Add('PD.R_TEL_NUMERO AS TELEFONE,PD.R_EMAIL_ENDERECO AS EMAIL,PD.R_P_INSCMF AS INSCMF,R_C_CODIGO AS CNAE,');
    loQryEmpresa.SQL.Add('PD.R_PFP_CODIGO AS FPAS,PD.R_PCT_CODIGO AS CODIGO_TERCEIROS,PD.R_PPH_PERCENTUAL_ISENCAO AS PERCENTUAL_ISENCAO,');
    loQryEmpresa.SQL.Add('PD.R_REGFE_TIPO REGIME_FEDERAL,PD.R_C_ALIQUOTA_RAT AS ALIQUOTA_RAT, R_CA_ANEXO_SIMPLES AS ANEXO_SIMPLES ');
    loQryEmpresa.SQL.Add('FROM SP_PESSOA_DADOS(:pData,:pIdEmpresa) PD');
    loQryEmpresa.ParamByName('pData'     ).AsDate   := Self.FOwner.FCompetencia;
    loQryEmpresa.ParamByName('pIdEmpresa').AsString := lsIdPessoa;
    loQryEmpresa.Open;
    FIdPessoa      := loQryEmpresa.FieldByName('ID_PESSOA'     ).AsString;
    FRegimeFederal := loQryEmpresa.FieldByName('REGIME_FEDERAL').AsInteger;

    loCdsColaboradores.Close;
    loDspColaboradores.DataSet := loQryColaboradores;
    loDspColaboradores.UpdateMode := upWhereKeyOnly;
    loDspColaboradores.Name := 'loDspColaboradores';
    loCdsColaboradores.ProviderName := loDspColaboradores.Name;
    loQryColaboradores.SQLConnection := TUtil.getConn;
//    loQryColaboradores.SQL.Add('SELECT * FROM SP_PCOLABORADORES_DADOS_SEFIP(:pIdPessoa,:pDataInicial,:pDataFinal,:pObraPropria,:pGps13,:pTipoRecolhimento) S WHERE ');
//    loQryColaboradores.SQL.Add('(((ABS(S.R_REMUNERACAO)+ABS(S.R_REMUNERACAO13)+ABS(S.R_BASE_PREVIDENCIA_ACIDENTE)) > 0) AND (:pGps13 = 0)) ');
//    loQryColaboradores.SQL.Add('OR ((S.R_13_MOVIMENTO > 0) AND (:pGps13 = -1)) OR (R_SAIDA_RETORNO_AFASTAMENTO = -1) ');
    loQryColaboradores.SQL.Clear;
    if (pOwner.FeTipoRecolhimentoSefip = TTipoRecolhimentoSefip.trs_somente_diferencas_650) then begin
      loQryColaboradores.SQL.Assign(dmInformacoesSefip.qryColaboradoresSefip650.SQL);
    end else begin
      loQryColaboradores.SQL.Assign(dmInformacoesSefip.qryColaboradores.SQL);
    end;

    if not Self.FOwner.FCompetencia13 then begin
      if (pOwner.FeTipoRecolhimentoSefip = TTipoRecolhimentoSefip.trs_somente_diferencas_650) then begin
        loQryColaboradores.ParamByName('pDataInicial').AsDate := BeginOfMonth(FOwner.FdDataInicial);
        loQryColaboradores.ParamByName('pDataFinal'  ).AsDate := EndOfMonth  (FOwner.FdDataFinal  );
      end else begin
        loQryColaboradores.ParamByName('pDataInicial').AsDate := BeginOfMonth(Self.FOwner.FCompetencia);
        loQryColaboradores.ParamByName('pDataFinal'  ).AsDate := EndOfMonth  (Self.FOwner.FCompetencia);
      end;
    end else begin
      loQryColaboradores.ParamByName('pDataInicial').AsDate := BeginOfMonth(FOwner.FCompetencia);
      loQryColaboradores.ParamByName('pDataFinal'  ).AsDate := BeginOfMonth(FOwner.FCompetencia)+19;
    end;
    loQryColaboradores.ParamByName('pIdPessoa'        ).AsString := lsIdPessoa;
    loQryColaboradores.ParamByName('pGps13'           ).AsInteger := BooleanToInt(Self.FOwner.FCompetencia13);
    loQryColaboradores.ParamByName('pObraPropria'     ).AsInteger := BooleanToInt(Self.FOwner.FObraPropria);
    loQryColaboradores.ParamByName('pTipoRecolhimento').AsInteger := Ord(Self.FOwner.FeTipoRecolhimentoSefip);
    loCdsColaboradores.Open;
    loCdsColaboradores.Last;

    if (pOwner.FeTipoRecolhimentoSefip <> TTipoRecolhimentoSefip.trs_somente_diferencas_650)
      and (Trim(fSoNumeros(loCdsColaboradores.FieldByName('R_INSCMF_TOMADOR').AsString)) <> '')
    then begin
      Self.FOwner.FTemTomador := True;
    end;
    loCdsColaboradores.First;

    if (pOwner.FeTipoRecolhimentoSefip = TTipoRecolhimentoSefip.trs_somente_diferencas_650) then begin
      Self.FOwner.FCodigoRecolhimentoGfip := '650';
    end else if Self.FOwner.FObraPropria then begin
      Self.FOwner.FCodigoRecolhimentoGfip := '155';
    end else if Self.FOwner.FTemTomador then begin
      Self.FOwner.FCodigoRecolhimentoGfip := '150';
    end else begin
      Self.FOwner.FCodigoRecolhimentoGfip := '115';
    end;

    if not pOwner.FCompetencia13 then begin
      lDataCalculo := fVerificaCalculo(TP_EMPRESA,TP_FOLHA_MENSAL,TP_BUSCA_DATA_EXATA,FIdPessoa,FOwner.FCompetencia,false,false);
      sTipoFolhaPagamento := 'folha de pagamento';
    end else begin
      lDataCalculo := fVerificaCalculo(TP_EMPRESA,TP_13_SALARIO,TP_BUSCA_DATA_EXATA,FIdPessoa,StrToDate('20'+copy(DateToStr(FOwner.FCompetencia),3,8)),false,false);
      lDataCalculo := EndOfMonth(lDataCalculo);
      sTipoFolhaPagamento := 'folha de pagamento do 13o. salário';
    end;
    if lDataCalculo < FOwner.FCompetencia then begin
      pOwner.FInconsistencias.Add('CNPJ/CEI: '+psInscMfPessoa+'-'+trim(loQryEmpresa.FieldByName('NOME').AsString)+', MOTIVO: A '+sTipoFolhaPagamento+' dessa empresa ainda não foi calculada.');
      pOwner.FInconsistencias.Add(' ');
    end else begin
      loQrySomaGps.SQLConnection := TUtil.getConn;
      loQrySomaGps.SQL.Add('SELECT sum(G.BASE_COOPERATIVAS) AS BASE_COOPERATIVAS,');
      loQrySomaGps.SQL.Add('sum(G.BASE_COMERCIALIZACAO_PROD_PF) AS BASE_COMERCIALIZACAO_PROD_PF,');
      loQrySomaGps.SQL.Add('sum(G.BASE_COMERCIALIZACAO_PROD_PJ) AS BASE_COMERCIALIZACAO_PROD_PJ,');
      loQrySomaGps.SQL.Add('sum(G.BASE_EVENTO_DESPORTIVO) AS BASE_EVENTO_DESPORTIVO ');
      loQrySomaGps.SQL.Add('FROM PGPS G ');
      loQrySomaGps.SQL.Add('WHERE (G.FK_PESSOA = :pIdPessoa) ');
      loQrySomaGps.SQL.Add('AND (G.DATA BETWEEN :pDataInicial AND :pDataFinal) ');
      loQrySomaGps.SQL.Add('AND (G.TP_CALCULO = :pTpCalculo)');
      loQrySomaGps.ParamByName('pIdPessoa'   ).AsString := lsIdPessoa;
      loQrySomaGps.ParamByName('pDataInicial').AsDate   := BeginOfMonth(pOwner.FCompetencia);
      loQrySomaGps.ParamByName('pDataFinal'  ).AsDate   := pOwner.FCompetencia;
      if not pOwner.FCompetencia13 then begin
        loQrySomaGps.ParamByName('pTpCalculo').AsInteger:= TP_FOLHA_MENSAL;
      end else begin
        loQrySomaGps.ParamByName('pTpCalculo').AsInteger:= TP_13_SALARIO;
      end;
      loQrySomaGps.Open;
      FComProducaoPessoaFisica  := loQrySomaGps.FieldByName('BASE_COMERCIALIZACAO_PROD_PF').AsCurrency;
      FComProducaoPessoaJuridica:= loQrySomaGps.FieldByName('BASE_COMERCIALIZACAO_PROD_PJ').AsCurrency;

      loQrySomaGps.Close;
      loQrySomaGps.SQL.Clear;
      loQrySomaGps.SQL.Add('SELECT GED.ORIGEM,SUM(GED.VALOR) AS VALOR FROM PGPS_EVENTO_DESPORTIVO GED WHERE (GED.FK_PESSOA = :pIdPessoa) AND (GED.DATA BETWEEN :pDataInicial AND :pDataFinal) GROUP BY GED.ORIGEM');
      loQrySomaGps.ParamByName('pIdPessoa'   ).AsString := lsIdPessoa;
      loQrySomaGps.ParamByName('pDataInicial').AsDate   := BeginOfMonth(pOwner.FCompetencia);
      loQrySomaGps.ParamByName('pDataFinal'  ).AsDate   := pOwner.FCompetencia;
      loQrySomaGps.Open;
      liQtdeEventosDesportivos := 0;
      FReceitaEventoDesportivo := 0;
      while not loQrySomaGps.Eof do begin
        inc(liQtdeEventosDesportivos);
        FReceitaEventoDesportivo       := FReceitaEventoDesportivo+loQrySomaGps.FieldByName('VALOR').AsCurrency;
        FOrigemReceitaEventoDesportivo := loQrySomaGps.FieldByName('ORIGEM').AsString;
        loQrySomaGps.Next;
      end;
      {liQtdeEventosDesportivos for igual a 1, FOrigemReceitaEventoDesportivo
       já recebeu a atribuição dentro do loop acima}
      if liQtdeEventosDesportivos < 1 then begin
        FOrigemReceitaEventoDesportivo := ' ';
      end else if liQtdeEventosDesportivos > 1 then begin
        FOrigemReceitaEventoDesportivo := 'A';
      end;

      FoQryGps.SQLConnection := TUtil.getConn;
      FoQryGps.Close;
      FoQryGps.SQL.Clear;
      FoQryGps.SQL.Add('SELECT G.TP_CALCULO,G.DESCONTO_EMPREGADOS,G.DESCONTO_SOCIOS_AUTONOMOS,G.EMP_EMPREGADOS,');
      FoQryGps.SQL.Add('G.EMP_SOCIOS_AUTONOMOS,G.EMP_RAT,G.EMP_RAT_AGENTES_NOCIVOS,G.EMP_COOPERATIVAS,');
      FoQryGps.SQL.Add('G.EMP_COMERCIALIZACAO_PROD_PF,G.EMP_COMERCIALIZACAO_PROD_PJ,G.EMP_EVENTO_DESP_PATROCINIO,');
      FoQryGps.SQL.Add('G.SALARIO_FAMILIA,G.SALARIO_MATERNIDADE,G.SALARIO_MATERNIDADE_13,G.OUTRAS_ENTIDADES,T.INSCMF AS INSCMF_TOMADOR,T.EMPREITADA_TOTAL_OBRA_PROPRIA ' );
      FoQryGps.SQL.Add('FROM PGPS G ');
      FoQryGps.SQL.Add('LEFT JOIN PLOCAIS L ON (G.FK_LOCAL = L.ID_PLOCAIS) ');
      FoQryGps.SQL.Add('LEFT JOIN PTOMADORES T ON (L.FK_PTOMADOR = T.ID_PTOMADORES) ');
      FoQryGps.SQL.Add('WHERE (G.FK_PESSOA = :pIdPessoa) AND (G.DATA BETWEEN :pDataInicial AND :pDataFinal)');
      FoQryGps.ParamByName('pIdPessoa'   ).AsString := lsIdPessoa;
      FoQryGps.ParamByName('pDataInicial').AsDate   := BeginOfMonth(Self.FOwner.FCompetencia);
      FoQryGps.ParamByName('pDataFinal'  ).AsDate   := EndOfMonth(Self.FOwner.FCompetencia);
      FoQryGps.Open;

      FNome := loQryEmpresa.FieldByName('NOME').AsString;
      CheckDoc.Mode  := moAutoDetect;
      CheckDoc.Input := psInscMfPessoa;
      if CheckDoc.ModeResult = moCGC then begin
        FTipoInscMf := '1';
      end else if CheckDoc.ModeResult = moCEI then begin
        FTipoInscMf := '2';
      end else if CheckDoc.ModeResult = moCPF then begin
        FTipoInscMf := '3';
        FOwner.FInconsistencias.Add('Empresa CPF: '+psInscMfPessoa+'-'+trim(FNome)+'. Motivo: Empresa não pode ser inscrita no CPF.');
        FOwner.FInconsistencias.Add(' ');
      end;

      if Self.FOwner.FObraPropria then begin
        lsFpas := '507';
      end else begin
        lsFpas := StrZero(loQryEmpresa.FieldByName('FPAS').AsInteger,3,0);
      end;
      lsEndereco := trim(loQryEmpresa.FieldByName('TIPO_LOGRADOURO').AsString);
      lsEndereco := lsEndereco+' '+trim(loQryEmpresa.FieldByName('LOGRADOURO').AsString);
      lsEndereco := lsEndereco+' '+trim(loQryEmpresa.FieldByName('NUMERO').AsString);
      lsEndereco := lsEndereco+' '+trim(loQryEmpresa.FieldByName('COMPLEMENTO').AsString);
      lsEndereco := Valid_Caracter(StrSubst(lsEndereco,'  ',' ',0),false);

      {Determina o código de pagamento da GPS para a empresa}
      if (FOwner.FeTipoRecolhimentoSefip = TTipoRecolhimentoSefip.trs_somente_diferencas_650) then begin
        FCodigoGPS := '2950';
      end else if lsFpas = IntToStr(TP_FPAS_868_EMPREGADOR_DOMESTICO) then begin
        {Empregador Doméstico}
        FCodigoGPS := '1600';
      end else if lsFpas = IntToStr(TP_FPAS_582_ORGAO_PUBLICO) then begin
        {Orgãos Públicos}
        FCodigoGPS := '2402';
      end else if lsFpas = IntToStr(TP_FPAS_639_ENTIDADE_BENEFICENTE) then begin
        {Entidades Beneficientes de assistência social}
        FCodigoGPS := '2305';
      end else if (FRegimeFederal = TP_REGIME_FEDERAL_SIMPLES_NACIONAL)
        and (loQryEmpresa.FieldByName('ANEXO_SIMPLES').AsInteger = 4)
      then begin
        {Empresa enquadrada no Anexo IV do Simples Nacional, ou enquadradas em
        qualquer anexo do Simples Nacional e obra própria recolhe o INSS como
        se fosse empresa normal.}
        FCodigoGPS := '2100';
      end else if (FTipoInscMf = '2') then begin
        {Inscritas no CEI}
        FCodigoGPS := '2208';
      end else if (FRegimeFederal = TP_REGIME_FEDERAL_SIMPLES_NACIONAL) then begin
        {Inscritas no Simples Nacional.}
        FCodigoGPS := '2003';
      end else begin
        {Demais empresas.}
        FCodigoGPS := '2100';
      end;

      lsLinha10 := '10';
      lsLinha10 := lsLinha10+FTipoInscMf;
      lsLinha10 := lsLinha10+StrZero(StrToInt64(fSoNumeros(FInscMf)),14,0);
      lsLinha10 := lsLinha10+StrZero(0,36,0);
      lsLinha10 := lsLinha10+Valid_Caracter(StrLPad(Copy(loQryEmpresa.FieldByName('NOME').AsString,1,40),40),false);
      lsLinha10 := lsLinha10+Valid_Caracter(StrLPad(Copy(lsEndereco,1,50),50),false);
      lsLinha10 := lsLinha10+Valid_Caracter(StrLPad(Copy(loQryEmpresa.FieldByName('BAIRRO').AsString,1,20),20),false);
      lsLinha10 := lsLinha10+fSoNumeros(loQryEmpresa.FieldByName('CEP').AsString);
      lsLinha10 := lsLinha10+Valid_Caracter(StrLPad(Copy(loQryEmpresa.FieldByName('CIDADE').AsString,1,20),20),false);
      lsLinha10 := lsLinha10+loQryEmpresa.FieldByName('UF').AsString;
      lsTelefone := FSoNumeros(loQryEmpresa.FieldByName('TELEFONE').AsString);
      lsTelefone := Trim(Copy(lsTelefone,1,2)+StrSpace(2)+Copy(lsTelefone,3,length(lsTelefone)-2));

      if Length(lsTelefone) = 12 then begin
        lsLinha10 := lsLinha10+StrLPad(Copy(lsTelefone,1,12),12);
      end else if Length(lsTelefone) = 13 then begin
        pOwner.FInconsistencias.Add('Empresa: '+psInscMfPessoa+'-'+trim(FNome)+'. Motivo: O telefone casdastrado para a empresa contém um dígito a mais.');
      end else begin
        pOwner.FInconsistencias.Add('Empresa: '+psInscMfPessoa+'-'+trim(FNome)+'. Motivo: Falta telefone principal no cadastro da empresa.');
      end;
      {Indicador de alteração de endereço.}
      if Self.FOwner.FCompetencia13 then begin
        lsLinha10 := lsLinha10+'N';
      end else begin
        lsLinha10 := lsLinha10+'S';
      end;

      if trim(fSoNumeros(loQryEmpresa.FieldByName('CNAE').AsString)) = '' then begin
        Self.FOwner.FInconsistencias.Add('-Empresa: '+trim(FNome)+'-'+FInscMf+'- Falta informar o CNAE no cadastro da empresa.');
        Self.FOwner.FInconsistencias.Add(' ');
        lsLinha10 := lsLinha10+StrSpace(7);
      end else begin
        lsLinha10 := lsLinha10+loQryEmpresa.FieldByName('CNAE').AsString;
      end;

      {Indicador de alteração de CNAE preponderante.}
      if (not FOwner.FCompetencia13)
        and (FOwner.FCompetencia > StrToDate('31/05/2008'))
      then begin
        lsLinha10 := lsLinha10+'A';
      end else begin
        lsLinha10 := lsLinha10+'N';
      end;


      if (pos(lsFpas,'604*647*825*833*868') > 0)
//        or (loQryEmpresa.FieldByName('REGIME_FEDERAL').AsInteger = TP_REGIME_FEDERAL_SIMPLES_NACIONAL)
//        or (loQryEmpresa.FieldByName('REGIME_FEDERAL').AsInteger = TP_REGIME_FEDERAL_NENHUM)
        or ((FRegimeFederal = TP_REGIME_FEDERAL_SIMPLES_NACIONAL) and (loQryEmpresa.FieldByName('ANEXO_SIMPLES').AsInteger <> 4) and (not pOwner.FObraPropria))
//        or (FRegimeFederal = TP_REGIME_FEDERAL_NENHUM)
      then begin
        {Se o FPAS for um dos elencados acima ou a empresa estiver enquadrada no
         Simples Nacional diferente de anexo 4, a alíquota do RAT é zero.}
        lsLinha10 := lsLinha10+'00';
      end else if  ((FRegimeFederal = TP_REGIME_FEDERAL_SIMPLES_NACIONAL) and (pOwner.FObraPropria)) then begin
        {Se estiver enquadrada no Simples Nacional e for Obra Própria, calcula o
        RAT a 3%}
        lsLinha10 := lsLinha10+MyCurrToStr(3,2,1,false);
      end else begin
        lsLinha10 := lsLinha10+MyCurrToStr(loQryEmpresa.FieldByName('ALIQUOTA_RAT').AsCurrency,2,1,false);
      end;
      {Código de Centralização}
      lsLinha10 := lsLinha10+'0';
      if (pos(lsFpas,'582*639*663*671*680*736*868') > 0)
        or ((FRegimeFederal = TP_REGIME_FEDERAL_SIMPLES_NACIONAL)
        and ((loQryEmpresa.FieldByName('ANEXO_SIMPLES').AsInteger = 4)
        or (pOwner.FObraPropria)))
      then begin
        {Empresas que estão enquadradas nos códigos FPAS acima não podem
         se enquadrar no Simples Nacional. E empresas enquadradas no Anexo IV do
         Simples Nacional ou tributadas pelo Simples Nacional e obra própia,
         também deve informar como não optante.
         Instrução Normativa RFB nº 925, de 6 de março de 2009, Art. 4o.
         http://www.receita.fazenda.gov.br/legislacao/ins/2009/in9252009.htm}
        lsLinha10 := lsLinha10+'1';
      end else if (FRegimeFederal = TP_REGIME_FEDERAL_SIMPLES_NACIONAL) then begin
        {Empresa optante pelo Simples Nacional}
        lsLinha10 := lsLinha10+'2';
      end else begin
        {Empresa Não optante pelo Simples Nacional}
        lsLinha10 := lsLinha10+'1';
      end;
      lsLinha10 := lsLinha10+lsFpas;
      if Pos(lsFpas,'582*868') > 0 then begin {582=Entidades sem fins lucrativos, 868=Empregador doméstico}
        lsLinha10 := lsLinha10+StrZero(0,4,0); {Código de outras entidades (Terceiros)}
      end else if ((FRegimeFederal = TP_REGIME_FEDERAL_SIMPLES_NACIONAL)
        and ((loQryEmpresa.FieldByName('ANEXO_SIMPLES').AsInteger = 4)
        or (pOwner.FObraPropria)))
      then begin
        {Empresa enquadrada no Anexo IV do Simples Nacional ou Tributadas pelo
        Simples Nacional e obra própria, recolhe o INSS como se fosse empresa
        normal.}
        lsLinha10 := lsLinha10+StrZero(loQryEmpresa.FieldByName('CODIGO_TERCEIROS').AsInteger,4,0); {Código de outras entidades (Terceiros)}
      end else if (FRegimeFederal = TP_REGIME_FEDERAL_SIMPLES_NACIONAL) then begin
        if (loQryEmpresa.FieldByName('CODIGO_TERCEIROS').AsInteger <> 0) then begin
          Self.FOwner.FInconsistencias.Add('-Empresa: '+trim(FNome)+'-'+FInscMf+'- O código de terceiros para empresas enquandradas no Simples Nacional deve ser zero.');
          Self.FOwner.FInconsistencias.Add(' ');
        end;
        lsLinha10 := lsLinha10+StrSpace(4); {Código de outras entidades (Terceiros)}
      end else begin
        lsLinha10 := lsLinha10+StrZero(loQryEmpresa.FieldByName('CODIGO_TERCEIROS').AsInteger,4,0); {Código de outras entidades (Terceiros)}
      end;
      if pos(Self.FOwner.FCodigoRecolhimentoGfip,'115*150*211*650') > 0 then begin
        {O código de recolhimento da GPS só pode ser informado para os códigos de
         recolhimento da GFIP acima.
         O código 155 informa no registro 20.}
        lsLinha10 := lsLinha10+FCodigoGPS;
      end else begin
        lsLinha10 := lsLinha10+StrSpace(4);
      end;
      if lsFpas = IntToStr(TP_FPAS_639_ENTIDADE_BENEFICENTE) then begin
        {Só pode ser informado para entidades beneficientes de assistência social.}
        lsLinha10 := lsLinha10+MyCurrToStr(loQryEmpresa.FieldByName('PERCENTUAL_ISENCAO').AsCurrency,5,2,false);
      end else begin
        lsLinha10 := lsLinha10+StrZero(0,5,0);
      end;
      if (pos(Self.FOwner.FCodigoRecolhimentoGfip,'115*211') > 0) and (not Self.FOwner.FCompetencia13) and (lsFpas <> IntToStr(TP_FPAS_868_EMPREGADOR_DOMESTICO)) then begin
        lsLinha10 := lsLinha10+MyCurrToStr(getSalarioFamiliaPago(),15,2,false);
      end else begin
        lsLinha10 := lsLinha10+StrZero(0,15,0);
      end;
      if (pos(Self.FOwner.FCodigoRecolhimentoGfip,'115*150*155*608') > 0)
        and (not Self.FOwner.FCompetencia13) and (lsFpas <> IntToStr(TP_FPAS_868_EMPREGADOR_DOMESTICO)) then begin
        lsLinha10 := lsLinha10+MyCurrToStr(getMaternidadePago(),15,2,false);
      end else begin
        lsLinha10 := lsLinha10+StrZero(0,15,0);
      end;
      lsLinha10 := lsLinha10+StrZero(0,15,0);
      lsLinha10 := lsLinha10+'0';
      lsLinha10 := lsLinha10+StrZero(0,14,0);
      lsLinha10 := lsLinha10+StrSpace(3);
      lsLinha10 := lsLinha10+StrSpace(4);
      lsLinha10 := lsLinha10+StrSpace(9);
      lsLinha10 := lsLinha10+StrZero(0,45,0);
      lsLinha10 := lsLinha10+StrSpace(4);
      lsLinha10 := lsLinha10+'*';

      lsLinha12 := '12';
      lsLinha12 := lsLinha12+FTipoInscMf;
      lsLinha12 := lsLinha12+StrZero(StrToInt64(fSoNumeros(FInscMf)),14,0);
      lsLinha12 := lsLinha12+StrZero(0,36,0);
      if (pos(Self.FOwner.FCodigoRecolhimentoGfip,'115*150*155*608') > 0)
        and (not Self.FOwner.FCompetencia13) and (lsFpas <> IntToStr(TP_FPAS_868_EMPREGADOR_DOMESTICO))
      then begin
        lsLinha12 := lsLinha12+MyCurrToStr(get13MaternidadePago(),15,2,false);
        lsLinha12 := lsLinha12+MyCurrToStr(FReceitaEventoDesportivo,15,2,false);
        lsLinha12 := lsLinha12+FOrigemReceitaEventoDesportivo;
      end else begin
        lsLinha12 := lsLinha12+MyCurrToStr(get13MaternidadePago(),15,2,false);
        lsLinha12 := lsLinha12+StrZero(0,15,0);
        lsLinha12 := lsLinha12+StrSpace(1);
      end;
      lsLinha12 := lsLinha12+MyCurrToStr(FComProducaoPessoaFisica,15,2,false);
      lsLinha12 := lsLinha12+MyCurrToStr(FComProducaoPessoaJuridica,15,2,false);

      if (Self.FOwner.FCodigoRecolhimentoGfip <> '650') then begin
        lsLinha12 := lsLinha12+StrSpace(11);
        lsLinha12 := lsLinha12+StrSpace(4);
        lsLinha12 := lsLinha12+StrSpace(5);
        lsLinha12 := lsLinha12+StrSpace(6);
        lsLinha12 := lsLinha12+StrSpace(6);
      end else begin
        lsLinha12 := lsLinha12+StrLPad(FOwner.FsProcesso,11);
        lsLinha12 := lsLinha12+DateStr(FOwner.FCompetencia,dtsY);
        lsLinha12 := lsLinha12+StrLPad(FOwner.FsVara,5);
        lsLinha12 := lsLinha12+DateStr(pOwner.FdDataInicial,dtsYM);
        lsLinha12 := lsLinha12+DateStr(pOwner.FdDataFinal  ,dtsYM);
      end;
      if (Self.FOwner.FCodigoRecolhimentoGfip = '115') then begin
        lsLinha12 := lsLinha12+getDadosCompensacao('');
        lsLinha12 := lsLinha12+getRecCompetenciasAnteriores('');
      end else begin
        lsLinha12 := lsLinha12+StrZero(0,15,0);
        lsLinha12 := lsLinha12+StrSpace(6);
        lsLinha12 := lsLinha12+StrSpace(6);
        lsLinha12 := lsLinha12+StrZero(0,15,0);
        lsLinha12 := lsLinha12+StrZero(0,15,0);
        lsLinha12 := lsLinha12+StrZero(0,15,0);
        lsLinha12 := lsLinha12+StrZero(0,15,0);
        lsLinha12 := lsLinha12+StrZero(0,15,0);
      end;
      lsLinha12 := lsLinha12+StrZero(0,15,0);
      lsLinha12 := lsLinha12+StrZero(0,15,0);
      lsLinha12 := lsLinha12+StrZero(0,15,0);
      if (Self.FOwner.FCodigoRecolhimentoGfip = '115') then begin
        lsLinha12 := lsLinha12+MyCurrToStr(getValoresPagosCooperativas,15,2,false);
      end else begin
        lsLinha12 := lsLinha12+StrZero(0,15,0);
      end;
      lsLinha12 := lsLinha12+StrZero(0,45,0);
      lsLinha12 := lsLinha12+StrSpace(6);
      lsLinha12 := lsLinha12+'*';

      Self.FOwner.FoCdsSefip10.Insert;
      Self.FOwner.FoCdsSefip10.FieldByName('TIPO_INSCMF_EMPRESA').AsString := FTipoInscMf;
      Self.FOwner.FoCdsSefip10.FieldByName('INSCMF_EMPRESA'     ).AsString := FInscMf;
      Self.FOwner.FoCdsSefip10.FieldByName('NOME'               ).AsString := FNome;
      Self.FOwner.FoCdsSefip10.FieldByName('LINHA10'            ).AsString := lsLinha10;
      Self.FOwner.FoCdsSefip10.FieldByName('LINHA12'            ).AsString := lsLinha12;
      Self.FOwner.FoCdsSefip10.Post;
      PreencheListaColaboradores(lsIdPessoa,pNGaugeColaborador,plblColaborador,loCdsColaboradores);
    end;
  finally
    FreeAndNil(loQryColaboradores);
    FreeAndNil(loDspColaboradores);
    FreeAndNil(loCdsColaboradores);
    FreeAndNil(FoQryGps);
    FreeAndNil(loQrySomaGps);
    FreeAndNil(loQryEmpresa);
    FreeAndNil(CheckDoc);
  end;
end;

destructor TEmpresa.Destroy;
begin
  FreeAndNil(FListaColaboradores);
  inherited;
end;

procedure TEmpresa.PreencheListaColaboradores(lsIdPessoa: String;
  var NGaugeColaborador: TEvGauge; var lblColaborador: TLabel;
  poCdsColaboradores: TClientDataSet);
var
  loColaborador: TColaborador;
begin
  NGaugeColaborador.Progress := 0;
  NGaugeColaborador.MaxValue := poCdsColaboradores.RecordCount;
  while not poCdsColaboradores.Eof do begin
    {Atualiza o NGauge e Label do colaborador}
    NGaugeColaborador.Progress := poCdsColaboradores.RecNo;
    lblColaborador   .Caption  := poCdsColaboradores.FieldByName('R_NOME').AsString;
    Application.ProcessMessages;
    {Instância o Colaborador}
//    loColaborador := TColaborador.Create(Self,poCdsColaboradores.FieldByName('R_ID').AsString,NGaugeColaborador,lblColaborador,poCdsColaboradores);
    loColaborador := TColaborador.Create(Self,NGaugeColaborador,lblColaborador,poCdsColaboradores);
    {Adiciona a colaborador a lista de colaboradores}
    FListaColaboradores.Add(loColaborador);
    poCdsColaboradores.Next;
  end;
//  if (Self.FOwner.FeTipoRecolhimentoSefip <> TTipoRecolhimentoSefip.trs_somente_diferencas_650) then begin
    getLinhas20();
//  end;
end;

//function TEmpresa.getInscMfTomador(): String;
//begin
//  { TODO -cURGENTE : Implementar }
//end;

function TEmpresa.getSalarioFamiliaPago(): Currency;
begin
  {De acordo com campo 22 do registro 10}
  Result := TP_ZERO;
  Self.FoQryGps.First;
  while not Self.FoQryGps.Eof do begin
    Result := Result+Self.FoQryGps.FieldByName('SALARIO_FAMILIA').AsCurrency;
    Self.FoQryGps.Next;
  end;
end;

function TEmpresa.getSalarioFamiliaPago(psIdTomador: String): Currency;
var
  loQrySalarioFamilia: TSQLQuery;
begin
  Result := TP_ZERO;
  loQrySalarioFamilia := TSQLQuery.Create(nil);
  try
    loQrySalarioFamilia.SQLConnection := TUtil.getConn;
    loQrySalarioFamilia.Close;
    loQrySalarioFamilia.SQL.Clear;
    loQrySalarioFamilia.SQL.Add('SELECT sum(G.SALARIO_FAMILIA) AS SALARIO_FAMILIA FROM PTOMADORES T ');
    loQrySalarioFamilia.SQL.Add('LEFT JOIN PLOCAIS L ON (T.ID_PTOMADORES = L.FK_PTOMADOR) ');
    loQrySalarioFamilia.SQL.Add('LEFT JOIN PGPS G ON (L.ID_PLOCAIS = G.FK_LOCAL) ');
    loQrySalarioFamilia.SQL.Add('WHERE (T.ID_PTOMADORES = :psIdTomador) ');
    loQrySalarioFamilia.SQL.Add('AND (G.DATA = :pData)');
    loQrySalarioFamilia.ParamByName('psIdTomador').AsString := psIdTomador;
    loQrySalarioFamilia.ParamByName('pData'      ).AsDate   := Self.FOwner.FCompetencia;
    loQrySalarioFamilia.Open;
    if not loQrySalarioFamilia.IsEmpty then begin
      Result := loQrySalarioFamilia.FieldByName('SALARIO_FAMILIA').AsCurrency;
    end;
  finally
    FreeAndNil(loQrySalarioFamilia);
  end;
end;

function TEmpresa.getMaternidadePago: Currency;
begin
  Result := TP_ZERO;
  {De acordo com o campo 23 do registro 10}
  Self.FoQryGps.First;
  while not Self.FoQryGps.Eof do begin
    if (Self.FoQryGps.FieldByName('SALARIO_MATERNIDADE').AsCurrency > 0)
      and ((Self.FOwner.FCodigoRecolhimentoGfip = '115')
      or ((Self.FoQryGps.FieldByName('INSCMF_TOMADOR').AsString = Self.FInscMf)
      and (IntToBoolean(Self.FoQryGps.FieldByName('EMPREITADA_TOTAL_OBRA_PROPRIA').AsInteger) = Self.FOwner.FObraPropria)))
    then begin
      Result := Result+Self.FoQryGps.FieldByName('SALARIO_MATERNIDADE').AsCurrency;
    end;
    Self.FoQryGps.Next;
  end;
end;

function TEmpresa.get13MaternidadePago: Currency;
begin
  Result := TP_ZERO;
  {De acordo com o campo 5 do registro 12}
  Self.FoQryGps.First;
  while not Self.FoQryGps.Eof do begin
    if (((Self.FOwner.FCompetencia13)
      and (Self.FoQryGps.FieldByName('TP_CALCULO').AsInteger = TP_13_SALARIO))
      or ((not Self.FOwner.FCompetencia13)
      and (Self.FoQryGps.FieldByName('TP_CALCULO').AsInteger <> TP_13_SALARIO)))
      and (Self.FoQryGps.FieldByName('SALARIO_MATERNIDADE_13').AsCurrency > 0)
      and ((Self.FOwner.FCodigoRecolhimentoGfip = '115')
      or ((Self.FoQryGps.FieldByName('INSCMF_TOMADOR').AsString = Self.FInscMf)
      and (IntToBoolean(Self.FoQryGps.FieldByName('EMPREITADA_TOTAL_OBRA_PROPRIA').AsInteger) = Self.FOwner.FObraPropria)))
    then begin
      Result := Result+Self.FoQryGps.FieldByName('SALARIO_MATERNIDADE_13').AsCurrency;
    end;
    Self.FoQryGps.Next;
  end;
end;

function TEmpresa.getDadosCompensacao(psInscMfTomador: String): String;
var
  loQryCompensacao: TSQLQuery;
  ldblValor: Currency;
begin
  Result := '';
  {De acordo com dos campos 15 a 17 do Registro 12
   ou 7 a 9 do Registro 21, e retornando tudo numa só string com tamnho 27}
  loQryCompensacao := TSQLQuery.Create(nil);
  try
    loQryCompensacao.SQLConnection := TUtil.getConn;
    loQryCompensacao.SQL.Add('SELECT FIRST 1 T.INSCMF,GC.DATA_INICIAL,GC.DATA_FINAL,GC.VALOR,GC.TP_CALCULO FROM PGPS_COMPENSACAO GC ');
    loQryCompensacao.SQL.Add('LEFT JOIN PLOCAIS L ON (GC.FK_LOCAL = L.ID_PLOCAIS) ');
    loQryCompensacao.SQL.Add('LEFT JOIN PTOMADORES T ON (L.FK_PTOMADOR = T.ID_PTOMADORES) ');
    loQryCompensacao.SQL.Add('WHERE (GC.FK_PESSOA = :pIdPessoa) AND (GC.DATA BETWEEN :pDataInicial AND :pDataFinal) AND (GC.TP_CALCULO = :pTpCalculo) ');
    if (FOwner.FCodigoRecolhimentoGfip = '115') then begin
      loQryCompensacao.SQL.Add('AND (T.INSCMF IS NULL) ORDER BY GC.DATA_INICIAL ');
    end else begin {FOwner.FCodigoRecolhimentoGfip = '150' ou '155'}
      loQryCompensacao.SQL.Add('AND (T.INSCMF = :pInscMfTomador) ORDER BY GC.DATA_INICIAL');
      loQryCompensacao.ParamByName('pInscMfTomador').AsString := psInscMfTomador;
    end;
    loQryCompensacao.ParamByName('pIdPessoa').AsString := FIdPessoa;
    loQryCompensacao.ParamByName('pDataInicial').AsDate := BeginOfMonth(FOwner.FCompetencia);
    loQryCompensacao.ParamByName('pDataFinal').AsDate := FOwner.FCompetencia;
    if not FOwner.FCompetencia13 then begin
      loQryCompensacao.ParamByName('pTpCalculo').AsInteger := TP_FOLHA_MENSAL;
    end else begin
      loQryCompensacao.ParamByName('pTpCalculo').AsInteger := TP_13_SALARIO;
    end;
    loQryCompensacao.Open;
    ldblValor := TP_ZERO;
//    while not loQryCompensacao.Eof do begin
      if (loQryCompensacao.FieldByName('VALOR').AsCurrency > 0) then begin
        ldblValor := ldblValor+loQryCompensacao.FieldByName('VALOR').AsCurrency;
      end;
//      loQryCompensacao.Next;
//    end;
    if (ldblValor > 0) then begin
      Result := MyCurrToStr(ldblValor,15,2,false);
      Result := Result+DateStr(loQryCompensacao.FieldByName('DATA_INICIAL').AsDateTime,dtsYM);
      Result := Result+DateStr(loQryCompensacao.FieldByName('DATA_FINAL'  ).AsDateTime,dtsYM);
    end else begin
      Result := StrZero(0,15,0);
      Result := Result+StrSpace(6);
      Result := Result+StrSpace(6);
    end;
  finally
    FreeAndNil(loQryCompensacao)
  end;
end;

function TEmpresa.getRecCompetenciasAnteriores(psInscMfTomador: String): String;
var
  loQryCompAnteriores: TSQLQuery;
  ldblInssAntPrincipal,ldblOutrasAntPrincipal,ldblInssAnt744,ldblOutrasAnt744,
  ldblInssAnt779: Currency;
begin
  Result := '';
  {De acordo com dos campos 18 a 22 do registro 12
  ou 10 a 11 do registro 21, e retornando tudo numa
  só string com tamnho 75 para o registro 12 ou
  30 para o registro 30}
  loQryCompAnteriores := TSQLQuery.Create(nil);
  try
    loQryCompAnteriores.SQLConnection := TUtil.getConn;
    loQryCompAnteriores.SQL.Add('SELECT F.CODIGO AS CODIGO_FPAS,G.VL_PENDENTE_INSS,G.VL_PENDENTE_OUTRAS_ENTIDADES,T.INSCMF ');
    loQryCompAnteriores.SQL.Add('FROM PGPS G ');
    loQryCompAnteriores.SQL.Add('LEFT JOIN PGPS G1 ON (G.FK_GPS_REC_PENDENTE = G1.ID_PGPS) ');
    loQryCompAnteriores.SQL.Add('LEFT JOIN PFPAS F ON (G.FK_FPAS = F.ID_PFPAS) ');
    loQryCompAnteriores.SQL.Add('LEFT JOIN PLOCAIS L ON (G.FK_LOCAL = L.ID_PLOCAIS) ');
    loQryCompAnteriores.SQL.Add('LEFT JOIN PTOMADORES T ON (L.FK_PTOMADOR = T.ID_PTOMADORES) ');
    loQryCompAnteriores.SQL.Add('WHERE (G.FK_PESSOA = :pIdPessoa) AND (G1.DATA BETWEEN :pDataInicial AND :pDataFinal) ');
    if (FOwner.FCodigoRecolhimentoGfip = '115') then begin
      loQryCompAnteriores.SQL.Add('AND (T.INSCMF IS NULL)');
    end else begin {FOwner.FCodigoRecolhimentoGfip = '150' ou '155'}
      loQryCompAnteriores.SQL.Add('AND (T.INSCMF = :pIdInscMfTomador)');
      loQryCompAnteriores.ParamByName('pIdInscMfTomador').AsString := psInscMfTomador;
    end;
    loQryCompAnteriores.ParamByName('pIdPessoa').AsString := FIdPessoa;
    loQryCompAnteriores.ParamByName('pDataInicial').AsDate := BeginOfMonth(FOwner.FCompetencia);
    loQryCompAnteriores.ParamByName('pDataFinal').AsDate := FOwner.FCompetencia;
    loQryCompAnteriores.Open;

    ldblInssAntPrincipal := 0;
    ldblOutrasAntPrincipal := 0;
    ldblInssAnt744 := 0;
    ldblOutrasAnt744 := 0;
    ldblInssAnt779 := 0;
    while not loQryCompAnteriores.Eof do begin
      if (loQryCompAnteriores.FieldByName('CODIGO_FPAS').AsInteger = TP_FPAS_744_CONTR_SOBRE_PROD_RURAL) then begin
        ldblInssAnt744   := ldblInssAnt744  +loQryCompAnteriores.FieldByName('VL_PENDENTE_INSS'            ).AsCurrency;
        ldblOutrasAnt744 := ldblOutrasAnt744+loQryCompAnteriores.FieldByName('VL_PENDENTE_OUTRAS_ENTIDADES').AsCurrency;
      end else if (loQryCompAnteriores.FieldByName('CODIGO_FPAS').AsInteger = TP_FPAS_779_EQUIPE_FUTEBOL) then begin
        ldblInssAnt779   := ldblInssAnt779  +loQryCompAnteriores.FieldByName('VL_PENDENTE_INSS'            ).AsCurrency;
      end else begin
        ldblInssAntPrincipal   := ldblInssAntPrincipal  +loQryCompAnteriores.FieldByName('VL_PENDENTE_INSS'            ).AsCurrency;
        ldblOutrasAntPrincipal := ldblOutrasAntPrincipal+loQryCompAnteriores.FieldByName('VL_PENDENTE_OUTRAS_ENTIDADES').AsCurrency;
      end;
      loQryCompAnteriores.Next;
    end;

    if (FOwner.FCodigoRecolhimentoGfip = '115') then begin
      Result := MyCurrToStr(ldblInssAntPrincipal,15,2,false);
      Result := Result+MyCurrToStr(ldblOutrasAntPrincipal,15,2,false);
      Result := Result+MyCurrToStr(ldblInssAnt744,15,2,false);
      Result := Result+MyCurrToStr(ldblOutrasAnt744,15,2,false);
      Result := Result+MyCurrToStr(ldblInssAnt779,15,2,false);
    end else begin
      Result := MyCurrToStr(ldblInssAntPrincipal,15,2,false);
      Result := Result+MyCurrToStr(ldblOutrasAntPrincipal,15,2,false);
    end;
  finally
    FreeAndNil(loQryCompAnteriores);
  end;
end;

function TEmpresa.getValoresPagosCooperativas: Currency;
var
  loQryBaseCooperativas: TSQLQuery;
begin
  {De acordo com o campo 26 do registro 12}
  loQryBaseCooperativas := TSQLQuery.Create(nil);
  try
    loQryBaseCooperativas.SQLConnection := TUtil.getConn;
    loQryBaseCooperativas.SQL.Add('SELECT sum(G.BASE_COOPERATIVAS) AS VALOR FROM PGPS G WHERE (G.FK_PESSOA = :pIdPessoa) AND (G.DATA BETWEEN :pDataInicial AND :pDataFinal)');
    loQryBaseCooperativas.ParamByName('pIdPessoa'   ).AsString := FIdPessoa;
    loQryBaseCooperativas.ParamByName('pDataInicial').AsDate   := BeginOfMonth(FOwner.FCompetencia);
    loQryBaseCooperativas.ParamByName('pDataFinal'  ).AsDate   := FOwner.FCompetencia;
    loQryBaseCooperativas.Open;
    Result := loQryBaseCooperativas.FieldByName('VALOR').AsCurrency;
  finally
    FreeAndNil(loQryBaseCooperativas);
  end;
end;

procedure TEmpresa.getLinhas20;
var
  lsLinha20,lsLinha21,lsInscMfTomador,lsEndereco,lsCodigoGps: String;
  loQryTomadores,loQryRetencoes: TSQLQuery;
begin
  loQryTomadores := TSQLQuery.Create(nil);
  loQryRetencoes := TSQLQuery.Create(nil);
  try
    loQryTomadores.SQLConnection := TUtil.getConn;
    loQryTomadores.SQL.Add('SELECT T.ID_PTOMADORES,T.NOME,T.INSCMF,TL.SIGLA AS TIPO_LOGRADOURO,T.LOGRADOURO,T.NUMERO,');
    loQryTomadores.SQL.Add('T.COMPL,T.BAIRRO,T.CEP,C.DESCRICAO AS CIDADE,E.SIGLA AS UF,T.FK_PESSOA ');
    loQryTomadores.SQL.Add('FROM PTOMADORES T ');
    loQryTomadores.SQL.Add('LEFT JOIN TP_LOGRADOUROS TL ON (T.FK_TP_LOGRADOURO = TL.ID_TP_LOGRADOUROS) ');
    loQryTomadores.SQL.Add('LEFT JOIN CIDADES C ON (T.FK_CIDADE = C.ID_CIDADES) ');
    loQryTomadores.SQL.Add('LEFT JOIN ESTADOS E ON (C.FK_ESTADO = E.ID_ESTADOS) ');
    loQryTomadores.SQL.Add('WHERE (T.FK_PESSOA = :pIdPessoa)');
    loQryTomadores.ParamByName('pIdPessoa').AsString  := Self.FIdPessoa;
    loQryTomadores.Open;

    loQryRetencoes.SQLConnection := TUtil.getConn;
//    loQryRetencoes.SQL.Add('SELECT SUM(GR.VALOR_RETIDO) AS VALOR_RETIDO,SUM(GR.VALOR_FATURAS) AS VALOR_FATURAS FROM PGPS_RETENCAO GR ');
    loQryRetencoes.SQL.Add('SELECT SUM(GR.VALOR_RETIDO) AS VALOR_RETIDO FROM PGPS_RETENCAO GR ');
    loQryRetencoes.SQL.Add('WHERE (GR.FK_TOMADOR = :pIdTomador) AND (GR.DATA BETWEEN :pDataInicial AND :pDataFinal) AND (GR.GPS13 = :pGps13)');
    loQryRetencoes.ParamByName('pDataInicial').AsDate     := BeginOfMonth(Self.FOwner.FCompetencia);
    loQryRetencoes.ParamByName('pDataFinal'  ).AsDate     := Self.FOwner.FCompetencia;
    loQryRetencoes.ParamByName('pGps13'      ).AsSmallInt := BooleanToInt(Self.FOwner.FCompetencia13);

    Self.FOwner.FoCdsSefip20.Filtered  := false;
    Self.FOwner.FoCdsSefip20.IndexName := 'INSCMF_TOMADOR';
    Self.FOwner.FoCdsSefip20.First;
    while not Self.FOwner.FoCdsSefip20.Eof do begin
      lsInscMfTomador := Self.FOwner.FoCdsSefip20.FieldByName('INSCMF_TOMADOR').AsString;
//      if loQryTomadores.Locate('INSCMF',lsInscMfTomador,[]) then begin
      if loQryTomadores.Locate('ID_PTOMADORES;FK_PESSOA',VarArrayOf([Self.FOwner.FoCdsSefip20.FieldByName('FK_TOMADOR').AsString,Self.FIdPessoa]),[]) then begin
        loQryRetencoes.Close;
        loQryRetencoes.ParamByName('pIdTomador').AsString := loQryTomadores.FieldByName('ID_PTOMADORES').AsString;
        loQryRetencoes.Open;

        lsEndereco := trim(loQryTomadores.FieldByName('TIPO_LOGRADOURO').AsString);
        lsEndereco := lsEndereco+' '+trim(loQryTomadores.FieldByName('LOGRADOURO' ).AsString);
        lsEndereco := lsEndereco+' '+trim(loQryTomadores.FieldByName('NUMERO'     ).AsString);
        lsEndereco := lsEndereco+' '+trim(loQryTomadores.FieldByName('COMPL').AsString);
        lsEndereco := Valid_Caracter(StrSubst(lsEndereco,'  ',' ',0),false);

        lsLinha20 := '20';
        lsLinha20 := lsLinha20+Self.FTipoInscMf;
        lsLinha20 := lsLinha20+StrZero(StrToInt64(fSoNumeros(Self.FInscMf)),14,0);
        lsLinha20 := lsLinha20+Self.FOwner.FoCdsSefip20.FieldByName('TIPO_INSCMF_TOMADOR').AsString;
        lsLinha20 := lsLinha20+StrZero(StrToInt64(fSoNumeros(Self.FOwner.FoCdsSefip20.FieldByName('INSCMF_TOMADOR').AsString)),14,0);
        lsLinha20 := lsLinha20+StrZero(0,21,0);
        lsLinha20 := lsLinha20+Valid_Caracter(StrLPad(copy(loQryTomadores.FieldByName('NOME').AsString,1,40),40),false);
        lsLinha20 := lsLinha20+StrLPad(copy(lsEndereco,1,50),50);
        lsLinha20 := lsLinha20+Valid_Caracter(StrLPad(copy(loQryTomadores.FieldByName('BAIRRO').AsString,1,20),20),false);
        lsLinha20 := lsLinha20+fSoNumeros(loQryTomadores.FieldByName('CEP').AsString);
        lsLinha20 := lsLinha20+Valid_Caracter(StrLPad(copy(loQryTomadores.FieldByName('CIDADE').AsString,1,20),20),false);
        lsLinha20 := lsLinha20+loQryTomadores.FieldByName('UF').AsString;
        {Código de pagamento da GPS. Para os códigos de recolhemento diferentes
        de 155, o código da GPS é informado no registro 10. No registro tipo 20,
        só pode informar o código da GPS para o código de recolhimento 155.}
        if Self.FOwner.FCodigoRecolhimentoGfip <> '155' then begin
          lsLinha20 := lsLinha20+StrSpace(4);
        end else begin
          if (Self.FOwner.FoCdsSefip20.FieldByName('TIPO_INSCMF_TOMADOR').AsString = '2') then begin
            {Inscritas no CEI}
            lsCodigoGps := '2208';
          end else if (FRegimeFederal = TP_REGIME_FEDERAL_SIMPLES_NACIONAL) then begin
            {Inscritas no Simples Nacional.}
            lsCodigoGps := '2003';
          end else begin
            {Demais empresas.}
            lsCodigoGps := '2100';
          end;
          lsLinha20 := lsLinha20+lsCodigoGps;
        end;
        if (not Self.FOwner.FCompetencia13) then begin
          lsLinha20 := lsLinha20+MyCurrToStr(getSalarioFamiliaPago(Self.FOwner.FoCdsSefip20.FieldByName('FK_TOMADOR').AsString),15,2,false);
        end else begin
          lsLinha20 := lsLinha20+StrZero(0,15,0);
        end;
        lsLinha20 := lsLinha20+StrZero(0,15,0);
        lsLinha20 := lsLinha20+'0';
        lsLinha20 := lsLinha20+StrZero(0,14,0);
        lsLinha20 := lsLinha20+MyCurrToStr(loQryRetencoes.FieldByName('VALOR_RETIDO' ).AsCurrency,15,2,false);
//        if FOwner.FCodigoRecolhimentoGfip <> '211' then begin
          lsLinha20 := lsLinha20+StrZero(0,15,0);
//        end else begin
//          lsLinha20 := lsLinha20+MyCurrToStr(loQryRetencoes.FieldByName('VALOR_FATURAS').AsCurrency,15,2,false);
//        end;
        lsLinha20 := lsLinha20+StrZero(0,45,0);
        lsLinha20 := lsLinha20+StrSpace(42);
        lsLinha20 := lsLinha20+'*';

        lsLinha21 := '21';
        lsLinha21 := lsLinha21+Self.FTipoInscMf;
        lsLinha21 := lsLinha21+StrZero(StrToInt64(fSoNumeros(Self.FInscMf)),14,0);
        lsLinha21 := lsLinha21+Self.FOwner.FoCdsSefip20.FieldByName('TIPO_INSCMF_TOMADOR').AsString;
        lsLinha21 := lsLinha21+StrZero(StrToInt64(fSoNumeros(Self.FOwner.FoCdsSefip20.FieldByName('INSCMF_TOMADOR').AsString)),14,0);
        lsLinha21 := lsLinha21+StrZero(0,21,0);

        lsLinha21 := lsLinha21+getDadosCompensacao(Self.FOwner.FoCdsSefip20.FieldByName('INSCMF_TOMADOR').AsString);
        lsLinha21 := lsLinha21+getRecCompetenciasAnteriores(Self.FOwner.FoCdsSefip20.FieldByName('INSCMF_TOMADOR').AsString);
        lsLinha21 := lsLinha21+StrZero(0,15,0);
        lsLinha21 := lsLinha21+StrZero(0,15,0);
        lsLinha21 := lsLinha21+StrZero(0,15,0);
        lsLinha21 := lsLinha21+StrSpace(204);
        lsLinha21 := lsLinha21+'*';

        Self.FOwner.FoCdsSefip20.Edit;
        Self.FOwner.FoCdsSefip20.FieldByName('LINHA20').AsString := lsLinha20;
        Self.FOwner.FoCdsSefip20.FieldByName('LINHA21').AsString := lsLinha21;
        Self.FOwner.FoCdsSefip20.Post;

      end;
//      if Self.FOwner.FoCdsSefip20.FieldByName('INSCMF_TOMADOR').AsString = lsInscMfTomador then begin
      Self.FOwner.FoCdsSefip20.Next;
//      end;
    end;
  finally
    FreeAndNil(loQryTomadores);
    FreeAndNil(loQryRetencoes);
  end;
end;

{ TGfip }

constructor TGfip.Create(psIdEmpresaResponsavel,psPath,psProcesso,psVara: String;
      poStrInscMfEmpresas: TStringList; pdCompetencia,pdDataRecFgts,
      pdDataRecPrevSoc: TDate; piIndicadorRecFgts,
      piIndicadorRecPrevSoc: SmallInt; pbCompetencia13: Boolean;
      var poNGaugeEmpresa,poNGaugeColaborador: TEvGauge;
      var polblEmpresa,polblColaborador: TLabel; pbObraPropria,pbExcluiPisZero: Boolean;
      peTipoRecolhimento: TTipoRecolhimentoSefip; pdDataInicial,pDataFinal: TDate);
var
  loQryEmpresaResponsavel: TSQLQuery;
  CheckDoc: TCheckDoc;
begin
  if not Assigned(dmInformacoesSefip) then begin
    dmInformacoesSefip := TdmInformacoesSefip.Create(nil);
  end;

  FCompetencia            := EndOfMonth(pdCompetencia);
  FdDataInicial           := pdDataInicial;
  FdDataFinal             := pDataFinal;
  FeTipoRecolhimentoSefip := peTipoRecolhimento;
  FDataRecFgts            := pdDataRecFgts;
  FDataRecPrevSoc         := pdDataRecPrevSoc;
  FIndicadorRecFgts       := piIndicadorRecFgts;
  FIndicadorRecPrevSoc    := piIndicadorRecPrevSoc;
  FCompetencia13          := pbCompetencia13;
  FListaEmpresas          := TList.Create;
  FObraPropria            := pbObraPropria;
  FTemTomador             := false;
  FInconsistencias        := TStringList.Create;
  FPath                   := psPath;
  FGfipComFuncionarios    := false;
  FExcluiPisZero          := pbExcluiPisZero;
  FsProcesso              := psProcesso;
  FsVara                  := psVara;

  if (Month(pdCompetencia) <> 12) and (pbCompetencia13) then begin
    FInconsistencias.Add('A competênca 13 só pode ser gerada no mês 12.');
    FInconsistencias.Add(' ');
  end;

  {Abre a qry para recuperar os dados da empresa responsável pela geração do
   arquivo para a SEFIP.}
  loQryEmpresaResponsavel:= TSQLQuery.Create(nil);
  CheckDoc := TCheckDoc.Create(nil);
  try
    loQryEmpresaResponsavel.SQLConnection := TUtil.getConn;
    loQryEmpresaResponsavel.SQL.Add('SELECT PD.R_P_NOME AS NOME,PD.R_PP_CONTATO AS PESSOA_CONTATO,PD.R_TPLP_SIGLA AS TIPO_LOGRADOURO,');
    loQryEmpresaResponsavel.SQL.Add('PD.R_P_LOGRADOURO AS LOGRADOURO,PD.R_P_NUMERO AS NUMERO,PD.R_P_COMPLEMENTO AS COMPLEMENTO,');
    loQryEmpresaResponsavel.SQL.Add('PD.R_P_BAIRRO AS BAIRRO,PD.R_PCID_DESCRICAO AS CIDADE,PD.R_PEST_SIGLA AS UF,PD.R_P_CEP AS CEP,');
    loQryEmpresaResponsavel.SQL.Add('PD.R_TEL_NUMERO AS TELEFONE,PD.R_EMAIL_ENDERECO AS EMAIL,PD.R_P_INSCMF AS INSCMF ');
    loQryEmpresaResponsavel.SQL.Add('FROM SP_PESSOA_DADOS(:pData,:pIdEmpresaResponsavel) PD');
    loQryEmpresaResponsavel.ParamByName('pData'                ).AsDate   := FCompetencia;
    loQryEmpresaResponsavel.ParamByName('pIdEmpresaResponsavel').AsString := psIdEmpresaResponsavel;
    loQryEmpresaResponsavel.Open;

    FNomeResponsavel          := loQryEmpresaResponsavel.FieldByName('NOME'  ).AsString;
    FInscMfResponsavel        := loQryEmpresaResponsavel.FieldByName('INSCMF').AsString;
    FPessoaContatoResponsavel := Valid_Caracter(loQryEmpresaResponsavel.FieldByName('PESSOA_CONTATO').AsString,False);
    if Trim(FPessoaContatoResponsavel) = '' then begin
      FInconsistencias.Add('-Falta, no cadastro da empresa responsável, o nome da pessoa para contato.')
    end;
    FBairroResponsavel        := loQryEmpresaResponsavel.FieldByName('BAIRRO').AsString;
    FCepResponsavel           := loQryEmpresaResponsavel.FieldByName('CEP'   ).AsString;
    FCidadeResponsavel        := loQryEmpresaResponsavel.FieldByName('CIDADE').AsString;
    FUfResponsavel            := loQryEmpresaResponsavel.FieldByName('UF'    ).AsString;
    FTelefoneResponsavel      := fSoNumeros(loQryEmpresaResponsavel.FieldByName('TELEFONE').AsString);
    FTelefoneResponsavel      := copy(FTelefoneResponsavel,1,2)+StrSpace(2)+copy(FTelefoneResponsavel,3,length(FTelefoneResponsavel)-2);
    FEmailResponsavel         := loQryEmpresaResponsavel.FieldByName('EMAIL').AsString;
    FEnderecoResponsavel      := trim(loQryEmpresaResponsavel.FieldByName('TIPO_LOGRADOURO').AsString);
    FEnderecoResponsavel      := FEnderecoResponsavel+' '+trim(loQryEmpresaResponsavel.FieldByName('LOGRADOURO' ).AsString);
    FEnderecoResponsavel      := FEnderecoResponsavel+' '+trim(loQryEmpresaResponsavel.FieldByName('NUMERO'     ).AsString);
    FEnderecoResponsavel      := FEnderecoResponsavel+' '+trim(loQryEmpresaResponsavel.FieldByName('COMPLEMENTO').AsString);
    FEnderecoResponsavel      := StrSubst(FEnderecoResponsavel,'  ',' ',0);

    CheckDoc.Mode  := moAutoDetect;
    CheckDoc.Input := loQryEmpresaResponsavel.FieldByName('INSCMF').AsString;
    if CheckDoc.ModeResult = moCGC then begin
      FTipoInscMfResponsavel := '1';
    end else if CheckDoc.ModeResult = moCEI then begin
      FTipoInscMfResponsavel := '2';
    end else if CheckDoc.ModeResult = moCPF then begin
      FTipoInscMfResponsavel := '3';
    end;

    CriaDataSets;

    PreencheListaEmpresas(poStrInscMfEmpresas,poNGaugeEmpresa,poNGaugeColaborador,polblEmpresa,polblColaborador);
  finally
    FreeAndNil(CheckDoc);
    FreeAndNil(loQryEmpresaResponsavel);
  end;
end;

procedure TGfip.CriaDataSets;
begin
  FoCdsSefip10 := TClientDataSet.Create(nil);
//  FoCdsSefip10.FieldDefs.Add('REGISTRO'           ,ftString,2  ,true);
  FoCdsSefip10.FieldDefs.Add('TIPO_INSCMF_EMPRESA',ftString,1  ,true);
  FoCdsSefip10.FieldDefs.Add('INSCMF_EMPRESA'     ,ftString,18 ,true);
  FoCdsSefip10.FieldDefs.Add('NOME'               ,ftString,100,true);
  FoCdsSefip10.FieldDefs.Add('LINHA10'            ,ftString,360,true);
  FoCdsSefip10.FieldDefs.Add('LINHA12'            ,ftString,360,true);
  FoCdsSefip10.CreateDataSet;
  FoCdsSefip10.Open;
  FoCdsSefip10.EmptyDataSet;

  FoCdsSefip20 := TClientDataSet.Create(nil);
//  FoCdsSefip20.FieldDefs.Add('REGISTRO'           ,ftString,2  ,true);
  FoCdsSefip20.FieldDefs.Add('FK_TOMADOR'         ,ftString,40 ,true);
  FoCdsSefip20.FieldDefs.Add('TIPO_INSCMF_EMPRESA',ftString,1  ,true);
  FoCdsSefip20.FieldDefs.Add('INSCMF_EMPRESA'     ,ftString,18 ,true);
  FoCdsSefip20.FieldDefs.Add('TIPO_INSCMF_TOMADOR',ftString,1  ,false);
  FoCdsSefip20.FieldDefs.Add('INSCMF_TOMADOR'     ,ftString,18 ,false);
  FoCdsSefip20.FieldDefs.Add('LINHA20'            ,ftString,360,true);
  FoCdsSefip20.FieldDefs.Add('LINHA21'            ,ftString,360,true);
  FoCdsSefip20.CreateDataSet;
  FoCdsSefip20.Open;
  FoCdsSefip20.EmptyDataSet;

  FoCdsSefip30 := TClientDataSet.Create(nil);
  FoCdsSefip30.FieldDefs.Add('MATRICULA_E_SOCIAL' ,ftInteger,0  ,true);
  FoCdsSefip30.FieldDefs.Add('TIPO_INSCMF_EMPRESA',ftString ,1  ,true);
  FoCdsSefip30.FieldDefs.Add('INSCMF_EMPRESA'     ,ftString ,18 ,true);
  FoCdsSefip30.FieldDefs.Add('TIPO_INSCMF_TOMADOR',ftString ,1  ,false);
  FoCdsSefip30.FieldDefs.Add('INSCMF_TOMADOR'     ,ftString ,18 ,false);
//  FoCdsSefip30.FieldDefs.Add('ID_FUNCIONARIO'     ,ftString ,40 ,true);
  FoCdsSefip30.FieldDefs.Add('NOME'               ,ftString ,100,true);
  FoCdsSefip30.FieldDefs.Add('PIS'                ,ftString ,11 ,false);
  FoCdsSefip30.FieldDefs.Add('DATA_ADMISSAO'      ,ftDate   ,0  ,false);
  FoCdsSefip30.FieldDefs.Add('CATEGORIA'          ,ftString ,2  ,false);
  FoCdsSefip30.FieldDefs.Add('LINHA'              ,ftString ,360,true);
  FoCdsSefip30.CreateDataSet;
  FoCdsSefip30.Open;
  FoCdsSefip30.EmptyDataSet;

//  FoCdsSefip30Clone := TClientDataSet.Create(nil);
//  FoCdsSefip30Clone.FieldDefs.Add('TIPO_INSCMF_EMPRESA',ftString,1  ,true);
//  FoCdsSefip30Clone.FieldDefs.Add('INSCMF_EMPRESA'     ,ftString,18 ,true);
//  FoCdsSefip30Clone.FieldDefs.Add('TIPO_INSCMF_TOMADOR',ftString,1  ,false);
//  FoCdsSefip30Clone.FieldDefs.Add('INSCMF_TOMADOR'     ,ftString,18 ,false);
//  FoCdsSefip30Clone.FieldDefs.Add('NOME'               ,ftString,100,true);
//  FoCdsSefip30Clone.FieldDefs.Add('PIS'                ,ftString,11 ,false);
//  FoCdsSefip30Clone.FieldDefs.Add('DATA_ADMISSAO'      ,ftDate  ,0  ,false);
//  FoCdsSefip30Clone.FieldDefs.Add('CATEGORIA'          ,ftString,2  ,false);
//  FoCdsSefip30Clone.FieldDefs.Add('LINHA'              ,ftString,360,true);
//  FoCdsSefip30Clone.CreateDataSet;
//  FoCdsSefip30Clone.Open;
//  FoCdsSefip30Clone.EmptyDataSet;

  FoCdsSefip32 := TClientDataSet.Create(nil);
  FoCdsSefip32.FieldDefs.Add('MATRICULA_E_SOCIAL' ,ftInteger,0 ,true);
  FoCdsSefip32.FieldDefs.Add('TIPO_INSCMF_EMPRESA',ftString,1  ,true);
  FoCdsSefip32.FieldDefs.Add('INSCMF_EMPRESA'     ,ftString,18 ,true);
  FoCdsSefip32.FieldDefs.Add('TIPO_INSCMF_TOMADOR',ftString,1  ,false);
  FoCdsSefip32.FieldDefs.Add('INSCMF_TOMADOR'     ,ftString,18 ,false);
//  FoCdsSefip32.FieldDefs.Add('NOME'               ,ftString,100,true);
//  FoCdsSefip32.FieldDefs.Add('PIS'                ,ftString,11 ,false);
//  FoCdsSefip32.FieldDefs.Add('DATA_ADMISSAO'      ,ftDate  ,0  ,false);
//  FoCdsSefip32.FieldDefs.Add('CATEGORIA'          ,ftString,2  ,false);
  FoCdsSefip32.FieldDefs.Add('LINHA'              ,ftString,360,true);
  FoCdsSefip32.CreateDataSet;
  FoCdsSefip32.Open;
  FoCdsSefip32.EmptyDataSet;

  {Cria os índices nos ClientDataSet's}
//  FoCdsSefip32.AddIndex('PRINCIPAL','TIPO_INSCMF_EMPRESA;INSCMF_EMPRESA;TIPO_INSCMF_TOMADOR;INSCMF_TOMADOR;PIS;DATA_ADMISSAO;CATEGORIA',[]);
  FoCdsSefip32.AddIndex('PRINCIPAL','TIPO_INSCMF_EMPRESA;INSCMF_EMPRESA;TIPO_INSCMF_TOMADOR;INSCMF_TOMADOR;MATRICULA_E_SOCIAL',[]);

  if (FeTipoRecolhimentoSefip <> TTipoRecolhimentoSefip.trs_somente_diferencas_650) then begin
    FoCdsSefip30.AddIndex('INSCMF_TOMADOR','INSCMF_TOMADOR',[ixDescending]);
    FoCdsSefip30.AddIndex('PRINCIPAL','TIPO_INSCMF_EMPRESA;INSCMF_EMPRESA;TIPO_INSCMF_TOMADOR;INSCMF_TOMADOR;PIS;DATA_ADMISSAO;CATEGORIA',[]);

//    FoCdsSefip30Clone.AddIndex('PRINCIPAL','TIPO_INSCMF_EMPRESA;INSCMF_EMPRESA;TIPO_INSCMF_TOMADOR;INSCMF_TOMADOR;PIS;DATA_ADMISSAO;CATEGORIA',[]);
  end else begin
    FoCdsSefip30.AddIndex('PRINCIPAL','TIPO_INSCMF_EMPRESA;INSCMF_EMPRESA;PIS;DATA_ADMISSAO;CATEGORIA',[]);

//    FoCdsSefip30Clone.AddIndex('PRINCIPAL','TIPO_INSCMF_EMPRESA;INSCMF_EMPRESA;PIS;DATA_ADMISSAO;CATEGORIA',[]);
  end;

  FoCdsSefip20.AddIndex('PRINCIPAL','TIPO_INSCMF_EMPRESA;INSCMF_EMPRESA;TIPO_INSCMF_TOMADOR;INSCMF_TOMADOR',[]);
  FoCdsSefip20.AddIndex('INSCMF_TOMADOR'  ,'TIPO_INSCMF_TOMADOR;INSCMF_TOMADOR',[]);

  FoCdsSefip10.AddIndex('PRINCIPAL','TIPO_INSCMF_EMPRESA;INSCMF_EMPRESA',[]);
end;

destructor TGfip.Destroy;
begin
  if Assigned(FoCdsSefip10) then begin
    FreeAndNil(FoCdsSefip10);
  end;
  if Assigned(FoCdsSefip20) then begin
    FreeAndNil(FoCdsSefip20);
  end;
  if Assigned(FoCdsSefip30) then begin
    FreeAndNil(FoCdsSefip30);
  end;
  if Assigned(FoCdsSefip30) then begin
    FreeAndNil(FoCdsSefip30);
  end;
  if Assigned(FoCdsSefip32) then begin
    FreeAndNil(FoCdsSefip32);
  end;
  if Assigned(FListaEmpresas) then begin
    FreeAndNil(FListaEmpresas);
  end;
  if Assigned(FInconsistencias) then begin
    FreeAndNil(FInconsistencias);
  end;
  if Assigned(dmInformacoesSefip) then begin
    FreeAndNil(dmInformacoesSefip);
  end;
  inherited;
end;

procedure TGfip.GeraArquivoSefip();
var
  strLstSefip: TStringList;
  lbTomadorPrimeiroRegistro,lbTomadorUltimoRegistro: Boolean;
  lsLinha00,lsLinha90,lsTipoInscMfEmpresa,lsInscMfEmpresa,lsTipoInscMfTomador,
  lsInscMfTomador,lsPis,lsCategoria: String;
  FMostraErros: TFMostraErros;
  ldDataAdmissao: TDate;
  liIncDataAdmissao: SmallInt;
  liMatriculaESocial: Integer;
begin
//  {Verifica se existe funcionário(s) com mais de um vínculo com o mesmo
//  empregador e acrescenta um dia a data de admissão.}
//  FoCdsSefip30Clone.IndexName := 'PRINCIPAL';
//  FoCdsSefip30Clone.First;
//  if (FeTipoRecolhimentoSefip <> TTipoRecolhimentoSefip.trs_somente_diferencas_650) then begin
//    while (not FoCdsSefip30Clone.Eof) do begin
//      lsTipoInscMfEmpresa := FoCdsSefip30Clone.FieldByName('TIPO_INSCMF_EMPRESA').AsString;
//      lsInscMfEmpresa     := FoCdsSefip30Clone.FieldByName('INSCMF_EMPRESA').AsString;
//      lsTipoInscMfTomador := FoCdsSefip30Clone.FieldByName('TIPO_INSCMF_TOMADOR').AsString;
//      lsInscMfTomador     := FoCdsSefip30Clone.FieldByName('INSCMF_TOMADOR').AsString;
//      lsPis               := FoCdsSefip30Clone.FieldByName('PIS').AsString;
//      ldDataAdmissao      := FoCdsSefip30Clone.FieldByName('DATA_ADMISSAO').AsDateTime;
//      lsCategoria         := FoCdsSefip30Clone.FieldByName('CATEGORIA').AsString;
//      liIncDataAdmissao   := 0;
//      while (FoCdsSefip30Clone.FieldByName('TIPO_INSCMF_EMPRESA').AsString   = lsTipoInscMfEmpresa)
//        and (FoCdsSefip30Clone.FieldByName('INSCMF_EMPRESA'     ).AsString   = lsInscMfEmpresa)
//        and (FoCdsSefip30Clone.FieldByName('TIPO_INSCMF_TOMADOR').AsString   = lsTipoInscMfTomador)
//        and (FoCdsSefip30Clone.FieldByName('INSCMF_TOMADOR'     ).AsString   = lsInscMfTomador)
//        and (FoCdsSefip30Clone.FieldByName('PIS'                ).AsString   = lsPis)
//        and (FoCdsSefip30Clone.FieldByName('DATA_ADMISSAO'      ).AsDateTime = ldDataAdmissao)
//        and (FoCdsSefip30Clone.FieldByName('CATEGORIA'          ).AsString   = lsCategoria)
//        and (not FoCdsSefip30Clone.Eof)
//      do begin
//        FoCdsSefip30.Insert;
//        FoCdsSefip30.FieldByName('TIPO_INSCMF_EMPRESA').AsString   :=  FoCdsSefip30Clone.FieldByName('TIPO_INSCMF_EMPRESA').AsString;
//        FoCdsSefip30.FieldByName('INSCMF_EMPRESA'     ).AsString   :=  FoCdsSefip30Clone.FieldByName('INSCMF_EMPRESA'     ).AsString;
//        FoCdsSefip30.FieldByName('TIPO_INSCMF_TOMADOR').AsString   :=  FoCdsSefip30Clone.FieldByName('TIPO_INSCMF_TOMADOR').AsString;
//        FoCdsSefip30.FieldByName('INSCMF_TOMADOR'     ).AsString   :=  FoCdsSefip30Clone.FieldByName('INSCMF_TOMADOR'     ).AsString;
//        FoCdsSefip30.FieldByName('NOME'               ).AsString   :=  FoCdsSefip30Clone.FieldByName('NOME'               ).AsString;
//        FoCdsSefip30.FieldByName('PIS'                ).AsString   :=  FoCdsSefip30Clone.FieldByName('PIS'                ).AsString;
//        FoCdsSefip30.FieldByName('CATEGORIA'          ).AsString   :=  FoCdsSefip30Clone.FieldByName('CATEGORIA'          ).AsString;
//        FoCdsSefip30.FieldByName('LINHA'              ).AsString   :=  FoCdsSefip30Clone.FieldByName('LINHA'              ).AsString;
//        if (liIncDataAdmissao > 0) then begin
//          FoCdsSefip30.FieldByName('DATA_ADMISSAO').AsDateTime := FoCdsSefip30Clone.FieldByName('DATA_ADMISSAO').AsDateTime+liIncDataAdmissao;
//        end else begin
//          FoCdsSefip30.FieldByName('DATA_ADMISSAO').AsDateTime := FoCdsSefip30Clone.FieldByName('DATA_ADMISSAO').AsDateTime;
//        end;
//        FoCdsSefip30.Post;
//        Inc(liIncDataAdmissao);
//        FoCdsSefip30Clone.Next;
//      end;
//    end;
//  end else begin
//    while (not FoCdsSefip30Clone.Eof) do begin
//      lsTipoInscMfEmpresa := FoCdsSefip30Clone.FieldByName('TIPO_INSCMF_EMPRESA').AsString;
//      lsInscMfEmpresa     := FoCdsSefip30Clone.FieldByName('INSCMF_EMPRESA').AsString;
//      lsPis               := FoCdsSefip30Clone.FieldByName('PIS').AsString;
//      ldDataAdmissao      := FoCdsSefip30Clone.FieldByName('DATA_ADMISSAO').AsDateTime;
//      lsCategoria         := FoCdsSefip30Clone.FieldByName('CATEGORIA').AsString;
//      liIncDataAdmissao   := 0;
//      while (FoCdsSefip30Clone.FieldByName('TIPO_INSCMF_EMPRESA').AsString   = lsTipoInscMfEmpresa)
//        and (FoCdsSefip30Clone.FieldByName('INSCMF_EMPRESA'     ).AsString   = lsInscMfEmpresa)
//        and (FoCdsSefip30Clone.FieldByName('PIS'                ).AsString   = lsPis)
//        and (FoCdsSefip30Clone.FieldByName('DATA_ADMISSAO'      ).AsDateTime = ldDataAdmissao)
//        and (FoCdsSefip30Clone.FieldByName('CATEGORIA'          ).AsString   = lsCategoria)
//        and (not FoCdsSefip30Clone.Eof)
//      do begin
//        FoCdsSefip30.Insert;
//        FoCdsSefip30.FieldByName('TIPO_INSCMF_EMPRESA').AsString   :=  FoCdsSefip30Clone.FieldByName('TIPO_INSCMF_EMPRESA').AsString;
//        FoCdsSefip30.FieldByName('INSCMF_EMPRESA'     ).AsString   :=  FoCdsSefip30Clone.FieldByName('INSCMF_EMPRESA'     ).AsString;
//        FoCdsSefip30.FieldByName('NOME'               ).AsString   :=  FoCdsSefip30Clone.FieldByName('NOME'               ).AsString;
//        FoCdsSefip30.FieldByName('PIS'                ).AsString   :=  FoCdsSefip30Clone.FieldByName('PIS'                ).AsString;
//        FoCdsSefip30.FieldByName('CATEGORIA'          ).AsString   :=  FoCdsSefip30Clone.FieldByName('CATEGORIA'          ).AsString;
//        FoCdsSefip30.FieldByName('LINHA'              ).AsString   :=  FoCdsSefip30Clone.FieldByName('LINHA'              ).AsString;
//        if (liIncDataAdmissao > 0) then begin
//          FoCdsSefip30.FieldByName('DATA_ADMISSAO').AsDateTime := FoCdsSefip30Clone.FieldByName('DATA_ADMISSAO').AsDateTime+liIncDataAdmissao;
//        end else begin
//          FoCdsSefip30.FieldByName('DATA_ADMISSAO').AsDateTime := FoCdsSefip30Clone.FieldByName('DATA_ADMISSAO').AsDateTime;
//        end;
//        FoCdsSefip30.Post;
//        Inc(liIncDataAdmissao);
//        FoCdsSefip30Clone.Next;
//      end;
//    end;
//  end;

//  FoCdsSefip30. EmptyDataSet;
//  FoCdsSefip30.Data := FoCdsSefip30Clone1.Data;

  strLstSefip  := TStringList.Create;
  FMostraErros := TFMostraErros.Create(nil);
  try
    lsLinha00 := '00';
    lsLinha00 := lsLinha00+StrSpace(51);
    lsLinha00 := lsLinha00+'1'; {Tipo de remessa GFIP}
    lsLinha00 := lsLinha00+FTipoInscMfResponsavel;
    lsLinha00 := lsLinha00+StrZero(StrToInt64(fSoNumeros(FInscMfResponsavel)),14,0);
    lsLinha00 := lsLinha00+Valid_Caracter(StrLPad(Copy(FNomeResponsavel,1,30),30),false);
    lsLinha00 := lsLinha00+Valid_Caracter(StrLPad(Copy(FPessoaContatoResponsavel,1,20),20),false);
    lsLinha00 := lsLinha00+Valid_Caracter(StrLPad(Copy(FEnderecoResponsavel,1,50),50),false);
    lsLinha00 := lsLinha00+Valid_Caracter(StrLPad(Copy(FBairroResponsavel,1,20),20),false);
    lsLinha00 := lsLinha00+fSoNumeros(FCepResponsavel);
    lsLinha00 := lsLinha00+Valid_Caracter(StrLPad(Copy(FCidadeResponsavel,1,20),20),false);
    lsLinha00 := lsLinha00+FUfResponsavel;
    lsLinha00 := lsLinha00+StrLPad(Copy(FTelefoneResponsavel,1,12),12);
    lsLinha00 := lsLinha00+StrLPad(Copy(FEmailResponsavel,1,60),60);
    if not FCompetencia13 then begin
      lsLinha00 := lsLinha00+DateStr(FCompetencia,dtsYM);
    end else begin
      lsLinha00 := lsLinha00+DateStr(FCompetencia,dtsY)+'13';
    end;
    lsLinha00 := lsLinha00+FCodigoRecolhimentoGfip;
    if not (FCompetencia13) then begin
      lsLinha00 := lsLinha00+IntToStr(FIndicadorRecFgts);
    end else begin
      lsLinha00 := lsLinha00+' ';
    end;
    if (FCompetencia13) or (not FGfipComFuncionarios) then begin {Modalidade}
      lsLinha00 := lsLinha00+'1'; {Declaração ao FGTS e a Previdência}
    end else begin
      lsLinha00 := lsLinha00+' '; {Recolhimento ao FGTS e Declaração a Previdência}
    end;
    if (FCompetencia13) or (FIndicadorRecFgts = 1) then begin
      lsLinha00 := lsLinha00+StrSpace(8);
    end else begin
      lsLinha00 := lsLinha00+DateStr(FDataRecFgts,dtsDMY);
    end;
    lsLinha00 := lsLinha00+IntToStr(FIndicadorRecPrevSoc);
    if FIndicadorRecPrevSoc = 1 then begin
      {Se o recolhimento a Previdência for no prazo,
       a data de recolhimento não deve ser informada.}
      lsLinha00 := lsLinha00+StrSpace(8);
    end else begin
      {Se o recolhimento a Previdência for em atraso,
       a data de recolhimento não precisa ser informada.}
      lsLinha00 := lsLinha00+DateStr(FDataRecPrevSoc,dtsDMY);
    end;
    lsLinha00 := lsLinha00+StrSpace(7);
    {Tipo de Inscrição do Fornecedor da Folha de Pagamento}
    lsLinha00 := lsLinha00+'1';
    lsLinha00 := lsLinha00+fSoNumeros(rInfoEmpresa.sInscMf);
    lsLinha00 := lsLinha00+StrSpace(18);
    lsLinha00 := lsLinha00+'*';

    {Incluir o Registro tipo 00}
    strLstSefip.Add(lsLinha00);

    FoCdsSefip32.IndexName := 'PRINCIPAL';
    FoCdsSefip20.IndexName := 'PRINCIPAL';
    FoCdsSefip10.IndexName := 'PRINCIPAL';
    FoCdsSefip10.First;

    while not FoCdsSefip10.Eof do begin
      {Incluir os Registros tipo 10 e 12}
      strLstSefip.Add(FoCdsSefip10.FieldByName('LINHA10').AsString);
      strLstSefip.Add(FoCdsSefip10.FieldByName('LINHA12').AsString);

      FoCdsSefip20.Filtered := false;
      FoCdsSefip20.Filter   := 'INSCMF_EMPRESA = '+quotedStr(FoCdsSefip10.FieldByName('INSCMF_EMPRESA').AsString);
      FoCdsSefip20.Filtered := true;

      FoCdsSefip30.Filtered := false;
      FoCdsSefip30.Filter   := 'INSCMF_EMPRESA = '+quotedStr(FoCdsSefip10.FieldByName('INSCMF_EMPRESA').AsString);
      FoCdsSefip30.Filtered := true;

      if (FeTipoRecolhimentoSefip <> TTipoRecolhimentoSefip.trs_somente_diferencas_650) then begin
        FoCdsSefip30.IndexName := 'INSCMF_TOMADOR';
        FoCdsSefip30.Last;
        lbTomadorUltimoRegistro := (trim(FoCdsSefip30.FieldByName('INSCMF_TOMADOR').AsString) <> '');
        FoCdsSefip30.First;
        lbTomadorPrimeiroRegistro := (trim(FoCdsSefip30.FieldByName('INSCMF_TOMADOR').AsString) <> '');
      end;
      FoCdsSefip30.IndexName := 'PRINCIPAL';

      if (FeTipoRecolhimentoSefip <> TTipoRecolhimentoSefip.trs_somente_diferencas_650)
        and (lbTomadorPrimeiroRegistro <> lbTomadorUltimoRegistro)
      then begin
        FInconsistencias.Add('CNPJ/CEI: '+FoCdsSefip30.FieldByName('INSCMF_EMPRESA').AsString+'-'+trim(Copy(FoCdsSefip10.FieldByName('INSCMF_EMPRESA').AsString,54,40))+', MOTIVO: Empresa não pode ter colaboradores vinculados e não vinculados a tomadores de serviços. Consulte manual da SEFIP.');
        FInconsistencias.Add('Situação dos colaboradores: ');
        FInconsistencias.Add(' ');
        while not FoCdsSefip30.Eof do begin
          if trim(FoCdsSefip30.FieldByName('INSCMF_TOMADOR').AsString) = '' then begin
            FInconsistencias.Add(StrLPad(trim(copy(FoCdsSefip30.FieldByName('NOME').AsString,1,70)),70)+' NÃO vinculado.' );
          end else begin
            FInconsistencias.Add(StrLPad(trim(copy(FoCdsSefip30.FieldByName('NOME').AsString,1,70)),70)+' Vinculado.' );
          end;
          FoCdsSefip30.Next;
        end;
        FInconsistencias.Add(' ');
        FoCdsSefip30.First;
      end;
//      if (Self.FObraPropria)
//        or ((FeTipoRecolhimentoSefip <> TTipoRecolhimentoSefip.trs_somente_diferencas_650)
//        and (not FoCdsSefip20.IsEmpty))
      if (Self.FObraPropria)
        or ((FeTipoRecolhimentoSefip <> TTipoRecolhimentoSefip.trs_somente_diferencas_650)
        and (not FoCdsSefip20.IsEmpty))
      then begin
        {Se for Obra Própria, ou tiver tomador...}
        FoCdsSefip20.First;
        while not FoCdsSefip20.Eof do begin
          {Incluir os Registros tipo 20 e 21, se houver.}
          strLstSefip.Add(FoCdsSefip20.FieldByName('LINHA20').AsString);
          strLstSefip.Add(FoCdsSefip20.FieldByName('LINHA21').AsString);

          FoCdsSefip30.Filtered := False;
          FoCdsSefip30.Filter   := 'INSCMF_EMPRESA = '+quotedStr(FoCdsSefip20.FieldByName('INSCMF_EMPRESA').AsString)+' AND INSCMF_TOMADOR = '+quotedStr(FoCdsSefip20.FieldByName('INSCMF_TOMADOR').AsString)  ;
          FoCdsSefip30.Filtered := true;
          FoCdsSefip30.First;

          while (FoCdsSefip30.FieldByName('INSCMF_EMPRESA').AsString = FoCdsSefip20.FieldByName('INSCMF_EMPRESA').AsString) and (not FoCdsSefip30.Eof) do begin
            {Inclui os Registros tipo 30.}
            strLstSefip.Add(FoCdsSefip30.FieldByName('LINHA').AsString);
            if FoCdsSefip30.FieldByName('DATA_ADMISSAO').AsDateTime > 0 then begin
              liMatriculaESocial  := FoCdsSefip30.FieldByName('MATRICULA_E_SOCIAL' ).AsInteger;
              lsTipoInscMfEmpresa := FoCdsSefip30.FieldByName('TIPO_INSCMF_EMPRESA').AsString;
              lsInscMfEmpresa     := FoCdsSefip30.FieldByName('INSCMF_EMPRESA'     ).AsString;
              lsTipoInscMfTomador := FoCdsSefip30.FieldByName('TIPO_INSCMF_TOMADOR').AsString;
              lsInscMfTomador     := FoCdsSefip30.FieldByName('INSCMF_TOMADOR'     ).AsString;
//              if FoCdsSefip32.Locate('PIS;DATA_ADMISSAO;INSCMF_TOMADOR',VarArrayOf([FoCdsSefip30.FieldByName('PIS').AsString,FoCdsSefip30.FieldByName('DATA_ADMISSAO').AsDateTime,FoCdsSefip30.FieldByName('INSCMF_TOMADOR').AsString]),[]) then begin
//                while (FoCdsSefip32.FieldByName('PIS').AsString = FoCdsSefip30.FieldByName('PIS').AsString)
//                  and (FoCdsSefip32.FieldByName('DATA_ADMISSAO').AsDateTime = FoCdsSefip30.FieldByName('DATA_ADMISSAO').AsDateTime)
//                  and (FoCdsSefip32.FieldByName('INSCMF_TOMADOR').AsString = FoCdsSefip30.FieldByName('INSCMF_TOMADOR').AsString)
//                  and (not FoCdsSefip32.Eof)
              if FoCdsSefip32.Locate('TIPO_INSCMF_EMPRESA;INSCMF_EMPRESA;TIPO_INSCMF_TOMADOR;INSCMF_TOMADOR;MATRICULA_E_SOCIAL',VarArrayOf([lsTipoInscMfEmpresa,lsInscMfEmpresa,lsTipoInscMfTomador,lsInscMfTomador,liMatriculaESocial]),[]) then begin
                while (FoCdsSefip32.FieldByName('TIPO_INSCMF_EMPRESA').AsString  = lsTipoInscMfEmpresa)
                  and (FoCdsSefip32.FieldByName('INSCMF_EMPRESA'     ).AsString  = lsInscMfEmpresa)
                  and (FoCdsSefip32.FieldByName('TIPO_INSCMF_TOMADOR').AsString  = lsTipoInscMfTomador)
                  and (FoCdsSefip32.FieldByName('INSCMF_TOMADOR'     ).AsString  = lsInscMfTomador)
                  and (FoCdsSefip32.FieldByName('MATRICULA_E_SOCIAL' ).AsInteger = liMatriculaESocial)
                  and (not FoCdsSefip32.Eof)
                do begin
                  {Inclui os Registros tipo 32.}
                  strLstSefip.Add(FoCdsSefip32.FieldByName('LINHA').AsString);
                  FoCdsSefip32.Next;
                end;
              end;
            end;
            FoCdsSefip30.Next;
          end;
          FoCdsSefip20.Next;
        end;
      end else begin
        {Se não for obra própria e não tiver tomador...}
        FoCdsSefip30.First;
        while (not FoCdsSefip30.Eof) do begin
          {Inclui os Registros tipo 30.}
          strLstSefip.Add(FoCdsSefip30.FieldByName('LINHA').AsString);
          if FoCdsSefip30.FieldByName('DATA_ADMISSAO').AsDateTime > 0 then begin
            liMatriculaESocial  := FoCdsSefip30.FieldByName('MATRICULA_E_SOCIAL' ).AsInteger;
            lsTipoInscMfEmpresa := FoCdsSefip30.FieldByName('TIPO_INSCMF_EMPRESA').AsString;
            lsInscMfEmpresa     := FoCdsSefip30.FieldByName('INSCMF_EMPRESA'     ).AsString;
            lsTipoInscMfTomador := FoCdsSefip30.FieldByName('TIPO_INSCMF_TOMADOR').AsString;
            lsInscMfTomador     := FoCdsSefip30.FieldByName('INSCMF_TOMADOR'     ).AsString;
//            if FoCdsSefip32.Locate('PIS;DATA_ADMISSAO',VarArrayOf([FoCdsSefip30.FieldByName('PIS').AsString,FoCdsSefip30.FieldByName('DATA_ADMISSAO').AsDateTime]),[]) then begin
//              while (FoCdsSefip32.FieldByName('PIS').AsString = FoCdsSefip30.FieldByName('PIS').AsString) and (FoCdsSefip32.FieldByName('DATA_ADMISSAO').AsDateTime = FoCdsSefip30.FieldByName('DATA_ADMISSAO').AsDateTime) and (not FoCdsSefip32.Eof) do begin
            if FoCdsSefip32.Locate('TIPO_INSCMF_EMPRESA;INSCMF_EMPRESA;TIPO_INSCMF_TOMADOR;INSCMF_TOMADOR;MATRICULA_E_SOCIAL',VarArrayOf([lsTipoInscMfEmpresa,lsInscMfEmpresa,lsTipoInscMfTomador,lsInscMfTomador,liMatriculaESocial]),[]) then begin
              while (FoCdsSefip32.FieldByName('TIPO_INSCMF_EMPRESA').AsString  = lsTipoInscMfEmpresa)
                and (FoCdsSefip32.FieldByName('INSCMF_EMPRESA'     ).AsString  = lsInscMfEmpresa)
                and (FoCdsSefip32.FieldByName('MATRICULA_E_SOCIAL' ).AsInteger = liMatriculaESocial)
                and (FoCdsSefip32.FieldByName('TIPO_INSCMF_TOMADOR').AsString  = lsTipoInscMfTomador)
                and (FoCdsSefip32.FieldByName('INSCMF_TOMADOR'     ).AsString  = lsInscMfTomador)
                and (not FoCdsSefip32.Eof)
              do begin
                {Inclui os Registros tipo 32.}
                strLstSefip.Add(FoCdsSefip32.FieldByName('LINHA').AsString);
                FoCdsSefip32.Next;
              end;
            end;
          end;
          FoCdsSefip30.Next;
        end;
      end;
      FoCdsSefip10.Next;
    end;
    lsLinha90 := '90';
    lsLinha90 := lsLinha90+StrReplicate('9',51);
    lsLinha90 := lsLinha90+StrSpace(306);
    lsLinha90 := lsLinha90+'*';
    strLstSefip.Add(lsLinha90);

    if FInconsistencias.Count = 0 then begin
      strLstSefip.SaveToFile(FPath);
    end else begin
      FMostraErros.RichEditErros.Lines.Assign(FInconsistencias);
      FMostraErros.Insert(0,'                        RELAÇÃO DE INCONSISTÊNCIAS');
      FMostraErros.Insert(1,'   ');
      FMostraErros.ShowModal;
    end;
  finally
    FreeAndNil(strLstSefip);
    FreeAndNil(FMostraErros);
  end;
end;

procedure TGfip.PreencheListaEmpresas(lStrInscMfEmpresas: TStringList;
      var NGaugeEmpresa,NGaugeColaborador: TEvGauge;
      var lblEmpresa,lblColaborador: TLabel);
var
  liForEmpresa: Integer;
  loEmpresa: TEmpresa;
begin
  {Ordena a lista de Inscrições no Ministério da Fazenda das empresas em ordem
   crescente}
  lStrInscMfEmpresas.Sort;
  NGaugeEmpresa.Progress := 0;
  NGaugeEmpresa.MaxValue := lStrInscMfEmpresas.Count;
  for liForEmpresa := 0 to lStrInscMfEmpresas.Count-1 do begin
    {Instância a empresa}
    Application.ProcessMessages;
    loEmpresa := TEmpresa.Create(Self,lStrInscMfEmpresas.Strings[liForEmpresa],NGaugeColaborador,lblColaborador);
    {Adiciona a empresa a lista de empresas}
    FListaEmpresas.Add(loEmpresa);
    {Atualiza o NGauge e Label de empresa}
    lblEmpresa.Caption  := loEmpresa.FNome;
    NGaugeEmpresa.Progress := liForEmpresa+1;
    Application.ProcessMessages;
  end;
end;

end.
