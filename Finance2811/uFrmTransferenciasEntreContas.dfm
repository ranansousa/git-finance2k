object frmTransferenciasEntreContas: TfrmTransferenciasEntreContas
  Left = 0
  Top = 0
  Caption = 'Transfer'#234'ncias entre contas banc'#225'rias'
  ClientHeight = 456
  ClientWidth = 884
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
  object cxPageCTRFBCO: TcxPageControl
    Left = 0
    Top = 125
    Width = 884
    Height = 311
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = cxTableTransfere
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 311
    ClientRectRight = 884
    ClientRectTop = 24
    object cxTableTransfere: TcxTabSheet
      Caption = 'Transfere'
      ImageIndex = 0
      object cbbDataMovimento: TcxDateEdit
        Left = 340
        Top = 27
        Properties.OnChange = cbbDataMovimentoPropertiesChange
        TabOrder = 0
        Width = 141
      end
      object cxLabel1: TcxLabel
        Left = 32
        Top = 28
        Caption = 'Identificador'
      end
      object cxLabel10: TcxLabel
        Left = 32
        Top = 148
        Caption = 'Conta cont'#225'bil cr'#233'dito'
      end
      object cxLabel2: TcxLabel
        Left = 501
        Top = 82
        Caption = 'Tipo opera'#231#227'o banc'#225'ria'
      end
      object cxLabel5: TcxLabel
        Left = 501
        Top = 28
        Caption = 'Valor da opera'#231#227'o'
      end
      object cxLabel6: TcxLabel
        Left = 281
        Top = 28
        Caption = 'Data'
      end
      object cxLabel9: TcxLabel
        Left = 278
        Top = 148
        Caption = 'Conta cont'#225'bil d'#233'bito'
      end
      inline frmContaBancaria1: TfrmContaBancaria
        Left = 16
        Top = 79
        Width = 243
        Height = 74
        TabOrder = 7
        ExplicitLeft = 16
        ExplicitTop = 79
        ExplicitHeight = 74
        inherited lbl1: TLabel
          Top = 3
          Width = 110
          Caption = 'Conta Banc'#225'ria Origem'
          ExplicitTop = 3
          ExplicitWidth = 110
        end
        inherited cbbConta: TComboBox
          Top = 22
          OnChange = frmContaBancaria1cbbContaChange
          ExplicitTop = 22
        end
        inherited qryObterTodos: TFDQuery
          Left = 144
          Top = 16
        end
        inherited qryObterContaContabil: TFDQuery
          Left = 64
          Top = 16
        end
      end
      object edtContaContabilCR: TcxTextEdit
        Left = 32
        Top = 171
        Enabled = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 8
        Width = 201
      end
      object edtContaContabilDB: TcxTextEdit
        Left = 278
        Top = 171
        Enabled = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 9
        Width = 201
      end
      object edtIdentificador: TcxTextEdit
        Left = 101
        Top = 27
        Enabled = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 10
        Width = 130
      end
      object edtTipoOperacao: TcxTextEdit
        Left = 501
        Top = 102
        Enabled = False
        TabOrder = 11
        Width = 240
      end
      inline frmContaBancaria2: TfrmContaBancaria
        Left = 265
        Top = 79
        Width = 230
        Height = 74
        TabOrder = 12
        ExplicitLeft = 265
        ExplicitTop = 79
        ExplicitWidth = 230
        ExplicitHeight = 74
        inherited lbl1: TLabel
          Top = 4
          Width = 112
          Caption = 'Conta Banc'#225'ria Destino'
          ExplicitTop = 4
          ExplicitWidth = 112
        end
        inherited cbbConta: TComboBox
          Top = 23
          OnChange = frmContaBancaria2cbbContaChange
          ExplicitTop = 23
        end
        inherited qryObterTodos: TFDQuery
          Left = 136
          Top = 16
        end
        inherited qryObterContaContabil: TFDQuery
          Top = 16
        end
      end
      inline frameResponsavel1: TframeResponsavel
        Left = 485
        Top = 144
        Width = 284
        Height = 102
        TabOrder = 13
        ExplicitLeft = 485
        ExplicitTop = 144
        ExplicitWidth = 284
        ExplicitHeight = 102
        inherited lblID: TLabel
          Left = 147
          ExplicitLeft = 147
        end
        inherited lblResponsavel: TLabel
          Left = 20
          Top = 8
          ExplicitLeft = 20
          ExplicitTop = 8
        end
        inherited cbbcombo: TComboBox
          Left = 19
          Top = 27
          Width = 233
          OnChange = frameResponsavel1cbbcomboChange
          ExplicitLeft = 19
          ExplicitTop = 27
          ExplicitWidth = 233
        end
      end
      object edtObservacao: TcxTextEdit
        Left = 32
        Top = 227
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 14
        Width = 447
      end
      object cxLabel3: TcxLabel
        Left = 32
        Top = 204
        Caption = 'Observa'#231#227'o'
      end
      object edtValor: TEvNumEdit
        Left = 598
        Top = 27
        Width = 141
        Height = 21
        Glyph.Data = {
          7E050000424D7E0500000000000036000000280000001A0000000D0000000100
          2000000000004805000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF009A6A39009767360093643400906131008C5E2F00895B
          2C0085582A00825527007F522500FF00FF00FF00FF00FF00FF00FF00FF008585
          8500828282007F7F7F007D7D7D007A7A7A007777770075757500727272006F6F
          6F00FF00FF00FF00FF00FF00FF00FF00FF009F6E3C00E3947600DC8B6A00D682
          5E00D07A5300CB724900C66B3F00C66B3F0082552700FF00FF00FF00FF00FF00
          FF00FF00FF0089898900B1B1B100A9A9A900A1A1A10099999900929292008B8B
          8B008B8B8B0072727200FF00FF00FF00FF00FF00FF00FF00FF00A2713E00FFFF
          FF00D0A08000FFFFFF00D0A08000FFFFFF00D0A08000E9D7C30085582A00FF00
          FF00FF00FF00FF00FF00FF00FF008B8B8B00FFFFFF00B7B7B700FFFFFF00B7B7
          B700FFFFFF00B7B7B700E0E0E00075757500FF00FF00FF00FF00FF00FF00FF00
          FF00A5734000E3947600DC8B6A00D6825E00D07A5300CB724900C66B3F00C66B
          3F00895B2C00FF00FF00FF00FF00FF00FF00FF00FF008D8D8D00B1B1B100A9A9
          A900A1A1A10099999900929292008B8B8B008B8B8B0077777700FF00FF00FF00
          FF00FF00FF00FF00FF00A8764200FFFFFF00D0A08000FFFFFF00D0A08000FFFF
          FF00D0A08000E9D7C3008C5E2F00FF00FF00FF00FF00FF00FF00FF00FF008F8F
          8F00FFFFFF00B7B7B700FFFFFF00B7B7B700FFFFFF00B7B7B700E0E0E0007A7A
          7A00FF00FF00FF00FF00FF00FF00FF00FF00AB794400E3947600DC8B6A00D682
          5E00D07A5300CB724900C66B3F00C66B3F0090613100FF00FF00FF00FF00FF00
          FF00FF00FF0092929200B1B1B100A9A9A900A1A1A10099999900929292008B8B
          8B008B8B8B007D7D7D00FF00FF00FF00FF00FF00FF00FF00FF00AE7B4600FFFF
          FF00D0A08000FFFFFF00D0A08000FFFFFF00D0A08000E9D7C30093643400FF00
          FF00FF00FF00FF00FF00FF00FF0093939300FFFFFF00B7B7B700FFFFFF00B7B7
          B700FFFFFF00B7B7B700E0E0E0007F7F7F00FF00FF00FF00FF00FF00FF00FF00
          FF00B17E4800E3947600DC8B6A00D6825E00D07A5300CB724900C66B3F00C66B
          3F0097673600FF00FF00FF00FF00FF00FF00FF00FF0096969600B1B1B100A9A9
          A900A1A1A10099999900929292008B8B8B008B8B8B0082828200FF00FF00FF00
          FF00FF00FF00FF00FF00B4814A00FFF9F900FFF3F300FFEDED00FFE7E700FFDC
          DC00FFD0D000FFD0D0009A6A3900FF00FF00FF00FF00FF00FF00FF00FF009999
          9900FBFBFB00F8F8F800F4F4F400F0F0F000E9E9E900E2E2E200E2E2E2008585
          8500FF00FF00FF00FF00FF00FF00FF00FF00B9854E00FFFFFF00FFF9F900FFF3
          F300FFEDED00FFE7E700FFDCDC00FFDCDC009F6E3C00FF00FF00FF00FF00FF00
          FF00FF00FF009C9C9C00FFFFFF00FBFBFB00F8F8F800F4F4F400F0F0F000E9E9
          E900E9E9E90089898900FF00FF00FF00FF00FF00FF00FF00FF00BC875000B985
          4E00B4814A00B17E4800AE7B4600AB794400A8764200A5734000A2713E00FF00
          FF00FF00FF00FF00FF00FF00FF009E9E9E009C9C9C0099999900969696009393
          9300929292008F8F8F008D8D8D008B8B8B00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00}
        TabOrder = 16
      end
    end
    object cxTableEstorna: TcxTabSheet
      Caption = 'Estorna'
      ImageIndex = 1
      inline frmPeriodo1: TfrmPeriodo
        Left = 3
        Top = 16
        Width = 254
        Height = 65
        TabOrder = 0
        ExplicitLeft = 3
        ExplicitTop = 16
        ExplicitWidth = 254
        ExplicitHeight = 65
        inherited lbl1: TLabel
          Top = 7
          ExplicitTop = 7
        end
        inherited lbl2: TLabel
          Top = 7
          ExplicitTop = 7
        end
        inherited dtpDataInicial: TDateTimePicker
          Top = 32
          ExplicitTop = 32
        end
        inherited dtpDataFinal: TDateTimePicker
          Top = 32
          ExplicitTop = 32
        end
      end
      object cxLabel4: TcxLabel
        Left = 512
        Top = 21
        Caption = 'Selecione uma transfer'#234'ncia'
      end
      object btnBuscaTRF: TBitBtn
        Left = 276
        Top = 46
        Width = 153
        Height = 26
        Caption = 'Buscar'
        TabOrder = 2
        OnClick = btnBuscaTRFClick
      end
      object cbbTransferencias: TComboBox
        Left = 512
        Top = 46
        Width = 241
        Height = 21
        TabOrder = 3
        Text = 'cbbTransferencias'
        OnChange = cbbTransferenciasChange
      end
      object edtContaOrigem: TcxTextEdit
        Left = 22
        Top = 139
        Enabled = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Style.BorderStyle = ebsFlat
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 4
        Width = 407
      end
      object cxLabel7: TcxLabel
        Left = 512
        Top = 116
        Caption = 'Valor da transfer'#234'ncia'
      end
      object cxLabel8: TcxLabel
        Left = 22
        Top = 116
        Caption = 'Conta banc'#225'ria de origem'
      end
      object edtContaDestino: TcxTextEdit
        Left = 22
        Top = 211
        Enabled = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Style.BorderStyle = ebsFlat
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 7
        Width = 407
      end
      object cxLabel11: TcxLabel
        Left = 22
        Top = 180
        Caption = 'Conta banc'#225'ria de  destino'
      end
      object edtValorTransf: TEvNumEdit
        Left = 512
        Top = 139
        Width = 241
        Height = 21
        Glyph.Data = {
          7E050000424D7E0500000000000036000000280000001A0000000D0000000100
          2000000000004805000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF009A6A39009767360093643400906131008C5E2F00895B
          2C0085582A00825527007F522500FF00FF00FF00FF00FF00FF00FF00FF008585
          8500828282007F7F7F007D7D7D007A7A7A007777770075757500727272006F6F
          6F00FF00FF00FF00FF00FF00FF00FF00FF009F6E3C00E3947600DC8B6A00D682
          5E00D07A5300CB724900C66B3F00C66B3F0082552700FF00FF00FF00FF00FF00
          FF00FF00FF0089898900B1B1B100A9A9A900A1A1A10099999900929292008B8B
          8B008B8B8B0072727200FF00FF00FF00FF00FF00FF00FF00FF00A2713E00FFFF
          FF00D0A08000FFFFFF00D0A08000FFFFFF00D0A08000E9D7C30085582A00FF00
          FF00FF00FF00FF00FF00FF00FF008B8B8B00FFFFFF00B7B7B700FFFFFF00B7B7
          B700FFFFFF00B7B7B700E0E0E00075757500FF00FF00FF00FF00FF00FF00FF00
          FF00A5734000E3947600DC8B6A00D6825E00D07A5300CB724900C66B3F00C66B
          3F00895B2C00FF00FF00FF00FF00FF00FF00FF00FF008D8D8D00B1B1B100A9A9
          A900A1A1A10099999900929292008B8B8B008B8B8B0077777700FF00FF00FF00
          FF00FF00FF00FF00FF00A8764200FFFFFF00D0A08000FFFFFF00D0A08000FFFF
          FF00D0A08000E9D7C3008C5E2F00FF00FF00FF00FF00FF00FF00FF00FF008F8F
          8F00FFFFFF00B7B7B700FFFFFF00B7B7B700FFFFFF00B7B7B700E0E0E0007A7A
          7A00FF00FF00FF00FF00FF00FF00FF00FF00AB794400E3947600DC8B6A00D682
          5E00D07A5300CB724900C66B3F00C66B3F0090613100FF00FF00FF00FF00FF00
          FF00FF00FF0092929200B1B1B100A9A9A900A1A1A10099999900929292008B8B
          8B008B8B8B007D7D7D00FF00FF00FF00FF00FF00FF00FF00FF00AE7B4600FFFF
          FF00D0A08000FFFFFF00D0A08000FFFFFF00D0A08000E9D7C30093643400FF00
          FF00FF00FF00FF00FF00FF00FF0093939300FFFFFF00B7B7B700FFFFFF00B7B7
          B700FFFFFF00B7B7B700E0E0E0007F7F7F00FF00FF00FF00FF00FF00FF00FF00
          FF00B17E4800E3947600DC8B6A00D6825E00D07A5300CB724900C66B3F00C66B
          3F0097673600FF00FF00FF00FF00FF00FF00FF00FF0096969600B1B1B100A9A9
          A900A1A1A10099999900929292008B8B8B008B8B8B0082828200FF00FF00FF00
          FF00FF00FF00FF00FF00B4814A00FFF9F900FFF3F300FFEDED00FFE7E700FFDC
          DC00FFD0D000FFD0D0009A6A3900FF00FF00FF00FF00FF00FF00FF00FF009999
          9900FBFBFB00F8F8F800F4F4F400F0F0F000E9E9E900E2E2E200E2E2E2008585
          8500FF00FF00FF00FF00FF00FF00FF00FF00B9854E00FFFFFF00FFF9F900FFF3
          F300FFEDED00FFE7E700FFDCDC00FFDCDC009F6E3C00FF00FF00FF00FF00FF00
          FF00FF00FF009C9C9C00FFFFFF00FBFBFB00F8F8F800F4F4F400F0F0F000E9E9
          E900E9E9E90089898900FF00FF00FF00FF00FF00FF00FF00FF00BC875000B985
          4E00B4814A00B17E4800AE7B4600AB794400A8764200A5734000A2713E00FF00
          FF00FF00FF00FF00FF00FF00FF009E9E9E009C9C9C0099999900969696009393
          9300929292008F8F8F008D8D8D008B8B8B00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00}
        TabOrder = 9
      end
    end
  end
  object dxStatusTRF: TdxStatusBar
    Left = 0
    Top = 436
    Width = 884
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.Alignment = taCenter
        Width = 89
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 600
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
    Width = 884
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 1
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Transfer'#234'ncias'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar4'
        end
        item
          ToolbarName = 'dxBarManager1Bar5'
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
    Left = 608
    Top = 64
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Transfere'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 727
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnTransfere'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Limpar'
      CaptionButtons = <>
      DockedLeft = 215
      DockedTop = 0
      FloatLeft = 727
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton2'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Cancelar'
      CaptionButtons = <>
      DockedLeft = 277
      DockedTop = 0
      FloatLeft = 727
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton3'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'Estornar'
      CaptionButtons = <>
      DockedLeft = 75
      DockedTop = 0
      FloatLeft = 918
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnEstorno'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar5: TdxBar
      Caption = 'Relat'#243'rio'
      CaptionButtons = <>
      DockedLeft = 143
      DockedTop = 0
      FloatLeft = 918
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnRelTRF'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarLargeButton1: TdxBarLargeButton
      Caption = 'Transferir'
      Category = 0
      Hint = 'Transferir'
      Visible = ivAlways
    end
    object dxBtnTransfere: TdxBarLargeButton
      Caption = 'Transferir'
      Category = 0
      Hint = 'Transferir'
      Visible = ivAlways
      OnClick = dxBtnTransfereClick
    end
    object dxBarLargeButton2: TdxBarLargeButton
      Caption = 'Limpar'
      Category = 0
      Hint = 'Limpar'
      Visible = ivAlways
      OnClick = dxBarLargeButton2Click
    end
    object dxBarLargeButton3: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBarLargeButton3Click
    end
    object cbbIdentificador: TcxBarEditItem
      Caption = 'Identificador'
      Category = 0
      Hint = 'Identificador'
      Visible = ivAlways
      Width = 150
      PropertiesClassName = 'TcxComboBoxProperties'
      Properties.Items.Strings = (
        'Ranan'
        'Aidil'
        'Show'
        'Detalhe'
        'Normal')
      Properties.PopupAlignment = taCenter
    end
    object dxBtnEstorno: TdxBarLargeButton
      Caption = 'Estornar'
      Category = 0
      Hint = 'Estornar'
      Visible = ivAlways
      OnClick = dxBtnEstornoClick
    end
    object dxBtnRelTRF: TdxBarLargeButton
      Caption = 'Relat'#243'rio'
      Category = 0
      Hint = 'Listagem de transfer'#234'ncias realizadas'
      Visible = ivAlways
      OnClick = dxBtnRelTRFClick
    end
  end
end
