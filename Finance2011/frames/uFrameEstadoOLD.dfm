object frmEstado: TfrmEstado
  Left = 0
  Top = 0
  Width = 311
  Height = 132
  TabOrder = 0
  object lblID: TLabel
    Left = 195
    Top = 6
    Width = 21
    Height = 13
    Caption = 'lblID'
    Visible = False
  end
  object cbbEstado: TComboBox
    Left = 0
    Top = 3
    Width = 161
    Height = 21
    TabOrder = 0
    Text = 'cbbEstado'
  end
  object qryObterPorID: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT E.ID_ESTADO, E.SIGLA, E.DESCRICAO'
      'FROM ESTADO E'
      'WHERE E.ID_ESTADO = :ID_ESTADO')
    Left = 56
    Top = 64
    ParamData = <
      item
        Name = 'ID_ESTADO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterTodos: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT E.ID_ESTADO, E.SIGLA, E.DESCRICAO'
      'FROM ESTADO E'
      'WHERE 1=1'
      'ORDER BY E.ID_ESTADO')
    Left = 152
    Top = 64
  end
end
