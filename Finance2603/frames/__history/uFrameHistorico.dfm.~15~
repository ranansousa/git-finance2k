inherited frameHistorico: TframeHistorico
  Width = 442
  Height = 305
  ExplicitWidth = 442
  ExplicitHeight = 305
  inherited lblID: TLabel
    Left = 407
    Top = 115
    ExplicitLeft = 407
    ExplicitTop = 115
  end
  inherited cbbcombo: TComboBox
    Width = 265
    ExplicitWidth = 265
  end
  inherited qryObterPorID: TFDQuery
    SQL.Strings = (
      'SELECT H.id_historico,'
      '       h.id_organizacao,'
      '       h.descricao,'
      '       h.tipo,'
      '       h.codigo,'
      '       h.id_conta_contabil,'
      '       h.descricao_reduzida'
      'FROM HISTORICO H'
      ''
      
        'WHERE (H.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (H.id_historico =' +
        ' :PIDHISTORICO)'
      ''
      '')
    Left = 376
    Top = 184
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDHISTORICO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  inherited qryObterTodos: TFDQuery
    SQL.Strings = (
      'SELECT H.ID_HISTORICO,'
      '       H.ID_ORGANIZACAO,'
      '       H.DESCRICAO AS DESCRICAO_HISTORICO,'
      '       H.TIPO, '
      '       H.CODIGO,'
      '       H.DESCRICAO_REDUZIDA, '
      '       CC.CONTA, '
      '       CC.DESCRICAO AS DESCRICAO_CONTA, '
      '       CC.CODREDUZ AS CODIGO_REDUZ'
      ''
      'FROM HISTORICO H'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.I' +
        'D_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO) '
      ''
      'WHERE (H.ID_ORGANIZACAO = :PIDORGANIZACAO) '
      ''
      'ORDER BY CC.CONTA'
      ''
      '')
    Left = 368
    Top = 128
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
    Left = 384
    Top = 48
  end
end
