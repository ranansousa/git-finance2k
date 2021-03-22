object dmExportaFinance: TdmExportaFinance
  OldCreateOrder = False
  Height = 426
  Width = 660
  object qryTitulosProvisionados: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.ID_ORGANIZACAO,'
      '       TP.ID_TITULO_PAGAR,'
      '       TP.DATA_EMISSAO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DESCRICAO,'
      '       TP.PARCELA,'
      '       TP.VALOR_NOMINAL,'
      '       CC.CONTA AS CONTA_CREDITO,'
      '       CC.CODREDUZ,'
      '       CC.DESCRICAO AS DSC_CONTA,'
      '       TP.ID_CONTA_CONTABIL_CREDITO'
      ''
      ''
      '        '
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = TP.' +
        'ID_CONTA_CONTABIL_CREDITO)'
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (TP.DATA_EMISSAO BETWEEN :pDataInicial AND :pDataFinal) AN' +
        'D'
      '      (TP.IS_PROVISAO = :pProvisao) AND'
      '      (TP.ID_TIPO_STATUS = :pIdStatus) AND'
      '      (TP.ID_LOTE_CONTABIL IS NULL) AND'
      '      (TP.DATA_PAGAMENTO IS NULL)'
      ''
      'ORDER BY TP.DATA_EMISSAO DESC, TP.VALOR_NOMINAL DESC;   '
      '')
    Left = 64
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
        Name = 'PPROVISAO'
        DataType = ftInteger
        ParamType = ptInput
        Size = 1
      end
      item
        Name = 'PIDSTATUS'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryGravarLoteContabil: TFDQuery
    Connection = dmConexao.Conn
    Left = 96
    Top = 56
  end
  object qryObterTPHistoricoPorTitulo: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.DefaultParamDataType = ftString
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      
        'SELECT TPH.ID_TITULO_PAGAR, TPH.VALOR, H.DESCRICAO,H.CODIGO, CD.' +
        'conta, CD.codreduz'
      '        '
      'FROM TITULO_PAGAR_HISTORICO TPH'
      'JOIN HISTORICO H ON (TPH.ID_HISTORICO = H.ID_HISTORICO)'
      
        'JOIN conta_contabil CD ON (CD.id_conta_contabil = H.id_conta_con' +
        'tabil)'
      ''
      'WHERE (TPH.ID_ORGANIZACAO = :pIdOrganizacao)AND'
      '      (TPH.ID_TITULO_PAGAR = :PID_TITULO_PAGAR)'
      ''
      'ORDER BY TPH.VALOR;'
      '')
    Left = 212
    Top = 208
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PID_TITULO_PAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterCentroCustoPorTitulo: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TPC.VALOR,       '
      '       TPC.ID_TITULO_PAGAR,'
      '       CC.DESCRICAO,'
      '       CC.CODIGO'
      '        '
      'FROM TITULO_PAGAR_RATEIO_CC TPC'
      
        'JOIN CENTRO_CUSTO CC ON (CC.ID_CENTRO_CUSTO = TPC.ID_CENTRO_CUST' +
        'O)'
      ''
      'WHERE    (TPC.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '         (TPC.ID_TITULO_PAGAR = :pId_TITULO_PAGAR) ;'
      ''
      '       '
      '')
    Left = 380
    Top = 208
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PID_TITULO_PAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryVerificaHistoricoSemContaContabil: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT H.descricao, H.codigo'
      'FROM  HISTORICO H'
      'WHERE (H.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '      (H.id_conta_contabil IS NULL)')
    Left = 528
    Top = 16
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end