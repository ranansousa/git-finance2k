object dmExportFinanceTP: TdmExportFinanceTP
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 372
  Width = 603
  object qryTitulosProvisionados: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.ID_ORGANIZACAO,'
      '       TP.ID_TITULO_PAGAR,'
      '       TP.DATA_EMISSAO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DESCRICAO,'
      '       TP.PARCELA,'
      '       TP.VALOR_NOMINAL, TP.ID_CEDENTE,'
      '       CED.NOME AS FORNECEDOR,'
      '       CC.CONTA AS CONTA_CREDITO,'
      '       CC.DGVER,'
      '       CC.CODREDUZ, CC.DGREDUZ, '
      '       CC.DESCRICAO AS DSC_CONTA,'
      '       TP.ID_CONTA_CONTABIL_CREDITO,'
      '       H.codigo as COD_HIST,'
      '       '#39'TPPROV'#39' as TIPO'
      ''
      'FROM TITULO_PAGAR TP'
      
        ' JOIN CEDENTE CED ON (CED.ID_CEDENTE = TP.ID_CEDENTE) AND (CED.I' +
        'D_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = TP.' +
        'ID_CONTA_CONTABIL_CREDITO) AND (CC.ID_ORGANIZACAO = TP.ID_ORGANI' +
        'ZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = tp.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
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
    Left = 488
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
        Size = 36
      end>
  end
  object qryTitulosQuitados: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.ID_ORGANIZACAO,'
      '       TP.ID_TITULO_PAGAR,'
      '       TP.DATA_EMISSAO,'
      '       TP.DATA_PAGAMENTO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DESCRICAO,'
      '       TP.PARCELA,'
      '       TP.VALOR_NOMINAL,'
      '        C.NOME,'
      '        H.DESCRICAO as dsc_hist, H.DESCRICAO_REDUZIDA,'
      '       '#39'TPB'#39' as TIPO'
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (TP.DATA_PAGAMENTO  BETWEEN :pDataInicial AND :pDataFinal)' +
        ' AND'
      '      (TP.ID_TIPO_STATUS = :pIdStatus) AND'
      '      (TP.ID_LOTE_CONTABIL IS NULL) AND'
      '      (TP.DATA_PAGAMENTO IS NOT NULL)'
      ''
      'ORDER BY TP.DATA_PAGAMENTO ASC, TP.VALOR_NOMINAL DESC;')
    Left = 480
    Top = 24
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
  object qryTPPROVBASE: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TP.REGISTRO_PROVISAO, '
      '       MAX(TP.ID_ORGANIZACAO) AS ID_ORGANIZACAO,'
      '       MAX(TP.ID_TITULO_PAGAR) AS ID_TITULO_PAGAR,'
      '       MAX(TP.DATA_EMISSAO) AS DATA_EMISSAO,'
      '       MAX(TP.NUMERO_DOCUMENTO) AS NUMERO_DOCUMENTO,'
      '       MAX(TP.DESCRICAO)AS DESCRICAO,'
      '       MAX(TP.PARCELA) AS PARCELA,       '
      '       MAX(TP.ID_CEDENTE),'
      '       MAX(CED.NOME) AS FORNECEDOR,'
      '       SUM(TP.VALOR_NOMINAL) AS TOTAL,       '
      '       '#39'TPPROV'#39' as TIPO'
      ''
      ''
      'FROM TITULO_PAGAR TP'
      
        'JOIN CEDENTE CED ON (CED.ID_CEDENTE = TP.ID_CEDENTE) AND (CED.ID' +
        '_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (TP.DATA_EMISSAO BETWEEN :pDataInicial AND :pDataFinal) AN' +
        'D'
      '      (TP.IS_PROVISAO = 1) AND'
      '      (TP.ID_TIPO_STATUS = '#39'ABERTO'#39') AND'
      '      (TP.ID_LOTE_CONTABIL IS NULL) AND'
      '      (TP.DATA_PAGAMENTO IS NULL)'
      ''
      'GROUP BY TP.REGISTRO_PROVISAO'
      'ORDER BY DATA_EMISSAO ASC, TOTAL DESC;  '
      '')
    Left = 48
    Top = 44
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
      end>
  end
  object qryProvCR: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      
        'SELECT sum(tp.valor_nominal) as total,  max(tp.descricao) as des' +
        'cricao, tp.registro_provisao, max(tp.id_titulo_pagar) as idTitul' +
        'o,'
      '              max(TP.data_emissao)as dt_emissao,'
      '              max(TP.numero_documento) as num_doc,'
      '              max(CED.NOME) AS NOME_CED,'
      '              max(CCC.DESCRICAO) AS CCC_DSC,'
      '              max(CCC.CONTA)  AS CONTA_CR,'
      '              max(CCC.CODREDUZ)  AS COD_RED_CR'
      'FROM '
      ''
      'titulo_pagar tp'
      'join CEDENTE CED ON (CED.id_cedente = TP.id_cedente)'
      
        'JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = CED.ID_CONTA' +
        '_CONTABIL)'
      ''
      'WHERE'
      '      (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TP.REGISTRO_PROVISAO = :PREGISTRO)'
      ''
      'GROUP BY TP.REGISTRO_PROVISAO')
    Left = 40
    Top = 180
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PREGISTRO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dsObterCreditos: TDataSource
    DataSet = qryTPPROVBASE
    OnDataChange = dsObterCreditosDataChange
    Left = 40
    Top = 112
  end
end
