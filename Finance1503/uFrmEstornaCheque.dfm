object frmEstornaCheque: TfrmEstornaCheque
  Left = 0
  Top = 0
  Caption = 'Estornar cheque compensado'
  ClientHeight = 454
  ClientWidth = 882
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
    Left = 24
    Top = 199
    Width = 71
    Height = 13
    Caption = 'Conta Cont'#225'bil'
  end
  object lbl2: TLabel
    Left = 166
    Top = 199
    Width = 135
    Height = 13
    Caption = 'Descri'#231#227'o da Conta Cont'#225'bil'
  end
  object lbl3: TLabel
    Left = 269
    Top = 137
    Width = 84
    Height = 13
    Caption = 'Cheques emitidos'
  end
  object lbl4: TLabel
    Left = 722
    Top = 137
    Width = 38
    Height = 13
    Caption = 'Emiss'#227'o'
  end
  object lbl5: TLabel
    Left = 722
    Top = 199
    Width = 62
    Height = 13
    Caption = 'Compensado'
  end
  object lbl6: TLabel
    Left = 414
    Top = 137
    Width = 24
    Height = 13
    Caption = 'Valor'
  end
  object lbl7: TLabel
    Left = 414
    Top = 199
    Width = 42
    Height = 13
    Caption = 'Portador'
  end
  object lblIDTP: TLabel
    Left = 820
    Top = 245
    Width = 33
    Height = 13
    Caption = 'lblIDTP'
    Visible = False
  end
  object lblIDCONTAbANCARIA: TLabel
    Left = 720
    Top = 315
    Width = 108
    Height = 13
    Caption = 'lblIDCONTAbANCARIA'
    Visible = False
  end
  object lblIDCHEQUE: TLabel
    Left = 722
    Top = 245
    Width = 62
    Height = 13
    Caption = 'lblIDCHEQUE'
    Visible = False
  end
  object lblRESPONSAVEL: TLabel
    Left = 720
    Top = 334
    Width = 80
    Height = 13
    Caption = 'lblRESPONSAVEL'
    Visible = False
  end
  object lblTOB: TLabel
    Left = 720
    Top = 358
    Width = 30
    Height = 13
    Caption = 'lblTOB'
    Visible = False
  end
  object lblIDUSER: TLabel
    Left = 720
    Top = 377
    Width = 26
    Height = 13
    Caption = 'USER'
    Visible = False
  end
  object lbl8: TLabel
    Left = 325
    Top = 397
    Width = 108
    Height = 13
    Caption = 'Data da Compensa'#231#227'o'
  end
  object Label1: TLabel
    Left = 554
    Top = 137
    Width = 63
    Height = 13
    Caption = 'Data estorno'
  end
  object Label2: TLabel
    Left = 415
    Top = 252
    Width = 58
    Height = 13
    Caption = 'Observa'#231#227'o'
  end
  inline frmContaBancaria1: TfrmContaBancaria
    Left = 8
    Top = 138
    Width = 233
    Height = 59
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 138
    ExplicitWidth = 233
    ExplicitHeight = 59
    inherited cbbConta: TComboBox
      OnChange = frmContaBancaria1cbbContaChange
    end
    inherited qryObterTodos: TFDQuery
      Top = 0
    end
    inherited qryObterContaContabil: TFDQuery
      Left = 24
      Top = 0
    end
  end
  object edtContaContabil: TEdit
    Left = 24
    Top = 218
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 1
  end
  object edtDescricaoCC: TEdit
    Left = 166
    Top = 218
    Width = 227
    Height = 21
    Enabled = False
    TabOrder = 2
  end
  object cbbcheque: TComboBox
    Left = 269
    Top = 157
    Width = 124
    Height = 21
    TabOrder = 3
    OnChange = cbbchequeChange
  end
  object edtPortador: TEdit
    Left = 414
    Top = 218
    Width = 271
    Height = 21
    Enabled = False
    TabOrder = 4
  end
  object medtDataEmissao: TMaskEdit
    Left = 722
    Top = 157
    Width = 131
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 5
    Text = '  /  /    '
  end
  object medtCompensado: TMaskEdit
    Left = 722
    Top = 218
    Width = 131
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 6
    Text = '  /  /    '
  end
  object medtvalor: TMaskEdit
    Left = 414
    Top = 157
    Width = 115
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 7
    Text = ''
  end
  object dbgrd1: TDBGrid
    Left = 0
    Top = 318
    Width = 882
    Height = 116
    Align = alBottom
    DataSource = ds1
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'NUMERO_DOCUMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'DOCUMENTO'
        Width = 120
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALOR_NOMINAL'
        Title.Alignment = taCenter
        Title.Caption = 'VALOR DO T'#205'TULO'
        Width = 120
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATA_VENCIMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'VENCIMENTO'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATA_PAGAMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'PAGAMENTO'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO_TP'
        Title.Alignment = taCenter
        Title.Caption = 'DESCRI'#199#195'O'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOB'
        Title.Alignment = taCenter
        Title.Caption = 'OPERA'#199#195'O BANC'#193'RIA'
        Width = 200
        Visible = True
      end>
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 434
    Width = 882
    Height = 20
    Panels = <
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
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 882
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 10
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Estornar cheque'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end>
      Index = 0
    end
  end
  object dtpEstorna: TDateTimePicker
    Left = 554
    Top = 156
    Width = 131
    Height = 25
    Date = 43754.000000000000000000
    Time = 0.999055312509881300
    TabOrder = 11
    OnChange = dtpEstornaChange
  end
  inline frameResponsavel1: TframeResponsavel
    Left = 24
    Top = 250
    Width = 385
    Height = 62
    TabOrder = 12
    ExplicitLeft = 24
    ExplicitTop = 250
    ExplicitWidth = 385
    ExplicitHeight = 62
    inherited lblID: TLabel
      Left = 67
      Top = 30
      ExplicitLeft = 67
      ExplicitTop = 30
    end
    inherited cbbcombo: TComboBox
      Width = 366
      OnChange = frameResponsavel1cbbcomboChange
      ExplicitWidth = 366
    end
    inherited qryObterPorID: TFDQuery
      Left = 16
      Top = 8
    end
    inherited qryObterTodos: TFDQuery
      Left = 104
      Top = 24
    end
  end
  object edtObs: TEdit
    Left = 414
    Top = 271
    Width = 439
    Height = 21
    Enabled = False
    TabOrder = 13
  end
  object qryObterCheque: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT  CBC.ID_CONTA_BANCARIA_CHEQUE AS IDCHEQUE,'
      '        CBC.ID_ORGANIZACAO,'
      '        CBC.ID_CONTA_BANCARIA,'
      '        CBC.ID_FUNCIONARIO,'
      '        CBC.ID_TIPO_STATUS,'
      '        CBC.NUMERO_CHEQUE,'
      '        CBC.DATA_EMISSAO,'
      '        CBC.DATA_ESTORNO,'
      '        CBC.DATA_COMPENSACAO,'
      '        CBC.VALOR,'
      '        CBC.OBSERVACAO,'
      '        CBC.PORTADOR,'
      '        CBC.QTD_IMPRESSAO,'
      '        F.NOME,'
      '        TS.DESCRICAO AS STATUS,'
      '        CB.CONTA_INTERNA,'
      '        CB.CONTA,'
      '        CB.AGENCIA,'
      '        CB.TITULAR'
      ''
      ' FROM CONTA_BANCARIA_CHEQUE CBC'
      ''
      
        ' LEFT OUTER JOIN FUNCIONARIO F ON (F.ID_FUNCIONARIO = CBC.ID_FUN' +
        'CIONARIO)  AND (F.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO)'
      
        ' LEFT OUTER JOIN TIPO_STATUS TS ON (TS.ID_TIPO_STATUS = CBC.ID_T' +
        'IPO_STATUS) AND (TS.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO)'
      
        ' LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CB' +
        'C.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO' +
        ')'
      ''
      ' WHERE (CBC.ID_ORGANIZACAO =  :PIDORGANIZACAO) AND'
      '       (CBC.ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE)')
    Left = 144
    Top = 368
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCHEQUE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryListaChequesPorCB: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT  CBC.ID_CONTA_BANCARIA_CHEQUE AS IDCHEQUE,       '
      '        CBC.NUMERO_CHEQUE'
      ''
      'FROM CONTA_BANCARIA_CHEQUE CBC'
      ''
      'WHERE (CBC.ID_ORGANIZACAO =  :PIDORGANIZACAO) AND'
      '       (CBC.ID_CONTA_BANCARIA = :PIDCONTABANCARIA) '
      '  AND  (CBC.ID_TIPO_STATUS = '#39'COMPENSADO'#39')'
      '')
    Left = 658
    Top = 366
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCONTABANCARIA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBBAIXA: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TPBCH.ID_TITULO_PAGAR_BAIXA_CHEQUE,'
      '       TPBCH.ID_ORGANIZACAO,'
      '       TPBCH.VALOR,'
      '       TPBCH.ID_TIPO_OPERACAO_BANCARIA AS TOB,'
      '       TOB.DESCRICAO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DATA_VENCIMENTO,'
      '       TP.DATA_PAGAMENTO,'
      '       (H.DESCRICAO || TP.DESCRICAO) AS DESCRICAO_TP,'
      '       TP.VALOR_NOMINAL,'
      '       TP.ID_TITULO_PAGAR,'
      '       TP.ID_RESPONSAVEL,'
      '       TPB.ID_LOTE_PAGAMENTO'
      ''
      '     '
      'FROM TITULO_PAGAR_BAIXA_CHEQUE TPBCH'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = TPBCH.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGA' +
        'NIZACAO = TPBCH.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.ID_TITULO_PAGAR_B' +
        'AIXA = TPBCH.ID_TITULO_PAGAR_BAIXA) AND (TPB.ID_ORGANIZACAO = TP' +
        'BCH.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN TITULO_PAGAR TP ON (TP.ID_TITULO_PAGAR = TPB.ID_' +
        'TITULO_PAGAR) AND (TP.ID_ORGANIZACAO = TPBCH.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TPBCH.ID_ORGANIZACAO)'
      ''
      ''
      'WHERE  (TPBCH.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      '   AND (TPBCH.ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE)'
      ''
      '')
    Left = 272
    Top = 368
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCHEQUE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object ds1: TDataSource
    DataSet = qryTPBBAIXA
    Left = 216
    Top = 376
  end
  object qryInsereCBD: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    Left = 344
    Top = 368
  end
  object qryCheckIdent: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT COUNT(*) AS QTD '
      ''
      'FROM CONTA_BANCARIA_DEBITO CBD '
      ''
      ''
      'WHERE (CBD.IDENTIFICACAO = :PIDENT)')
    Left = 552
    Top = 368
    ParamData = <
      item
        Name = 'PIDENT'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryUpdateCheque: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'UPDATE CONTA_BANCARIA_CHEQUE CBC '
      '       SET CBC.ID_TIPO_STATUS = :PSTATUS, '
      '           CBC.DATA_COMPENSACAO = :PDATACOMPENSADO'
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (CBC.ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE)')
    Left = 432
    Top = 368
    ParamData = <
      item
        Name = 'PSTATUS'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATACOMPENSADO'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCHEQUE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
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
    Left = 728
    Top = 56
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
    Left = 808
    Top = 64
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Estono de cheque'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 918
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnEstonar'
        end
        item
          Visible = True
          ItemName = 'dxBarBtnBloquear'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Fechar'
      CaptionButtons = <>
      DockedLeft = 119
      DockedTop = 0
      FloatLeft = 918
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnSair'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarBtnSair: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBarBtnSairClick
    end
    object dxBarBtnEstornar: TdxBarLargeButton
      Caption = 'Estornar'
      Category = 0
      Hint = 'Estornar'
      Visible = ivAlways
    end
    object dxBarBtnEstonar: TdxBarLargeButton
      Caption = 'Estornar'
      Category = 0
      Hint = 'Estornar'
      Visible = ivAlways
      OnClick = dxBarBtnEstonarClick
    end
    object dxBarBtnBloquear: TdxBarLargeButton
      Caption = 'Alterar Status'
      Category = 0
      Hint = 'Alterar Status'
      Visible = ivAlways
      OnClick = dxBarBtnBloquearClick
    end
  end
end
