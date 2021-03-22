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
          ToolbarName = 'dxBarManager1Bar4'
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
  end
  object Panel1: TPanel
    Left = 0
    Top = 125
    Width = 1264
    Height = 11
    Align = alTop
    TabOrder = 2
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
    Left = 264
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
      Caption = 'Per'#237'odo'
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
      Caption = 'Imprime'
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
        end
        item
          Visible = True
          ItemName = 'dxBarBtnEnviaEmail'
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
      DockedLeft = 643
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
    object dxBarManager1Bar4: TdxBar
      Caption = 'Exporta'
      CaptionButtons = <>
      DockedLeft = 350
      DockedTop = 0
      FloatLeft = 1292
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnExport'
        end
        item
          UserDefine = [udWidth]
          UserWidth = 190
          Visible = True
          ItemName = 'edtLocalExport'
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
    object dxBarBtnEnviaEmail: TdxBarLargeButton
      Caption = 'Enviar E-mail'
      Category = 0
      Hint = 'Enviar E-mail'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000000E744558745469746C65004D61696C3B4E6577A171F84B0000021F49
        444154785EA5934D48545D18809FF736A8D834431A9846660B89B285156411FD
        4C5614DA2290B00F5C652099D6A255C1884AB592C08A68119441D8CE0F246931
        9416811406C5D4486205E9989160E2CFBDF774DF602E17C5451B1F7839CFD93C
        BC8B7344555909162B441EF47C02155045F1F14DA818AECBB8AA2280AAC68136
        55E2A8B6291032C6A3BEA64C00591E5FEE432DDB5B3DA552D003AAB4E18791BB
        8FDF271062A8A202A83F8AB2A1204CD1C413483E6267633B3363A3840B8B797B
        3B4E2602589D5DEFD4768CFE8B0F77CEE8AF44932EBC69D6C9FF6B75A0B924D1
        7F711321401CC7F0F4C5307B7714138DE4E2795EB035960863CF3AF8997C49E9
        FE7AA6478688E645706CFBB0423C13B05D97A2C228F7BB07A9AADCCAB6D2F538
        C603605548C8D97D0E275A4D7FE721A4A09C3FE9D700A28ABF816B1B7273B3A9
        3CB885DE448A642A4D4D7539283CEC7E45EACB144D67634CC52E305552C7CCAD
        F21B59210151FC0D1CC3F4ACC3F8F82CD547CAF83CFA83CBED3DA4C726A93ABE
        8BFF4E55F0F5FB6FF2F79C6764F01B0DDDD3D77A6AD7002C06EC39C3B17D9B41
        8448389B757961003616E591BF76358A32F47182E4F02480000492D3D8D237DF
        71E528B6F1100565115D22D95916975AFBB877FD64445567820D701D8308842C
        2B788504E0F909B504015CD7232008780B0BF3CF1BAEF6C6347840A2088A7FCF
        1801AE3D370098A501D375F3F409DF117F203897B90206B0F161C5DFF92F5E25
        157110505FC30000000049454E44AE426082}
      OnClick = dxBarBtnEnviaEmailClick
    end
    object dxBarBtnExport: TdxBarLargeButton
      Caption = 'Exporta CSV'
      Category = 0
      Hint = 'Exporta CSV'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001D744558745469746C65004578706F72743B4353563B4578706F7274
        546F4353563B61685AF00000020C49444154785E8D933D6B544114869FB9C68F
        C2CA5A89105289A8681209C88AC108011BFD07C982010329446C244534454A21
        88B0F90B2E22229242C807BB91A028961A4940BBC5147EC4ECCE9C57380C97C5
        3472997BDEB99CF3CC7B997302F0EFA28CFB3580802849003D4098AFADBF2E42
        510110427202267F230590210231FE599D99BA3C027432800285CA9DEA40C92F
        C5FE2D738F1B978003DD80106520D86B270428439485080838722890A2011400
        2520B513004902511641C0D941191C88C97343378014132094010AC1B5726AD6
        0EAB0CF53207D0EDA0930C01332B9B2C6FB7200AC9308B98EB845942D1FC7BFF
        83FACFFED9A760A95E00C11D002BDB3B54CF1EA731314CA33A8C24AA177A599F
        BC4263720461AC4F5D03196FA6C730B31BEEA0DD4948208B8C9F39C1506D0DAC
        83A2183F7F92C185257760660E953BC67501D0C90E64C21F455214A6486D6393
        E6EDAB5407FA72A130093340C90121A5EC40C263F434DF2F363F33F8E8251383
        7DBE7FF7F53BD58BFDBCFFD642829E0C002F4E2C6E6CD1BC554188A185253FDD
        10B5E62777F0FCE316F747CF31FBEA2D921180A3E3F79EFD78F2F03AD32F3EB0
        FAA5855904FF67F3E5D653BE090999504C48A95EF68180F9D1D3E52CE47BCFDA
        7284D5C62637C74E1D93B493FB80D8DEFDBD3C71B75E3141911BC704210859E8
        EA4ED1DEFBB506B4BB47B5000E0307FF63A4958768575202F80BB14381F3D6DB
        90F20000000049454E44AE426082}
      OnClick = dxBarBtnExportClick
    end
    object cxBarEditItem1: TcxBarEditItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
    end
    object cxBarEditItem2: TcxBarEditItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      PropertiesClassName = 'TcxMemoProperties'
    end
    object edtLocalExport: TdxBarEdit
      Caption = 'Pasta'#13#10
      Category = 0
      Hint = 'Pasta'#13#10
      Visible = ivAlways
      Width = 300
    end
  end
  object dsMain: TDataSource
    AutoEdit = False
    DataSet = qryConsolidadoCC
    Left = 152
    Top = 232
  end
  object frxRelatorio: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 44256.918846215260000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 376
    Top = 304
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'dados'
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
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 220.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Style = fsDouble
      Frame.Typ = []
      LargeDesignHeight = True
      MirrorMode = []
      PrintOnPreviousPage = True
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 117.165395830000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 1.559060000000000000
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
          Top = 1.559060000000000000
          Width = 442.205010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[strRazaoSocial]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 572.094620000000000000
          Top = 1.559060000000000000
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
          Left = 628.638220000000000000
          Top = 1.559060000000000000
          Width = 245.669450000000000000
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
          Width = 442.205010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strEndereco]')
          ParentFont = False
        end
        object strCEP: TfrxMemoView
          AllowVectorExport = True
          Left = 632.417750000000000000
          Top = 33.795300000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCEP]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 572.094620000000000000
          Top = 33.795300000000000000
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
          Left = 790.142240000000000000
          Top = 33.795300000000000000
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
          Left = 903.307670000000000000
          Top = 33.795300000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
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
          Left = 963.780150000000000000
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
          Left = 910.866730000000000000
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
          Align = baWidth
          AllowVectorExport = True
          Top = 74.370130000000000000
          Width = 1046.929810000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'CENTRO DE CUSTOS CONSOLIDADOS DO  [strPeriodo]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line5: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 60.472480000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Style = fsDouble
          Frame.Typ = [ftTop]
        end
      end
      object Memo41: TfrxMemoView
        AllowVectorExport = True
        Left = 7.559060000000000000
        Top = -7.559060000000000000
        Width = 49.133890000000000000
        Height = 15.118120000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
        ParentFont = False
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 438.425480000000000000
        Width = 1046.929810000000000000
        object Memo36: TfrxMemoView
          Align = baLeft
          AllowVectorExport = True
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
          Align = baRight
          AllowVectorExport = True
          Left = 941.102970000000000000
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
          Align = baRight
          AllowVectorExport = True
          Left = 869.291900000000000000
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
          Align = baRight
          AllowVectorExport = True
          Left = 997.795920000000000000
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
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 196.535560000000000000
        Width = 1046.929810000000000000
        Condition = '1=1'
        object Line2: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo23: TfrxMemoView
          AllowVectorExport = True
          Top = 2.779530000000000000
          Width = 120.944960000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CENTRO DE CUSTOS')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 123.472431180000000000
          Top = 2.779530000000000000
          Width = 75.590551180000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'JANEIRO')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 26.456710000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 200.401621180000000000
          Top = 2.779530000000000000
          Width = 75.590551180000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'FEVEREIRO')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Left = 277.551281180000000000
          Top = 2.779530000000000000
          Width = 75.590551180000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'MAR'#199'O')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          AllowVectorExport = True
          Left = 354.480471180000000000
          Top = 2.779530000000000000
          Width = 75.590551180000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'ABRIL')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          AllowVectorExport = True
          Left = 431.630131180000000000
          Top = 2.779530000000000000
          Width = 75.590551180000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'MAIO')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 508.559321180000000000
          Top = 2.779530000000000000
          Width = 75.590551180000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'JUNHO')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 585.708981180000000000
          Top = 2.779530000000000000
          Width = 75.590551180000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'JULHO')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          AllowVectorExport = True
          Left = 663.638171180000000000
          Top = 2.779530000000000000
          Width = 75.590551180000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'AGOSTO')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          AllowVectorExport = True
          Left = 739.787831180000000000
          Top = 2.779530000000000000
          Width = 75.590551180000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'SETEMBRO')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          AllowVectorExport = True
          Left = 816.717021180000000000
          Top = 2.779530000000000000
          Width = 75.590551180000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'OUTUBRO')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          AllowVectorExport = True
          Left = 893.780101180000000000
          Top = 2.779530000000000000
          Width = 75.590551180000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'NOVEMBRO')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          AllowVectorExport = True
          Left = 970.929810000000000000
          Top = 2.779530000000000000
          Width = 75.590551180000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'DEZEMBRO')
          ParentFont = False
        end
      end
      object SALDOS: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 17.007874020000000000
        Top = 249.448980000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBDataset1
        DataSetName = 'dados'
        RowCount = 0
        object Memo14: TfrxMemoView
          Align = baClient
          AllowVectorExport = True
          Width = 1046.929810000000000000
          Height = 17.007874020000000000
          Frame.Typ = []
          Fill.BackColor = clWindow
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 10218495
          Highlight.Frame.Typ = []
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DataField = 'CENTRO_CUSTO_DSC'
          DataSet = frxDBDataset1
          DataSetName = 'dados'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dados."CENTRO_CUSTO_DSC"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 123.472431180000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'JANEIRO'
          DataSet = frxDBDataset1
          DataSetName = 'dados'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dados."JANEIRO"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 200.401621180000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'FEVEREIRO'
          DataSet = frxDBDataset1
          DataSetName = 'dados'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dados."FEVEREIRO"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          AllowVectorExport = True
          Left = 277.551281180000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'MARCO'
          DataSet = frxDBDataset1
          DataSetName = 'dados'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dados."MARCO"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          AllowVectorExport = True
          Left = 354.480471180000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'ABRIL'
          DataSet = frxDBDataset1
          DataSetName = 'dados'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dados."ABRIL"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          AllowVectorExport = True
          Left = 431.630131180000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'MAIO'
          DataSet = frxDBDataset1
          DataSetName = 'dados'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dados."MAIO"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          AllowVectorExport = True
          Left = 508.559321180000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'JUNHO'
          DataSet = frxDBDataset1
          DataSetName = 'dados'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dados."JUNHO"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          AllowVectorExport = True
          Left = 585.708981180000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'JULHO'
          DataSet = frxDBDataset1
          DataSetName = 'dados'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dados."JULHO"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          AllowVectorExport = True
          Left = 663.638171180000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'AGOSTO'
          DataSet = frxDBDataset1
          DataSetName = 'dados'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dados."AGOSTO"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          AllowVectorExport = True
          Left = 739.787831180000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'SETEMBRO'
          DataSet = frxDBDataset1
          DataSetName = 'dados'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dados."SETEMBRO"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          AllowVectorExport = True
          Left = 816.717021180000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'OUTUBRO'
          DataSet = frxDBDataset1
          DataSetName = 'dados'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dados."OUTUBRO"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          AllowVectorExport = True
          Left = 893.780101180000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'NOVEMBRO'
          DataSet = frxDBDataset1
          DataSetName = 'dados'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dados."NOVEMBRO"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          AllowVectorExport = True
          Left = 970.929810000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'DEZEMBRO'
          DataSet = frxDBDataset1
          DataSetName = 'dados'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[dados."DEZEMBRO"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 41.574830000000000000
        Top = 291.023810000000000000
        Width = 1046.929810000000000000
        object Line3: TfrxLineView
          AllowVectorExport = True
          Top = 16.000000000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo35: TfrxMemoView
          AllowVectorExport = True
          Left = 123.472431180000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmConsolidadoBancos.frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<dados."JANEIRO">,SALDOS)]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          AllowVectorExport = True
          Top = 19.000000000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'TOTAIS ')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          AllowVectorExport = True
          Left = 200.401621180000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmConsolidadoBancos.frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<dados."FEVEREIRO">,SALDOS)]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          AllowVectorExport = True
          Left = 277.551281180000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmConsolidadoBancos.frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<dados."MARCO">,SALDOS)]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          AllowVectorExport = True
          Left = 354.480471180000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmConsolidadoBancos.frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<dados."ABRIL">,SALDOS)]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          AllowVectorExport = True
          Left = 431.630131180000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmConsolidadoBancos.frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<dados."MAIO">,SALDOS)]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          AllowVectorExport = True
          Left = 508.559321180000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmConsolidadoBancos.frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<dados."JUNHO">,SALDOS)]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          AllowVectorExport = True
          Left = 585.708981180000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmConsolidadoBancos.frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<dados."JULHO">,SALDOS)]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          AllowVectorExport = True
          Left = 663.638171180000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmConsolidadoBancos.frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<dados."AGOSTO">,SALDOS)]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          AllowVectorExport = True
          Left = 739.787831180000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmConsolidadoBancos.frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<dados."SETEMBRO">,SALDOS)]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          AllowVectorExport = True
          Left = 816.717021180000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmConsolidadoBancos.frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<dados."OUTUBRO">,SALDOS)]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          AllowVectorExport = True
          Left = 893.780101180000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmConsolidadoBancos.frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<dados."NOVEMBRO">,SALDOS)]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          AllowVectorExport = True
          Left = 970.929810000000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmConsolidadoBancos.frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<dados."DEZEMBRO">,SALDOS)]')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 3.779530000000020000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 393.071120000000000000
        Width = 1046.929810000000000000
      end
    end
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
    Left = 368
    Top = 232
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
    Left = 624
    Top = 222
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'dados'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CENTRO_CUSTO_DSC=CENTRO_CUSTO_DSC'
      'JANEIRO=JANEIRO'
      'FEVEREIRO=FEVEREIRO'
      'MARCO=MARCO'
      'ABRIL=ABRIL'
      'MAIO=MAIO'
      'JUNHO=JUNHO'
      'JULHO=JULHO'
      'AGOSTO=AGOSTO'
      'SETEMBRO=SETEMBRO'
      'OUTUBRO=OUTUBRO'
      'NOVEMBRO=NOVEMBRO'
      'DEZEMBRO=DEZEMBRO')
    DataSet = qryConsolidadoCC
    BCDToCurrency = False
    Left = 272
    Top = 312
  end
end