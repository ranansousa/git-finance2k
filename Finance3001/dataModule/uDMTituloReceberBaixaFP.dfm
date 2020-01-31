object dmTRBFP: TdmTRBFP
  OldCreateOrder = False
  Height = 490
  Width = 704
  object qryObterPorTRB: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT  TRBFP.id_forma_pagamento,'
      '        FP.id_conta_contabil,'
      '        CC.descricao,'
      '        CC.conta,'
      '        CC.codreduz'
      'FROM titulo_receber_baixa_fp TRBFP'
      ''
      
        'left outer JOIN forma_pagamento FP ON (FP.id_forma_pagamento = T' +
        'RBFP.id_forma_pagamento) AND (FP.id_organizacao = TRBFP.id_organ' +
        'izacao)'
      
        'left outer JOIN conta_contabil CC ON (CC.id_conta_contabil = FP.' +
        'id_conta_contabil) AND (CC.id_organizacao = fp.id_organizacao)'
      'WHERE   (TRBFP.id_organizacao = :PIDORGANIZACAO) AND'
      '        (TRBFP.id_titulo_receber_baixa = :PIDTITULORECEBERBAIXA)')
    Left = 360
    Top = 232
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
