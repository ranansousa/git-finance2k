object frmReciboTR: TfrmReciboTR
  Left = 0
  Top = 0
  Caption = 'Emitir recibo '
  ClientHeight = 734
  ClientWidth = 1062
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 1062
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 0
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Emiss'#227'o de recibo de contas  recebidas'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar5'
        end
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end>
      Index = 0
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 714
    Width = 1062
    Height = 20
    Panels = <
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
  object dbgrd1: TDBGrid
    Left = 0
    Top = 135
    Width = 1062
    Height = 579
    Align = alClient
    DataSource = dsGrid
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgrd1TitleClick
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DOC'
        Title.Alignment = taCenter
        Title.Caption = 'DOCUMENTO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_PAGO'
        Title.Alignment = taCenter
        Title.Caption = 'VALOR'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 120
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATA_PAGAMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'DT_RCBTO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PARCELA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Alignment = taCenter
        Title.Caption = 'DESCRI'#199#195'O'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 380
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLIENTE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 270
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 125
    Width = 1062
    Height = 10
    Align = alTop
    TabOrder = 3
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
    Left = 664
    Top = 56
    PixelsPerInch = 96
    object dxBarManager1Bar3: TdxBar
      Caption = 'Sair'
      CaptionButtons = <>
      DockedLeft = 462
      DockedTop = 0
      FloatLeft = 818
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
    object dxBarManager1Bar5: TdxBar
      Caption = 'Pesquisar'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udWidth]
          UserWidth = 144
          Visible = True
          ItemName = 'cxbrdtmPesquisa'
        end
        item
          Position = ipBeginsNewColumn
          Visible = True
          ItemName = 'cxbrdtmPesquisaSacado'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar1: TdxBar
      Caption = 'Impress'#227'o'
      CaptionButtons = <>
      DockedLeft = 391
      DockedTop = 0
      FloatLeft = 1095
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnImpimir'
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
      OnClick = dxBtnFecharClick
    end
    object dxBtnDeletar: TdxBarLargeButton
      Caption = 'Deletar'
      Category = 0
      Hint = 'Deletar'
      Visible = ivAlways
    end
    object cxbrdtmPesquisa: TcxBarEditItem
      Align = iaRight
      Caption = 'Documento'
      Category = 0
      Hint = 'Documento'
      Visible = ivAlways
      OnCurChange = cxbrdtmPesquisaCurChange
      Width = 120
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
      OnClick = dxBtnImpimirClick
    end
    object cxbrdtmPesquisaSacado: TcxBarEditItem
      Align = iaRight
      Caption = 'Cliente'
      Category = 0
      Hint = 'Cliente'
      Visible = ivAlways
      OnCurChange = cxbrdtmPesquisaSacadoCurChange
      Width = 120
    end
  end
  object msgDlg: TEvMsgDlg
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
    Left = 808
    Top = 56
  end
  object dsGrid: TDataSource
    DataSet = qryPreencheGrid
    OnDataChange = dsGridDataChange
    Left = 608
    Top = 168
  end
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TR.ID_TITULO_RECEBER,'
      '       TR.NUMERO_DOCUMENTO AS DOC,       '
      '       TR.ID_ORGANIZACAO,'
      '       (H.descricao || '#39' '#39' ||  TR.DESCRICAO) AS DESCRICAO,'
      '       TRB.VALOR_PAGO,'
      '       TR.ID_SACADO,'
      '       TR.data_pagamento,'
      '       C.nome AS CLIENTE,'
      '       TR.PARCELA'
      '       '
      '       '
      ''
      'FROM TITULO_RECEBER TR'
      ''
      
        'LEFT OUTER JOIN TITULO_RECEBER_BAIXA TRB ON (TRB.id_titulo_RECEB' +
        'ER = TR.id_titulo_RECEBER) AND (TRB.id_organizacao = TR.id_organ' +
        'izacao)'
      
        'LEFT OUTER JOIN SACADO C ON (C.id_SACADO = TR.id_SACADO) AND (C.' +
        'id_organizacao = TR.id_organizacao)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.id_historico =  TR.id_historic' +
        'o) AND (H.id_organizacao = TR.id_organizacao)'
      'WHERE ( TR.ID_ORGANIZACAO = :PIDORGANIZACAO )'
      ' AND  ( TR.ID_TIPO_STATUS IN ('#39'PARCIAL'#39', '#39'QUITADO'#39') )'
      ''
      'ORDER BY TR.DATA_EMISSAO DESC, TR.VALOR_NOMINAL DESC'
      ''
      '')
    Left = 888
    Top = 184
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object frxReportRecibo: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43827.466410034700000000
    ReportOptions.LastChange = 43928.448210520830000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 744
    Top = 176
  end
  object frxDBRecibo: TfrxDBDataset
    UserName = 'Recibo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER'
      'DOC=DOC'
      'PARCELA=PARCELA'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DESCRICAO=DESCRICAO'
      'VALOR_PAGO=VALOR_PAGO'
      'IDTRB=IDTRB'
      'ID_SACADO=ID_SACADO'
      'CLIENTE=CLIENTE'
      'TIPO=TIPO'
      'SAC_CNPJ=SAC_CNPJ'
      'RAZAO_SOCIAL=RAZAO_SOCIAL'
      'SIGLA=SIGLA'
      'FANTASIA=FANTASIA'
      'CNPJ=CNPJ'
      'ORG_END=ORG_END')
    DataSet = qryObterDados
    BCDToCurrency = False
    Left = 712
    Top = 248
  end
  object qryObterDados: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TR.ID_TITULO_RECEBER,'
      '       TR.NUMERO_DOCUMENTO AS DOC,'
      '       TR.PARCELA,'
      '       TR.data_pagamento,'
      '       TR.ID_ORGANIZACAO,'
      '       (H.descricao || '#39' '#39' ||  TR.DESCRICAO) AS DESCRICAO,'
      ''
      '       TRB.VALOR_PAGO,'
      '       TRB.id_titulo_RECEBER_baixa AS IDTRB,'
      ''
      '       TR.ID_SACADO,'
      '       S.nome AS CLIENTE,'
      '       TS.DESCRICAO as tipo,'
      '       S.cpfcnpj as sac_cnpj,'
      ''
      '       ORG.RAZAO_SOCIAL,'
      '       ORG.SIGLA,'
      '       ORG.FANTASIA,'
      '       ORG.CNPJ,'
      
        '      ( ORG.LOGRADOURO || '#39' '#39' || ORG.COMPLEMENTO || '#39' '#39' || ORG.N' +
        'UMERO || '#39' , '#39' || B.BAIRRO || '#39' - '#39' ||  CID.CIDADE || '#39' - '#39' ||  ' +
        'E.DESCRICAO || '#39' CEP: '#39' ||  ORG.CEP   ) as ORG_END'
      ''
      ''
      'FROM TITULO_RECEBER TR'
      ''
      
        'LEFT OUTER JOIN TITULO_RECEBER_BAIXA TRB ON (TRB.id_titulo_RECEB' +
        'ER = TR.id_titulo_RECEBER) AND (TRB.id_organizacao = TR.id_organ' +
        'izacao)'
      
        'LEFT OUTER JOIN SACADO S ON (S.ID_SACADO = TR.ID_SACADO) AND (S.' +
        'id_organizacao = TR.id_organizacao)'
      
        'LEFT OUTER JOIN TIPO_SACADO TS ON (TS.id_TIPO_SACADO = S.ID_TIPO' +
        '_SACADO) AND (TS.id_organizacao = TR.id_organizacao)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.id_historico =  TR.id_historic' +
        'o) AND (H.id_organizacao = TR.id_organizacao)'
      
        'INNER JOIN ORGANIZACAO ORG ON (ORG.ID_ORGANIZACAO = TR.ID_ORGANI' +
        'ZACAO)'
      'INNER JOIN ESTADO E ON (E.ID_ESTADO = ORG.ID_ESTADO)'
      'INNER JOIN CIDADE CID ON (CID.ID_CIDADE = ORG.ID_CIDADE)'
      'INNER JOIN BAIRRO B ON (B.ID_BAIRRO = ORG.ID_BAIRRO)'
      'WHERE ( TR.ID_ORGANIZACAO = :PIDORGANIZACAO )'
      ' AND  ( TR.ID_TITULO_RECEBER = :PID )'
      ''
      ''
      '')
    Left = 592
    Top = 256
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
  object qryBaixaTRCaixa: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ' SELECT TC.ID_TITULO_RECEBER_BAIXA,'
      '        TC.data_movimento, '
      '        TC.valor_nominal as VALOR,'
      '        TC.descricao,'
      '        H.descricao as DSC_HIST'
      '   FROM TESOURARIA_CREDITO TC'
      
        '   LEFT OUTER JOIN historico h on (h.id_historico = TC.id_histor' +
        'ico) and (h.id_organizacao = TC.id_organizacao)'
      ''
      ' WHERE (TC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '       (TC.ID_TITULO_RECEBER_BAIXA = :PIDTITULOBAIXA)')
    Left = 184
    Top = 312
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryBaixaTRCheque: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT  TRBC.ID_TITULO_RECEBER_BAIXA_CHEQUE,'
      '        TRBC.ID_ORGANIZACAO,'
      '        TRBC.ID_TITULO_RECEBER_BAIXA,'
      '        TRBC.VALOR as VALOR,'
      '        TRBC.numero_cheque AS CHEQUE,'
      '        TRBC.titular, TRBC.conta, TRBC.AGENCIA, B.codigo_banco,'
      '        TRBC.data_PROTOCOLO'
      ''
      ''
      'FROM TITULO_RECEBER_BAIXA_CHEQUE TRBC'
      'LEFT OUTER JOIN BANCO B ON (B.id_banco = TRBC.id_banco)'
      ''
      ''
      'WHERE (TRBC.id_organizacao = :PIDORGANIZACAO) AND'
      '      (TRBC.ID_TITULO_RECEBER_BAIXA = :PIDTITULOBAIXA)'
      '')
    Left = 56
    Top = 312
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterTRBBanco: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TRBI.ID_TITULO_RECEBER_BAIXA,'
      '       TRBI.ID_ORGANIZACAO,'
      '       TRBI.VALOR as VALOR,'
      '       TRBI.id_conta_bancaria,'
      '       TOB.DESCRICAO AS HISTORICO,'
      '       CB.titular, CB.conta, CB.AGENCIA, B.codigo_banco'
      ''
      ''
      '        '
      'FROM TITULO_RECEBER_BAIXA_INTERNET TRBI'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = TRBI.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGAN' +
        'IZACAO = TRBI.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = TRB' +
        'I.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = TRBI.ID_ORGANIZACA' +
        'O)'
      'LEFT OUTER JOIN BANCO B ON (B.id_banco = CB.id_banco)'
      'WHERE (TRBI.ID_ORGANIZACAO = :PIDORGANIZACAO )AND'
      '      (TRBI.ID_TITULO_RECEBER_BAIXA = :PIDTITULOBAIXA)'
      ''
      'ORDER BY TRBI.VALOR;')
    Left = 321
    Top = 320
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object extenso: TEvExtenso
    Currency.Strings = (
      'real'
      'reais'
      'centavo'
      'centavos')
    Left = 992
    Top = 184
  end
  object frxDBTPQuitados: TfrxDBDataset
    UserName = 'TPQUITADOS'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 600
    Top = 368
  end
  object frxDBTRB: TfrxDBDataset
    UserName = 'TPBaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER')
    DataSet = qryObterIDTRB
    BCDToCurrency = False
    Left = 904
    Top = 328
  end
  object frxDBTRBCaixa: TfrxDBDataset
    UserName = 'TPBCaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'DSC_HIST=DSC_HIST')
    DataSet = qryBaixaTRCaixa
    BCDToCurrency = False
    Left = 192
    Top = 232
  end
  object frxTRBCheque: TfrxDBDataset
    UserName = 'TPBCheque'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA_CHEQUE=ID_TITULO_RECEBER_BAIXA_CHEQUE'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'VALOR=VALOR'
      'CHEQUE=CHEQUE'
      'TITULAR=TITULAR'
      'CONTA=CONTA'
      'AGENCIA=AGENCIA'
      'CODIGO_BANCO=CODIGO_BANCO'
      'DATA_PROTOCOLO=DATA_PROTOCOLO')
    DataSet = qryBaixaTRCheque
    BCDToCurrency = False
    Left = 49
    Top = 232
  end
  object frxTRBBanco: TfrxDBDataset
    UserName = 'TPBBanco'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'VALOR=VALOR'
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'HISTORICO=HISTORICO'
      'TITULAR=TITULAR'
      'CONTA=CONTA'
      'AGENCIA=AGENCIA'
      'CODIGO_BANCO=CODIGO_BANCO')
    DataSet = qryObterTRBBanco
    BCDToCurrency = False
    Left = 321
    Top = 232
  end
  object qryObterIDTRB: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ' SELECT FIRST 1 TRB.id_organizacao, '
      '        TRB.id_titulo_receber_baixa,   '
      '        TRB.id_titulo_receber'
      ''
      ''
      ' FROM TITULO_RECEBER_BAIXA TRB         '
      ''
      ''
      ' WHERE (TRB.ID_ORGANIZACAO   = :PIDORGANIZACAO) AND  '
      '       (TRB.id_titulo_RECEBER = :PIDTITULO) AND   '
      '       (TRB.ID_LOTE_CONTABIL IS NULL)           ')
    Left = 904
    Top = 256
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
