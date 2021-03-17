object frameCheque: TframeCheque
  Left = 0
  Top = 0
  Width = 270
  Height = 137
  TabOrder = 0
  object lbl1: TLabel
    Left = 16
    Top = 0
    Width = 37
    Height = 13
    Caption = 'Cheque'
  end
  object cbbCheque: TComboBox
    Left = 16
    Top = 19
    Width = 201
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    MaxLength = 10
    ParentFont = False
    TabOrder = 0
    Text = 'cbbCheque'
    TextHint = 'Seleciona um cheque '
  end
  object qryObterTodos: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT CBC.id_conta_bancaria_cheque AS ID,'
      '       CBC.numero_cheque AS CHEQUE'
      ''
      '  FROM CONTA_BANCARIA_CHEQUE CBC'
      'WHERE (CBC.ID_ORGANIZACAO =:PIDORGANIZACAO)'
      '   AND  (CBC.id_CONTA_BANCARIA = :PIDCONTA)'
      '   AND   (CBC.id_tipo_status = :PIDSTATUS)'
      'ORDER BY CBC.NUMERO_CHEQUE'
      '')
    Left = 24
    Top = 48
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
      end
      item
        Name = 'PIDSTATUS'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryChequePorID: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT CBC.id_conta_bancaria_cheque,'
      '       cbc.id_organizacao,'
      '       cbc.id_conta_bancaria,'
      '       cbc.id_funcionario,'
      '       cbc.id_tipo_status,'
      '       cbc.numero_cheque,'
      '       cbc.data_registro,'
      '       cbc.data_emissao,'
      '       cbc.data_compensacao,'
      '       cbc.valor,'
      '       cbc.observacao,'
      '       cbc.portador,'
      '       cbc.data_previsao_compensacao,'
      '       cbc.data_estorno,'
      '       cbc.id_usuario,'
      '       cbc.qtd_impressao'
      ' FROM conta_bancaria_cheque CBC'
      ''
      ' WHERE (CBC.ID_ORGANIZACAO =:PIDORGANIZACAO)'
      '   AND (CBC.ID_CONTA_BANCARIA = :PIDCONTA)'
      '   AND (CBC.ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE)'
      ''
      ''
      '')
    Left = 96
    Top = 48
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
      end
      item
        Name = 'PIDCHEQUE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryChequePorNumero: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT CBC.id_conta_bancaria_cheque,'
      '       cbc.id_organizacao,'
      '       cbc.id_conta_bancaria,'
      '       cbc.id_funcionario,'
      '       cbc.id_tipo_status,'
      '       cbc.numero_cheque,'
      '       cbc.data_registro,'
      '       cbc.data_emissao,'
      '       cbc.data_compensacao,'
      '       cbc.valor,'
      '       cbc.observacao,'
      '       cbc.portador,'
      '       cbc.data_previsao_compensacao,'
      '       cbc.data_estorno,'
      '       cbc.id_usuario,'
      '       cbc.qtd_impressao'
      ' FROM conta_bancaria_cheque CBC'
      ''
      ' WHERE (CBC.ID_ORGANIZACAO =:PIDORGANIZACAO)'
      '   AND (CBC.ID_CONTA_BANCARIA = :PIDCONTA)'
      '   AND (CBC.NUMERO_CHEQUE = :CHEQUE)'
      ''
      ''
      '')
    Left = 40
    Top = 112
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
      end
      item
        Name = 'CHEQUE'
        DataType = ftString
        ParamType = ptInput
        Size = 10
      end>
  end
end
