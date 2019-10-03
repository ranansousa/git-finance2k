object dmRelTPHistorico: TdmRelTPHistorico
  OldCreateOrder = False
  Height = 439
  Width = 689
  object qryTotalDebitoPorFornecedor: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT SUM(TP.VALOR_NOMINAL) as DEBITO'
      'FROM  TITULO_PAGAR TP'
      ''
      'WHERE (TP.ID_CEDENTE = :PIDCEDENTE) AND'
      '      (TP.ID_TIPO_STATUS in ('#39'ABERTO'#39', '#39'PARCIAL'#39','#39'QUITADO'#39')) AND'
      '      (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)AND'
      
        '      (TP.DATA_EMISSAO  BETWEEN :DTDATAINICIAL AND :DTDATAFINAL)' +
        ';')
    Left = 280
    Top = 207
    ParamData = <
      item
        Name = 'PIDCEDENTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryTotalQuitadoPorFornecedor: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT SUM(TP.VALOR_NOMINAL)as DEBITO'
      ''
      'FROM  TITULO_PAGAR TP'
      ''
      'WHERE (TP.ID_CEDENTE = :PIDCEDENTE) AND'
      '      (TP.ID_TIPO_STATUS in ('#39'QUITADO'#39', '#39'PARCIAL'#39')) AND'
      '      (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)AND'
      '      (TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL);'
      '')
    Left = 504
    Top = 119
    ParamData = <
      item
        Name = 'PIDCEDENTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryTitulosPorFornecedor: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT *'
      'FROM  TITULO_PAGAR TP'
      'WHERE (TP.ID_CEDENTE = :PIDCEDENTE) AND'
      '      (TP.ID_TIPO_STATUS in ('#39'ABERTO'#39','#39'QUITADO'#39', '#39'PARCIAL'#39')) AND'
      '      (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)AND'
      '      (TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL)'
      'ORDER BY TP.DATA_EMISSAO, TP.VALOR_NOMINAL'
      '')
    Left = 505
    Top = 199
    ParamData = <
      item
        Name = 'PIDCEDENTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryObterTotalPorStatus: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT SUM(TP.VALOR_NOMINAL)DEBITO'
      'FROM  TITULO_PAGAR TP'
      'WHERE (TP.ID_TIPO_STATUS = :PIDSTATUS) AND'
      '      (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)AND'
      '      (TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL);'
      '')
    Left = 284
    Top = 96
    ParamData = <
      item
        Name = 'PIDSTATUS'
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qry1: TFDQuery
    Left = 424
    Top = 304
  end
end
