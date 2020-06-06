object frmContaBancaria: TfrmContaBancaria
  Left = 0
  Top = 0
  Width = 243
  Height = 114
  TabOrder = 0
  object lbl1: TLabel
    Left = 16
    Top = 0
    Width = 73
    Height = 13
    Caption = 'Conta Banc'#225'ria'
  end
  object cbbConta: TComboBox
    Left = 16
    Top = 19
    Width = 201
    Height = 21
    TabOrder = 0
    Text = 'cbbConta'
  end
  object qryObterTodos: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT CB.ID_CONTA_BANCARIA,'
      '       CB.ID_ORGANIZACAO,'
      '       CB.ID_CONTA_CONTABIL, '
      '       CB.ID_BANCO,'
      '       CB.CONTA,'
      '       CB.AGENCIA,'
      '       CB.TITULAR'
      ''
      'FROM CONTA_BANCARIA CB'
      ''
      'WHERE CB.ID_ORGANIZACAO = :PIDORGANIZACAO')
    Left = 152
    Top = 56
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterContaContabil: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT CB.ID_CONTA_BANCARIA,'
      '       CB.ID_ORGANIZACAO,       '
      '       CC.ID_CONTA_CONTABIL,'
      '       CC.DESCRICAO,'
      '       CC.CONTA,'
      '       CC.DGVER,'
      '       CC.CODREDUZ,'
      '       CC.DGREDUZ'
      ''
      ''
      'FROM CONTA_BANCARIA CB'
      ''
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = CB.' +
        'ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = CB.ID_ORGANIZACAO)'
      ''
      'WHERE (CB.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      'AND   (CB.ID_CONTA_BANCARIA = :PIDCONTABANCARIA)'
      ''
      ''
      ''
      '')
    Left = 32
    Top = 56
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
end
