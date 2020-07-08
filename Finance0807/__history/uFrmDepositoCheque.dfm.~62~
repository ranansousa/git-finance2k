object frmDepositoCheque: TfrmDepositoCheque
  Left = 0
  Top = 0
  Caption = 'Dep'#243'sito em cheque da tesouraria para  o banco'
  ClientHeight = 630
  ClientWidth = 1110
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
    Left = 733
    Top = 175
    Width = 102
    Height = 13
    Caption = 'Conta cont'#225'bil d'#233'bito'
  end
  object lbl8: TLabel
    Left = 772
    Top = 290
    Width = 82
    Height = 13
    Caption = 'Data do dep'#243'sito'
  end
  object lbl2: TLabel
    Left = 868
    Top = 175
    Width = 131
    Height = 13
    Caption = 'Descri'#231#227'o da conta cont'#225'bil'
  end
  object lbl3: TLabel
    Left = 868
    Top = 227
    Width = 112
    Height = 13
    Caption = 'Tipo opera'#231#227'o banc'#225'ria'
  end
  object lbl4: TLabel
    Left = 733
    Top = 228
    Width = 105
    Height = 13
    Caption = 'Conta cont'#225'bil cr'#233'dito'
  end
  object EvLabel3D1: TEvLabel3D
    Left = 495
    Top = 140
    Width = 278
    Height = 15
    AutoSize = False
    Caption = 'Dep'#243'sito em cheques da tesouraria para o banco'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Transparent = True
  end
  inline frmContaBancaria1: TfrmContaBancaria
    Left = 479
    Top = 176
    Width = 226
    Height = 114
    TabOrder = 0
    ExplicitLeft = 479
    ExplicitTop = 176
    ExplicitWidth = 226
    ExplicitHeight = 114
    inherited cbbConta: TComboBox
      OnChange = frmContaBancaria1cbbContaChange
    end
  end
  object gridMain: TStringGrid
    Left = 0
    Top = 128
    Width = 465
    Height = 398
    Cursor = crSQLWait
    ColCount = 7
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSelect]
    TabOrder = 1
    OnDrawCell = gridMainDrawCell
    OnSelectCell = gridMainSelectCell
    ColWidths = (
      64
      64
      64
      64
      64
      64
      64)
    RowHeights = (
      24
      24
      24
      24
      24)
  end
  object edtContaContabil: TEdit
    Left = 733
    Top = 195
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 2
  end
  object dtpDeposito: TDateTimePicker
    Left = 868
    Top = 284
    Width = 200
    Height = 25
    Date = 43754.999055312510000000
    Time = 43754.999055312510000000
    MaxDate = 46022.999988425930000000
    MinDate = 41640.000000000000000000
    TabOrder = 3
  end
  object edtDescricaoCC: TEdit
    Left = 868
    Top = 195
    Width = 200
    Height = 21
    Enabled = False
    TabOrder = 4
  end
  object edtTOB: TEdit
    Left = 868
    Top = 247
    Width = 200
    Height = 21
    Enabled = False
    TabOrder = 5
  end
  object edtCTACCDB: TEdit
    Left = 733
    Top = 247
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 6
  end
  inline frameResponsavel1: TframeResponsavel
    Left = 733
    Top = 336
    Width = 348
    Height = 49
    TabOrder = 7
    ExplicitLeft = 733
    ExplicitTop = 336
    ExplicitWidth = 348
    ExplicitHeight = 49
    inherited lblID: TLabel
      Left = 67
      Top = 38
      ExplicitLeft = 67
      ExplicitTop = 38
    end
    inherited cbbcombo: TComboBox
      Top = 24
      Width = 334
      OnChange = frameResponsavel1cbbcomboChange
      ExplicitTop = 24
      ExplicitWidth = 334
    end
    inherited qryObterPorID: TFDQuery
      Top = 32
    end
    inherited qryObterTodos: TFDQuery
      Top = 24
    end
  end
  object dxStatusTRF: TdxStatusBar
    Left = 0
    Top = 610
    Width = 1110
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 90
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 600
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 1110
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 9
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Dep'#243'sito de cheques'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar2'
        end>
      Index = 0
    end
  end
  object qryObterCheques: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ''
      'SELECT TRC.ID_TITULO_RECEBER_BAIXA_CHEQUE AS ID,'
      '       TRC.ID_ORGANIZACAO,'
      '       TRC.ID_TITULO_RECEBER_BAIXA,'
      '       TR.numero_documento AS DOCTR,'
      '       TR.data_pagamento,'
      '       TRC.ID_BANCO,'
      '       B.NOME_BANCO AS banco,'
      '       TRC.ID_LOTE_DEPOSITO,'
      '       TRC.ID_TIPO_STATUS,'
      '       TRC.DATA_PROTOCOLO,'
      '       TRC.VALOR,'
      '       TRC.NUMERO_CHEQUE AS CHEQUE,'
      '       TRC.TITULAR,'
      '       TRC.DATA_DEPOSITO'
      ''
      ''
      'FROM  TITULO_RECEBER_BAIXA_CHEQUE TRC'
      'LEFT OUTER JOIN BANCO B ON (B.ID_BANCO = TRC.ID_BANCO)'
      
        'LEFT OUTER JOIN TITULO_RECEBER_BAIXA TRB ON (TRB.ID_TITULO_RECEB' +
        'ER_BAIXA = TRC.ID_TITULO_RECEBER_BAIXA) AND (TRC.ID_ORGANIZACAO ' +
        '= TRC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN titulo_receber TR ON (TR.ID_TITULO_RECEBER = TRB' +
        '.ID_TITULO_RECEBER) AND (TR.ID_ORGANIZACAO = TRC.ID_ORGANIZACAO)'
      ''
      ''
      'WHERE (TRC.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      'AND   (TRC.ID_TIPO_STATUS IS NULL )'
      'AND   (TRC.ID_LOTE_DEPOSITO IS NULL)'
      ''
      'ORDER BY TRC.VALOR DESC')
    Left = 31
    Top = 544
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterTOB: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TOB.id_tipo_operacao_bancaria,'
      '       tob.id_organizacao,'
      '       tob.descricao,'
      '       tob.tipo,'
      '       tob.codigo,'
      '       tob.id_conta_contabil,'
      '       CC.conta,'
      '       CC.codreduz'
      'FROM tipo_operacao_bancaria TOB'
      
        'LEFT OUTER JOIN conta_contabil CC ON (CC.id_conta_contabil = TOB' +
        '.id_conta_contabil) AND (CC.id_organizacao = TOB.id_organizacao)'
      'WHERE (TOB.id_organizacao = :PIDORGANIZACAO)'
      'AND   (TOB.id_tipo_operacao_bancaria = :PIDTOB)'
      '')
    Left = 231
    Top = 544
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTOB'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterContaBancaria: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT CB.ID_CONTA_BANCARIA,'
      '       CB.ID_ORGANIZACAO,'
      '       CB.ID_CONTA_CONTABIL, '
      '       CB.ID_BANCO, B.CODIGO_BANCO,'
      '       CB.CONTA,'
      '       CB.AGENCIA,'
      '       CB.TITULAR'
      ''
      'FROM CONTA_BANCARIA CB'
      'LEFT OUTER JOIN BANCO B ON (B.ID_BANCO = CB.ID_BANCO)'
      
        'WHERE (CB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (CB.ID_CONTA_BAN' +
        'CARIA = :PIDCONTA)')
    Left = 127
    Top = 544
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
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
    Left = 592
    Top = 456
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Dep'#243'sito'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1144
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnConfirmar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Sair'
      CaptionButtons = <>
      DockedLeft = 79
      DockedTop = 0
      FloatLeft = 1144
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton2'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBtnConfirmar: TdxBarLargeButton
      Caption = 'Confirmar'
      Category = 0
      Hint = 'Confirmar'
      Visible = ivAlways
      OnClick = dxBtnConfirmarClick
    end
    object dxBarLargeButton2: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBarLargeButton2Click
    end
  end
end
