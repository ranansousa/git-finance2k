object frmExtratoBancario: TfrmExtratoBancario
  Left = 0
  Top = 0
  Caption = 'Emiss'#227'o de Extrato Banc'#225'rio'
  ClientHeight = 222
  ClientWidth = 879
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 144
  TextHeight = 19
  object lbl: TLabel
    Left = 37
    Top = 8
    Width = 205
    Height = 19
    Caption = 'Relat'#243'rio de Extrato Banc'#225'rio'
  end
  inline frmContaBancaria1: TfrmContaBancaria
    Left = 393
    Top = 57
    Width = 243
    Height = 94
    TabOrder = 0
    ExplicitLeft = 393
    ExplicitTop = 57
    ExplicitHeight = 94
    inherited lbl1: TLabel
      Width = 105
      Height = 19
      ExplicitWidth = 105
      ExplicitHeight = 19
    end
    inherited cbbConta: TComboBox
      Top = 25
      Height = 27
      OnChange = frmContaBancaria1cbbContaChange
      ExplicitTop = 25
      ExplicitHeight = 27
    end
    inherited qryObterTodos: TFDQuery
      Left = 128
      Top = 32
    end
    inherited qryObterContaContabil: TFDQuery
      Left = 40
      Top = 40
    end
  end
  inline frmPeriodo1: TfrmPeriodo
    Left = 18
    Top = 49
    Width = 351
    Height = 97
    TabOrder = 1
    ExplicitLeft = 18
    ExplicitTop = 49
    ExplicitWidth = 351
    ExplicitHeight = 97
    inherited lbl1: TLabel
      Top = 3
      Width = 79
      Height = 19
      ExplicitTop = 3
      ExplicitWidth = 79
      ExplicitHeight = 19
    end
    inherited lbl2: TLabel
      Left = 186
      Top = 3
      Width = 70
      Height = 19
      ExplicitLeft = 186
      ExplicitTop = 3
      ExplicitWidth = 70
      ExplicitHeight = 19
    end
    inherited dtpDataInicial: TDateTimePicker
      Top = 28
      Width = 130
      Height = 30
      OnChange = frmPeriodo1dtpDataInicialChange
      ExplicitTop = 28
      ExplicitWidth = 130
      ExplicitHeight = 30
    end
    inherited dtpDataFinal: TDateTimePicker
      Left = 186
      Top = 28
      Width = 130
      Height = 30
      OnChange = frmPeriodo1dtpDataFinalChange
      ExplicitLeft = 186
      ExplicitTop = 28
      ExplicitWidth = 130
      ExplicitHeight = 30
    end
  end
  object btnImprimir: TButton
    Left = 652
    Top = 68
    Width = 150
    Height = 30
    Caption = 'Imprimir'
    TabOrder = 2
    OnClick = btnImprimirClick
  end
  object btnFechar: TBitBtn
    Left = 652
    Top = 116
    Width = 150
    Height = 30
    Caption = 'Fechar'
    TabOrder = 3
    OnClick = btnFecharClick
  end
  object chkTipo: TCheckBox
    Left = 652
    Top = 24
    Width = 197
    Height = 17
    Caption = 'Totalizado por dia'
    TabOrder = 4
  end
  object frxExtratoBancario: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 43761.866405787000000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 72
    Top = 152
  end
  object frxPDFExport1: TfrxPDFExport
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
    Left = 328
    Top = 152
  end
  object frxCSVExport1: TfrxCSVExport
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
    Left = 240
    Top = 152
  end
  object frxExtrato: TfrxDBDataset
    UserName = 'EXTRATO'
    CloseDataSource = False
    FieldAliases.Strings = (
      'DATA=DATA'
      'VALOR=VALOR'
      'DETALHAMENTO=DETALHAMENTO'
      'TIPO=TIPO')
    DataSet = dmExtratoBancario.qryExtrato
    BCDToCurrency = False
    Left = 160
    Top = 152
  end
  object PempecMsg: TEvMsgDlg
    ButtonFont.Charset = DEFAULT_CHARSET
    ButtonFont.Color = clWindowText
    ButtonFont.Height = -11
    ButtonFont.Name = 'Tahoma'
    ButtonFont.Style = []
    MessageFont.Charset = DEFAULT_CHARSET
    MessageFont.Color = clWindowText
    MessageFont.Height = -11
    MessageFont.Name = 'Tahoma'
    MessageFont.Style = []
    Left = 400
    Top = 10
  end
end
