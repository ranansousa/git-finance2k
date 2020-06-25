object dmDeletaLoteContabil: TdmDeletaLoteContabil
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 261
  Width = 449
  object qryObterTodosLoteContabil: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    SQL.Strings = (
      'SELECT  LC.ID_LOTE_CONTABIL,'
      '        LC.ID_ORGANIZACAO,'
      '        LC.LOTE,'
      '        LC.STATUS,'
      '        LC.DATA_REGISTRO,'
      '        LC.DATA_ATUALIZACAO,'
      '        LC.PERIODO_INICIAL,'
      '        LC.PERIODO_FINAL,'
      '        LC.TIPO_TABLE,'
      '        LC.QTD_REGISTROS'
      ''
      ' FROM LOTE_CONTABIL LC'
      ''
      'WHERE (LC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (LC.DATA_REGISTRO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL)' +
        ' AND'
      '      LC.STATUS <> '#39'EXCLUIDO'#39
      ''
      'ORDER BY LC.DATA_REGISTRO, LC.LOTE'
      '')
    Left = 44
    Top = 77
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
end
