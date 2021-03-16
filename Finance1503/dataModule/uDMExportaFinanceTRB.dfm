object dmExportFinanceTRB: TdmExportFinanceTRB
  OldCreateOrder = False
  Height = 582
  Width = 756
  object qryObterBaixaPorTitulo: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM//YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT  TRB.VALOR_PAGO,'
      '        TRB.ID_TITULO_RECEBER,'
      '        TRB.ID_TITULO_RECEBER_BAIXA,'
      '        TR.ID_CONTA_CONTABIL_CREDITO,'
      '        H.DESCRICAO AS DSC_HIST,'
      '        H.CODIGO AS CODIGO_HIST,'
      '        CCC.CONTA AS CONTA_CREDITO,'
      '        CCC.CODREDUZ AS COD_REDUZ_CREDITO,'
      '        CCD.CONTA AS CONTA_DEBITO,'
      '        CCD.CODREDUZ AS COD_REDUZ_DEBITO'
      ''
      'FROM TITULO_RECEBER_BAIXA TRB'
      
        'LEFT OUTER JOIN TITULO_RECEBER TR ON (TR.ID_TITULO_RECEBER = TRB' +
        '.ID_TITULO_RECEBER) AND (TR.ID_ORGANIZACAO = TRB.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TR.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TRB.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = T' +
        'R.ID_CONTA_CONTABIL_CREDITO) AND (CCC.ID_ORGANIZACAO = TRB.ID_OR' +
        'GANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = T' +
        'R.ID_CONTA_CONTABIL_DEBITO) AND (CCD.ID_ORGANIZACAO = TRB.ID_ORG' +
        'ANIZACAO)'
      ''
      'WHERE (TRB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TRB.ID_TITULO_RECEBER =:PIDTITULORECEBER) AND'
      '      (TRB.ID_LOTE_CONTABIL IS NULL)'
      ''
      'ORDER BY TRB.VALOR_PAGO DESC')
    Left = 552
    Top = 232
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULORECEBER'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
