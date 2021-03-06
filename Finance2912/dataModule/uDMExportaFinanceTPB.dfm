object dmExportFinanceTPB: TdmExportFinanceTPB
  OldCreateOrder = False
  Height = 477
  Width = 512
  object qryObterBaixaPorTitulo: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM//YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT *'
      'FROM TITULO_PAGAR_BAIXA TPB'
      ''
      'WHERE (TPB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TPB.id_titulo_pagar =:pIdtituloPagar) AND'
      '      (TPB.ID_LOTE_CONTABIL IS NULL)'
      ''
      'ORDER BY TPB.VALOR_PAGO DESC'
      '')
    Left = 216
    Top = 208
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
