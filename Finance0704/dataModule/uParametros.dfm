object DataModule1: TDataModule1
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
    Left = 96
    Top = 72
  end
end
