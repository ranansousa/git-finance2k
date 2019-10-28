object dmContasPagarManter: TdmContasPagarManter
  OldCreateOrder = False
  Height = 433
  Width = 669
  object qryDeletaExcluidos: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'DELETE '
      'FROM TITULO_PAGAR TP '
      'WHERE (TP.ID_TIPO_STATUS = :PIDSTATUS) AND'
      '      (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (tp.ID_TITULO_GERADOR is null) ;'
      '')
    Left = 64
    Top = 72
    ParamData = <
      item
        Name = 'PIDSTATUS'
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
  object qryAlteraNumDoc: TFDQuery
    Left = 64
    Top = 160
  end
end
