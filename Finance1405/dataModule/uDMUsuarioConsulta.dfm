object dmUsuarioConsulta: TdmUsuarioConsulta
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 389
  Width = 772
  object qryPreencheCombo: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT Upper(us.nome)  as NOME, '
      '       us.id_usuario as ID'
      'FROM usuario us '
      'WHERE  us.ativo = 1'
      'ORDER BY us.ultimo_acesso desc')
    Left = 80
    Top = 96
  end
  object qryObterUsuarioPorID: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT us.login as login, '
      'us.nome as nome, '
      'us.senha as senha, '
      'us.ultimo_acesso as acesso, '
      'us.eh_administrador as administrador, '
      'us.id_usuario as id_usuario'
      'FROM usuario us'
      'WHERE us.id_usuario =:pIdUsuario')
    Left = 216
    Top = 96
    ParamData = <
      item
        Name = 'PIDUSUARIO'
        DataType = ftSmallint
        ParamType = ptInput
        Size = 5
      end>
  end
  object dtsPreencheGrid: TDataSource
    DataSet = qryObterUsuarioPorID
    Left = 656
    Top = 24
  end
  object dtsUsuarioPorID: TDataSource
    DataSet = qryObterUsuarioPorID
    Left = 552
    Top = 24
  end
  object qryUsuarios: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT us.login as login,'
      '       us.nome, '
      '       us.senha, '
      '       us.ultimo_acesso, '
      '       us.eh_administrador, '
      '       us.id_usuario'
      'FROM usuario us'
      'WHERE 1=1')
    Left = 80
    Top = 184
  end
  object qryValidarUsuario: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT us.login as login,'
      '       us.id_organizacao,'
      '       us.nome, '
      '       us.senha, '
      '       us.ultimo_acesso, '
      '       us.eh_administrador as ADM, '
      '       us.id_usuario'
      'FROM usuario us'
      'WHERE us.id_usuario = :pIdUsuario'
      'AND us.login = :pLogin'
      'AND us.senha = :pSenha')
    Left = 216
    Top = 200
    ParamData = <
      item
        Name = 'PIDUSUARIO'
        DataType = ftInteger
        ParamType = ptInput
        Size = 5
      end
      item
        Name = 'PLOGIN'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PSENHA'
        DataType = ftString
        ParamType = ptInput
      end>
  end
end
