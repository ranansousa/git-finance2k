object frmImobilizado: TfrmImobilizado
  Left = 0
  Top = 0
  Caption = 'frmImobilizado'
  ClientHeight = 724
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 24
    Top = 181
    Width = 29
    Height = 13
    Caption = 'Grupo'
  end
  object lbl2: TLabel
    Left = 232
    Top = 181
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object lbl3: TLabel
    Left = 376
    Top = 181
    Width = 70
    Height = 13
    Caption = 'Data aquisi'#231#227'o'
  end
  object lbl4: TLabel
    Left = 527
    Top = 181
    Width = 86
    Height = 13
    Caption = 'Valor de aquisi'#231#227'o'
  end
  object lbl5: TLabel
    Left = 24
    Top = 237
    Width = 84
    Height = 13
    Caption = 'Descri'#231#227'o do bem'
  end
  object lbl6: TLabel
    Left = 529
    Top = 244
    Width = 20
    Height = 13
    Caption = 'Tipo'
  end
  object lbl7: TLabel
    Left = 688
    Top = 181
    Width = 40
    Height = 13
    Caption = 'Parcelas'
  end
  object lbl8: TLabel
    Left = 24
    Top = 302
    Width = 96
    Height = 13
    Caption = 'Hist'#243'rico patrimonial'
  end
  object lbl9: TLabel
    Left = 167
    Top = 573
    Width = 84
    Height = 13
    Caption = 'Hist'#243'rico despesa'
  end
  object lbl10: TLabel
    Left = 527
    Top = 302
    Width = 67
    Height = 13
    Caption = 'C'#243'd. reduzido'
  end
  object lbl11: TLabel
    Left = 632
    Top = 302
    Width = 69
    Height = 13
    Caption = 'Conta cont'#225'bil'
  end
  object lbl12: TLabel
    Left = 376
    Top = 302
    Width = 70
    Height = 13
    Caption = 'C'#243'digo padr'#227'o'
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 1008
    Height = 126
    BarManager = dxBarManager1
    ColorSchemeName = 'Blue'
    Contexts = <>
    TabOrder = 1
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'dxRibbon1Tab1'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end>
      Index = 0
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 704
    Width = 1008
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
  object cbbGrupo: TComboBox
    Left = 24
    Top = 203
    Width = 185
    Height = 21
    TabOrder = 0
  end
  object edtCodigo: TEdit
    Left = 232
    Top = 203
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 4
  end
  object dtpAquisicao: TDateTimePicker
    Left = 376
    Top = 203
    Width = 129
    Height = 21
    Date = 43816.000000000000000000
    Time = 0.793663715281582000
    TabOrder = 6
  end
  object edtValorAquisicao: TEvNumEdit
    Left = 527
    Top = 203
    Width = 145
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
    TabOrder = 8
  end
  object edtDescricao: TEdit
    Left = 24
    Top = 263
    Width = 481
    Height = 21
    TabOrder = 10
  end
  object cbbTipo: TComboBox
    Left = 527
    Top = 263
    Width = 145
    Height = 21
    TabOrder = 3
  end
  object edtParcelas: TEdit
    Left = 688
    Top = 203
    Width = 57
    Height = 21
    NumbersOnly = True
    TabOrder = 5
  end
  inline frmHistoricoPatrimonial: TframeHistorico
    Left = 24
    Top = 325
    Width = 337
    Height = 78
    TabOrder = 7
    ExplicitLeft = 24
    ExplicitTop = 325
    ExplicitWidth = 337
    ExplicitHeight = 78
    inherited lblID: TLabel
      Left = 164
      Top = 30
      ExplicitLeft = 164
      ExplicitTop = 30
    end
    inherited cbbcombo: TComboBox
      Width = 329
      OnChange = frmHistoricoPatrimonialcbbcomboChange
      ExplicitWidth = 329
    end
    inherited qryObterPorID: TFDQuery
      Left = 16
    end
    inherited qryObterTodos: TFDQuery
      Left = 72
    end
    inherited qryObterContaContabil: TFDQuery
      Left = 120
      Top = 16
    end
  end
  inline frmHistoricoDespesa: TframeHistorico
    Left = 167
    Top = 589
    Width = 299
    Height = 78
    TabOrder = 9
    ExplicitLeft = 167
    ExplicitTop = 589
    ExplicitWidth = 299
    ExplicitHeight = 78
    inherited lblID: TLabel
      Left = 143
      Top = 30
      ExplicitLeft = 143
      ExplicitTop = 30
    end
    inherited cbbcombo: TComboBox
      Width = 296
      ExplicitWidth = 296
    end
    inherited qryObterPorID: TFDQuery
      Left = 16
    end
    inherited qryObterTodos: TFDQuery
      Left = 88
    end
    inherited qryObterContaContabil: TFDQuery
      Left = 168
      Top = 16
    end
  end
  object edtCODREDUZ: TEdit
    Left = 527
    Top = 328
    Width = 67
    Height = 21
    Alignment = taCenter
    Color = clMoneyGreen
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
  end
  object edtContaContabil: TEdit
    Left = 632
    Top = 328
    Width = 113
    Height = 21
    Alignment = taRightJustify
    Color = clMoneyGreen
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
  end
  object edtCodHistPadrao: TEdit
    Left = 376
    Top = 328
    Width = 113
    Height = 21
    Alignment = taRightJustify
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
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
    Left = 832
    Top = 72
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Cadastrar'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1042
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarLargeButton1: TdxBarLargeButton
      Caption = 'Novo'
      Category = 0
      Hint = 'Novo'
      Visible = ivAlways
      OnClick = dxBarLargeButton1Click
    end
  end
  object qry1: TFDQuery
    Left = 872
    Top = 136
  end
end
