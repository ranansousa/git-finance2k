object dmContaContabil: TdmContaContabil
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 454
  Width = 529
  object qryObterPlanoContas: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500000
    SQL.Strings = (
      
        'SELECT * FROM conta_contabil C WHERE (C.id_organizacao = :PIDORG' +
        'ANIZACAO) ORDER BY CONTA')
    Left = 392
    Top = 224
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dtsPlanoContas: TDataSource
    DataSet = qryObterPlanoContas
    Left = 456
    Top = 320
  end
  object qryIncluirConta: TFDQuery
    Left = 224
    Top = 312
  end
  object qryObterPorConta: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      
        'SELECT * FROM conta_contabil C WHERE (C.id_organizacao = :PIDORG' +
        'ANIZACAO)'
      ' AND ((c.conta = :PCONTA));')
    Left = 232
    Top = 216
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PCONTA'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qryAtualizaDescricaoConta: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'UPDATE CONTA_CONTABIL CC SET  CC.DESCRICAO = UPPER(:pDescricao),'
      '                              CC.conta = (:PCONTA),'
      '                              CC.dgver = (:PDGVER),'
      '                              CC.codreduz = (:PCODREDUZ),'
      '                              CC.dgreduz = (:PDGREDUZ),'
      '                              CC.DATA_REGISTRO = (:PDATA),'
      '                              CC.tipo = (:PTIPO)'
      ''
      'WHERE (CC.ID_CONTA_CONTABIL = :pIdContaContabil) AND '
      '      (CC.ID_ORGANIZACAO = :pIDOrganizacao);')
    Left = 232
    Top = 112
    ParamData = <
      item
        Name = 'PDESCRICAO'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end
      item
        Name = 'PCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 14
      end
      item
        Name = 'PDGVER'
        DataType = ftString
        ParamType = ptInput
        Size = 1
      end
      item
        Name = 'PCODREDUZ'
        DataType = ftString
        ParamType = ptInput
        Size = 18
      end
      item
        Name = 'PDGREDUZ'
        DataType = ftString
        ParamType = ptInput
        Size = 1
      end
      item
        Name = 'PDATA'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PTIPO'
        DataType = ftString
        ParamType = ptInput
        Size = 1
      end
      item
        Name = 'PIDCONTACONTABIL'
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
  object qryObterPorCodigoReduzido: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ''
      'SELECT * FROM conta_contabil C'
      'WHERE (C.id_organizacao = :PIDORGANIZACAO) AND'
      '(C.CODREDUZ = :PCODREDUZ)')
    Left = 400
    Top = 112
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PCODREDUZ'
        DataType = ftString
        ParamType = ptInput
      end>
  end
end
