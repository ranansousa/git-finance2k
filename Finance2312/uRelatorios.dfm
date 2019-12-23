object FrmBackup: TFrmBackup
  Left = 549
  Top = 309
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Manuten'#231#227'o do Banco de Dados'
  ClientHeight = 389
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblAviso: TLabel
    Left = 0
    Top = 351
    Width = 633
    Height = 19
    Align = alBottom
    Caption = 'lblAviso'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    ExplicitWidth = 64
  end
  object Label1: TLabel
    Left = 8
    Top = 320
    Width = 146
    Height = 14
    Caption = 'Pempec Enterprise Backup'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMoneyGreen
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 633
    Height = 74
    Align = alTop
    TabOrder = 2
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 370
    Width = 633
    Height = 19
    Color = clMoneyGreen
    Panels = <
      item
        Text = 'Status : '
        Width = 50
      end
      item
        Width = 300
      end>
  end
  object PageControl1: TPageControl
    Left = -2
    Top = 80
    Width = 635
    Height = 225
    ActivePage = tbRelatorios
    Align = alCustom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object tbRelatorios: TTabSheet
      Caption = 'Contas a Pagar'
      ImageIndex = 5
      object btnRelContaPagar: TButton
        Left = 3
        Top = 24
        Width = 273
        Height = 25
        Caption = 'Relat'#243'rio Contas '#224'  Pagar'
        TabOrder = 0
        OnClick = btnRelContaPagarClick
      end
    end
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 248
    Top = 304
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 376
    Top = 304
  end
  object Conn: TFDConnection
    Params.Strings = (
      'Database=F:\Clientes\Imap\Finance\Dados\FINANCE.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 456
    Top = 16
  end
  object QueryTPS: TFDQuery
    Connection = Conn
    Left = 568
    Top = 24
  end
  object IdAntiFreeze1: TIdAntiFreeze
    IdleTimeOut = 1000
    Left = 480
    Top = 304
  end
end
