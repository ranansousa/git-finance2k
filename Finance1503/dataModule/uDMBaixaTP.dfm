object dmBaixaTP: TdmBaixaTP
  OldCreateOrder = False
  Height = 230
  Width = 527
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      '  SELECT TP.ID_TITULO_PAGAR AS ID, '
      '         TP.NUMERO_DOCUMENTO AS DOC,       '
      '         TP.ID_ORGANIZACAO,  '
      '         TP.DESCRICAO,'
      '         TP.VALOR_NOMINAL, '
      '         TP.ID_CEDENTE,'
      '         TP.DATA_EMISSAO, '
      '         TP.PARCELA,'
      '         C.NOME AS FORNECEDOR, '
      '         H.DESCRICAO AS DSC_HIST'
      '         '
      '  FROM TITULO_PAGAR TP'
      
        '  LEFT OUTER JOIN CEDENTE C ON (C.id_cedente = TP.id_cedente) AN' +
        'D (C.id_organizacao = TP.id_organizacao)'
      
        '  LEFT OUTER JOIN HISTORICO H ON (H.id_historico =  TP.id_histor' +
        'ico) AND (H.id_organizacao = TP.id_organizacao)'
      
        '  WHERE ( TP.ID_ORGANIZACAO = :PIDORGANIZACAO )   AND  ( TP.ID_T' +
        'IPO_STATUS IN ('#39'ABERTO'#39'))'
      '  ORDER BY TP.DATA_EMISSAO DESC, TP.VALOR_NOMINAL DESC ')
    Left = 399
    Top = 120
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterIDTPB: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ' SELECT FIRST 1 TPB.id_organizacao, '
      '        TPB.id_titulo_pagar_baixa,   '
      '        TPB.id_titulo_pagar'
      ''
      ''
      ' FROM TITULO_PAGAR_BAIXA TPB         '
      ''
      ''
      ' WHERE (TPB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND  '
      '      (TPB.id_titulo_pagar =:pIdtituloPagar) AND  '
      '      (TPB.ID_LOTE_CONTABIL IS NULL)           ')
    Left = 399
    Top = 70
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterCedente: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      
        'SELECT C.NOME, C.CPFCNPJ,C.ID_ORGANIZACAO, C.CODIGO,C.ID_CEDENTE' +
        ' AS ID '
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)    '
      ''
      ''
      ' WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND  '
      '      (TP.id_titulo_pagar =:pIdtituloPagar)    ')
    Left = 399
    Top = 22
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
