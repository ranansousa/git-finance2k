object frmMostraProcesso: TfrmMostraProcesso
  Left = 0
  Top = 0
  Caption = 'Solicita'#231#227'o sendo processada...'
  ClientHeight = 70
  ClientWidth = 1063
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 144
  TextHeight = 19
  inline framePB1: TframePB
    Left = 0
    Top = 0
    Width = 1063
    Height = 70
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 1063
    ExplicitHeight = 70
    inherited lblProgressBar: TLabel
      Width = 70
      Height = 19
      Caption = 'Progresso'
      ExplicitWidth = 70
      ExplicitHeight = 19
    end
    inherited lbl3: TLabel
      Left = 972
      Top = 24
      Width = 43
      Height = 19
      ExplicitLeft = 972
      ExplicitTop = 24
      ExplicitWidth = 43
      ExplicitHeight = 19
    end
    inherited pb1: TProgressBar
      Top = 23
      Width = 958
      BarColor = clHotLight
      ExplicitTop = 23
      ExplicitWidth = 958
    end
  end
end
