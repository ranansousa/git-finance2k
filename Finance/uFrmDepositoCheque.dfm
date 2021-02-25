object frmDepositoCheque: TfrmDepositoCheque
  Left = 0
  Top = 0
  Caption = 'Dep'#243'sito em cheque da tesouraria para  o banco'
  ClientHeight = 734
  ClientWidth = 1182
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
    Left = 774
    Top = 271
    Width = 102
    Height = 13
    Caption = 'Conta cont'#225'bil d'#233'bito'
  end
  object lbl8: TLabel
    Left = 813
    Top = 386
    Width = 82
    Height = 13
    Caption = 'Data do dep'#243'sito'
  end
  object lbl2: TLabel
    Left = 909
    Top = 271
    Width = 131
    Height = 13
    Caption = 'Descri'#231#227'o da conta cont'#225'bil'
  end
  object lbl3: TLabel
    Left = 909
    Top = 323
    Width = 112
    Height = 13
    Caption = 'Tipo opera'#231#227'o banc'#225'ria'
  end
  object lbl4: TLabel
    Left = 774
    Top = 324
    Width = 105
    Height = 13
    Caption = 'Conta cont'#225'bil cr'#233'dito'
  end
  inline frmContaBancaria1: TfrmContaBancaria
    Left = 760
    Top = 184
    Width = 261
    Height = 65
    TabOrder = 0
    ExplicitLeft = 760
    ExplicitTop = 184
    ExplicitWidth = 261
    ExplicitHeight = 65
    inherited lbl1: TLabel
      Left = 14
      Top = -3
      ExplicitLeft = 14
      ExplicitTop = -3
    end
    inherited cbbConta: TComboBox
      Left = 14
      Width = 202
      OnChange = frmContaBancaria1cbbContaChange
      ExplicitLeft = 14
      ExplicitWidth = 202
    end
  end
  object gridMain: TStringGrid
    Left = 0
    Top = 137
    Width = 745
    Height = 576
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
    Left = 774
    Top = 291
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 2
  end
  object dtpDeposito: TDateTimePicker
    Left = 909
    Top = 380
    Width = 200
    Height = 25
    Date = 43754.999055312510000000
    Time = 43754.999055312510000000
    MaxDate = 46022.999988425930000000
    MinDate = 41640.000000000000000000
    TabOrder = 3
  end
  object edtDescricaoCC: TEdit
    Left = 909
    Top = 291
    Width = 200
    Height = 21
    Enabled = False
    TabOrder = 4
  end
  object edtTOB: TEdit
    Left = 909
    Top = 343
    Width = 200
    Height = 21
    Enabled = False
    TabOrder = 5
  end
  object edtCTACCDB: TEdit
    Left = 774
    Top = 343
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 6
  end
  inline frameResponsavel1: TframeResponsavel
    Left = 774
    Top = 432
    Width = 348
    Height = 49
    TabOrder = 7
    ExplicitLeft = 774
    ExplicitTop = 432
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
    Top = 714
    Width = 1182
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
    Width = 1182
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
  object Panel1: TPanel
    Left = 0
    Top = 125
    Width = 1182
    Height = 10
    Align = alTop
    TabOrder = 10
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
      'AND   (TRC.ID_TIPO_STATUS = '#39'RECEBIDO'#39' )'
      'AND   (TRC.ID_LOTE_DEPOSITO IS NULL)'
      ''
      'ORDER BY TRC.VALOR DESC')
    Left = 63
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
    Left = 295
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
    Left = 175
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
    Left = 1081
    Top = 240
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
    Left = 1089
    Top = 176
  end
end
