object dmRD: TdmRD
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 343
  Width = 878
  object qryDespesas: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      
        'SELECT  SUM(TPRCC.VALOR) AS VALOR_DESPESA, MAX(CC.DESCRICAO) AS ' +
        'CENTRO_CUSTOS, TPRCC.ID_CENTRO_CUSTO'
      ''
      'FROM TITULO_PAGAR_RATEIO_CC TPRCC'
      
        'LEFT OUTER JOIN TITULO_PAGAR TP ON (TP.ID_TITULO_PAGAR = TPRCC.I' +
        'D_TITULO_PAGAR) AND (TP.ID_ORGANIZACAO = TPRCC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CENTRO_CUSTO CC ON (CC.ID_CENTRO_CUSTO = TPRCC.I' +
        'D_CENTRO_CUSTO) AND (CC.ID_ORGANIZACAO = TPRCC.ID_ORGANIZACAO)'
      ''
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) '
      
        '       AND (TP.DATA_PAGAMENTO BETWEEN :DTDATAINICIAL AND :DTDATA' +
        'FINAL) '
      '       AND (TP.ID_TIPO_STATUS IN ('#39'QUITADO'#39', '#39'PARCIAL'#39' ))'
      ''
      'GROUP BY TPRCC.ID_CENTRO_CUSTO'
      'ORDER BY VALOR_DESPESA')
    Left = 264
    Top = 80
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
  object frxReportRD: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 43738.815641527780000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 464
    Top = 152
  end
  object qryReceitas: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      
        'SELECT  SUM(TRRCC.VALOR) AS VALOR_RECEITA, MAX(CC.DESCRICAO) AS ' +
        'CENTRO_CUSTOS, TRRCC.ID_CENTRO_CUSTO'
      ''
      'FROM TITULO_RECEBER_RATEIO_CC TRRCC'
      ''
      
        'LEFT OUTER JOIN TITULO_RECEBER TR ON (TR.ID_TITULO_RECEBER = TRR' +
        'CC.ID_TITULO_RECEBER)  AND (TR.ID_ORGANIZACAO = TRRCC.ID_ORGANIZ' +
        'ACAO)'
      
        'LEFT OUTER JOIN CENTRO_CUSTO CC ON (CC.ID_CENTRO_CUSTO = TRRCC.I' +
        'D_CENTRO_CUSTO) AND (CC.ID_ORGANIZACAO = TRRCC.ID_ORGANIZACAO)'
      ''
      'WHERE (TR.ID_ORGANIZACAO = :PIDORGANIZACAO) '
      
        '       AND (TR.DATA_PAGAMENTO BETWEEN :DTDATAINICIAL AND :DTDATA' +
        'FINAL) '
      '       AND (TR.ID_TIPO_STATUS IN ('#39'QUITADO'#39', '#39'PARCIAL'#39' ))'
      ''
      ''
      'GROUP BY TRRCC.ID_CENTRO_CUSTO'
      'ORDER BY VALOR_RECEITA'
      '')
    Left = 344
    Top = 176
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
  object frxDespesas: TfrxDBDataset
    UserName = 'frxDespesas'
    CloseDataSource = False
    FieldAliases.Strings = (
      'VALOR_DESPESA=VALOR_DESPESA'
      'CENTRO_CUSTOS=CENTRO_CUSTOS'
      'ID_CENTRO_CUSTO=ID_CENTRO_CUSTO')
    DataSet = qryDespesas
    BCDToCurrency = False
    Left = 344
    Top = 80
  end
  object frxReceitas: TfrxDBDataset
    UserName = 'frxReceitas'
    CloseDataSource = False
    FieldAliases.Strings = (
      'VALOR_RECEITA=VALOR_RECEITA'
      'CENTRO_CUSTOS=CENTRO_CUSTOS'
      'ID_CENTRO_CUSTO=ID_CENTRO_CUSTO')
    DataSet = qryReceitas
    BCDToCurrency = False
    Left = 256
    Top = 176
  end
end
