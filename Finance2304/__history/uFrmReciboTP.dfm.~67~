object frmReciboTP: TfrmReciboTP
  Left = 0
  Top = 0
  Caption = 'Emitir recibo '
  ClientHeight = 523
  ClientWidth = 1061
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 1061
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 0
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Emiss'#227'o de recibo de contas pagas'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar5'
        end
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end>
      Index = 0
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 503
    Width = 1061
    Height = 20
    Panels = <
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
  object dbgrd1: TDBGrid
    Left = 0
    Top = 125
    Width = 1061
    Height = 378
    Align = alClient
    DataSource = dsGrid
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgrd1TitleClick
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DOC'
        Title.Caption = 'DOCUMENTO'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_PAGO'
        Title.Caption = 'VALOR PAGO'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_PAGAMENTO'
        Title.Caption = 'PAGAMENTO'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PARCELA'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Caption = 'DESCRI'#199#195'O'
        Width = 500
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FORNECEDOR'
        Width = 200
        Visible = True
      end>
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
    Left = 664
    Top = 56
    PixelsPerInch = 96
    object dxBarManager1Bar3: TdxBar
      Caption = 'Sair'
      CaptionButtons = <>
      DockedLeft = 296
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnFechar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar5: TdxBar
      Caption = 'Pesquisar'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udWidth]
          UserWidth = 144
          Visible = True
          ItemName = 'cxbrdtmPesquisa'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar1: TdxBar
      Caption = 'Impress'#227'o'
      CaptionButtons = <>
      DockedLeft = 225
      DockedTop = 0
      FloatLeft = 1095
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnImpimir'
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
      OnClick = dxBtnFecharClick
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
      OnCurChange = cxbrdtmPesquisaCurChange
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
      OnClick = dxBtnImpimirClick
    end
  end
  object msgDlg: TEvMsgDlg
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
    Left = 704
    Top = 152
  end
  object dsGrid: TDataSource
    DataSet = qryPreencheGrid
    OnDataChange = dsGridDataChange
    Left = 664
    Top = 152
  end
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.ID_TITULO_PAGAR,'
      '       TP.NUMERO_DOCUMENTO AS DOC,       '
      '       TP.ID_ORGANIZACAO,'
      '       (H.descricao || '#39' '#39' ||  TP.DESCRICAO) AS DESCRICAO,'
      '       TPB.VALOR_PAGO,'
      '       TP.ID_CEDENTE,'
      '       TP.data_pagamento,'
      '       C.nome AS FORNECEDOR,'
      '       TP.PARCELA,'
      '       '
      '       ORG.RAZAO_SOCIAL,'
      '       ORG.SIGLA, '
      '       ORG.FANTASIA,'
      '       ORG.CNPJ,'
      '       ORG.LOGRADOURO, '
      '       ORG.COMPLEMENTO,'
      '       ORG.NUMERO,'
      '       ORG.CEP,'
      '       E.DESCRICAO AS ESTADO,'
      '       CID.CIDADE,'
      '       B.BAIRRO'
      ''
      'FROM TITULO_PAGAR TP'
      ''
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.id_titulo_pagar =' +
        ' TP.id_titulo_pagar) AND (TPB.id_organizacao = TP.id_organizacao' +
        ')'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.id_cedente = TP.id_cedente) AND ' +
        '(C.id_organizacao = TP.id_organizacao)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.id_historico =  TP.id_historic' +
        'o) AND (H.id_organizacao = TP.id_organizacao)'
      
        'INNER JOIN ORGANIZACAO ORG ON (ORG.ID_ORGANIZACAO = TP.ID_ORGANI' +
        'ZACAO) '
      'INNER JOIN ESTADO E ON (E.ID_ESTADO = ORG.ID_ESTADO)'
      'INNER JOIN CIDADE CID ON (CID.ID_CIDADE = ORG.ID_CIDADE)'
      'INNER JOIN BAIRRO B ON (B.ID_BAIRRO = ORG.ID_BAIRRO)'
      'WHERE ( TP.ID_ORGANIZACAO = :PIDORGANIZACAO )'
      ' AND  ( TP.ID_TIPO_STATUS IN ('#39'PARCIAL'#39', '#39'QUITADO'#39') )'
      ''
      'ORDER BY TP.DATA_EMISSAO DESC, TP.VALOR_NOMINAL DESC'
      ''
      '')
    Left = 744
    Top = 152
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object frxReportRecibo: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43827.466410034700000000
    ReportOptions.LastChange = 43827.800529953700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 808
    Top = 240
    Datasets = <
      item
        DataSet = frxDBRecibo
        DataSetName = 'Recibo'
      end
      item
        DataSet = frxTPBBanco
        DataSetName = 'TPBBanco'
      end
      item
        DataSet = frxDBTPBCaixa
        DataSetName = 'TPBCaixa'
      end
      item
        DataSet = frxTPBCheque
        DataSetName = 'TPBCheque'
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
      end
      item
        Name = 'strExtenso'
        Value = Null
      end
      item
        Name = 'strValidate'
        Value = Null
      end>
    Style = <
      item
        Name = 'Title'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = []
        Fill.BackColor = 14211288
      end
      item
        Name = 'Header'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = []
        Fill.BackColor = 15790320
      end
      item
        Name = 'Group header'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = []
        Fill.BackColor = 15790320
      end
      item
        Name = 'Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
      end
      item
        Name = 'Group footer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftTop]
      end
      item
        Name = 'Header line'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
        Frame.Width = 2.000000000000000000
      end>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 143.622140000000000000
        Top = 230.551330000000000000
        Width = 718.110700000000000000
        DataSet = frxDBRecibo
        DataSetName = 'Recibo'
        RowCount = 0
        object Memo28: TfrxMemoView
          AllowVectorExport = True
          Left = 100.391797520000000000
          Top = 71.149659999999990000
          Width = 99.044928550000000000
          Height = 15.118120000000000000
          DataField = 'PARCELA'
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Recibo."PARCELA"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          AllowVectorExport = True
          Left = 100.391797520000000000
          Top = 46.133890000000010000
          Width = 503.454638550000000000
          Height = 18.897650000000000000
          DataField = 'DESCRICAO'
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Recibo."DESCRICAO"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          AllowVectorExport = True
          Left = 608.728316060000000000
          Top = 23.456710000000000000
          Width = 106.862320130000000000
          Height = 18.897650000000000000
          DataField = 'VALOR_PAGO'
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Recibo."VALOR_PAGO"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          AllowVectorExport = True
          Left = 251.187387610000000000
          Top = 0.779529999999994100
          Width = 463.942153570000000000
          Height = 18.897650000000000000
          DataField = 'FORNECEDOR'
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Recibo."FORNECEDOR"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          AllowVectorExport = True
          Left = 106.196255840000000000
          Top = 0.779529999999994100
          Width = 141.991783480000000000
          Height = 18.897650000000000000
          DataField = 'TIPO'
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Recibo."TIPO"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 100.391797520000000000
          Top = 23.456710000000000000
          Width = 503.454638550000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strExtenso]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 2.005897520000000000
          Top = 71.149659999999990000
          Width = 95.265398550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'PARCELA :')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Align = baWidth
          AllowVectorExport = True
          Top = 110.724490000000000000
          Width = 718.110700000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 14211288
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS DO RECEBIMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo61: TfrxMemoView
          AllowVectorExport = True
          Left = 2.005897520000000000
          Top = 0.779529999999994100
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Recebemos de :')
        end
        object Memo62: TfrxMemoView
          AllowVectorExport = True
          Left = 2.005897520000000000
          Top = 23.456709999999990000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'O valor de :')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo63: TfrxMemoView
          AllowVectorExport = True
          Left = 2.005897520000000000
          Top = 46.133890000000010000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Referente a:')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 124.724490000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 207.094620000000000000
          Top = 28.220470000000000000
          Width = 86.929190000000000000
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
          Left = 299.260050000000000000
          Top = 28.220470000000000000
          Width = 411.968770000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strEndereco]')
          ParentFont = False
        end
        object strCEP: TfrxMemoView
          AllowVectorExport = True
          Left = 272.039580000000000000
          Top = 58.456710000000000000
          Width = 132.283550000000000000
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
          Left = 204.094620000000000000
          Top = 58.456710000000000000
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
          Left = 491.016080000000000000
          Top = 58.456710000000000000
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
          Left = 590.622450000000000000
          Top = 58.456710000000000000
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
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
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
          Left = 114.063080000000000000
          Width = 585.827150000000000000
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
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 28.015770000000000000
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
          Left = 59.385900000000000000
          Top = 28.015770000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCNPJ]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Align = baWidth
          AllowVectorExport = True
          Top = 91.708720000000000000
          Width = 718.110700000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 14211288
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          AllowVectorExport = True
          Left = 403.630180000000000000
          Top = 93.488250000000000000
          Width = 113.131876040000000000
          Height = 18.897650000000000000
          DataField = 'DOC'
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Recibo."DOC"]')
          ParentFont = False
        end
        object Line4: TfrxLineView
          AllowVectorExport = True
          Left = -219.212740000000000000
          Top = -215.433210000000000000
          Width = 200.315090000000000000
          Color = clBlack
          Frame.Typ = []
          Diagonal = True
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 3.779527560000000000
        Top = 204.094620000000000000
        Width = 718.110700000000000000
        Condition = '1=1'
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 128.504020000000000000
        Top = 544.252320000000100000
        Width = 718.110700000000000000
        object Line3: TfrxLineView
          AllowVectorExport = True
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Top = 110.047310000000000000
          Width = 99.648420170000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'C'#211'DIGO VALIDA'#199#195'O :')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          AllowVectorExport = True
          Left = 103.519790000000000000
          Top = 110.047310000000000000
          Width = 371.774580170000000000
          Height = 15.118120000000000000
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[strValidate]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 245.008040000000000000
          Top = 60.472480000000000000
          Width = 226.771653540000000000
          Color = clBlack
          Frame.Typ = []
          Diagonal = True
        end
        object Memo60: TfrxMemoView
          AllowVectorExport = True
          Left = 275.905690000000000000
          Top = 62.252010000000040000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Caixa:')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          AllowVectorExport = True
          Left = 429.431377520000000000
          Top = 20.456710000000040000
          Width = 166.907119240000000000
          Height = 15.118120000000000000
          DataField = 'DATA_PAGAMENTO'
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Recibo."DATA_PAGAMENTO"]')
          ParentFont = False
        end
        object Line7: TfrxLineView
          AllowVectorExport = True
          Left = 136.063080000000000000
          Top = 25.236240000000070000
          Width = 170.078850000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 0.500000000000000000
        end
        object Line8: TfrxLineView
          AllowVectorExport = True
          Left = 322.157700000000000000
          Top = 25.236240000000070000
          Width = 52.913420000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 0.500000000000000000
        end
        object Memo64: TfrxMemoView
          AllowVectorExport = True
          Left = 309.141930000000000000
          Top = 11.338590000000070000
          Width = 11.338590000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            ',')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object DT_CHEQUE: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 41.574830000000000000
        Top = 396.850650000000000000
        Width = 718.110700000000000000
        DataSet = frxTPBCheque
        DataSetName = 'TPBCheque'
        RowCount = 0
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 2.005897520000000000
          Top = 3.779530000000020000
          Width = 144.229939240000000000
          Height = 15.118120000000000000
          DataField = 'TOB_DESC'
          DataSet = frxTPBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBCheque."TOB_DESC"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Left = 199.212740000000000000
          Top = 3.779530000000000000
          Width = 49.911038550000000000
          Height = 15.118120000000000000
          DataField = 'CODIGO_BANCO'
          DataSet = frxTPBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TPBCheque."CODIGO_BANCO"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          AllowVectorExport = True
          Left = 146.519790000000000000
          Top = 3.779530000000000000
          Width = 49.911038550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'BANCO:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          AllowVectorExport = True
          Left = 252.685220000000000000
          Top = 3.779530000000000000
          Width = 57.470098550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'AG'#202'NCIA:')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          AllowVectorExport = True
          Left = 313.496290000000000000
          Top = 3.779530000000000000
          Width = 49.911038550000000000
          Height = 15.118120000000000000
          DataField = 'AGENCIA'
          DataSet = frxTPBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TPBCheque."AGENCIA"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          AllowVectorExport = True
          Left = 366.189240000000000000
          Top = 3.779530000000000000
          Width = 46.131508550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'CONTA:')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          AllowVectorExport = True
          Left = 412.320748550000000000
          Top = 3.779530000000000000
          Width = 76.474861450000000000
          Height = 15.118120000000000000
          DataField = 'CONTA'
          DataSet = frxTPBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBCheque."CONTA"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Align = baWidth
          AllowVectorExport = True
          Left = 488.795610000000000000
          Top = 3.779530000000000000
          Width = 60.472479999999990000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'CHEQUE:')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          AllowVectorExport = True
          Left = 549.268090000000000000
          Top = 3.779530000000000000
          Width = 61.249628550000000000
          Height = 15.118120000000000000
          DataField = 'CHEQUE'
          DataSet = frxTPBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBCheque."CHEQUE"]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          AllowVectorExport = True
          Left = 608.728316060000000000
          Top = 3.779530000000020000
          Width = 106.862320130000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = frxTPBCheque
          DataSetName = 'TPBCheque'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBCheque."VALOR"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          AllowVectorExport = True
          Left = 2.005897520000000000
          Top = 22.677180000000000000
          Width = 65.029158550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'EMISS'#195'O:')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          AllowVectorExport = True
          Left = 69.590600000000000000
          Top = 22.677180000000000000
          Width = 125.501638550000000000
          Height = 15.118120000000000000
          DataField = 'DATA_EMISSAO'
          DataSet = frxTPBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBCheque."DATA_EMISSAO"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          AllowVectorExport = True
          Left = 197.653680000000000000
          Top = 22.677180000000000000
          Width = 91.485868550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'COMPENSADO:')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          AllowVectorExport = True
          Left = 288.139548550000000000
          Top = 22.677180000000000000
          Width = 121.388281450000000000
          Height = 15.118120000000000000
          DataField = 'DATA_COMPENSACAO'
          DataSet = frxTPBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBCheque."DATA_COMPENSACAO"]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          AllowVectorExport = True
          Left = 412.320748550000000000
          Top = 22.677180000000000000
          Width = 70.954797640000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'PORTADOR:')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          AllowVectorExport = True
          Left = 486.380277640000000000
          Top = 22.677180000000000000
          Width = 227.548948550000000000
          Height = 15.118120000000000000
          DataField = 'PORTADOR'
          DataSet = frxTPBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBCheque."PORTADOR"]')
          ParentFont = False
        end
      end
      object DT_WEB: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 461.102660000000000000
        Width = 718.110700000000000000
        DataSet = frxTPBBanco
        DataSetName = 'TPBBanco'
        RowCount = 0
        object Memo47: TfrxMemoView
          AllowVectorExport = True
          Width = 144.229939240000000000
          Height = 15.118120000000000000
          DataField = 'HISTORICO'
          DataSet = frxTPBBanco
          DataSetName = 'TPBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBBanco."HISTORICO"]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          AllowVectorExport = True
          Left = 197.206842480000000000
          Width = 49.911038550000000000
          Height = 15.118120000000000000
          DataField = 'CODIGO_BANCO'
          DataSet = frxTPBBanco
          DataSetName = 'TPBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TPBBanco."CODIGO_BANCO"]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          AllowVectorExport = True
          Left = 250.679322480000000000
          Width = 57.470098550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'AG'#202'NCIA:')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          AllowVectorExport = True
          Left = 311.490392480000000000
          Width = 49.911038550000000000
          Height = 15.118120000000000000
          DataField = 'AGENCIA'
          DataSet = frxTPBBanco
          DataSetName = 'TPBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TPBBanco."AGENCIA"]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          AllowVectorExport = True
          Left = 364.183342480000000000
          Width = 46.131508550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'CONTA:')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          AllowVectorExport = True
          Left = 412.301462480000000000
          Width = 72.588218550000000000
          Height = 15.118120000000000000
          DataField = 'CONTA'
          DataSet = frxTPBBanco
          DataSetName = 'TPBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBBanco."CONTA"]')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          AllowVectorExport = True
          Left = 608.728316060000000000
          Width = 106.862320130000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = frxTPBBanco
          DataSetName = 'TPBBanco'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBBanco."VALOR"]')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          AllowVectorExport = True
          Left = 147.401670000000000000
          Width = 49.911038550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'BANCO:')
          ParentFont = False
        end
      end
      object DT_CAIXA: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 502.677490000000000000
        Width = 718.110700000000000000
        DataSet = frxDBTPBCaixa
        DataSetName = 'TPBCaixa'
        RowCount = 0
        object Memo53: TfrxMemoView
          AllowVectorExport = True
          Width = 352.104089240000000000
          Height = 15.118120000000000000
          DataField = 'DSC_HIST'
          DataSet = frxDBTPBCaixa
          DataSetName = 'TPBCaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBCaixa."DSC_HIST"]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          AllowVectorExport = True
          Left = 608.728316060000000000
          Width = 106.862320130000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = frxDBTPBCaixa
          DataSetName = 'TPBCaixa'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBCaixa."VALOR"]')
          ParentFont = False
        end
      end
    end
  end
  object frxDBRecibo: TfrxDBDataset
    UserName = 'Recibo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'DOC=DOC'
      'PARCELA=PARCELA'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DESCRICAO=DESCRICAO'
      'VALOR_PAGO=VALOR_PAGO'
      'IDTPB=IDTPB'
      'ID_CEDENTE=ID_CEDENTE'
      'FORNECEDOR=FORNECEDOR'
      'TIPO=TIPO'
      'CED_CNPJ=CED_CNPJ'
      'RAZAO_SOCIAL=RAZAO_SOCIAL'
      'SIGLA=SIGLA'
      'FANTASIA=FANTASIA'
      'CNPJ=CNPJ'
      'ORG_END=ORG_END')
    DataSet = qryObterDados
    BCDToCurrency = False
    Left = 688
    Top = 240
  end
  object qryObterDados: TFDQuery
    Active = True
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.ID_TITULO_PAGAR,'
      '       TP.NUMERO_DOCUMENTO AS DOC,'
      '       TP.PARCELA,'
      '       TP.data_pagamento,'
      '       TP.ID_ORGANIZACAO,'
      '       (H.descricao || '#39' '#39' ||  TP.DESCRICAO) AS DESCRICAO,'
      ''
      '       TPB.VALOR_PAGO,'
      '       TPB.id_titulo_pagar_baixa AS IDTPB,'
      ''
      '       TP.ID_CEDENTE,'
      '       C.nome AS FORNECEDOR,'
      '       TC.DESCRICAO as tipo,'
      '       c.cpfcnpj as ced_cnpj,'
      ''
      '       ORG.RAZAO_SOCIAL,'
      '       ORG.SIGLA,'
      '       ORG.FANTASIA,'
      '       ORG.CNPJ,'
      
        '      ( ORG.LOGRADOURO || '#39' '#39' || ORG.COMPLEMENTO || '#39' '#39' || ORG.N' +
        'UMERO || '#39' , '#39' || B.BAIRRO || '#39' - '#39' ||  CID.CIDADE || '#39' - '#39' ||  ' +
        'E.DESCRICAO || '#39' CEP: '#39' ||  ORG.CEP   ) as ORG_END'
      ''
      ''
      'FROM TITULO_PAGAR TP'
      ''
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.id_titulo_pagar =' +
        ' TP.id_titulo_pagar) AND (TPB.id_organizacao = TP.id_organizacao' +
        ')'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.id_cedente = TP.id_cedente) AND ' +
        '(C.id_organizacao = TP.id_organizacao)'
      
        'LEFT OUTER JOIN TIPO_CEDENTE TC ON (TC.id_TIPO_CEDENTE = C.ID_TI' +
        'PO_CEDENTE) AND (TC.id_organizacao = TP.id_organizacao)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.id_historico =  TP.id_historic' +
        'o) AND (H.id_organizacao = TP.id_organizacao)'
      
        'INNER JOIN ORGANIZACAO ORG ON (ORG.ID_ORGANIZACAO = TP.ID_ORGANI' +
        'ZACAO)'
      'INNER JOIN ESTADO E ON (E.ID_ESTADO = ORG.ID_ESTADO)'
      'INNER JOIN CIDADE CID ON (CID.ID_CIDADE = ORG.ID_CIDADE)'
      'INNER JOIN BAIRRO B ON (B.ID_BAIRRO = ORG.ID_BAIRRO)'
      'WHERE ( TP.ID_ORGANIZACAO = :PIDORGANIZACAO )'
      ' AND  ( TP.ID_TITULO_PAGAR = :PID )'
      ''
      ''
      '')
    Left = 784
    Top = 344
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
    Left = 872
    Top = 344
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
  object qryBaixaTPCaixa: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ' SELECT td.ID_TITULO_PAGAR_BAIXA,'
      '          td.data_movimento, '
      '          td.valor_nominal as VALOR,'
      '          td.descricao,'
      '          h.descricao as DSC_HIST'
      '   FROM TESOURARIA_DEBITO TD'
      
        '   LEFT OUTER JOIN historico h on (h.id_historico = td.id_histor' +
        'ico) and (h.id_organizacao = td.id_organizacao)'
      ''
      ' WHERE (TD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '         (TD.id_titulo_pagar_baixa = :PIDTITULOPAGARBAIXA)')
    Left = 280
    Top = 440
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
      '        TOB.DESCRICAO AS TOB_DESC,'
      '        CBC.numero_cheque AS CHEQUE,'
      '        CB.titular, CB.conta, CB.AGENCIA, B.codigo_banco,'
      '        CBC.data_emissao, CBC.data_compensacao, CBC.PORTADOR'
      ''
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
      
        'LEFT OUTER JOIN BANCO B ON (B.id_banco = CB.id_banco) AND (B.id_' +
        'organizacao = TPBC.id_organizacao)'
      
        'LEFT OUTER JOIN conta_contabil CC ON (CC.id_conta_contabil = CB.' +
        'id_conta_contabil) AND (CC.ID_ORGANIZACAO = TPBC.ID_ORGANIZACAO)'
      ''
      ''
      ''
      'WHERE (TPBC.id_organizacao = :PIDORGANIZACAO) AND'
      '       (TPBC.ID_TITULO_PAGAR_BAIXA = :PIDTITULOPAGARBAIXA)'
      '')
    Left = 200
    Top = 440
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
  object qryObterTPBBanco: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TPBI.ID_TITULO_PAGAR_BAIXA,'
      '       TPBI.ID_ORGANIZACAO,'
      '       TPBI.VALOR as VALOR,'
      '       TPBI.id_conta_bancaria,'
      '       TOB.DESCRICAO AS HISTORICO,'
      '       CB.titular, CB.conta, CB.AGENCIA, B.codigo_banco'
      ''
      ''
      '        '
      'FROM TITULO_PAGAR_BAIXA_INTERNET TPBI'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = TPBI.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGAN' +
        'IZACAO = TPBI.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = TPB' +
        'I.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = TPBI.ID_ORGANIZACA' +
        'O)'
      
        'LEFT OUTER JOIN BANCO B ON (B.id_banco = CB.id_banco) AND (B.id_' +
        'organizacao = TPBI.id_organizacao)'
      'WHERE (TPBI.ID_ORGANIZACAO = :PIDORGANIZACAO )AND'
      '      (TPBI.ID_TITULO_PAGAR_BAIXA = :PIDTPB)'
      ''
      'ORDER BY TPBI.VALOR;')
    Left = 361
    Top = 440
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
    Left = 32
    Top = 440
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
    Left = 112
    Top = 440
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
  object extenso: TEvExtenso
    Currency.Strings = (
      'real'
      'reais'
      'centavo'
      'centavos')
    Left = 896
    Top = 240
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
    BCDToCurrency = False
    Left = 792
    Top = 400
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
    BCDToCurrency = False
    Left = 872
    Top = 400
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
    Left = 27
    Top = 384
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
    Left = 110
    Top = 384
  end
  object frxDBTPBCaixa: TfrxDBDataset
    UserName = 'TPBCaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'DSC_HIST=DSC_HIST')
    DataSet = qryBaixaTPCaixa
    BCDToCurrency = False
    Left = 280
    Top = 384
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
      'TOB_DESC=TOB_DESC'
      'CHEQUE=CHEQUE'
      'TITULAR=TITULAR'
      'CONTA=CONTA'
      'AGENCIA=AGENCIA'
      'CODIGO_BANCO=CODIGO_BANCO'
      'DATA_EMISSAO=DATA_EMISSAO'
      'DATA_COMPENSACAO=DATA_COMPENSACAO'
      'PORTADOR=PORTADOR')
    DataSet = qryBaixaTPCheque
    BCDToCurrency = False
    Left = 193
    Top = 384
  end
  object frxTPBBanco: TfrxDBDataset
    UserName = 'TPBBanco'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'VALOR=VALOR'
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'HISTORICO=HISTORICO'
      'TITULAR=TITULAR'
      'CONTA=CONTA'
      'AGENCIA=AGENCIA'
      'CODIGO_BANCO=CODIGO_BANCO')
    DataSet = qryObterTPBBanco
    BCDToCurrency = False
    Left = 361
    Top = 384
  end
end
