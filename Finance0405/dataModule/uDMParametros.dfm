object dmParametros: TdmParametros
  OldCreateOrder = False
  Height = 264
  Width = 448
  object qryObterTodos: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      
        'SELECT P.CODIGO, (P.MENSAGEM) AS PARAMETRO, P.TELA, P.STATUS  FR' +
        'OM PARAMETROS P'
      'WHERE 1=1 '
      'ORDER BY P.CODIGO')
    Left = 64
    Top = 48
  end
  object qryObterStatusTela: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      
        'SELECT P.CODIGO, (P.MENSAGEM) AS PARAMETRO, P.TELA, P.STATUS  FR' +
        'OM PARAMETROS P'
      'WHERE P.CODIGO = :PCODIGO'
      '')
    Left = 64
    Top = 112
    ParamData = <
      item
        Name = 'PCODIGO'
        DataType = ftString
        ParamType = ptInput
        Size = 20
      end>
  end
end
