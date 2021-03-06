object frmSaldoContas: TfrmSaldoContas
  Left = 0
  Top = 0
  Caption = 'Saldo das Contas Banc'#225'rias'
  ClientHeight = 701
  ClientWidth = 1182
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
  object dbgrd1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 138
    Width = 1176
    Height = 540
    Align = alClient
    Color = clInfoBk
    DataSource = dsSaldo
    GradientEndColor = clTeal
    GradientStartColor = clMoneyGreen
    Options = [dgTitles, dgColLines, dgRowLines, dgTabs]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    StyleElements = [seFont, seClient]
    OnDrawColumnCell = dbgrd1DrawColumnCell
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONTA'
        Title.Alignment = taCenter
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JANEIRO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FEVEREIRO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MARCO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ABRIL'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAIO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JUNHO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JULHO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AGOSTO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SETEMBRO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OUTUBRO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOVEMBRO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DEZEMBRO'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end>
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 1182
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 1
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Saldo das Contas banc'#225'rias'#13#10
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar4'
        end
        item
          ToolbarName = 'dxBarManager1Bar5'
        end
        item
          ToolbarName = 'dxBarManager1Bar2'
        end
        item
          ToolbarName = 'dxBarManager1Bar6'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end>
      Index = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 125
    Width = 1182
    Height = 10
    Align = alTop
    TabOrder = 2
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 681
    Width = 1182
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 500
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 500
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object dsSaldo: TDataSource
    DataSet = qrySaldosBancarios
    OnDataChange = dsSaldoDataChange
    Left = 472
    Top = 424
  end
  object qryObterConta: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT'
      '     CB.ID_CONTA_BANCARIA,'
      '     CB.CONTA,'
      '     CB.AGENCIA,'
      '     CB.TITULAR,'
      '     CB.SALDO_INICIAL,'
      '     CB.ID_CONTA_CONTABIL,'
      '     CC.CONTA AS CONTA_CONT,'
      '     CC.DESCRICAO AS DSC_CONT,'
      '     CC.CODREDUZ AS COD_CONT'
      ''
      ' FROM CONTA_BANCARIA CB'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = CB.' +
        'ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = CB.ID_ORGANIZACAO)'
      
        'WHERE (CB.ID_CONTA_BANCARIA = :PIDCONTA) AND (CB.ID_ORGANIZACAO ' +
        '= :PIDORGANIZACAO)'
      ''
      '')
    Left = 432
    Top = 520
    ParamData = <
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qrySaldosBancarios: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT'
      '     CB.ID_CONTA_BANCARIA,'
      '     CB.CONTA,     '
      '     CB.TITULAR,'
      '     CBS.ANO,'
      '     CBS.JANE AS JANEIRO,'
      '     CBS.FEVE AS FEVEREIRO,'
      '     CBS.MARC AS MARCO,'
      '     CBS.ABRI AS ABRIL,'
      '     CBS.MAIO AS MAIO,'
      '     CBS.JUNH AS JUNHO,'
      '     CBS.JULH AS JULHO,'
      '     CBS.AGOS AS AGOSTO,'
      '     CBS.SETE AS SETEMBRO,'
      '     CBS.OUTU AS OUTUBRO,'
      '     CBS.NOVE AS NOVEMBRO,'
      '     CBS.DEZE AS DEZEMBRO'
      ''
      ''
      ''
      'FROM CONTA_BANCARIA_SALDO CBS'
      ''
      ''
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB  ON (CB.ID_CONTA_BANCARIA = CB' +
        'S.ID_CONTA_BANCARIA)'
      ''
      'WHERE 1=1'
      ''
      'ORDER BY CBS.ANO, CB.CONTA'
      ''
      '')
    Left = 936
    Top = 520
  end
  object qryObterTodasContas: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT'
      '     CB.ID_CONTA_BANCARIA,'
      '     CB.CONTA,'
      '     CB.AGENCIA,'
      '     CB.TITULAR,'
      '     CB.SALDO_INICIAL,'
      '     CB.ID_CONTA_CONTABIL'
      ''
      ''
      'FROM CONTA_BANCARIA CB'
      'WHERE (CB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (CB.ATIVO = 1)'
      ''
      '')
    Left = 568
    Top = 520
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryLimpaDataset: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'DELETE FROM  CONTA_BANCARIA_SALDO WHERE 1=1')
    Left = 88
    Top = 520
  end
  object qryPreparaDataset: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      
        'INSERT INTO CONTA_BANCARIA_SALDO (ID_CONTA_BANCARIA, ANO) VALUES' +
        ' ( :PIDCONTA, :PANO);'
      '')
    Left = 200
    Top = 520
    ParamData = <
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PANO'
        DataType = ftString
        ParamType = ptInput
        Size = 4
      end>
  end
  object qryInsereSaldoConta: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      
        'INSERT INTO CONTA_BANCARIA_SALDO (ID_CONTA_BANCARIA, ANO) VALUES' +
        ' ( :PIDCONTA, :PANO);'
      '')
    Left = 320
    Top = 520
    ParamData = <
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PANO'
        DataType = ftString
        ParamType = ptInput
        Size = 4
      end>
  end
  object frxRelatorioSaldos: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.AllowEdit = False
    PreviewOptions.AllowPreviewEdit = False
    PreviewOptions.Buttons = [pbPrint, pbSave, pbExport, pbZoom, pbFind, pbPageSetup, pbTools, pbExportQuick]
    PreviewOptions.DoubleBuffered = False
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.Description.Strings = (
      'Pempec Enterprise Finance 2k')
    ReportOptions.LastChange = 43770.569159594910000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 800
    Top = 384
  end
  object frxDBSaldos: TfrxDBDataset
    UserName = 'SALDOS'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'CONTA=CONTA'
      'TITULAR=TITULAR'
      'ANO=ANO'
      'JANEIRO=JANEIRO'
      'FEVEREIRO=FEVEREIRO'
      'MARCO=MARCO'
      'ABRIL=ABRIL'
      'MAIO=MAIO'
      'JUNHO=JUNHO'
      'JULHO=JULHO'
      'AGOSTO=AGOSTO'
      'SETEMBRO=SETEMBRO'
      'OUTUBRO=OUTUBRO'
      'NOVEMBRO=NOVEMBRO'
      'DEZEMBRO=DEZEMBRO')
    DataSet = qrySaldosBancarios
    BCDToCurrency = False
    Left = 944
    Top = 384
  end
  object qrySaldoDebito: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'select sum(CBD.valor) as SALDO,'
      '       max(cb.conta) as conta_banco,'
      '       max(cb.titular) as titular,'
      '       max(cc.conta) as conta_contbil,'
      '       max(cc.descricao) as dsc_cc'
      ''
      'FROM  conta_bancaria_debito CBD'
      
        'left outer join conta_bancaria cb on (cb.id_conta_bancaria = cbD' +
        '.id_conta_bancaria) and (CB.ID_ORGANIZACAO = CBD.ID_ORGANIZACAO)'
      
        'left outer join conta_contabil cc on (cc.id_conta_contabil = cb.' +
        'id_conta_contabil) and (CC.ID_ORGANIZACAO = CBD.ID_ORGANIZACAO)'
      ''
      ''
      ''
      'WHERE (CBD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (CBD.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) AND'
      '      (CBD.ID_CONTA_BANCARIA = :PIDCONTA)'
      ''
      '')
    Left = 792
    Top = 520
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qrySaldoCredito: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'select sum(cbc.valor) as SALDO,'
      '       max(cb.conta) as conta_banco,'
      '       max(cb.titular) as titular,'
      '       max(cc.conta) as conta_contbil,'
      '       max(cc.descricao) as dsc_cc'
      ''
      'FROM  conta_bancaria_credito cbc'
      
        'left outer join conta_bancaria cb on (cb.id_conta_bancaria = cbc' +
        '.id_conta_bancaria)'
      
        'left outer join conta_contabil cc on (cc.id_conta_contabil = cb.' +
        'id_conta_contabil)'
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (CBC.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) AND'
      '      (CBC.ID_CONTA_BANCARIA = :PIDCONTA)'
      ''
      ''
      '')
    Left = 680
    Top = 520
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 888
    Top = 64
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Processar'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1423
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnProcessar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Imprimir'
      CaptionButtons = <>
      DockedLeft = 588
      DockedTop = 0
      FloatLeft = 1423
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnImprimir'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Fechar'
      CaptionButtons = <>
      DockedLeft = 808
      DockedTop = 0
      FloatLeft = 1423
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnFechar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'Per'#237'odo'
      CaptionButtons = <>
      DockedLeft = 75
      DockedTop = 0
      FloatLeft = 1218
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarDataInicial'
        end
        item
          Visible = True
          ItemName = 'dxBarDataFinal'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar5: TdxBar
      Caption = 'Filtro'
      CaptionButtons = <>
      DockedLeft = 290
      DockedTop = 0
      FloatLeft = 1218
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarCbxContas'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar6: TdxBar
      Caption = 'Transmitir'
      CaptionButtons = <>
      DockedLeft = 659
      DockedTop = 0
      FloatLeft = 1218
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          ViewLayout = ivlGlyphControlCaption
          Visible = True
          ItemName = 'chkJPG'
        end
        item
          ViewLayout = ivlGlyphControlCaption
          Visible = True
          ItemName = 'chkPDF'
        end
        item
          Visible = True
          ItemName = 'dxBarBtnEnviaMail'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBtnProcessar: TdxBarLargeButton
      Caption = 'Processar'
      Category = 0
      Hint = 'Processar'
      Visible = ivAlways
      OnClick = dxBtnProcessarClick
    end
    object dxBtnImprimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprimir'
      Visible = ivAlways
      OnClick = dxBtnImprimirClick
    end
    object dxBtnFechar: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBtnFecharClick
    end
    object dxBarDataInicial: TdxBarDateCombo
      Align = iaRight
      Caption = 'Data Inicial'
      Category = 0
      Hint = 'Data Inicial'
      Visible = ivAlways
      OnChange = dxBarDataInicialChange
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000FF00FFFFFF00FFFFFF00
        FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFF0000
        00FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FF0000
        80FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFF000080FF000080FF000080FF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FFFF000000FF800000FF8000
        00FF800000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FFFF000000FF800000FF8000
        00FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF0000
        00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF}
      Width = 120
    end
    object dxBarDataFinal: TdxBarDateCombo
      Align = iaRight
      Caption = 'Data Final'
      Category = 0
      Hint = 'Data Final'
      Visible = ivAlways
      OnChange = dxBarDataFinalChange
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000FF00FFFFFF00FFFFFF00
        FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFF0000
        00FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FF0000
        80FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFF000080FF000080FF000080FF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FFFF000000FF800000FF8000
        00FF800000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FFFF000000FF800000FF8000
        00FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF0000
        00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF}
      Width = 120
    end
    object dxBarLargeButton1: TdxBarLargeButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object dxBarCbxContas: TdxBarCombo
      Caption = 'Conta Banc'#225'ria'
      Category = 0
      Hint = 'Conta Banc'#225'ria'
      Visible = ivAlways
      OnChange = dxBarCbxContasChange
      Width = 200
      ItemIndex = -1
    end
    object cxBarEditItem1: TcxBarEditItem
      Caption = 'Enviar por'
      Category = 0
      Hint = 'Enviar por'
      Visible = ivAlways
      PropertiesClassName = 'TcxRadioGroupProperties'
      Properties.Items = <>
    end
    object cxBarEditItem2: TcxBarEditItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      PropertiesClassName = 'TcxCheckGroupProperties'
      Properties.Items = <>
    end
    object chkJPG: TcxBarEditItem
      Caption = 'Imagem'
      Category = 0
      Hint = 'Imagem'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000033744558745469746C6500496D6167653B50686F746F3B5069637475
        72653B4469616772616D3B4669677572653B647261773B7061696E7415D5C670
        0000022049444154785EA5934D4B546114C77F8FA3E514312E34214D050D5711
        58462DA226A14D9BE82BB80AA245B8AA5D9BA27511116D4312A245416E4C1149
        C309844C94D0D2AC2C1947E7CE9D3BF7798B0E7A61825EA0C3E5BCFC9F7B7F9C
        E7B9E75180029058657FD53CE0D49D4733234AA9AC285EFCCE03A2F9ED2879B2
        668D191BE8EFEDAB0DC3383BD07F2C61FEABDDBC3F751A48D558E304399B37CC
        6E18DE6E68A696F32C3EBB85FF364434F710B5F914FDFE1E2A3FC8FCE3EB783C
        C63800556BAD2414632B6D5AABD18B394C5822F8B04231BFC4EAD01B5A7A0FD3
        D0D246BCB5B9FD9E4500C63A21AE950C1ED09588EE9941DACEF5906E6E2277FB
        094D07D22C8CCD90BDD444E791B4009CDDE9C0581176F92B00A49465A93DC0BC
        18A1A5AB95C6EE0EE646673974A29DCF931F595EF8CAD11ED009C03A0154E20A
        0AF0CA5368B434E48A64BA4E62831217AFF5B1FA6A85868E34F3B950FE86353E
        D982085125402905C0FA7A81FD3664E2EE20DA39F61D3CC5BBDC027612C2DD16
        F713E06C75075BA542321FC520C05D38CEEB4FD3144637493D1866BCD9B3D159
        87D686F372882E0108B11C9511C5C39E8CE2F9C44BC2C0D0DABB97B19A1ABE2C
        4764D2298AC508E77C154084A852C1E141A6033ABAEBA54E79F8BEA641411C5B
        F26BB1005C02700EE7E1F2D9E96494138FAA1A6DE7A5C43A0402501B95C3D1AB
        3786CF241F0905AA535F5D033A2E8D035A01F540DD1F6EA5FACD4DD440A4BCF7
        FC8FFD008E0F555D42FE2EE90000000049454E44AE426082}
      ShowCaption = True
      Width = 0
      PropertiesClassName = 'TcxCheckBoxProperties'
      Properties.ImmediatePost = True
    end
    object chkPDF: TcxBarEditItem
      Caption = 'PDF'
      Category = 0
      Hint = 'PDF'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000000E744558745469746C65005064663B53656E64C252BCE00000028449
        444154785E65524F48545F14FEEECC0B756A882CD29214332B6572516241CEA0
        E18804090DB47421B410AA5D24697F7E94444484D0AA850B3741FF8468A16136
        834561A8E568B93022B494292D4543677EEF9CDBBDF7F16CAC8F77DEBDDFE19C
        EF7C87F78494122E26C2E147CC1C91CC2026489B4044E6CEA48355D88AB37367
        EAB29006293952D8F314920566FEBB80C5580CC5B1178A03532DE7301FED43C9
        AB214848304BBCDB1F8878900EC9A679A2A60A3997AF821567063E1CAEC0F6B6
        EB66AA763C5A5E86F8817DE6BE46801946BDA8378AE98B2DDAAAE190FAAD0F87
        970E8C80754E8525847045C45828A46BF1B1BA12AC9B894D334933D9E4580223
        E58155EEB97377A0AFE3FE200D8F4DDB7A024CA1844DE48830B0F7E51B4C369F
        051CAE42AA600012A2F5468F6C6A3884BC9C8D986C3D8F85E751D86483898D80
        6DDBA698898C1322369CD8B8EAB27CBE4CBC7DFF05CBCB2914B55DC336727673
        218480E515888F4F61E957125EB10EA18AC24C55938482C5120856ECC2C0F067
        3CE98DA3A92168F64CAE103232BCC666EBAD07282ECAC791CA32743E1C34BA70
        000FB1D95915E4A260C7565CBAF918733F97B0393B0BDF661770AAB9033B0BF2
        113C580A8FF0C0B6E55A01D696159F492CC2BF3E0B671A6BD079AF1FC71BDB71
        BBA31BA74F1E455EEE16CCCDAF80A40411AF11B06C6224BE2FE2EBCC0FD45597
        A809848613211CAB2D07C0C8DEE4C79EE23CF444C76179B583BF04B4E2EBA14F
        88D49521952268F87D3EF837F8E042E7C3C1DDE8EA8EBB029E3F022A511F0E20
        45EE1F2720A04E764E172405EA6B03181A7D86745889C46CEC4A7BB44AB73A8F
        D671EF8EA8A10E472AB9DC0FC08682BB4BA6165AB5F52F045C38FAFF0348AA21
        6697DF17529B5239C3C2E10000000049454E44AE426082}
      ShowCaption = True
      Width = 0
      PropertiesClassName = 'TcxCheckBoxProperties'
      Properties.ImmediatePost = True
    end
    object dxBarBtnEnviaMail: TdxBarLargeButton
      Align = iaCenter
      Caption = 'Enviar E-mail'
      Category = 0
      Hint = 'Enviar E-mail'
      Visible = ivAlways
      OnClick = dxBarBtnEnviaMailClick
    end
    object dxBarEdit1: TdxBarEdit
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
    end
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
    Left = 976
    Top = 48
  end
  object qryObterTodos: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT CB.ID_CONTA_BANCARIA,'
      '       CB.ID_ORGANIZACAO,'
      '       CB.ID_CONTA_CONTABIL, '
      '       CB.ID_BANCO,'
      '       CB.CONTA,'
      '       CB.AGENCIA,'
      '       CB.TITULAR'
      ''
      'FROM CONTA_BANCARIA CB'
      ''
      'WHERE (CB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (CB.ATIVO = 1)')
    Left = 1032
    Top = 56
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object FDQuery1: TFDQuery
    SQL.Strings = (
      'select'
      '  c.conta_banco_dsc,'
      '  sum(c.janeiro) as janeiro,'
      '  sum(c.fevereiro) as fevereiro,'
      '  sum(c.marco) as marco,'
      '  sum(c.abril) as abril,'
      '  sum(c.maio) as maio,'
      '  sum(c.junho) as junho,'
      '  sum(c.julho) as julho,'
      '  sum(c.agosto) as agosto,'
      '  sum(c.setembro) as setembro,'
      '  sum(c.outubro) as outubro,'
      '  sum(c.novembro) as novembro,'
      '  sum(c.dezembro) as dezembro'
      'from'
      '  sp_saldo_bancario(2021,'#39'imap'#39') c'
      'group by'
      '  c.conta_banco_dsc'
      'order by'
      '  c.conta_banco_dsc')
    Left = 256
    Top = 312
  end
end
