object dmTPBCheque: TdmTPBCheque
  OldCreateOrder = False
  Height = 403
  Width = 614
  object qryObterPorTPB: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT  TPBC.ID_TITULO_PAGAR_BAIXA_CHEQUE,'
      '        TPBC.ID_CONTA_BANCARIA_CHEQUE,'
      '        TPBC.ID_TITULO_PAGAR_BAIXA,'
      '        TPBC.VALOR,'
      '        CC.CONTA AS CONTA_CONTABIL_CREDITO,'
      '        CC.CODREDUZ AS COD_REDUZ_CREDITO,'
      '        CC.DESCRICAO AS DSC_CC_CREDITO'
      ''
      ''
      'FROM TITULO_PAGAR_BAIXA_CHEQUE TPBC'
      
        'LEFT OUTER JOIN conta_bancaria_cheque CBC ON (CBC.ID_CONTA_BANCA' +
        'RIA_CHEQUE = TPBC.ID_CONTA_BANCARIA_CHEQUE)'
      ' AND (CBC.ID_ORGANIZACAO = TPBC.id_organizacao)'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = CBC' +
        '.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = TPBC.id_organizacao' +
        ')'
      
        'LEFT OUTER JOIN conta_contabil CC ON (CC.id_conta_contabil = CB.' +
        'id_conta_contabil) AND (CC.ID_ORGANIZACAO = TPBC.id_organizacao)'
      ''
      'WHERE (TPBC.id_organizacao = :PIDORGANIZACAO) AND'
      '       (TPBC.ID_TITULO_PAGAR_BAIXA = :PIDTITULOPAGARBAIXA)AND'
      '       (CBC.data_compensacao is null)')
    Left = 160
    Top = 152
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
end
