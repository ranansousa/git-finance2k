object frmPagamentoLoteTitulos: TfrmPagamentoLoteTitulos
  Left = 0
  Top = 0
  Caption = 'Baixa de t'#237'tulos em lote'
  ClientHeight = 604
  ClientWidth = 1079
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
    Width = 1079
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 0
    TabStop = False
    object menuBaixaTP: TdxRibbonTab
      Active = True
      Caption = 'Baixa de t'#237'tulos a pagar em lote'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar2'
        end
        item
          ToolbarName = 'dxBarManager1Bar4'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end>
      Index = 0
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 584
    Width = 1079
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 400
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.Font.Charset = DEFAULT_CHARSET
        PanelStyle.Font.Color = clWindowText
        PanelStyle.Font.Height = -11
        PanelStyle.Font.Name = 'Tahoma'
        PanelStyle.Font.Style = [fsBold]
        PanelStyle.ParentFont = False
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 150
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object dbgrdMain: TDBGrid
    Left = 0
    Top = 125
    Width = 1079
    Height = 459
    Align = alClient
    DataSource = dsTitulos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgrdMainDblClick
    OnTitleClick = dbgrdMainTitleClick
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATA_VENCIMENTO'
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
        FieldName = 'NUMERO_DOCUMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'DOCUMENTO'
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
        FieldName = 'FORNECEDOR'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 220
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALOR_NOMINAL'
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
        Expanded = False
        FieldName = 'DSC_HST'
        Title.Alignment = taCenter
        Title.Caption = 'HIST'#211'RICO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 210
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DSC_TP'
        Title.Alignment = taCenter
        Title.Caption = 'DESCRI'#199#195'O'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 230
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'REGISTRO_LOTE_DELETADO'
        Title.Alignment = taCenter
        Title.Caption = 'LOTE'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 60
        Visible = True
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
    Left = 824
    Top = 64
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Pesquisar'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 928
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
    object dxBarManager1Bar2: TdxBar
      Caption = 'Lote pagamento'
      CaptionButtons = <>
      DockedLeft = 201
      DockedTop = 0
      FloatLeft = 928
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnPagar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Sair'
      CaptionButtons = <>
      DockedLeft = 523
      DockedTop = 0
      FloatLeft = 928
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
      DockedLeft = 297
      DockedTop = 0
      FloatLeft = 930
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dtInicial'
        end
        item
          Visible = True
          ItemName = 'dtFinal'
        end
        item
          Position = ipBeginsNewColumn
          Visible = True
          ItemName = 'dxBtnConsulta'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
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
    object dxBtnFechar: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBtnFecharClick
    end
    object dxBtnPagar: TdxBarLargeButton
      Caption = 'Gerar'
      Category = 0
      Hint = 'Baixa de t'#237'tulos'
      Visible = ivAlways
      OnClick = dxBtnPagarClick
    end
    object dxBtnPagarAV: TdxBarLargeButton
      Caption = 'Baixa Avan'#231'ada'
      Category = 0
      Hint = 'Baixa de t'#237'tulos avan'#231'ada'
      Visible = ivAlways
      OnClick = dxBtnPagarAVClick
    end
    object dtInicial: TcxBarEditItem
      Align = iaRight
      Caption = 'Inicio'
      Category = 0
      Hint = 'Inicio'
      Visible = ivAlways
      OnChange = dtInicialChange
      Width = 120
      PropertiesClassName = 'TcxDateEditProperties'
    end
    object dtFinal: TcxBarEditItem
      Align = iaRight
      Caption = 'Final'
      Category = 0
      Hint = 'Final'
      Visible = ivAlways
      OnChange = dtFinalChange
      Width = 120
      PropertiesClassName = 'TcxDateEditProperties'
    end
    object cxBarEditItem1: TcxBarEditItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      PropertiesClassName = 'TcxButtonEditProperties'
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
    end
    object dxBtnConsulta: TdxBarButton
      Caption = 'Consultar'
      Category = 0
      Hint = 'Processar nova consulta'
      Visible = ivAlways
      ShortCut = 16464
      OnClick = dxBtnConsultaClick
    end
    object dxBarEdit1: TdxBarEdit
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
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
  end
  object dsTitulos: TDataSource
    DataSet = qryPreencheGrid
    OnDataChange = dsTitulosDataChange
    Left = 320
    Top = 240
  end
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
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
      '       TP.NUMERO_DOCUMENTO,       '
      '       TP.VALOR_NOMINAL, '
      '       TP.DESCRICAO as dsc_tp, '
      '       TP.DATA_VENCIMENTO,'
      '       C.NOME as fornecedor,'
      '       TP.REGISTRO_LOTE_DELETADO,'
      '       H.DESCRICAO as dsc_hst'
      '--       '#39'0'#39' as PAGAR'
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (TP.ID_HISTORICO = H.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      '       AND   (TP.ID_TIPO_STATUS = '#39'ABERTO'#39')'
      
        '       AND   (TP.DATA_VENCIMENTO between :DTDINICIAL and :DTFINA' +
        'L )'
      '       ORDER BY DATA_VENCIMENTO asc')
    Left = 223
    Top = 240
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTFINAL'
        DataType = ftDate
        ParamType = ptInput
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
    Left = 736
    Top = 64
  end
  object fdmLoteTP: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 312
    Top = 312
  end
end
