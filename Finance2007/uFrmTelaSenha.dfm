object frmTelaSenha: TfrmTelaSenha
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsToolWindow
  BorderWidth = 2
  Caption = 'Autoriza'#231#227'o'
  ClientHeight = 148
  ClientWidth = 590
  Color = 14215400
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
  object lblUser: TLabel
    Left = 5
    Top = 15
    Width = 94
    Height = 13
    Caption = 'Nome do usu'#225'rio(a)'
  end
  object Label1: TLabel
    Left = 213
    Top = 15
    Width = 60
    Height = 13
    Caption = 'Super senha'
  end
  object edtPassword: TEdit
    Left = 213
    Top = 36
    Width = 145
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  object btnConfirma: TBitBtn
    Left = 369
    Top = 34
    Width = 97
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
    OnClick = btnConfirmaClick
  end
  object edtUsuario: TEdit
    Left = 5
    Top = 36
    Width = 193
    Height = 21
    Enabled = False
    TabOrder = 3
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 128
    Width = 590
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
    ExplicitTop = 120
    ExplicitWidth = 582
  end
  object btnFechar: TBitBtn
    Left = 475
    Top = 34
    Width = 97
    Height = 25
    Caption = 'Fechar'
    TabOrder = 2
    OnClick = btnFecharClick
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
    Left = 376
    Top = 61
  end
end
