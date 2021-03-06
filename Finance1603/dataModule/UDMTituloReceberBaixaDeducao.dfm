object dmTRBDeducao: TdmTRBDeducao
  OldCreateOrder = False
  Height = 475
  Width = 503
  object qryObterPorTRB: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TRBDE.ID_TITULO_RECEBER_BAIXA_DE,'
      '    TRBDE.ID_TITULO_RECEBER_BAIXA,'
      '    TRBDE.ID_TIPO_DEDUCAO,'
      '    TRBDE.VALOR,'
      '    H.DESCRICAO AS DSC_HIST,'
      '    H.CODIGO AS COD_HIST,'
      '    H.DESCRICAO_REDUZIDA,'
      '    C.DESCRICAO AS DSC_CONTA,'
      '    C.CONTA,'
      '    C.CODREDUZ,'
      '    TD.DESCRICAO AS DSC_DEDUCAO'
      ''
      'FROM TITULO_RECEBER_BAIXA_DE TRBDE'
      ''
      
        'JOIN TIPO_DEDUCAO TD ON (TD.ID_TIPO_DEDUCAO = TRBDE.ID_TIPO_DEDU' +
        'CAO)'
      'JOIN HISTORICO H ON (H.ID_HISTORICO = TD.ID_HISTORICO)'
      
        'JOIN CONTA_CONTABIL C ON (C.ID_CONTA_CONTABIL = H.ID_CONTA_CONTA' +
        'BIL)'
      ''
      'WHERE   (TRBDE.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '        (TRBDE.ID_TITULO_RECEBER_BAIXA =:PIDTITULORECEBERBAIXA);'
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
