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
    EngineOptions.PrintIfEmpty = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Author = 'Pempec Enterprise Finance 2K'
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.Name = 'Relat'#243'rio Exporta'#231#227'o'
    ReportOptions.LastChange = 43992.552666331000000000
    ReportOptions.VersionBuild = '2'
    ReportOptions.VersionMajor = '2'
    ReportOptions.VersionMinor = '2'
    ReportOptions.VersionRelease = '1'
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 480
    Top = 288
    Datasets = <
      item
        DataSetName = 'CBT_C'
      end
      item
        DataSetName = 'CBT_D'
      end
      item
        DataSetName = 'CBTBASE'
      end
      item
        DataSet = dmEspelhoTP.frxTPBAcrescimo
        DataSetName = 'TPBAcrescimo'
      end
      item
        DataSet = dmEspelhoTP.frxDBTPB
        DataSetName = 'TPBaixa'
      end
      item
        DataSet = dmEspelhoTP.frxTPBBanco
        DataSetName = 'TPBBanco'
      end
      item
        DataSet = dmEspelhoTP.frxDBTPBCaixa
        DataSetName = 'TPBCaixa'
      end
      item
        DataSet = dmEspelhoTP.frxTPBCheque
        DataSetName = 'TPBCheque'
      end
      item
        DataSet = dmEspelhoTP.frxTPBDeducao
        DataSetName = 'TPBDeducao'
      end
      item
        DataSet = dmEspelhoTP.frxTPBHistorico
        DataSetName = 'TPBHistorico'
      end
      item
        DataSet = frxDBTitulos
        DataSetName = 'TRPROVBASE'
      end
      item
        DataSet = dmEspelhoTP.frxTPPROVCR
        DataSetName = 'TPPROVCR'
      end
      item
        DataSetName = 'TPPROVDB'
      end
      item
        DataSet = dmEspelhoTP.frxDBTPQuitados
        DataSetName = 'TPQUITADOS'
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
        DataSetName = 'TRFBCOCAIXA'
      end
      item
        DataSetName = 'TRFCAIXABANCO'
      end
      item
        DataSet = frxDBTitulos
        DataSetName = 'TRPROVBASE'
      end
      item
        DataSet = frxTRPROVCR
        DataSetName = 'TRPROVCR'
      end
      item
        DataSetName = 'TRPROVDB'
      end
      item
        DataSet = frxDBTRQuitados
        DataSetName = 'TRQUITADOS'
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
        Name = 'strPeriodo'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 52.913420000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        Child = frxEspelhoTR.Child1
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 1.338590000000000000
          Width = 109.606370000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Organiza'#231#227'o: ')
          ParentFont = False
        end
        object strRazaoSocial1: TfrxMemoView
          AllowVectorExport = True
          Left = 117.283550000000000000
          Top = 1.338590000000000000
          Width = 449.764070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strRazaoSocial]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 572.433210000000000000
          Top = 1.338590000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
        object strCNPJ: TfrxMemoView
          AllowVectorExport = True
          Left = 639.976810000000000000
          Top = 1.338590000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCNPJ]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 24.015770000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object strEndereco: TfrxMemoView
          AllowVectorExport = True
          Left = 117.283550000000000000
          Top = 24.015770000000000000
          Width = 449.764070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strEndereco]')
          ParentFont = False
        end
        object strCEP: TfrxMemoView
          AllowVectorExport = True
          Left = 639.976810000000000000
          Top = 24.015770000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCEP]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 570.709030000000000000
          Top = 24.015770000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CEP  :')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 793.701300000000000000
          Top = 27.795300000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CIDADE/UF:')
          ParentFont = False
        end
        object strCidade: TfrxMemoView
          AllowVectorExport = True
          Left = 903.307670000000000000
          Top = 27.795300000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
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
          Left = 975.118740000000000000
          Top = 1.338590000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
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
          Left = 925.984850000000000000
          Top = 1.338590000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'P'#193'G.')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Frame.Typ = []
        Height = 37.795300000000000000
        Top = 94.488250000000000000
        Width = 1046.929810000000000000
        ToNRows = 0
        ToNRowsMode = rmCount
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 559.370440000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'RELAT'#211'RIO ESPELHO DA EXPORTA'#199#195'O')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          AllowVectorExport = True
          Left = 570.709030000000000000
          Width = 75.590600000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'PER'#205'ODO: ')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          AllowVectorExport = True
          Left = 647.079160000000000000
          Width = 362.834880000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[strPeriodo]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897662200000000000
        Top = 192.756030000000000000
        Width = 1046.929810000000000000
        Condition = '1=1'
        ReprintOnNewPage = True
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Top = 1.338590000000010000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'EMISS'#195'O')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 181.346559210000000000
          Top = 1.338590000000010000
          Width = 124.724490000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O  ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Top = 1.338590000000010000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Top = 1.338590000000010000
          Width = 268.346630000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#211'D.HIST.                    DESCRI'#199#195'O CONT'#193'BIL')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Top = 1.338590000000010000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CONTA  CONT'#193'BIL')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo17: TfrxMemoView
          AllowVectorExport = True
          Left = 783.803650000000000000
          Top = 1.338590000000010000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'D'#201'BITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo18: TfrxMemoView
          AllowVectorExport = True
          Left = 944.882500000000000000
          Top = 1.338590000000010000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CR'#201'DITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo23: TfrxMemoView
          AllowVectorExport = True
          Left = 141.181200000000000000
          Top = 1.338590000000010000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'TIPO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Line7: TfrxLineView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo52: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Top = 1.338590000000010000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CD.REDUZ')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object MD_TP_PROV: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 260.787570000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBTitulos
        DataSetName = 'TRPROVBASE'
        RowCount = 0
        object TitulosNUMERO_DOCUMENTO: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataField = 'NUMERO_DOCUMENTO'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."NUMERO_DOCUMENTO"]')
          ParentFont = False
        end
        object TitulosDATA_EMISSAO: TfrxMemoView
          AllowVectorExport = True
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DataField = 'DATA_EMISSAO'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."DATA_EMISSAO"]')
          ParentFont = False
        end
        object TitulosDSC_CONTA: TfrxMemoView
          AllowVectorExport = True
          Left = 312.480520000000000000
          Width = 264.567100000000000000
          Height = 15.118120000000000000
          DataField = 'FORNECEDOR'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."FORNECEDOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          AllowVectorExport = True
          Left = 141.181200000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DataField = 'TIPO'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."TIPO"]')
          ParentFont = False
        end
        object Memo171: TfrxMemoView
          AllowVectorExport = True
          Left = 181.346559210000000000
          Width = 128.504020000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRICAO'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."DESCRICAO"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object DT_TP_PROV_CR: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 336.378170000000000000
        Width = 1046.929810000000000000
        DataSet = dmEspelhoTP.frxTPPROVCR
        DataSetName = 'TPPROVCR'
        RowCount = 0
        object HistoricosDESCRICAO: TfrxMemoView
          AllowVectorExport = True
          Left = 393.071120000000000000
          Width = 241.889920000000000000
          Height = 15.118110240000000000
          DataField = 'CCC_DSC'
          DataSet = dmEspelhoTP.frxTPPROVCR
          DataSetName = 'TPPROVCR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPPROVCR."CCC_DSC"]')
          ParentFont = False
          WordWrap = False
        end
        object HistoricosVALOR: TfrxMemoView
          AllowVectorExport = True
          Left = 922.205320000000000000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DataSet = dmEspelhoTP.frxTPPROVCR
          DataSetName = 'TPPROVCR'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPPROVCR."VALOR_TOTAL"]')
          ParentFont = False
        end
        object HistoricosCONTA: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          DataField = 'CONTA_CR'
          DataSet = dmEspelhoTP.frxTPPROVCR
          DataSetName = 'TPPROVCR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPPROVCR."CONTA_CR"]')
          ParentFont = False
        end
        object HistoricosCODIGO: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataField = 'COD_HIST'
          DataSet = dmEspelhoTP.frxTPPROVCR
          DataSetName = 'TPPROVCR'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TPPROVCR."COD_HIST"]')
          ParentFont = False
        end
        object HistoricosCODREDUZ: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DataField = 'COD_RED_CR'
          DataSet = dmEspelhoTP.frxTPPROVCR
          DataSetName = 'TPPROVCR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPPROVCR."COD_RED_CR"]')
          ParentFont = False
        end
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 1.779530000000000000
        Top = 234.330860000000000000
        Width = 1046.929810000000000000
        Condition = 'TPPROVBASE."ID_TITULO_PAGAR"'
        object Line1: TfrxLineView
          AllowVectorExport = True
          Top = 1.779529999999970000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Frame.Typ = []
        Height = 94.488250000000000000
        Top = 2108.977740000000000000
        Width = 1046.929810000000000000
        object Line2: TfrxLineView
          AllowVectorExport = True
          Top = 3.000000000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo20: TfrxMemoView
          AllowVectorExport = True
          Left = 753.567410000000000000
          Top = 11.338589999999800000
          Width = 151.181200000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DE D'#201'BITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo21: TfrxMemoView
          AllowVectorExport = True
          Left = 918.425790000000000000
          Top = 11.338589999999800000
          Width = 124.724490000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DE CR'#201'DITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo74: TfrxMemoView
          AllowVectorExport = True
          Left = 768.685530000000000000
          Top = 26.015770000000000000
          Width = 136.063080000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '['
            ''
            'SUM(<TPPROVDB."VALOR_TOTAL">,DT_TP_PROV_DB) +'
            'SUM(<TPBaixa."VALOR">,DT_TPB)+'
            'SUM(<TPBHistorico."VALOR">,DT_TPB_HIST)+'
            'SUM(<TPBAcrescimo."VALOR">,DT_TPB_AC)+'
            'SUM(<TRPROVDB."VALOR">,DT_TR_PROV_DB) +'
            ''
            'SUM(<TRBDeducao."VALOR">,DT_TRB_DEDUCAO)+'
            'SUM(<TRBCaixa."VALOR">,DT_TRB_CAIXA)+'
            'SUM(<TRBCheque."VALOR">,DT_TRB_CHEQUE)+'
            'SUM(<TRBBanco."VALOR">,DT_TRB_BANCO) +'
            'SUM(<TRFCAIXABANCO."VALOR">,MD_TRF_CX_BCO)+'
            'SUM(<CBT_C."VALOR">,DT_CBT_CR)+'
            'SUM(<TRFBCOCAIXA."VALOR">,MD_TRF_BCO_CX)'
            ']')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          AllowVectorExport = True
          Left = 907.087200000000000000
          Top = 26.015770000000000000
          Width = 136.063080000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '['
            'SUM(<TPPROVCR."VALOR_TOTAL">,DT_TP_PROV_CR) + '
            'SUM(<TPBDeducao."VALOR">,DT_TPB_DE)+ '
            'SUM(<TPBCaixa."VALOR">,DT_TPB_CAIXA)+ '
            'SUM(<TPBBanco."VALOR">,DT_TPB_BANCO)+'
            'SUM(<TPBCheque."VALOR">,DT_TPB_CHEQUE)+'
            'SUM(<TRPROVCR."VALOR">,DT_TR_PROV_CR)+'
            'SUM(<TRQUITADOS."VALOR">,MD_TR_QUITADO) + '
            'SUM(<TRBAcrescimo."VALOR">,DT_TRB_ACRESCIMO)+'
            'SUM(<TRFCAIXABANCO."VALOR">,MD_TRF_CX_BCO)+'
            'SUM(<CBT_D."VALOR">,DT_CBT_DB)+'
            'SUM(<TRFBCOCAIXA."VALOR">,MD_TRF_BCO_CX)'
            ']')
          ParentFont = False
        end
        object Memo138: TfrxMemoView
          AllowVectorExport = True
          Left = 753.567410000000000000
          Top = 60.472479999999900000
          Width = 151.181200000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'DIFEREN'#199'A APURADA ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo205: TfrxMemoView
          AllowVectorExport = True
          Left = 907.087200000000000000
          Top = 60.472479999999900000
          Width = 136.063080000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '['
            ''
            'SUM(<TPPROVDB."VALOR_TOTAL">,DT_TP_PROV_DB) +'
            'SUM(<TPBHistorico."VALOR">,DT_TPB_HIST)+'
            'SUM(<TPBaixa."VALOR">,DT_TPB)+'
            'SUM(<TPBAcrescimo."VALOR">,DT_TPB_AC)+'
            'SUM(<TRPROVDB."VALOR">,DT_TR_PROV_DB) +'
            ''
            'SUM(<TRBDeducao."VALOR">,DT_TRB_DEDUCAO)+'
            'SUM(<TRBCaixa."VALOR">,DT_TRB_CAIXA)+'
            'SUM(<TRBCheque."VALOR">,DT_TRB_CHEQUE)+'
            'SUM(<TRBBanco."VALOR">,DT_TRB_BANCO) +'
            'SUM(<TRFCAIXABANCO."VALOR">,MD_TRF_CX_BCO)+'
            'SUM(<CBT_C."VALOR">,DT_CBT_CR)+'
            'SUM(<TRFBCOCAIXA."VALOR">,MD_TRF_BCO_CX) -'
            ''
            'SUM(<TPPROVCR."VALOR_TOTAL">,DT_TP_PROV_CR) -'
            'SUM(<TPBDeducao."VALOR">,DT_TPB_DE)-'
            'SUM(<TPBCaixa."VALOR">,DT_TPB_CAIXA)- '
            'SUM(<TPBBanco."VALOR">,DT_TPB_BANCO)-'
            'SUM(<TPBCheque."VALOR">,DT_TPB_CHEQUE)-'
            'SUM(<TRPROVCR."VALOR">,DT_TR_PROV_CR)-'
            'SUM(<TRQUITADOS."VALOR">,MD_TR_QUITADO) -'
            'SUM(<TRBAcrescimo."VALOR">,DT_TRB_ACRESCIMO)-'
            'SUM(<TRFCAIXABANCO."VALOR">,MD_TRF_CX_BCO)-'
            'SUM(<CBT_D."VALOR">,DT_CBT_DB)-'
            'SUM(<TRFBCOCAIXA."VALOR">,MD_TRF_BCO_CX)'
            ']'
            ''
            ''
            ']')
          ParentFont = False
        end
      end
      object Memo41: TfrxMemoView
        AllowVectorExport = True
        Left = 7.559060000000000000
        Top = -7.559060000000000000
        Width = 49.133890000000000000
        Height = 15.118120000000000000
        DataSet = frxDBTitulos
        DataSetName = 'TRPROVBASE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'tahoma'
        Font.Style = []
        Frame.Typ = []
        ParentFont = False
      end
      object GroupFooter4: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456700240000000000
        Top = 374.173470000000000000
        Width = 1046.929810000000000000
        object Line25: TfrxLineView
          AllowVectorExport = True
          Left = 816.378626460000000000
          Top = 3.559059999999990000
          Width = 226.771653540000000000
          Color = clBlue
          ArrowSolid = True
          Frame.Style = fsDot
          Frame.Typ = [ftTop]
        end
        object SysMemo1: TfrxSysMemoView
          AllowVectorExport = True
          Left = 922.205320000000000000
          Top = 7.559059999999990000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<TPPROVCR."VALOR_TOTAL">,DT_TP_PROV_CR)]')
          ParentFont = False
        end
        object SysMemo2: TfrxSysMemoView
          AllowVectorExport = True
          Left = 783.803650000000000000
          Top = 7.559059999999990000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<TPPROVDB."VALOR_TOTAL">,DT_TP_PROV_DB)]')
          ParentFont = False
        end
      end
      object DT_TP_PROV_DB: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 298.582870000000000000
        Width = 1046.929810000000000000
        DataSetName = 'TPPROVDB'
        RowCount = 0
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 393.071120000000000000
          Width = 241.889920000000000000
          Height = 15.118110240000000000
          DataField = 'CCD_DSC'
          DataSetName = 'TPPROVDB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPPROVDB."CCD_DSC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          AllowVectorExport = True
          Left = 783.803650000000000000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DataField = 'VALOR_TOTAL'
          DataSetName = 'TPPROVDB'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPPROVDB."VALOR_TOTAL"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          DataField = 'CONTA_DB'
          DataSetName = 'TPPROVDB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPPROVDB."CONTA_DB"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataField = 'HST_CODIGO'
          DataSetName = 'TPPROVDB'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TPPROVDB."HST_CODIGO"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DataField = 'COD_RED_DB'
          DataSetName = 'TPPROVDB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPPROVDB."COD_RED_DB"]')
          ParentFont = False
        end
      end
      object MD_TP_QUITADO: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 495.118430000000000000
        Width = 1046.929810000000000000
        DataSet = dmEspelhoTP.frxDBTPQuitados
        DataSetName = 'TPQUITADOS'
        RowCount = 0
        object titulosPGQuitadosDATA_PAGAMENTO: TfrxMemoView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DataField = 'DATA_PAGAMENTO'
          DataSet = dmEspelhoTP.frxDBTPQuitados
          DataSetName = 'TPQUITADOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPQUITADOS."DATA_PAGAMENTO"]')
          ParentFont = False
          WordWrap = False
        end
        object titulosPGQuitadosNUMERO_DOCUMENTO: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataField = 'NUMERO_DOCUMENTO'
          DataSet = dmEspelhoTP.frxDBTPQuitados
          DataSetName = 'TPQUITADOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPQUITADOS."NUMERO_DOCUMENTO"]')
          ParentFont = False
          WordWrap = False
        end
        object titulosPGQuitadosDESCRICAO: TfrxMemoView
          AllowVectorExport = True
          Left = 181.346559210000000000
          Width = 139.842610000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRICAO'
          DataSet = dmEspelhoTP.frxDBTPQuitados
          DataSetName = 'TPQUITADOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPQUITADOS."DESCRICAO"]')
          ParentFont = False
          WordWrap = False
        end
        object titulosPGQuitadosTIPO: TfrxMemoView
          AllowVectorExport = True
          Left = 141.181200000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DataField = 'TIPO'
          DataSet = dmEspelhoTP.frxDBTPQuitados
          DataSetName = 'TPQUITADOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPQUITADOS."TIPO"]')
          ParentFont = False
          WordWrap = False
        end
        object titulosPGQuitadosDESCRICAO_REDUZIDA: TfrxMemoView
          AllowVectorExport = True
          Left = 455.882190000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRICAO_REDUZIDA'
          DataSet = dmEspelhoTP.frxDBTPQuitados
          DataSetName = 'TPQUITADOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPQUITADOS."DESCRICAO_REDUZIDA"]')
          ParentFont = False
          WordWrap = False
        end
        object titulosPGQuitadosNOME: TfrxMemoView
          AllowVectorExport = True
          Left = 323.819110000000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          DataField = 'NOME'
          DataSet = dmEspelhoTP.frxDBTPQuitados
          DataSetName = 'TPQUITADOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPQUITADOS."NOME"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader7: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677165350000000000
        Top = 423.307360000000000000
        Width = 1046.929810000000000000
        Condition = '1=1'
        StartNewPage = True
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Top = 7.559059999999990000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'PAGTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 181.346559210000000000
          Top = 7.559059999999990000
          Width = 124.724490000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo27: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Top = 7.559060000000040000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo28: TfrxMemoView
          AllowVectorExport = True
          Left = 141.181200000000000000
          Top = 7.559060000000040000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'TIPO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo29: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Top = 7.559059999999990000
          Width = 268.346630000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#211'D.HIST.                    DESCRI'#199#195'O CONT'#193'BIL')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo30: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Top = 7.559059999999990000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CONTA  CONT'#193'BIL')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo31: TfrxMemoView
          AllowVectorExport = True
          Left = 785.024120000000000000
          Top = 7.559059999999990000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'D'#201'BITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo32: TfrxMemoView
          AllowVectorExport = True
          Left = 944.882500000000000000
          Top = 7.559060000000040000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CR'#201'DITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Line6: TfrxLineView
          AllowVectorExport = True
          Left = 0.559060000000000000
          Top = 3.779530000000020000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo54: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Top = 7.559060000000040000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CD.REDUZ')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object DT_TPB_BANCO: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 721.890230000000000000
        Width = 1046.929810000000000000
        DataSet = dmEspelhoTP.frxTPBBanco
        DataSetName = 'TPBBanco'
        RowCount = 0
        object TPBBancoVALOR: TfrxMemoView
          AllowVectorExport = True
          Left = 944.882500000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = dmEspelhoTP.frxTPBBanco
          DataSetName = 'TPBBanco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBBanco."VALOR"]')
          ParentFont = False
        end
        object TPBBancoCONTA_CREDITO: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_CR'
          DataSet = dmEspelhoTP.frxTPBBanco
          DataSetName = 'TPBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBBanco."CONTA_CR"]')
          ParentFont = False
        end
        object TPBBancoDSC_CC: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_CONTA_CR'
          DataSet = dmEspelhoTP.frxTPBBanco
          DataSetName = 'TPBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBBanco."DSC_CONTA_CR"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'COD_RED_CR'
          DataSet = dmEspelhoTP.frxTPBBanco
          DataSetName = 'TPBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBBanco."COD_RED_CR"]')
          ParentFont = False
        end
        object Memo226: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'CDHIST'
          DataSet = dmEspelhoTP.frxTPBBanco
          DataSetName = 'TPBBanco'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBBanco."CDHIST"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object DT_TPB_CAIXA: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 684.094930000000000000
        Width = 1046.929810000000000000
        DataSet = dmEspelhoTP.frxDBTPBCaixa
        DataSetName = 'TPBCaixa'
        RowCount = 0
        object TPBCaixaVALOR_NOMINAL: TfrxMemoView
          AllowVectorExport = True
          Left = 944.882500000000000000
          Top = 2.779530000000020000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          DataField = 'VALOR'
          DataSet = dmEspelhoTP.frxDBTPBCaixa
          DataSetName = 'TPBCaixa'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBCaixa."VALOR"]')
          ParentFont = False
        end
        object TPBCaixaCONTA_CREDITO: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Top = 2.779530000000020000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_CREDITO'
          DataSet = dmEspelhoTP.frxDBTPBCaixa
          DataSetName = 'TPBCaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBCaixa."CONTA_CREDITO"]')
          ParentFont = False
        end
        object TPBCaixaDSC_CC: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Top = 2.779530000000020000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_CC'
          DataSet = dmEspelhoTP.frxDBTPBCaixa
          DataSetName = 'TPBCaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBCaixa."DSC_CC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Top = 2.779530000000020000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'CODREDUZ'
          DataSet = dmEspelhoTP.frxDBTPBCaixa
          DataSetName = 'TPBCaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBCaixa."CODREDUZ"]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Top = 2.779530000000020000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'HST_COD'
          DataSet = dmEspelhoTP.frxDBTPBCaixa
          DataSetName = 'TPBCaixa'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBCaixa."HST_COD"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader9: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 1.779530000000000000
        Top = 468.661720000000000000
        Width = 1046.929810000000000000
        Condition = 'TPQUITADOS."ID_TITULO_PAGAR"'
        object Line5: TfrxLineView
          AllowVectorExport = True
          Top = 1.779530000000020000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object DT_TPB_HIST: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 570.709030000000000000
        Width = 1046.929810000000000000
        DataSet = dmEspelhoTP.frxTPBHistorico
        DataSetName = 'TPBHistorico'
        RowCount = 0
        object Memo34: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DataField = 'HST_DSC'
          DataSet = dmEspelhoTP.frxTPBHistorico
          DataSetName = 'TPBHistorico'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBHistorico."HST_DSC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          AllowVectorExport = True
          Left = 783.803650000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = dmEspelhoTP.frxTPBHistorico
          DataSetName = 'TPBHistorico'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBHistorico."VALOR"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'HST_COD'
          DataSet = dmEspelhoTP.frxTPBHistorico
          DataSetName = 'TPBHistorico'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBHistorico."HST_COD"]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CONTA_DB'
          DataSet = dmEspelhoTP.frxTPBHistorico
          DataSetName = 'TPBHistorico'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBHistorico."CONTA_DB"]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DataField = 'COD_RED_DB'
          DataSet = dmEspelhoTP.frxTPBHistorico
          DataSetName = 'TPBHistorico'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBHistorico."COD_RED_DB"]')
          ParentFont = False
        end
      end
      object DT_TPB_DE: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 646.299630000000000000
        Width = 1046.929810000000000000
        DataSet = dmEspelhoTP.frxTPBDeducao
        DataSetName = 'TPBDeducao'
        RowCount = 0
        object tpbDeducaoVALOR: TfrxMemoView
          AllowVectorExport = True
          Left = 944.882500000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = dmEspelhoTP.frxTPBDeducao
          DataSetName = 'TPBDeducao'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBDeducao."VALOR"]')
          ParentFont = False
        end
        object tpbDeducaoCONTA: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA'
          DataSet = dmEspelhoTP.frxTPBDeducao
          DataSetName = 'TPBDeducao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBDeducao."CONTA"]')
          ParentFont = False
        end
        object tpbDeducaoCODREDUZ: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'CODREDUZ'
          DataSet = dmEspelhoTP.frxTPBDeducao
          DataSetName = 'TPBDeducao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBDeducao."CODREDUZ"]')
          ParentFont = False
        end
        object tpbDeducaoDSC_HIST: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_HIST'
          DataSet = dmEspelhoTP.frxTPBDeducao
          DataSetName = 'TPBDeducao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBDeducao."DSC_HIST"]')
          ParentFont = False
          WordWrap = False
        end
        object tpbDeducaoCODIGO: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'CODIGO'
          DataSet = dmEspelhoTP.frxTPBDeducao
          DataSetName = 'TPBDeducao'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBDeducao."CODIGO"]')
          ParentFont = False
        end
      end
      object DT_TPB_AC: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 608.504330000000000000
        Width = 1046.929810000000000000
        DataSet = dmEspelhoTP.frxTPBAcrescimo
        DataSetName = 'TPBAcrescimo'
        RowCount = 0
        object Memo55: TfrxMemoView
          AllowVectorExport = True
          Left = 783.803650000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = dmEspelhoTP.frxTPBAcrescimo
          DataSetName = 'TPBAcrescimo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBAcrescimo."VALOR"]')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA'
          DataSet = dmEspelhoTP.frxTPBAcrescimo
          DataSetName = 'TPBAcrescimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBAcrescimo."CONTA"]')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'CODREDUZ'
          DataSet = dmEspelhoTP.frxTPBAcrescimo
          DataSetName = 'TPBAcrescimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBAcrescimo."CODREDUZ"]')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_HIST'
          DataSet = dmEspelhoTP.frxTPBAcrescimo
          DataSetName = 'TPBAcrescimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBAcrescimo."DSC_HIST"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo59: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'CODIGO'
          DataSet = dmEspelhoTP.frxTPBAcrescimo
          DataSetName = 'TPBAcrescimo'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBAcrescimo."CODIGO"]')
          ParentFont = False
        end
      end
      object DT_TPB_CHEQUE: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 759.685530000000000000
        Width = 1046.929810000000000000
        DataSet = dmEspelhoTP.frxTPBCheque
        DataSetName = 'TPBCheque'
        RowCount = 0
        object Memo68: TfrxMemoView
          AllowVectorExport = True
          Left = 944.882500000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = dmEspelhoTP.frxTPBCheque
          DataSetName = 'TPBCheque'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBCheque."VALOR"]')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'COD_REDUZ_CREDITO'
          DataSet = dmEspelhoTP.frxTPBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBCheque."COD_REDUZ_CREDITO"]')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_CONTABIL_CREDITO'
          DataSet = dmEspelhoTP.frxTPBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBCheque."CONTA_CONTABIL_CREDITO"]')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_CC_CREDITO'
          DataSet = dmEspelhoTP.frxTPBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBCheque."DSC_CC_CREDITO"]')
          ParentFont = False
        end
        object Memo227: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'CDHIST'
          DataSet = dmEspelhoTP.frxTPBCheque
          DataSetName = 'TPBCheque'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBCheque."CDHIST"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupFooter5: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456692910000000000
        Top = 797.480830000000000000
        Width = 1046.929810000000000000
        object Line24: TfrxLineView
          AllowVectorExport = True
          Left = 816.378626460000000000
          Width = 226.771653540000000000
          Color = clBlue
          ArrowSolid = True
          Frame.Style = fsDot
          Frame.Typ = [ftTop]
        end
        object SysMemo5: TfrxSysMemoView
          AllowVectorExport = True
          Left = 783.803650000000000000
          Top = 2.559060000000050000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<TPBaixa."VALOR">,DT_TPB)+SUM(<TPBHistorico."VALOR">,DT_TPB' +
              '_HIST)+SUM(<TPBAcrescimo."VALOR">,DT_TPB_AC)]')
          ParentFont = False
        end
        object SysMemo6: TfrxSysMemoView
          AllowVectorExport = True
          Left = 922.205320000000000000
          Top = 2.559060000000050000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<TPBDeducao."VALOR">,DT_TPB_DE)+ SUM(<TPBCaixa."VALOR">,DT_' +
              'TPB_CAIXA)+ SUM(<TPBBanco."VALOR">,DT_TPB_BANCO)+SUM(<TPBCheque.' +
              '"VALOR">,DT_TPB_CHEQUE)]')
          ParentFont = False
        end
        object Memo217: TfrxMemoView
          AllowVectorExport = True
          Left = 313.700990000000000000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          Frame.Typ = []
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 2226.143170000000000000
        Width = 1046.929810000000000000
        object Memo36: TfrxMemoView
          AllowVectorExport = True
          Left = -0.661410000000000000
          Top = 1.779529999999800000
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
          Left = 933.528140000000000000
          Top = 1.779529999999800000
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
          Left = 860.512370000000000000
          Top = 1.779529999999800000
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
          Left = 994.016390000000000000
          Top = 1.779529999999800000
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
      object GroupHeader6: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 846.614720000000000000
        Width = 1046.929810000000000000
        Condition = '1=1'
        StartNewPage = True
        object Memo43: TfrxMemoView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Top = 7.559059999999930000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'EMISS'#195'O')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo44: TfrxMemoView
          AllowVectorExport = True
          Left = 181.346559210000000000
          Top = 7.559059999999930000
          Width = 124.724490000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo38: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Top = 7.559060000000040000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo39: TfrxMemoView
          AllowVectorExport = True
          Left = 141.181200000000000000
          Top = 7.559059999999930000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'TIPO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo48: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Top = 7.559060000000040000
          Width = 268.346630000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#211'D.HIST.                    DESCRI'#199#195'O CONT'#193'BIL')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo49: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Top = 7.559060000000040000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CONTA  CONT'#193'BIL')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo50: TfrxMemoView
          AllowVectorExport = True
          Left = 785.024120000000000000
          Top = 7.559059999999930000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'D'#201'BITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo51: TfrxMemoView
          AllowVectorExport = True
          Left = 944.882500000000000000
          Top = 7.559059999999930000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CR'#201'DITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo53: TfrxMemoView
          AllowVectorExport = True
          Left = 588.370440000000000000
          Top = 7.559059999999930000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'PARCELA')
          ParentFont = False
        end
        object Line3: TfrxLineView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Top = 3.779530000000140000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo60: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Top = 7.559060000000040000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CD.REDUZ')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object GF_TR_PROV: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456692910000000000
        Top = 1031.811690000000000000
        Width = 1046.929810000000000000
        object Line8: TfrxLineView
          AllowVectorExport = True
          Left = 789.921770000000000000
          Width = 253.228510000000000000
          Color = clBlack
          Frame.Style = fsDot
          Frame.Typ = [ftTop]
        end
        object SysMemo7: TfrxSysMemoView
          AllowVectorExport = True
          Left = 783.803650000000000000
          Top = 1.559060000000050000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<TRPROVDB."VALOR">,DT_TR_PROV_DB)]')
          ParentFont = False
        end
        object SysMemo8: TfrxSysMemoView
          AllowVectorExport = True
          Left = 922.205320000000000000
          Top = 1.559060000000050000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<TRPROVCR."VALOR">,DT_TR_PROV_CR)]')
          ParentFont = False
        end
      end
      object MT_TR_PROV: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 918.425790000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBTitulos
        DataSetName = 'TRPROVBASE'
        RowCount = 0
        object Memo75: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Width = 75.590600000000000000
          Height = 15.118110240000000000
          DataField = 'NUMERO_DOCUMENTO'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."NUMERO_DOCUMENTO"]')
          ParentFont = False
        end
        object Memo185: TfrxMemoView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataField = 'DATA_EMISSAO'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."DATA_EMISSAO"]')
          ParentFont = False
        end
        object Memo186: TfrxMemoView
          AllowVectorExport = True
          Left = 196.464679210000000000
          Width = 124.724490000000000000
          Height = 15.118110240000000000
          DataField = 'DESCRICAO'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."DESCRICAO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo187: TfrxMemoView
          AllowVectorExport = True
          Left = 588.370440000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DataField = 'PARCELA'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRPROVBASE."PARCELA"]')
          ParentFont = False
        end
        object Memo188: TfrxMemoView
          AllowVectorExport = True
          Left = 141.181200000000000000
          Width = 37.795300000000000000
          Height = 15.118110240000000000
          DataField = 'TIPO'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."TIPO"]')
          ParentFont = False
        end
        object Memo189: TfrxMemoView
          AllowVectorExport = True
          Left = 323.819110000000000000
          Width = 268.346630000000000000
          Height = 15.118110240000000000
          DataField = 'CLIENTE'
          DataSet = frxDBTitulos
          DataSetName = 'TRPROVBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVBASE."CLIENTE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader34: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        Height = 3.779527559055120000
        ParentFont = False
        Top = 891.969080000000000000
        Width = 1046.929810000000000000
        Condition = 'TRPROVBASE."ID_TITULO_RECEBER"'
        object Line4: TfrxLineView
          AllowVectorExport = True
          Top = 3.220469999999980000
          Width = 1043.150280000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object DT_TR_PROV_CR: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 994.016390000000000000
        Width = 1046.929810000000000000
        DataSet = frxTRPROVCR
        DataSetName = 'TRPROVCR'
        RowCount = 0
        object Memo61: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Width = 241.889920000000000000
          Height = 15.118110240000000000
          DataField = 'CCD_DSC'
          DataSet = frxTRPROVCR
          DataSetName = 'TRPROVCR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVCR."CCD_DSC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo62: TfrxMemoView
          AllowVectorExport = True
          Left = 922.205320000000000000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DataField = 'VALOR'
          DataSet = frxTRPROVCR
          DataSetName = 'TRPROVCR'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRPROVCR."VALOR"]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          DataField = 'CONTA_DB'
          DataSet = frxTRPROVCR
          DataSetName = 'TRPROVCR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRPROVCR."CONTA_DB"]')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataField = 'HST_CODIGO'
          DataSet = frxTRPROVCR
          DataSetName = 'TRPROVCR'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRPROVCR."HST_CODIGO"]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DataField = 'COD_RED_DB'
          DataSet = frxTRPROVCR
          DataSetName = 'TRPROVCR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRPROVCR."COD_RED_DB"]')
          ParentFont = False
        end
      end
      object DT_TR_PROV_DB: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 956.221090000000000000
        Width = 1046.929810000000000000
        DataSetName = 'TRPROVDB'
        RowCount = 0
        object Memo66: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Width = 241.889920000000000000
          Height = 15.118110240000000000
          DataField = 'CCC_DSC'
          DataSetName = 'TRPROVDB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRPROVDB."CCC_DSC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo67: TfrxMemoView
          AllowVectorExport = True
          Left = 783.803650000000000000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DataField = 'VALOR'
          DataSetName = 'TRPROVDB'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRPROVDB."VALOR"]')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          DataField = 'CONTA_CR'
          DataSetName = 'TRPROVDB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRPROVDB."CONTA_CR"]')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataField = 'COD_HIST'
          DataSetName = 'TRPROVDB'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRPROVDB."COD_HIST"]')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DataField = 'COD_RED_CR'
          DataSetName = 'TRPROVDB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRPROVDB."COD_RED_CR"]')
          ParentFont = False
        end
      end
      object GroupHeader14: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 1.889763780000000000
        Top = 1126.299940000000000000
        Width = 1046.929810000000000000
        Condition = 'TRQUITADOS."ID_TITULO_RECEBER"'
        object Line9: TfrxLineView
          AllowVectorExport = True
          Top = 0.220469999999978000
          Width = 1050.709340000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MD_TR_QUITADO: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 1152.756650000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBTRQuitados
        DataSetName = 'TRQUITADOS'
        RowCount = 0
        object Memo80: TfrxMemoView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DataField = 'DATA_PAGAMENTO'
          DataSet = frxDBTRQuitados
          DataSetName = 'TRQUITADOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRQUITADOS."DATA_PAGAMENTO"]')
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DataField = 'NUMERO_DOCUMENTO'
          DataSet = frxDBTRQuitados
          DataSetName = 'TRQUITADOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRQUITADOS."NUMERO_DOCUMENTO"]')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          AllowVectorExport = True
          Left = 141.181200000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          DataField = 'TIPO'
          DataSet = frxDBTRQuitados
          DataSetName = 'TRQUITADOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRQUITADOS."TIPO"]')
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          AllowVectorExport = True
          Left = 181.346559210000000000
          Width = 139.842610000000000000
          Height = 11.338590000000000000
          DataField = 'DESCRICAO'
          DataSet = frxDBTRQuitados
          DataSetName = 'TRQUITADOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRQUITADOS."DESCRICAO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo84: TfrxMemoView
          AllowVectorExport = True
          Left = 323.819110000000000000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          DataField = 'NOME'
          DataSet = frxDBTRQuitados
          DataSetName = 'TRQUITADOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRQUITADOS."NOME"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo85: TfrxMemoView
          AllowVectorExport = True
          Left = 455.882190000000000000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          DataField = 'DESCRICAO_REDUZIDA'
          DataSet = frxDBTRQuitados
          DataSetName = 'TRQUITADOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRQUITADOS."DESCRICAO_REDUZIDA"]')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          AllowVectorExport = True
          Left = 587.149970000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DataField = 'PARCELA'
          DataSet = frxDBTRQuitados
          DataSetName = 'TRQUITADOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRQUITADOS."PARCELA"]')
          ParentFont = False
        end
      end
      object GroupHeader16: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 1080.945580000000000000
        Width = 1046.929810000000000000
        Condition = '1=1'
        StartNewPage = True
        object Line10: TfrxLineView
          AllowVectorExport = True
          Top = 3.779529999999800000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo89: TfrxMemoView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Top = 7.559060000000040000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'REBTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo91: TfrxMemoView
          AllowVectorExport = True
          Left = 181.346559210000000000
          Top = 7.559060000000040000
          Width = 124.724490000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo92: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Top = 7.559060000000040000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo93: TfrxMemoView
          AllowVectorExport = True
          Left = 141.181200000000000000
          Top = 7.559060000000040000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'TIPO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo94: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Top = 7.559060000000040000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CONTA  CONT'#193'BIL')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo95: TfrxMemoView
          AllowVectorExport = True
          Left = 785.024120000000000000
          Top = 7.559060000000040000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'D'#201'BITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo96: TfrxMemoView
          AllowVectorExport = True
          Left = 946.102970000000000000
          Top = 7.559060000000040000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CR'#201'DITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo97: TfrxMemoView
          AllowVectorExport = True
          Left = 588.370440000000000000
          Top = 7.559060000000040000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'PARCELA')
          ParentFont = False
        end
        object Line11: TfrxLineView
          AllowVectorExport = True
          Left = 0.559060000000000000
          Top = 3.779530000000020000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo98: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Top = 7.559060000000040000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CD.REDUZ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo99: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Top = 7.559060000000040000
          Width = 268.346630000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#211'D.HIST.                    DESCRI'#199#195'O CONT'#193'BIL')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object DT_TRB_CAIXA: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 1228.347250000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBTRBCaixa
        DataSetName = 'TRBCaixa'
        RowCount = 0
        object Memo100: TfrxMemoView
          AllowVectorExport = True
          Left = 807.701300000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = frxDBTRBCaixa
          DataSetName = 'TRBCaixa'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBCaixa."VALOR"]')
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_DB'
          DataSet = frxDBTRBCaixa
          DataSetName = 'TRBCaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBCaixa."CONTA_DB"]')
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'COD_RED_DB'
          DataSet = frxDBTRBCaixa
          DataSetName = 'TRBCaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBCaixa."COD_RED_DB"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo103: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DataField = 'CTA_DB__DSC'
          DataSet = frxDBTRBCaixa
          DataSetName = 'TRBCaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRBCaixa."CTA_DB__DSC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo130: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'HIST_COD'
          DataSet = frxDBTRBCaixa
          DataSetName = 'TRBCaixa'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRBCaixa."HIST_COD"]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object DT_TRB_BANCO: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 1303.937850000000000000
        Width = 1046.929810000000000000
        DataSet = frxTRBBanco
        DataSetName = 'TRBBanco'
        RowCount = 0
        object Memo105: TfrxMemoView
          AllowVectorExport = True
          Left = 807.701300000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = frxTRBBanco
          DataSetName = 'TRBBanco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBBanco."VALOR"]')
          ParentFont = False
        end
        object Memo106: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_CD_DB'
          DataSet = frxTRBBanco
          DataSetName = 'TRBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRBBanco."DSC_CD_DB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo107: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_DB'
          DataSet = frxTRBBanco
          DataSetName = 'TRBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBBanco."CONTA_DB"]')
          ParentFont = False
        end
        object Memo108: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'COD_RED_DB'
          DataSet = frxTRBBanco
          DataSetName = 'TRBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBBanco."COD_RED_DB"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo109: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Width = 234.330860000000000000
          Height = 11.338590000000000000
          DataField = 'DESCRICAO'
          DataSet = frxTRBBanco
          DataSetName = 'TRBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRBBanco."DESCRICAO"]')
          ParentFont = False
        end
        object Memo228: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'CDHIST'
          DataSet = frxTRBBanco
          DataSetName = 'TRBBanco'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRBBanco."CDHIST"]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object DT_TRB_CHEQUE: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 1266.142550000000000000
        Width = 1046.929810000000000000
        DataSet = frxTRBCheque
        DataSetName = 'TRBCheque'
        RowCount = 0
        object Memo110: TfrxMemoView
          AllowVectorExport = True
          Left = 807.701300000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = frxTRBCheque
          DataSetName = 'TRBCheque'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBCheque."VALOR"]')
          ParentFont = False
        end
        object Memo111: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_DB'
          DataSet = frxTRBCheque
          DataSetName = 'TRBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBCheque."CONTA_DB"]')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'COD_RED_DB'
          DataSet = frxTRBCheque
          DataSetName = 'TRBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBCheque."COD_RED_DB"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo113: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_DSC_DB'
          DataSet = frxTRBCheque
          DataSetName = 'TRBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRBCheque."CONTA_DSC_DB"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo114: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Width = 234.330860000000000000
          Height = 11.338590000000000000
          DataField = 'HIST_DSC'
          DataSet = frxTRBCheque
          DataSetName = 'TRBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRBCheque."HIST_DSC"]')
          ParentFont = False
        end
        object Memo129: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Top = 1.000000000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'HIST_COD'
          DataSet = frxTRBCheque
          DataSetName = 'TRBCheque'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRBCheque."HIST_COD"]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object DT_TRB_ACRESCIMO: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 1341.733150000000000000
        Width = 1046.929810000000000000
        DataSet = frxTRBAcrescimo
        DataSetName = 'TRBAcrescimo'
        RowCount = 0
        object Memo115: TfrxMemoView
          AllowVectorExport = True
          Left = 946.102970000000000000
          Top = 0.559060000000045000
          Width = 98.267780000000000000
          Height = 15.118110240000000000
          DataField = 'VALOR'
          DataSet = frxTRBAcrescimo
          DataSetName = 'TRBAcrescimo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBAcrescimo."VALOR"]')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Top = 0.559060000000045000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'CODREDUZ'
          DataSet = frxTRBAcrescimo
          DataSetName = 'TRBAcrescimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBAcrescimo."CODREDUZ"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo117: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Top = 0.559060000000045000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA'
          DataSet = frxTRBAcrescimo
          DataSetName = 'TRBAcrescimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBAcrescimo."CONTA"]')
          ParentFont = False
        end
        object Memo118: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Top = 0.559060000000045000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_CONTA'
          DataSet = frxTRBAcrescimo
          DataSetName = 'TRBAcrescimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRBAcrescimo."DSC_CONTA"]')
          ParentFont = False
        end
        object Memo119: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Top = 0.559060000000045000
          Width = 234.330860000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_DEDUCAO'
          DataSet = frxTRBAcrescimo
          DataSetName = 'TRBAcrescimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRBAcrescimo."DSC_DEDUCAO"]')
          ParentFont = False
        end
        object Memo131: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'COD_HIST'
          DataSet = frxTRBAcrescimo
          DataSetName = 'TRBAcrescimo'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRBAcrescimo."COD_HIST"]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object DT_TRB_DEDUCAO: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 1190.551950000000000000
        Width = 1046.929810000000000000
        DataSet = frxTRBDeducao
        DataSetName = 'TRBDeducao'
        RowCount = 0
        object Memo120: TfrxMemoView
          AllowVectorExport = True
          Left = 807.701300000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          DataField = 'VALOR'
          DataSet = frxTRBDeducao
          DataSetName = 'TRBDeducao'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBDeducao."VALOR"]')
          ParentFont = False
        end
        object Memo121: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'CODREDUZ'
          DataSet = frxTRBDeducao
          DataSetName = 'TRBDeducao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBDeducao."CODREDUZ"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo122: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA'
          DataSet = frxTRBDeducao
          DataSetName = 'TRBDeducao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBDeducao."CONTA"]')
          ParentFont = False
        end
        object Memo123: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_CONTA'
          DataSet = frxTRBDeducao
          DataSetName = 'TRBDeducao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRBDeducao."DSC_CONTA"]')
          ParentFont = False
        end
        object Memo124: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'COD_HIST'
          DataSet = frxTRBDeducao
          DataSetName = 'TRBDeducao'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRBDeducao."COD_HIST"]')
          ParentFont = False
        end
      end
      object GroupFooter3: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 1417.323750000000000000
        Width = 1046.929810000000000000
        object Line22: TfrxLineView
          AllowVectorExport = True
          Left = 774.803650000000000000
          Width = 268.346630000000000000
          Color = clBlack
          Frame.Style = fsDot
          Frame.Typ = [ftTop]
        end
        object Memo125: TfrxMemoView
          AllowVectorExport = True
          Left = 923.425790000000000000
          Top = 5.559060000000040000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[ SUM(<TRBaixa."VALOR">,DT_TRB_BAIXA) + SUM(<TRBAcrescimo."VALOR' +
              '">,DT_TRB_ACRESCIMO) ]')
          ParentFont = False
        end
        object Memo126: TfrxMemoView
          AllowVectorExport = True
          Left = 785.024120000000000000
          Top = 5.559060000000040000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ '
            'SUM(<TRBDeducao."VALOR">,DT_TRB_DEDUCAO)+'
            'SUM(<TRBCaixa."VALOR">,DT_TRB_CAIXA)+'
            'SUM(<TRBCheque."VALOR">,DT_TRB_CHEQUE)+'
            'SUM(<TRBBanco."VALOR">,DT_TRB_BANCO)'
            ']')
          ParentFont = False
        end
      end
      object DT_TRB_BAIXA: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 1379.528450000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBTRB
        DataSetName = 'TRBaixa'
        RowCount = 0
        object tituloRBaixaVALOR_PAGO: TfrxMemoView
          AllowVectorExport = True
          Left = 946.102970000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          DataField = 'VALOR'
          DataSet = frxDBTRB
          DataSetName = 'TRBaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBaixa."VALOR"]')
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_CREDITO'
          DataSet = frxDBTRB
          DataSetName = 'TRBaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBaixa."CONTA_CREDITO"]')
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'COD_REDUZ_CREDITO'
          DataSet = frxDBTRB
          DataSetName = 'TRBaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRBaixa."COD_REDUZ_CREDITO"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo127: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_HIST'
          DataSet = frxDBTRB
          DataSetName = 'TRBaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRBaixa."DSC_HIST"]')
          ParentFont = False
        end
        object Memo128: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'CODIGO_HIST'
          DataSet = frxDBTRB
          DataSetName = 'TRBaixa'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRBaixa."CODIGO_HIST"]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 1.889763780000000000
        Top = 1515.591530000000000000
        Width = 1046.929810000000000000
        Condition = 'TRFCAIXABANCO."ID_CONTA_BANCARIA_CREDITO"'
        object Line12: TfrxLineView
          AllowVectorExport = True
          Top = 0.220469999999978000
          Width = 1050.709340000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader4: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 1470.237170000000000000
        Width = 1046.929810000000000000
        Condition = '1=1'
        StartNewPage = True
        object Line13: TfrxLineView
          AllowVectorExport = True
          Top = 3.779529999999800000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo104: TfrxMemoView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Top = 7.559060000000040000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'TRANSF.')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo132: TfrxMemoView
          AllowVectorExport = True
          Left = 181.346559210000000000
          Top = 7.559060000000040000
          Width = 124.724490000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo133: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Top = 7.559060000000040000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo134: TfrxMemoView
          AllowVectorExport = True
          Left = 141.181200000000000000
          Top = 7.559060000000040000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'TIPO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo135: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Top = 7.559060000000040000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CONTA  CONT'#193'BIL')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo136: TfrxMemoView
          AllowVectorExport = True
          Left = 785.024120000000000000
          Top = 7.559060000000040000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'D'#201'BITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo137: TfrxMemoView
          AllowVectorExport = True
          Left = 946.102970000000000000
          Top = 7.559060000000040000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CR'#201'DITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Line14: TfrxLineView
          AllowVectorExport = True
          Left = 0.559060000000000000
          Top = 3.779530000000020000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo139: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Top = 7.559060000000040000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CD.REDUZ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo140: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Top = 7.559060000000040000
          Width = 268.346630000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#211'D.HIST.                    DESCRI'#199#195'O CONT'#193'BIL')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object MD_TRF_CX_BCO: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 34.015770000000000000
        Top = 1542.048240000000000000
        Width = 1046.929810000000000000
        DataSetName = 'TRFCAIXABANCO'
        RowCount = 0
        object Memo141: TfrxMemoView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DataField = 'DATA_MOVIMENTO'
          DataSetName = 'TRFCAIXABANCO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRFCAIXABANCO."DATA_MOVIMENTO"]')
          ParentFont = False
        end
        object Memo142: TfrxMemoView
          AllowVectorExport = True
          Left = 181.346559210000000000
          Width = 124.724490000000000000
          Height = 11.338590000000000000
          DataField = 'TIPO_OPERACAO'
          DataSetName = 'TRFCAIXABANCO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRFCAIXABANCO."TIPO_OPERACAO"]')
          ParentFont = False
        end
        object Memo143: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DataField = 'IDENTIFICACAO'
          DataSetName = 'TRFCAIXABANCO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRFCAIXABANCO."IDENTIFICACAO"]')
          ParentFont = False
        end
        object Memo144: TfrxMemoView
          AllowVectorExport = True
          Left = 136.063080000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          DataField = 'TIPO_OPERACAO'
          DataSetName = 'TRFCAIXABANCO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRFCAIXABANCO."TIPO_OPERACAO"]')
          ParentFont = False
        end
        object Memo145: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'TOB_CODIGO'
          DataSetName = 'TRFCAIXABANCO'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRFCAIXABANCO."TOB_CODIGO"]')
          ParentFont = False
        end
        object Memo146: TfrxMemoView
          AllowVectorExport = True
          Left = 393.850650000000000000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_CC_DB'
          DataSetName = 'TRFCAIXABANCO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRFCAIXABANCO."DSC_CC_DB"]')
          ParentFont = False
        end
        object Memo147: TfrxMemoView
          AllowVectorExport = True
          Left = 393.850650000000000000
          Top = 15.118120000000100000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_CC_CR'
          DataSetName = 'TRFCAIXABANCO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRFCAIXABANCO."DSC_CC_CR"]')
          ParentFont = False
        end
        object Memo148: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_CONTABIL_DB'
          DataSetName = 'TRFCAIXABANCO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFCAIXABANCO."CONTA_CONTABIL_DB"]')
          ParentFont = False
        end
        object Memo149: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Top = 15.118120000000100000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_CONTABIL_CR'
          DataSetName = 'TRFCAIXABANCO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFCAIXABANCO."CONTA_CONTABIL_CR"]')
          ParentFont = False
        end
        object Memo150: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'COD_REDUZ_DB'
          DataSetName = 'TRFCAIXABANCO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFCAIXABANCO."COD_REDUZ_DB"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo151: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Top = 13.677179999999900000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'COD_REDUZ_CR'
          DataSetName = 'TRFCAIXABANCO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFCAIXABANCO."COD_REDUZ_CR"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo152: TfrxMemoView
          AllowVectorExport = True
          Left = 807.701300000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSetName = 'TRFCAIXABANCO'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFCAIXABANCO."VALOR"]')
          ParentFont = False
        end
        object Memo153: TfrxMemoView
          AllowVectorExport = True
          Left = 946.102970000000000000
          Top = 15.118120000000100000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSetName = 'TRFCAIXABANCO'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFCAIXABANCO."VALOR"]')
          ParentFont = False
        end
        object Memo154: TfrxMemoView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Top = 13.677179999999900000
          Width = 302.362400000000000000
          Height = 11.338590000000000000
          DataField = 'DESCRICAO'
          DataSetName = 'TRFCAIXABANCO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRFCAIXABANCO."DESCRICAO"]')
          ParentFont = False
        end
        object Memo221: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Top = 15.118120000000100000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'TOB_CODIGO'
          DataSetName = 'TRFCAIXABANCO'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRFCAIXABANCO."TOB_CODIGO"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 30.236220470000000000
        Top = 2018.269020000000000000
        Width = 1046.929810000000000000
        object Line15: TfrxLineView
          AllowVectorExport = True
          Left = 774.803650000000000000
          Width = 268.346630000000000000
          Color = clBlack
          Frame.Style = fsDot
          Frame.Typ = [ftTop]
        end
        object Memo155: TfrxMemoView
          AllowVectorExport = True
          Left = 923.425790000000000000
          Top = 5.559060000000040000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<TRFBCOCAIXA."VALOR">,MD_TRF_BCO_CX)]')
          ParentFont = False
        end
        object Memo156: TfrxMemoView
          AllowVectorExport = True
          Left = 785.024120000000000000
          Top = 5.559060000000040000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<TRFBCOCAIXA."VALOR">,MD_TRF_BCO_CX)]')
          ParentFont = False
        end
      end
      object GroupHeader5: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 1.889763780000000000
        Top = 1697.008970000000000000
        Width = 1046.929810000000000000
        Condition = 'CBTBASE."ID_CONTA_BANCARIA_TRANSFERENCIA"'
        object Line16: TfrxLineView
          AllowVectorExport = True
          Top = 0.220469999999978000
          Width = 1050.709340000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader8: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 1651.654610000000000000
        Width = 1046.929810000000000000
        Condition = '1=1'
        object Line17: TfrxLineView
          AllowVectorExport = True
          Top = 3.779529999999800000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo157: TfrxMemoView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Top = 7.559060000000040000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DATA ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo158: TfrxMemoView
          AllowVectorExport = True
          Left = 181.346559210000000000
          Top = 7.559060000000040000
          Width = 124.724490000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo159: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Top = 7.559060000000040000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo160: TfrxMemoView
          AllowVectorExport = True
          Left = 141.181200000000000000
          Top = 7.559060000000040000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'TIPO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo161: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Top = 7.559060000000040000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CONTA  CONT'#193'BIL')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo162: TfrxMemoView
          AllowVectorExport = True
          Left = 785.024120000000000000
          Top = 7.559060000000040000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'D'#201'BITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo163: TfrxMemoView
          AllowVectorExport = True
          Left = 946.102970000000000000
          Top = 7.559060000000040000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CR'#201'DITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Line18: TfrxLineView
          AllowVectorExport = True
          Left = 0.559060000000000000
          Top = 3.779530000000020000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo165: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Top = 7.559060000000040000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CD.REDUZ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo166: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Top = 7.559060000000040000
          Width = 268.346630000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#211'D.HIST.                    DESCRI'#199#195'O CONT'#193'BIL')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object MD_CBT_BASE: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 1723.465680000000000000
        Width = 1046.929810000000000000
        DataSetName = 'CBTBASE'
        RowCount = 0
        object Memo167: TfrxMemoView
          AllowVectorExport = True
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DataField = 'DATA_MOVIMENTO'
          DataSetName = 'CBTBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[CBTBASE."DATA_MOVIMENTO"]')
          ParentFont = False
        end
        object Memo168: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DataField = 'IDENTIFICACAO'
          DataSetName = 'CBTBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[CBTBASE."IDENTIFICACAO"]')
          ParentFont = False
        end
        object Memo169: TfrxMemoView
          AllowVectorExport = True
          Left = 141.181200000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          DataField = 'TIPO'
          DataSetName = 'CBTBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CBTBASE."TIPO"]')
          ParentFont = False
        end
        object Memo170: TfrxMemoView
          AllowVectorExport = True
          Left = 181.346559210000000000
          Width = 124.724490000000000000
          Height = 11.338590000000000000
          DataField = 'ID_TIPO_OPERACAO_BANCARIA'
          DataSetName = 'CBTBASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[CBTBASE."ID_TIPO_OPERACAO_BANCARIA"]')
          ParentFont = False
        end
      end
      object DT_CBT_CR: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 1761.260980000000000000
        Width = 1046.929810000000000000
        DataSetName = 'CBT_C'
        RowCount = 0
        object Memo172: TfrxMemoView
          AllowVectorExport = True
          Width = 302.362400000000000000
          Height = 11.338590000000000000
          DataField = 'DESCRICAO'
          DataSetName = 'CBT_C'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[CBT_C."DESCRICAO"]')
          ParentFont = False
        end
        object Memo173: TfrxMemoView
          AllowVectorExport = True
          Left = 518.354670000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_CORRENTE_CREDITO'
          DataSetName = 'CBT_C'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[CBT_C."CONTA_CORRENTE_CREDITO"]')
          ParentFont = False
        end
        object Memo174: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Width = 124.724490000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_CC_DB'
          DataSetName = 'CBT_C'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[CBT_C."DSC_CC_DB"]')
          ParentFont = False
        end
        object Memo175: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_CONTABIL_DB'
          DataSetName = 'CBT_C'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CBT_C."CONTA_CONTABIL_DB"]')
          ParentFont = False
        end
        object Memo176: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'COD_REDUZ_DB'
          DataSetName = 'CBT_C'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CBT_C."COD_REDUZ_DB"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo177: TfrxMemoView
          AllowVectorExport = True
          Left = 807.701300000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSetName = 'CBT_C'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CBT_C."VALOR"]')
          ParentFont = False
        end
        object Memo222: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'TOB_CODIGO'
          DataSetName = 'CBT_C'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CBT_C."TOB_CODIGO"]')
          ParentFont = False
        end
      end
      object DT_CBT_DB: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 1799.056280000000000000
        Width = 1046.929810000000000000
        DataSetName = 'CBT_D'
        RowCount = 0
        object Memo178: TfrxMemoView
          AllowVectorExport = True
          Width = 302.362400000000000000
          Height = 11.338590000000000000
          DataField = 'DESCRICAO'
          DataSetName = 'CBT_D'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[CBT_D."DESCRICAO"]')
          ParentFont = False
        end
        object Memo179: TfrxMemoView
          AllowVectorExport = True
          Left = 518.354670000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_CORRENTE_DEBITO'
          DataSetName = 'CBT_D'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[CBT_D."CONTA_CORRENTE_DEBITO"]')
          ParentFont = False
        end
        object Memo180: TfrxMemoView
          AllowVectorExport = True
          Left = 391.850650000000000000
          Width = 124.724490000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_CC_CR'
          DataSetName = 'CBT_D'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[CBT_D."DSC_CC_CR"]')
          ParentFont = False
        end
        object Memo181: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_CONTABIL_CR'
          DataSetName = 'CBT_D'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CBT_D."CONTA_CONTABIL_CR"]')
          ParentFont = False
        end
        object Memo182: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'COD_REDUZ_CR'
          DataSetName = 'CBT_D'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CBT_D."COD_REDUZ_CR"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo183: TfrxMemoView
          AllowVectorExport = True
          Left = 946.102970000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSetName = 'CBT_D'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CBT_D."VALOR"]')
          ParentFont = False
        end
        object Memo223: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'TOB_CODIGO'
          DataSetName = 'CBT_D'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CBT_D."TOB_CODIGO"]')
          ParentFont = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 30.236220470000000000
        Top = 1836.851580000000000000
        Width = 1046.929810000000000000
        object Line19: TfrxLineView
          AllowVectorExport = True
          Left = 774.803650000000000000
          Width = 268.346630000000000000
          Color = clBlack
          Frame.Style = fsDot
          Frame.Typ = [ftTop]
        end
        object Memo184: TfrxMemoView
          AllowVectorExport = True
          Left = 923.425790000000000000
          Top = 5.559060000000040000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<CBT_D."VALOR">,DT_CBT_DB)]')
          ParentFont = False
        end
        object Memo190: TfrxMemoView
          AllowVectorExport = True
          Left = 785.024120000000000000
          Top = 5.559060000000040000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<CBT_C."VALOR">,DT_CBT_CR)]')
          ParentFont = False
        end
      end
      object GroupHeader10: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 1.889763780000000000
        Top = 1935.119360000000000000
        Width = 1046.929810000000000000
        Condition = 'TRFBCOCAIXA."ID_CONTA_BANCARIA_DEBITO"'
        object Line20: TfrxLineView
          AllowVectorExport = True
          Top = 0.220469999999978000
          Width = 1050.709340000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader11: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 1889.765000000000000000
        Width = 1046.929810000000000000
        Condition = '1=1'
        StartNewPage = True
        object Line21: TfrxLineView
          AllowVectorExport = True
          Top = 3.779529999999800000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo191: TfrxMemoView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Top = 7.559060000000040000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo192: TfrxMemoView
          AllowVectorExport = True
          Left = 181.346559210000000000
          Top = 7.559060000000040000
          Width = 124.724490000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo193: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Top = 7.559060000000040000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo194: TfrxMemoView
          AllowVectorExport = True
          Left = 141.181200000000000000
          Top = 7.559060000000040000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'TIPO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo195: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Top = 7.559060000000040000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CONTA  CONT'#193'BIL')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo196: TfrxMemoView
          AllowVectorExport = True
          Left = 785.024120000000000000
          Top = 7.559060000000040000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'D'#201'BITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo197: TfrxMemoView
          AllowVectorExport = True
          Left = 946.102970000000000000
          Top = 7.559060000000040000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CR'#201'DITO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Line23: TfrxLineView
          AllowVectorExport = True
          Left = 0.559060000000000000
          Top = 3.779530000000020000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo199: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Top = 7.559060000000040000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'CD.REDUZ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo200: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Top = 7.559060000000040000
          Width = 268.346630000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#211'D.HIST.                    DESCRI'#199#195'O CONT'#193'BIL')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object MD_TRF_BCO_CX: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 34.015748030000000000
        Top = 1961.576070000000000000
        Width = 1046.929810000000000000
        DataSetName = 'TRFBCOCAIXA'
        RowCount = 0
        object Memo201: TfrxMemoView
          AllowVectorExport = True
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DataField = 'DATA_MOVIMENTO'
          DataSetName = 'TRFBCOCAIXA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRFBCOCAIXA."DATA_MOVIMENTO"]')
          ParentFont = False
        end
        object Memo202: TfrxMemoView
          AllowVectorExport = True
          Left = 181.346559210000000000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          DataField = 'ID_TIPO_OPERACAO_BANCARIA'
          DataSetName = 'TRFBCOCAIXA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRFBCOCAIXA."ID_TIPO_OPERACAO_BANCARIA"]')
          ParentFont = False
        end
        object Memo203: TfrxMemoView
          AllowVectorExport = True
          Left = 63.031540000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DataField = 'IDENTIFICACAO'
          DataSetName = 'TRFBCOCAIXA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRFBCOCAIXA."IDENTIFICACAO"]')
          ParentFont = False
        end
        object Memo204: TfrxMemoView
          AllowVectorExport = True
          Left = 141.181200000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          DataField = 'TIPO'
          DataSetName = 'TRFBCOCAIXA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRFBCOCAIXA."TIPO"]')
          ParentFont = False
        end
        object Memo206: TfrxMemoView
          AllowVectorExport = True
          Left = 392.850650000000000000
          Width = 188.976500000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_CC_DEBITO'
          DataSetName = 'TRFBCOCAIXA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRFBCOCAIXA."DSC_CC_DEBITO"]')
          ParentFont = False
        end
        object Memo207: TfrxMemoView
          AllowVectorExport = True
          Left = 392.850650000000000000
          Top = 13.677179999999900000
          Width = 188.976500000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_CC_CREDITO'
          DataSetName = 'TRFBCOCAIXA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRFBCOCAIXA."DSC_CC_CREDITO"]')
          ParentFont = False
        end
        object Memo208: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_CONTABIL_DEBITO'
          DataSetName = 'TRFBCOCAIXA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFBCOCAIXA."CONTA_CONTABIL_DEBITO"]')
          ParentFont = False
        end
        object Memo209: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Top = 13.677179999999900000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DataField = 'CONTA_CONTABIL_CREDITO'
          DataSetName = 'TRFBCOCAIXA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFBCOCAIXA."CONTA_CONTABIL_CREDITO"]')
          ParentFont = False
        end
        object Memo210: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'COD_REDUZ_DEBITO'
          DataSetName = 'TRFBCOCAIXA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFBCOCAIXA."COD_REDUZ_DEBITO"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo211: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Top = 13.677179999999900000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataField = 'COD_REDUZ_CREDITO'
          DataSetName = 'TRFBCOCAIXA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFBCOCAIXA."COD_REDUZ_CREDITO"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo212: TfrxMemoView
          AllowVectorExport = True
          Left = 804.142240000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSetName = 'TRFBCOCAIXA'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFBCOCAIXA."VALOR"]')
          ParentFont = False
        end
        object Memo213: TfrxMemoView
          AllowVectorExport = True
          Left = 942.543910000000000000
          Top = 13.677179999999900000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSetName = 'TRFBCOCAIXA'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFBCOCAIXA."VALOR"]')
          ParentFont = False
        end
        object Memo214: TfrxMemoView
          AllowVectorExport = True
          Top = 13.677179999999900000
          Width = 302.362400000000000000
          Height = 11.338590000000000000
          DataField = 'DESCRICAO'
          DataSetName = 'TRFBCOCAIXA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TRFBCOCAIXA."DESCRICAO"]')
          ParentFont = False
        end
        object Memo224: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'TOB_CODIGO'
          DataSetName = 'TRFBCOCAIXA'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRFBCOCAIXA."TOB_CODIGO"]')
          ParentFont = False
        end
        object Memo225: TfrxMemoView
          AllowVectorExport = True
          Left = 310.480520000000000000
          Top = 13.677179999999900000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'TOB_CODIGO'
          DataSetName = 'TRFBCOCAIXA'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TRFBCOCAIXA."TOB_CODIGO"]')
          ParentFont = False
        end
      end
      object GroupFooter6: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 30.236220470000000000
        Top = 1598.741190000000000000
        Width = 1046.929810000000000000
        object Line26: TfrxLineView
          AllowVectorExport = True
          Left = 774.803650000000000000
          Width = 268.346630000000000000
          Color = clBlack
          Frame.Style = fsDot
          Frame.Typ = [ftTop]
        end
        object Memo164: TfrxMemoView
          AllowVectorExport = True
          Left = 923.425790000000000000
          Top = 5.559060000000040000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<TRFCAIXABANCO."VALOR">,MD_TRF_CX_BCO)]')
          ParentFont = False
        end
        object Memo198: TfrxMemoView
          AllowVectorExport = True
          Left = 785.024120000000000000
          Top = 5.559060000000040000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<TRFCAIXABANCO."VALOR">,MD_TRF_CX_BCO)]')
          ParentFont = False
        end
      end
      object DT_TPB: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 532.913730000000000000
        Width = 1046.929810000000000000
        DataSet = dmEspelhoTP.frxDBTPB
        DataSetName = 'TPBaixa'
        RowCount = 0
        object Memo215: TfrxMemoView
          AllowVectorExport = True
          Left = 392.630180000000000000
          Width = 257.008040000000000000
          Height = 11.338590000000000000
          DataField = 'DSC_CDD'
          DataSet = dmEspelhoTP.frxDBTPB
          DataSetName = 'TPBaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBaixa."DSC_CDD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo216: TfrxMemoView
          AllowVectorExport = True
          Left = 783.803650000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = dmEspelhoTP.frxDBTPB
          DataSetName = 'TPBaixa'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBaixa."VALOR"]')
          ParentFont = False
        end
        object Memo218: TfrxMemoView
          AllowVectorExport = True
          Left = 640.331170000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CONTA_DB'
          DataSet = dmEspelhoTP.frxDBTPB
          DataSetName = 'TPBaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBaixa."CONTA_DB"]')
          ParentFont = False
        end
        object Memo219: TfrxMemoView
          AllowVectorExport = True
          Left = 733.228820000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DataField = 'COD_REDUZ_DB'
          DataSet = dmEspelhoTP.frxDBTPB
          DataSetName = 'TPBaixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBaixa."COD_REDUZ_DB"]')
          ParentFont = False
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
end
