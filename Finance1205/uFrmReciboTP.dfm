object frmReciboTP: TfrmReciboTP
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
      Caption = 'Emiss'#227'o de recibo de contas pagas'
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
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALOR_PAGO'
        Title.Alignment = taCenter
        Title.Caption = 'VALOR PAGO'
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
        Title.Caption = 'PAGAMENTO'
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
        FieldName = 'FORNECEDOR'
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
      DockedLeft = 485
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
          ItemName = 'cxbrdtmPesquisaCedente'
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
      DockedLeft = 414
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
    object cxbrdtmPesquisaCedente: TcxBarEditItem
      Align = iaRight
      Caption = 'Fornecedor'
      Category = 0
      Hint = 'Fornecedor'
      Visible = ivAlways
      OnCurChange = cxbrdtmPesquisaCedenteCurChange
      Width = 120
    end
  end
  object dsGrid: TDataSource
    DataSet = qryPreencheGrid
    OnDataChange = dsGridDataChange
    Left = 576
    Top = 184
  end
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.ID_TITULO_PAGAR,'
      '       TP.NUMERO_DOCUMENTO AS DOC,       '
      '       TP.ID_ORGANIZACAO,'
      '       (H.descricao || '#39' '#39' ||  TP.DESCRICAO) AS DESCRICAO,'
      '       TPB.VALOR_PAGO,'
      '       TP.ID_CEDENTE,'
      '       TP.data_pagamento,'
      '       C.nome AS FORNECEDOR,'
      '       TP.PARCELA,'
      '       '
      '       ORG.RAZAO_SOCIAL,'
      '       ORG.SIGLA, '
      '       ORG.FANTASIA,'
      '       ORG.CNPJ,'
      '       ORG.LOGRADOURO, '
      '       ORG.COMPLEMENTO,'
      '       ORG.NUMERO,'
      '       ORG.CEP,'
      '       E.DESCRICAO AS ESTADO,'
      '       CID.CIDADE,'
      '       B.BAIRRO'
      ''
      'FROM TITULO_PAGAR TP'
      ''
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.id_titulo_pagar =' +
        ' TP.id_titulo_pagar) AND (TPB.id_organizacao = TP.id_organizacao' +
        ')'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.id_cedente = TP.id_cedente) AND ' +
        '(C.id_organizacao = TP.id_organizacao)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.id_historico =  TP.id_historic' +
        'o) AND (H.id_organizacao = TP.id_organizacao)'
      
        'INNER JOIN ORGANIZACAO ORG ON (ORG.ID_ORGANIZACAO = TP.ID_ORGANI' +
        'ZACAO) '
      'INNER JOIN ESTADO E ON (E.ID_ESTADO = ORG.ID_ESTADO)'
      'INNER JOIN CIDADE CID ON (CID.ID_CIDADE = ORG.ID_CIDADE)'
      'INNER JOIN BAIRRO B ON (B.ID_BAIRRO = ORG.ID_BAIRRO)'
      'WHERE ( TP.ID_ORGANIZACAO = :PIDORGANIZACAO )'
      ' AND  ( TP.ID_TIPO_STATUS IN ('#39'PARCIAL'#39', '#39'QUITADO'#39') )'
      ''
      'ORDER BY TP.DATA_EMISSAO DESC, TP.VALOR_NOMINAL DESC'
      ''
      '')
    Left = 736
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
    ReportOptions.LastChange = 43827.800529953700000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 792
    Top = 264
  end
  object frxDBRecibo: TfrxDBDataset
    UserName = 'Recibo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'DOC=DOC'
      'PARCELA=PARCELA'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DESCRICAO=DESCRICAO'
      'VALOR_PAGO=VALOR_PAGO'
      'IDTPB=IDTPB'
      'ID_CEDENTE=ID_CEDENTE'
      'FORNECEDOR=FORNECEDOR'
      'TIPO=TIPO'
      'CED_CNPJ=CED_CNPJ'
      'RAZAO_SOCIAL=RAZAO_SOCIAL'
      'SIGLA=SIGLA'
      'FANTASIA=FANTASIA'
      'CNPJ=CNPJ'
      'ORG_END=ORG_END')
    DataSet = qryObterDados
    BCDToCurrency = False
    Left = 680
    Top = 256
  end
  object qryObterDados: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.ID_TITULO_PAGAR,'
      '       TP.NUMERO_DOCUMENTO AS DOC,'
      '       TP.PARCELA,'
      '       TP.data_pagamento,'
      '       TP.ID_ORGANIZACAO,'
      '       (H.descricao || '#39' '#39' ||  TP.DESCRICAO) AS DESCRICAO,'
      ''
      '       TPB.VALOR_PAGO,'
      '       TPB.id_titulo_pagar_baixa AS IDTPB,'
      ''
      '       TP.ID_CEDENTE,'
      '       C.nome AS FORNECEDOR,'
      '       TC.DESCRICAO as tipo,'
      '       c.cpfcnpj as ced_cnpj,'
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
      'FROM TITULO_PAGAR TP'
      ''
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.id_titulo_pagar =' +
        ' TP.id_titulo_pagar) AND (TPB.id_organizacao = TP.id_organizacao' +
        ')'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.id_cedente = TP.id_cedente) AND ' +
        '(C.id_organizacao = TP.id_organizacao)'
      
        'LEFT OUTER JOIN TIPO_CEDENTE TC ON (TC.id_TIPO_CEDENTE = C.ID_TI' +
        'PO_CEDENTE) AND (TC.id_organizacao = TP.id_organizacao)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.id_historico =  TP.id_historic' +
        'o) AND (H.id_organizacao = TP.id_organizacao)'
      
        'INNER JOIN ORGANIZACAO ORG ON (ORG.ID_ORGANIZACAO = TP.ID_ORGANI' +
        'ZACAO)'
      'INNER JOIN ESTADO E ON (E.ID_ESTADO = ORG.ID_ESTADO)'
      'INNER JOIN CIDADE CID ON (CID.ID_CIDADE = ORG.ID_CIDADE)'
      'INNER JOIN BAIRRO B ON (B.ID_BAIRRO = ORG.ID_BAIRRO)'
      'WHERE ( TP.ID_ORGANIZACAO = :PIDORGANIZACAO )'
      ' AND  ( TP.ID_TITULO_PAGAR = :PID )'
      ''
      ''
      '')
    Left = 784
    Top = 344
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
  object qryObterIDTPB: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ' SELECT FIRST 1 TPB.id_organizacao, '
      '        TPB.id_titulo_pagar_baixa,   '
      '        TPB.id_titulo_pagar'
      ''
      ''
      ' FROM TITULO_PAGAR_BAIXA TPB         '
      ''
      ''
      ' WHERE (TPB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND  '
      '      (TPB.id_titulo_pagar =:pIdtituloPagar) AND  '
      '      (TPB.ID_LOTE_CONTABIL IS NULL)           ')
    Left = 872
    Top = 344
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryBaixaTPCaixa: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ' SELECT td.ID_TITULO_PAGAR_BAIXA,'
      '          td.data_movimento, '
      '          td.valor_nominal as VALOR,'
      '          td.descricao,'
      '          h.descricao as DSC_HIST'
      '   FROM TESOURARIA_DEBITO TD'
      
        '   LEFT OUTER JOIN historico h on (h.id_historico = td.id_histor' +
        'ico) and (h.id_organizacao = td.id_organizacao)'
      ''
      ' WHERE (TD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '         (TD.id_titulo_pagar_baixa = :PIDTITULOPAGARBAIXA)')
    Left = 280
    Top = 440
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryBaixaTPCheque: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ''
      'SELECT  TPBC.ID_TITULO_PAGAR_BAIXA_CHEQUE,'
      '        TPBC.ID_ORGANIZACAO,'
      '        TPBC.ID_CONTA_BANCARIA_CHEQUE,'
      '        TPBC.ID_TITULO_PAGAR_BAIXA,'
      '        TPBC.VALOR as VALOR,'
      '        TOB.DESCRICAO AS TOB_DESC,'
      '        CBC.numero_cheque AS CHEQUE,'
      '        CB.titular, CB.conta, CB.AGENCIA, B.codigo_banco,'
      '        CBC.data_emissao, CBC.data_compensacao, CBC.PORTADOR'
      ''
      ''
      ''
      'FROM TITULO_PAGAR_BAIXA_CHEQUE TPBC'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = TPBC.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGAN' +
        'IZACAO = TPBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria_cheque CBC ON (CBC.ID_CONTA_BANCA' +
        'RIA_CHEQUE = TPBC.ID_CONTA_BANCARIA_CHEQUE)AND (CBC.ID_ORGANIZAC' +
        'AO = TPBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = CBC' +
        '.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = TPBC.ID_ORGANIZACAO' +
        ')'
      'LEFT OUTER JOIN BANCO B ON (B.id_banco = CB.id_banco)'
      
        'LEFT OUTER JOIN conta_contabil CC ON (CC.id_conta_contabil = CB.' +
        'id_conta_contabil) AND (CC.ID_ORGANIZACAO = TPBC.ID_ORGANIZACAO)'
      ''
      ''
      ''
      'WHERE (TPBC.id_organizacao = :PIDORGANIZACAO) AND'
      '       (TPBC.ID_TITULO_PAGAR_BAIXA = :PIDTITULOPAGARBAIXA)'
      '')
    Left = 200
    Top = 440
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterTPBBanco: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TPBI.ID_TITULO_PAGAR_BAIXA,'
      '       TPBI.ID_ORGANIZACAO,'
      '       TPBI.VALOR as VALOR,'
      '       TPBI.id_conta_bancaria,'
      '       TOB.DESCRICAO AS HISTORICO,'
      '       CB.titular, CB.conta, CB.AGENCIA, B.codigo_banco'
      ''
      ''
      '        '
      'FROM TITULO_PAGAR_BAIXA_INTERNET TPBI'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = TPBI.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGAN' +
        'IZACAO = TPBI.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = TPB' +
        'I.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = TPBI.ID_ORGANIZACA' +
        'O)'
      'LEFT OUTER JOIN BANCO B ON (B.id_banco = CB.id_banco)'
      'WHERE (TPBI.ID_ORGANIZACAO = :PIDORGANIZACAO )AND'
      '      (TPBI.ID_TITULO_PAGAR_BAIXA = :PIDTPB)'
      ''
      'ORDER BY TPBI.VALOR;')
    Left = 361
    Top = 440
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTPB'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBAcrescimos: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TPBA.id_titulo_pagar_baixa, '
      '       TPBA.valor as VALOR, '
      '       TA.descricao,'
      '       TA.id_historico, '
      '       H.descricao as dsc_hist, '
      '       H.id_conta_contabil,'
      '       H.Codigo,'
      '       CC.conta, CC.codreduz'
      'FROM titulo_pagar_baixa_ac TPBA'
      ''
      
        'JOIN tipo_acrescimo TA ON (TA.id_tipo_acrescimo = TPBA.id_tipo_a' +
        'crescimo) AND (TA.ID_ORGANIZACAO = TPBA.ID_ORGANIZACAO)'
      
        'JOIN HISTORICO H ON (H.id_historico = TA.id_historico) AND (H.ID' +
        '_ORGANIZACAO = TA.ID_ORGANIZACAO)'
      
        'JOIN conta_contabil CC ON (CC.id_conta_contabil = H.id_conta_con' +
        'tabil) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBA.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '      (TPBA.id_titulo_pagar_baixa = :pIdTitutloPagarBaixa)'
      ''
      'order by TPBA.valor')
    Left = 32
    Top = 440
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITUTLOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBDeducao: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    SQL.Strings = (
      'SELECT TPBD.id_titulo_pagar_baixa, '
      '       TPBD.valor as VALOR, '
      '       TD.descricao,'
      '       TD.id_historico, '
      '       H.descricao as dsc_hist, '
      '       H.id_conta_contabil, '
      '       H.codigo,'
      '       CC.conta, '
      '       CC.codreduz'
      'FROM titulo_pagar_baixa_de TPBD'
      ''
      
        'JOIN tipo_deducao TD ON (TD.ID_TIPO_DEDUCAO = TPBD.ID_TIPO_DEDUC' +
        'AO) AND (TD.ID_ORGANIZACAO = TPBD.ID_ORGANIZACAO)'
      
        'JOIN HISTORICO H ON (H.id_historico = TD.id_historico) AND (H.ID' +
        '_ORGANIZACAO = TD.ID_ORGANIZACAO)'
      
        'JOIN conta_contabil CC ON (CC.id_conta_contabil = H.id_conta_con' +
        'tabil) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBD.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '      (TPBD.id_titulo_pagar_baixa = :pIdTitutloPagarBaixa)'
      ''
      'ORDER BY TPBD.VALOR DESC')
    Left = 112
    Top = 440
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITUTLOPAGARBAIXA'
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
    Left = 896
    Top = 240
  end
  object frxDBTPQuitados: TfrxDBDataset
    UserName = 'TPQUITADOS'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'DATA_EMISSAO=DATA_EMISSAO'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'DESCRICAO=DESCRICAO'
      'PARCELA=PARCELA'
      'VALOR_NOMINAL=VALOR_NOMINAL'
      'IDTPB=IDTPB'
      'VALOR=VALOR'
      'NOME=NOME'
      'DSC_HIST=DSC_HIST'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'TIPO=TIPO')
    BCDToCurrency = False
    Left = 776
    Top = 408
  end
  object frxDBTPB: TfrxDBDataset
    UserName = 'TPBaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'ID_CENTRO_CUSTO=ID_CENTRO_CUSTO'
      'VALOR=VALOR'
      'TIPO_BAIXA=TIPO_BAIXA'
      'DATA_EMISSAO=DATA_EMISSAO'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'DESCRICAO=DESCRICAO'
      'PARCELA=PARCELA'
      'VALOR_TP=VALOR_TP'
      'NOME=NOME'
      'HST_COD=HST_COD'
      'DSC_HIST=DSC_HIST'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'DSC_CDD=DSC_CDD'
      'CONTA_DB=CONTA_DB'
      'COD_REDUZ_DB=COD_REDUZ_DB')
    BCDToCurrency = False
    Left = 872
    Top = 416
  end
  object frxTPBAcrescimo: TfrxDBDataset
    UserName = 'TPBAcrescimo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'ID_HISTORICO=ID_HISTORICO'
      'DSC_HIST=DSC_HIST'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'CODIGO=CODIGO'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ')
    DataSet = qryTPBAcrescimos
    BCDToCurrency = False
    Left = 27
    Top = 384
  end
  object frxTPBDeducao: TfrxDBDataset
    UserName = 'TPBDeducao'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'ID_HISTORICO=ID_HISTORICO'
      'DSC_HIST=DSC_HIST'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'CODIGO=CODIGO'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ')
    DataSet = qryTPBDeducao
    BCDToCurrency = False
    Left = 110
    Top = 384
  end
  object frxDBTPBCaixa: TfrxDBDataset
    UserName = 'TPBCaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'DSC_HIST=DSC_HIST')
    DataSet = qryBaixaTPCaixa
    BCDToCurrency = False
    Left = 280
    Top = 384
  end
  object frxTPBCheque: TfrxDBDataset
    UserName = 'TPBCheque'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA_CHEQUE=ID_TITULO_PAGAR_BAIXA_CHEQUE'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_CONTA_BANCARIA_CHEQUE=ID_CONTA_BANCARIA_CHEQUE'
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'VALOR=VALOR'
      'TOB_DESC=TOB_DESC'
      'CHEQUE=CHEQUE'
      'TITULAR=TITULAR'
      'CONTA=CONTA'
      'AGENCIA=AGENCIA'
      'CODIGO_BANCO=CODIGO_BANCO'
      'DATA_EMISSAO=DATA_EMISSAO'
      'DATA_COMPENSACAO=DATA_COMPENSACAO'
      'PORTADOR=PORTADOR')
    DataSet = qryBaixaTPCheque
    BCDToCurrency = False
    Left = 193
    Top = 384
  end
  object frxTPBBanco: TfrxDBDataset
    UserName = 'TPBBanco'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'VALOR=VALOR'
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'HISTORICO=HISTORICO'
      'TITULAR=TITULAR'
      'CONTA=CONTA'
      'AGENCIA=AGENCIA'
      'CODIGO_BANCO=CODIGO_BANCO')
    DataSet = qryObterTPBBanco
    BCDToCurrency = False
    Left = 361
    Top = 384
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
    Left = 24
    Top = 265
  end
end
