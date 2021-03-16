object dmExtratoTesouraria: TdmExtratoTesouraria
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 529
  Width = 930
  object qryObterTC: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TC.ID_TESOURARIA_CREDITO,'
      '       TC.ID_ORGANIZACAO ,'
      '       TC.NUMERO_DOCUMENTO ,'
      '       TC.DESCRICAO ,'
      '       TC.DATA_MOVIMENTO ,'
      '       TC.VALOR_NOMINAL AS VALOR,'
      '       TC.ID_LOTE_CONTABIL,'
      '       TC.ID_HISTORICO ,'
      '       TC.TIPO_LANCAMENTO,'
      '       H.DESCRICAO AS DSC_HIST,'
      '       TC.ID_TITULO_RECEBER_BAIXA_CHEQUE ,'
      '       TRBC.NUMERO_CHEQUE AS CHEQUE_RECEBIDO,'
      '       TRBC.ID_LOTE_DEPOSITO,'
      '       LD.LOTE,'
      '       CB.CONTA AS CONTA_DEPOSITO,'
      '       TC.ID_TITULO_RECEBER_BAIXA,'
      '       TR.NUMERO_DOCUMENTO AS DOCUMENTO,'
      '       TR.DESCRICAO AS DSC_TITULO'
      ''
      ' FROM TESOURARIA_CREDITO TC'
      
        ' LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TC.ID_HISTORIC' +
        'O) AND (TC.ID_ORGANIZACAO = H.ID_ORGANIZACAO)'
      
        ' LEFT OUTER JOIN TITULO_RECEBER_BAIXA TRB ON (TRB.ID_TITULO_RECE' +
        'BER_BAIXA = TC.ID_TITULO_RECEBER_BAIXA) AND (TC.ID_ORGANIZACAO =' +
        ' TRB.ID_ORGANIZACAO)'
      
        ' LEFT OUTER JOIN TITULO_RECEBER TR ON (TR.ID_TITULO_RECEBER = TR' +
        'B.ID_TITULO_RECEBER) AND (TR.ID_ORGANIZACAO = TC.ID_ORGANIZACAO)'
      
        ' LEFT OUTER JOIN TITULO_RECEBER_BAIXA_CHEQUE TRBC ON (TRBC.ID_TI' +
        'TULO_RECEBER_BAIXA_CHEQUE = TC.ID_TITULO_RECEBER_BAIXA_CHEQUE) A' +
        'ND (TC.ID_ORGANIZACAO = TRBC.ID_ORGANIZACAO)'
      
        ' LEFT OUTER JOIN LOTE_DEPOSITO LD ON (LD.ID_LOTE_DEPOSITO = TRBC' +
        '.ID_LOTE_DEPOSITO) AND (LD.ID_ORGANIZACAO = TC.ID_ORGANIZACAO)'
      
        ' LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = LD' +
        '.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = TC.ID_ORGANIZACAO)'
      ''
      ''
      
        ' WHERE (TC.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L )'
      ' AND (TC.ID_ORGANIZACAO  = :PIDORGANIZACAO)'
      ' ORDER BY TC.DATA_MOVIMENTO ASC, TC.VALOR_NOMINAL ASC')
    Left = 67
    Top = 250
    ParamData = <
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
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qrySaldoAnteriorTC: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      '--RETORNA O SALDO ANTERIOR DA TC'
      'SELECT SUM(TC.VALOR_NOMINAL) AS VALOR'
      'FROM TESOURARIA_CREDITO TC'
      'WHERE (TC.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      'AND   (TC.DATA_MOVIMENTO < :DTDATAINICIAL )')
    Left = 195
    Top = 250
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
      end>
  end
  object qrySaldoAnteriorTD: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      '--RETORNA O SALDO ANTERIOR DA TD'
      'SELECT ( SUM(TD.VALOR_NOMINAL) ) AS VALOR'
      'FROM TESOURARIA_DEBITO TD'
      'WHERE (TD.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      'AND   (TD.DATA_MOVIMENTO < :DTDATAINICIAL )'
      ''
      ''
      '')
    Left = 323
    Top = 250
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
      end>
  end
  object qryObterTD: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TD.ID_TESOURARIA_DEBITO,'
      '       TD.ID_ORGANIZACAO,'
      '       TD.NUMERO_DOCUMENTO,'
      '       TD.DESCRICAO,'
      '       TD.DATA_MOVIMENTO,'
      '       (TD.VALOR_NOMINAL * (-1)) AS VALOR,'
      '       TD.ID_LOTE_DEPOSITO,'
      '       TD.TIPO_LANCAMENTO,'
      '       LD.LOTE,'
      '       LD.ID_CONTA_BANCARIA,'
      
        '       (CB.id_banco || CB.agencia || CB.CONTA) AS CONTA_DEPOSITO' +
        ','
      '       TD.ID_HISTORICO,'
      '       H.DESCRICAO AS DSC_HIST,'
      '       TD.ID_CEDENTE,'
      '       C.NOME AS FORNECEDOR,'
      '       TD.ID_TITULO_PAGAR_BAIXA,'
      '       TP.NUMERO_DOCUMENTO AS DOC,'
      '       TP.DESCRICAO AS DSC_DOC'
      ''
      '    '
      '    FROM TESOURARIA_DEBITO TD'
      
        '    LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TD.ID_HISTO' +
        'RICO) AND (H.ID_ORGANIZACAO = TD.ID_ORGANIZACAO)'
      
        '    LEFT OUTER JOIN CEDENTE   C ON (C.ID_CEDENTE = TD.ID_CEDENTE' +
        ' )    AND (C.ID_ORGANIZACAO = TD.ID_ORGANIZACAO)'
      
        '    LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.ID_TITULO_PAG' +
        'AR_BAIXA = TD.ID_TITULO_PAGAR_BAIXA) AND (TPB.ID_ORGANIZACAO = T' +
        'D.ID_ORGANIZACAO)'
      
        '    LEFT OUTER JOIN TITULO_PAGAR TP ON (TP.ID_TITULO_PAGAR = TPB' +
        '.ID_TITULO_PAGAR) AND (TP.ID_ORGANIZACAO = TD.ID_ORGANIZACAO)'
      
        '    LEFT OUTER JOIN LOTE_DEPOSITO LD ON (LD.ID_LOTE_DEPOSITO = T' +
        'D.ID_LOTE_DEPOSITO) AND (LD.ID_ORGANIZACAO = TD.ID_ORGANIZACAO)'
      
        '    LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA =' +
        ' LD.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = TD.ID_ORGANIZACA' +
        'O)'
      '    '
      ''
      
        '     WHERE (TD.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATA' +
        'FINAL )'
      '     AND (TD.ID_ORGANIZACAO  = :PIDORGANIZACAO)'
      '     ORDER BY TD.DATA_MOVIMENTO ASC, TD.VALOR_NOMINAL ASC')
    Left = 451
    Top = 250
    ParamData = <
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
        Name = 'PIDORGANIZACAO'
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
    Left = 579
    Top = 250
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
    Left = 707
    Top = 250
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
    Left = 835
    Top = 250
  end
end
