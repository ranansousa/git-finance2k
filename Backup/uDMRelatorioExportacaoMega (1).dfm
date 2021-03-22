object dmRelExportacaoMega: TdmRelExportacaoMega
  OldCreateOrder = False
  Height = 469
  Width = 610
  object frxRelatorioExportacaoMega: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 42645.409382118060000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 48
    Top = 16
  end
  object frxDBTitulos: TfrxDBDataset
    UserName = 'Titulos'
    CloseDataSource = False
    DataSet = dmExportaFinance.qryTitulosProvisionados
    BCDToCurrency = False
    Left = 176
    Top = 40
  end
  object frxDBHistoricos: TfrxDBDataset
    UserName = 'Historicos'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'CODIGO=CODIGO'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ')
    DataSet = dmExportaFinance.qryObterTPHistoricoPorTitulo
    BCDToCurrency = False
    Left = 248
    Top = 40
  end
  object frxDBCentroCusto: TfrxDBDataset
    UserName = 'CentroCusto'
    CloseDataSource = False
    DataSet = dmExportaFinance.qryObterCentroCustoPorTitulo
    BCDToCurrency = False
    Left = 344
    Top = 52
  end
  object frxDBTRProv: TfrxDBDataset
    UserName = 'TitulosReceberProv'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER'
      'DATA_EMISSAO=DATA_EMISSAO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'DESCRICAO=DESCRICAO'
      'PARCELA=PARCELA'
      'VALOR_NOMINAL=VALOR_NOMINAL'
      'CONTA_DEBITO=CONTA_DEBITO'
      'CODREDUZ=CODREDUZ'
      'DSC_CONTA=DSC_CONTA'
      'ID_CONTA_CONTABIL_DEBITO=ID_CONTA_CONTABIL_DEBITO')
    DataSet = qryTRProvisionados
    BCDToCurrency = False
    Left = 344
    Top = 328
  end
  object frxDBHistTR: TfrxDBDataset
    UserName = 'HistoricosTR'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'CODIGO=CODIGO'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ')
    DataSet = qryHistoricoTR
    BCDToCurrency = False
    Left = 416
    Top = 325
  end
  object frxDBCCustoTR: TfrxDBDataset
    UserName = 'CentroCustoTR'
    CloseDataSource = False
    FieldAliases.Strings = (
      'VALOR=VALOR'
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER'
      'DESCRICAO=DESCRICAO'
      'CODIGO=CODIGO')
    DataSet = qryCentroCustoTR
    BCDToCurrency = False
    Left = 512
    Top = 324
  end
  object qryTRProvisionados: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.ID_ORGANIZACAO,'
      '       TP.ID_TITULO_RECEBER,'
      '       TP.DATA_EMISSAO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DESCRICAO,'
      '       TP.PARCELA,'
      '       TP.VALOR_NOMINAL,'
      '       CC.CONTA AS CONTA_DEBITO,'
      '       CC.CODREDUZ,'
      '       CC.DESCRICAO AS DSC_CONTA,'
      '       TP.ID_CONTA_CONTABIL_DEBITO'
      ''
      ''
      '        '
      'FROM TITULO_RECEBER TP'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = TP.' +
        'ID_CONTA_CONTABIL_DEBITO)'
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (TP.DATA_EMISSAO BETWEEN :pDataInicial AND :pDataFinal) AN' +
        'D'
      '      (TP.IS_PROVISAO = :pProvisao) AND'
      '      (TP.ID_TIPO_STATUS = :pIdStatus) AND'
      '      (TP.ID_LOTE_CONTABIL IS NULL) AND'
      '      (TP.DATA_PAGAMENTO IS NULL)'
      ''
      'ORDER BY TP.DATA_EMISSAO DESC, TP.VALOR_NOMINAL DESC;  ')
    Left = 344
    Top = 400
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
        Name = 'PPROVISAO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PIDSTATUS'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qryHistoricoTR: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      
        'SELECT TPH.ID_TITULO_RECEBER, TPH.VALOR, H.DESCRICAO,H.id_conta_' +
        'contabil, H.CODIGO, CD.conta, CD.codreduz'
      '        '
      'FROM TITULO_RECEBER_HISTORICO TPH'
      'JOIN HISTORICO H ON (TPH.ID_HISTORICO = H.ID_HISTORICO)'
      
        'JOIN conta_contabil CD ON (CD.id_conta_contabil = H.id_conta_con' +
        'tabil)'
      ''
      'WHERE (TPH.ID_ORGANIZACAO = :pIdOrganizacao)AND'
      '      (TPH.ID_TITULO_RECEBER = :PID_TITULO_RECEBER)'
      ''
      'ORDER BY TPH.VALOR;')
    Left = 430
    Top = 400
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PID_TITULO_RECEBER'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryCentroCustoTR: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TPC.VALOR,       '
      '       TPC.ID_TITULO_RECEBER,'
      '       CC.DESCRICAO,'
      '       CC.CODIGO'
      '        '
      'FROM TITULO_RECEBER_RATEIO_CC TPC'
      
        'JOIN CENTRO_CUSTO CC ON (CC.ID_CENTRO_CUSTO = TPC.ID_CENTRO_CUST' +
        'O)'
      ''
      'WHERE    (TPC.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '         (TPC.ID_TITULO_RECEBER = :pId_TITULO_RECEBER) ;'
      ''
      '       '
      '')
    Left = 512
    Top = 400
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PID_TITULO_RECEBER'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
