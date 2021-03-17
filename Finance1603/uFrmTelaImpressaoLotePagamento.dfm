object fmTelaImpressaoLotePagamento: TfmTelaImpressaoLotePagamento
  Left = 0
  Top = 0
  Caption = 'Pempec Entreprise Finance 2k'
  ClientHeight = 734
  ClientWidth = 863
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
  object dbgrdMain: TDBGrid
    Left = 0
    Top = 135
    Width = 863
    Height = 579
    Align = alClient
    DataSource = dsDbGrid
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgrdMainTitleClick
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'LOTE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATA_PAGAMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'PAGAMENTO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 150
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'FP'
        Title.Alignment = taCenter
        Title.Caption = 'FORMA PAG'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 130
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONTA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CHEQUE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 130
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'QTD'
        Title.Alignment = taCenter
        Title.Caption = 'T'#205'TULOS'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end>
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 863
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 1
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Manuten'#231#227'o de lote pagamento'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar2'
        end
        item
          ToolbarName = 'dxBarManager1Bar4'
        end
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar6'
        end>
      Index = 0
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 714
    Width = 863
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 125
    Width = 863
    Height = 10
    Align = alTop
    TabOrder = 3
  end
  object dsDbGrid: TDataSource
    DataSet = qryPreencheDBGrid
    OnDataChange = dsDbGridDataChange
    Left = 80
    Top = 304
  end
  object qryObterTitulos: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.id_titulo_pagar, TP.ID_LOTE_TPB, TP.ID_LOTE_CONTABIL,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.valor_nominal,'
      '       TP.DESCRICAO,'
      '       TP.id_lote_pagamento,'
      '       C.nome,  C.id_cedente'
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      '')
    Left = 336
    Top = 544
  end
  object frxRelLotePagamento: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 43865.677339756940000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 64
    Top = 536
  end
  object frxDBLote: TfrxDBDataset
    UserName = 'lote'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_LOTE_PAGAMENTO=ID_LOTE_PAGAMENTO'
      'LOTE=LOTE'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'VALOR=VALOR'
      'STATUS=STATUS'
      'ID_FORMA_PAGAMENTO=ID_FORMA_PAGAMENTO'
      'FP=FP'
      'ID_CONTA_BANCARIA_CHEQUE=ID_CONTA_BANCARIA_CHEQUE'
      'CHEQUE=CHEQUE'
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'ID_CONTA_BANCARIA_1=ID_CONTA_BANCARIA_1'
      'CONTA=CONTA')
    DataSet = qryLote
    BCDToCurrency = False
    Left = 168
    Top = 544
  end
  object frxDBTitulo: TfrxDBDataset
    UserName = 'titulo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'VALOR_NOMINAL=VALOR_NOMINAL'
      'DESCRICAO=DESCRICAO'
      'ID_LOTE_PAGAMENTO=ID_LOTE_PAGAMENTO'
      'NOME=NOME'
      'ID_CEDENTE=ID_CEDENTE')
    DataSet = qryObterTitulos
    BCDToCurrency = False
    Left = 248
    Top = 544
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
    Left = 551
    Top = 56
    PixelsPerInch = 96
    object dxBarManager1Bar2: TdxBar
      Caption = 'Pesquisar'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1095
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'cxbrdtmLote'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'Impress'#227'o'
      CaptionButtons = <>
      DockedLeft = 141
      DockedTop = 0
      FloatLeft = 1095
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarImprimir'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar6: TdxBar
      Caption = 'Sair'
      CaptionButtons = <>
      DockedLeft = 294
      DockedTop = 0
      FloatLeft = 1095
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnFechar1'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar1: TdxBar
      Caption = 'Deletar'
      CaptionButtons = <>
      DockedLeft = 212
      DockedTop = 0
      FloatLeft = 899
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnCancelaLote'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBtnEditar: TdxBarLargeButton
      Caption = 'Editar'#13#10
      Category = 0
      Hint = 'Editar'#13#10' registro. F2'
      Visible = ivAlways
    end
    object dxBtnSalvar: TdxBarLargeButton
      Caption = 'Salvar'
      Category = 0
      Hint = 'Salvar registro. F10'
      Visible = ivAlways
    end
    object dxBtnImprimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Novo registro. F4'
      Visible = ivAlways
    end
    object dxBtnFechar: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
    end
    object dxBtnDeletar: TdxBarLargeButton
      Caption = 'Deletar'
      Category = 0
      Hint = 'Deletar'
      Visible = ivAlways
    end
    object cxbrdtmPesquisa: TcxBarEditItem
      Caption = 'Documento'
      Category = 0
      Hint = 'Documento'
      Visible = ivAlways
      PropertiesClassName = 'TcxTextEditProperties'
    end
    object dxBtnImprime: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprime o recibo '
      Visible = ivAlways
    end
    object dxBtnImpimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprimir'
      Visible = ivAlways
    end
    object dxBtnFechar1: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar tela'
      Visible = ivAlways
      OnClick = dxBtnFechar1Click
    end
    object dxBarImprimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprimir'
      Visible = ivAlways
      OnClick = dxBarImprimirClick
    end
    object cxbrdtmLote: TcxBarEditItem
      Caption = 'Lote'
      Category = 0
      Hint = 'Lote'
      Visible = ivAlways
      OnCurChange = cxbrdtmLoteCurChange
    end
    object dxBtnCancelaLote: TdxBarLargeButton
      Caption = 'Cancelar Lote Pagto'
      Category = 0
      Hint = 'Cancelar Lote Pagto'
      Visible = ivAlways
      OnClick = dxBtnCancelaLoteClick
    end
  end
  object qryLote: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      ''
      
        'SELECT LP.id_lote_pagamento, LP.LOTE as LOTE, LP.id_organizacao,' +
        ' LP.DATA_PAGAMENTO, LP.VALOR, LP.status,'
      '       FP.id_forma_pagamento, FP.descricao AS FP,'
      
        '       CBC.id_conta_bancaria_cheque, CBC.numero_cheque AS CHEQUE' +
        ', CBC.id_conta_bancaria,'
      '       CB.id_conta_bancaria, CB.conta'
      'FROM lote_pagamento LP'
      ''
      
        'LEFT OUTER JOIN forma_pagamento FP ON (FP.id_forma_pagamento = L' +
        'P.id_forma_pagamento)   AND (FP.ID_ORGANIZACAO = LP.ID_ORGANIZAC' +
        'AO)'
      
        'LEFT OUTER JOIN conta_bancaria_cheque CBC ON (CBC.id_conta_banca' +
        'ria_cheque = LP.id_conta_bancaria_cheque) AND (CBC.ID_ORGANIZACA' +
        'O = LP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = LP.' +
        'id_conta_bancaria) AND (CB.ID_ORGANIZACAO = LP.ID_ORGANIZACAO)'
      ' '
      
        'WHERE (LP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (LP.ID_LOTE_PAGA' +
        'MENTO = :PID)'
      '')
    Left = 424
    Top = 544
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PID'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
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
    Left = 672
    Top = 56
  end
  object qryObterPagos: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.id_titulo_pagar, TP.ID_LOTE_TPB, TP.ID_LOTE_CONTABIL,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.valor_nominal,'
      '       TP.DESCRICAO,'
      '       TP.id_lote_pagamento,'
      '       C.nome,  C.id_cedente'
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      '')
    Left = 504
    Top = 544
  end
  object qryPreencheDBGrid: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      
        ' SELECT LP.id_lote_pagamento, LP.LOTE as LOTE, LP.id_organizacao' +
        ', LP.DATA_PAGAMENTO, LP.VALOR, LP.status, LP.QTD_TIT_PAG as QTD,'
      '       FP.id_forma_pagamento, FP.descricao AS FP,'
      
        '       CBC.id_conta_bancaria_cheque, CBC.numero_cheque AS CHEQUE' +
        ', CBC.id_conta_bancaria,'
      '       CB.id_conta_bancaria, CB.conta'
      '       FROM lote_pagamento LP'
      
        '       LEFT OUTER JOIN forma_pagamento FP ON (FP.id_forma_pagame' +
        'nto = LP.id_forma_pagamento)   AND (FP.ID_ORGANIZACAO = LP.ID_OR' +
        'GANIZACAO)'
      
        '       LEFT OUTER JOIN conta_bancaria_cheque CBC ON (CBC.id_cont' +
        'a_bancaria_cheque = LP.id_conta_bancaria_cheque) AND (CBC.ID_ORG' +
        'ANIZACAO = LP.ID_ORGANIZACAO)'
      
        '       LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancari' +
        'a = LP.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = LP.ID_ORGANIZ' +
        'ACAO)'
      '       WHERE (LP.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      '       ORDER BY LP.DATA_PAGAMENTO DESC ;')
    Left = 272
    Top = 352
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
        Value = Null
      end>
  end
end
