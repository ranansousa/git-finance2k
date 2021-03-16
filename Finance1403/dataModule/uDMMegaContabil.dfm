object dmMegaContabil: TdmMegaContabil
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 503
  Width = 1043
  object qryDadosEmpresaMega: TFDQuery
    Connection = dmConexao.ConnMega
    SQL.Strings = (
      'SELECT'
      '  *'
      ''
      'FROM'
      '  CADASTRO C'
      ''
      'WHERE'
      '  (C.INSCMF = :pCnpj)')
    Left = 72
    Top = 144
    ParamData = <
      item
        Name = 'PCNPJ'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qryExistLote: TFDQuery
    Connection = dmConexao.ConnMega
    SQL.Strings = (
      'SELECT '
      '  L.ID,'
      '  L.EMPRESA,'
      '  L.ANO, '
      '  L.LOTE'
      ''
      'FROM'
      '  CLOTES L'
      ''
      'WHERE'
      '  (L.EMPRESA = :pIDEmpresa) AND'
      '  (L.ANO = :pAno) AND'
      '  (L.LOTE = :pLote)')
    Left = 640
    Top = 264
    ParamData = <
      item
        Name = 'PIDEMPRESA'
        ParamType = ptInput
      end
      item
        Name = 'PANO'
        ParamType = ptInput
      end
      item
        Name = 'PLOTE'
        ParamType = ptInput
      end>
  end
  object qryGenIdClotes: TFDQuery
    Connection = dmConexao.ConnMega
    SQL.Strings = (
      'select gen_id(gen_id_clotes,1) from rdb$database')
    Left = 640
    Top = 184
  end
  object qryVerificaFechamento: TFDQuery
    Connection = dmConexao.ConnMega
    SQL.Strings = (
      'SELECT '
      '  L.ID'
      ''
      'FROM'
      '  CLANCAMENTOS L'
      ''
      'WHERE'
      '  (L.EMPRESA = :pIDEmpresa) AND'
      '  ((L.CDHIST = 65) OR (L.CDHIST = 66) OR'
      '   (L.CDHIST = 75) OR (L.CDHIST = 76)) AND'
      '(L.DATA BETWEEN :pDataInicial AND '#39'31.12.2020'#39')'
      ''
      '')
    Left = 640
    Top = 328
    ParamData = <
      item
        Name = 'PIDEMPRESA'
        ParamType = ptInput
      end
      item
        Name = 'PDATAINICIAL'
        ParamType = ptInput
      end>
  end
  object qryGravaLote: TFDQuery
    Connection = dmConexao.ConnMega
    Left = 640
    Top = 104
  end
  object qryObterPlanoContas: TFDQuery
    Connection = dmConexao.ConnMega
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500000
    SQL.Strings = (
      'SELECT '
      '    NMCONTA,'
      '    CONTA, '
      '    DGVER, '
      '    CODREDUZ, '
      '    DGREDUZ, '
      '    INSCMF, '
      '    TIPO, '
      '    GRAU, '
      '    ORDEM_DIPJ, '
      '    RELACIONAMENTO, '
      '    NATUREZA '
      'FROM CPLANOEMPRESA '
      
        'WHERE (LEI11638 <> 0 ) AND (GRAU = 5)  AND (EMPRESA = :PIDEMPRES' +
        'A) '
      'ORDER BY CONTA')
    Left = 64
    Top = 32
    ParamData = <
      item
        Name = 'PIDEMPRESA'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object dtsPlanoContas: TDataSource
    DataSet = qryObterPlanoContas
    Left = 360
    Top = 24
  end
  object qryInsereLancamento: TFDQuery
    Connection = dmConexao.ConnMega
    Left = 240
    Top = 136
  end
  object qryConsultaContaContabil: TFDQuery
    Connection = dmConexao.ConnMega
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500000
    SQL.Strings = (
      'SELECT '
      '    NMCONTA,'
      '    CONTA, '
      '    DGVER, '
      '    CODREDUZ, '
      '    DGREDUZ, '
      '    INSCMF, '
      '    TIPO, '
      '    GRAU, '
      '    ORDEM_DIPJ, '
      '    RELACIONAMENTO, '
      '    NATUREZA '
      'FROM CPLANOEMPRESA '
      'WHERE CONTA = :PCONTA'
      'AND CODREDUZ = :PCDREDUZ'
      'AND (LEI11638 <> 0 )'
      'AND (GRAU = 5)'
      'AND (EMPRESA = :PIDEMPRESA)')
    Left = 216
    Top = 32
    ParamData = <
      item
        Name = 'PCONTA'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PCDREDUZ'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PIDEMPRESA'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object qryObterLotePorFiltro: TFDQuery
    Connection = dmConexao.ConnMega
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500000
    SQL.Strings = (
      'SELECT cl.id, '
      '       cl.ano, '
      '       cl.empresa, '
      '       cl.lote,'
      '       cl.debito,'
      '       cl.credito,'
      '       cl.total'
      ''
      'FROM clotes cl'
      'WHERE cl.ano = :PANO'
      '  AND cl.empresa = :PIDEMPRESA'
      '  AND cl.lote = :PLOTE')
    Left = 640
    Top = 40
    ParamData = <
      item
        Name = 'PANO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PIDEMPRESA'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PLOTE'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object qryObterLoteError: TFDQuery
    Connection = dmConexao.ConnMega
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500000
    SQL.Strings = (
      'SELECT cl.id, '
      '       cl.ano, '
      '       cl.empresa, '
      '       cl.lote,'
      '       cl.diferenca,'
      '       cl.debito,'
      '       cl.credito'
      'FROM clotes_error cl'
      'WHERE cl.ano = :PANO'
      '  AND cl.empresa = :PIDEMPRESA'
      '  AND cl.lote = :PLOTE')
    Left = 480
    Top = 40
    ParamData = <
      item
        Name = 'PANO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PIDEMPRESA'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PLOTE'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object qryObterDataError: TFDQuery
    Connection = dmConexao.ConnMega
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500000
    SQL.Strings = (
      'SELECT cl.id, '
      '       cl.ano, '
      '       cl.empresa, '
      '       cl.data,'
      '       cl.diferenca,'
      '       cl.debito,'
      '       cl.credito'
      'FROM cdatas_error cl'
      'WHERE cl.ano = :PANO'
      '  AND cl.empresa = :PIDEMPRESA'
      '  AND cl.data'
      
        '  between (Select (current_date -1) from RDB$DATABASE) AND (Sele' +
        'ct (current_date+1 ) from RDB$DATABASE)'
      '')
    Left = 480
    Top = 112
    ParamData = <
      item
        Name = 'PANO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PIDEMPRESA'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
