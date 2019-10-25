object frmDeletaLoteContabil: TfrmDeletaLoteContabil
  Left = 0
  Top = 0
  Caption = 'Deleta Lote Contabil'
  ClientHeight = 399
  ClientWidth = 806
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
  object lbl1: TLabel
    Left = 226
    Top = 21
    Width = 120
    Height = 13
    Caption = 'Selecione o Lote Cont'#225'bil'
  end
  object lbl2: TLabel
    Left = 162
    Top = 104
    Width = 42
    Height = 13
    Caption = 'ID LOTE '
  end
  object lbl3: TLabel
    Left = 123
    Top = 148
    Width = 81
    Height = 13
    Caption = 'DATA REGISTRO'
  end
  object lbl4: TLabel
    Left = 109
    Top = 195
    Width = 95
    Height = 13
    Caption = 'TIPO LAN'#199'AMENTO'
  end
  object lbl5: TLabel
    Left = 131
    Top = 236
    Width = 73
    Height = 13
    Caption = 'VALOR D'#201'BITO'
  end
  object lbl6: TLabel
    Left = 123
    Top = 276
    Width = 81
    Height = 13
    Caption = 'VALOR CR'#201'DITO'
  end
  object lbl7: TLabel
    Left = 16
    Top = 19
    Width = 75
    Height = 13
    Caption = 'Selecione o ano'
  end
  object cbbLoteContabil: TComboBox
    Left = 226
    Top = 40
    Width = 180
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12582911
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnSelect = cbbLoteContabilSelect
  end
  object btnLimpar: TButton
    Left = 568
    Top = 101
    Width = 121
    Height = 25
    Caption = 'Limpar'
    TabOrder = 1
    OnClick = btnLimparClick
  end
  object edtIdLote: TEdit
    Left = 226
    Top = 101
    Width = 230
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 2
  end
  object edtDataRegistro: TEdit
    Left = 226
    Top = 148
    Width = 230
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 3
  end
  object medtValorDB: TMaskEdit
    Left = 226
    Top = 236
    Width = 230
    Height = 21
    Alignment = taRightJustify
    Color = clMoneyGreen
    Enabled = False
    TabOrder = 4
    Text = ''
  end
  object edtTabela: TEdit
    Left = 226
    Top = 192
    Width = 230
    Height = 21
    Alignment = taCenter
    Enabled = False
    TabOrder = 5
  end
  object medtValorCR: TMaskEdit
    Left = 226
    Top = 273
    Width = 230
    Height = 21
    Alignment = taRightJustify
    Color = 13619199
    Enabled = False
    TabOrder = 6
    Text = ''
  end
  object btnDeletarLote: TButton
    Left = 568
    Top = 273
    Width = 121
    Height = 25
    Caption = 'Deletar'
    TabOrder = 7
    OnClick = btnDeletarLoteClick
  end
  object cbbAno: TComboBox
    Left = 16
    Top = 40
    Width = 113
    Height = 21
    TabOrder = 8
    Text = '>>Selecione <<'
    OnChange = cbbAnoChange
    Items.Strings = (
      '2019'
      '2018'
      '2017'
      '2016'
      '2015'
      '2014')
  end
  object qryObterLoteID: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    SQL.Strings = (
      ''
      'SELECT  LC.ID_LOTE_CONTABIL,'
      '        LC.ID_ORGANIZACAO,'
      '        LC.LOTE,'
      '        LC.STATUS,'
      '        LC.DATA_REGISTRO,'
      '        LC.DATA_ATUALIZACAO,'
      '        LC.PERIODO_INICIAL,'
      '        LC.PERIODO_FINAL,'
      '        LC.TIPO_TABLE, '
      '        LC.VALOR_CR, '
      '        LC.VALOR_DB,'
      '        LC.QTD_REGISTROS'
      ''
      ''
      ' FROM LOTE_CONTABIL LC'
      ''
      'WHERE (LC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (LC.ID_LOTE_CONTABIL = :PIDLOTE)'
      '      ')
    Left = 608
    Top = 16
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDLOTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryGeneric: TFDQuery
    Connection = dmConexao.conn
    Left = 720
    Top = 200
  end
  object qryAlteraGeneric: TFDQuery
    Connection = dmConexao.conn
    Left = 720
    Top = 128
  end
  object qryAlteraLote: TFDQuery
    Connection = dmConexao.conn
    Left = 728
    Top = 16
  end
  object qryObterTPPROV: TFDQuery
    Connection = dmConexao.conn
    Left = 672
    Top = 344
  end
  object qryDeletaLote: TFDQuery
    Connection = dmConexao.conn
    Left = 432
    Top = 328
  end
end