object dmTDConsulta: TdmTDConsulta
  OldCreateOrder = False
  Height = 343
  Width = 611
  object qryObterPorTituloPagarBaixa: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      
        '   SELECT td.ID_TITULO_PAGAR_BAIXA, td.id_tesouraria_debito, td.' +
        'data_movimento, td.valor_nominal,h.descricao as DSC_HIST,'
      
        '          td.observacao, td.descricao, cc.conta as CONTA_CREDITO' +
        ', cc.descricao as DSC_CC,cc.codreduz'
      '   FROM TESOURARIA_DEBITO TD'
      '   join historico h on (h.id_historico = td.id_historico)'
      
        '   join conta_contabil cc on (cc.id_conta_contabil = h.id_conta_' +
        'contabil)'
      '   WHERE (TD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '         (TD.id_titulo_pagar_baixa = :PIDTITULOPAGARBAIXA)')
    Left = 320
    Top = 104
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterPorPeriodo: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      '   SELECT * FROM TESOURARIA_DEBITO TD'
      '   WHERE (TD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '         (TD.id_titulo_pagar_baixa = :PIDTITULOPAGARBAIXA)')
    Left = 104
    Top = 96
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterPorContaBancariaCredito: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT  TD.NUMERO_DOCUMENTO,'
      '        TD.DESCRICAO,'
      '        TD.VALOR_NOMINAL,'
      '        H.DESCRICAO AS DSC_HIST,'
      '        H.CODIGO AS CODIGO_HIST,'
      '        H.DESCRICAO_REDUZIDA,'
      '        CC.CONTA AS CONTA_CONTABIL_CREDITO,'
      '        CC.CODREDUZ AS COD_REDUZ_CREDITO,'
      '        CC.DESCRICAO AS DSC_CC_CREDITO'
      ''
      'FROM  TESOURARIA_DEBITO TD'
      'JOIN HISTORICO H ON (H.ID_HISTORICO = TD.ID_HISTORICO)'
      
        'JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.ID_CONTA_CON' +
        'TABIL)'
      ''
      'WHERE (TD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TD.id_conta_bancaria_credito = :PIDCONTABANCOCREDITO) AND'
      '      (TD.ID_LOTE_CONTABIL IS NULL)')
    Left = 280
    Top = 224
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCONTABANCOCREDITO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
