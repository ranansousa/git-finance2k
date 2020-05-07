object frmInfoUpdate: TfrmInfoUpdate
  Left = 0
  Top = 0
  HorzScrollBar.Color = clBtnShadow
  HorzScrollBar.ParentColor = False
  BorderIcons = []
  Caption = 'Atualiza'#231#227'o necess'#225'ria'
  ClientHeight = 190
  ClientWidth = 372
  Color = clBtnFace
  TransparentColorValue = clSilver
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 372
    Height = 190
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 48
    ExplicitTop = 64
    ExplicitWidth = 425
    ExplicitHeight = 81
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 370
      Height = 188
      Align = alClient
      Lines.Strings = (
        'Pempec Enterprise Finance 2000 - Finance 2K'
        ''
        'Informamos que existe uma nova vers'#227'o dispon'#237'vel.'
        'Acesse o site www.pempec.com.br'
        'Clique no menu Download'
        'Baixe a vers'#227'o de instala'#231#227'o '
        'Execute o instalador'
        'Obs. Execute o arquivo de instala'#231#227'o como Administrador.'
        ''
        'Agradecemos pela prefer'#234'ncia.')
      TabOrder = 2
      ExplicitLeft = 16
      ExplicitTop = 32
      ExplicitWidth = 297
      ExplicitHeight = 89
    end
    object btnFechar: TBitBtn
      Left = 191
      Top = 164
      Width = 180
      Height = 25
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = btnFecharClick
    end
    object btnDown: TBitBtn
      Left = 5
      Top = 164
      Width = 180
      Height = 25
      Caption = 'Download'
      TabOrder = 0
      OnClick = btnFecharClick
    end
  end
end
