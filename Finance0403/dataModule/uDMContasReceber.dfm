object dmContasReceber: TdmContasReceber
  OldCreateOrder = False
  Height = 317
  Width = 561
  object qryObterTRPendentes: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      '  SELECT T.CNPJ,'
      '         T.VALOR,'
      '         T.VALOR_PAGO,'
      '         T.DATA_VCTO,'
      '         T.DATA_PAGTO,'
      '         T.DATA_PROTOCOLO,'
      '         T.PRODUTO,'
      '         T.CONTA,'
      '         T.SACADO,'
      '         T.HISTORICO,'
      '         T.CENTRO_CUSTO,'
      '         T.CONTA_BANCARIA'
      '  FROM TITULO_RECEBER_PENDENTE T  '
      ''
      '  WHERE T.ID_ORGANIZACAO = :PIDORGANIZACAO '
      ''
      '  ORDER BY T.VALOR_PAGO ')
    Left = 56
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dtsPendentesImportados: TDataSource
    DataSet = qryObterTRPendentes
    Left = 64
    Top = 112
  end
  object qryDelPendentesAll: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'DELETE FROM titulo_receber_pendente TRP'
      'WHERE TRP.id_organizacao =:PIDORGANIZACAO;')
    Left = 160
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
