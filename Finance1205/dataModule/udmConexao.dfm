object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 347
  Width = 558
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 200
    Top = 256
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrHourGlass
    Left = 88
    Top = 256
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 304
    Top = 256
  end
  object ConnMega: TFDConnection
    ConnectionName = 'connMega'
    Params.Strings = (
      'Protocol=TCPIP'
      'Database=F:\Clientes\producao\MEGA.FDB'
      'ConnectionDef=MEGA')
    FetchOptions.AssignedValues = [evMode, evDetailDelay]
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    ResourceOptions.AssignedValues = [rvCmdExecMode, rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    ConnectedStoredUsage = []
    LoginPrompt = False
    Left = 472
    Top = 136
  end
  object qryEstacoesConectadas: TFDQuery
    SQL.Strings = (
      'SELECT DISTINCT'
      '  MA.MON$ATTACHMENT_ID AS ID,'
      '  MA.MON$REMOTE_PROTOCOL AS PROTOCOLO,'
      '  MA.MON$REMOTE_ADDRESS AS ENDERECO,'
      '  MA.MON$REMOTE_PROCESS AS PROCESSO'
      'FROM'
      '  MON$ATTACHMENTS MA'
      'WHERE'
      '  (MA.MON$ATTACHMENT_ID <> CURRENT_CONNECTION)'
      '')
    Left = 312
    Top = 16
  end
  object qryObterGUID: TFDQuery
    SQL.Strings = (
      'select createguid() as newID from rdb$database')
    Left = 208
    Top = 16
  end
  object conn: TFDConnection
    ConnectionName = 'conn'
    Params.Strings = (
      'Database=F:\Clientes\producao\FINANCE.FDB'
      'ConnectionDef=FINANCE')
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    TxOptions.AutoStop = False
    ConnectedStoredUsage = []
    LoginPrompt = False
    Left = 464
    Top = 48
  end
  object qryDadosEmpresaMega: TFDQuery
    Connection = ConnMega
    SQL.Strings = (
      'SELECT'
      '  *'
      ''
      'FROM'
      '  CADASTRO C'
      ''
      'WHERE'
      '  (C.INSCMF = :pCnpj)')
    Left = 88
    Top = 16
    ParamData = <
      item
        Name = 'PCNPJ'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object frxPDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 184
    Top = 120
  end
  object frxCSVExport: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    UTF8 = False
    OpenAfterExport = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 280
    Top = 112
  end
  object frxJPEGExport: TfrxJPEGExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Left = 120
    Top = 131
  end
end
