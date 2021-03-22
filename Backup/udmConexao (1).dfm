object dmConexao: TdmConexao
  OldCreateOrder = False
  Height = 412
  Width = 510
  object Conn: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=D:\Clientes\Imap\FINANCE.FDB'
      'Server=127.0.0.1'
      'Port=3051'
      'DriverID=FB')
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
  object ConnMega: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    Left = 168
    Top = 40
  end
end
