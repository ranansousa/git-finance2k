object FMostraErros: TFMostraErros
  Left = 317
  Top = 127
  ActiveControl = BtnFechar
  Caption = 'Rela'#231#227'o de inconsist'#234'ncias'
  ClientHeight = 402
  ClientWidth = 807
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 383
    Width = 807
    Height = 19
    Panels = <>
  end
  object BtnImprimir: TBitBtn
    Left = 690
    Top = 347
    Width = 80
    Height = 25
    Caption = '&Imprimir'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
      8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
      8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
      8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
    TabOrder = 1
    OnClick = BtnImprimirClick
  end
  object BtnFechar: TBitBtn
    Left = 582
    Top = 347
    Width = 80
    Height = 25
    Caption = '&Fechar'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 0
    OnClick = BtnFecharClick
  end
  object RichEditErros: TRichEdit
    Left = 0
    Top = 0
    Width = 807
    Height = 331
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    Lines.Strings = (
      'RichEditErros')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 3
    Zoom = 100
  end
end
