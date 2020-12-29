object dmEspelhoTR: TdmEspelhoTR
  OldCreateOrder = False
  Height = 516
  Width = 1499
  object frxDBTitulos: TfrxDBDataset
    UserName = 'TRPROVBASE'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_SACADO=ID_SACADO'
      'ID_HISTORICO=ID_HISTORICO'
      'ID_CENTRO_CUSTO=ID_CENTRO_CUSTO'
      'ID_TIPO_STATUS=ID_TIPO_STATUS'
      'ID_TIPO_COBRANCA=ID_TIPO_COBRANCA'
      'ID_RESPONSAVEL=ID_RESPONSAVEL'
      'ID_LOCAL_PAGAMENTO=ID_LOCAL_PAGAMENTO'
      'ID_TITULO_GERADOR=ID_TITULO_GERADOR'
      'ID_LOTE_CONTABIL=ID_LOTE_CONTABIL'
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
      'ID_LOTE_TRB=ID_LOTE_TRB'
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
    Left = 264
    Top = 48
  end
  object frxTRROVDB: TfrxDBDataset
    UserName = 'historicos'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_HISTORICO=ID_HISTORICO'
      'VALOR_TOTAL=VALOR_TOTAL'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'PARCELA=PARCELA'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER'
      'HST_DSC=HST_DSC'
      'HST_CODIGO=HST_CODIGO'
      'CCD_DSC=CCD_DSC'
      'CONTA_DB=CONTA_DB'
      'DG_CONTA_DB=DG_CONTA_DB'
      'COD_RED_DB=COD_RED_DB')
    DataSet = qryTRPROVDB
    BCDToCurrency = False
    Left = 264
    Top = 104
  end
  object frxTRPROVCR: TfrxDBDataset
    UserName = 'TRPROVCR'
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
    DataSet = qryTRPROVCR
    BCDToCurrency = False
    Left = 1216
    Top = 384
  end
  object qryTRPROVCR: TFDQuery
    Connection = dmConexao.conn
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
      'WHERE    (TP.ID_TITULO_PAGAR = :PID) AND'
      '         (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      ''
      ''
      'GROUP BY TP.REGISTRO_PROVISAO')
    Left = 1392
    Top = 376
    ParamData = <
      item
        Name = 'PID'
        ParamType = ptInput
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTRPROVDB: TFDQuery
    Connection = dmConexao.conn
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
      '              tp.id_titulo_RECEBER AS ID_TITULO_RECEBER,'
      '              H.descricao AS HST_DSC,'
      '              H.CODIGO AS HST_CODIGO,'
      '              CCD.DESCRICAO AS CCD_DSC,'
      '              CCD.CONTA  AS CONTA_DB,'
      '              CCD.DGVER  AS DG_CONTA_DB,'
      '              CCD.CODREDUZ  AS COD_RED_DB'
      ''
      ''
      'FROM  TITULO_RECEBER_HISTORICO TPH'
      
        'LEFT OUTER JOIN titulo_RECEBER TP ON (TP.ID_TITULO_RECEBER = TPH' +
        '.ID_TITULO_RECEBER)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TPH.ID_HISTORIC' +
        'O) AND (H.ID_ORGANIZACAO = TPH.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = H' +
        '.ID_CONTA_CONTABIL)'
      ''
      'WHERE    (TPH.ID_TITULO_RECEBER = :PID) AND'
      '         (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO)')
    Left = 64
    Top = 104
    ParamData = <
      item
        Name = 'PID'
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
  object dsDetalhesTR: TDataSource
    DataSet = qryObterPorNumeroDocumento
    OnDataChange = dsDetalhesTRDataChange
    Left = 168
    Top = 248
  end
  object frxDBTRQuitados: TfrxDBDataset
    UserName = 'TRQUITADOS'
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
    DataSet = qryTRQuitados
    BCDToCurrency = False
    Left = 1224
    Top = 312
  end
  object frxDBTRBCaixa: TfrxDBDataset
    UserName = 'TRBCaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TESOURARIA_CREDITO=ID_TESOURARIA_CREDITO'
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
    DataSet = qryBaixaTRCaixa
    BCDToCurrency = False
    Left = 782
    Top = 136
  end
  object frxTRBAcrescimo: TfrxDBDataset
    UserName = 'TRBAcrescimo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'ID_HISTORICO=ID_HISTORICO'
      'DSC_HIST=DSC_HIST'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'CODIGO=CODIGO'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ')
    DataSet = qryTRBAcrescimos
    BCDToCurrency = False
    Left = 579
    Top = 136
  end
  object frxTRBDeducao: TfrxDBDataset
    UserName = 'TRBDeducao'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'ID_HISTORICO=ID_HISTORICO'
      'DSC_HIST=DSC_HIST'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'CODIGO=CODIGO'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ')
    DataSet = qryTRBDeducao
    BCDToCurrency = False
    Left = 686
    Top = 136
  end
  object frxDBTRB: TfrxDBDataset
    UserName = 'TRBaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER'
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
    DataSet = qryObterTRBaixaPorTitulo
    BCDToCurrency = False
    Left = 472
    Top = 136
  end
  object frxTRBCheque: TfrxDBDataset
    UserName = 'TRBCheque'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA_CHEQUE=ID_TITULO_RECEBER_BAIXA_CHEQUE'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'VALOR_BAIXA=VALOR_BAIXA'
      'CHEQUE=CHEQUE'
      'VALOR_CHEQUE=VALOR_CHEQUE')
    DataSet = qryBaixaTRCheque
    BCDToCurrency = False
    Left = 886
    Top = 136
  end
  object qryTRQuitados: TFDQuery
    Connection = dmConexao.conn
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
    Left = 1376
    Top = 312
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
  object qryObterTRBaixaPorTitulo: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TPB.id_organizacao,'
      '       TPB.id_titulo_RECEBER_baixa,'
      '       TPB.id_titulo_RECEBER,'
      '       TPB.id_centro_custo,'
      '      -- TPB.ID_LOTE_PAGAMENTO,'
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
      '       '#39'TRB'#39' as TIPO'
      ''
      'FROM TITULO_RECEBER_BAIXA TPB'
      ''
      
        'LEFT OUTER JOIN titulo_RECEBER TP ON (TP.ID_TITULO_RECEBER = TPB' +
        '.ID_TITULO_RECEBER)'
      
        'LEFT OUTER JOIN SACADO C ON  (C.ID_SACADO = TP.ID_SACADO) AND (C' +
        '.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = H' +
        '.ID_CONTA_CONTABIL) AND (CCD.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TPB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TPB.ID_TITULO_RECEBER = :PID)  ')
    Left = 464
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PID'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryBaixaTRCaixa: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ' SELECT td.ID_TITULO_RECEBER_BAIXA,'
      '          td.id_organizacao,'
      '          td.id_tesouraria_CREDITO, '
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
      '   FROM TESOURARIA_CREDITO TD'
      
        '   left outer join historico h on (h.id_historico = td.id_histor' +
        'ico) and (h.id_organizacao = td.id_organizacao)'
      
        '   left outer join conta_contabil cc on (cc.id_conta_contabil = ' +
        'H.id_conta_contabil) and (cc.id_organizacao = td.id_organizacao)'
      ''
      ' WHERE (TD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '         (TD.id_titulo_RECEBER_baixa = :PIDTRB)')
    Left = 784
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTRB'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryBaixaTRCheque: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT  TPBC.ID_TITULO_RECEBER_BAIXA_CHEQUE,'
      '        TPBC.ID_ORGANIZACAO,'
      '        TPBC.ID_TITULO_RECEBER_BAIXA,'
      '        TPBC.VALOR as VALOR_BAIXA,'
      '        --CC.CONTA AS CONTA_CONTABIL_CREDITO,'
      '       -- CC.CODREDUZ AS COD_REDUZ_CREDITO,'
      '       -- CC.DESCRICAO AS DSC_CC_CREDITO,'
      '        TPBC.NUMERO_CHEQUE AS CHEQUE,'
      '        TPBC.VALOR AS VALOR_CHEQUE'
      ''
      'FROM TITULO_RECEBER_BAIXA_CHEQUE TPBC'
      ''
      'WHERE (TPBC.id_organizacao = :PIDORGANIZACAO) AND'
      '       (TPBC.ID_TITULO_RECEBER_BAIXA = :PIDTRB)'
      '       ')
    Left = 886
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTRB'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTRBAcrescimos: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TPBA.id_titulo_RECEBER_baixa, '
      '       TPBA.valor as VALOR, '
      '       TA.descricao,'
      '       TA.id_historico, '
      '       H.descricao as dsc_hist, '
      '       H.id_conta_contabil,'
      '       H.Codigo,'
      '       CC.conta, CC.codreduz'
      'FROM titulo_RECEBER_baixa_ac TPBA'
      ''
      
        'JOIN tipo_acrescimo TA ON (TA.id_tipo_acrescimo = TPBA.id_tipo_a' +
        'crescimo) AND (TA.ID_ORGANIZACAO = TPBA.ID_ORGANIZACAO)'
      
        'JOIN HISTORICO H ON (H.id_historico = TA.id_historico) AND (H.ID' +
        '_ORGANIZACAO = TA.ID_ORGANIZACAO)'
      
        'JOIN conta_contabil CC ON (CC.id_conta_contabil = H.id_conta_con' +
        'tabil) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBA.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TPBA.id_titulo_RECEBER_baixa = :PIDTRB)'
      ''
      'order by TPBA.valor')
    Left = 584
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTRB'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTRBDeducao: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    SQL.Strings = (
      'SELECT TPBD.id_titulo_RECEBER_baixa, '
      '       TPBD.valor as VALOR, '
      '       TD.descricao,'
      '       TD.id_historico, '
      '       H.descricao as dsc_hist, '
      '       H.id_conta_contabil, '
      '       H.codigo,'
      '       CC.conta, '
      '       CC.codreduz'
      'FROM titulo_RECEBER_baixa_de TPBD'
      ''
      
        'JOIN tipo_deducao TD ON (TD.ID_TIPO_DEDUCAO = TPBD.ID_TIPO_DEDUC' +
        'AO) AND (TD.ID_ORGANIZACAO = TPBD.ID_ORGANIZACAO)'
      
        'JOIN HISTORICO H ON (H.id_historico = TD.id_historico) AND (H.ID' +
        '_ORGANIZACAO = TD.ID_ORGANIZACAO)'
      
        'JOIN conta_contabil CC ON (CC.id_conta_contabil = H.id_conta_con' +
        'tabil) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TPBD.id_titulo_RECEBER_baixa = :PIDTRB)'
      ''
      'ORDER BY TPBD.VALOR DESC')
    Left = 688
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTRB'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTRBHistorico: TFDQuery
    Connection = dmConexao.conn
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
    Left = 1364
    Top = 232
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
  object frxTRBHistorico: TfrxDBDataset
    UserName = 'TRBHistorico'
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
    DataSet = qryTRBHistorico
    BCDToCurrency = False
    Left = 1208
    Top = 248
  end
  object frxEspelhoTR: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 43905.388124687500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 480
    Top = 288
    Datasets = <
      item
        DataSet = frxCentroCustos
        DataSetName = 'CentroCustos'
      end
      item
        DataSet = frxTRROVDB
        DataSetName = 'historicos'
      end
      item
        DataSet = frxSacado
        DataSetName = 'sacado'
      end
      item
        DataSet = frxDBTitulos
        DataSetName = 'TRPROVBASE'
      end
      item
        DataSet = frxTRBAcrescimo
        DataSetName = 'TRBAcrescimo'
      end
      item
        DataSet = frxDBTRB
        DataSetName = 'TRBaixa'
      end
      item
        DataSet = frxTRBBanco
        DataSetName = 'TRBBanco'
      end
      item
        DataSet = frxDBTRBCaixa
        DataSetName = 'TRBCaixa'
      end
      item
        DataSet = frxTRBCheque
        DataSetName = 'TRBCheque'
      end
      item
        DataSet = frxTRBDeducao
        DataSetName = 'TRBDeducao'
      end
      item
        DataSet = frxTRBHistorico
        DataSetName = 'TRBHistorico'
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
      Frame.Typ = []
      LargeDesignHeight = True
      MirrorMode = []
      PrintOnPreviousPage = True
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 86.929155830000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 5.338590000000000000
          Width = 109.606370000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Organiza'#231#227'o: ')
          ParentFont = False
        end
        object strRazaoSocial1: TfrxMemoView
          AllowVectorExport = True
          Left = 117.283550000000000000
          Top = 5.338590000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strRazaoSocial]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 353.220470000000000000
          Top = 5.338590000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
        object strCNPJ: TfrxMemoView
          AllowVectorExport = True
          Left = 420.764070000000000000
          Top = 1.559060000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCNPJ]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 30.015770000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object strEndereco: TfrxMemoView
          AllowVectorExport = True
          Left = 117.283550000000000000
          Top = 30.015770000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strEndereco]')
          ParentFont = False
        end
        object strCEP: TfrxMemoView
          AllowVectorExport = True
          Left = 420.764070000000000000
          Top = 30.015770000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCEP]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 353.220470000000000000
          Top = 30.015770000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CEP  :')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 510.236550000000000000
          Top = 30.015770000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CIDADE/UF:')
          ParentFont = False
        end
        object strCidade: TfrxMemoView
          AllowVectorExport = True
          Left = 619.842920000000000000
          Top = 33.795300000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
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
          AllowVectorExport = True
          Left = 680.315400000000000000
          Top = 1.559060000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
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
          AllowVectorExport = True
          Left = 619.842920000000000000
          Top = 1.559060000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'P'#193'G.')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 5.102350000000000000
          Top = 57.031540000000000000
          Width = 737.008350000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'ESPELHO T'#205'TULO A RECEBER')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Frame.Typ = []
        Height = 68.031496060000000000
        Top = 1379.528450000000000000
        Width = 755.906000000000000000
        object Line2: TfrxLineView
          AllowVectorExport = True
          Top = 3.000000000000000000
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 1.500000000000000000
        end
      end
      object Memo41: TfrxMemoView
        AllowVectorExport = True
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
        Frame.Typ = []
        ParentFont = False
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 3.779527560000000000
        Top = 166.299320000000000000
        Width = 755.906000000000000000
        Condition = 'TRPROVBASE."ID_TITULO_RECEBER"'
        object Line3: TfrxLineView
          AllowVectorExport = True
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 1470.237170000000000000
        Width = 755.906000000000000000
        object Memo36: TfrxMemoView
          AllowVectorExport = True
          Left = -1.220470000000000000
          Top = 2.000000000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Pempec Enterprise Finance')
          ParentFont = False
          VAlign = vaBottom
        end
        object Date: TfrxMemoView
          AllowVectorExport = True
          Left = 648.441250000000000000
          Top = 2.000000000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo79: TfrxMemoView
          AllowVectorExport = True
          Left = 575.086890000000000000
          Top = 2.000000000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Emitido em:  ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Time: TfrxMemoView
          AllowVectorExport = True
          Left = 706.488560000000000000
          Top = 2.000000000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object Titulo: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 128.504020000000000000
        Top = 192.756030000000000000
        Width = 755.906000000000000000
        DataSet = frxDBTitulos
        DataSetName = 'TRPROVBASE'
        RowCount = 0
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 100.165430000000000000
          Top = 26.456710000000000000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          DataField = 'NUMERO_DOCUMENTO'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."NUMERO_DOCUMENTO"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          AllowVectorExport = True
          Left = 336.732530000000000000
          Top = 26.456710000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'DATA_VENCIMENTO'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[TRPROVBASE."DATA_VENCIMENTO"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
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
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 26.456710000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DOCUMENTO ')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 291.023810000000000000
          Top = 26.456710000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'VCTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 491.016080000000000000
          Top = 26.456710000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'DATA_PAGAMENTO'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."DATA_PAGAMENTO"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 441.307360000000000000
          Top = 26.456710000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'PGTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 668.976321810000000000
          Top = 26.456710000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'DATA_EMISSAO'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."DATA_EMISSAO"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          AllowVectorExport = True
          Left = 585.370440000000000000
          Top = 26.456710000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'EMISS'#195'O')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo23: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 46.354360000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O ')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          AllowVectorExport = True
          Left = 100.165430000000000000
          Top = 46.354360000000000000
          Width = 325.039580000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRICAO'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."DESCRICAO"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 105.606370000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'HIST'#211'RICO ')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 100.165430000000000000
          Top = 105.606370000000000000
          Width = 521.575140000000000000
          Height = 15.118120000000000000
          DataField = 'DSC_HIST'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."DSC_HIST"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 64.252010000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          AllowVectorExport = True
          Left = 100.165430000000000000
          Top = 64.252010000000000000
          Width = 170.078850000000000000
          Height = 15.118120000000000000
          DataField = 'STATUS'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[TRPROVBASE."STATUS"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          AllowVectorExport = True
          Left = 441.307360000000000000
          Top = 46.354360000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'PARCELA')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          AllowVectorExport = True
          Left = 518.913730000000000000
          Top = 46.354360000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DataField = 'PARCELA'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."PARCELA"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          AllowVectorExport = True
          Left = 625.283860000000000000
          Top = 105.606370000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          AllowVectorExport = True
          Left = 699.212561810000000000
          Top = 105.606370000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DataField = 'COD_HIST'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."COD_HIST"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          AllowVectorExport = True
          Left = 441.307360000000000000
          Top = 64.252010000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'RESPONS'#193'VEL')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          AllowVectorExport = True
          Left = 548.031361810000000000
          Top = 64.252010000000000000
          Width = 207.874150000000000000
          Height = 15.118120000000000000
          DataField = 'RESPONSAVEL'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."RESPONSAVEL"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          AllowVectorExport = True
          Left = 441.307360000000000000
          Top = 84.708720000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'VALOR ')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          AllowVectorExport = True
          Left = 555.590421810000000000
          Top = 84.708720000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR_NOMINAL'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRPROVBASE."VALOR_NOMINAL"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 84.708720000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'ANTECIPADO')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          AllowVectorExport = True
          Left = 100.165430000000000000
          Top = 84.708720000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR_ANTECIPADO'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[TRPROVBASE."VALOR_ANTECIPADO"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Top = 125.063080000000000000
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Fornecedor: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 177.637910000000000000
        Top = 343.937230000000000000
        Width = 755.906000000000000000
        DataSet = frxSacado
        DataSetName = 'sacado'
        RowCount = 0
        object Memo34: TfrxMemoView
          AllowVectorExport = True
          Width = 755.905511810000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Line4: TfrxLineView
          AllowVectorExport = True
          Top = 171.417440000000000000
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo39: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 25.456710000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#211'DIGO ')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          AllowVectorExport = True
          Left = 67.811070000000000000
          Top = 25.456709999999990000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'CODIGO'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."CODIGO"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          AllowVectorExport = True
          Left = 313.700990000000000000
          Top = 25.456710000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CPF/CNPJ')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          AllowVectorExport = True
          Left = 376.512060000000000000
          Top = 25.456710000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          DataField = 'CPFCNPJ'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."CPFCNPJ"]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          AllowVectorExport = True
          Left = 158.740260000000000000
          Top = 25.456710000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frmCTPHistorico.frxDBCedente
          DataSetName = 'Cedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'PERSONALIDADE')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          AllowVectorExport = True
          Left = 271.905690000000000000
          Top = 25.456710000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DataField = 'PERSONALIDADE'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."PERSONALIDADE"]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          AllowVectorExport = True
          Left = 610.165740000000000000
          Top = 25.456710000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          AllowVectorExport = True
          Left = 668.976321810000000000
          Top = 25.456710000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'STATUS'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[sacado."STATUS"]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          AllowVectorExport = True
          Left = 495.661720000000000000
          Top = 25.456710000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CGA')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 46.133890000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'NOME')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          AllowVectorExport = True
          Left = 68.031540000000000000
          Top = 46.133890000000000000
          Width = 241.889920000000000000
          Height = 15.118120000000000000
          DataField = 'NOME'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."NOME"]')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          AllowVectorExport = True
          Left = 313.700990000000000000
          Top = 46.133890000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'INSC. ESTADUAL')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          AllowVectorExport = True
          Left = 429.425480000000000000
          Top = 46.133890000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataField = 'CONTA'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."CONTA"]')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 65.031540000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'TIPO')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          AllowVectorExport = True
          Left = 68.031540000000000000
          Top = 65.031540000000000000
          Width = 241.889920000000000000
          Height = 15.118120000000000000
          DataField = 'TIPO'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."TIPO"]')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          AllowVectorExport = True
          Left = 313.700990000000000000
          Top = 65.031540000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CONTA CONT'#193'BIL')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          AllowVectorExport = True
          Left = 429.425480000000000000
          Top = 65.031540000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataField = 'CONTA'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."CONTA"]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          AllowVectorExport = True
          Left = 505.016080000000000000
          Top = 65.031540000000000000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          DataField = 'DSC_CONTA'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."DSC_CONTA"]')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          AllowVectorExport = True
          Left = 706.551640000000000000
          Top = 64.252010000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DataField = 'CEP'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[sacado."CEP"]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 86.708720000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'ENDERE'#199'O ')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          AllowVectorExport = True
          Left = 77.149660000000000000
          Top = 86.708720000000000000
          Width = 170.078850000000000000
          Height = 15.118120000000000000
          DataField = 'LOGRADOURO'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."LOGRADOURO"]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          AllowVectorExport = True
          Left = 249.448980000000000000
          Top = 86.708720000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DataField = 'COMPLEMENTO'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."COMPLEMENTO"]')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          AllowVectorExport = True
          Left = 415.748300000000000000
          Top = 86.708720000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DataField = 'NUMERO'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."NUMERO"]')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          AllowVectorExport = True
          Left = 468.661720000000000000
          Top = 86.708720000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'CEP'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[sacado."CEP"]')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          AllowVectorExport = True
          Left = 249.448980000000000000
          Top = 102.047310000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DataField = 'CIDADE'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."CIDADE"]')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          AllowVectorExport = True
          Left = 77.149660000000000000
          Top = 102.047310000000000000
          Width = 170.078850000000000000
          Height = 15.118120000000000000
          DataField = 'BAIRRO'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."BAIRRO"]')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          AllowVectorExport = True
          Left = 468.661720000000000000
          Top = 102.047310000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'ID_ESTADO'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[sacado."ID_ESTADO"]')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 125.504020000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CONTATOS')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          AllowVectorExport = True
          Left = 77.149660000000000000
          Top = 125.504020000000000000
          Width = 170.078850000000000000
          Height = 15.118120000000000000
          DataField = 'TELEFONE'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."TELEFONE"]')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          AllowVectorExport = True
          Left = 253.228510000000000000
          Top = 125.504020000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DataField = 'CELULAR'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."CELULAR"]')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          AllowVectorExport = True
          Left = 551.590910000000000000
          Top = 125.504020000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'EMAIL'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."EMAIL"]')
          ParentFont = False
        end
        object Memo80: TfrxMemoView
          AllowVectorExport = True
          Top = 4.000000000000000000
          Width = 752.126470000000000000
          Height = 15.118120000000000000
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsItalic]
          Frame.Typ = []
          Fill.BackColor = cl3DLight
          HAlign = haCenter
          Memo.UTF8W = (
            '[sacado."TIPO"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo134: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 149.960730000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'BANCO')
          ParentFont = False
        end
        object Memo135: TfrxMemoView
          AllowVectorExport = True
          Left = 77.149660000000000000
          Top = 149.960730000000000000
          Width = 257.008040000000000000
          Height = 15.118120000000000000
          DataField = 'BANCO'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."BANCO"]')
          ParentFont = False
        end
        object Memo136: TfrxMemoView
          AllowVectorExport = True
          Left = 347.716760000000000000
          Top = 149.960730000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'AG'#202'NCIA')
          ParentFont = False
        end
        object Memo137: TfrxMemoView
          AllowVectorExport = True
          Left = 549.236550000000000000
          Top = 149.960730000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CONTA')
          ParentFont = False
        end
        object Memo138: TfrxMemoView
          AllowVectorExport = True
          Left = 427.086890000000000000
          Top = 149.960730000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          DataField = 'AGENCIA'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."AGENCIA"]')
          ParentFont = False
        end
        object Memo139: TfrxMemoView
          AllowVectorExport = True
          Left = 612.283860000000000000
          Top = 149.960730000000000000
          Width = 139.842610000000000000
          Height = 15.118120000000000000
          DataField = 'CONTA_BANCARIA'
          DataSet = frxSacado
          DataSetName = 'sacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[sacado."CONTA_BANCARIA"]')
          ParentFont = False
        end
      end
      object RateioHistorico: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677165350000000000
        Top = 589.606680000000000000
        Width = 755.906000000000000000
        DataSet = frxTRROVDB
        DataSetName = 'historicos'
        RowCount = 0
        object Memo61: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 1.000000000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DataField = 'HST_CODIGO'
          DataSet = frxTRROVDB
          DataSetName = 'historicos'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[historicos."HST_CODIGO"]')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          AllowVectorExport = True
          Left = 44.574830000000000000
          Top = 1.000000000000000000
          Width = 283.464750000000000000
          Height = 15.118120000000000000
          DataField = 'HST_DSC'
          DataSet = frxTRROVDB
          DataSetName = 'historicos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[historicos."HST_DSC"]')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          AllowVectorExport = True
          Left = 331.598640000000000000
          Top = 1.000000000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CONTA_DB'
          DataSet = frxTRROVDB
          DataSetName = 'historicos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[historicos."CONTA_DB"]')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          AllowVectorExport = True
          Left = 429.984540000000000000
          Top = 1.000000000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataField = 'COD_RED_DB'
          DataSet = frxTRROVDB
          DataSetName = 'historicos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[historicos."COD_RED_DB"]')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          AllowVectorExport = True
          Left = 555.590421810000000000
          Top = 1.000000000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR_TOTAL'
          DataSet = frxTRROVDB
          DataSetName = 'historicos'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[historicos."VALOR_TOTAL"]')
          ParentFont = False
        end
      end
      object RateioCustos: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Times New Roman'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 680.315400000000000000
        Width = 755.906000000000000000
        DataSet = frxCentroCustos
        DataSetName = 'CentroCustos'
        RowCount = 0
        object Memo81: TfrxMemoView
          AllowVectorExport = True
          Left = 63.590600000000000000
          Top = 1.000000000000000000
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
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[CentroCustos."CODIGO"]')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          AllowVectorExport = True
          Left = 298.582870000000000000
          Top = 1.000000000000000000
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
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[CentroCustos."CENTRO_CST"]')
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          AllowVectorExport = True
          Left = 555.590421810000000000
          Top = 1.000000000000000000
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
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[CentroCustos."VALOR"]')
          ParentFont = False
        end
        object Memo133: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 1.000000000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#211'DIGO ')
          ParentFont = False
        end
      end
      object Memo16: TfrxMemoView
        AllowVectorExport = True
        Left = 813.819420000000000000
        Top = 260.787570000000000000
        Width = 151.181200000000000000
        Height = 11.338590000000000000
        DataField = 'VALOR_NOMINAL'
        DataSet = frxDBTitulos
        DataSetName = 'TRPROVBASE'
        DisplayFormat.FormatStr = '%2.2n'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
        HAlign = haRight
        Memo.UTF8W = (
          '[TRPROVBASE."VALOR_NOMINAL"]')
        ParentFont = False
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 544.252320000000100000
        Width = 755.906000000000000000
        Condition = '1=1'
        object Memo35: TfrxMemoView
          AllowVectorExport = True
          Width = 755.905511810000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = cl3DLight
          HAlign = haCenter
          Memo.UTF8W = (
            'Rateio por Hist'#243'ricos Cont'#225'beis')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 634.961040000000000000
        Width = 755.906000000000000000
        Condition = '1=1'
        object Memo37: TfrxMemoView
          AllowVectorExport = True
          Width = 755.905511810000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = cl3DLight
          HAlign = haCenter
          Memo.UTF8W = (
            'Rateio por Centro de Custos')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader4: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 725.669760000000000000
        Width = 755.906000000000000000
        Condition = '1=1'
        object Memo84: TfrxMemoView
          AllowVectorExport = True
          Width = 755.905511810000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = cl3DLight
          HAlign = haCenter
          Memo.UTF8W = (
            'Informa'#231#245'es sobre o pagamento')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object TRBAIXA: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456710000000000000
        Top = 771.024120000000000000
        Width = 755.906000000000000000
        DataSet = frxDBTRB
        DataSetName = 'TRBaixa'
        RowCount = 0
        object Memo98: TfrxMemoView
          AllowVectorExport = True
          Left = 61.031540000000000000
          Top = 2.779530000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'DATA_PAGAMENTO'
          DataSet = frxDBTRB
          DataSetName = 'TRBaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[TRBaixa."DATA_PAGAMENTO"]')
          ParentFont = False
        end
        object Memo99: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 2.779530000000020000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
        end
        object Memo103: TfrxMemoView
          AllowVectorExport = True
          Left = 555.590421810000000000
          Top = 2.779530000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR_PAGO'
          DataSet = frxDBTRB
          DataSetName = 'TRBaixa'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBaixa."VALOR_PAGO"]')
          ParentFont = False
        end
        object Memo104: TfrxMemoView
          AllowVectorExport = True
          Left = 463.543600000000000000
          Top = 2.779530000000020000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Color = clBlue
          Frame.Typ = []
          Fill.BackColor = 15790320
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR PAGO')
          ParentFont = False
        end
      end
      object DT_ACRESCIMO: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897637800000000000
        Top = 1088.504640000000000000
        Width = 755.906000000000000000
        DataSet = frxTRBAcrescimo
        DataSetName = 'TRBAcrescimo'
        RowCount = 0
        object Memo105: TfrxMemoView
          AllowVectorExport = True
          Left = 555.590421810000000000
          Top = 0.779530000000023000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = frxTRBAcrescimo
          DataSetName = 'TRBAcrescimo'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBAcrescimo."VALOR"]')
          ParentFont = False
        end
        object Memo106: TfrxMemoView
          AllowVectorExport = True
          Left = 463.543600000000000000
          Top = 0.779530000000023000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object Memo108: TfrxMemoView
          AllowVectorExport = True
          Left = 69.252010000000000000
          Top = 0.779530000000023000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRICAO'
          DataSet = frxTRBAcrescimo
          DataSetName = 'TRBAcrescimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[TRBAcrescimo."DESCRICAO"]')
          ParentFont = False
        end
        object Memo109: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 0.779530000000023000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DataField = 'CODIGO'
          DataSet = frxTRBAcrescimo
          DataSetName = 'TRBAcrescimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRBAcrescimo."CODIGO"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo107: TfrxMemoView
          AllowVectorExport = True
          Left = 331.598640000000000000
          Top = 0.779530000000023000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CONTA'
          DataSet = frxTRBAcrescimo
          DataSetName = 'TRBAcrescimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBAcrescimo."CONTA"]')
          ParentFont = False
        end
        object Memo110: TfrxMemoView
          AllowVectorExport = True
          Left = 424.984540000000000000
          Top = 0.779530000000023000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataField = 'CODREDUZ'
          DataSet = frxTRBAcrescimo
          DataSetName = 'TRBAcrescimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBAcrescimo."CODREDUZ"]')
          ParentFont = False
        end
      end
      object DT_DEDUCAO: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897637800000000000
        Top = 1251.024430000000000000
        Width = 755.906000000000000000
        DataSet = frxTRBDeducao
        DataSetName = 'TRBDeducao'
        RowCount = 0
        object Memo111: TfrxMemoView
          AllowVectorExport = True
          Left = 555.590421810000000000
          Top = 1.779530000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'CODREDUZ'
          DataSet = frxTRBDeducao
          DataSetName = 'TRBDeducao'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBDeducao."CODREDUZ"]')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          AllowVectorExport = True
          Left = 463.543600000000000000
          Top = 1.779530000000020000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object Memo113: TfrxMemoView
          AllowVectorExport = True
          Left = 69.252010000000000000
          Top = 1.779530000000020000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRICAO'
          DataSet = frxTRBDeducao
          DataSetName = 'TRBDeducao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            '[TRBDeducao."DESCRICAO"]')
          ParentFont = False
        end
        object Memo114: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 1.779530000000020000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DataField = 'CODIGO'
          DataSet = frxTRBDeducao
          DataSetName = 'TRBDeducao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRBDeducao."CODIGO"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo115: TfrxMemoView
          AllowVectorExport = True
          Left = 331.598640000000000000
          Top = 1.779530000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRICAO'
          DataSet = frxTRBAcrescimo
          DataSetName = 'TRBAcrescimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBAcrescimo."DESCRICAO"]')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          AllowVectorExport = True
          Left = 424.984540000000000000
          Top = 1.779530000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataField = 'CODREDUZ'
          DataSet = frxTRBDeducao
          DataSetName = 'TRBDeducao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBDeducao."CODREDUZ"]')
          ParentFont = False
        end
      end
      object GroupHeader5: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 820.158010000000000000
        Width = 755.906000000000000000
        Condition = '1=1'
        object Memo117: TfrxMemoView
          AllowVectorExport = True
          Width = 755.905511810000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = cl3DLight
          HAlign = haCenter
          Memo.UTF8W = (
            'Formas de pagamento')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object DetailData3: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677162910000000000
        Top = 865.512370000000000000
        Width = 755.906000000000000000
        DataSet = frxDBTRBCaixa
        DataSetName = 'TRBCaixa'
        RowCount = 0
        object Memo120: TfrxMemoView
          AllowVectorExport = True
          Left = 140.992270000000000000
          Top = 2.779530000000020000
          Width = 188.976500000000000000
          Height = 15.118120000000000000
          DataField = 'DSC_HIST'
          DataSet = frxDBTRBCaixa
          DataSetName = 'TRBCaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBCaixa."DSC_HIST"]')
          ParentFont = False
        end
        object Memo121: TfrxMemoView
          AllowVectorExport = True
          Left = 331.598640000000000000
          Top = 2.779530000000020000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CONTA_CREDITO'
          DataSet = frxDBTRBCaixa
          DataSetName = 'TRBCaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBCaixa."CONTA_CREDITO"]')
          ParentFont = False
        end
        object Memo122: TfrxMemoView
          AllowVectorExport = True
          Left = 429.984540000000000000
          Top = 2.779530000000020000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataField = 'CODREDUZ'
          DataSet = frxDBTRBCaixa
          DataSetName = 'TRBCaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBCaixa."CODREDUZ"]')
          ParentFont = False
        end
        object Memo118: TfrxMemoView
          AllowVectorExport = True
          Left = 555.590421810000000000
          Top = 2.779530000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = frxDBTRBCaixa
          DataSetName = 'TRBCaixa'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBCaixa."VALOR"]')
          ParentFont = False
        end
        object Memo143: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 2.779530000000020000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          DataSet = dmEspelhoTP.frxTPBBanco
          DataSetName = 'TPBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            'CAIXA/TESOURARIA')
          ParentFont = False
        end
      end
      object DetailData4: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677165350000000000
        Top = 910.866730000000000000
        Width = 755.906000000000000000
        DataSet = frxTRBBanco
        DataSetName = 'TRBBanco'
        RowCount = 0
        object Memo124: TfrxMemoView
          AllowVectorExport = True
          Left = 137.212740000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataField = 'DSC_CONTA_CR'
          DataSet = frxTRBBanco
          DataSetName = 'TRBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBBanco."DSC_CONTA_CR"]')
          ParentFont = False
        end
        object Memo125: TfrxMemoView
          AllowVectorExport = True
          Left = 331.598640000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CONTA_CR'
          DataSet = frxTRBBanco
          DataSetName = 'TRBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBBanco."CONTA_CR"]')
          ParentFont = False
        end
        object Memo126: TfrxMemoView
          AllowVectorExport = True
          Left = 429.984540000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataField = 'CONTA_CR'
          DataSet = frxTRBBanco
          DataSetName = 'TRBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBBanco."CONTA_CR"]')
          ParentFont = False
        end
        object Memo127: TfrxMemoView
          AllowVectorExport = True
          Left = 555.590421810000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = frxTRBBanco
          DataSetName = 'TRBBanco'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBBanco."VALOR"]')
          ParentFont = False
        end
        object Memo142: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          DataSet = dmEspelhoTP.frxTPBBanco
          DataSetName = 'TPBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clMenu
          Memo.UTF8W = (
            'PAGTO BANK LINE')
          ParentFont = False
        end
      end
      object DetailData5: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456695350000000000
        Top = 956.221090000000000000
        Width = 755.906000000000000000
        DataSet = frxTRBCheque
        DataSetName = 'TRBCheque'
        RowCount = 0
        object Memo130: TfrxMemoView
          AllowVectorExport = True
          Left = 555.590421810000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR_CHEQUE'
          DataSet = frxTRBCheque
          DataSetName = 'TRBCheque'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBCheque."VALOR_CHEQUE"]')
          ParentFont = False
        end
        object Memo132: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CHEQUE')
          ParentFont = False
        end
      end
      object GroupHeader6: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 34.015770000000000000
        Top = 1005.354980000000000000
        Width = 755.906000000000000000
        Condition = '1=1'
        object Memo140: TfrxMemoView
          AllowVectorExport = True
          Top = 6.000000000000000000
          Width = 755.905511810000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = cl3DLight
          HAlign = haCenter
          Memo.UTF8W = (
            'Acr'#233'scimos')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line9: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Width = 755.906000000000000000
          Color = clNavy
          Frame.Style = fsDouble
          Frame.Typ = [ftTop]
          Frame.Width = 1.500000000000000000
        end
      end
      object GroupHeader7: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 1179.213360000000000000
        Width = 755.906000000000000000
        Condition = '1=1'
        object Memo141: TfrxMemoView
          AllowVectorExport = True
          Width = 755.905511810000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = cl3DLight
          HAlign = haCenter
          Memo.UTF8W = (
            'Dedu'#231#245'es')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader8: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 3.779527560000000000
        Top = 1224.567720000000000000
        Width = 755.906000000000000000
        Condition = 'TRBDeducao."ID_TITULO_RECEBER_BAIXA"'
        object Line5: TfrxLineView
          AllowVectorExport = True
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooter4: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456692910000000000
        Top = 1292.599260000000000000
        Width = 755.906000000000000000
        object Memo144: TfrxMemoView
          AllowVectorExport = True
          Left = 555.590421810000000000
          Top = 2.118120000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataSet = dmEspelhoTP.frxTPBDeducao
          DataSetName = 'TPBDeducao'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<TRBDeducao."VALOR">,DT_DEDUCAO)]')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo145: TfrxMemoView
          AllowVectorExport = True
          Left = 463.543600000000000000
          Top = 2.118120000000090000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL ')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456692910000000000
        Top = 1130.079470000000000000
        Width = 755.906000000000000000
        object Memo146: TfrxMemoView
          AllowVectorExport = True
          Left = 555.590421810000000000
          Top = 2.118120000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataSet = dmEspelhoTP.frxTPBDeducao
          DataSetName = 'TPBDeducao'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clMenu
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<TRBAcrescimo."VALOR">,DT_ACRESCIMO)]')
          ParentFont = False
        end
        object Line7: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo147: TfrxMemoView
          AllowVectorExport = True
          Left = 463.543600000000000000
          Top = 2.118120000000090000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL ')
          ParentFont = False
        end
      end
      object GroupHeader9: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 3.779527560000000000
        Top = 1062.047930000000000000
        Width = 755.906000000000000000
        Condition = 'TRBAcrescimo."ID_TITULO_RECEBER_BAIXA"'
        object Line8: TfrxLineView
          AllowVectorExport = True
          Width = 755.905511810000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object qryObterTRBBanco: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TPBI.ID_TITULO_RECEBER_BAIXA,'
      '       TPBI.ID_ORGANIZACAO,'
      '       TPBI.VALOR as VALOR,'
      '       TPBI.id_conta_bancaria,'
      '       CC.conta AS CONTA_CR,'
      '       CC.DESCRICAO AS DSC_CONTA_CR,'
      '       CC.codreduz AS COD_RED_CR'
      '        '
      'FROM TITULO_RECEBER_BAIXA_INTERNET TPBI'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = TPB' +
        'I.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = TPBI.ID_ORGANIZACA' +
        'O)'
      
        'LEFT OUTER JOIN conta_contabil CC ON (CC.id_conta_contabil = CB.' +
        'id_conta_contabil) AND (CC.ID_ORGANIZACAO = TPBI.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBI.ID_ORGANIZACAO = :PIDORGANIZACAO )AND'
      '      (TPBI.ID_TITULO_RECEBER_BAIXA = :PIDTRB)'
      ''
      'ORDER BY TPBI.VALOR;')
    Left = 990
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTRB'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qrySacado: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT C.ID_SACADO,'
      '       C.ID_ORGANIZACAO,'
      '       C.ID_CONTA_CONTABIL,'
      '       C.ID_TIPO_SACADO,'
      '       C.ID_ENDERECO,'
      '       C.ID_CONTATO,'
      '       C.NOME,'
      '       C.PERSONALIDADE,'
      '       C.CPFCNPJ,       '
      '       C.INSCRICAO_ESTADUAL,       '
      '       C.STATUS,'
      '       C.CODIGO,'
      '       C.DATA_ULTIMA_ATUALIZACAO,'
      '       TC.DESCRICAO AS TIPO,'
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
      '       CC.CODREDUZ AS CODRED_CONTA,'
      '       (BCO.CODIGO_BANCO || '#39' - '#39' || + BCO.NOME_BANCO) AS BANCO,'
      '       C.AGENCIA,'
      '       C.CONTA_BANCARIA'
      ' '
      ''
      ''
      'FROM SACADO C'
      
        'LEFT OUTER JOIN TIPO_SACADO TC   ON (TC.ID_TIPO_SACADO = C.ID_TI' +
        'PO_SACADO) AND (TC.ID_ORGANIZACAO = C.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTATO CT        ON (CT.id_contato = C.ID_CONTA' +
        'TO) AND  (CT.ID_ORGANIZACAO =  C.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN ENDERECO E        ON (E.ID_ENDERECO = C.ID_ENDER' +
        'ECO) AND (E.ID_ORGANIZACAO =  C.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = C.I' +
        'D_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO =  C.ID_ORGANIZACAO)'
      'LEFT OUTER JOIN BAIRRO   B        ON (B.ID_BAIRRO = E.ID_BAIRRO)'
      
        'LEFT OUTER JOIN CIDADE   CID      ON (CID.ID_CIDADE = E.ID_CIDAD' +
        'E)'
      'LEFT OUTER JOIN BANCO BCO         ON (BCO.ID_BANCO = C.ID_BANCO)'
      ''
      'WHERE (C.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (C.ID_SACADO = :PID)')
    Left = 264
    Top = 280
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PID'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterPorNumeroDocumento: TFDQuery
    Active = True
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    SQL.Strings = (
      'SELECT TP.ID_TITULO_RECEBER,'
      '       TP.ID_ORGANIZACAO,'
      '       TP.ID_SACADO,'
      '       TP.ID_HISTORICO,'
      '       TP.ID_CENTRO_CUSTO,'
      '       TP.ID_TIPO_STATUS,'
      '       TP.ID_TIPO_COBRANCA,'
      '       TP.ID_RESPONSAVEL,'
      '       TP.ID_LOCAL_PAGAMENTO,'
      '       TP.ID_TITULO_GERADOR,'
      '       TP.ID_LOTE_CONTABIL,       '
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
      '       TP.ID_LOTE_TRB,'
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
      'FROM TITULO_RECEBER TP'
      
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
    Left = 88
    Top = 16
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
  object frxSacado: TfrxDBDataset
    UserName = 'sacado'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_SACADO=ID_SACADO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'ID_TIPO_SACADO=ID_TIPO_SACADO'
      'ID_ENDERECO=ID_ENDERECO'
      'ID_CONTATO=ID_CONTATO'
      'NOME=NOME'
      'PERSONALIDADE=PERSONALIDADE'
      'CPFCNPJ=CPFCNPJ'
      'INSCRICAO_ESTADUAL=INSCRICAO_ESTADUAL'
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
      'CODRED_CONTA=CODRED_CONTA'
      'BANCO=BANCO'
      'AGENCIA=AGENCIA'
      'CONTA_BANCARIA=CONTA_BANCARIA')
    DataSet = qrySacado
    BCDToCurrency = False
    Left = 264
    Top = 352
  end
  object qryRateioCentroCustos: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT  TPC.ID_TITULO_RECEBER_RATEIO_CC,'
      '        TPC.ID_ORGANIZACAO,      '
      '        TPC.VALOR,       '
      '        TPC.ID_TITULO_RECEBER,'
      '        CC.DESCRICAO AS CENTRO_CST,'
      '        CC.CODIGO,'
      '        CC.SIGLA'
      '        '
      'FROM TITULO_RECEBER_RATEIO_CC TPC'
      
        'LEFT OUTER JOIN CENTRO_CUSTO CC ON (CC.ID_CENTRO_CUSTO = TPC.ID_' +
        'CENTRO_CUSTO) AND (CC.ID_ORGANIZACAO = TPC.ID_ORGANIZACAO)'
      ''
      'WHERE    (TPC.ID_TITULO_RECEBER = :PID) AND'
      '         (TPC.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      '')
    Left = 64
    Top = 168
    ParamData = <
      item
        Name = 'PID'
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
      'ID_TITULO_RECEBER_RATEIO_CC=ID_TITULO_RECEBER_RATEIO_CC'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'VALOR=VALOR'
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER'
      'CENTRO_CST=CENTRO_CST'
      'CODIGO=CODIGO'
      'SIGLA=SIGLA')
    DataSet = qryRateioCentroCustos
    BCDToCurrency = False
    Left = 264
    Top = 176
  end
  object qryLoteRecebto: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT LP.id_LOTE_RECEBIMENTO ,'
      '       LP.id_organizacao,'
      '       LP.id_conta_bancaria,'
      '       LP.id_conta_bancaria_cheque,'
      '       LP.id_tipo_operacao_bancaria,'
      '       LP.data_pagamento,'
      '       LP.lote,'
      '       LP.valor AS VALOR_lOTE,'
      '       CB.conta,'
      '       cb.id_conta_contabiL,'
      '       CCBCO.conta as cc_ctbancaria,'
      '       CCBCO.descricao AS CC_DSC,'
      '       cb.titular,'
      '       FP.descricao AS forma_pagamento'
      ''
      'FROM LOTE_RECEBIMENTO LP'
      
        'LEFT OUTER JOIN forma_pagamento FP ON (FP.ID_FORMA_PAGAMENTO = L' +
        'P.ID_FORMA_PAGAMENTO) AND (FP.ID_ORGANIZACAO = LP.ID_ORGANIZACAO' +
        ')'
      
        'LEFT OUTER JOIN tipo_operacao_bancaria TOB ON (TOB.id_tipo_opera' +
        'cao_bancaria = LP.id_tipo_operacao_bancaria) AND (TOB.ID_ORGANIZ' +
        'ACAO = LP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = LP.' +
        'id_conta_bancaria) AND (CB.ID_ORGANIZACAO = LP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria_cheque CBC ON (CBC.id_conta_banca' +
        'ria_cheque = LP.id_conta_bancaria_cheque) AND (CBC.ID_ORGANIZACA' +
        'O = LP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_contabil CCBCO ON (CCBCO.id_conta_contabil' +
        ' = CB.id_conta_contabil)AND (CCBCO.ID_ORGANIZACAO = LP.ID_ORGANI' +
        'ZACAO)'
      ''
      'WHERE (LP.id_organizacao = :PIDORGANIZACAO) AND'
      '      (LP.ID_LOTE_RECEBIMENTO  = :PIDLOTE)'
      ''
      ''
      '')
    Left = 48
    Top = 288
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDLOTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object frxLoteRcbto: TfrxDBDataset
    UserName = 'loteRecbto'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_LOTE_RECEBIMENTO=ID_LOTE_RECEBIMENTO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'ID_CONTA_BANCARIA_CHEQUE=ID_CONTA_BANCARIA_CHEQUE'
      'ID_TIPO_OPERACAO_BANCARIA=ID_TIPO_OPERACAO_BANCARIA'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'LOTE=LOTE'
      'VALOR_LOTE=VALOR_LOTE'
      'CONTA=CONTA'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'CC_CTBANCARIA=CC_CTBANCARIA'
      'CC_DSC=CC_DSC'
      'TITULAR=TITULAR'
      'FORMA_PAGAMENTO=FORMA_PAGAMENTO')
    DataSet = qryLoteRecebto
    BCDToCurrency = False
    Left = 48
    Top = 360
  end
  object frxTRBBanco: TfrxDBDataset
    UserName = 'TRBBanco'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'VALOR=VALOR'
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'CONTA_CR=CONTA_CR'
      'DSC_CONTA_CR=DSC_CONTA_CR'
      'COD_RED_CR=COD_RED_CR')
    DataSet = qryObterTRBBanco
    BCDToCurrency = False
    Left = 984
    Top = 136
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 744
    Top = 344
  end
  object frxCSVExport1: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    UTF8 = False
    OpenAfterExport = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 872
    Top = 344
  end
end
