object frmConsolidadoCC: TfrmConsolidadoCC
  Left = 0
  Top = 0
  Caption = 'Consolidado Centro de Custos'
  ClientHeight = 561
  ClientWidth = 1264
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
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 1264
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 0
    TabStop = False
    ExplicitWidth = 1244
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Consolidado Centro de Custos'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar2'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end>
      Index = 0
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 541
    Width = 1264
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
    ExplicitTop = 390
    ExplicitWidth = 1244
  end
  object Panel1: TPanel
    Left = 0
    Top = 125
    Width = 1264
    Height = 11
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 1244
  end
  object dbgMain: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 139
    Width = 1258
    Height = 399
    Align = alClient
    Color = clInfoBk
    DataSource = dsMain
    GradientEndColor = clTeal
    GradientStartColor = clMoneyGreen
    Options = [dgTitles, dgColLines, dgRowLines, dgTabs]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    StyleElements = [seFont, seClient]
    Columns = <
      item
        Expanded = False
        FieldName = 'CENTRO_CUSTO_DSC'
        Title.Alignment = taCenter
        Title.Caption = 'CENTRO CUSTOS    '
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JANEIRO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FEVEREIRO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MARCO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ABRIL'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAIO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JUNHO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JULHO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AGOSTO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SETEMBRO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OUTUBRO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOVEMBRO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DEZEMBRO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end>
  end
  object qryConsolidadoCC: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'select'
      '  c.centro_custo_dsc,'
      '  sum(c.janeiro) as janeiro,'
      '  sum(c.fevereiro) as fevereiro,'
      '  sum(c.marco) as marco,'
      '  sum(c.abril) as abril,'
      '  sum(c.maio) as maio,'
      '  sum(c.junho) as junho,'
      '  sum(c.julho) as julho,'
      '  sum(c.agosto) as agosto,'
      '  sum(c.setembro) as setembro,'
      '  sum(c.outubro) as outubro,'
      '  sum(c.novembro) as novembro,'
      '  sum(c.dezembro) as dezembro'
      'from'
      '  sp_consolidadocc(:PANO,:PIDORGANIZACAO) c'
      'group by'
      '  c.centro_custo_dsc'
      'order by'
      '  c.centro_custo_dsc')
    Left = 248
    Top = 232
    ParamData = <
      item
        Name = 'PANO'
        DataType = ftSmallint
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
        Value = Null
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
    Left = 688
    Top = 56
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Par'#226'metros'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1210
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'cbxAnosPagtos'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btnGerar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Impress'#227'o'
      CaptionButtons = <>
      DockedLeft = 229
      DockedTop = 0
      FloatLeft = 1210
      FloatTop = 2
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
    object dxBarManager1Bar3: TdxBar
      Caption = 'Sair'
      CaptionButtons = <>
      DockedLeft = 300
      DockedTop = 0
      FloatLeft = 1210
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarFechar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarFechar: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBarFecharClick
    end
    object dxBarImprimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprimir'
      Visible = ivAlways
      OnClick = dxBarImprimirClick
    end
    object cbxAnosPagtos: TdxBarCombo
      Align = iaCenter
      Caption = 'Ano   '
      Category = 0
      Hint = 'Ano   '
      Visible = ivAlways
      ItemIndex = -1
    end
    object btnGerar: TdxBarButton
      Align = iaCenter
      Caption = '      Gerar      '
      Category = 0
      Hint = '      Gerar      '
      Visible = ivAlways
      OnClick = btnGerarClick
    end
  end
  object dsMain: TDataSource
    AutoEdit = False
    DataSet = qryConsolidadoCC
    Left = 176
    Top = 248
  end
  object relatorio: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44250.544480335650000000
    ReportOptions.LastChange = 44250.544480335650000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 416
    Top = 56
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object qryAnosPagto: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT '
      
        '--cast(extract(year from MAX(TP.DATA_PAGAMENTO)) as varchar(5)) ' +
        'as MAIOR ,'
      
        '--cast(extract(year from MIN(TP.DATA_PAGAMENTO)) as varchar(5)) ' +
        'as MENOR'
      ''
      'extract(year from MAX(TP.DATA_PAGAMENTO)) as MAIOR ,'
      'extract(year from MIN(TP.DATA_PAGAMENTO)) as MENOR'
      ''
      ''
      'FROM TITULO_PAGAR TP'
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) '
      'AND   (TP.ID_TIPO_STATUS IN ('#39'QUITADO'#39', '#39'PARCIAL'#39'))')
    Left = 496
    Top = 56
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
        Value = Null
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
    Left = 592
    Top = 54
  end
end
