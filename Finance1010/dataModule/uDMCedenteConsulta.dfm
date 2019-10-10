object dmCedenteConsulta: TdmCedenteConsulta
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 342
  Width = 499
  object qryPreencheCombo: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT NOME,ID_CEDENTE FROM CEDENTE '
      'WHERE (ID_ORGANIZACAO = :pIdOrganizacao)')
    Left = 80
    Top = 152
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterCedentePorID: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT C.ID_CEDENTE,c.NOME,c.CPFCNPJ AS CNPJ,'
      '       C.ID_TIPO_CEDENTE,c.ID_CONTATO,c.PERSONALIDADE,'
      
        '       C.STATUS,c.CONTA_BANCARIA,c.AGENCIA,C.id_banco, bc.sigla_' +
        'banco AS banco, '
      
        '       c.data_registro,c.codigo, ctt.telefone, ctt.email,ctt.cel' +
        'ular'
      'FROM CEDENTE C'
      'LEFT OUTER join contato ctt on (ctt.id_contato = c.id_contato)'
      'LEFT OUTER join banco bc on (bc.id_banco = c.id_banco)'
      'WHERE (C.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '      (C.ID_CEDENTE = :pIdCedente);'
      '')
    Left = 200
    Top = 152
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCEDENTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dtsPreencheGrid: TDataSource
    DataSet = qryObterCedentePorID
    Left = 328
    Top = 152
  end
  object dtsCedentePorID: TDataSource
    DataSet = qryObterCedentePorID
    Left = 320
    Top = 224
  end
end
