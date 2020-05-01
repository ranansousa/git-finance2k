object frmExtratoBancario: TfrmExtratoBancario
  Left = 0
  Top = 0
  Caption = 'Emiss'#227'o de Extrato Banc'#225'rio'
  ClientHeight = 384
  ClientWidth = 732
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 144
  TextHeight = 19
  inline frmContaBancaria1: TfrmContaBancaria
    Left = 389
    Top = 172
    Width = 300
    Height = 78
    TabOrder = 0
    ExplicitLeft = 389
    ExplicitTop = 172
    ExplicitWidth = 300
    ExplicitHeight = 78
    inherited lbl1: TLabel
      Width = 105
      Height = 19
      ExplicitWidth = 105
      ExplicitHeight = 19
    end
    inherited cbbConta: TComboBox
      Top = 28
      Width = 273
      Height = 27
      OnChange = frmContaBancaria1cbbContaChange
      ExplicitTop = 28
      ExplicitWidth = 273
      ExplicitHeight = 27
    end
    inherited qryObterTodos: TFDQuery
      Left = 128
      Top = 32
    end
    inherited qryObterContaContabil: TFDQuery
      Left = 40
      Top = 40
    end
  end
  inline frmPeriodo1: TfrmPeriodo
    Left = 32
    Top = 172
    Width = 351
    Height = 78
    TabOrder = 1
    ExplicitLeft = 32
    ExplicitTop = 172
    ExplicitWidth = 351
    ExplicitHeight = 78
    inherited lbl1: TLabel
      Top = 3
      Width = 79
      Height = 19
      ExplicitTop = 3
      ExplicitWidth = 79
      ExplicitHeight = 19
    end
    inherited lbl2: TLabel
      Left = 186
      Top = 3
      Width = 70
      Height = 19
      ExplicitLeft = 186
      ExplicitTop = 3
      ExplicitWidth = 70
      ExplicitHeight = 19
    end
    inherited dtpDataInicial: TDateTimePicker
      Top = 28
      Width = 130
      Height = 30
      OnChange = frmPeriodo1dtpDataInicialChange
      ExplicitTop = 28
      ExplicitWidth = 130
      ExplicitHeight = 30
    end
    inherited dtpDataFinal: TDateTimePicker
      Left = 186
      Top = 28
      Width = 130
      Height = 30
      OnChange = frmPeriodo1dtpDataFinalChange
      ExplicitLeft = 186
      ExplicitTop = 28
      ExplicitWidth = 130
      ExplicitHeight = 30
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 364
    Width = 732
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 500
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ExplicitTop = 363
    ExplicitWidth = 724
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 732
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 3
    TabStop = False
    ExplicitWidth = 724
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Relat'#243'rio de Extrato Banc'#225'rio'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar2'
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
  object frxExtratoBancario: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 43761.866405787000000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 352
    Top = 288
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
    Left = 240
    Top = 288
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
    Left = 152
    Top = 288
  end
  object frxExtrato: TfrxDBDataset
    UserName = 'EXTRATO'
    CloseDataSource = False
    FieldAliases.Strings = (
      'DATA=DATA'
      'VALOR=VALOR'
      'DETALHAMENTO=DETALHAMENTO'
      'TIPO=TIPO')
    DataSet = dmExtratoBancario.qryExtrato
    BCDToCurrency = False
    Left = 64
    Top = 288
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
    Left = 416
    Top = 64
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
    Left = 808
    Top = 48
    PixelsPerInch = 96
    object dxBarManager1Bar2: TdxBar
      Caption = 'Op'#231#245'es'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 915
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          ViewLayout = ivlGlyphControlCaption
          Visible = True
          ItemName = 'chkTipo'
        end
        item
          ViewLayout = ivlGlyphControlCaption
          Visible = True
          ItemName = 'chkCheque'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar1: TdxBar
      Caption = 'Imprimir'
      CaptionButtons = <>
      DockedLeft = 131
      DockedTop = 0
      FloatLeft = 915
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnImprimir'
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
      DockedLeft = 202
      DockedTop = 0
      FloatLeft = 915
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
    object dtInicial: TcxBarEditItem
      Align = iaRight
      Caption = 'Data Inicial'
      Category = 0
      Hint = 'Data Inicial'
      Visible = ivAlways
      PropertiesClassName = 'TcxDateEditProperties'
    end
    object dtFinal: TcxBarEditItem
      Align = iaRight
      Caption = 'Data Final'
      Category = 0
      Hint = 'Data Final'
      Visible = ivAlways
      PropertiesClassName = 'TcxDateEditProperties'
    end
    object dxBtnConsulta: TdxBarButton
      Caption = '     Consultar  '
      Category = 0
      Hint = '     Consultar  '
      Visible = ivAlways
    end
    object chkTipo: TcxBarEditItem
      Caption = 'Totalizado por dia'
      Category = 0
      Hint = 'Totalizado por dia'
      Visible = ivAlways
      ShowCaption = True
      Width = 0
      PropertiesClassName = 'TcxCheckBoxProperties'
      Properties.ImmediatePost = True
    end
    object chkCheque: TcxBarEditItem
      Caption = 'Cheques emitidos'
      Category = 0
      Enabled = False
      Hint = 'Cheques emitidos'
      Visible = ivAlways
      ShowCaption = True
      Width = 0
      PropertiesClassName = 'TcxCheckBoxProperties'
      Properties.ImmediatePost = True
    end
    object cxBarEditItem1: TcxBarEditItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      ShowCaption = True
      Width = 0
      PropertiesClassName = 'TcxCheckBoxProperties'
      Properties.ImmediatePost = True
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'New SubItem'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object dxBtnImprimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprimir'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000010744558745469746C65005072696E743B5064663BA5B5DD12000002
        6249444154785EA5534D48545114FEDE6B22AD454651D0AE5270C4824ADC2854
        E4A285A32941102E92A8064CFA612890A42145A442910A342268618B42572D12
        0BA70C6122290B02A94D05FD408E32A333CE7BEF9ED3BDE7390DE3B66FF8E6FC
        DC73BE7BEE7BF759CC8CFF4120E7581AB37575234CD4A409450AEC2928A5C427
        65489A9E8EC9F7498D0690C71A3035ED7836A68D859FD1AB48C562288B4D8209
        F8DE71190B132F109C9A068341C478BFAFB2D9461E3698A4F973DD416CBBD605
        620211F0A9A61ADBBB7B655766C6C7AA3DF8B07FB7F805024410F55DE313F8D1
        D9614695186CB2C6F871457C06C42C02014B0310A1803430F0E5502DC8F88AA4
        59B1EC2C396260A6AAF25F6CF70CBE3ADCFFF05DFC78B837C52C0D723E4F295F
        8480F2D76FF0ED4A04F0634DD624000CEBD683E9DF2742E55BCF5EECC5C9F959
        94FEF9AA9BBD95A74CF03C4F8A492999442992D89F9647AD9EA1B71C69DD8B96
        7017E6128B00C3307F76F1819292223CBA7F1D3D4371749FAF59CFCC19B90759
        C745C65138D512C2C0E03012730B20C590DF8AC0964D1B71A6B519E965174ED6
        8386050311D0C9B416290D96E1CE40D45F2316CB3623576DBCE4928BAC2F60E7
        051C0FA98C87A52507A7DBFBE083B11AF76E476059AC27500513D826915C7431
        BFB88CC6503D9E3F89E2E8A573085D68C391F6368C3D8EA2B1A11E89641AC9B4
        0BD75D7584C4DCAF97FD77C70F384E1615C19DF08810AEDE0C96B9194ADE04E1
        C6CD61D87600AE939E04202A39A562CDB59A4591EEA723EB8A37D4E697586C26
        9D9CEAEB6C380620A3E9682E3333499576725FA36D447CB1822BCE9AEE4A93C2
        2AFC05E9C29476E9D9BD180000000049454E44AE426082}
      OnClick = dxBtnImprimirClick
    end
    object dxBtnFechar: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBtnFecharClick
    end
  end
end