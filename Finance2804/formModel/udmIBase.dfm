object dmIBase: TdmIBase
  OldCreateOrder = False
  Height = 363
  Width = 517
  object qryLog: TFDQuery
    SQL.Strings = (
      'INSERT INTO UCTABHISTORY ('
      '  APPLICATIONID,'
      '  USERID,'
      '  EVENTDATE,'
      '  EVENTTIME,'
      '  FORM,'
      '  FORMCAPTION,'
      '  "EVENT",'
      '  OBS,'
      '  TNAME)'
      'VALUES ('
      '  :APPLICATIONID,'
      '  :USERID,'
      '  :EVENTDATE,'
      '  :EVENTTIME,'
      '  :FORM,'
      '  :FORMCAPTION,'
      '  :"EVENT",'
      '  :OBS,'
      '  :TNAME)  ')
    Left = 82
    Top = 176
    ParamData = <
      item
        Name = 'APPLICATIONID'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'USERID'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'EVENTDATE'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'EVENTTIME'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'FORM'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'FORMCAPTION'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'EVENT'
        IsCaseSensitive = True
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'OBS'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TNAME'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qryPost: TFDQuery
    FetchOptions.AssignedValues = [evUnidirectional]
    Left = 82
    Top = 110
  end
  object qryPesquisaConteudoAnteriorCampo: TFDQuery
    Left = 80
    Top = 236
  end
  object qryPesquisaFk: TFDQuery
    Left = 80
    Top = 294
  end
end
