object dmContasPagar: TdmContasPagar
  OldCreateOrder = False
  Height = 325
  Width = 503
  object DSPreencheGridMain: TDataSource
    AutoEdit = False
    DataSet = qryRelPagamentos
    Left = 87
    Top = 88
  end
  object qryRelPagamentos: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT'
      '  TP.NUMERO_DOCUMENTO,'
      '  TP.VALOR_NOMINAL,'
      '  TP.DATA_VENCIMENTO AS DATA_VENCIMENTO,'
      '  TP.DATA_PAGAMENTO AS DATA_PAGAMENTO,'
      '  TP.DESCRICAO,'
      '  H.DESCRICAO AS DESC_HISTORICO,'
      '  C.NOME AS NOME_CEDENTE,'
      '  T.DESCRICAO AS STATUS,'
      '  CC.DESCRICAO AS CENTRO_DE_CUSTO'
      'FROM'
      '  TITULO_PAGAR TP'
      
        '  LEFT OUTER JOIN TIPO_STATUS T ON (T.ID_TIPO_STATUS = TP.ID_TIP' +
        'O_STATUS AND T.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        '  LEFT OUTER JOIN CENTRO_CUSTO CC ON (CC.ID_CENTRO_CUSTO = TP.ID' +
        '_CENTRO_CUSTO AND T.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        '  LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORI' +
        'CO AND H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        '  LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE AND' +
        ' C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)')
    Left = 280
    Top = 88
  end
  object qryCentroCusto: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT'
      '  CC.ID_CENTRO_CUSTO,'
      '  CC.DESCRICAO'
      'FROM'
      '  CENTRO_CUSTO CC')
    Left = 192
    Top = 88
  end
  object sqlScriptContainer: TFDScript
    SQLScripts = <
      item
        Name = 'sqlRelPagamentos'
        SQL.Strings = (
          'SELECT'
          '  TP.NUMERO_DOCUMENTO,'
          '  TP.VALOR_NOMINAL,'
          '  TP.DATA_VENCIMENTO AS DATA_VENCIMENTO,'
          '  TP.DATA_PAGAMENTO AS DATA_PAGAMENTO,'
          '  TP.DESCRICAO,'
          '  H.DESCRICAO AS DESC_HISTORICO,'
          '  C.NOME AS NOME_CEDENTE,'
          '  T.DESCRICAO AS STATUS,'
          '  CC.DESCRICAO AS CENTRO_DE_CUSTO'
          'FROM'
          '  TITULO_PAGAR TP'
          
            '  LEFT OUTER JOIN TIPO_STATUS T ON (T.ID_TIPO_STATUS = TP.ID_TIP' +
            'O_STATUS AND T.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
          
            '  LEFT OUTER JOIN CENTRO_CUSTO CC ON (CC.ID_CENTRO_CUSTO = TP.ID' +
            '_CENTRO_CUSTO AND T.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
          
            '  LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORI' +
            'CO AND H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
          
            '  LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE AND' +
            ' C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)')
      end>
    Connection = dmConexao.Conn
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 416
    Top = 40
  end
end
