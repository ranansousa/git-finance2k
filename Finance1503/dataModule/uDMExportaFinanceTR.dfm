object dmExportFinanceTR: TdmExportFinanceTR
  OldCreateOrder = False
  Height = 455
  Width = 751
  object qryTRProvisionados: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayDate, fvFmtDisplayTime, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.ID_ORGANIZACAO,'
      '       TP.ID_TITULO_RECEBER,'
      '       TP.DATA_EMISSAO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DESCRICAO,'
      '       TP.PARCELA,'
      '       TP.VALOR_NOMINAL,'
      '       CC.CONTA AS CONTA_DEBITO,'
      '       CC.CODREDUZ,'
      '       CC.DESCRICAO AS DSC_CONTA,'
      '       TP.ID_CONTA_CONTABIL_DEBITO, '
      '      '#39'TRPROV'#39' as TIPO'
      '        '
      'FROM TITULO_RECEBER TP'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = TP.' +
        'ID_CONTA_CONTABIL_DEBITO) AND (CC.ID_ORGANIZACAO = TP.ID_ORGANIZ' +
        'ACAO)'
      ''
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (TP.DATA_EMISSAO BETWEEN :pDataInicial AND :pDataFinal) AN' +
        'D'
      '      (TP.IS_PROVISAO = :pProvisao) AND'
      '      (TP.ID_TIPO_STATUS = :pIdStatus) AND'
      '      (TP.ID_LOTE_CONTABIL IS NULL) AND'
      '      (TP.DATA_PAGAMENTO IS NULL)'
      ''
      'ORDER BY TP.DATA_EMISSAO ASC, TP.VALOR_NOMINAL DESC;  '
      '')
    Left = 496
    Top = 104
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PPROVISAO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PIDSTATUS'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qryTitulosQuitados: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayDate, fvFmtDisplayTime, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TR.ID_ORGANIZACAO,'
      '       TR.ID_TITULO_RECEBER,'
      '       TR.DATA_EMISSAO,'
      '       TR.DATA_PAGAMENTO,'
      '       TR.NUMERO_DOCUMENTO,'
      '       TR.DESCRICAO,'
      '       TR.PARCELA,'
      '       TR.VALOR_NOMINAL,'
      '       S.NOME,'
      '       CC.conta,CC.codreduz,CC.DESCRICAO AS DSC_CC,'
      '       H.DESCRICAO as dsc_hist, H.DESCRICAO_REDUZIDA,'
      '       '#39'TRB'#39' as TIPO'
      ''
      'FROM TITULO_RECEBER TR'
      
        'LEFT OUTER JOIN SACADO S ON (S.ID_SACADO = TR.ID_SACADO) AND (S.' +
        'ID_ORGANIZACAO = TR.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TR.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TR.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_contabil CC on (CC.id_conta_contabil = TR.' +
        'id_conta_contabil_debito) AND (CC.ID_ORGANIZACAO = TR.ID_ORGANIZ' +
        'ACAO)'
      ''
      'WHERE (TR.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (TR.DATA_PAGAMENTO  BETWEEN :pDataInicial AND :pDataFinal)' +
        ' AND'
      '      (TR.ID_TIPO_STATUS = :pIdStatus) AND'
      '      (TR.ID_LOTE_CONTABIL IS NULL) AND'
      '      (TR.DATA_PAGAMENTO IS NOT NULL)'
      ''
      ''
      'ORDER BY TR.DATA_PAGAMENTO ASC, TR.VALOR_NOMINAL DESC;')
    Left = 496
    Top = 208
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PIDSTATUS'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
