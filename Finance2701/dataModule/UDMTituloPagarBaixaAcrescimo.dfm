object dmTPBAcrescimo: TdmTPBAcrescimo
  OldCreateOrder = False
  Height = 385
  Width = 622
  object qryObterPorTPB: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TPBA.id_titulo_pagar_baixa, TPBA.valor, TA.descricao,'
      
        '       TA.id_historico, H.descricao as dsc_hist, H.id_conta_cont' +
        'abil,H.Codigo,'
      '       CC.conta, CC.codreduz'
      'FROM titulo_pagar_baixa_ac TPBA'
      ''
      
        'JOIN tipo_acrescimo TA ON (TA.id_tipo_acrescimo = TPBA.id_tipo_a' +
        'crescimo) AND (TA.ID_ORGANIZACAO = TPBA.ID_ORGANIZACAO)'
      
        'JOIN HISTORICO H ON (H.id_historico = TA.id_historico) AND (H.ID' +
        '_ORGANIZACAO = TA.ID_ORGANIZACAO)'
      
        'JOIN conta_contabil CC ON (CC.id_conta_contabil = H.id_conta_con' +
        'tabil) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBA.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '      (TPBA.id_titulo_pagar_baixa = :pIdTitutloPagarBaixa)'
      ''
      'order by TPBA.valor')
    Left = 64
    Top = 72
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITUTLOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
