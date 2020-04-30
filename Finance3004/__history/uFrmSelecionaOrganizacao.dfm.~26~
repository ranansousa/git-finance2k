object frmSelectOrganizacao: TfrmSelectOrganizacao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Selecionar Organiza'#231#227'o'
  ClientHeight = 246
  ClientWidth = 634
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
  object lblBoasVindas: TLabel
    Left = 48
    Top = 8
    Width = 88
    Height = 16
    Caption = 'lblBoasVindas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl1: TLabel
    Left = 48
    Top = 46
    Width = 211
    Height = 13
    Caption = 'Selecione uma organiza'#231#227'o para trabalhar.'#39';'
  end
  object lblSistemaContabil: TLabel
    Left = 51
    Top = 168
    Width = 123
    Height = 13
    Caption = 'Informa'#231#245'es importantes '
  end
  inline frameOrg1: TframeOrg
    Left = 32
    Top = 65
    Width = 339
    Height = 81
    TabOrder = 0
    ExplicitLeft = 32
    ExplicitTop = 65
    inherited lbl1: TLabel
      Width = 65
      Height = 13
      ExplicitWidth = 65
      ExplicitHeight = 13
    end
    inherited cbbOrg: TComboBox
      Height = 21
      ExplicitHeight = 21
    end
  end
  object btnSelecOrg: TButton
    Left = 408
    Top = 98
    Width = 105
    Height = 25
    Caption = 'Selecionar'
    TabOrder = 1
    OnClick = btnSelecOrgClick
  end
  object qryPreencheCombo: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT  O.razao_social, '
      '        O.id_organizacao'
      'FROM ORGANIZACAO O     '
      'WHERE 1=1 '
      'ORDER BY  O.data_atualizacao desc ;')
    Left = 496
    Top = 150
  end
  object qryDadosEmpresaMega: TFDQuery
    Connection = dmConexao.ConnMega
    SQL.Strings = (
      'SELECT'
      '  *'
      ''
      'FROM'
      '  CADASTRO C'
      ''
      'WHERE'
      '  (C.INSCMF = :pCnpj)')
    Left = 528
    Top = 24
    ParamData = <
      item
        Name = 'PCNPJ'
        DataType = ftString
        ParamType = ptInput
      end>
  end
end
