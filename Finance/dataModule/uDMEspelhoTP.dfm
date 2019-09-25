object dmEspelhoTP: TdmEspelhoTP
  OldCreateOrder = False
  Height = 516
  Width = 1022
  object frxDBTitulos: TfrxDBDataset
    UserName = 'TPPROVBASE'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_CEDENTE=ID_CEDENTE'
      'ID_HISTORICO=ID_HISTORICO'
      'ID_CENTRO_CUSTO=ID_CENTRO_CUSTO'
      'ID_TIPO_STATUS=ID_TIPO_STATUS'
      'ID_TIPO_COBRANCA=ID_TIPO_COBRANCA'
      'ID_RESPONSAVEL=ID_RESPONSAVEL'
      'ID_LOCAL_PAGAMENTO=ID_LOCAL_PAGAMENTO'
      'ID_TITULO_GERADOR=ID_TITULO_GERADOR'
      'ID_LOTE_CONTABIL=ID_LOTE_CONTABIL'
      'ID_LOTE_PAGAMENTO=ID_LOTE_PAGAMENTO'
      'ID_USUARIO=ID_USUARIO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'DESCRICAO=DESCRICAO'
      'DATA_REGISTRO=DATA_REGISTRO'
      'DATA_EMISSAO=DATA_EMISSAO'
      'DATA_VENCIMENTO=DATA_VENCIMENTO'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'DATA_ULTIMA_ATUALIZACAO=DATA_ULTIMA_ATUALIZACAO'
      'PREVISAO_CARTORIO=PREVISAO_CARTORIO'
      'VALOR_NOMINAL=VALOR_NOMINAL'
      'VALOR_ANTECIPADO=VALOR_ANTECIPADO'
      'PARCELA=PARCELA'
      'OBSERVACAO=OBSERVACAO'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'ID_CONTA_CONTABIL_DEBITO=ID_CONTA_CONTABIL_DEBITO'
      'ID_CONTA_CONTABIL_CREDITO=ID_CONTA_CONTABIL_CREDITO'
      'ID_LOTE_TPB=ID_LOTE_TPB'
      'DSC_HIST=DSC_HIST'
      'COD_HIST=COD_HIST'
      'STATUS=STATUS'
      'CONTA_DB=CONTA_DB'
      'CODRED_DB=CODRED_DB'
      'CONTA_CR=CONTA_CR'
      'CODRED_CR=CODRED_CR'
      'RESPONSAVEL=RESPONSAVEL')
    DataSet = qryObterPorNumeroDocumento
    BCDToCurrency = False
    Left = 184
    Top = 40
  end
  object frxTPROVDB: TfrxDBDataset
    UserName = 'historicos'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_HISTORICO=ID_HISTORICO'
      'VALOR_TOTAL=VALOR_TOTAL'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'PARCELA=PARCELA'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'HST_DSC=HST_DSC'
      'HST_CODIGO=HST_CODIGO'
      'CCD_DSC=CCD_DSC'
      'CONTA_DB=CONTA_DB'
      'DG_CONTA_DB=DG_CONTA_DB'
      'COD_RED_DB=COD_RED_DB')
    DataSet = qryTPPROVDB
    BCDToCurrency = False
    Left = 184
    Top = 104
  end
  object frxTPPROVCR: TfrxDBDataset
    UserName = 'TPPROVCR'
    CloseDataSource = False
    FieldAliases.Strings = (
      'VALOR_TOTAL=VALOR_TOTAL'
      'CCC_DSC=CCC_DSC'
      'CONTA_CR=CONTA_CR'
      'COD_RED_CR=COD_RED_CR'
      'COD_HIST=COD_HIST'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'DESCRICAO=DESCRICAO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DT_EMISSAO=DT_EMISSAO'
      'NUM_DOC=NUM_DOC'
      'NOME_CED=NOME_CED')
    DataSet = qryTPPROVCR
    BCDToCurrency = False
    Left = 400
    Top = 280
  end
  object qryTPPROVCR: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT distinct sum(tp.valor_nominal) as valor_total,'
      '              max(CCC.DESCRICAO) AS CCC_DSC,'
      '              max(CCC.CONTA)  AS CONTA_CR,'
      '              max(CCC.CODREDUZ)  AS COD_RED_CR,'
      '              max(H.CODIGO) AS COD_HIST,'
      '              tp.registro_provisao, '
      '              max(tp.descricao) as descricao,               '
      '              max(tp.id_titulo_pagar) as ID_TITULO_PAGAR, '
      '              MAX(TP.ID_ORGANIZACAO) AS ID_ORGANIZACAO,'
      '              max(TP.data_emissao)as dt_emissao,'
      '              max(TP.numero_documento) as num_doc,'
      '              max(CED.NOME) AS NOME_CED'
      ''
      'FROM '
      'TITULO_PAGAR TP'
      'INNER join CEDENTE CED ON (CED.id_cedente = TP.id_cedente)'
      
        'INNER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = TP.ID_' +
        'CONTA_CONTABIL_CREDITO) AND (CCC.ID_ORGANIZACAO = TP.ID_ORGANIZA' +
        'CAO)'
      
        'INNER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO) AND' +
        ' (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE    (TP.ID_TITULO_PAGAR = :PIDTITULOPAGAR) AND'
      '         (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      ''
      ''
      'GROUP BY TP.REGISTRO_PROVISAO')
    Left = 408
    Top = 216
    ParamData = <
      item
        Name = 'PIDTITULOPAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPPROVDB: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.DefaultParamDataType = ftString
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT        TPH.id_historico,'
      '              TPH.valor AS VALOR_TOTAL,'
      '              Tp.registro_provisao AS REGISTRO_PROVISAO,'
      '              TP.PARCELA AS PARCELA,'
      '              tp.numero_documento,'
      '              tp.id_organizacao AS ID_ORGANIZACAO,'
      '              tp.id_titulo_pagar AS ID_TITULO_PAGAR,'
      '              H.descricao AS HST_DSC,'
      '              H.CODIGO AS HST_CODIGO,'
      '              CCD.DESCRICAO AS CCD_DSC,'
      '              CCD.CONTA  AS CONTA_DB,'
      '              CCD.DGVER  AS DG_CONTA_DB,'
      '              CCD.CODREDUZ  AS COD_RED_DB'
      ''
      ''
      'FROM  TITULO_PAGAR_HISTORICO TPH'
      
        'LEFT OUTER JOIN titulo_pagar TP ON (TP.ID_TITULO_PAGAR = TPH.ID_' +
        'TITULO_PAGAR)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TPH.ID_HISTORIC' +
        'O) AND (H.ID_ORGANIZACAO = TPH.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = H' +
        '.ID_CONTA_CONTABIL)'
      ''
      'WHERE    (TPH.ID_TITULO_PAGAR = :PIDTITULOPAGAR) AND'
      '         (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO)')
    Left = 32
    Top = 104
    ParamData = <
      item
        Name = 'PIDTITULOPAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dsDetalhesTP: TDataSource
    DataSet = qryObterPorNumeroDocumento
    OnDataChange = dsDetalhesTPDataChange
    Left = 104
    Top = 112
  end
  object frxDBTPQuitados: TfrxDBDataset
    UserName = 'TPQUITADOS'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'DATA_EMISSAO=DATA_EMISSAO'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'DESCRICAO=DESCRICAO'
      'PARCELA=PARCELA'
      'VALOR=VALOR'
      'NOME=NOME'
      'DSC_HIST=DSC_HIST'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'TIPO=TIPO')
    DataSet = qryTPQuitados
    BCDToCurrency = False
    Left = 400
    Top = 160
  end
  object frxDBTPBCaixa: TfrxDBDataset
    UserName = 'TPBCaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TESOURARIA_DEBITO=ID_TESOURARIA_DEBITO'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'VALOR=VALOR'
      'OBSERVACAO=OBSERVACAO'
      'DESCRICAO=DESCRICAO'
      'ID_HISTORICO=ID_HISTORICO'
      'DSC_HIST=DSC_HIST'
      'HST_COD=HST_COD'
      'CONTA_CREDITO=CONTA_CREDITO'
      'DSC_CC=DSC_CC'
      'CODREDUZ=CODREDUZ')
    DataSet = qryBaixaTPCaixa
    BCDToCurrency = False
    Left = 926
    Top = 160
  end
  object frxTPBAcrescimo: TfrxDBDataset
    UserName = 'TPBAcrescimo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'ID_HISTORICO=ID_HISTORICO'
      'DSC_HIST=DSC_HIST'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'CODIGO=CODIGO'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ')
    DataSet = qryTPBAcrescimos
    BCDToCurrency = False
    Left = 595
    Top = 160
  end
  object frxTPBDeducao: TfrxDBDataset
    UserName = 'TPBDeducao'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'ID_HISTORICO=ID_HISTORICO'
      'DSC_HIST=DSC_HIST'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'CODIGO=CODIGO'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ')
    DataSet = qryTPBDeducao
    BCDToCurrency = False
    Left = 710
    Top = 160
  end
  object frxDBTPB: TfrxDBDataset
    UserName = 'TPBaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'ID_CENTRO_CUSTO=ID_CENTRO_CUSTO'
      'VALOR_PAGO=VALOR_PAGO'
      'TIPO_BAIXA=TIPO_BAIXA'
      'DATA_EMISSAO=DATA_EMISSAO'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'DESCRICAO=DESCRICAO'
      'PARCELA=PARCELA'
      'VALOR=VALOR'
      'NOME=NOME'
      'HST_COD=HST_COD'
      'DSC_HIST=DSC_HIST'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'DSC_CDD=DSC_CDD'
      'CONTA_DB=CONTA_DB'
      'COD_REDUZ_DB=COD_REDUZ_DB'
      'TIPO=TIPO')
    DataSet = qryObterTPBaixaPorTitulo
    BCDToCurrency = False
    Left = 496
    Top = 160
  end
  object frxTPBCheque: TfrxDBDataset
    UserName = 'TPBCheque'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA_CHEQUE=ID_TITULO_PAGAR_BAIXA_CHEQUE'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_CONTA_BANCARIA_CHEQUE=ID_CONTA_BANCARIA_CHEQUE'
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'VALOR=VALOR'
      'CONTA_CONTABIL_CREDITO=CONTA_CONTABIL_CREDITO'
      'COD_REDUZ_CREDITO=COD_REDUZ_CREDITO'
      'DSC_CC_CREDITO=DSC_CC_CREDITO')
    DataSet = qryBaixaTPCheque
    BCDToCurrency = False
    Left = 918
    Top = 232
  end
  object qryTPQuitados: TFDQuery
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
      '       TP.VALOR_NOMINAL as VALOR,'
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
      'WHERE (TP.ID_ORGANIZACAO = :pIdOrganizacao) '
      
        '       AND (TP.DATA_PAGAMENTO BETWEEN :pDataInicial AND :pDataFi' +
        'nal) '
      '       AND (TP.ID_TIPO_STATUS = :pIdStatus )'
      '       AND (TP.ID_LOTE_CONTABIL IS NULL) '
      ''
      'ORDER BY TP.DATA_PAGAMENTO ASC, TP.VALOR_NOMINAL DESC;')
    Left = 400
    Top = 56
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
  object dsDetalhesTPB: TDataSource
    DataSet = qryTPQuitados
    Left = 552
    Top = 120
  end
  object qryObterTPBaixaPorTitulo: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM//YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      '--somente titulos que nao foram provisionados'
      ''
      'SELECT TPB.id_organizacao,'
      '       TPB.id_titulo_pagar_baixa,'
      '       TPB.id_titulo_pagar,'
      '       TPB.id_centro_custo,'
      '       TPB.valor_pago,'
      '       TPB.tipo_baixa,'
      '       TP.DATA_EMISSAO,'
      '       TP.DATA_PAGAMENTO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DESCRICAO,'
      '       TP.PARCELA,'
      '       TP.VALOR_NOMINAL as VALOR,'
      '       C.NOME,'
      '       H.CODIGO AS HST_COD,       '
      '       H.DESCRICAO as dsc_hist, H.DESCRICAO_REDUZIDA,'
      '       CCD.DESCRICAO AS DSC_CDD,'
      '       CCD.CONTA AS CONTA_DB,'
      '       CCD.CODREDUZ AS COD_REDUZ_DB,'
      '       '#39'TPB'#39' as TIPO'
      ''
      'FROM TITULO_PAGAR_BAIXA TPB'
      ''
      
        'LEFT OUTER JOIN titulo_pagar TP ON (TP.ID_TITULO_PAGAR = TPB.ID_' +
        'TITULO_PAGAR)'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = H' +
        '.ID_CONTA_CONTABIL) AND (CCD.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TPB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TPB.id_titulo_pagar =:pIdtituloPagar) AND'
      '      (TPB.ID_LOTE_CONTABIL IS NULL)'
      '-- AND (TP.IS_PROVISAO = 0)'
      '  '
      ''
      ''
      'ORDER BY TP.DATA_PAGAMENTO ASC, TP.VALOR_NOMINAL DESC;')
    Left = 504
    Top = 56
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
  object qryBaixaTPCaixa: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      ' SELECT td.ID_TITULO_PAGAR_BAIXA,'
      '          td.id_organizacao,'
      '          td.id_tesouraria_debito, '
      '          td.data_movimento, '
      '          td.valor_nominal as VALOR,'
      '          td.observacao, '
      '          td.descricao, '
      '          h.id_historico,'
      '          h.descricao as DSC_HIST,'
      '          H.CODIGO AS HST_COD,'
      '          cc.conta as CONTA_CREDITO, '
      '          cc.descricao as DSC_CC,'
      '          cc.codreduz'
      '   FROM TESOURARIA_DEBITO TD'
      
        '   left outer join historico h on (h.id_historico = td.id_histor' +
        'ico) and (h.id_organizacao = td.id_organizacao)'
      
        '   left outer join conta_contabil cc on (cc.id_conta_contabil = ' +
        'H.id_conta_contabil) and (cc.id_organizacao = td.id_organizacao)'
      ''
      ' WHERE (TD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '         (TD.id_titulo_pagar_baixa = :PIDTITULOPAGARBAIXA)')
    Left = 912
    Top = 56
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
  object qryBaixaTPCheque: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT  TPBC.ID_TITULO_PAGAR_BAIXA_CHEQUE,'
      '        TPBC.ID_ORGANIZACAO,'
      '        TPBC.ID_CONTA_BANCARIA_CHEQUE,'
      '        TPBC.ID_TITULO_PAGAR_BAIXA,'
      '        TPBC.VALOR as VALOR,'
      '        CC.CONTA AS CONTA_CONTABIL_CREDITO,'
      '        CC.CODREDUZ AS COD_REDUZ_CREDITO,'
      '        CC.DESCRICAO AS DSC_CC_CREDITO'
      ''
      ''
      'FROM TITULO_PAGAR_BAIXA_CHEQUE TPBC'
      
        'LEFT OUTER JOIN conta_bancaria_cheque CBC ON (CBC.ID_CONTA_BANCA' +
        'RIA_CHEQUE = TPBC.ID_CONTA_BANCARIA_CHEQUE)AND (CBC.ID_ORGANIZAC' +
        'AO = TPBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = CBC' +
        '.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = TPBC.ID_ORGANIZACAO' +
        ')'
      
        'LEFT OUTER JOIN conta_contabil CC ON (CC.id_conta_contabil = CB.' +
        'id_conta_contabil) AND (CC.ID_ORGANIZACAO = TPBC.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBC.id_organizacao = :PIDORGANIZACAO) AND'
      '       (TPBC.ID_TITULO_PAGAR_BAIXA = :PIDTITULOPAGARBAIXA)AND'
      '       (CBC.data_compensacao is null)')
    Left = 974
    Top = 48
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
  object qryTPBAcrescimos: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TPBA.id_titulo_pagar_baixa, '
      '       TPBA.valor as VALOR, '
      '       TA.descricao,'
      '       TA.id_historico, '
      '       H.descricao as dsc_hist, '
      '       H.id_conta_contabil,'
      '       H.Codigo,'
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
    Left = 616
    Top = 56
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
  object qryTPBDeducao: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    SQL.Strings = (
      'SELECT TPBD.id_titulo_pagar_baixa, '
      '       TPBD.valor as VALOR, '
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
      'ORDER BY TPBD.VALOR DESC')
    Left = 712
    Top = 56
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
  object qryTPBHistorico: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.DefaultParamDataType = ftString
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TPH.id_titulo_pagar_historico,'
      '       TPH.id_organizacao,'
      '       TPH.id_historico,'
      '       TPH.id_titulo_pagar,'
      '       TPH.id_conta_contabil_debito,'
      '       TPH.valor,'
      '       H.DESCRICAO AS HST_DSC,'
      '       H.DESCRICAO_REDUZIDA AS HST_DSC_RED,'
      '       H.CODIGO AS HST_COD,'
      '       CD.conta AS CONTA_DB,'
      '       CD.DESCRICAO AS DSC_CONTA_DB,'
      '       CD.codreduz AS COD_RED_DB'
      ''
      'FROM TITULO_PAGAR_HISTORICO TPH'
      ''
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TPH.ID_HISTORIC' +
        'O) AND (H.ID_ORGANIZACAO = TPH.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_contabil CD ON (CD.id_conta_contabil = H.i' +
        'd_conta_contabil) and (CD.ID_ORGANIZACAO = TPH.ID_ORGANIZACAO)'
      ''
      'WHERE  (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) AND '
      '       (TPH.id_titulo_pagar = :PIDTP)'
      ''
      'ORDER BY TPH.VALOR')
    Left = 820
    Top = 56
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTP'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object frxTPBHistorico: TfrxDBDataset
    UserName = 'TPBHistorico'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_HISTORICO=ID_TITULO_PAGAR_HISTORICO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_HISTORICO=ID_HISTORICO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'ID_CONTA_CONTABIL_DEBITO=ID_CONTA_CONTABIL_DEBITO'
      'VALOR=VALOR'
      'HST_DSC=HST_DSC'
      'HST_DSC_RED=HST_DSC_RED'
      'HST_COD=HST_COD'
      'CONTA_DB=CONTA_DB'
      'DSC_CONTA_DB=DSC_CONTA_DB'
      'COD_RED_DB=COD_RED_DB')
    DataSet = qryTPBHistorico
    BCDToCurrency = False
    Left = 824
    Top = 160
  end
  object frxEspelhoTP: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 43733.843168553240000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 96
    Top = 360
    Datasets = <
      item
        DataSet = frxCedente
        DataSetName = 'cedente'
      end
      item
        DataSet = frxCentroCustos
        DataSetName = 'CentroCustos'
      end
      item
        DataSet = frxTPROVDB
        DataSetName = 'historicos'
      end
      item
        DataSet = frxDBTitulos
        DataSetName = 'TPPROVBASE'
      end>
    Variables = <
      item
        Name = ' Pempec'
        Value = Null
      end
      item
        Name = 'strRazaoSocial'
        Value = Null
      end
      item
        Name = 'strCNPJ'
        Value = Null
      end
      item
        Name = 'strEndereco'
        Value = Null
      end
      item
        Name = 'strCEP'
        Value = Null
      end
      item
        Name = 'strCidade'
        Value = Null
      end
      item
        Name = 'strUF'
        Value = Null
      end
      item
        Name = 'strTipoStatus'
        Value = Null
      end
      item
        Name = 'strTipo'
        Value = Null
      end
      item
        Name = 'cc_perc'
        Value = Null
      end
      item
        Name = 'strPeriodo'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 220.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      PrintOnPreviousPage = True
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 86.929155830000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 5.338590000000000000
          Width = 109.606370000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Organiza'#231#227'o: ')
          ParentFont = False
        end
        object strRazaoSocial1: TfrxMemoView
          Left = 117.283550000000000000
          Top = 5.338590000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strRazaoSocial]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 353.220470000000000000
          Top = 5.338590000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
        object strCNPJ: TfrxMemoView
          Left = 420.764070000000000000
          Top = 1.559059999999999000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strCNPJ]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 30.015770000000010000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object strEndereco: TfrxMemoView
          Left = 117.283550000000000000
          Top = 30.015770000000010000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strEndereco]')
          ParentFont = False
        end
        object strCEP: TfrxMemoView
          Left = 420.764070000000000000
          Top = 30.015770000000010000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strCEP]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 353.220470000000000000
          Top = 30.015770000000010000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CEP  :')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 510.236550000000000000
          Top = 30.015770000000010000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CIDADE/UF:')
          ParentFont = False
        end
        object strCidade: TfrxMemoView
          Left = 619.842920000000000000
          Top = 33.795300000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strCidade]/[strUF]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Page: TfrxMemoView
          Left = 680.315400000000000000
          Top = 1.559059999999999000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo15: TfrxMemoView
          Left = 619.842920000000000000
          Top = 1.559059999999999000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'P'#193'G.')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 5.102350000000000000
          Top = 54.031540000000010000
          Width = 737.008350000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'ESPELHO T'#205'TULO '#192' PAGAR')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 68.031496060000000000
        Top = 857.953310000000000000
        Width = 755.906000000000000000
        object Line2: TfrxLineView
          Top = 3.000000000000000000
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 7.000000000000000000
        end
      end
      object Memo41: TfrxMemoView
        Left = 7.559060000000000000
        Top = -7.559060000000000000
        Width = 49.133890000000000000
        Height = 15.118120000000000000
        DataSet = frmCTPHistorico.frxDBTitulosPorCedente
        DataSetName = 'Titulos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 3.779527560000000000
        Top = 166.299320000000000000
        Width = 755.906000000000000000
        Condition = 'TPPROVBASE."ID_TITULO_PAGAR"'
        object Line3: TfrxLineView
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 948.662030000000000000
        Width = 755.906000000000000000
        object Memo36: TfrxMemoView
          Left = -1.220470000000000000
          Top = 2.000000000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pempec Enterprise Finance')
          ParentFont = False
          VAlign = vaBottom
        end
        object Date: TfrxMemoView
          Left = 648.441250000000000000
          Top = 2.000000000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo79: TfrxMemoView
          Left = 575.086890000000000000
          Top = 2.000000000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Emitido em:  ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Time: TfrxMemoView
          Left = 706.488560000000000000
          Top = 2.000000000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object Titulo: TfrxMasterData
        FillType = ftBrush
        Height = 113.385900000000000000
        Top = 192.756030000000000000
        Width = 755.906000000000000000
        DataSet = frxDBTitulos
        DataSetName = 'TPPROVBASE'
        RowCount = 0
        object Memo10: TfrxMemoView
          Left = 100.165430000000000000
          Top = 26.456709999999990000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          DataField = 'NUMERO_DOCUMENTO'
          DataSet = frxDBTitulos
          DataSetName = 'TPPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TPPROVBASE."NUMERO_DOCUMENTO"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 336.732530000000000000
          Top = 26.456709999999990000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'DATA_VENCIMENTO'
          DataSet = frxDBTitulos
          DataSetName = 'TPPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[TPPROVBASE."DATA_VENCIMENTO"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Width = 755.905511810000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          HAlign = haCenter
          Memo.UTF8W = (
            'Informa'#231#245'es b'#225'sicas')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 3.779530000000000000
          Top = 26.456709999999990000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO ')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 291.023810000000000000
          Top = 26.456709999999990000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VCTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo12: TfrxMemoView
          Left = 491.016080000000000000
          Top = 26.456709999999990000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'DATA_PAGAMENTO'
          DataSet = frxDBTitulos
          DataSetName = 'TPPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TPPROVBASE."DATA_PAGAMENTO"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 441.307360000000000000
          Top = 26.456709999999990000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PGTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo14: TfrxMemoView
          Left = 668.976321810000000000
          Top = 26.456709999999990000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'DATA_EMISSAO'
          DataSet = frxDBTitulos
          DataSetName = 'TPPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TPPROVBASE."DATA_EMISSAO"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 585.370440000000000000
          Top = 26.456709999999990000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMISS'#195'O')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo23: TfrxMemoView
          Left = 3.779530000000000000
          Top = 46.354360000000010000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O ')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 100.165430000000000000
          Top = 46.354360000000010000
          Width = 170.078850000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRICAO'
          DataSet = frxDBTitulos
          DataSetName = 'TPPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TPPROVBASE."DESCRICAO"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 441.307360000000000000
          Top = 46.354360000000010000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'HIST'#211'RICO ')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 540.472301810000000000
          Top = 46.354360000000010000
          Width = 215.433210000000000000
          Height = 15.118120000000000000
          DataField = 'DSC_HIST'
          DataSet = frxDBTitulos
          DataSetName = 'TPPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TPPROVBASE."DSC_HIST"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 3.779530000000000000
          Top = 64.252009999999990000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 100.165430000000000000
          Top = 64.252009999999990000
          Width = 170.078850000000000000
          Height = 15.118120000000000000
          DataField = 'STATUS'
          DataSet = frxDBTitulos
          DataSetName = 'TPPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[TPPROVBASE."STATUS"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 291.023810000000000000
          Top = 64.252009999999990000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataSet = frxDBTitulos
          DataSetName = 'TPPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PARCELA')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 371.173470000000000000
          Top = 64.252009999999990000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DataField = 'PARCELA'
          DataSet = frxDBTitulos
          DataSetName = 'TPPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TPPROVBASE."PARCELA"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 291.023810000000000000
          Top = 46.354360000000010000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataSet = frxDBTitulos
          DataSetName = 'TPPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 371.173470000000000000
          Top = 46.354360000000010000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DataField = 'COD_HIST'
          DataSet = frxDBTitulos
          DataSetName = 'TPPROVBASE'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TPPROVBASE."COD_HIST"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 441.307360000000000000
          Top = 64.252009999999990000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RESPONS'#193'VEL')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 548.031361810000000000
          Top = 64.252009999999990000
          Width = 207.874150000000000000
          Height = 15.118120000000000000
          DataField = 'RESPONSAVEL'
          DataSet = frxDBTitulos
          DataSetName = 'TPPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TPPROVBASE."RESPONSAVEL"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 441.307360000000000000
          Top = 84.708720000000030000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR ')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 555.590421809999900000
          Top = 84.708719999999970000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR_NOMINAL'
          DataSet = frxDBTitulos
          DataSetName = 'TPPROVBASE'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TPPROVBASE."VALOR_NOMINAL"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 3.779530000000000000
          Top = 84.708720000000030000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ANTECIPADO')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 100.165430000000000000
          Top = 84.708720000000030000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR_ANTECIPADO'
          DataSet = frxDBTitulos
          DataSetName = 'TPPROVBASE'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[TPPROVBASE."VALOR_ANTECIPADO"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 109.606370000000000000
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Fornecedor: TfrxDetailData
        FillType = ftBrush
        Height = 162.519790000000000000
        Top = 328.819110000000000000
        Width = 755.906000000000000000
        DataSet = frxCedente
        DataSetName = 'cedente'
        RowCount = 0
        object Memo34: TfrxMemoView
          Width = 755.905511810000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line4: TfrxLineView
          Top = 154.960730000000000000
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo39: TfrxMemoView
          Left = 3.779530000000000000
          Top = 25.456709999999990000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO ')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 67.811070000000000000
          Top = 25.456709999999990000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'CODIGO'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."CODIGO"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 313.700990000000000000
          Top = 25.456709999999990000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CPF/CNPJ')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 376.512060000000000000
          Top = 25.456709999999990000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          DataField = 'CPFCNPJ'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."CPFCNPJ"]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 158.740260000000000000
          Top = 25.456709999999990000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PERSONALIDADE')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 271.905690000000000000
          Top = 25.456709999999990000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DataField = 'PERSONALIDADE'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."PERSONALIDADE"]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 610.165740000000000000
          Top = 25.456709999999990000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 668.976321810000000000
          Top = 25.456709999999990000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'STATUS'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[cedente."STATUS"]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 495.661720000000000000
          Top = 25.456709999999990000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CGA')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 539.913730000000000000
          Top = 25.456709999999990000
          Width = 68.031540000000010000
          Height = 15.118120000000000000
          DataField = 'CGA'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."CGA"]')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 3.779530000000000000
          Top = 46.133890000000010000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOME')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 68.031540000000000000
          Top = 46.133890000000010000
          Width = 241.889920000000000000
          Height = 15.118120000000000000
          DataField = 'NOME'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."NOME"]')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 313.700990000000000000
          Top = 46.133890000000010000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'INSC. ESTADUAL')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 429.425480000000000000
          Top = 46.133890000000010000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataField = 'INSCRICAO_ESTADUAL'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."INSCRICAO_ESTADUAL"]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 533.693260000000000000
          Top = 46.133890000000010000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'INSC. MUNICIPAL')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 649.858690000000000000
          Top = 46.133890000000010000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataField = 'INSCRICAO_MUNICIPAL'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."INSCRICAO_MUNICIPAL"]')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 3.779530000000000000
          Top = 65.031540000000010000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TIPO')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 68.031540000000000000
          Top = 65.031540000000010000
          Width = 241.889920000000000000
          Height = 15.118120000000000000
          DataField = 'TIPO'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."TIPO"]')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 313.700990000000000000
          Top = 65.031540000000010000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CONTA CONT'#193'BIL')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 429.425480000000000000
          Top = 65.031540000000010000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataField = 'CONTA'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."CONTA"]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 505.016080000000000000
          Top = 65.031540000000010000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          DataField = 'DSC_CONTA'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."DSC_CONTA"]')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 706.551640000000000000
          Top = 64.252009999999990000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DataField = 'CODRED_CONTA'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[cedente."CODRED_CONTA"]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 3.779530000000000000
          Top = 86.708720000000030000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ENDERE'#199'O ')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 83.149660000000000000
          Top = 86.708720000000030000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DataField = 'LOGRADOURO'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."LOGRADOURO"]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 249.448980000000000000
          Top = 86.708720000000030000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DataField = 'COMPLEMENTO'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."COMPLEMENTO"]')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          Left = 415.748300000000000000
          Top = 86.708720000000030000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DataField = 'NUMERO'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."NUMERO"]')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 468.661720000000000000
          Top = 86.708720000000030000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'CEP'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[cedente."CEP"]')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Left = 249.448980000000000000
          Top = 102.047310000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DataField = 'CIDADE'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."CIDADE"]')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 83.149660000000000000
          Top = 102.047310000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DataField = 'BAIRRO'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."BAIRRO"]')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 468.661720000000000000
          Top = 102.047310000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'ID_ESTADO'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[cedente."ID_ESTADO"]')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 3.779530000000000000
          Top = 125.504020000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CONTATOS')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 83.149660000000000000
          Top = 125.504020000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DataField = 'TELEFONE'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."TELEFONE"]')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 253.228510000000000000
          Top = 125.504020000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DataField = 'CELULAR'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."CELULAR"]')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 551.590910000000000000
          Top = 125.504020000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'EMAIL'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[cedente."EMAIL"]')
          ParentFont = False
        end
        object Memo80: TfrxMemoView
          Left = 6.779530000000000000
          Top = 4.000000000000000000
          Width = 744.567410000000000000
          Height = 15.118120000000000000
          DataField = 'TIPO'
          DataSet = frxCedente
          DataSetName = 'cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsItalic]
          Fill.BackColor = clScrollBar
          HAlign = haCenter
          Memo.UTF8W = (
            '[cedente."TIPO"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object RateioHistorico: TfrxDetailData
        FillType = ftBrush
        Height = 22.677165350000000000
        Top = 559.370440000000000000
        Width = 755.906000000000000000
        DataSet = frxTPROVDB
        DataSetName = 'historicos'
        RowCount = 0
        object Memo61: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.000000000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DataField = 'HST_CODIGO'
          DataSet = frxTPROVDB
          DataSetName = 'historicos'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[historicos."HST_CODIGO"]')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 41.574830000000000000
          Top = 1.000000000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          DataField = 'HST_DSC'
          DataSet = frxTPROVDB
          DataSetName = 'historicos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[historicos."HST_DSC"]')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 298.582870000000000000
          Top = 1.000000000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataField = 'CONTA_DB'
          DataSet = frxTPROVDB
          DataSetName = 'historicos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[historicos."CONTA_DB"]')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Left = 396.850650000000000000
          Top = 1.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataField = 'COD_RED_DB'
          DataSet = frxTPROVDB
          DataSetName = 'historicos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[historicos."COD_RED_DB"]')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Left = 555.590421809999900000
          Top = 1.000000000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR_TOTAL'
          DataSet = frxTPROVDB
          DataSetName = 'historicos'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[historicos."VALOR_TOTAL"]')
          ParentFont = False
        end
      end
      object RateioCustos: TfrxDetailData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Times New Roman'
        Font.Style = []
        Height = 22.677165354330710000
        ParentFont = False
        Top = 650.079160000000000000
        Width = 755.906000000000000000
        DataSet = frxCentroCustos
        DataSetName = 'CentroCustos'
        RowCount = 0
        object Memo81: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.377952759999971000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataField = 'CODIGO'
          DataSet = frxCentroCustos
          DataSetName = 'CentroCustos'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[CentroCustos."CODIGO"]')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Left = 298.582870000000000000
          Top = 0.377952759999971000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          DataField = 'CENTRO_CST'
          DataSet = frxCentroCustos
          DataSetName = 'CentroCustos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[CentroCustos."CENTRO_CST"]')
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          Left = 555.590421809999900000
          Top = 0.377952759999971000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = frxCentroCustos
          DataSetName = 'CentroCustos'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[CentroCustos."VALOR"]')
          ParentFont = False
        end
      end
      object DetailData3: TfrxDetailData
        FillType = ftBrush
        Height = 102.047310000000000000
        Top = 695.433520000000000000
        Width = 755.906000000000000000
        DataSet = frxDBTitulos
        DataSetName = 'TPPROVBASE'
        RowCount = 0
        object Line6: TfrxLineView
          Top = 52.913419999999970000
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo38: TfrxMemoView
          Width = 755.905511810000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Informa'#231#245'es do Pagamento')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line7: TfrxLineView
          Top = 98.267780000000010000
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Memo16: TfrxMemoView
        Left = 813.819420000000000000
        Top = 260.787570000000000000
        Width = 151.181200000000000000
        Height = 11.338590000000000000
        DataField = 'VALOR_NOMINAL'
        DataSet = frxDBTitulos
        DataSetName = 'TPPROVBASE'
        DisplayFormat.FormatStr = '%2.2n'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haRight
        Memo.UTF8W = (
          '[TPPROVBASE."VALOR_NOMINAL"]')
        ParentFont = False
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 514.016080000000000000
        Width = 755.906000000000000000
        Condition = '1=1'
        object Memo35: TfrxMemoView
          Width = 755.905511810000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          HAlign = haCenter
          Memo.UTF8W = (
            'Rateio Cont'#225'bil')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 604.724800000000000000
        Width = 755.906000000000000000
        Condition = '1=1'
        object Memo37: TfrxMemoView
          Width = 755.905511810000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          HAlign = haCenter
          Memo.UTF8W = (
            'Rateio por Centros de Custos')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Line5: TfrxLineView
        Top = 590.606680000000000000
        Width = 755.905511810000000000
        Color = clBlack
        Frame.Typ = [ftTop]
      end
    end
  end
  object qryObterTPBBanco: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TPBI.ID_TITULO_PAGAR_BAIXA,'
      '       TPBI.ID_ORGANIZACAO,'
      '       TPBI.VALOR as VALOR,'
      '       TPBI.id_conta_bancaria,'
      '       CC.conta AS CONTA_CR,'
      '       CC.DESCRICAO AS DSC_CONTA_CR,'
      '       CC.codreduz AS COD_RED_CR'
      '        '
      'FROM TITULO_PAGAR_BAIXA_INTERNET TPBI'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = TPB' +
        'I.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = TPBI.ID_ORGANIZACA' +
        'O)'
      
        'LEFT OUTER JOIN conta_contabil CC ON (CC.id_conta_contabil = CB.' +
        'id_conta_contabil) AND (CC.ID_ORGANIZACAO = TPBI.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBI.ID_ORGANIZACAO = :PIDORGANIZACAO )AND'
      '      (TPBI.ID_TITULO_PAGAR_BAIXA = :PIDTPB)'
      ''
      'ORDER BY TPBI.VALOR;')
    Left = 878
    Top = 120
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTPB'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryCedente: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT C.ID_CEDENTE,'
      '       C.ID_ORGANIZACAO,'
      '       C.ID_CONTA_CONTABIL,'
      '       C.ID_TIPO_CEDENTE,'
      '       C.ID_ENDERECO,'
      '       C.ID_CONTATO,'
      '       C.NOME,'
      '       C.PERSONALIDADE,'
      '       C.CPFCNPJ,'
      '       C.CGA,'
      '       C.INSCRICAO_ESTADUAL,'
      '       C.INSCRICAO_MUNICIPAL,'
      '       C.STATUS,'
      '       C.CODIGO,'
      '       C.DATA_ULTIMA_ATUALIZACAO,'
      '       TC.DESCRICAO AS tipo,'
      '       CT.TELEFONE,'
      '       CT.CELULAR,'
      '       CT.EMAIL,'
      '       E.ID_ESTADO,'
      '       E.LOGRADOURO,'
      '       E.COMPLEMENTO,'
      '       E.NUMERO,'
      '       E.CEP,'
      '       B.BAIRRO,'
      '       CID.CIDADE,'
      '       CC.CONTA AS CONTA,'
      '       CC.DESCRICAO AS DSC_CONTA,'
      '       CC.CODREDUZ AS CODRED_CONTA '
      ''
      ''
      'FROM CEDENTE C'
      
        'LEFT OUTER JOIN TIPO_CEDENTE TC   ON (TC.ID_TIPO_CEDENTE = C.ID_' +
        'TIPO_CEDENTE) AND (TC.ID_ORGANIZACAO = C.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTATO CT        ON (CT.id_contato = C.ID_CONTA' +
        'TO) AND  (CT.ID_ORGANIZACAO =  C.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN ENDERECO E        ON (E.ID_ENDERECO = C.ID_ENDER' +
        'ECO) AND (E.ID_ORGANIZACAO =  C.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = C.I' +
        'D_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO =  C.ID_ORGANIZACAO)'
      'LEFT OUTER JOIN BAIRRO   B        ON (B.ID_BAIRRO = E.ID_BAIRRO)'
      
        'LEFT OUTER JOIN CIDADE   CID      ON (CID.ID_CIDADE = E.ID_CIDAD' +
        'E)'
      ''
      'WHERE (C.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (C.ID_CEDENTE = :PIDCEDENTE)')
    Left = 104
    Top = 296
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCEDENTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterPorNumeroDocumento: TFDQuery
    Active = True
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TP.ID_TITULO_PAGAR,'
      '       TP.ID_ORGANIZACAO,'
      '       TP.ID_CEDENTE,'
      '       TP.ID_HISTORICO,'
      '       TP.ID_CENTRO_CUSTO,'
      '       TP.ID_TIPO_STATUS,'
      '       TP.ID_TIPO_COBRANCA,'
      '       TP.ID_RESPONSAVEL,'
      '       TP.ID_LOCAL_PAGAMENTO,'
      '       TP.ID_TITULO_GERADOR,'
      '       TP.ID_LOTE_CONTABIL,'
      '       TP.ID_LOTE_PAGAMENTO,'
      '       TP.ID_USUARIO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DESCRICAO,'
      '       TP.DATA_REGISTRO,'
      '       TP.DATA_EMISSAO,'
      '       TP.DATA_VENCIMENTO,'
      '       TP.DATA_PAGAMENTO,'
      '       TP.DATA_ULTIMA_ATUALIZACAO,'
      '       TP.PREVISAO_CARTORIO,'
      '       TP.VALOR_NOMINAL,'
      '       TP.VALOR_ANTECIPADO,'
      '       TP.PARCELA,'
      '       TP.OBSERVACAO,'
      '       TP.REGISTRO_PROVISAO,'
      '       TP.ID_CONTA_CONTABIL_DEBITO,'
      '       TP.ID_CONTA_CONTABIL_CREDITO,'
      '       TP.ID_LOTE_TPB,'
      '       H.DESCRICAO AS DSC_HIST,'
      '       H.CODIGO AS COD_HIST,'
      '       TS.DESCRICAO AS STATUS,'
      '       CCD.CONTA AS CONTA_DB,'
      '       CCD.CODREDUZ AS CODRED_DB,'
      '       CCC.CONTA AS CONTA_CR,'
      '       CCC.CODREDUZ AS CODRED_CR,'
      '       F.NOME AS RESPONSAVEL'
      ''
      ''
      ''
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN FUNCIONARIO F ON (F.ID_FUNCIONARIO = TP.ID_RESPO' +
        'NSAVEL) AND (F.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN TIPO_STATUS TS ON (TS.ID_TIPO_STATUS = TP.ID_TIP' +
        'O_STATUS) AND (TS.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON   (H.ID_HISTORICO = TP.ID_HISTORI' +
        'CO)  AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = T' +
        'P.ID_CONTA_CONTABIL_DEBITO) AND (CCD.ID_ORGANIZACAO = TP.ID_ORGA' +
        'NIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = T' +
        'P.ID_CONTA_CONTABIL_CREDITO) AND (CCC.ID_ORGANIZACAO = TP.ID_ORG' +
        'ANIZACAO)'
      ''
      'WHERE (TP.numero_documento = :PNUMDOC) AND'
      '      (TP.ID_ORGANIZACAO   = :PIDORGANIZACAO);'
      '')
    Left = 56
    Top = 32
    ParamData = <
      item
        Name = 'PNUMDOC'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object frxCedente: TfrxDBDataset
    UserName = 'cedente'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CEDENTE=ID_CEDENTE'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'ID_TIPO_CEDENTE=ID_TIPO_CEDENTE'
      'ID_ENDERECO=ID_ENDERECO'
      'ID_CONTATO=ID_CONTATO'
      'NOME=NOME'
      'PERSONALIDADE=PERSONALIDADE'
      'CPFCNPJ=CPFCNPJ'
      'CGA=CGA'
      'INSCRICAO_ESTADUAL=INSCRICAO_ESTADUAL'
      'INSCRICAO_MUNICIPAL=INSCRICAO_MUNICIPAL'
      'STATUS=STATUS'
      'CODIGO=CODIGO'
      'DATA_ULTIMA_ATUALIZACAO=DATA_ULTIMA_ATUALIZACAO'
      'TIPO=TIPO'
      'TELEFONE=TELEFONE'
      'CELULAR=CELULAR'
      'EMAIL=EMAIL'
      'ID_ESTADO=ID_ESTADO'
      'LOGRADOURO=LOGRADOURO'
      'COMPLEMENTO=COMPLEMENTO'
      'NUMERO=NUMERO'
      'CEP=CEP'
      'BAIRRO=BAIRRO'
      'CIDADE=CIDADE'
      'CONTA=CONTA'
      'DSC_CONTA=DSC_CONTA'
      'CODRED_CONTA=CODRED_CONTA')
    DataSet = qryCedente
    BCDToCurrency = False
    Left = 184
    Top = 296
  end
  object qryRateioCentroCustos: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT  TPC.ID_TITULO_PAGAR_RATEIO_CC,'
      '        TPC.ID_ORGANIZACAO,      '
      '        TPC.VALOR,       '
      '        TPC.ID_TITULO_PAGAR,'
      '        CC.DESCRICAO AS CENTRO_CST,'
      '        CC.CODIGO,'
      '        CC.SIGLA'
      '        '
      'FROM TITULO_PAGAR_RATEIO_CC TPC'
      
        'LEFT OUTER JOIN CENTRO_CUSTO CC ON (CC.ID_CENTRO_CUSTO = TPC.ID_' +
        'CENTRO_CUSTO) AND (CC.ID_ORGANIZACAO = TPC.ID_ORGANIZACAO)'
      ''
      'WHERE    (TPC.ID_TITULO_PAGAR = :PIDTITULOPAGAR) AND'
      '         (TPC.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      '')
    Left = 36
    Top = 168
    ParamData = <
      item
        Name = 'PIDTITULOPAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object frxCentroCustos: TfrxDBDataset
    UserName = 'CentroCustos'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_RATEIO_CC=ID_TITULO_PAGAR_RATEIO_CC'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'VALOR=VALOR'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'CENTRO_CST=CENTRO_CST'
      'CODIGO=CODIGO'
      'SIGLA=SIGLA')
    DataSet = qryRateioCentroCustos
    BCDToCurrency = False
    Left = 184
    Top = 176
  end
end
