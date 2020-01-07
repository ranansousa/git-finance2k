inherited frmCidade: TfrmCidade
  Width = 270
  Height = 29
  ExplicitWidth = 270
  ExplicitHeight = 29
  inherited lblID: TLabel
    Left = 35
    Top = 36
    ExplicitLeft = 35
    ExplicitTop = 36
  end
  inherited cbbcombo: TComboBox
    AlignWithMargins = True
    Left = 3
    Width = 264
    Align = alClient
    AutoCompleteDelay = 1000
    ExplicitLeft = 2
    ExplicitWidth = 264
  end
  inherited qryObterPorID: TFDQuery
    Left = 48
    Top = 16
  end
  inherited qryObterTodos: TFDQuery
    Left = 120
    Top = 16
  end
  object qryObterEstado: TFDQuery
    Connection = dmConexao.conn
    Left = 184
    Top = 16
  end
end
