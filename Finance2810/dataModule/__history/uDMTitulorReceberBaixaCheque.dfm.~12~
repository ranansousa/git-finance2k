object dmTRBCheque: TdmTRBCheque
  OldCreateOrder = False
  Height = 489
  Width = 615
  object qryObterPorTRB: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      ''
      'SELECT TRBC.ID_TITULO_RECEBER_BAIXA_CHEQUE,'
      '        TRBC.ID_TITULO_RECEBER_BAIXA,'
      '        TRBC.VALOR,'
      '        H.DESCRICAO AS DSC_HIST,'
      '        CC.CONTA,'
      '        CC.DESCRICAO AS DSC_CC,'
      '        CC.CODREDUZ'
      ''
      'FROM TITULO_RECEBER_BAIXA_CHEQUE TRBC'
      
        'LEFT OUTER JOIN TESOURARIA_CREDITO TC on (tc.id_titulo_receber_b' +
        'aixa_cheque = TRBC.ID_TITULO_RECEBER_BAIXA_CHEQUE)  AND (TC.id_o' +
        'rganizacao = TRBC.id_organizacao)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TC.ID_HISTORICO' +
        ') and (h.id_organizacao = tc.id_organizacao)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.I' +
        'D_CONTA_CONTABIL) AND (CC.id_organizacao = H.id_organizacao)'
      ''
      'WHERE (TRBC.id_organizacao = :PIDORGANIZACAO) AND'
      '      (TRBC.ID_TITULO_RECEBER_BAIXA = :PIDTITULORECEBERBAIXA);'
      ''
      '')
    Left = 240
    Top = 192
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
