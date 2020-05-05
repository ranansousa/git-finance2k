object fmTelaImpressaoLotePagamento: TfmTelaImpressaoLotePagamento
  Left = 0
  Top = 0
  Caption = 'Pempec Entreprise Finance 2k'
  ClientHeight = 659
  ClientWidth = 863
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dbgrdMain: TDBGrid
    Left = 0
    Top = 125
    Width = 863
    Height = 514
    Align = alBottom
    DataSource = dsDbGrid
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgrdMainTitleClick
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'LOTE'
        Title.Alignment = taCenter
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATA_PAGAMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'PAGAMENTO'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALOR'
        Title.Alignment = taCenter
        Width = 150
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'FP'
        Title.Alignment = taCenter
        Title.Caption = 'FORMA PAG'
        Width = 120
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONTA'
        Title.Alignment = taCenter
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CHEQUE'
        Title.Alignment = taCenter
        Width = 120
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTD'
        Title.Alignment = taRightJustify
        Title.Caption = 'T'#205'TULOS'
        Width = 80
        Visible = True
      end>
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 863
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 1
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Manuten'#231#227'o de lote pagamento'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar2'
        end
        item
          ToolbarName = 'dxBarManager1Bar4'
        end
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar6'
        end>
      Index = 0
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 639
    Width = 863
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object dsDbGrid: TDataSource
    DataSet = qryPreencheDBGrid
    OnDataChange = dsDbGridDataChange
    Left = 80
    Top = 304
  end
  object qryPreencheDBGrid: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      ''
      
        'SELECT LP.id_lote_pagamento, LP.LOTE as LOTE, LP.id_organizacao,' +
        ' LP.DATA_PAGAMENTO, LP.VALOR, LP.status, LP.QTD_TIT_PAG as QTD,'
      '       FP.id_forma_pagamento, FP.descricao AS FP,'
      
        '       CBC.id_conta_bancaria_cheque, CBC.numero_cheque AS CHEQUE' +
        ', CBC.id_conta_bancaria,'
      '       CB.id_conta_bancaria, CB.conta'
      'FROM lote_pagamento LP'
      ''
      
        'LEFT OUTER JOIN forma_pagamento FP ON (FP.id_forma_pagamento = L' +
        'P.id_forma_pagamento)   AND (FP.ID_ORGANIZACAO = LP.ID_ORGANIZAC' +
        'AO)'
      
        'LEFT OUTER JOIN conta_bancaria_cheque CBC ON (CBC.id_conta_banca' +
        'ria_cheque = LP.id_conta_bancaria_cheque) AND (CBC.ID_ORGANIZACA' +
        'O = LP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = LP.' +
        'id_conta_bancaria) AND (CB.ID_ORGANIZACAO = LP.ID_ORGANIZACAO)'
      ' '
      'WHERE (LP.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      'ORDER BY LP.DATA_PAGAMENTO DESC')
    Left = 192
    Top = 304
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterTitulos: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.id_titulo_pagar, TP.ID_LOTE_TPB, TP.ID_LOTE_CONTABIL,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.valor_nominal,'
      '       TP.DESCRICAO,'
      '       TP.id_lote_pagamento,'
      '       C.nome,  C.id_cedente'
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      '')
    Left = 336
    Top = 544
  end
  object frxRelLotePagamento: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 43865.677339756940000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 64
    Top = 536
    Datasets = <
      item
        DataSet = frxDBLote
        DataSetName = 'lote'
      end
      item
        DataSet = frxDBTitulo
        DataSetName = 'titulo'
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
      Frame.Typ = []
      LargeDesignHeight = True
      MirrorMode = []
      PrintOnPreviousPage = True
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 86.929155830000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 5.338590000000000000
          Width = 109.606370000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Organiza'#231#227'o: ')
          ParentFont = False
        end
        object strRazaoSocial1: TfrxMemoView
          AllowVectorExport = True
          Left = 117.283550000000000000
          Top = 5.338590000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strRazaoSocial]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 353.220470000000000000
          Top = 5.338590000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
        object strCNPJ: TfrxMemoView
          AllowVectorExport = True
          Left = 420.764070000000000000
          Top = 1.559060000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCNPJ]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 30.015770000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object strEndereco: TfrxMemoView
          AllowVectorExport = True
          Left = 117.283550000000000000
          Top = 30.015770000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strEndereco]')
          ParentFont = False
        end
        object strCEP: TfrxMemoView
          AllowVectorExport = True
          Left = 420.764070000000000000
          Top = 30.015770000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCEP]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 353.220470000000000000
          Top = 30.015770000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CEP  :')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 510.236550000000000000
          Top = 30.015770000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CIDADE/UF:')
          ParentFont = False
        end
        object strCidade: TfrxMemoView
          AllowVectorExport = True
          Left = 619.842920000000000000
          Top = 33.795300000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
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
          AllowVectorExport = True
          Left = 680.315400000000000000
          Top = 1.559060000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
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
          AllowVectorExport = True
          Left = 619.842920000000000000
          Top = 1.559060000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'P'#193'G.')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 5.102350000000000000
          Top = 57.031540000000000000
          Width = 737.008350000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'LOTE PAGAMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line5: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 52.913420000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Frame.Typ = []
        Height = 68.031496060000000000
        Top = 502.677490000000000000
        Width = 755.906000000000000000
        object Line2: TfrxLineView
          AllowVectorExport = True
          Top = 3.000000000000000000
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 1.500000000000000000
        end
      end
      object Memo41: TfrxMemoView
        AllowVectorExport = True
        Left = 7.559060000000000000
        Top = -7.559060000000000000
        Width = 49.133890000000000000
        Height = 15.118120000000000000
        DataSetName = 'TITULOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
        ParentFont = False
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 3.779527560000000000
        Top = 166.299320000000000000
        Width = 755.906000000000000000
        Condition = '1=1'
        object Line3: TfrxLineView
          AllowVectorExport = True
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 593.386210000000000000
        Width = 755.906000000000000000
        object Memo36: TfrxMemoView
          AllowVectorExport = True
          Left = -1.220470000000000000
          Top = 2.000000000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Pempec Enterprise Finance')
          ParentFont = False
          VAlign = vaBottom
        end
        object Date: TfrxMemoView
          AllowVectorExport = True
          Left = 648.441250000000000000
          Top = 2.000000000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo79: TfrxMemoView
          AllowVectorExport = True
          Left = 575.086890000000000000
          Top = 2.000000000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Emitido em:  ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Time: TfrxMemoView
          AllowVectorExport = True
          Left = 706.488560000000000000
          Top = 2.000000000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object Titulo: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 125.063080000000000000
        Top = 192.756030000000000000
        Width = 755.906000000000000000
        DataSet = frxDBLote
        DataSetName = 'lote'
        RowCount = 0
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 107.724490000000000000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          DataField = 'LOTE'
          DataSet = frxDBLote
          DataSetName = 'lote'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[lote."LOTE"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'LOTE')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 441.882190000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          DataField = 'DATA_PAGAMENTO'
          DataSet = frxDBLote
          DataSetName = 'lote'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[lote."DATA_PAGAMENTO"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 297.685220000000000000
          Width = 139.842610000000000000
          Height = 15.118120000000000000
          DataSet = frxDBLote
          DataSetName = 'lote'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'DATA PAGAMENTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo23: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 31.236240000000010000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'PAGO EM ')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 75.370130000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CHEQUE ')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          AllowVectorExport = True
          Left = 581.827150000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          AllowVectorExport = True
          Left = 107.724490000000000000
          Top = 31.236240000000000000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          DataField = 'FP'
          DataSet = frxDBLote
          DataSetName = 'lote'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[lote."FP"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          AllowVectorExport = True
          Left = 297.685220000000000000
          Top = 39.354360000000000000
          Width = 139.842610000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR ')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          AllowVectorExport = True
          Left = 442.204521810000000000
          Top = 39.354360000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = frxDBLote
          DataSetName = 'lote'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[lote."VALOR"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 54.472480000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CONTA BANC'#193'RIA')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Top = 125.063080000000000000
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo34: TfrxMemoView
          AllowVectorExport = True
          Left = 657.637731810000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'STATUS'
          DataSet = frxDBLote
          DataSetName = 'lote'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[lote."STATUS"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          AllowVectorExport = True
          Left = 107.724490000000000000
          Top = 56.692950000000000000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          DataField = 'CONTA'
          DataSet = frxDBLote
          DataSetName = 'lote'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[lote."CONTA"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          AllowVectorExport = True
          Left = 107.724490000000000000
          Top = 75.590600000000000000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          DataField = 'CHEQUE'
          DataSet = frxDBLote
          DataSetName = 'lote'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[lote."CHEQUE"]')
          ParentFont = False
        end
      end
      object Fornecedor: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 427.086890000000000000
        Width = 755.906000000000000000
        DataSet = frxDBTitulo
        DataSetName = 'titulo'
        RowCount = 0
        object Memo40: TfrxMemoView
          AllowVectorExport = True
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'NUMERO_DOCUMENTO'
          DataSet = frxDBTitulo
          DataSetName = 'titulo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[titulo."NUMERO_DOCUMENTO"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          AllowVectorExport = True
          Left = 93.267780000000000000
          Width = 215.433210000000000000
          Height = 15.118120000000000000
          DataField = 'NOME'
          DataSet = frxDBTitulo
          DataSetName = 'titulo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[titulo."NOME"]')
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          AllowVectorExport = True
          Left = 608.503841810000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR_NOMINAL'
          DataSet = frxDBTitulo
          DataSetName = 'titulo'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[titulo."VALOR_NOMINAL"]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          AllowVectorExport = True
          Left = 313.260050000000000000
          Width = 219.212740000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRICAO'
          DataSet = frxDBTitulo
          DataSetName = 'titulo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[titulo."DESCRICAO"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 64.252010000000000000
        Top = 340.157700000000000000
        Width = 755.906000000000000000
        object Memo33: TfrxMemoView
          Align = baWidth
          AllowVectorExport = True
          Top = 3.779527560000020000
          Width = 755.906000000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haCenter
          Memo.UTF8W = (
            'RELA'#199#195'O DOS T'#205'TULOS PAGOS')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 27.118120000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Line6: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo39: TfrxMemoView
          AllowVectorExport = True
          Top = 40.354360000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          AllowVectorExport = True
          Left = 93.267780000000000000
          Top = 40.354360000000000000
          Width = 215.433210000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'FORNECEDOR')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          AllowVectorExport = True
          Left = 313.260050000000000000
          Top = 40.354360000000000000
          Width = 219.212740000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo100: TfrxMemoView
          AllowVectorExport = True
          Left = 702.992091810000000000
          Top = 40.354360000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR ')
          ParentFont = False
        end
        object Line7: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 59.015770000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDBLote: TfrxDBDataset
    UserName = 'lote'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_LOTE_PAGAMENTO=ID_LOTE_PAGAMENTO'
      'LOTE=LOTE'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'VALOR=VALOR'
      'STATUS=STATUS'
      'ID_FORMA_PAGAMENTO=ID_FORMA_PAGAMENTO'
      'FP=FP'
      'ID_CONTA_BANCARIA_CHEQUE=ID_CONTA_BANCARIA_CHEQUE'
      'CHEQUE=CHEQUE'
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'ID_CONTA_BANCARIA_1=ID_CONTA_BANCARIA_1'
      'CONTA=CONTA')
    DataSet = qryLote
    BCDToCurrency = False
    Left = 168
    Top = 544
  end
  object frxDBTitulo: TfrxDBDataset
    UserName = 'titulo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'VALOR_NOMINAL=VALOR_NOMINAL'
      'DESCRICAO=DESCRICAO'
      'ID_LOTE_PAGAMENTO=ID_LOTE_PAGAMENTO'
      'NOME=NOME'
      'ID_CEDENTE=ID_CEDENTE')
    DataSet = qryObterTitulos
    BCDToCurrency = False
    Left = 248
    Top = 544
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 551
    Top = 56
    PixelsPerInch = 96
    object dxBarManager1Bar2: TdxBar
      Caption = 'Pesquisar'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1095
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'cxbrdtmLote'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'Impress'#227'o'
      CaptionButtons = <>
      DockedLeft = 141
      DockedTop = 0
      FloatLeft = 1095
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarImprimir'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar6: TdxBar
      Caption = 'Sair'
      CaptionButtons = <>
      DockedLeft = 294
      DockedTop = 0
      FloatLeft = 1095
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnFechar1'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar1: TdxBar
      Caption = 'Deletar'
      CaptionButtons = <>
      DockedLeft = 212
      DockedTop = 0
      FloatLeft = 899
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnCancelaLote'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBtnEditar: TdxBarLargeButton
      Caption = 'Editar'#13#10
      Category = 0
      Hint = 'Editar'#13#10' registro. F2'
      Visible = ivAlways
    end
    object dxBtnSalvar: TdxBarLargeButton
      Caption = 'Salvar'
      Category = 0
      Hint = 'Salvar registro. F10'
      Visible = ivAlways
    end
    object dxBtnImprimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Novo registro. F4'
      Visible = ivAlways
    end
    object dxBtnFechar: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
    end
    object dxBtnDeletar: TdxBarLargeButton
      Caption = 'Deletar'
      Category = 0
      Hint = 'Deletar'
      Visible = ivAlways
    end
    object cxbrdtmPesquisa: TcxBarEditItem
      Caption = 'Documento'
      Category = 0
      Hint = 'Documento'
      Visible = ivAlways
      PropertiesClassName = 'TcxTextEditProperties'
    end
    object dxBtnImprime: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprime o recibo '
      Visible = ivAlways
    end
    object dxBtnImpimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprimir'
      Visible = ivAlways
    end
    object dxBtnFechar1: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar tela'
      Visible = ivAlways
      OnClick = dxBtnFechar1Click
    end
    object dxBarImprimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprimir'
      Visible = ivAlways
      OnClick = dxBarImprimirClick
    end
    object cxbrdtmLote: TcxBarEditItem
      Caption = 'Lote'
      Category = 0
      Hint = 'Lote'
      Visible = ivAlways
      OnCurChange = cxbrdtmLoteCurChange
    end
    object dxBtnCancelaLote: TdxBarLargeButton
      Caption = 'Cancelar Lote Pagto'
      Category = 0
      Hint = 'Cancelar Lote Pagto'
      Visible = ivAlways
      OnClick = dxBtnCancelaLoteClick
    end
  end
  object qryLote: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      ''
      
        'SELECT LP.id_lote_pagamento, LP.LOTE as LOTE, LP.id_organizacao,' +
        ' LP.DATA_PAGAMENTO, LP.VALOR, LP.status,'
      '       FP.id_forma_pagamento, FP.descricao AS FP,'
      
        '       CBC.id_conta_bancaria_cheque, CBC.numero_cheque AS CHEQUE' +
        ', CBC.id_conta_bancaria,'
      '       CB.id_conta_bancaria, CB.conta'
      'FROM lote_pagamento LP'
      ''
      
        'LEFT OUTER JOIN forma_pagamento FP ON (FP.id_forma_pagamento = L' +
        'P.id_forma_pagamento)   AND (FP.ID_ORGANIZACAO = LP.ID_ORGANIZAC' +
        'AO)'
      
        'LEFT OUTER JOIN conta_bancaria_cheque CBC ON (CBC.id_conta_banca' +
        'ria_cheque = LP.id_conta_bancaria_cheque) AND (CBC.ID_ORGANIZACA' +
        'O = LP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = LP.' +
        'id_conta_bancaria) AND (CB.ID_ORGANIZACAO = LP.ID_ORGANIZACAO)'
      ' '
      
        'WHERE (LP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (LP.ID_LOTE_PAGA' +
        'MENTO = :PID)'
      '')
    Left = 424
    Top = 536
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PID'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object PempecMsg: TEvMsgDlg
    ButtonFont.Charset = DEFAULT_CHARSET
    ButtonFont.Color = clWindowText
    ButtonFont.Height = -11
    ButtonFont.Name = 'Tahoma'
    ButtonFont.Style = []
    MessageFont.Charset = DEFAULT_CHARSET
    MessageFont.Color = clWindowText
    MessageFont.Height = -11
    MessageFont.Name = 'Tahoma'
    MessageFont.Style = []
    Left = 616
    Top = 56
  end
  object qryObterPagos: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.id_titulo_pagar, TP.ID_LOTE_TPB, TP.ID_LOTE_CONTABIL,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.valor_nominal,'
      '       TP.DESCRICAO,'
      '       TP.id_lote_pagamento,'
      '       C.nome,  C.id_cedente'
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      '')
    Left = 560
    Top = 504
  end
end
