object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 412
  Width = 510
  object Conn: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    Left = 40
    Top = 40
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 264
    Top = 336
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrHourGlass
    Left = 160
    Top = 336
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 48
    Top = 336
  end
  object qryLoadOrgs: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT * FROM ORGANIZACAO WHERE 1=1'
      'ORDER BY SIGLA DESC')
    Left = 88
    Top = 40
  end
  object DataSource11: TDataSource
    Left = 256
    Top = 176
  end
end