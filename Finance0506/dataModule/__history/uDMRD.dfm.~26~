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
    Left = 64
    Top = 72
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
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
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
    Left = 336
    Top = 136
  end
  object frxCSVExport1: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    UTF8 = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 408
    Top = 136
  end
  object frxReportRD: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 43738.815641527780000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 256
    Top = 136
    Datasets = <
      item
        DataSet = frxDespesas
        DataSetName = 'frxDespesas'
      end
      item
        DataSet = frxReceitas
        DataSetName = 'frxReceitas'
      end>
    Variables = <
      item
        Name = ' Pempec'
        Value = Null
      end
      item
        Name = 'strRazaoSocial'
        Value = Null
      end
      item
        Name = 'strCNPJ'
        Value = Null
      end
      item
        Name = 'strEndereco'
        Value = Null
      end
      item
        Name = 'strCEP'
        Value = Null
      end
      item
        Name = 'strCidade'
        Value = Null
      end
      item
        Name = 'strUF'
        Value = Null
      end
      item
        Name = 'strTipoStatus'
        Value = Null
      end
      item
        Name = 'strTipo'
        Value = Null
      end
      item
        Name = 'cc_perc'
        Value = Null
      end
      item
        Name = 'strPeriodo'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 220.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      PrintOnPreviousPage = True
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 94.488215830000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 5.338590000000000000
          Width = 109.606370000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Organiza'#231#227'o: ')
          ParentFont = False
        end
        object strRazaoSocial1: TfrxMemoView
          Left = 117.283550000000000000
          Top = 5.338590000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strRazaoSocial]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 353.220470000000000000
          Top = 5.338590000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
        object strCNPJ: TfrxMemoView
          Left = 420.764070000000000000
          Top = 1.559059999999999000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strCNPJ]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 30.015770000000010000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object strEndereco: TfrxMemoView
          Left = 117.283550000000000000
          Top = 30.015770000000010000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strEndereco]')
          ParentFont = False
        end
        object strCEP: TfrxMemoView
          Left = 420.764070000000000000
          Top = 30.015770000000010000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strCEP]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 353.220470000000000000
          Top = 30.015770000000010000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CEP  :')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 510.236550000000000000
          Top = 30.015770000000010000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CIDADE/UF:')
          ParentFont = False
        end
        object strCidade: TfrxMemoView
          Left = 619.842920000000000000
          Top = 33.795300000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strCidade]/[strUF]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Page: TfrxMemoView
          Left = 680.315400000000000000
          Top = 1.559059999999999000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo15: TfrxMemoView
          Left = 619.842920000000000000
          Top = 1.559059999999999000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'P'#193'G.')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 54.031540000000010000
          Width = 480.000310000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DEMONSTRATIVO DE RECEITAS E DESPESAS DO PER'#205'ODO ')
          ParentFont = False
          VAlign = vaCenter
        end
        object strPeriodo: TfrxMemoView
          Left = 498.897960000000000000
          Top = 54.031540000000010000
          Width = 219.212740000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strPeriodo]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line2: TfrxLineView
          Left = 3.779530000000000000
          Top = 86.929190000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Memo41: TfrxMemoView
        Left = 7.559060000000000000
        Top = -7.559060000000000000
        Width = 49.133890000000000000
        Height = 15.118120000000000000
        DataSet = frmRelatorioPagamentos.frxDBTitulos
        DataSetName = 'Titulos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 548.031849999999900000
        Width = 755.906000000000000000
        object Memo36: TfrxMemoView
          Left = 2.559060000000000000
          Top = 2.000000000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pempec Enterprise Finance')
          ParentFont = False
          VAlign = vaBottom
        end
        object Date: TfrxMemoView
          Left = 648.441250000000000000
          Top = 2.000000000000114000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo79: TfrxMemoView
          Left = 575.086890000000000000
          Top = 2.000000000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Emitido em:  ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Time: TfrxMemoView
          Left = 706.488560000000000000
          Top = 2.000000000000114000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object receitas: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637795275600000
        Top = 249.448980000000000000
        Width = 755.906000000000000000
        DataSet = frxReceitas
        DataSetName = 'frxReceitas'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 136.063080000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataField = 'CENTRO_CUSTOS'
          DataSet = frxReceitas
          DataSetName = 'frxReceitas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8W = (
            '[frxReceitas."CENTRO_CUSTOS"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 525.354670000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataField = 'VALOR_RECEITA'
          DataSet = frxReceitas
          DataSetName = 'frxReceitas'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxReceitas."VALOR_RECEITA"]')
          ParentFont = False
        end
      end
      object despesas: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637795275600000
        Top = 366.614410000000000000
        Width = 755.906000000000000000
        DataSet = frxDespesas
        DataSetName = 'frxDespesas'
        RowCount = 0
        object Memo9: TfrxMemoView
          Left = 136.063080000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataField = 'CENTRO_CUSTOS'
          DataSet = frxDespesas
          DataSetName = 'frxDespesas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDespesas."CENTRO_CUSTOS"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 525.354670000000100000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataField = 'VALOR_DESPESA'
          DataSet = frxDespesas
          DataSetName = 'frxDespesas'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDespesas."VALOR_DESPESA"]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 173.858380000000000000
        Width = 755.906000000000000000
        Condition = '1=1'
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RECEITAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 136.063080000000000000
          Width = 173.858380000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CENTRO DE CUSTOS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 582.047620000000000000
          Width = 173.858380000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader4: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 291.023810000000000000
        Width = 755.906000000000000000
        Condition = '1=1'
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESPESAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 136.063080000000000000
          Width = 173.858380000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CENTRO DE CUSTOS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 582.047620000000000000
          Width = 173.858380000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Top = 343.937230000000000000
        Width = 755.906000000000000000
        Condition = 'frxDespesas."ID_CENTRO_CUSTO"'
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Top = 226.771800000000000000
        Width = 755.906000000000000000
        Condition = 'frxReceitas."ID_CENTRO_CUSTO"'
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 77.590600000000000000
        Top = 445.984540000000000000
        Width = 755.906000000000000000
        object Memo14: TfrxMemoView
          Left = 307.480520000000000000
          Top = 1.889763780000010000
          Width = 136.063080000000000000
          Height = 26.456710000000000000
          DataSet = frxReceitas
          DataSetName = 'frxReceitas'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxReceitas."VALOR_RECEITA">,receitas)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 217.212740000000000000
          Top = 1.889763780000010000
          Width = 86.929190000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RECEITAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Left = 3.779530000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Style = fsDouble
          Frame.Typ = [ftTop]
        end
        object Memo16: TfrxMemoView
          Left = 217.212740000000000000
          Top = 38.472480000000020000
          Width = 86.929190000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESPESAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 307.480520000000000000
          Top = 38.472480000000020000
          Width = 136.063080000000000000
          Height = 26.456710000000000000
          DataSet = frxReceitas
          DataSetName = 'frxReceitas'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDespesas."VALOR_DESPESA">,despesas)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 525.354670000000100000
          Top = 37.795300000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataSet = frxReceitas
          DataSetName = 'frxReceitas'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxReceitas."VALOR_RECEITA">,receitas) - SUM(<frxDespesas.' +
              '"VALOR_DESPESA">,despesas)  ] ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 612.283860000000000000
          Top = 3.779530000000022000
          Width = 143.622140000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO APURADO')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
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
    Left = 64
    Top = 192
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
    Left = 144
    Top = 72
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
    Left = 144
    Top = 192
  end
end
