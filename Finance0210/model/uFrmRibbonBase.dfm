object frmRibbonBase: TfrmRibbonBase
  Left = 0
  Top = 0
  Caption = 'Detalhes'
  ClientHeight = 556
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 784
    Height = 126
    BarManager = dxBarManager1
    ColorSchemeName = 'Blue'
    Contexts = <>
    TabOrder = 0
    TabStop = False
    ExplicitWidth = 635
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Principal'
      Groups = <>
      Index = 0
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 536
    Width = 784
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
    ExplicitLeft = 272
    ExplicitTop = 248
    ExplicitWidth = 0
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
    Left = 184
    Top = 136
    PixelsPerInch = 96
  end
end
