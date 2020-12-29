object FRelPagamentos: TFRelPagamentos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Relat'#243'rio Contas a Pagar'
  ClientHeight = 528
  ClientWidth = 1106
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 27
    Top = 13
    Width = 53
    Height = 13
    Caption = 'Data Inicial'
  end
  object Label3: TLabel
    Left = 304
    Top = 13
    Width = 48
    Height = 13
    Caption = 'Data Final'
  end
  object Label4: TLabel
    Left = 24
    Top = 69
    Width = 41
    Height = 13
    Caption = 'Empresa'
  end
  object Label5: TLabel
    Left = 304
    Top = 69
    Width = 84
    Height = 13
    Caption = 'Centro de Custos'
  end
  object Label6: TLabel
    Left = 24
    Top = 117
    Width = 34
    Height = 13
    Caption = 'Status '
  end
  object Label7: TLabel
    Left = 304
    Top = 117
    Width = 53
    Height = 13
    Caption = 'Ordena'#231#227'o'
  end
  object dtDataInicial: TDateTimePicker
    Left = 24
    Top = 32
    Width = 186
    Height = 21
    Date = 42572.376240046300000000
    Time = 42572.376240046300000000
    TabOrder = 0
  end
  object dtDataFinal: TDateTimePicker
    Left = 304
    Top = 32
    Width = 186
    Height = 21
    Date = 42572.376240046300000000
    Time = 42572.376240046300000000
    TabOrder = 1
  end
  object cbxOrganizacoes: TComboBox
    Left = 24
    Top = 88
    Width = 186
    Height = 21
    ItemIndex = 0
    TabOrder = 2
    Text = 'Organiza'#231#245'es'
    Items.Strings = (
      'Organiza'#231#245'es')
  end
  object cbxCentrosCusto: TComboBox
    Left = 304
    Top = 88
    Width = 186
    Height = 21
    ItemIndex = 0
    TabOrder = 3
    Text = 'Centro de Custo'
    Items.Strings = (
      'Centro de Custo')
  end
  object cbxStatus: TComboBox
    Left = 24
    Top = 136
    Width = 186
    Height = 21
    ItemIndex = 0
    TabOrder = 4
    Text = 'TODOS'
    Items.Strings = (
      'TODOS'
      'ABERTO'
      'EXCLUIDO'
      'QUITADO')
  end
  object cbxOrdem: TComboBox
    Left = 304
    Top = 136
    Width = 186
    Height = 21
    ItemIndex = 0
    TabOrder = 5
    Text = 'VALOR'
    Items.Strings = (
      'VALOR'
      'CEDENTE'
      'CENTRO DE CUSTO'
      'DATA DE PAGAMENTO'
      'DATA DE VENCIMENTO'
      'HIST'#211'RICO'
      'STATUS')
  end
  object Button1: TButton
    Left = 24
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 6
    OnClick = Button1Click
  end
  object DBGridMain: TDBGrid
    Left = 24
    Top = 232
    Width = 1074
    Height = 298
    Cursor = crSQLWait
    Color = clInfoBk
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMERO_DOCUMENTO'
        Title.Caption = 'NUM.DOC'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_NOMINAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Caption = 'VALOR'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_VENCIMENTO'
        Title.Caption = 'VENCIMENTO'
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_PAGAMENTO'
        Title.Caption = 'PAGAMENTO'
        Title.Color = clMoneyGreen
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESC_HISTORICO'
        Title.Caption = 'HISTORICO'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CEDENTE'
        Title.Caption = 'FORNECEDOR'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CENTRO_DE_CUSTO'
        Title.Caption = 'CENTRO DE CUSTO'
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Title.Color = clYellow
        Width = 80
        Visible = True
      end>
  end
  object frxRelContasPagar: TfrxReport
    Version = '5.3.14'
    DataSet = frxDBTitulos
    DataSetName = 'Titulos'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 42574.358524097200000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 280
    Top = 336
  end
  object frxDBTitulos: TfrxDBDataset
    UserName = 'Titulos'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'VALOR_NOMINAL=VALOR_NOMINAL'
      'DATA_VENCIMENTO=DATA_VENCIMENTO'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'DESCRICAO=DESCRICAO'
      'DESC_HISTORICO=DESC_HISTORICO'
      'NOME_CEDENTE=NOME_CEDENTE'
      'STATUS=STATUS'
      'CENTRO_DE_CUSTO=CENTRO_DE_CUSTO')
    DataSet = dmContasPagar.qryRelPagamentos
    BCDToCurrency = False
    Left = 392
    Top = 336
  end
  object frxDBCentroCusto: TfrxDBDataset
    UserName = 'CentroCusto'
    CloseDataSource = False
    DataSet = dmContasPagar.qryCentroCusto
    BCDToCurrency = False
    Left = 472
    Top = 336
  end
  object frxCSVExport1: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    UTF8 = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 560
    Top = 336
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
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
    Left = 680
    Top = 336
  end
end
