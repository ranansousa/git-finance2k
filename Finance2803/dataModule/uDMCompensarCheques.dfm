object dmCompensarCheques: TdmCompensarCheques
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 496
  Width = 571
  object qryObterCheque: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT  CBC.ID_CONTA_BANCARIA_CHEQUE AS IDCHEQUE,'
      '        CBC.ID_ORGANIZACAO,'
      '        CBC.ID_CONTA_BANCARIA,'
      '        CBC.ID_FUNCIONARIO,'
      '        CBC.ID_TIPO_STATUS,'
      '        CBC.NUMERO_CHEQUE,'
      '        CBC.DATA_EMISSAO,'
      '        CBC.DATA_ESTORNO,'
      '        CBC.VALOR,'
      '        CBC.OBSERVACAO,'
      '        CBC.PORTADOR,'
      '        CBC.QTD_IMPRESSAO,'
      '        F.NOME,'
      '        TS.DESCRICAO AS STATUS,'
      '        CB.CONTA_INTERNA,'
      '        CB.CONTA,'
      '        CB.AGENCIA,'
      '        CB.TITULAR'
      ''
      ' FROM CONTA_BANCARIA_CHEQUE CBC'
      ''
      
        ' LEFT OUTER JOIN FUNCIONARIO F ON (F.ID_FUNCIONARIO = CBC.ID_FUN' +
        'CIONARIO)  AND (F.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO)'
      
        ' LEFT OUTER JOIN TIPO_STATUS TS ON (TS.ID_TIPO_STATUS = CBC.ID_T' +
        'IPO_STATUS) AND (TS.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO)'
      
        ' LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CB' +
        'C.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO' +
        ')'
      ''
      ' WHERE (CBC.ID_ORGANIZACAO =  :PIDORGANIZACAO) AND'
      '       (CBC.ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE)')
    Left = 192
    Top = 24
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCHEQUE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryListaChequesPorCB: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT  CBC.ID_CONTA_BANCARIA_CHEQUE AS IDCHEQUE,       '
      '        CBC.NUMERO_CHEQUE'
      ''
      'FROM CONTA_BANCARIA_CHEQUE CBC'
      ''
      'WHERE (CBC.ID_ORGANIZACAO =  :PIDORGANIZACAO) AND'
      '       (CBC.ID_CONTA_BANCARIA = :PIDCONTABANCARIA) '
      '  AND  (CBC.ID_TIPO_STATUS = '#39'EMITIDO'#39')'
      '')
    Left = 48
    Top = 24
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCONTABANCARIA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBBAIXA: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TPBCH.ID_TITULO_PAGAR_BAIXA_CHEQUE,'
      '       TPBCH.ID_ORGANIZACAO,'
      '       TPBCH.VALOR,'
      '       TPBCH.ID_TIPO_OPERACAO_BANCARIA AS TOB,'
      '       TOB.DESCRICAO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DATA_VENCIMENTO,'
      '       TP.DATA_PAGAMENTO,'
      '       TP.DESCRICAO AS DESCRICAO_TP,'
      '       TP.VALOR_NOMINAL,'
      '       TP.ID_TITULO_PAGAR,'
      '       TP.ID_RESPONSAVEL'
      ''
      '     '
      'FROM TITULO_PAGAR_BAIXA_CHEQUE TPBCH'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = TPBCH.ID_TIPO_OPERACAO_BANCARIA)'
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.ID_TITULO_PAGAR_B' +
        'AIXA = TPBCH.ID_TITULO_PAGAR_BAIXA)'
      
        'LEFT OUTER JOIN TITULO_PAGAR TP ON (TP.ID_TITULO_PAGAR = TPB.ID_' +
        'TITULO_PAGAR)'
      ''
      ''
      'WHERE  (TPBCH.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      '   AND (TPBCH.ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE)'
      ''
      '')
    Left = 48
    Top = 104
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCHEQUE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryInsereCBD: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    Left = 192
    Top = 112
  end
  object qryCheckIdent: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT COUNT(*) AS QTD '
      ''
      'FROM CONTA_BANCARIA_DEBITO CBD '
      ''
      ''
      'WHERE (CBD.IDENTIFICACAO = :PIDENT)')
    Left = 459
    Top = 24
    ParamData = <
      item
        Name = 'PIDENT'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryUpdateCheque: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'UPDATE CONTA_BANCARIA_CHEQUE CBC '
      '       SET CBC.ID_TIPO_STATUS = :PSTATUS, '
      '           CBC.DATA_COMPENSACAO = :PDATACOMPENSADO'
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (CBC.ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE)')
    Left = 320
    Top = 32
    ParamData = <
      item
        Name = 'PSTATUS'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATACOMPENSADO'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCHEQUE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
