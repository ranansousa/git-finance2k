object frameGeneric: TframeGeneric
  Left = 0
  Top = 0
  Width = 303
  Height = 164
  TabOrder = 0
  object lblID: TLabel
    Left = 195
    Top = 6
    Width = 21
    Height = 13
    Caption = 'lblID'
    Visible = False
  end
  object cbbcombo: TComboBox
    Left = 0
    Top = 3
    Width = 161
    Height = 21
    TabOrder = 0
    Text = '>> Selecione <<'
    OnChange = cbbcomboChange
  end
  object qryObterPorID: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      '')
    Left = 56
    Top = 64
  end
  object qryObterTodos: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT E.ID_ESTADO, E.SIGLA, E.DESCRICAO'
      'FROM ESTADO E'
      'WHERE 1=1'
      'ORDER BY E.ID_ESTADO')
    Left = 152
    Top = 64
  end
end
