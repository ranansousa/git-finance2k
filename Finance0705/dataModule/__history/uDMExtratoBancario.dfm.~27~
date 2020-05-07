object dmExtratoBancario: TdmExtratoBancario
  OldCreateOrder = False
  Height = 362
  Width = 750
  object qryCBD: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT'
      '       cbd.descricao,'
      '     ((cbd.valor)* (-1)) AS VALOR,'
      '       cbd.data_movimento,'
      '       cbd.identificacao,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DESCRICAO AS DSC_TITULO,'
      '       CB.conta AS CONTA_BANCO,'
      '       CB.titular,'
      '       CBC.numero_cheque,'
      '       TOB.descricao AS TIPO_OPERACAO,'
      '       CBD.id_conta_bancaria_debito,'
      '       cbd.id_organizacao,'
      '       cbd.tipo_lancamento,'
      '       C.NOME AS FORNECEDOR'
      ''
      ''
      'FROM CONTA_BANCARIA_DEBITO CBD'
      
        'LEFT OUTER JOIN TITULO_PAGAR TP ON (TP.ID_TITULO_PAGAR = CBD.ID_' +
        'TITULO_PAGAR) AND (TP.ID_ORGANIZACAO = CBD.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.id_conta_bancaria = CBD' +
        '.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = CBD.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria_cheque CBC ON (CBC.id_conta_banca' +
        'ria_cheque = CBD.id_conta_bancaria_cheque) AND (CBC.ID_ORGANIZAC' +
        'AO = CBD.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN tipo_operacao_bancaria TOB ON (TOB.id_tipo_opera' +
        'cao_bancaria = CBD.id_tipo_operacao_bancaria) AND (TOB.ID_ORGANI' +
        'ZACAO = CBD.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = CBD.ID_ORGANIZACAO)'
      ''
      'WHERE (CBD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (CBD.data_movimento BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) AND'
      '      (CBD.ID_CONTA_BANCARIA = :PIDCONTA)'
      'ORDER BY CBD.DATA_MOVIMENTO, CBD.valor DESC'
      '')
    Left = 48
    Top = 122
    ParamData = <
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
      end
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryCBC: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT'
      '       CBC.descricao,'
      '     ((CBC.valor)* (1)) AS VALOR,'
      '       CBC.data_movimento,'
      '       CBC.identificacao,'
      '       TR.NUMERO_DOCUMENTO,'
      '       TR.DESCRICAO AS DSC_TITULO,'
      '       CB.conta AS CONTA_BANCO,'
      '       CB.titular,'
      '       TOB.descricao AS TIPO_OPERACAO,'
      '       CBC.id_conta_bancaria_CREDITO,'
      '       CBC.id_organizacao,'
      '       CBC.tipo_lancamento,'
      '       S.NOME'
      ''
      'FROM CONTA_BANCARIA_CREDITO CBC'
      
        'LEFT OUTER JOIN TITULO_RECEBER TR ON (TR.ID_TITULO_RECEBER = CBC' +
        '.ID_TITULO_RECEBER) AND (TR.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.id_conta_bancaria = CBC' +
        '.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN tipo_operacao_bancaria TOB ON (TOB.id_tipo_opera' +
        'cao_bancaria = CBC.id_tipo_operacao_bancaria) AND (TOB.ID_ORGANI' +
        'ZACAO = CBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN SACADO S ON (S.ID_SACADO = TR.ID_SACADO)  AND (S' +
        '.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO)'
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (CBC.data_movimento BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) AND'
      '      (CBC.ID_CONTA_BANCARIA = :PIDCONTA)'
      'ORDER BY CBC.DATA_MOVIMENTO, CBC.valor DESC'
      '')
    Left = 144
    Top = 122
    ParamData = <
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
      end
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qrySaldoCredito: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'select sum(cbc.valor) as SALDO,'
      '       max(cb.conta) as conta_banco,'
      '       max(cb.titular) as titular,'
      '       max(cc.conta) as conta_contbil,'
      '       max(cc.descricao) as dsc_cc'
      ''
      'FROM  conta_bancaria_credito cbc'
      
        'left outer join conta_bancaria cb on (cb.id_conta_bancaria = cbc' +
        '.id_conta_bancaria)'
      
        'left outer join conta_contabil cc on (cc.id_conta_contabil = cb.' +
        'id_conta_contabil)'
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (CBC.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) AND'
      '      (CBC.ID_CONTA_BANCARIA = :PIDCONTA)'
      ''
      ''
      '')
    Left = 168
    Top = 34
    ParamData = <
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
      end
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qrySaldoDebito: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'select sum(CBD.valor) as SALDO,'
      '       max(cb.conta) as conta_banco,'
      '       max(cb.titular) as titular,'
      '       max(cc.conta) as conta_contbil,'
      '       max(cc.descricao) as dsc_cc'
      ''
      'FROM  conta_bancaria_debito CBD'
      
        'left outer join conta_bancaria cb on (cb.id_conta_bancaria = cbD' +
        '.id_conta_bancaria) and (CB.ID_ORGANIZACAO = CBD.ID_ORGANIZACAO)'
      
        'left outer join conta_contabil cc on (cc.id_conta_contabil = cb.' +
        'id_conta_contabil) and (CC.ID_ORGANIZACAO = CBD.ID_ORGANIZACAO)'
      ''
      ''
      ''
      'WHERE (CBD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (CBD.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) AND'
      '      (CBD.ID_CONTA_BANCARIA = :PIDCONTA)'
      ''
      '')
    Left = 480
    Top = 42
    ParamData = <
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
      end
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryDeletaTemp: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'DELETE FROM TEMP_EXTRATO WHERE 1=1')
    Left = 432
    Top = 114
  end
  object qryInsereTemp: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      '')
    Left = 424
    Top = 202
  end
  object qryExtrato: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TE.DATA,'
      '       TE.valor,'
      '       TE.DETALHAMENTO,'
      '       TE.TIPO'
      'FROM TEMP_EXTRATO TE'
      'WHERE 1=1'
      'ORDER BY TE.data,TE.TIPO, TE.VALOR')
    Left = 528
    Top = 186
  end
end
