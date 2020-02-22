object dmTCConsulta: TdmTCConsulta
  OldCreateOrder = False
  Height = 431
  Width = 759
  object qryObterPorTituloReceberBaixa: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TC.ID_TITULO_RECEBER_BAIXA,'
      '   TC.ID_TESOURARIA_CREDITO,'
      '   TC.DATA_MOVIMENTO,'
      '   TC.VALOR_NOMINAL,'
      '   H.DESCRICAO AS DSC_HIST,'
      '   TC.OBSERVACAO,'
      '   TC.DESCRICAO,'
      '   CC.CONTA,'
      '   CC.DESCRICAO AS DSC_CC,'
      '   CC.CODREDUZ'
      '   '
      'FROM TESOURARIA_CREDITO TC'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TC.ID_HISTORICO' +
        ')'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.I' +
        'D_CONTA_CONTABIL)'
      ''
      'WHERE (TC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND          '
      '      (TC.ID_TITULO_RECEBER_BAIXA = :PIDTITULORECEBERBAIXA)')
    Left = 496
    Top = 280
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
  object qryObterPorContaBancariaDebito: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT  TC.NUMERO_DOCUMENTO,'
      '        TC.id_conta_bancaria_debito,'
      '        TC.DESCRICAO,'
      '        TC.VALOR_NOMINAL,'
      '        H.DESCRICAO AS DSC_HIST,'
      '        H.CODIGO AS CODIGO_HIST,'
      '        H.DESCRICAO_REDUZIDA,'
      '        CC.CONTA AS CONTA_CONTABIL_DEBITO,'
      '        CC.CODREDUZ AS COD_REDUZ_DEBITO,'
      '        CC.DESCRICAO AS DSC_CC_DEBITO,'
      '        '#39'CBD'#39' as TIPO'
      ''
      ''
      'FROM  TESOURARIA_CREDITO TC '
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TC.ID_HISTORICO' +
        ')AND (H.id_organizacao = TC.id_organizacao)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.I' +
        'D_CONTA_CONTABIL) AND (CC.id_organizacao = h.id_organizacao)'
      ''
      ''
      'WHERE (TC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TC.ID_CONTA_BANCARIA_DEBITO = :PIDCONTABANCODEBITO) AND'
      '      (TC.ID_LOTE_CONTABIL IS NULL)')
    Left = 488
    Top = 200
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCONTABANCODEBITO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
