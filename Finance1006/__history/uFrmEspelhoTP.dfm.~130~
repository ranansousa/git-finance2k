object formEspelhoTP: TformEspelhoTP
  Left = 0
  Top = 0
  Caption = 'Espelho de t'#237'tulo a pagar'
  ClientHeight = 734
  ClientWidth = 1011
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
  object statStatusEsp: TStatusBar
    Left = 0
    Top = 715
    Width = 1011
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 400
      end>
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 1011
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 1
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Espelho de t'#237'tulo a pagar'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar2'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end
        item
          ToolbarName = 'dxBarManager1Bar4'
        end>
      Index = 0
    end
  end
  object dbgrdMain: TDBGrid
    Left = 0
    Top = 135
    Width = 1011
    Height = 580
    Align = alClient
    Color = 13433082
    DataSource = dsTitulos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = dbgrdMainDrawColumnCell
    OnDblClick = dbgrdMainDblClick
    OnTitleClick = dbgrdMainTitleClick
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATA_VENCIMENTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'VENCIMENTO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATA_PAGAMENTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
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
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'NUMERO_DOCUMENTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Title.Caption = 'DOCUMENTO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FORNECEDOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_NOMINAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'VALOR'
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
        FieldName = 'DSC_HST'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'HIST'#211'RICO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DSC_TP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'DESCRI'#199#195'O'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 125
    Width = 1011
    Height = 10
    Align = alTop
    TabOrder = 3
  end
  object qryBusca: TFDQuery
    FormatOptions.AssignedValues = [fvFmtDisplayDate]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    SQL.Strings = (
      'SELECT TP.ID_TITULO_PAGAR,'
      '       TP.ID_ORGANIZACAO,'
      '       TP.ID_CEDENTE,'
      '       TP.ID_HISTORICO,'
      '       TP.ID_CENTRO_CUSTO,'
      '       TP.ID_TIPO_STATUS,'
      '       TP.ID_TIPO_COBRANCA,'
      '       TP.ID_RESPONSAVEL,'
      '       TP.ID_LOCAL_PAGAMENTO,'
      '       TP.ID_TITULO_GERADOR,'
      '       TP.ID_LOTE_CONTABIL,'
      '       TP.ID_LOTE_PAGAMENTO,'
      '       TP.ID_USUARIO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DESCRICAO,'
      '       TP.DATA_REGISTRO,'
      '       TP.DATA_EMISSAO,'
      '       TP.DATA_VENCIMENTO,'
      '       TP.DATA_PAGAMENTO,'
      '       TP.DATA_ULTIMA_ATUALIZACAO,'
      '       TP.PREVISAO_CARTORIO,'
      '       TP.VALOR_NOMINAL,'
      '       TP.VALOR_ANTECIPADO,'
      '       TP.PARCELA,'
      '       TP.OBSERVACAO,'
      '       TP.REGISTRO_PROVISAO,'
      '       TP.ID_CONTA_CONTABIL_DEBITO,'
      '       TP.ID_CONTA_CONTABIL_CREDITO,'
      '       TP.ID_LOTE_TPB,'
      '       H.DESCRICAO AS DSC_HIST,'
      '       H.CODIGO AS COD_HIST,'
      '       TS.DESCRICAO AS STATUS,'
      '       CCD.CONTA AS CONTA_DB,'
      '       CCD.CODREDUZ AS CODRED_DB,'
      '       CCC.CONTA AS CONTA_CR,'
      '       CCC.CODREDUZ AS CODRED_CR,'
      '       F.NOME AS RESPONSAVEL'
      ''
      ''
      ''
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN FUNCIONARIO F ON (F.ID_FUNCIONARIO = TP.ID_RESPO' +
        'NSAVEL) AND (F.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN TIPO_STATUS TS ON (TS.ID_TIPO_STATUS = TP.ID_TIP' +
        'O_STATUS) AND (TS.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON   (H.ID_HISTORICO = TP.ID_HISTORI' +
        'CO)  AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = T' +
        'P.ID_CONTA_CONTABIL_DEBITO) AND (CCD.ID_ORGANIZACAO = TP.ID_ORGA' +
        'NIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = T' +
        'P.ID_CONTA_CONTABIL_CREDITO) AND (CCC.ID_ORGANIZACAO = TP.ID_ORG' +
        'ANIZACAO)'
      ''
      
        'WHERE ((TP.numero_documento = :PNUMDOC) OR (TP.ID_TITULO_PAGAR =' +
        ' :PIDTP))'
      'AND    (TP.ID_ORGANIZACAO   = :PIDORGANIZACAO);'
      ''
      '')
    Left = 208
    Top = 289
    ParamData = <
      item
        Name = 'PNUMDOC'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end
      item
        Name = 'PIDTP'
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
    Left = 816
    Top = 186
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
    Left = 904
    Top = 184
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Pesquisa'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1018
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'cxbrdtmPesquisa'
        end
        item
          Visible = True
          ItemName = 'cxBarPesquisaCedente'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Imprimir'
      CaptionButtons = <>
      DockedLeft = 819
      DockedTop = 0
      FloatLeft = 1018
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnImprimirMultiplos'
        end
        item
          Visible = True
          ItemName = 'dxBarBtnEnviarEmail'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'Sair'
      CaptionButtons = <>
      DockedLeft = 940
      DockedTop = 0
      FloatLeft = 1018
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
    object dxBarManager1Bar2: TdxBar
      Caption = 'Filtros'
      CaptionButtons = <>
      DockedLeft = 201
      DockedTop = 0
      FloatLeft = 1047
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarDTINI'
        end
        item
          Visible = True
          ItemName = 'dxBarDTFIN'
        end
        item
          Position = ipBeginsNewColumn
          Visible = True
          ItemName = 'dxBarCbxTipo'
        end
        item
          Position = ipBeginsNewColumn
          Visible = True
          ItemName = 'dxBarCbxOrdem'
        end
        item
          Visible = True
          ItemName = 'dxBarCbxStatus'
        end
        item
          Position = ipBeginsNewColumn
          Visible = True
          ItemName = 'dxBarBtnConsulta'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBtnFechar: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Sair'
      Visible = ivAlways
      OnClick = dxBtnFecharClick
    end
    object dxBtnImprimir: TdxBarLargeButton
      Caption = 'Imprimir OLD'
      Category = 0
      Hint = 'Imprimir OLD'
      Visible = ivNever
      OnClick = dxBtnImprimirClick
    end
    object dxBarEdit1: TdxBarEdit
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
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
    object cxBarPesquisaCedente: TcxBarEditItem
      Align = iaRight
      Caption = 'Fornecedor'
      Category = 0
      Hint = 'Fornecedor'
      Visible = ivAlways
      OnCurChange = cxBarPesquisaCedenteCurChange
      Width = 120
    end
    object dxBarDTINI: TdxBarDateCombo
      Align = iaRight
      Caption = 'Data in'#237'cio'
      Category = 0
      Hint = 'Data in'#237'cio'
      Visible = ivAlways
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
      Text = 'sex 10/04/2020'
      DateOnStart = bdsCustom
    end
    object dxBarDTFIN: TdxBarDateCombo
      Align = iaRight
      Caption = 'Data   final'
      Category = 0
      Hint = 'Data   final'
      Visible = ivAlways
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
      Text = 'sex 10/04/2020'
      DateOnStart = bdsCustom
    end
    object dxBarCbxOrdem: TdxBarCombo
      Align = iaRight
      Caption = 'Ordem'
      Category = 0
      Hint = 'Ordem'
      Visible = ivAlways
      Width = 120
      Items.Strings = (
        'VENCIMENTO'
        'PAGAMENTO'
        'VALOR')
      ItemIndex = -1
    end
    object dxBarCbxFornecedor: TdxBarCombo
      Align = iaRight
      Caption = 'Fornecedor'
      Category = 0
      Hint = 'Fornecedor'
      Visible = ivAlways
      Width = 120
      ItemIndex = -1
    end
    object dxBarCbxTipo: TdxBarCombo
      Align = iaRight
      Caption = 'Data'
      Category = 0
      Hint = 'Data'
      Visible = ivAlways
      Width = 120
      Items.Strings = (
        'VENCIMENTO'
        'PAGAMENTO')
      ItemIndex = -1
    end
    object dxBarBtnConsulta: TdxBarButton
      Caption = '     Consultar    '
      Category = 0
      Hint = '     Consultar    '
      Visible = ivAlways
      OnClick = dxBarBtnConsultaClick
    end
    object dxBarCbxStatus: TdxBarCombo
      Align = iaRight
      Caption = 'Status'
      Category = 0
      Hint = 'Status'
      Visible = ivAlways
      Width = 120
      Items.Strings = (
        'TODOS'
        'QUITADO'
        'ABERTO')
      ItemIndex = -1
    end
    object dxBtnImprimirMultiplos: TdxBarLargeButton
      Caption = '  Imprimir'
      Category = 0
      Hint = '  Imprimir'
      Visible = ivAlways
      OnClick = dxBtnImprimirMultiplosClick
    end
    object dxBarBtnEnviarEmail: TdxBarLargeButton
      Caption = 'Enviar E-mail'
      Category = 0
      Hint = 'Enviar E-mail'
      Visible = ivAlways
      OnClick = dxBarBtnEnviarEmailClick
    end
  end
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.DefaultParamDataType = ftString
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.ID_TITULO_PAGAR as ID, '
      '       TP.ID_ORGANIZACAO, '
      '       TP.ID_CEDENTE, '
      '       TP.ID_HISTORICO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.VALOR_NOMINAL, '
      '       TP.DESCRICAO as dsc_tp, '
      '       TP.DATA_VENCIMENTO,'
      '       TP.DATA_PAGAMENTO,'
      '       C.NOME as fornecedor,'
      '       H.DESCRICAO as dsc_hst'
      '--       '#39'0'#39' as PAGAR'
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (TP.ID_HISTORICO = H.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      
        'WHERE (TP.ID_TITULO_PAGAR = :PID ) OR ( (TP.ID_ORGANIZACAO = :PI' +
        'DORGANIZACAO) '
      '   AND (TP.DATA_VENCIMENTO BETWEEN :DTI AND :DTF) '
      '   AND   (TP.ID_TIPO_STATUS <> '#39'EXCLUIDO'#39') )'
      ''
      '   ORDER BY TP.DATA_PAGAMENTO DESC ')
    Left = 319
    Top = 289
    ParamData = <
      item
        Name = 'PID'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTI'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTF'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object dsTitulos: TDataSource
    AutoEdit = False
    DataSet = qryPreencheGrid
    OnDataChange = dsTitulosDataChange
    Left = 440
    Top = 289
  end
  object qryRelPagamentos: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.ID_TITULO_PAGAR as ID, '
      '       TP.ID_ORGANIZACAO, '
      '       TP.ID_CEDENTE, '
      '       TP.ID_HISTORICO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.VALOR_NOMINAL, '
      '       TP.DESCRICAO as dsc_tp, '
      '       TP.DATA_VENCIMENTO,'
      '       TP.DATA_PAGAMENTO,'
      '       C.NOME as fornecedor,'
      '       H.DESCRICAO as dsc_hst'
      '--       '#39'0'#39' as PAGAR'
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (TP.ID_HISTORICO = H.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TP.ID_TIPO_STATUS <> '#39'EXCLUIDO'#39')'
      ''
      '       ORDER BY TP.DATA_PAGAMENTO DESC '
      '')
    Left = 576
    Top = 289
  end
  object sqlScriptContainer: TFDScript
    SQLScripts = <
      item
        Name = 'sqlRelPagamentos'
        SQL.Strings = (
          'SELECT '
          '       TP.ID_TITULO_PAGAR as ID, '
          '       TP.ID_ORGANIZACAO, '
          '       TP.ID_CEDENTE, '
          '       TP.ID_HISTORICO,'
          '       TP.NUMERO_DOCUMENTO,'
          '       TP.VALOR_NOMINAL, '
          '       TP.DESCRICAO as dsc_tp, '
          '       TP.DATA_VENCIMENTO,'
          '       TP.DATA_PAGAMENTO,'
          '       C.NOME as fornecedor,'
          '       H.DESCRICAO as dsc_hst'
          ''
          'FROM TITULO_PAGAR TP'
          
            'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
            '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
          
            'LEFT OUTER JOIN HISTORICO H ON (TP.ID_HISTORICO = H.ID_HISTORICO' +
            ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)')
      end>
    Connection = dmConexao.conn
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 704
    Top = 289
  end
  object fdmTPPrinter: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 336
    Top = 416
  end
end
