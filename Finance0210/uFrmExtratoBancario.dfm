object frmExtratoBancario: TfrmExtratoBancario
  Left = 0
  Top = 0
  Caption = 'Emiss'#227'o de Extrato Banc'#225'rio'
  ClientHeight = 594
  ClientWidth = 975
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
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 574
    Width = 975
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
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 975
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 1
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Relat'#243'rio de Extrato Banc'#225'rio'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar2'
        end
        item
          ToolbarName = 'dxBarManager1Bar6'
        end
        item
          ToolbarName = 'dxBarManager1Bar5'
        end
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar4'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end>
      Index = 0
    end
  end
  object gridExtrato: TDBGrid
    Left = 0
    Top = 125
    Width = 975
    Height = 408
    Align = alClient
    DataSource = dtsExtrato
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = gridExtratoTitleClick
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DETALHAMENTO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 605
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TIPO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 50
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALOR'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 150
        Visible = True
      end>
  end
  object pnSaldoConta: TPanel
    Left = 0
    Top = 533
    Width = 975
    Height = 41
    Align = alBottom
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3692855
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object frxExtratoBancario: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    EngineOptions.PrintIfEmpty = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Author = 'Pempec Enterprise Finance 2K'
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.Name = 'Relat'#243'rio Extrato Banc'#225'rio'
    ReportOptions.LastChange = 43978.467593171300000000
    ReportOptions.VersionBuild = '2'
    ReportOptions.VersionMajor = '2'
    ReportOptions.VersionMinor = '1'
    ReportOptions.VersionRelease = '1'
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 64
    Top = 224
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
    Left = 424
    Top = 264
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
    Left = 152
    Top = 152
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
    Left = 272
    Top = 176
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
      DockedLeft = 664
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
      DockedLeft = 861
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
    object dxBarManager1Bar4: TdxBar
      Caption = 'Transmitir'
      CaptionButtons = <>
      DockedLeft = 735
      DockedTop = 0
      FloatLeft = 768
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          ViewLayout = ivlGlyphControlCaption
          Visible = True
          ItemName = 'chkPDF'
        end
        item
          Visible = True
          ItemName = 'dxBarBtnEnviarEmail'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar5: TdxBar
      Caption = 'Filtro'
      CaptionButtons = <>
      DockedLeft = 346
      DockedTop = 0
      FloatLeft = 768
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarCbxContas'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarBtnConsultar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar6: TdxBar
      Caption = 'Per'#237'odo'
      CaptionButtons = <>
      DockedLeft = 131
      DockedTop = 0
      FloatLeft = 768
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarDataInicial'
        end
        item
          Visible = True
          ItemName = 'dxBarDataFinal'
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
    object cxBarEditItem2: TcxBarEditItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      ShowCaption = True
      Width = 0
      PropertiesClassName = 'TcxCheckBoxProperties'
      Properties.ImmediatePost = True
    end
    object cxBarEditItem3: TcxBarEditItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      ShowCaption = True
      Width = 0
      PropertiesClassName = 'TcxCheckBoxProperties'
      Properties.ImmediatePost = True
    end
    object chkPDF: TcxBarEditItem
      Caption = 'PDF'
      Category = 0
      Hint = 'PDF'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000000E744558745469746C65005064663B53656E64C252BCE00000028449
        444154785E65524F48545F14FEEECC0B756A882CD29214332B6572516241CEA0
        E18804090DB47421B410AA5D24697F7E94444484D0AA850B3741FF8468A16136
        834561A8E568B93022B494292D4543677EEF9CDBBDF7F16CAC8F77DEBDDFE19C
        EF7C87F78494122E26C2E147CC1C91CC2026489B4044E6CEA48355D88AB37367
        EAB29006293952D8F314920566FEBB80C5580CC5B1178A03532DE7301FED43C9
        AB214848304BBCDB1F8878900EC9A679A2A60A3997AF821567063E1CAEC0F6B6
        EB66AA763C5A5E86F8817DE6BE46801946BDA8378AE98B2DDAAAE190FAAD0F87
        970E8C80754E8525847045C45828A46BF1B1BA12AC9B894D334933D9E4580223
        E58155EEB97377A0AFE3FE200D8F4DDB7A024CA1844DE48830B0F7E51B4C369F
        051CAE42AA600012A2F5468F6C6A3884BC9C8D986C3D8F85E751D86483898D80
        6DDBA698898C1322369CD8B8EAB27CBE4CBC7DFF05CBCB2914B55DC336727673
        218480E515888F4F61E957125EB10EA18AC24C55938482C5120856ECC2C0F067
        3CE98DA3A92168F64CAE103232BCC666EBAD07282ECAC791CA32743E1C34BA70
        000FB1D95915E4A260C7565CBAF918733F97B0393B0BDF661770AAB9033B0BF2
        113C580A8FF0C0B6E55A01D696159F492CC2BF3E0B671A6BD079AF1FC71BDB71
        BBA31BA74F1E455EEE16CCCDAF80A40411AF11B06C6224BE2FE2EBCC0FD45597
        A809848613211CAB2D07C0C8DEE4C79EE23CF444C76179B583BF04B4E2EBA14F
        88D49521952268F87D3EF837F8E042E7C3C1DDE8EA8EBB029E3F022A511F0E20
        45EE1F2720A04E764E172405EA6B03181A7D86745889C46CEC4A7BB44AB73A8F
        D671EF8EA8A10E472AB9DC0FC08682BB4BA6165AB5F52F045C38FAFF0348AA21
        6697DF17529B5239C3C2E10000000049454E44AE426082}
      ShowCaption = True
      Width = 0
      PropertiesClassName = 'TcxCheckBoxProperties'
      Properties.ImmediatePost = True
    end
    object dxBarBtnEnviarEmail: TdxBarLargeButton
      Caption = 'Enviar E-mail'
      Category = 0
      Hint = 'Enviar E-mail'
      Visible = ivAlways
      OnClick = dxBarBtnEnviarEmailClick
    end
    object dxBarDataInicial: TdxBarDateCombo
      Align = iaRight
      Caption = 'Data Inicial'
      Category = 0
      Hint = 'Data inicial'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000FF00FFFFFF00FFFFFF00
        FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFF0000
        00FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FF0000
        80FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFF000080FF000080FF000080FF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FFFF000000FF800000FF8000
        00FF800000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FFFF000000FF800000FF8000
        00FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF0000
        00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF}
      Width = 120
    end
    object dxBarDataFinal: TdxBarDateCombo
      Align = iaRight
      Caption = 'Data Final'
      Category = 0
      Hint = 'Data Final'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000FF00FFFFFF00FFFFFF00
        FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFF0000
        00FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FF0000
        80FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFF000080FF000080FF000080FF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FFFF000000FF800000FF8000
        00FF800000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FFFF000000FF800000FF8000
        00FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF0000
        00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF}
      Width = 120
    end
    object dxBarCbxContas: TdxBarCombo
      Caption = 'Conta Banc'#225'ria '
      Category = 0
      Hint = 'Conta Banc'#225'ria '
      Visible = ivAlways
      OnChange = dxBarCbxContasChange
      Width = 150
      ItemIndex = -1
    end
    object dxBarBtnConsultar: TdxBarButton
      Caption = 'Consultar'
      Category = 0
      Hint = 'Consultar'
      Visible = ivAlways
      OnClick = dxBarBtnConsultarClick
    end
  end
  object dtsExtrato: TDataSource
    DataSet = dmExtratoBancario.qryExtrato
    Left = 312
    Top = 320
  end
  object qryObterTodos: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT CB.ID_CONTA_BANCARIA,'
      '       CB.ID_ORGANIZACAO,'
      '       CB.ID_CONTA_CONTABIL, '
      '       CB.ID_BANCO,'
      '       CB.CONTA,'
      '       CB.AGENCIA,'
      '       CB.TITULAR'
      ''
      'FROM CONTA_BANCARIA CB'
      ''
      'WHERE (CB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (CB.ATIVO = 1)')
    Left = 437
    Top = 184
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
