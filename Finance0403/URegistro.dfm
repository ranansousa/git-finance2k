object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Pempec Enterprise Registro'
  ClientHeight = 476
  ClientWidth = 815
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 176
    Top = 32
    Width = 223
    Height = 29
    Caption = 'Registro de Sistemas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clTeal
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label15: TLabel
    Left = 112
    Top = 800
    Width = 56
    Height = 13
    Caption = 'ID_BAIRRO'
    FocusControl = DBEdit14
  end
  object Label16: TLabel
    Left = 112
    Top = 840
    Width = 61
    Height = 13
    Caption = 'IPSERVERBD'
    FocusControl = DBEdit15
  end
  object Label17: TLabel
    Left = 112
    Top = 880
    Width = 79
    Height = 13
    Caption = 'NAMESERVERBD'
    FocusControl = DBEdit16
  end
  object Label18: TLabel
    Left = 112
    Top = 920
    Width = 99
    Height = 13
    Caption = 'SISTEMA_CONTABIL'
    FocusControl = DBEdit17
  end
  object Label19: TLabel
    Left = 112
    Top = 960
    Width = 55
    Height = 13
    Caption = 'SERIAL_HD'
    FocusControl = DBEdit18
  end
  object Label20: TLabel
    Left = 112
    Top = 1000
    Width = 82
    Height = 13
    Caption = 'SERIAL_CLIENTE'
    FocusControl = DBEdit19
  end
  object Label21: TLabel
    Left = 112
    Top = 1040
    Width = 43
    Height = 13
    Caption = 'LICENCA'
    FocusControl = DBEdit20
  end
  object Label22: TLabel
    Left = 112
    Top = 1080
    Width = 67
    Height = 13
    Caption = 'SOCKET_WEB'
    FocusControl = DBEdit21
  end
  object Label23: TLabel
    Left = 112
    Top = 1120
    Width = 69
    Height = 13
    Caption = 'CODIGO_WEB'
    FocusControl = DBEdit22
  end
  object Label24: TLabel
    Left = 112
    Top = 1160
    Width = 55
    Height = 13
    Caption = 'CODINOME'
    FocusControl = DBEdit23
  end
  object Label25: TLabel
    Left = 112
    Top = 1200
    Width = 61
    Height = 13
    Caption = 'HOST_NAME'
    FocusControl = DBEdit24
  end
  object Label26: TLabel
    Left = 112
    Top = 1240
    Width = 43
    Height = 13
    Caption = 'HOST_IP'
    FocusControl = DBEdit25
  end
  object Label27: TLabel
    Left = 112
    Top = 1280
    Width = 40
    Height = 13
    Caption = 'VERSAO'
    FocusControl = DBEdit26
  end
  object Label28: TLabel
    Left = 112
    Top = 1320
    Width = 104
    Height = 13
    Caption = 'DATA_ATUALIZACAO'
    FocusControl = DBEdit27
  end
  object DBEdit14: TDBEdit
    Left = 112
    Top = 816
    Width = 472
    Height = 21
    DataField = 'ID_BAIRRO'
    TabOrder = 0
  end
  object DBEdit15: TDBEdit
    Left = 112
    Top = 856
    Width = 784
    Height = 21
    DataField = 'IPSERVERBD'
    TabOrder = 1
  end
  object DBEdit16: TDBEdit
    Left = 112
    Top = 896
    Width = 784
    Height = 21
    DataField = 'NAMESERVERBD'
    TabOrder = 2
  end
  object DBEdit17: TDBEdit
    Left = 112
    Top = 936
    Width = 784
    Height = 21
    DataField = 'SISTEMA_CONTABIL'
    TabOrder = 3
  end
  object DBEdit18: TDBEdit
    Left = 112
    Top = 976
    Width = 784
    Height = 21
    DataField = 'SERIAL_HD'
    TabOrder = 4
  end
  object DBEdit19: TDBEdit
    Left = 112
    Top = 1016
    Width = 784
    Height = 21
    DataField = 'SERIAL_CLIENTE'
    TabOrder = 5
  end
  object DBEdit20: TDBEdit
    Left = 112
    Top = 1056
    Width = 784
    Height = 21
    DataField = 'LICENCA'
    TabOrder = 6
  end
  object DBEdit21: TDBEdit
    Left = 112
    Top = 1096
    Width = 784
    Height = 21
    DataField = 'SOCKET_WEB'
    TabOrder = 7
  end
  object DBEdit22: TDBEdit
    Left = 112
    Top = 1136
    Width = 784
    Height = 21
    DataField = 'CODIGO_WEB'
    TabOrder = 8
  end
  object DBEdit23: TDBEdit
    Left = 112
    Top = 1176
    Width = 784
    Height = 21
    DataField = 'CODINOME'
    TabOrder = 9
  end
  object DBEdit24: TDBEdit
    Left = 112
    Top = 1216
    Width = 784
    Height = 21
    DataField = 'HOST_NAME'
    TabOrder = 10
  end
  object DBEdit25: TDBEdit
    Left = 112
    Top = 1256
    Width = 784
    Height = 21
    DataField = 'HOST_IP'
    TabOrder = 11
  end
  object DBEdit26: TDBEdit
    Left = 112
    Top = 1296
    Width = 394
    Height = 21
    DataField = 'VERSAO'
    TabOrder = 12
  end
  object DBEdit27: TDBEdit
    Left = 112
    Top = 1336
    Width = 134
    Height = 21
    DataField = 'DATA_ATUALIZACAO'
    TabOrder = 13
  end
  object MainMenu1: TMainMenu
    Left = 720
    Top = 64
    object Pesquisar1: TMenuItem
      Caption = 'Pesquisar'
      object Finance1: TMenuItem
        Caption = 'Finance'
        OnClick = Finance1Click
      end
    end
    object Config1: TMenuItem
      Caption = 'Config'
      object BasedeDados1: TMenuItem
        Caption = 'Base de Dados'
        OnClick = BasedeDados1Click
      end
    end
  end
end
