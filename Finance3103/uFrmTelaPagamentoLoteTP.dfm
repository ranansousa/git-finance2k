object frmPagamentoLoteTitulos: TfrmPagamentoLoteTitulos
  Left = 0
  Top = 0
  Caption = 'Baixa de t'#237'tulos em lote'
  ClientHeight = 575
  ClientWidth = 894
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
    Width = 894
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
    Top = 555
    Width = 894
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
  object dbgrdMain: TDBGrid
    Left = 0
    Top = 125
    Width = 894
    Height = 430
    Align = alClient
    DataSource = dsTitulos
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
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
        Expanded = False
        FieldName = 'DATA_VENCIMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'VENCIMENTO'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'NUMERO_DOCUMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'DOCUMENTO'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FORNECEDOR'
        Title.Alignment = taCenter
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_NOMINAL'
        Title.Alignment = taCenter
        Title.Caption = 'VALOR'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DSC_HST'
        Title.Alignment = taCenter
        Title.Caption = 'HIST'#211'RICO'
        Width = 170
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DSC_TP'
        Title.Alignment = taCenter
        Title.Caption = 'DESCRI'#199#195'O'
        Width = 150
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
      DockedLeft = 181
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
      DockedLeft = 493
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
      DockedLeft = 277
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
      Caption = 'Documento'
      Category = 0
      Hint = 'Documento'
      Visible = ivAlways
      OnCurChange = cxbrdtmPesquisaCurChange
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
      Width = 110
      PropertiesClassName = 'TcxDateEditProperties'
    end
    object dtFinal: TcxBarEditItem
      Align = iaRight
      Caption = 'Final'
      Category = 0
      Hint = 'Final'
      Visible = ivAlways
      OnChange = dtFinalChange
      Width = 110
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
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.VALOR_NOMINAL, '
      '       TP.DESCRICAO as dsc_tp, '
      '       TP.DATA_VENCIMENTO,'
      '       C.NOME as fornecedor,'
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
      '       AND   (TP.DATA_VENCIMENTO <= current_date )'
      '       ORDER BY DATA_VENCIMENTO DESC')
    Left = 223
    Top = 240
    ParamData = <
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
    Left = 440
    Top = 240
  end
end