object dmCBT: TdmCBT
  OldCreateOrder = False
  Height = 388
  Width = 881
  object qryObterPorPeriodo: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT  CBT.ID_CONTA_BANCARIA_TRANSFERENCIA,'
      '        CBT.ID_CONTA_BANCARIA_CREDITO,'
      '        CBT.ID_CONTA_BANCARIA_DEBITO,'
      '        CBT.ID_TIPO_OPERACAO_BANCARIA,'
      '        CBT.VALOR, CBT.DATA_MOVIMENTO,'
      '        CBT.IDENTIFICACAO,'
      '        CBT.VALOR,'
      '       '#39'CBT'#39' AS TIPO'
      ''
      ''
      'FROM CONTA_BANCARIA_TRANSFERENCIA CBT'
      ''
      
        'LEFT OUTER JOIN CONTA_BANCARIA_CREDITO CBC ON (CBC.ID_CONTA_BANC' +
        'ARIA_CREDITO = CBT.ID_CONTA_BANCARIA_CREDITO) AND (CBC.ID_ORGANI' +
        'ZACAO = CBT.ID_ORGANIZACAO)'
      ''
      'WHERE   (CBT.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '        (CBT.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFI' +
        'NAL) AND'
      '        (CBC.ID_LOTE_CONTABIL IS NULL)'
      ''
      ''
      ''
      '')
    Left = 72
    Top = 64
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
      end>
  end
  object qryExisteIdentificacao: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT COUNT(*) AS QTD'
      ''
      'FROM CONTA_BANCARIA_TRANSFERENCIA CBT'
      ''
      ''
      'WHERE   (CBT.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '        (CBT.IDENTIFICACAO = :PIDENTIFICACAO)'
      ''
      ''
      ''
      '')
    Left = 288
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDENTIFICACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterIDContaBancaria: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      
        'SELECT CB.ID_CONTA_BANCARIA AS ID, CB.CONTA, CB.AGENCIA, CB.TITU' +
        'LAR  '
      ''
      'FROM CONTA_BANCARIA CB'
      ''
      ' WHERE ( CB.ID_ORGANIZACAO = :PIDORGANIZACAO )'
      '   AND ( CB.ID_CONTA_BANCARIA = :PIDCB)')
    Left = 72
    Top = 168
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCB'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryInsereCBT: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'INSERT INTO CONTA_BANCARIA_TRANSFERENCIA '
      '           (ID_CONTA_BANCARIA_TRANSFERENCIA, '
      '            ID_ORGANIZACAO, '
      '            ID_CONTA_BANCARIA_CREDITO, '
      '            ID_CONTA_BANCARIA_DEBITO, '
      '            ID_TIPO_OPERACAO_BANCARIA, '
      '            ID_RESPONSAVEL, '
      '            ID_USUARIO,'
      '            IDENTIFICACAO, '
      '            OBSERVACAO, '
      '            VALOR, '
      '            DATA_REGISTRO, '
      '            DATA_MOVIMENTO )'
      
        'VALUES (:PID, :PIDORGANIZACAO, :PIDCONTACR, :PIDCONTADB, :PIDTIP' +
        'O, :PIDRESP, :PIDUSUARIO, :PIDIDENT, :POBS,:PVALOR, :PDTREGISTRO' +
        ', :PDTMOVIMENTO);')
    Left = 48
    Top = 280
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
      end
      item
        Name = 'PIDCONTACR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCONTADB'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTIPO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDRESP'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDUSUARIO'
        DataType = ftSmallint
        ParamType = ptInput
      end
      item
        Name = 'PIDIDENT'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'POBS'
        DataType = ftString
        ParamType = ptInput
        Size = 60
      end
      item
        Name = 'PVALOR'
        DataType = ftCurrency
        ParamType = ptInput
      end
      item
        Name = 'PDTREGISTRO'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PDTMOVIMENTO'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryInsereCBDESTINO: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    SQL.Strings = (
      
        'INSERT INTO CONTA_BANCARIA_CREDITO (ID_CONTA_BANCARIA_CREDITO, I' +
        'D_ORGANIZACAO, ID_CONTA_BANCARIA, ID_TIPO_OPERACAO_BANCARIA, ID_' +
        'RESPONSAVEL, TIPO_LANCAMENTO, DESCRICAO, VALOR, DATA_REGISTRO, D' +
        'ATA_MOVIMENTO, IDENTIFICACAO, ID_USUARIO)'
      
        '                            VALUES ('#39'6f9f8168-8ee6-4cfc-a668-608' +
        'fc8d958f3'#39', '#39'imap'#39', '#39'fa415bc0-c407-11e4-964c-9dd53c0c5488'#39', '#39'REC' +
        'BTO TITULO'#39', '#39'3b3fce40-9af1-11e3-b9a1-b909de21f15b'#39', '#39'C'#39', '#39'CRED ' +
        'REF RCBTO TITULO 502843'#39', 300, '#39'2019-02-05'#39', '#39'2019-01-23'#39', '#39'5028' +
        '42'#39', 1);')
    Left = 448
    Top = 192
  end
  object qryObterGUID: TFDQuery
    SQL.Strings = (
      'select createguid() as newID from rdb$database')
    Left = 408
    Top = 40
  end
  object qryInsereCBORIGEM: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    SQL.Strings = (
      
        'INSERT INTO CONTA_BANCARIA_DEBITO (ID_CONTA_BANCARIA_DEBITO, ID_' +
        'ORGANIZACAO, ID_CONTA_BANCARIA, ID_TIPO_OPERACAO_BANCARIA, ID_RE' +
        'SPONSAVEL, TIPO_LANCAMENTO, DESCRICAO, VALOR, DATA_REGISTRO, DAT' +
        'A_MOVIMENTO, IDENTIFICACAO, ID_USUARIO)'
      
        '                            VALUES ('#39'6f9f8168-8ee6-4cfc-a668-608' +
        'fc8d958f3'#39', '#39'pEmpresa'#39', '#39'fa415bc0-c407-11e4-964c-9dd53c0c5488'#39', ' +
        #39'RECBTO TITULO'#39', '#39'3b3fce40-9af1-11e3-b9a1-b909de21f15b'#39', '#39'C'#39', '#39'C' +
        'RED REF RCBTO TITULO 502843'#39', 300, '#39'2019-02-05'#39', '#39'2019-01-23'#39', '#39 +
        '502842'#39', 1);')
    Left = 440
    Top = 280
  end
  object qryObterTRFPORID: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT  CBT.ID_CONTA_BANCARIA_TRANSFERENCIA,'
      '        CBT.ID_CONTA_BANCARIA_CREDITO,'
      '        CBT.ID_CONTA_BANCARIA_DEBITO,'
      '        CBT.ID_TIPO_OPERACAO_BANCARIA,'
      '        CBT.VALOR, '
      '        CBT.DATA_MOVIMENTO,'
      '        CBT.IDENTIFICACAO,'
      '        CBT.VALOR,'
      '        CBDS.id_conta_bancaria_credito,'
      '       CBC.CONTA AS CONTADESTINO,'
      '       CBC.AGENCIA AS AGENCIADESTINO,'
      '       CBC.TITULAR AS TITULARDESTINO,'
      '       CBDS.IDENTIFICACAO AS IDENTICACAODESTINO,'
      '       CBD.CONTA AS CONTAORIGEM,'
      '       CBD.AGENCIA AS AGENCIAORIGEM,'
      '       CBD.TITULAR AS TITULARORIGEM,'
      '       CBOG.IDENTIFICACAO AS IDENTICACAOORIGEM'
      ''
      ''
      'FROM CONTA_BANCARIA_TRANSFERENCIA CBT'
      ''
      
        'LEFT OUTER JOIN CONTA_BANCARIA_CREDITO CBDS ON (CBDS.ID_CONTA_BA' +
        'NCARIA_CREDITO = CBT.ID_CONTA_BANCARIA_CREDITO) AND (CBDS.ID_ORG' +
        'ANIZACAO = CBT.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CBC ON (CBC.ID_CONTA_BANCARIA = C' +
        'BDS.ID_CONTA_BANCARIA) AND (CBC.ID_ORGANIZACAO = CBT.ID_ORGANIZA' +
        'CAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA_DEBITO  CBOG ON (CBOG.ID_CONTA_BA' +
        'NCARIA_DEBITO  = CBT.ID_CONTA_BANCARIA_DEBITO) AND (CBOG.ID_ORGA' +
        'NIZACAO = CBT.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CBD ON (CBD.ID_CONTA_BANCARIA = C' +
        'BOG.ID_CONTA_BANCARIA) AND (CBD.ID_ORGANIZACAO = CBT.ID_ORGANIZA' +
        'CAO)'
      ''
      ''
      'WHERE   (CBT.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '        (CBT.ID_CONTA_BANCARIA_TRANSFERENCIA = :PIDCBT)'
      ''
      ''
      ''
      '')
    Left = 240
    Top = 176
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCBT'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryDeletaCBT: TFDQuery
    Connection = dmConexao.conn
    Left = 240
    Top = 288
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
    Left = 520
    Top = 66
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
    Left = 648
    Top = 66
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
end
