object dmTPBDeducao: TdmTPBDeducao
  OldCreateOrder = False
  Height = 360
  Width = 508
  object qryObterPorTPB: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    SQL.Strings = (
      'SELECT TPBD.id_titulo_pagar_baixa, '
      '       TPBD.valor, '
      '       TD.descricao,'
      '       TD.id_historico, '
      '       H.descricao as dsc_hist, '
      '       H.id_conta_contabil, '
      '       H.codigo,'
      '       CC.conta, '
      '       CC.codreduz'
      'FROM titulo_pagar_baixa_de TPBD'
      ''
      
        'JOIN tipo_deducao TD ON (TD.ID_TIPO_DEDUCAO = TPBD.ID_TIPO_DEDUC' +
        'AO) AND (TD.ID_ORGANIZACAO = TPBD.ID_ORGANIZACAO)'
      
        'JOIN HISTORICO H ON (H.id_historico = TD.id_historico) AND (H.ID' +
        '_ORGANIZACAO = TD.ID_ORGANIZACAO)'
      
        'JOIN conta_contabil CC ON (CC.id_conta_contabil = H.id_conta_con' +
        'tabil) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBD.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '      (TPBD.id_titulo_pagar_baixa = :pIdTitutloPagarBaixa)'
      ''
      'ORDER BY TPBD.VALOR')
    Left = 112
    Top = 88
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
