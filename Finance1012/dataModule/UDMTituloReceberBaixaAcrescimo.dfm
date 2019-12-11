object dmTRBAcrescimo: TdmTRBAcrescimo
  OldCreateOrder = False
  Height = 615
  Width = 755
  object qryObterPorTRB: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TRBAC.ID_TITULO_RECEBER_BAIXA_AC,'
      '    TRBAC.ID_TITULO_RECEBER_BAIXA,'
      '    TRBAC.ID_TIPO_ACRESCIMO,'
      '    TRBAC.VALOR,'
      '    H.DESCRICAO AS DSC_HIST,'
      '    H.CODIGO AS COD_HIST,'
      '    H.DESCRICAO_REDUZIDA,'
      '    C.DESCRICAO AS DSC_CONTA,'
      '    C.CONTA,'
      '    C.CODREDUZ,'
      '    TA.DESCRICAO AS DSC_DEDUCAO'
      ''
      'FROM TITULO_RECEBER_BAIXA_AC TRBAC'
      ''
      
        'LEFT OUTER JOIN TIPO_ACRESCIMO TA ON (TA.ID_TIPO_ACRESCIMO = TRB' +
        'AC.ID_TIPO_ACRESCIMO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TA.ID_HISTORICO' +
        ')'
      
        'LEFT OUTER JOIN CONTA_CONTABIL C ON (C.ID_CONTA_CONTABIL = H.ID_' +
        'CONTA_CONTABIL)'
      ''
      'WHERE   (TRBAC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '        (TRBAC.ID_TITULO_RECEBER_BAIXA =:PIDTITULORECEBERBAIXA);'
      '')
    Left = 112
    Top = 96
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULORECEBERBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
