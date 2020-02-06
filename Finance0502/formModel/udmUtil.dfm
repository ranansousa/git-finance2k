object dmUtil: TdmUtil
  OldCreateOrder = False
  Height = 461
  Width = 760
  object qryAppInfo: TFDQuery
    SQL.Strings = (
      'SELECT'
      '  U.TIME_OUT'
      'FROM'
      '  UC_APP_INFO U')
    Left = 64
    Top = 40
  end
  object qrySignatarios: TFDQuery
    Connection = dmConexao.fdConexao
    SQL.Strings = (
      'SELECT'
      '  S.ID_SOCIOS,'
      '  S.NOME'
      'FROM'
      '  SOCIOS S'
      'WHERE'
      '  (S.FK_PESSOA = :pIdPessoa)'
      'AND'
      '  (S.DATA_ENTRADA <= :pDataFinal)'
      'AND'
      
        '  (COALESCE(S.DATA_SAIDA, (SELECT R_DATA_MAXIMA_LIMITE FROM SP_D' +
        'ATA_MAXIMA_LIMITE)) >= :pDataFinal)'
      '--AND'
      '--  (CHAR_LENGTH(TRIM(S.INSCMF)) = 14)'
      'ORDER BY'
      '  S.NOME  '
      '')
    Left = 66
    Top = 112
    ParamData = <
      item
        Name = 'PIDPESSOA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end>
  end
end
