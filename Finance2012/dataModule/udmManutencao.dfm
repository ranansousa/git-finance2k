object dmManutencao: TdmManutencao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 364
  Width = 449
  object qryAllTables: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT rdb$relation_name as tabela'
      'FROM rdb$relations'
      'WHERE rdb$system_flag = 0'
      '   -- and rdb$relation_type = 0'
      'order by rdb$relation_name'
      ';')
    Left = 64
    Top = 40
  end
  object qry1: TFDQuery
    SQL.Strings = (
      'SELECT rdb$relation_name as tabela'
      'FROM rdb$relations'
      'WHERE rdb$system_flag = 0'
      '  --  and rdb$relation_type = 0'
      'order by rdb$relation_name'
      ';')
    Left = 64
    Top = 120
  end
end
