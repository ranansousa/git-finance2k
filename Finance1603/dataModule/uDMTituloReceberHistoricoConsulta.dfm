object dmTRHistoricoConsulta: TdmTRHistoricoConsulta
  OldCreateOrder = False
  Height = 455
  Width = 669
  object qryObterTRHistoricoPorTR: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TRH.ID_TITULO_RECEBER,'
      '       TRH.ID_HISTORICO, '
      '       TRH.VALOR, '
      '       H.DESCRICAO, '
      '       H.CODIGO,  '
      '       CC.CONTA,'
      '       CC.CODREDUZ'
      ''
      'FROM TITULO_RECEBER_HISTORICO TRH'
      
        'left outer JOIN HISTORICO H ON (H.ID_HISTORICO = TRH.ID_HISTORIC' +
        'O) and (h.id_organizacao = trh.id_organizacao)'
      
        'left outer JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.I' +
        'D_CONTA_CONTABIL) AND (CC.id_organizacao = H.id_organizacao)'
      ''
      'WHERE (TRH.ID_ORGANIZACAO =:pIdOrganizacao) AND'
      '      (TRH.ID_TITULO_RECEBER =:PID_TITULO_RECEBER);')
    Left = 238
    Top = 136
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PID_TITULO_RECEBER'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
