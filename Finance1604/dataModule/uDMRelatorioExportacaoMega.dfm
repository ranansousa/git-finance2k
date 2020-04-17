object dmRelExportacaoMega: TdmRelExportacaoMega
  OldCreateOrder = False
  Height = 848
  Width = 1303
  object frxRelatorioExportacaoMega: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 43797.782852037040000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 72
    Top = 40
  end
  object frxDBTitulos: TfrxDBDataset
    UserName = 'TPPROVBASE'
    CloseDataSource = False
    FieldAliases.Strings = (
      'VALOR_NOMINAL=VALOR_NOMINAL'
      'DESCRICAO=DESCRICAO'
      'PARCELA=PARCELA'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'DATA_EMISSAO=DATA_EMISSAO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'FORNECEDOR=FORNECEDOR'
      'TIPO=TIPO')
    DataSet = qryTPPROVBASE
    BCDToCurrency = False
    Left = 176
    Top = 128
  end
  object frxTPROVDB: TfrxDBDataset
    UserName = 'TPPROVDB'
    CloseDataSource = False
    FieldAliases.Strings = (
      'VALOR_TOTAL=VALOR_TOTAL'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'HST_DSC=HST_DSC'
      'HST_CODIGO=HST_CODIGO'
      'CCD_DSC=CCD_DSC'
      'CONTA_DB=CONTA_DB'
      'DG_CONTA_DB=DG_CONTA_DB'
      'COD_RED_DB=COD_RED_DB')
    DataSet = qryTPPROVDB
    BCDToCurrency = False
    Left = 184
    Top = 192
  end
  object frxDBTRProv: TfrxDBDataset
    UserName = 'TRPROVBASE'
    CloseDataSource = False
    FieldAliases.Strings = (
      'VALOR_NOMINAL=VALOR_NOMINAL'
      'DESCRICAO=DESCRICAO'
      'PARCELA=PARCELA'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER'
      'DATA_EMISSAO=DATA_EMISSAO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'CLIENTE=CLIENTE'
      'TIPO=TIPO')
    DataSet = qryTRPROVBASE
    BCDToCurrency = False
    Left = 184
    Top = 345
  end
  object frxTRPROVDB: TfrxDBDataset
    UserName = 'TRPROVDB'
    CloseDataSource = False
    FieldAliases.Strings = (
      'VALOR=VALOR'
      'CCC_DSC=CCC_DSC'
      'CONTA_CR=CONTA_CR'
      'COD_RED_CR=COD_RED_CR'
      'COD_HIST=COD_HIST'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'DESCRICAO=DESCRICAO'
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DT_EMISSAO=DT_EMISSAO'
      'NUM_DOC=NUM_DOC'
      'NOME_CLIENTE=NOME_CLIENTE')
    DataSet = qryTRPROVDB
    BCDToCurrency = False
    Left = 184
    Top = 413
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 184
    Top = 40
  end
  object frxCSVExport1: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    UTF8 = False
    OpenAfterExport = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 264
    Top = 40
  end
  object frxDBTPQuitados: TfrxDBDataset
    UserName = 'TPQUITADOS'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'DATA_EMISSAO=DATA_EMISSAO'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'DESCRICAO=DESCRICAO'
      'PARCELA=PARCELA'
      'VALOR_NOMINAL=VALOR_NOMINAL'
      'IDTPB=IDTPB'
      'VALOR=VALOR'
      'NOME=NOME'
      'DSC_HIST=DSC_HIST'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'TIPO=TIPO')
    DataSet = qryTPQuitados
    BCDToCurrency = False
    Left = 456
    Top = 256
  end
  object frxTPBBanco: TfrxDBDataset
    UserName = 'TPBBanco'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'VALOR=VALOR'
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'CONTA_CR=CONTA_CR'
      'DSC_CONTA_CR=DSC_CONTA_CR'
      'COD_RED_CR=COD_RED_CR'
      'CDHIST=CDHIST'
      'COMPL=COMPL'
      'HISTORICO=HISTORICO')
    DataSet = qryObterTPBBanco
    BCDToCurrency = False
    Left = 1168
    Top = 232
  end
  object frxDBTPBCaixa: TfrxDBDataset
    UserName = 'TPBCaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TESOURARIA_DEBITO=ID_TESOURARIA_DEBITO'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'VALOR=VALOR'
      'OBSERVACAO=OBSERVACAO'
      'DESCRICAO=DESCRICAO'
      'ID_HISTORICO=ID_HISTORICO'
      'DSC_HIST=DSC_HIST'
      'HST_COD=HST_COD'
      'CONTA_CREDITO=CONTA_CREDITO'
      'DSC_CC=DSC_CC'
      'CODREDUZ=CODREDUZ')
    DataSet = qryBaixaTPCaixa
    BCDToCurrency = False
    Left = 992
    Top = 256
  end
  object frxTPBAcrescimo: TfrxDBDataset
    UserName = 'TPBAcrescimo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'ID_HISTORICO=ID_HISTORICO'
      'DSC_HIST=DSC_HIST'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'CODIGO=CODIGO'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ')
    DataSet = qryTPBAcrescimos
    BCDToCurrency = False
    Left = 659
    Top = 256
  end
  object frxTPBDeducao: TfrxDBDataset
    UserName = 'TPBDeducao'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'ID_HISTORICO=ID_HISTORICO'
      'DSC_HIST=DSC_HIST'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'CODIGO=CODIGO'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ')
    DataSet = qryTPBDeducao
    BCDToCurrency = False
    Left = 774
    Top = 256
  end
  object frxDBTRQuitados: TfrxDBDataset
    UserName = 'TRQUITADOS'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER'
      'DATA_EMISSAO=DATA_EMISSAO'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'DESCRICAO=DESCRICAO'
      'PARCELA=PARCELA'
      'VALOR=VALOR'
      'NOME=NOME'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ'
      'DSC_CC=DSC_CC'
      'DSC_HIST=DSC_HIST'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'TIPO=TIPO')
    DataSet = qryTRQuitados
    BCDToCurrency = False
    Left = 464
    Top = 459
  end
  object frxDBTRBaixa: TfrxDBDataset
    UserName = 'TRBaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'VALOR=VALOR'
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER'
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'ID_CONTA_CONTABIL_CREDITO=ID_CONTA_CONTABIL_CREDITO'
      'DSC_HIST=DSC_HIST'
      'CODIGO_HIST=CODIGO_HIST'
      'CONTA_CREDITO=CONTA_CREDITO'
      'COD_REDUZ_CREDITO=COD_REDUZ_CREDITO'
      'CONTA_DEBITO=CONTA_DEBITO'
      'COD_REDUZ_DEBITO=COD_REDUZ_DEBITO')
    DataSet = qryObterTRBaixaPorTitulo
    BCDToCurrency = False
    Left = 571
    Top = 459
  end
  object frxDBTRQuitadoBanco: TfrxDBDataset
    UserName = 'TRBBanco'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'VALOR=VALOR'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'DESCRICAO=DESCRICAO'
      'CONTA_DB=CONTA_DB'
      'DSC_CD_DB=DSC_CD_DB'
      'COD_RED_DB=COD_RED_DB'
      'CDHIST=CDHIST'
      'COMPL=COMPL'
      'HISTORICO=HISTORICO')
    DataSet = qryBaixaTRBanco
    BCDToCurrency = False
    Left = 1168
    Top = 451
  end
  object frxDBTRBCheque: TfrxDBDataset
    UserName = 'TRBCheque'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA_CHEQUE=ID_TITULO_RECEBER_BAIXA_CHEQUE'
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'VALOR=VALOR'
      'HIST_DSC=HIST_DSC'
      'HIST_COD=HIST_COD'
      'CONTA_DB=CONTA_DB'
      'CONTA_DSC_DB=CONTA_DSC_DB'
      'COD_RED_DB=COD_RED_DB')
    DataSet = qryBaixaTRCheque
    BCDToCurrency = False
    Left = 1027
    Top = 459
  end
  object frxDBTRBCaixa: TfrxDBDataset
    UserName = 'TRBCaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'ID_TESOURARIA_CREDITO=ID_TESOURARIA_CREDITO'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'VALOR=VALOR'
      'HIST_DSC=HIST_DSC'
      'HIST_COD=HIST_COD'
      'OBSERVACAO=OBSERVACAO'
      'DESCRICAO=DESCRICAO'
      'CONTA_DB=CONTA_DB'
      'CTA_DB__DSC=CTA_DB__DSC'
      'COD_RED_DB=COD_RED_DB')
    DataSet = qryBaixaTRCaixa
    BCDToCurrency = False
    Left = 920
    Top = 459
  end
  object frxDBTPB: TfrxDBDataset
    UserName = 'TPBaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'ID_CENTRO_CUSTO=ID_CENTRO_CUSTO'
      'VALOR=VALOR'
      'TIPO_BAIXA=TIPO_BAIXA'
      'DATA_EMISSAO=DATA_EMISSAO'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'DESCRICAO=DESCRICAO'
      'PARCELA=PARCELA'
      'VALOR_TP=VALOR_TP'
      'NOME=NOME'
      'HST_COD=HST_COD'
      'DSC_HIST=DSC_HIST'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'DSC_CDD=DSC_CDD'
      'CONTA_DB=CONTA_DB'
      'COD_REDUZ_DB=COD_REDUZ_DB')
    DataSet = qryObterTPBaixaPorTitulo
    BCDToCurrency = False
    Left = 560
    Top = 256
  end
  object frxTPBCheque: TfrxDBDataset
    UserName = 'TPBCheque'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA_CHEQUE=ID_TITULO_PAGAR_BAIXA_CHEQUE'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_CONTA_BANCARIA_CHEQUE=ID_CONTA_BANCARIA_CHEQUE'
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'VALOR=VALOR'
      'CONTA_CONTABIL_CREDITO=CONTA_CONTABIL_CREDITO'
      'COD_REDUZ_CREDITO=COD_REDUZ_CREDITO'
      'DSC_CC_CREDITO=DSC_CC_CREDITO'
      'CDHIST=CDHIST'
      'COMPL=COMPL'
      'HISTORICO=HISTORICO')
    DataSet = qryBaixaTPCheque
    BCDToCurrency = False
    Left = 1079
    Top = 256
  end
  object frxTRBDeducao: TfrxDBDataset
    UserName = 'TRBDeducao'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA_DE=ID_TITULO_RECEBER_BAIXA_DE'
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'ID_TIPO_DEDUCAO=ID_TIPO_DEDUCAO'
      'VALOR=VALOR'
      'DSC_HIST=DSC_HIST'
      'COD_HIST=COD_HIST'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'DSC_CONTA=DSC_CONTA'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ'
      'DSC_DEDUCAO=DSC_DEDUCAO')
    DataSet = qryTRBDeducao
    BCDToCurrency = False
    Left = 804
    Top = 459
  end
  object frxDBTRBAcrescimo: TfrxDBDataset
    UserName = 'TRBAcrescimo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA_AC=ID_TITULO_RECEBER_BAIXA_AC'
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'ID_TIPO_ACRESCIMO=ID_TIPO_ACRESCIMO'
      'VALOR=VALOR'
      'DSC_HIST=DSC_HIST'
      'COD_HIST=COD_HIST'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'DSC_CONTA=DSC_CONTA'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ'
      'DSC_DEDUCAO=DSC_DEDUCAO')
    DataSet = qryTRBAcrescimos
    BCDToCurrency = False
    Left = 680
    Top = 459
  end
  object frxDBCBT: TfrxDBDataset
    UserName = 'CBTBASE'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CONTA_BANCARIA_TRANSFERENCIA=ID_CONTA_BANCARIA_TRANSFERENCIA'
      'ID_CONTA_BANCARIA_CREDITO=ID_CONTA_BANCARIA_CREDITO'
      'ID_CONTA_BANCARIA_DEBITO=ID_CONTA_BANCARIA_DEBITO'
      'ID_TIPO_OPERACAO_BANCARIA=ID_TIPO_OPERACAO_BANCARIA'
      'VALOR=VALOR'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'IDENTIFICACAO=IDENTIFICACAO'
      'TIPO_OPERACAO=TIPO_OPERACAO'
      'TOB_CODIGO=TOB_CODIGO'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'TIPO=TIPO')
    DataSet = qryCBTBASE
    BCDToCurrency = False
    Left = 144
    Top = 680
  end
  object frxDBCBTC: TfrxDBDataset
    UserName = 'CBT_C'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'ID_TIPO_OPERACAO_BANCARIA=ID_TIPO_OPERACAO_BANCARIA'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'IDENTIFICACAO=IDENTIFICACAO'
      'CONTA_CORRENTE_CREDITO=CONTA_CORRENTE_CREDITO'
      'AGENCIA=AGENCIA'
      'TITULAR=TITULAR'
      'CODIGO_BANCO=CODIGO_BANCO'
      'SIGLA_BANCO=SIGLA_BANCO'
      'NOME_BANCO=NOME_BANCO'
      'DSC_CC_DB=DSC_CC_DB'
      'CONTA_CONTABIL_DB=CONTA_CONTABIL_DB'
      'COD_REDUZ_DB=COD_REDUZ_DB'
      'TIPO_OPERACAO=TIPO_OPERACAO'
      'TOB_CODIGO=TOB_CODIGO'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL')
    DataSet = qryCBTCR
    BCDToCurrency = False
    Left = 216
    Top = 680
  end
  object frxDBCBTD: TfrxDBDataset
    UserName = 'CBT_D'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'ID_TIPO_OPERACAO_BANCARIA=ID_TIPO_OPERACAO_BANCARIA'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'IDENTIFICACAO=IDENTIFICACAO'
      'CONTA_CORRENTE_DEBITO=CONTA_CORRENTE_DEBITO'
      'AGENCIA=AGENCIA'
      'TITULAR=TITULAR'
      'CODIGO_BANCO=CODIGO_BANCO'
      'SIGLA_BANCO=SIGLA_BANCO'
      'NOME_BANCO=NOME_BANCO'
      'DSC_CC_CR=DSC_CC_CR'
      'CONTA_CONTABIL_CR=CONTA_CONTABIL_CR'
      'COD_REDUZ_CR=COD_REDUZ_CR'
      'TIPO_OPERACAO=TIPO_OPERACAO'
      'TOB_CODIGO=TOB_CODIGO'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL')
    DataSet = qryCBTDB
    BCDToCurrency = False
    Left = 296
    Top = 688
  end
  object frxBCOCAIXA: TfrxDBDataset
    UserName = 'TRFBCOCAIXA'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CONTA_BANCARIA_DEBITO=ID_CONTA_BANCARIA_DEBITO'
      'ID_TIPO_OPERACAO_BANCARIA=ID_TIPO_OPERACAO_BANCARIA'
      'DESCRICAO=DESCRICAO'
      'VALOR=VALOR'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'IDENTIFICACAO=IDENTIFICACAO'
      'CONTA_CONTABIL_CREDITO=CONTA_CONTABIL_CREDITO'
      'COD_REDUZ_CREDITO=COD_REDUZ_CREDITO'
      'DSC_CC_CREDITO=DSC_CC_CREDITO'
      'CONTA_CONTABIL_DEBITO=CONTA_CONTABIL_DEBITO'
      'COD_REDUZ_DEBITO=COD_REDUZ_DEBITO'
      'DSC_CC_DEBITO=DSC_CC_DEBITO'
      'TIPO_OPERACAO=TIPO_OPERACAO'
      'TOB_CODIGO=TOB_CODIGO'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'TIPO=TIPO')
    DataSet = qryBancoCaixa
    BCDToCurrency = False
    Left = 368
    Top = 688
  end
  object frxdbdtstDBTRF_DO_Banco: TfrxDBDataset
    UserName = 'TransferenciaPorBanco'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'ID_CONTA_BANCARIA_DEBITO=ID_CONTA_BANCARIA_DEBITO'
      'DESCRICAO=DESCRICAO'
      'VALOR_NOMINAL=VALOR_NOMINAL'
      'DSC_HIST=DSC_HIST'
      'CODIGO_HIST=CODIGO_HIST'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'CONTA_CONTABIL_DEBITO=CONTA_CONTABIL_DEBITO'
      'COD_REDUZ_DEBITO=COD_REDUZ_DEBITO'
      'DSC_CC_DEBITO=DSC_CC_DEBITO'
      'TIPO=TIPO')
    DataSet = dmTCConsulta.qryObterPorContaBancariaDebito
    BCDToCurrency = False
    Left = 944
    Top = 576
  end
  object frxTRFCaixaBanco: TfrxDBDataset
    UserName = 'TRFCAIXABANCO'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CONTA_BANCARIA_CREDITO=ID_CONTA_BANCARIA_CREDITO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TIPO_OPERACAO_BANCARIA=ID_TIPO_OPERACAO_BANCARIA'
      'DESCRICAO=DESCRICAO'
      'VALOR=VALOR'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'IDENTIFICACAO=IDENTIFICACAO'
      'CONTA_BANCO=CONTA_BANCO'
      'AGENCIA=AGENCIA'
      'CONTA_CONTABIL_CR=CONTA_CONTABIL_CR'
      'COD_REDUZ_CR=COD_REDUZ_CR'
      'DSC_CC_CR=DSC_CC_CR'
      'TIPO_OPERACAO=TIPO_OPERACAO'
      'TOB_CODIGO=TOB_CODIGO'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'CONTA_CONTABIL_DB=CONTA_CONTABIL_DB'
      'COD_REDUZ_DB=COD_REDUZ_DB'
      'DSC_CC_DB=DSC_CC_DB'
      'TIPO=TIPO')
    DataSet = qryTRFCAIXABANCO
    BCDToCurrency = False
    Left = 48
    Top = 672
  end
  object frxdbdtstDBTRF_TESBanco: TfrxDBDataset
    UserName = 'TransferenciaTesourariaBanco'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'DESCRICAO=DESCRICAO'
      'VALOR_NOMINAL=VALOR_NOMINAL'
      'DSC_HIST=DSC_HIST'
      'CODIGO_HIST=CODIGO_HIST'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'CONTA_CONTABIL_CREDITO=CONTA_CONTABIL_CREDITO'
      'COD_REDUZ_CREDITO=COD_REDUZ_CREDITO'
      'DSC_CC_CREDITO=DSC_CC_CREDITO')
    DataSet = dmTDConsulta.qryObterPorContaBancariaCredito
    BCDToCurrency = False
    Left = 944
    Top = 648
  end
  object qryTPPROVBASE: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      '   SELECT distinct'
      '              SUM(TP.VALOR_NOMINAL) AS VALOR_NOMINAL, '
      '              max(TP.descricao) as descricao, '
      '             -- MAX(position('#39'/'#39' in TP.parcela)) AS PARCELA,'
      '              COUNT(TP.REGISTRO_PROVISAO) AS PARCELA,'
      '              TP.REGISTRO_PROVISAO, '
      '              MAX(TP.ID_ORGANIZACAO) AS ID_ORGANIZACAO,'
      '              max(tp.id_titulo_pagar) as id_titulo_pagar,'
      '              max(TP.data_emissao)as data_emissao,'
      '              max(TP.numero_documento) as NUMERO_DOCUMENTO,'
      '              max(CED.NOME) AS FORNECEDOR,'
      '             '#39'TPPROV'#39' as TIPO'
      ''
      ''
      'FROM TITULO_PAGAR TP'
      
        'JOIN CEDENTE CED ON (CED.ID_CEDENTE = TP.ID_CEDENTE) AND (CED.ID' +
        '_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (TP.DATA_EMISSAO BETWEEN :pDataInicial AND :pDataFinal) AN' +
        'D'
      '      (TP.REGISTRO_PROVISAO IS NOT NULL ) AND'
      '      (TP.ID_TIPO_STATUS <> '#39'EXCLUIDO'#39') AND '
      '      (TP.ID_LOTE_CONTABIL IS NULL) AND'
      '      (TP.ID_LOTE_TPB IS NULL)'
      ''
      ''
      ' GROUP BY TP.REGISTRO_PROVISAO'
      ''
      'ORDER BY DATA_EMISSAO ASC, VALOR_NOMINAL DESC;'
      '')
    Left = 32
    Top = 128
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object frxTPPROVCR: TfrxDBDataset
    UserName = 'TPPROVCR'
    CloseDataSource = False
    FieldAliases.Strings = (
      'VALOR_TOTAL=VALOR_TOTAL'
      'CCC_DSC=CCC_DSC'
      'CONTA_CR=CONTA_CR'
      'COD_RED_CR=COD_RED_CR'
      'COD_HIST=COD_HIST'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'DESCRICAO=DESCRICAO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DT_EMISSAO=DT_EMISSAO'
      'NUM_DOC=NUM_DOC'
      'NOME_CED=NOME_CED')
    DataSet = qryTPPROVCR
    BCDToCurrency = False
    Left = 184
    Top = 280
  end
  object qryTPPROVCR: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT distinct sum(tp.valor_nominal) as valor_total,'
      '              max(CCC.DESCRICAO) AS CCC_DSC,'
      '              max(CCC.CONTA)  AS CONTA_CR,'
      '              max(CCC.CODREDUZ)  AS COD_RED_CR,'
      '              max(H.CODIGO) AS COD_HIST,'
      '              tp.registro_provisao, '
      '              max(tp.descricao) as descricao,               '
      '              max(tp.id_titulo_pagar) as ID_TITULO_PAGAR, '
      '              MAX(TP.ID_ORGANIZACAO) AS ID_ORGANIZACAO,'
      '              max(TP.data_emissao)as dt_emissao,'
      '              max(TP.numero_documento) as num_doc,'
      '              max(CED.NOME) AS NOME_CED'
      ''
      'FROM '
      'TITULO_PAGAR TP'
      'INNER join CEDENTE CED ON (CED.id_cedente = TP.id_cedente)'
      
        'INNER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = TP.ID_' +
        'CONTA_CONTABIL_CREDITO) AND (CCC.ID_ORGANIZACAO = TP.ID_ORGANIZA' +
        'CAO)'
      
        'INNER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO) AND' +
        ' (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE'
      '      (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TP.REGISTRO_PROVISAO = :PREGISTRO)'
      ''
      'GROUP BY TP.REGISTRO_PROVISAO')
    Left = 32
    Top = 264
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PREGISTRO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPPROVDB: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.DefaultParamDataType = ftString
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'select'
      '   (C.VALOR_TOTAL) AS VALOR_TOTAL,'
      '    C.registro_provisao,'
      '    C.id_organizacao,'
      '    c.id_titulo_pagar,'
      '    C.HST_DSC,'
      '    C.HST_CODIGO,'
      '    C.CCD_DSC,'
      '    C.CONTA_DB,'
      '    C.DG_CONTA_DB,'
      '    C.COD_RED_DB'
      '  from ('
      '        select'
      
        '         IIF(B.POS <> 0, cast(trim(substring(B.parcela from (B.P' +
        'OS + 1) for 19)) as integer),'
      '                    cast(trim(B.parcela) AS INTEGER)) as qtd,'
      '          B.VALOR_TOTAL,'
      '          B.PARCELA,'
      '          B.registro_provisao,'
      '          B.id_organizacao,'
      '          B.id_titulo_pagar,'
      '          B.HST_DSC,'
      '          B.HST_CODIGO,'
      '          B.CCD_DSC,'
      '          B.CONTA_DB,'
      '          B.DG_CONTA_DB,'
      '          B.COD_RED_DB'
      ''
      'from ('
      '        select'
      '          position('#39'/'#39' in A.parcela) as POS,'
      '          A.PARCELA,'
      '          A.VALOR_TOTAL,'
      '          A.registro_provisao,'
      '          A.id_organizacao,'
      '          A.id_titulo_pagar,'
      '          A.HST_DSC,'
      '          A.HST_CODIGO,'
      '          A.CCD_DSC,'
      '          A.CONTA_DB,'
      '          A.DG_CONTA_DB,'
      '          A.COD_RED_DB'
      '        from ('
      '            select'
      ''
      '              TPH.id_historico,'
      '              SUM(TPH.valor) AS VALOR_TOTAL,'
      '              MAX(tp.registro_provisao) AS REGISTRO_PROVISAO,'
      '              MAX(TP.PARCELA) AS PARCELA,'
      '              MAX(tp.id_organizacao) AS ID_ORGANIZACAO,'
      '              MAX(tp.id_titulo_pagar) AS ID_TITULO_PAGAR,'
      '              MAX(H.descricao) AS HST_DSC,'
      '              MAX(H.CODIGO) AS HST_CODIGO,'
      '              MAX(CCD.DESCRICAO) AS CCD_DSC,'
      '              MAX(CCD.CONTA)  AS CONTA_DB,'
      '              MAX(CCD.DGVER)  AS DG_CONTA_DB,'
      '              MAX(CCD.CODREDUZ)  AS COD_RED_DB'
      ''
      ''
      '            FROM  titulo_pagar_historico tPH'
      
        '            LEFT OUTER JOIN titulo_pagar TP ON (TP.ID_TITULO_PAG' +
        'AR = TPH.ID_TITULO_PAGAR)'
      
        '            LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TPH' +
        '.ID_HISTORICO) AND (H.ID_ORGANIZACAO = TPH.ID_ORGANIZACAO)'
      
        '            LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_' +
        'CONTABIL = H.ID_CONTA_CONTABIL)'
      ''
      '            WHERE'
      '                (TP.REGISTRO_PROVISAO = :PREGISTRO) AND'
      '                (tp.id_organizacao = :PIDORGANIZACAO)'
      '            '
      '            GROUP BY TPH.id_historico'
      ''
      '            ) A'
      ''
      '       ) B'
      '       ) C')
    Left = 32
    Top = 192
    ParamData = <
      item
        Name = 'PREGISTRO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dsDetalhesTP: TDataSource
    DataSet = qryTPPROVBASE
    OnDataChange = dsDetalhesTPDataChange
    Left = 104
    Top = 240
  end
  object qryTPQuitados: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.ID_ORGANIZACAO,'
      '       TP.ID_TITULO_PAGAR,'
      '       TP.DATA_EMISSAO,'
      '       TP.DATA_PAGAMENTO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.REGISTRO_PROVISAO,'
      '       TP.DESCRICAO,'
      '       TP.PARCELA,'
      '       TP.VALOR_NOMINAL,'
      '       TPB.ID_TITULO_PAGAR_BAIXA as IDTPB,'
      '       TPB.VALOR_PAGO as VALOR,'
      '        C.NOME,'
      '        H.DESCRICAO as dsc_hist, H.DESCRICAO_REDUZIDA,'
      '       '#39'TPB'#39' as TIPO'
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.ID_TITULO_PAGAR =' +
        ' TP.ID_TITULO_PAGAR) AND (TPB.ID_ORGANIZACAO = TP.ID_ORGANIZACAO' +
        ')'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TP.ID_ORGANIZACAO = :pIdOrganizacao) '
      
        '       AND (TP.DATA_PAGAMENTO BETWEEN :pDataInicial AND :pDataFi' +
        'nal) '
      '       AND (TP.ID_TIPO_STATUS  IN ('#39'QUITADO'#39','#39'PARCIAL'#39') )'
      '       AND (TP.ID_LOTE_CONTABIL IS NULL) '
      ''
      'ORDER BY TP.DATA_PAGAMENTO ASC, TP.VALOR_NOMINAL DESC;')
    Left = 448
    Top = 80
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object dsDetalhesTPB: TDataSource
    DataSet = qryTPQuitados
    OnDataChange = dsDetalhesTPBDataChange
    Left = 568
    Top = 112
  end
  object qryObterTPBaixaPorTitulo: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM//YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      ' SELECT TPB.id_organizacao, '
      '        TPB.id_titulo_pagar_baixa,   '
      '        TPB.id_titulo_pagar,         '
      '        TPB.id_centro_custo,         '
      '        TPB.valor_pago as VALOR,              '
      '        TPB.tipo_baixa,              '
      '        TP.DATA_EMISSAO,             '
      '        TP.DATA_PAGAMENTO,           '
      '        TP.NUMERO_DOCUMENTO,         '
      '        TP.REGISTRO_PROVISAO,        '
      '        TP.DESCRICAO,                '
      '        TP.PARCELA,                  '
      '        TP.VALOR_NOMINAL as VALOR_TP,   '
      '        C.NOME,                      '
      '        H.CODIGO AS HST_COD,         '
      '        H.DESCRICAO as dsc_hist,     '
      '        H.DESCRICAO_REDUZIDA,        '
      '        CCD.DESCRICAO AS DSC_CDD,    '
      '        CCD.CONTA AS CONTA_DB,       '
      '        CCD.CODREDUZ AS COD_REDUZ_DB '
      ''
      ' FROM TITULO_PAGAR_BAIXA TPB         '
      ''
      
        ' LEFT OUTER JOIN titulo_pagar TP ON (TP.ID_TITULO_PAGAR = TPB.ID' +
        '_TITULO_PAGAR) '
      
        ' LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND' +
        ' (C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) '
      
        ' LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORIC' +
        'O) AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) '
      
        ' LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = ' +
        'TP.ID_CONTA_CONTABIL_CREDITO ) AND (CCD.ID_ORGANIZACAO = TP.ID_O' +
        'RGANIZACAO) '
      ''
      '--WHERE TP.DATA_PAGAMENTO = '#39'06.12.2019'#39)
    Left = 456
    Top = 168
  end
  object qryBaixaTPCaixa: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ' SELECT td.ID_TITULO_PAGAR_BAIXA,'
      '          td.id_organizacao,'
      '          td.id_tesouraria_debito, '
      '          td.data_movimento, '
      '          td.valor_nominal as VALOR,'
      '          td.observacao, '
      '          td.descricao, '
      '          h.id_historico,'
      '          h.descricao as DSC_HIST,'
      '          H.CODIGO AS HST_COD,'
      '          cc.conta as CONTA_CREDITO, '
      '          cc.descricao as DSC_CC,'
      '          cc.codreduz'
      '   FROM TESOURARIA_DEBITO TD'
      
        '   left outer join historico h on (h.id_historico = td.id_histor' +
        'ico) and (h.id_organizacao = td.id_organizacao)'
      
        '   left outer join conta_contabil cc on (cc.id_conta_contabil = ' +
        'H.id_conta_contabil) and (cc.id_organizacao = td.id_organizacao)'
      ''
      ' WHERE (TD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '         (TD.id_titulo_pagar_baixa = :PIDTITULOPAGARBAIXA)')
    Left = 944
    Top = 64
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryBaixaTPCheque: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ''
      'SELECT  TPBC.ID_TITULO_PAGAR_BAIXA_CHEQUE,'
      '        TPBC.ID_ORGANIZACAO,'
      '        TPBC.ID_CONTA_BANCARIA_CHEQUE,'
      '        TPBC.ID_TITULO_PAGAR_BAIXA,'
      '        TPBC.VALOR as VALOR,'
      '        CC.CONTA AS CONTA_CONTABIL_CREDITO,'
      '        CC.CODREDUZ AS COD_REDUZ_CREDITO,'
      '        CC.DESCRICAO AS DSC_CC_CREDITO,'
      '        TOB.CODIGO AS CDHIST,'
      '        TOB.DESCRICAO AS COMPL,'
      '        TOB.DESCRICAO AS HISTORICO'
      ''
      ''
      'FROM TITULO_PAGAR_BAIXA_CHEQUE TPBC'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = TPBC.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGAN' +
        'IZACAO = TPBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria_cheque CBC ON (CBC.ID_CONTA_BANCA' +
        'RIA_CHEQUE = TPBC.ID_CONTA_BANCARIA_CHEQUE)AND (CBC.ID_ORGANIZAC' +
        'AO = TPBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = CBC' +
        '.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = TPBC.ID_ORGANIZACAO' +
        ')'
      
        'LEFT OUTER JOIN conta_contabil CC ON (CC.id_conta_contabil = CB.' +
        'id_conta_contabil) AND (CC.ID_ORGANIZACAO = TPBC.ID_ORGANIZACAO)'
      ''
      ''
      'WHERE (TPBC.id_organizacao = :PIDORGANIZACAO) AND'
      '       (TPBC.ID_TITULO_PAGAR_BAIXA = :PIDTITULOPAGARBAIXA)'
      '')
    Left = 1032
    Top = 64
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterTPBBancoOLD: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT cbd.id_conta_bancaria,cbd.valor,'
      ' CBD.ID_CONTA_BANCARIA_CHEQUE,'
      '        cbd.data_movimento,cbd.descricao as DSC_BAIXA,'
      '        cc.conta as CONTA_CREDITO,'
      '        cc.descricao as DSC_CC,cc.codreduz'
      'FROM conta_bancaria_debito CBD'
      
        'LEFT OUTER  join conta_bancaria cb on (cb.id_conta_bancaria = cb' +
        'd.id_conta_bancaria)'
      
        'LEFT OUTER join conta_contabil cc on (cc.id_conta_contabil = cb.' +
        'id_conta_contabil)'
      'WHERE (cbd.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '         (cbd.id_titulo_pagar = :PIDTITULOPAGAR) AND'
      '         (cbd.ID_LOTE_CONTABIL IS NULL);')
    Left = 680
    Top = 16
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBAcrescimos: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TPBA.id_titulo_pagar_baixa, '
      '       TPBA.valor as VALOR, '
      '       TA.descricao,'
      '       TA.id_historico, '
      '       H.descricao as dsc_hist, '
      '       H.id_conta_contabil,'
      '       H.Codigo,'
      '       CC.conta, CC.codreduz'
      'FROM titulo_pagar_baixa_ac TPBA'
      ''
      
        'JOIN tipo_acrescimo TA ON (TA.id_tipo_acrescimo = TPBA.id_tipo_a' +
        'crescimo) AND (TA.ID_ORGANIZACAO = TPBA.ID_ORGANIZACAO)'
      
        'JOIN HISTORICO H ON (H.id_historico = TA.id_historico) AND (H.ID' +
        '_ORGANIZACAO = TA.ID_ORGANIZACAO)'
      
        'JOIN conta_contabil CC ON (CC.id_conta_contabil = H.id_conta_con' +
        'tabil) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBA.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '      (TPBA.id_titulo_pagar_baixa = :pIdTitutloPagarBaixa)'
      ''
      'order by TPBA.valor')
    Left = 688
    Top = 152
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITUTLOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBDeducao: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    SQL.Strings = (
      'SELECT TPBD.id_titulo_pagar_baixa, '
      '       TPBD.valor as VALOR, '
      '       TD.descricao,'
      '       TD.id_historico, '
      '       H.descricao as dsc_hist, '
      '       H.id_conta_contabil, '
      '       H.codigo,'
      '       CC.conta, '
      '       CC.codreduz'
      'FROM titulo_pagar_baixa_de TPBD'
      ''
      
        'JOIN tipo_deducao TD ON (TD.ID_TIPO_DEDUCAO = TPBD.ID_TIPO_DEDUC' +
        'AO) AND (TD.ID_ORGANIZACAO = TPBD.ID_ORGANIZACAO)'
      
        'JOIN HISTORICO H ON (H.id_historico = TD.id_historico) AND (H.ID' +
        '_ORGANIZACAO = TD.ID_ORGANIZACAO)'
      
        'JOIN conta_contabil CC ON (CC.id_conta_contabil = H.id_conta_con' +
        'tabil) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBD.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '      (TPBD.id_titulo_pagar_baixa = :pIdTitutloPagarBaixa)'
      ''
      'ORDER BY TPBD.VALOR DESC')
    Left = 784
    Top = 152
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITUTLOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBHistorico: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.DefaultParamDataType = ftString
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TPH.id_titulo_pagar_historico,'
      '       TPH.id_organizacao,'
      '       TPH.id_historico,'
      '       TPH.id_titulo_pagar,'
      '       TPH.id_conta_contabil_debito,'
      '       TPH.valor,'
      '       H.DESCRICAO AS HST_DSC,'
      '       H.DESCRICAO_REDUZIDA AS HST_DSC_RED,'
      '       H.CODIGO AS HST_COD,'
      '       CD.conta AS CONTA_DB,'
      '       CD.DESCRICAO AS DSC_CONTA_DB,'
      '       CD.codreduz AS COD_RED_DB'
      ''
      'FROM TITULO_PAGAR_HISTORICO TPH'
      ''
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TPH.ID_HISTORIC' +
        'O) AND (H.ID_ORGANIZACAO = TPH.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_contabil CD ON (CD.id_conta_contabil = H.i' +
        'd_conta_contabil) and (CD.ID_ORGANIZACAO = TPH.ID_ORGANIZACAO)'
      
        'left OUTER JOIN titulo_pagar TP ON (TP.id_titulo_pagar = TPH.id_' +
        'titulo_pagar) and (TP.ID_ORGANIZACAO = TPH.ID_ORGANIZACAO)'
      ''
      'WHERE  (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) AND '
      '       (TPH.id_titulo_pagar = :PIDTP)'
      '  AND ((TP.registro_provisao is null ) )'
      '  '
      'ORDER BY TPH.VALOR')
    Left = 908
    Top = 136
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTP'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object frxTPBHistorico: TfrxDBDataset
    UserName = 'TPBHistorico'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_HISTORICO=ID_TITULO_PAGAR_HISTORICO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_HISTORICO=ID_HISTORICO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'ID_CONTA_CONTABIL_DEBITO=ID_CONTA_CONTABIL_DEBITO'
      'VALOR=VALOR'
      'HST_DSC=HST_DSC'
      'HST_DSC_RED=HST_DSC_RED'
      'HST_COD=HST_COD'
      'CONTA_DB=CONTA_DB'
      'DSC_CONTA_DB=DSC_CONTA_DB'
      'COD_RED_DB=COD_RED_DB')
    DataSet = qryTPBHistorico
    BCDToCurrency = False
    Left = 888
    Top = 256
  end
  object qryObterTPBBanco: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TPBI.ID_TITULO_PAGAR_BAIXA,'
      '       TPBI.ID_ORGANIZACAO,'
      '       TPBI.VALOR as VALOR,'
      '       TPBI.id_conta_bancaria,'
      '       CC.conta AS CONTA_CR,'
      '       CC.DESCRICAO AS DSC_CONTA_CR,'
      '       CC.codreduz AS COD_RED_CR,'
      '       TOB.CODIGO AS CDHIST,'
      '       TOB.DESCRICAO AS COMPL,'
      '       TOB.DESCRICAO AS HISTORICO'
      ''
      '        '
      'FROM TITULO_PAGAR_BAIXA_INTERNET TPBI'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = TPBI.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGAN' +
        'IZACAO = TPBI.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = TPB' +
        'I.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = TPBI.ID_ORGANIZACA' +
        'O)'
      
        'LEFT OUTER JOIN conta_contabil CC ON (CC.id_conta_contabil = CB.' +
        'id_conta_contabil) AND (CC.ID_ORGANIZACAO = TPBI.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBI.ID_ORGANIZACAO = :PIDORGANIZACAO )AND'
      '      (TPBI.ID_TITULO_PAGAR_BAIXA = :PIDTPB)'
      ''
      'ORDER BY TPBI.VALOR;')
    Left = 1128
    Top = 72
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTPB'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qry1: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM//YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      '--pega a conta debito do TP que foi provisionado'
      ''
      'SELECT TPB.id_organizacao,'
      '       TPB.id_titulo_pagar_baixa,'
      '       TPB.id_titulo_pagar,'
      '       TPB.id_centro_custo,'
      '       TPB.valor_pago,'
      '       TPB.tipo_baixa,'
      '       TP.DATA_EMISSAO,'
      '       TP.DATA_PAGAMENTO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DESCRICAO,'
      '       TP.PARCELA,'
      '       TP.id_conta_contabil_credito,'
      '       TP.VALOR_NOMINAL as VALOR,'
      '       C.NOME,'
      '       CCD.DESCRICAO AS DSC_CDD,'
      '       CCD.CONTA AS CONTA_DB,'
      '       CCD.CODREDUZ AS COD_REDUZ_DB,'
      '       '#39'TPB'#39' as TIPO'
      ''
      'FROM TITULO_PAGAR_BAIXA TPB'
      ''
      
        'LEFT OUTER JOIN titulo_pagar TP ON (TP.ID_TITULO_PAGAR = TPB.ID_' +
        'TITULO_PAGAR)'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = t' +
        'p.id_conta_contabil_credito) AND (CCD.ID_ORGANIZACAO = TP.ID_ORG' +
        'ANIZACAO)'
      ''
      ''
      'WHERE (TPB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TPB.id_titulo_pagar =:pIdtituloPagar) AND'
      '      (TPB.ID_LOTE_CONTABIL IS NULL)'
      ''
      'ORDER BY TP.DATA_PAGAMENTO ASC, TP.VALOR_NOMINAL DESC;')
    Left = 576
    Top = 16
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTRPROVBASE: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT distinct'
      '              SUM(TR.VALOR_NOMINAL) AS VALOR_NOMINAL,'
      '              max(TR.descricao) as descricao, '
      '              MAX(position('#39'/'#39' in TR.parcela)) AS PARCELA,'
      '              TR.REGISTRO_PROVISAO, '
      '              MAX(TR.ID_ORGANIZACAO) AS ID_ORGANIZACAO,'
      '              max(TR.id_titulo_RECEBER) as id_titulo_RECEBER,'
      '              max(TR.data_emissao)as data_emissao,'
      '              max(TR.numero_documento) as NUMERO_DOCUMENTO,'
      '              max(S.NOME) AS CLIENTE,'
      '             '#39'TRPROV'#39' as TIPO'
      ''
      ''
      'FROM TITULO_RECEBER TR'
      
        'JOIN SACADO S ON (S.ID_SACADO = TR.ID_SACADO) AND (S.ID_ORGANIZA' +
        'CAO = TR.ID_ORGANIZACAO)'
      ''
      'WHERE (TR.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (TR.DATA_EMISSAO BETWEEN :pDataInicial AND :pDataFinal) AN' +
        'D'
      '      (TR.IS_PROVISAO = 1) AND'
      '      (TR.ID_TIPO_STATUS = '#39'ABERTO'#39') AND'
      '      (TR.ID_LOTE_CONTABIL IS NULL) AND'
      '      (TR.DATA_PAGAMENTO IS NULL)'
      ''
      ''
      ' GROUP BY TR.REGISTRO_PROVISAO'
      ''
      'ORDER BY DATA_EMISSAO ASC, VALOR_NOMINAL DESC;'
      '')
    Left = 32
    Top = 344
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryTRPROVCR: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT '
      '   (C.VALOR_TOTAL) AS VALOR,'
      '    C.registro_provisao,'
      '    C.id_organizacao,'
      '    c.id_titulo_receber,'
      '    C.HST_DSC,'
      '    C.HST_CODIGO,'
      '    C.CCD_DSC,'
      '    C.CONTA_DB,'
      '    C.DG_CONTA_DB,'
      '    C.COD_RED_DB'
      '  from ('
      '        select'
      
        '         IIF(B.POS <> 0, cast(trim(substring(B.parcela from (B.P' +
        'OS + 1) for 19)) as integer),'
      '                    cast(trim(B.parcela) AS INTEGER)) as qtd,'
      '          B.VALOR_TOTAL,'
      '          B.PARCELA,'
      '          B.registro_provisao,'
      '          B.id_organizacao,'
      '          B.id_titulo_receber,'
      '          B.HST_DSC,'
      '          B.HST_CODIGO,'
      '          B.CCD_DSC,'
      '          B.CONTA_DB,'
      '          B.DG_CONTA_DB,'
      '          B.COD_RED_DB'
      ''
      'from ('
      '        select'
      '          position('#39'/'#39' in A.parcela) as POS,'
      '          A.PARCELA,'
      '          A.VALOR_TOTAL,'
      '          A.registro_provisao,'
      '          A.id_organizacao,'
      '          A.id_titulo_receber,'
      '          A.HST_DSC,'
      '          A.HST_CODIGO,'
      '          A.CCD_DSC,'
      '          A.CONTA_DB,'
      '          A.DG_CONTA_DB,'
      '          A.COD_RED_DB'
      '        from ('
      '            select'
      ''
      '              TRH.id_historico,'
      '              SUM(TRH.valor) AS VALOR_TOTAL,'
      '              MAX(TR.registro_provisao) AS REGISTRO_PROVISAO,'
      '              MAX(TR.PARCELA) AS PARCELA,'
      '              MAX(TR.id_organizacao) AS ID_ORGANIZACAO,'
      '              MAX(TR.id_titulo_receber) AS ID_TITULO_RECEBER,'
      '              MAX(H.descricao) AS HST_DSC,'
      '              MAX(H.CODIGO) AS HST_CODIGO,'
      '              MAX(CCD.DESCRICAO) AS CCD_DSC,'
      '              MAX(CCD.CONTA)  AS CONTA_DB,'
      '              MAX(CCD.DGVER)  AS DG_CONTA_DB,'
      '              MAX(CCD.CODREDUZ)  AS COD_RED_DB'
      ''
      ''
      '            FROM  titulo_receber_historico TRH'
      
        '            LEFT OUTER JOIN titulo_receber TR ON (TR.ID_TITULO_R' +
        'ECEBER = TRH.ID_TITULO_RECEBER)'
      
        '            LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TRH' +
        '.ID_HISTORICO) AND (H.ID_ORGANIZACAO = TRH.ID_ORGANIZACAO)'
      
        '            LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_' +
        'CONTABIL = H.ID_CONTA_CONTABIL)'
      ''
      '            WHERE'
      '               (TR.REGISTRO_PROVISAO = :PREGISTRO) AND'
      '               (TR.id_organizacao = :PIDORGANIZACAO)'
      '            '
      '            GROUP BY TRH.id_historico'
      ''
      '            ) A'
      ''
      '       ) B'
      '       ) C'
      '')
    Left = 32
    Top = 480
    ParamData = <
      item
        Name = 'PREGISTRO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTRPROVDB: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.DefaultParamDataType = ftString
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      ''
      ''
      'SELECT distinct sum(TR.valor_nominal) as valor,'
      '              max(CCC.DESCRICAO) AS CCC_DSC,'
      '              max(CCC.CONTA)  AS CONTA_CR,'
      '              max(CCC.CODREDUZ)  AS COD_RED_CR,'
      '              max(H.CODIGO) AS COD_HIST,'
      '              TR.registro_provisao, '
      '              max(TR.descricao) as descricao,               '
      '              max(TR.ID_titulo_receber) as ID_TITULO_RECEBER, '
      '              MAX(TR.ID_ORGANIZACAO) AS ID_ORGANIZACAO,'
      '              max(TR.data_emissao) as dt_emissao,'
      '              max(TR.numero_documento) as num_doc,'
      '              max(S.NOME) AS NOME_CLIENTE'
      ''
      'FROM '
      'TITULO_RECEBER TR'
      'INNER JOIN SACADO S ON (S.ID_SACADO = TR.ID_SACADO)'
      
        'INNER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = TR.ID_' +
        'CONTA_CONTABIL_DEBITO) AND (CCC.ID_ORGANIZACAO = TR.ID_ORGANIZAC' +
        'AO)'
      
        'INNER JOIN HISTORICO H ON (H.ID_HISTORICO = TR.ID_HISTORICO) AND' +
        ' (H.ID_ORGANIZACAO = TR.ID_ORGANIZACAO)'
      ''
      '       WHERE'
      '               (TR.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '                 (TR.REGISTRO_PROVISAO = :PREGISTRO)'
      '            '
      ''
      'GROUP BY TR.REGISTRO_PROVISAO')
    Left = 32
    Top = 408
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PREGISTRO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dsDetalhesTR: TDataSource
    DataSet = qryTRPROVBASE
    OnDataChange = dsDetalhesTRDataChange
    Left = 104
    Top = 392
  end
  object frxTRPROVCR: TfrxDBDataset
    UserName = 'TRPROVCR'
    CloseDataSource = False
    FieldAliases.Strings = (
      'VALOR=VALOR'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER'
      'HST_DSC=HST_DSC'
      'HST_CODIGO=HST_CODIGO'
      'CCD_DSC=CCD_DSC'
      'CONTA_DB=CONTA_DB'
      'DG_CONTA_DB=DG_CONTA_DB'
      'COD_RED_DB=COD_RED_DB')
    DataSet = qryTRPROVCR
    BCDToCurrency = False
    Left = 184
    Top = 480
  end
  object qryObterTRBaixaPorTitulo: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM//YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT  TR.VALOR_NOMINAL AS VALOR,'
      '        TRB.ID_TITULO_RECEBER,'
      '        TRB.ID_TITULO_RECEBER_BAIXA,'
      '        TR.ID_CONTA_CONTABIL_CREDITO,'
      '        H.DESCRICAO AS DSC_HIST,'
      '        H.CODIGO AS CODIGO_HIST,'
      '        CCC.CONTA AS CONTA_CREDITO,'
      '        CCC.CODREDUZ AS COD_REDUZ_CREDITO,'
      '        CCD.CONTA AS CONTA_DEBITO,'
      '        CCD.CODREDUZ AS COD_REDUZ_DEBITO'
      ''
      'FROM TITULO_RECEBER_BAIXA TRB'
      
        'LEFT OUTER JOIN TITULO_RECEBER TR ON (TR.ID_TITULO_RECEBER = TRB' +
        '.ID_TITULO_RECEBER) AND (TR.ID_ORGANIZACAO = TRB.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TR.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TRB.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = T' +
        'R.ID_CONTA_CONTABIL_CREDITO) AND (CCC.ID_ORGANIZACAO = TRB.ID_OR' +
        'GANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = T' +
        'R.ID_CONTA_CONTABIL_DEBITO) AND (CCD.ID_ORGANIZACAO = TRB.ID_ORG' +
        'ANIZACAO)'
      ''
      'WHERE (TRB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TRB.ID_TITULO_RECEBER =:PIDTITULORECEBER) AND'
      '      (TRB.ID_LOTE_CONTABIL IS NULL)'
      ''
      'ORDER BY TRB.VALOR_PAGO DESC')
    Left = 568
    Top = 376
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULORECEBER'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTRQuitados: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayDate, fvFmtDisplayTime, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TR.ID_ORGANIZACAO,'
      '       TR.ID_TITULO_RECEBER,'
      '       TR.DATA_EMISSAO,'
      '       TR.DATA_PAGAMENTO,'
      '       TR.NUMERO_DOCUMENTO,'
      '       TR.DESCRICAO,'
      '       TR.PARCELA,'
      '       TR.VALOR_NOMINAL as VALOR,'
      '       S.NOME,'
      '       CC.conta,CC.codreduz,CC.DESCRICAO AS DSC_CC,'
      '       H.DESCRICAO as dsc_hist, H.DESCRICAO_REDUZIDA,'
      '       '#39'TRB'#39' as TIPO'
      ''
      'FROM TITULO_RECEBER TR'
      
        'LEFT OUTER JOIN SACADO S ON (S.ID_SACADO = TR.ID_SACADO) AND (S.' +
        'ID_ORGANIZACAO = TR.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TR.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TR.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_contabil CC on (CC.id_conta_contabil = TR.' +
        'id_conta_contabil_debito) AND (CC.ID_ORGANIZACAO = TR.ID_ORGANIZ' +
        'ACAO)'
      ''
      'WHERE (TR.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (TR.DATA_PAGAMENTO  BETWEEN :pDataInicial AND :pDataFinal)' +
        ' AND'
      '      (TR.ID_TIPO_STATUS = :pIdStatus) AND'
      '      (TR.ID_LOTE_CONTABIL IS NULL) AND'
      '      (TR.DATA_PAGAMENTO IS NOT NULL)'
      ''
      ''
      'ORDER BY TR.DATA_PAGAMENTO ASC, TR.VALOR_NOMINAL DESC;')
    Left = 464
    Top = 376
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PIDSTATUS'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTRBAcrescimos: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TRBAC.ID_TITULO_RECEBER_BAIXA_AC,'
      '    TRBAC.ID_TITULO_RECEBER_BAIXA,'
      '    TRBAC.ID_TIPO_ACRESCIMO,'
      '    TRBAC.VALOR as VALOR,'
      '    H.DESCRICAO AS DSC_HIST,'
      '    H.CODIGO AS COD_HIST,'
      '    H.DESCRICAO_REDUZIDA,'
      '    C.DESCRICAO AS DSC_CONTA,'
      '    C.CONTA,'
      '    C.CODREDUZ,'
      '    TA.DESCRICAO AS DSC_DEDUCAO'
      ''
      'FROM TITULO_RECEBER_BAIXA_AC TRBAC'
      ''
      
        'LEFT OUTER JOIN TIPO_ACRESCIMO TA ON (TA.ID_TIPO_ACRESCIMO = TRB' +
        'AC.ID_TIPO_ACRESCIMO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TA.ID_HISTORICO' +
        ')'
      
        'LEFT OUTER JOIN CONTA_CONTABIL C ON (C.ID_CONTA_CONTABIL = H.ID_' +
        'CONTA_CONTABIL)'
      ''
      'WHERE   (TRBAC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '        (TRBAC.ID_TITULO_RECEBER_BAIXA =:PIDTITULORECEBERBAIXA);'
      '')
    Left = 680
    Top = 376
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULORECEBERBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTRBDeducao: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TRBDE.ID_TITULO_RECEBER_BAIXA_DE,'
      '    TRBDE.ID_TITULO_RECEBER_BAIXA,'
      '    TRBDE.ID_TIPO_DEDUCAO,'
      '    TRBDE.VALOR as VALOR,'
      '    H.DESCRICAO AS DSC_HIST,'
      '    H.CODIGO AS COD_HIST,'
      '    H.DESCRICAO_REDUZIDA,'
      '    C.DESCRICAO AS DSC_CONTA,'
      '    C.CONTA,'
      '    C.CODREDUZ,'
      '    TD.DESCRICAO AS DSC_DEDUCAO'
      ''
      'FROM TITULO_RECEBER_BAIXA_DE TRBDE'
      ''
      
        'JOIN TIPO_DEDUCAO TD ON (TD.ID_TIPO_DEDUCAO = TRBDE.ID_TIPO_DEDU' +
        'CAO)'
      'JOIN HISTORICO H ON (H.ID_HISTORICO = TD.ID_HISTORICO)'
      
        'JOIN CONTA_CONTABIL C ON (C.ID_CONTA_CONTABIL = H.ID_CONTA_CONTA' +
        'BIL)'
      ''
      'WHERE   (TRBDE.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '        (TRBDE.ID_TITULO_RECEBER_BAIXA =:PIDTITULORECEBERBAIXA);'
      '')
    Left = 792
    Top = 376
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULORECEBERBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryBaixaTRCaixa: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT'
      '   TC.ID_TITULO_RECEBER_BAIXA,'
      '   TC.ID_TESOURARIA_CREDITO,'
      '   TC.DATA_MOVIMENTO,'
      '   TC.VALOR_NOMINAL AS VALOR,'
      '   H.DESCRICAO AS HIST_DSC,'
      '   H.CODIGO AS HIST_COD,'
      '   TC.OBSERVACAO,'
      '   TC.DESCRICAO,'
      '   CC.CONTA AS CONTA_DB,'
      '   CC.DESCRICAO AS CTA_DB__DSC,'
      '   CC.CODREDUZ AS COD_RED_DB'
      '   '
      'FROM TESOURARIA_CREDITO TC'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TC.ID_HISTORICO' +
        ')  AND (H.ID_ORGANIZACAO = TC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.I' +
        'D_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = TC.ID_ORGANIZACAO)'
      ''
      'WHERE (TC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND      '
      '      (TC.ID_TITULO_RECEBER_BAIXA = :PIDTITULORECEBERBAIXA)')
    Left = 912
    Top = 376
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULORECEBERBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryBaixaTRCheque: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ''
      'SELECT TRBC.ID_TITULO_RECEBER_BAIXA_CHEQUE,'
      '        TRBC.ID_TITULO_RECEBER_BAIXA,'
      '        TRBC.VALOR AS VALOR,'
      '        H.DESCRICAO AS HIST_DSC,'
      '        H.CODIGO AS HIST_COD,'
      '        CC.CONTA AS CONTA_DB,'
      '        CC.DESCRICAO AS CONTA_DSC_DB,'
      '        CC.CODREDUZ AS COD_RED_DB'
      ''
      'FROM TITULO_RECEBER_BAIXA_CHEQUE TRBC'
      
        'LEFT OUTER JOIN TESOURARIA_CREDITO TC on (tc.id_titulo_receber_b' +
        'aixa_cheque = TRBC.ID_TITULO_RECEBER_BAIXA_CHEQUE)  AND (TC.id_o' +
        'rganizacao = TRBC.id_organizacao)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TC.ID_HISTORICO' +
        ') and (h.id_organizacao = tc.id_organizacao)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.I' +
        'D_CONTA_CONTABIL) AND (CC.id_organizacao = H.id_organizacao)'
      ''
      'WHERE (TRBC.id_organizacao = :PIDORGANIZACAO) AND'
      '      (TRBC.ID_TITULO_RECEBER_BAIXA = :PIDTITULORECEBERBAIXA);'
      ''
      '')
    Left = 1024
    Top = 376
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULORECEBERBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryBaixaTRBanco: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT  CBC.ID_CONTA_BANCARIA,'
      '        CBC.ID_ORGANIZACAO,'
      '        CBC.VALOR AS VALOR,'
      '        CBC.DATA_MOVIMENTO,'
      '        CBC.DESCRICAO,'
      '        CC.CONTA AS CONTA_DB,'
      '        CC.DESCRICAO AS DSC_CD_DB,'
      '        CC.CODREDUZ AS COD_RED_DB,'
      '        TOB.CODIGO AS CDHIST,'
      '        TOB.DESCRICAO AS COMPL,'
      '        TOB.DESCRICAO AS HISTORICO'
      ''
      ''
      'FROM CONTA_BANCARIA_CREDITO CBC'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CBC' +
        '.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = CB.' +
        'ID_CONTA_CONTABIL)  AND (CC.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = CBC.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGANI' +
        'ZACAO = CBC.ID_ORGANIZACAO)'
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '         (CBC.ID_TITULO_RECEBER = :PIDTITULORECEBER) AND'
      '         (CBC.ID_LOTE_CONTABIL IS NULL);'
      ''
      ''
      '')
    Left = 1159
    Top = 376
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULORECEBER'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dsDetalhesTRB: TDataSource
    DataSet = qryTRQuitados
    OnDataChange = dsDetalhesTRBDataChange
    Left = 616
    Top = 336
  end
  object qryTRFCAIXABANCO: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      '--obter as transferencias da tesouraria para o banco'
      '-- por periodo'
      ''
      'SELECT  CBC.ID_CONTA_BANCARIA_CREDITO,'
      '        CBC.id_organizacao,'
      '        CBC.id_tipo_operacao_bancaria,'
      '        CBC.DESCRICAO,'
      '        CBC.VALOR,'
      '        CBC.DATA_MOVIMENTO,'
      '        CBC.IDENTIFICACAO,'
      '        CB.CONTA AS CONTA_BANCO,'
      '        CB.AGENCIA,'
      '        CCC.CONTA AS CONTA_CONTABIL_CR,'
      '        CCC.CODREDUZ AS COD_REDUZ_CR,'
      '        CCC.DESCRICAO AS DSC_CC_CR,'
      '        TOB.descricao AS TIPO_OPERACAO,'
      '        TOB.codigo AS TOB_CODIGO,'
      '        TOB.id_conta_contabil,        '
      '        CCD.CONTA AS CONTA_CONTABIL_DB,'
      '        CCD.CODREDUZ AS COD_REDUZ_DB,'
      '        CCD.DESCRICAO AS DSC_CC_DB,'
      '        '#39'TRF_TES_BCO'#39' as TIPO'
      ''
      'FROM CONTA_BANCARIA_CREDITO CBC'
      ''
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = CBC.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGANI' +
        'ZACAO = CBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CBC' +
        '.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = T' +
        'OB.ID_CONTA_CONTABIL ) AND (CCC.ID_ORGANIZACAO = CBC.ID_ORGANIZA' +
        'CAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = C' +
        'B.ID_CONTA_CONTABIL ) AND (CCD.ID_ORGANIZACAO = CBC.ID_ORGANIZAC' +
        'AO)'
      ''
      ''
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO)AND'
      
        '      (CBC.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) AND'
      
        '      (CBC.ID_TIPO_OPERACAO_BANCARIA = '#39'DEPOSITO TESOURARIA/BANC' +
        'O'#39') AND'
      '      (CBC.ID_LOTE_CONTABIL IS NULL)')
    Left = 48
    Top = 608
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryCBTBASE: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT  CBT.ID_CONTA_BANCARIA_TRANSFERENCIA,'
      '        CBT.ID_CONTA_BANCARIA_CREDITO,'
      '        CBT.ID_CONTA_BANCARIA_DEBITO,'
      '        CBT.ID_TIPO_OPERACAO_BANCARIA,'
      '        CBT.VALOR, CBT.DATA_MOVIMENTO,'
      '        CBT.ID_ORGANIZACAO,'
      '        CBT.IDENTIFICACAO,'
      '        TOB.descricao AS TIPO_OPERACAO,'
      '        TOB.codigo AS TOB_CODIGO,'
      '        TOB.id_conta_contabil,  '
      '       '#39'CBT'#39' AS TIPO'
      ''
      ''
      'FROM CONTA_BANCARIA_TRANSFERENCIA CBT'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = CBT.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGANI' +
        'ZACAO = CBT.ID_ORGANIZACAO)'
      'WHERE   (CBT.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '        (CBT.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFI' +
        'NAL) AND'
      '        (CBT.ID_LOTE_CONTABIL IS NULL)'
      ''
      ''
      ''
      ''
      '')
    Left = 144
    Top = 608
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryCBTCR: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT CBC.ID_CONTA_BANCARIA,'
      '       CBC.ID_TIPO_OPERACAO_BANCARIA,'
      '       CBC.VALOR, CBC.DESCRICAO,'
      '       CBC.DATA_MOVIMENTO,'
      '       CBC.IDENTIFICACAO,'
      '       CONTA.CONTA AS CONTA_CORRENTE_CREDITO,'
      '       CONTA.AGENCIA,'
      '       CONTA.TITULAR,'
      '       B.codigo_banco, '
      '       B.sigla_banco,'
      '       B.nome_banco,'
      '       CC.DESCRICAO AS DSC_CC_DB,'
      '       CC.CONTA AS CONTA_CONTABIL_DB,'
      '       CC.CODREDUZ AS COD_REDUZ_DB,'
      '       TOB.descricao AS TIPO_OPERACAO,'
      '       TOB.codigo AS TOB_CODIGO,'
      '       TOB.id_conta_contabil'
      ''
      'FROM CONTA_BANCARIA_CREDITO CBC'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CONTA ON (CONTA.ID_CONTA_BANCARIA' +
        ' = CBC.ID_CONTA_BANCARIA)'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = CBC.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGANI' +
        'ZACAO = CBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = CON' +
        'TA.ID_CONTA_CONTABIL)'
      'LEFT OUTER JOIN BANCO B ON (B.ID_BANCO = CONTA.ID_BANCO)'
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (CBC.ID_CONTA_BANCARIA_CREDITO = :PIDCONTABANCARIACREDITO)')
    Left = 216
    Top = 608
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCONTABANCARIACREDITO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryCBTDB: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT CBD.ID_CONTA_BANCARIA,'
      '       CBD.ID_TIPO_OPERACAO_BANCARIA,'
      '       CBD.VALOR, CBD.DESCRICAO,'
      '       CBD.DATA_MOVIMENTO,'
      '       CBD.IDENTIFICACAO,'
      '       CONTA.CONTA AS CONTA_CORRENTE_DEBITO,'
      '       CONTA.AGENCIA,'
      '       CONTA.TITULAR,'
      '       B.codigo_banco, '
      '       B.sigla_banco,'
      '       B.nome_banco,'
      '       CC.DESCRICAO AS DSC_CC_CR,'
      '       CC.CONTA AS CONTA_CONTABIL_CR,'
      '       CC.CODREDUZ AS COD_REDUZ_CR,'
      '       TOB.descricao AS TIPO_OPERACAO,'
      '       TOB.codigo AS TOB_CODIGO,'
      '       TOB.id_conta_contabil'
      ''
      'FROM CONTA_BANCARIA_DEBITO CBD'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = CBD.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGANI' +
        'ZACAO = CBD.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CONTA ON (CONTA.ID_CONTA_BANCARIA' +
        ' = CBD.ID_CONTA_BANCARIA)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = CON' +
        'TA.ID_CONTA_CONTABIL)'
      'LEFT OUTER JOIN BANCO B ON (B.ID_BANCO = CONTA.ID_BANCO)'
      ''
      'WHERE (CBD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (CBD.ID_CONTA_BANCARIA_DEBITO = :PIDCONTABANCARIADEBITO)')
    Left = 296
    Top = 608
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCONTABANCARIADEBITO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dsDetalhesCBT: TDataSource
    DataSet = qryCBTBASE
    OnDataChange = dsDetalhesCBTDataChange
    Left = 184
    Top = 760
  end
  object qryBancoCaixa: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT  cbd.id_conta_bancaria_debito,'
      '        CBD.id_tipo_operacao_bancaria,'
      '        CBD.DESCRICAO,'
      '        CBD.VALOR,'
      '        CBD.DATA_MOVIMENTO,'
      '        CBD.IDENTIFICACAO,'
      '        CCC.CONTA AS CONTA_CONTABIL_CREDITO,'
      '        CCC.CODREDUZ AS COD_REDUZ_CREDITO,'
      '        CCC.DESCRICAO AS DSC_CC_CREDITO,'
      '        CCD.CONTA AS CONTA_CONTABIL_DEBITO,'
      '        CCD.CODREDUZ AS COD_REDUZ_DEBITO,'
      '        CCD.DESCRICAO AS DSC_CC_DEBITO,'
      '        TOB.descricao AS TIPO_OPERACAO,'
      '        TOB.codigo AS TOB_CODIGO,'
      '        TOB.id_conta_contabil,   '
      '        '#39'TRF_BC_CX'#39' as TIPO'
      ''
      'FROM CONTA_BANCARIA_DEBITO CBD'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = CBD.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGANI' +
        'ZACAO = CBD.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = T' +
        'OB.ID_CONTA_CONTABIL) AND (CCD.id_organizacao = CBD.id_organizac' +
        'ao)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CBD' +
        '.ID_CONTA_BANCARIA) AND (CB.id_organizacao = CBD.id_organizacao)'
      'LEFT OUTER JOIN BANCO B ON (B.ID_BANCO = CB.ID_BANCO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = C' +
        'B.ID_CONTA_CONTABIL)  AND (CCC.id_organizacao = CBD.id_organizac' +
        'ao)'
      ''
      ''
      ''
      'WHERE (CBD.ID_ORGANIZACAO = :PIDORGANIZACAO)AND'
      
        '      (CBD.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) AND'
      
        '      (CBD.ID_TIPO_OPERACAO_BANCARIA = '#39'TRANSFERE BANCO/TESOURAR' +
        'IA'#39') AND'
      '      (CBD.ID_LOTE_CONTABIL IS NULL)'
      'ORDER BY CBD.DATA_MOVIMENTO, CBD.VALOR')
    Left = 360
    Top = 608
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryobterTPBContasDebito: TFDQuery
    Connection = dmConexao.conn
    Left = 808
    Top = 25
  end
  object qryObterIDTPB: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ' SELECT FIRST 1 TPB.id_organizacao, '
      '        TPB.id_titulo_pagar_baixa,   '
      '        TPB.id_titulo_pagar'
      ''
      ''
      ' FROM TITULO_PAGAR_BAIXA TPB         '
      ''
      ''
      ' WHERE (TPB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND  '
      '      (TPB.id_titulo_pagar =:pIdtituloPagar) AND  '
      '      (TPB.ID_LOTE_CONTABIL IS NULL)           ')
    Left = 672
    Top = 96
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterRegistroProvisao: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ' SELECT FIRST 1 TP.ID_ORGANIZACAO,'
      '        TP.ID_TITULO_PAGAR,  '
      '        TP.REGISTRO_PROVISAO'
      ''
      ''
      ' FROM TITULO_PAGAR TP'
      ''
      ''
      ' WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND  '
      '       (TP.ID_TITULO_PAGAR =:pIdtituloPagar) ')
    Left = 792
    Top = 88
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
