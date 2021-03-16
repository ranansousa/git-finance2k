object frmEspelhoCheques: TfrmEspelhoCheques
  Left = 0
  Top = 0
  Caption = 'Listagem de Cheques'
  ClientHeight = 734
  ClientWidth = 1145
  Color = clInfoBk
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
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 1145
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 1
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Painel de consulta'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar5'
        end
        item
          ToolbarName = 'dxBarManager1Bar4'
        end
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar6'
        end
        item
          ToolbarName = 'dxBarManager1Bar7'
        end
        item
          ToolbarName = 'dxBarManager1Bar2'
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
    Width = 1145
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.Alignment = taCenter
        Width = 50
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 50
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 300
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ExplicitWidth = 1071
  end
  object dbgrdMain: TDBGrid
    Left = 0
    Top = 135
    Width = 1145
    Height = 537
    Align = alClient
    DataSource = dtsMain
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgrdMainTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_CONTA_BANCARIA_CHEQUE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ID_ORGANIZACAO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ID_CONTA_BANCARIA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'NUMERO_CHEQUE'
        Title.Alignment = taCenter
        Title.Caption = ' CHEQUE'
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
        FieldName = 'VALOR'
        Title.Alignment = taCenter
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
        FieldName = 'PORTADOR'
        Title.Alignment = taCenter
        Title.Caption = 'FORNECEDOR/PORTADOR'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 250
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'NUMERO_DOCUMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'NUMERO DOCUMENTO'
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
        FieldName = 'ID_TIPO_STATUS'
        Title.Alignment = taCenter
        Title.Caption = ' STATUS'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DATA_REGISTRO'
        Title.Alignment = taCenter
        Title.Caption = 'GERA'#199#195'O'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DATA_EMISSAO'
        Title.Alignment = taCenter
        Title.Caption = 'EMISS'#195'O'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DATA_COMPENSACAO'
        Title.Alignment = taCenter
        Title.Caption = 'COMPENSA'#199#195'O'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DATA_ESTORNO'
        Title.Alignment = taCenter
        Title.Caption = ' ESTORNO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 672
    Width = 1145
    Height = 42
    Align = alBottom
    TabOrder = 3
    ExplicitWidth = 1071
  end
  object Panel3: TPanel
    Left = 0
    Top = 125
    Width = 1145
    Height = 10
    Align = alTop
    TabOrder = 4
    ExplicitWidth = 1071
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
    Left = 616
    Top = 584
    PixelsPerInch = 96
    object dxBarManager1Bar2: TdxBar
      Caption = 'Limpar'
      CaptionButtons = <>
      DockedLeft = 833
      DockedTop = 0
      FloatLeft = 918
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnLimpar'
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
      DockedLeft = 895
      DockedTop = 0
      FloatLeft = 918
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnSair'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'Filtros '
      CaptionButtons = <>
      DockedLeft = 215
      DockedTop = 0
      FloatLeft = 981
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarCbxContas'
        end
        item
          Visible = True
          ItemName = 'dxBarCbxStatus'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar1: TdxBar
      Caption = 'Consultar'
      CaptionButtons = <>
      DockedLeft = 394
      DockedTop = 0
      FloatLeft = 981
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnConsulta'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar5: TdxBar
      Caption = 'Per'#237'odo'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 981
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
        end
        item
          ViewLayout = ivlGlyphControlCaption
          Visible = True
          ItemName = 'chkTodos'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar6: TdxBar
      Caption = 'Pesquisa'
      CaptionButtons = <>
      DockedLeft = 470
      DockedTop = 0
      FloatLeft = 1034
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'cxBarPesquisaCheque'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar7: TdxBar
      Caption = 'Imprimir'
      CaptionButtons = <>
      DockedLeft = 655
      DockedTop = 0
      FloatLeft = 1107
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnImprimir'
        end
        item
          Visible = True
          ItemName = 'dxBarBtnEnviarEmail'
        end
        item
          Visible = True
          ItemName = 'dxBarBtnCopiaCheque'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBtnSair: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBtnSairClick
    end
    object dxBtnLimpar: TdxBarLargeButton
      Caption = 'Limpar'
      Category = 0
      Hint = 'Limpar'
      Visible = ivAlways
      OnClick = dxBtnLimparClick
    end
    object dxBtnGerar: TdxBarLargeButton
      Caption = 'Gerar'
      Category = 0
      Hint = 'Gerar'
      Visible = ivAlways
    end
    object dxBarCbxContas: TdxBarCombo
      Align = iaRight
      Caption = 'Conta'
      Category = 0
      Hint = 'Conta'
      Visible = ivAlways
      OnChange = dxBarCbxContasChange
      Width = 120
      ItemIndex = -1
    end
    object dxBarCbxCheques: TdxBarCombo
      Align = iaRight
      Caption = 'Cheques'
      Category = 0
      Hint = 'Cheques'
      Visible = ivAlways
      Width = 150
      ItemIndex = -1
    end
    object dxBarCbxStatus: TdxBarCombo
      Align = iaRight
      Caption = '   Status'
      Category = 0
      Hint = '   Status'
      Visible = ivAlways
      OnChange = dxBarCbxStatusChange
      Width = 120
      Items.Strings = (
        ' TODOS'
        ' EMITIDOS'
        ' COMPENSADOS'
        ' DESATIVADOS'
        ''
        ''
        ' ')
      ItemIndex = -1
    end
    object dxBarBtnConsulta: TdxBarLargeButton
      Caption = 'Consultar'
      Category = 0
      Hint = 'Consultar'
      Visible = ivAlways
      OnClick = dxBarBtnConsultaClick
    end
    object dxBarDataInicial: TdxBarDateCombo
      Align = iaRight
      Caption = 'Data Inicial'
      Category = 0
      Hint = 'Data Inicial'
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
    end
    object dxBarDataFinal: TdxBarDateCombo
      Align = iaRight
      Caption = 'Data Final'
      Category = 0
      Hint = 'Data Final'
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
    end
    object cxBarPesquisaCheque: TcxBarEditItem
      Caption = ' Cheque '
      Category = 0
      Hint = 'Informe o n'#250'mero do cheque '
      Visible = ivAlways
      OnCurChange = cxBarPesquisaChequeCurChange
      Width = 120
    end
    object cxBarEditItem1: TcxBarEditItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      PropertiesClassName = 'TdxSparklineProperties'
      Properties.Series = <>
      Properties.Padding.All = 3
    end
    object dxBarBtnImprimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprimir'
      Visible = ivAlways
      OnClick = dxBarBtnImprimirClick
    end
    object dxBarBtnEnviarEmail: TdxBarLargeButton
      Caption = 'Enviar E-mail'
      Category = 0
      Hint = 'Enviar E-mail'
      Visible = ivAlways
      OnClick = dxBarBtnEnviarEmailClick
    end
    object chkTodos: TcxBarEditItem
      Caption = 'Buscar todo per'#237'odo'
      Category = 0
      Hint = 
        'Buscar todo per'#237'odo. Inicial por Data Registro e Final por Data ' +
        'Emiss'#227'o'
      Visible = ivAlways
      OnCurChange = chkTodosCurChange
      ShowCaption = True
      Width = 80
      PropertiesClassName = 'TcxCheckBoxProperties'
      Properties.ImmediatePost = True
    end
    object dxBarBtnCopiaCheque: TdxBarLargeButton
      Caption = 'C'#243'pia Cheque'
      Category = 0
      Hint = 'C'#243'pia Cheque'
      Visible = ivAlways
      OnClick = dxBarBtnCopiaChequeClick
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
    Left = 504
    Top = 568
  end
  object dtsMain: TDataSource
    DataSet = qryPreencheGrid
    OnDataChange = dtsMainDataChange
    Left = 232
    Top = 416
  end
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 50000
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayTime, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayTime = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.NUMERO_DOCUMENTO,              '
      '       CBCH.VALOR AS VALOR_CHEQUE,      '
      '       CBCH.DATA_EMISSAO AS DATA_EMISSAO_CHEQUE,'
      '       CBCH.DATA_COMPENSACAO AS DATA_COMPENSA_CHEQUE,'
      '       (H.DESCRICAO || '#39' '#39' || TP.DESCRICAO) AS DESCRICAO,'
      '       C.NOME AS FORNECEDOR,'
      '       CBCH.NUMERO_CHEQUE,'
      '       CBCH.PORTADOR,'
      '       CBCH.ID_TIPO_STATUS AS STATUS_CHEQUE,'
      '       CB.CONTA AS CONTA,'
      '       CB.AGENCIA AS AGENCIA,'
      '       CB.TITULAR AS TITULAR, --//AQUI'
      '        CBCH.ID_CONTA_BANCARIA_CHEQUE,'
      '        CBCH.ID_ORGANIZACAO,'
      '        CBCH.ID_CONTA_BANCARIA,'
      '        CBCH.ID_FUNCIONARIO,'
      '        CBCH.ID_TIPO_STATUS,'
      '        CBCH.DATA_REGISTRO,'
      '        CBCH.DATA_EMISSAO,'
      '        CBCH.DATA_COMPENSACAO,'
      '        CBCH.VALOR,'
      '        CBCH.OBSERVACAO,'
      '        CBCH.DATA_PREVISAO_COMPENSACAO,'
      '        CBCH.DATA_ESTORNO,'
      '        CBCH.ID_USUARIO,'
      '        CBCH.QTD_IMPRESSAO'
      ''
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C                       ON (C.ID_CEDENTE' +
        ' = TP.ID_CEDENTE    AND  C.ID_ORGANIZACAO =  TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H                     ON (H.ID_HISTORI' +
        'CO = TP.ID_HISTORICO AND  H.ID_ORGANIZACAO =  TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB          ON (TPB.ID_TITUL' +
        'O_PAGAR = TP.ID_TITULO_PAGAR AND  TPB.ID_ORGANIZACAO =  TP.ID_OR' +
        'GANIZACAO)'
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA_CHEQUE TPBCH ON (TPBCH.ID_TIT' +
        'ULO_PAGAR_BAIXA = TPB.ID_TITULO_PAGAR_BAIXA AND  TPBCH.ID_ORGANI' +
        'ZACAO =  TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA_CHEQUE CBCH      ON (CBCH.ID_CONT' +
        'A_BANCARIA_CHEQUE = TPBCH.ID_CONTA_BANCARIA_CHEQUE AND  CBCH.ID_' +
        'ORGANIZACAO =  TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB               ON (CB.ID_CONTA_' +
        'BANCARIA = CBCH.ID_CONTA_BANCARIA AND  CB.ID_ORGANIZACAO =  TP.I' +
        'D_ORGANIZACAO)'
      ''
      '')
    Left = 136
    Top = 240
  end
  object sqlScriptContainer: TFDScript
    SQLScripts = <
      item
        Name = 'sqlCheques'
        SQL.Strings = (
          'SELECT TP.NUMERO_DOCUMENTO,              '
          '       CBCH.VALOR AS VALOR_CHEQUE,      '
          '       CBCH.DATA_EMISSAO AS DATA_EMISSAO_CHEQUE,'
          '       CBCH.DATA_COMPENSACAO AS DATA_COMPENSA_CHEQUE,'
          '       (H.DESCRICAO || '#39' '#39' || TP.DESCRICAO) AS DESCRICAO,'
          '       C.NOME AS FORNECEDOR,'
          '       CBCH.NUMERO_CHEQUE,'
          '       CBCH.PORTADOR,'
          '       CBCH.ID_TIPO_STATUS AS STATUS_CHEQUE,'
          '       CB.CONTA AS CONTA,'
          '       CB.AGENCIA AS AGENCIA,'
          '       CB.TITULAR AS TITULAR, --//AQUI'
          '        CBCH.ID_CONTA_BANCARIA_CHEQUE,'
          '        CBCH.ID_ORGANIZACAO,'
          '        CBCH.ID_CONTA_BANCARIA,'
          '        CBCH.ID_FUNCIONARIO,'
          '        CBCH.ID_TIPO_STATUS,'
          '        CBCH.DATA_REGISTRO,'
          '        CBCH.DATA_EMISSAO,'
          '        CBCH.DATA_COMPENSACAO,'
          '        CBCH.VALOR,'
          '        CBCH.OBSERVACAO,'
          '        CBCH.DATA_PREVISAO_COMPENSACAO,'
          '        CBCH.DATA_ESTORNO,'
          '        CBCH.ID_USUARIO,'
          '        CBCH.QTD_IMPRESSAO'
          ''
          ''
          'FROM TITULO_PAGAR TP'
          
            'LEFT OUTER JOIN CEDENTE C                       ON (C.ID_CEDENTE' +
            ' = TP.ID_CEDENTE    AND  C.ID_ORGANIZACAO =  TP.ID_ORGANIZACAO)'
          
            'LEFT OUTER JOIN HISTORICO H                     ON (H.ID_HISTORI' +
            'CO = TP.ID_HISTORICO AND  H.ID_ORGANIZACAO =  TP.ID_ORGANIZACAO)'
          
            'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB          ON (TPB.ID_TITUL' +
            'O_PAGAR = TP.ID_TITULO_PAGAR AND  TPB.ID_ORGANIZACAO =  TP.ID_OR' +
            'GANIZACAO)'
          
            'LEFT OUTER JOIN TITULO_PAGAR_BAIXA_CHEQUE TPBCH ON (TPBCH.ID_TIT' +
            'ULO_PAGAR_BAIXA = TPB.ID_TITULO_PAGAR_BAIXA AND  TPBCH.ID_ORGANI' +
            'ZACAO =  TP.ID_ORGANIZACAO)'
          
            'LEFT OUTER JOIN CONTA_BANCARIA_CHEQUE CBCH      ON (CBCH.ID_CONT' +
            'A_BANCARIA_CHEQUE = TPBCH.ID_CONTA_BANCARIA_CHEQUE AND  CBCH.ID_' +
            'ORGANIZACAO =  TP.ID_ORGANIZACAO)'
          
            'LEFT OUTER JOIN CONTA_BANCARIA CB               ON (CB.ID_CONTA_' +
            'BANCARIA = CBCH.ID_CONTA_BANCARIA AND  CB.ID_ORGANIZACAO =  TP.I' +
            'D_ORGANIZACAO)')
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
    Left = 360
    Top = 560
  end
  object frxRelatorio: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    EngineOptions.PrintIfEmpty = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Author = 'Pempec Enterprise Finance 2K'
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.Name = 'Relat'#243'rio Extrato Banc'#225'rio'
    ReportOptions.LastChange = 44061.814051307900000000
    ReportOptions.VersionBuild = '2'
    ReportOptions.VersionMajor = '2'
    ReportOptions.VersionMinor = '1'
    ReportOptions.VersionRelease = '1'
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 136
    Top = 312
    Datasets = <
      item
        DataSet = frxDBDEmiteCopia
        DataSetName = 'EMITE_COPIA'
      end>
    Variables = <
      item
        Name = ' Pempec'
        Value = Null
      end
      item
        Name = 'strRazaoSocial'
        Value = Null
      end
      item
        Name = 'strCNPJ'
        Value = Null
      end
      item
        Name = 'strEndereco'
        Value = Null
      end
      item
        Name = 'strCEP'
        Value = Null
      end
      item
        Name = 'strCidade'
        Value = Null
      end
      item
        Name = 'strUF'
        Value = Null
      end
      item
        Name = 'strTipoStatus'
        Value = Null
      end
      item
        Name = 'strTipo'
        Value = Null
      end
      item
        Name = 'cc_perc'
        Value = Null
      end
      item
        Name = 'strPeriodo'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 132.283550000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Top = 5.338590000000000000
          Width = 109.606370000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Organiza'#231#227'o: ')
          ParentFont = False
        end
        object strRazaoSocial1: TfrxMemoView
          AllowVectorExport = True
          Left = 110.283550000000000000
          Top = 5.338590000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strRazaoSocial]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 487.236550000000000000
          Top = 5.338590000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
        object strCNPJ: TfrxMemoView
          AllowVectorExport = True
          Left = 549.047620000000000000
          Top = 5.338590000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCNPJ]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Top = 30.015770000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object strEndereco: TfrxMemoView
          AllowVectorExport = True
          Left = 110.283550000000000000
          Top = 30.015770000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strEndereco]')
          ParentFont = False
          WordWrap = False
        end
        object strCEP: TfrxMemoView
          AllowVectorExport = True
          Left = 396.764070000000000000
          Top = 30.015770000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCEP]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 340.220470000000000000
          Top = 30.015770000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CEP  :')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 487.236550000000000000
          Top = 30.015770000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CIDADE/UF:')
          ParentFont = False
        end
        object strCidade: TfrxMemoView
          AllowVectorExport = True
          Left = 586.842920000000000000
          Top = 30.015770000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCidade]/[strUF]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo8: TfrxMemoView
          Align = baWidth
          AllowVectorExport = True
          Top = 92.047310000000000000
          Width = 718.110700000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              'C'#211'PIA DE CHEQUE   [<EMITE_COPIA."NUMERO_CHEQUE"> +'#39'  CONTA  '#39' + ' +
              '<EMITE_COPIA."CONTA_BANCARIA">  ]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line4: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 87.929190000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 124.724490000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Memo41: TfrxMemoView
        AllowVectorExport = True
        Left = 7.559060000000000000
        Top = -7.559060000000000000
        Width = 49.133890000000000000
        Height = 15.118120000000000000
        DataSet = frmCTPHistorico.frxDBTitulosPorCedente
        DataSetName = 'Titulos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
        ParentFont = False
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 510.236550000000000000
        Width = 718.110700000000000000
        object Memo36: TfrxMemoView
          AllowVectorExport = True
          Left = -1.220470000000000000
          Top = 2.000000000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Pempec Enterprise Finance')
          ParentFont = False
          VAlign = vaBottom
        end
        object Date: TfrxMemoView
          AllowVectorExport = True
          Left = 648.441250000000000000
          Top = 2.000000000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo79: TfrxMemoView
          AllowVectorExport = True
          Left = 575.086890000000000000
          Top = 2.000000000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Emitido em:  ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Time: TfrxMemoView
          AllowVectorExport = True
          Left = 706.488560000000000000
          Top = 2.000000000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 3.779547090000000000
        Top = 211.653680000000000000
        Width = 718.110700000000000000
        Condition = '1=1'
      end
      object CHEQUES: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 166.299310240000000000
        Top = 238.110390000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDEmiteCopia
        DataSetName = 'EMITE_COPIA'
        RowCount = 0
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 55.031540000000000000
          Top = 5.559060000000000000
          Width = 359.055350000000000000
          Height = 15.118110240000000000
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            
              '[<EMITE_COPIA."AGENCIA"> + '#39' '#39' + <EMITE_COPIA."CONTA_BANCARIA"> ' +
              '+ '#39' '#39' + <EMITE_COPIA."TITULAR">]')
          ParentFont = False
          WordWrap = False
        end
        object CHEQUESVALOR: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 623.622450000000000000
          Top = 5.559059999999990000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          DataField = 'VALOR_CHEQUE'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clWindow
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[EMITE_COPIA."VALOR_CHEQUE"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          AllowVectorExport = True
          Left = 192.535560000000000000
          Top = 119.165430000000000000
          Width = 272.126160000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RESPONS'#193'VEL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          AllowVectorExport = True
          Top = 24.236240000000000000
          Width = 75.590600000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'PORTADOR :')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          AllowVectorExport = True
          Left = 229.551330000000000000
          Top = 45.913420000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'DESCRI'#199#195'O :')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          AllowVectorExport = True
          Left = 416.527830000000000000
          Top = 24.236240000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DATA EMISS'#195'O:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          AllowVectorExport = True
          Left = 571.827150000000000000
          Top = 5.559059999999990000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'VALOR:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Top = 5.559059999999990000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CONTA:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 2.000000000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Style = fsDouble
          Frame.Typ = [ftTop]
        end
        object Memo21: TfrxMemoView
          AllowVectorExport = True
          Left = 514.575140000000000000
          Top = 24.236240000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataField = 'DATA_EMISSAO_CHEQUE'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          HAlign = haRight
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            '[EMITE_COPIA."DATA_EMISSAO_CHEQUE"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          AllowVectorExport = True
          Left = 416.527830000000000000
          Top = 5.559059999999990000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CHEQUE:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          AllowVectorExport = True
          Left = 475.559370000000000000
          Top = 5.559059999999990000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          DataField = 'NUMERO_CHEQUE'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          HAlign = haRight
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            '[EMITE_COPIA."NUMERO_CHEQUE"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          AllowVectorExport = True
          Left = 572.827150000000000000
          Top = 24.236240000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DATA COMP.:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          AllowVectorExport = True
          Left = 657.638256610000000000
          Top = 24.236240000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataField = 'DATA_COMPENSA_CHEQUE'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          HAlign = haRight
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            '[EMITE_COPIA."DATA_COMPENSA_CHEQUE"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          AllowVectorExport = True
          Left = 79.149660000000000000
          Top = 24.236240000000000000
          Width = 336.378170000000000000
          Height = 15.118110240000000000
          DataField = 'PORTADOR'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            '[EMITE_COPIA."PORTADOR"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          AllowVectorExport = True
          Top = 45.913420000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DOCUMENTO:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          AllowVectorExport = True
          Left = 86.708720000000000000
          Top = 45.913420000000000000
          Width = 139.842610000000000000
          Height = 15.118110240000000000
          DataField = 'NUMERO_DOCUMENTO'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          HAlign = haCenter
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            '[EMITE_COPIA."NUMERO_DOCUMENTO"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          AllowVectorExport = True
          Left = 314.700990000000000000
          Top = 45.913420000000000000
          Width = 400.630180000000000000
          Height = 15.118110240000000000
          DataField = 'DESCRICAO'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            '[EMITE_COPIA."DESCRICAO"]')
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 70.811070000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Style = fsDouble
          Frame.Typ = [ftTop]
        end
        object Memo34: TfrxMemoView
          AllowVectorExport = True
          Top = 78.149660000000000000
          Width = 113.385900000000000000
          Height = 15.118110240000000000
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            'EMISS'#195'O : [EMITE_COPIA."DATA_EMISSAO_CHEQUE"]')
          ParentFont = False
        end
        object Line6: TfrxLineView
          AllowVectorExport = True
          Left = 154.960730000000000000
          Top = 118.944960000000000000
          Width = 355.275820000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Date1: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 600.945270000000000000
          Top = 78.149660000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'IMPRESSO EM:  : [Date]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          AllowVectorExport = True
          Left = 151.181200000000000000
          Top = 79.370130000000000000
          Width = 139.842610000000000000
          Height = 15.118110240000000000
          DataField = 'STATUS_CHEQUE'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          HAlign = haCenter
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            '[EMITE_COPIA."STATUS_CHEQUE"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 427.086890000000000000
        Width = 718.110700000000000000
        object Line3: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDBDCheques: TfrxDBDataset
    UserName = 'CHEQUES'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'VALOR_CHEQUE=VALOR_CHEQUE'
      'DATA_EMISSAO_CHEQUE=DATA_EMISSAO_CHEQUE'
      'DATA_COMPENSA_CHEQUE=DATA_COMPENSA_CHEQUE'
      'DESCRICAO=DESCRICAO'
      'FORNECEDOR=FORNECEDOR'
      'NUMERO_CHEQUE=NUMERO_CHEQUE'
      'PORTADOR=PORTADOR'
      'STATUS_CHEQUE=STATUS_CHEQUE'
      'CONTA=CONTA'
      'AGENCIA=AGENCIA'
      'TITULAR=TITULAR'
      'ID_CONTA_BANCARIA_CHEQUE=ID_CONTA_BANCARIA_CHEQUE'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'ID_FUNCIONARIO=ID_FUNCIONARIO'
      'ID_TIPO_STATUS=ID_TIPO_STATUS'
      'DATA_REGISTRO=DATA_REGISTRO'
      'DATA_EMISSAO=DATA_EMISSAO'
      'DATA_COMPENSACAO=DATA_COMPENSACAO'
      'VALOR=VALOR'
      'OBSERVACAO=OBSERVACAO'
      'DATA_PREVISAO_COMPENSACAO=DATA_PREVISAO_COMPENSACAO'
      'DATA_ESTORNO=DATA_ESTORNO'
      'ID_USUARIO=ID_USUARIO'
      'QTD_IMPRESSAO=QTD_IMPRESSAO')
    DataSet = fdmCheques
    BCDToCurrency = False
    Left = 252
    Top = 312
  end
  object fdmCheques: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 128
    Top = 416
  end
  object qryCopiaChequeTP: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 50000
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayTime, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayTime = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.NUMERO_DOCUMENTO,              '
      '       CBCH.VALOR AS VALOR_CHEQUE,      '
      '       CBCH.DATA_EMISSAO AS DATA_EMISSAO_CHEQUE,'
      '       CBCH.DATA_COMPENSACAO AS DATA_COMPENSA_CHEQUE,'
      '       (H.DESCRICAO || '#39' '#39' || TP.DESCRICAO) AS DESCRICAO,'
      '       C.NOME AS FORNECEDOR,'
      '       CBCH.NUMERO_CHEQUE,'
      '       CBCH.PORTADOR,'
      '       CBCH.ID_TIPO_STATUS AS STATUS_CHEQUE,'
      '       CB.CONTA AS CONTA_BANCARIA,'
      '       CB.AGENCIA AS AGENCIA,'
      '       CB.TITULAR AS TITULAR'
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C                       ON (C.ID_CEDENTE' +
        ' = TP.ID_CEDENTE    AND  C.ID_ORGANIZACAO =  TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H                     ON (H.ID_HISTORI' +
        'CO = TP.ID_HISTORICO AND  H.ID_ORGANIZACAO =  TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB          ON (TPB.ID_TITUL' +
        'O_PAGAR = TP.ID_TITULO_PAGAR AND  TPB.ID_ORGANIZACAO =  TP.ID_OR' +
        'GANIZACAO)'
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA_CHEQUE TPBCH ON (TPBCH.ID_TIT' +
        'ULO_PAGAR_BAIXA = TPB.ID_TITULO_PAGAR_BAIXA AND  TPBCH.ID_ORGANI' +
        'ZACAO =  TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA_CHEQUE CBCH      ON (CBCH.ID_CONT' +
        'A_BANCARIA_CHEQUE = TPBCH.ID_CONTA_BANCARIA_CHEQUE AND  CBCH.ID_' +
        'ORGANIZACAO =  TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB               ON (CB.ID_CONTA_' +
        'BANCARIA = CBCH.ID_CONTA_BANCARIA AND  CB.ID_ORGANIZACAO =  TP.I' +
        'D_ORGANIZACAO)'
      ''
      'WHERE  (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)   '
      '   AND (CBCH.ID_CONTA_BANCARIA_CHEQUE = :PID)')
    Left = 664
    Top = 209
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
  object qryCopiaChequeCBT: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 50000
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayTime, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayTime = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT CBD.identificacao as NUMERO_DOCUMENTO,       '
      '       CBCH.VALOR AS VALOR_CHEQUE,       '
      '       CBCH.DATA_EMISSAO AS DATA_EMISSAO_CHEQUE,'
      '       CBCH.DATA_COMPENSACAO AS DATA_COMPENSA_CHEQUE,'
      '       UPPER('#39#39' || '#39' '#39' || CBD.descricao) AS DESCRICAO,'
      '       CB.TITULAR AS FORNECEDOR,'
      '       CBCH.NUMERO_CHEQUE,'
      '       CBCH.PORTADOR,'
      '       CBCH.ID_TIPO_STATUS AS STATUS_CHEQUE,'
      '       CB.CONTA AS CONTA_BANCARIA,'
      '       CB.AGENCIA AS AGENCIA,'
      '       CB.TITULAR AS TITULAR'
      ''
      'FROM CONTA_BANCARIA_DEBITO CBD'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB      ON (TOB.id_tipo_' +
        'operacao_bancaria = CBD.id_tipo_operacao_bancaria AND  TOB.ID_OR' +
        'GANIZACAO =  CBD.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA_CHEQUE CBCH      ON (CBCH.ID_CONT' +
        'A_BANCARIA_CHEQUE = CBD.ID_CONTA_BANCARIA_CHEQUE AND  CBCH.ID_OR' +
        'GANIZACAO =  CBD.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB               ON (CB.ID_CONTA_' +
        'BANCARIA = CBCH.ID_CONTA_BANCARIA AND  CB.ID_ORGANIZACAO =  CBD.' +
        'ID_ORGANIZACAO)'
      ''
      'WHERE  (CBD.ID_ORGANIZACAO = :PIDORGANIZACAO)   '
      '   AND (CBCH.ID_CONTA_BANCARIA_CHEQUE = :PID)'
      '')
    Left = 832
    Top = 201
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
  object fdmEmiteCopia: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 688
    Top = 296
  end
  object frxDBDEmiteCopia: TfrxDBDataset
    UserName = 'EMITE_COPIA'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'VALOR_CHEQUE=VALOR_CHEQUE'
      'DATA_EMISSAO_CHEQUE=DATA_EMISSAO_CHEQUE'
      'DATA_COMPENSA_CHEQUE=DATA_COMPENSA_CHEQUE'
      'DESCRICAO=DESCRICAO'
      'FORNECEDOR=FORNECEDOR'
      'NUMERO_CHEQUE=NUMERO_CHEQUE'
      'PORTADOR=PORTADOR'
      'STATUS_CHEQUE=STATUS_CHEQUE'
      'CONTA_BANCARIA=CONTA_BANCARIA'
      'AGENCIA=AGENCIA'
      'TITULAR=TITULAR')
    DataSet = fdmEmiteCopia
    BCDToCurrency = False
    Left = 844
    Top = 288
  end
  object frxCopiaCheque: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    EngineOptions.PrintIfEmpty = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Author = 'Pempec Enterprise Finance 2K'
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.Name = 'Relat'#243'rio Extrato Banc'#225'rio'
    ReportOptions.LastChange = 44061.814051307870000000
    ReportOptions.VersionBuild = '2'
    ReportOptions.VersionMajor = '2'
    ReportOptions.VersionMinor = '1'
    ReportOptions.VersionRelease = '1'
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 832
    Top = 384
    Datasets = <
      item
        DataSet = frxDBDEmiteCopia
        DataSetName = 'EMITE_COPIA'
      end>
    Variables = <
      item
        Name = ' Pempec'
        Value = Null
      end
      item
        Name = 'strRazaoSocial'
        Value = Null
      end
      item
        Name = 'strCNPJ'
        Value = Null
      end
      item
        Name = 'strEndereco'
        Value = Null
      end
      item
        Name = 'strCEP'
        Value = Null
      end
      item
        Name = 'strCidade'
        Value = Null
      end
      item
        Name = 'strUF'
        Value = Null
      end
      item
        Name = 'strTipoStatus'
        Value = Null
      end
      item
        Name = 'strTipo'
        Value = Null
      end
      item
        Name = 'cc_perc'
        Value = Null
      end
      item
        Name = 'strPeriodo'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 132.283550000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Top = 5.338590000000000000
          Width = 109.606370000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Organiza'#231#227'o: ')
          ParentFont = False
        end
        object strRazaoSocial1: TfrxMemoView
          AllowVectorExport = True
          Left = 110.283550000000000000
          Top = 5.338590000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strRazaoSocial]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 487.236550000000000000
          Top = 5.338590000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
        object strCNPJ: TfrxMemoView
          AllowVectorExport = True
          Left = 549.047620000000100000
          Top = 5.338590000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCNPJ]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Top = 30.015770000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object strEndereco: TfrxMemoView
          AllowVectorExport = True
          Left = 110.283550000000000000
          Top = 30.015770000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strEndereco]')
          ParentFont = False
          WordWrap = False
        end
        object strCEP: TfrxMemoView
          AllowVectorExport = True
          Left = 396.764070000000000000
          Top = 30.015770000000000000
          Width = 86.929190000000010000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCEP]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 340.220470000000000000
          Top = 30.015770000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CEP  :')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 487.236550000000000000
          Top = 30.015770000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CIDADE/UF:')
          ParentFont = False
        end
        object strCidade: TfrxMemoView
          AllowVectorExport = True
          Left = 586.842920000000000000
          Top = 30.015770000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCidade]/[strUF]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo8: TfrxMemoView
          Align = baWidth
          AllowVectorExport = True
          Top = 92.047310000000000000
          Width = 718.110700000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              'C'#211'PIA DE CHEQUE   [<EMITE_COPIA."NUMERO_CHEQUE"> +'#39'  CONTA  '#39' + ' +
              '<EMITE_COPIA."CONTA_BANCARIA">  ]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line4: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 87.929190000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 124.724490000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Memo41: TfrxMemoView
        AllowVectorExport = True
        Left = 7.559060000000000000
        Top = -7.559060000000000000
        Width = 49.133890000000000000
        Height = 15.118120000000000000
        DataSet = frmCTPHistorico.frxDBTitulosPorCedente
        DataSetName = 'Titulos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
        ParentFont = False
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 510.236550000000000000
        Width = 718.110700000000000000
        object Memo36: TfrxMemoView
          AllowVectorExport = True
          Left = -1.220470000000000000
          Top = 2.000000000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Pempec Enterprise Finance')
          ParentFont = False
          VAlign = vaBottom
        end
        object Date: TfrxMemoView
          AllowVectorExport = True
          Left = 648.441250000000000000
          Top = 2.000000000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo79: TfrxMemoView
          AllowVectorExport = True
          Left = 575.086890000000000000
          Top = 2.000000000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Emitido em:  ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Time: TfrxMemoView
          AllowVectorExport = True
          Left = 706.488560000000000000
          Top = 2.000000000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 3.779547090000000000
        Top = 211.653680000000000000
        Width = 718.110700000000000000
        Condition = '1=1'
      end
      object CHEQUES: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 166.299310240000000000
        Top = 238.110390000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDEmiteCopia
        DataSetName = 'EMITE_COPIA'
        RowCount = 0
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 55.031540000000000000
          Top = 5.559059999999990000
          Width = 359.055350000000000000
          Height = 15.118110240000000000
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            
              '[<EMITE_COPIA."AGENCIA"> + '#39' '#39' + <EMITE_COPIA."CONTA_BANCARIA"> ' +
              '+ '#39' '#39' + <EMITE_COPIA."TITULAR">]')
          ParentFont = False
          WordWrap = False
        end
        object CHEQUESVALOR: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 623.622450000000000000
          Top = 5.559059999999988000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          DataField = 'VALOR_CHEQUE'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clWindow
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[EMITE_COPIA."VALOR_CHEQUE"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          AllowVectorExport = True
          Left = 192.535560000000000000
          Top = 119.165430000000000000
          Width = 272.126160000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RESPONS'#193'VEL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          AllowVectorExport = True
          Top = 24.236240000000010000
          Width = 75.590599999999990000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'PORTADOR :')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          AllowVectorExport = True
          Left = 229.551330000000000000
          Top = 45.913420000000030000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'DESCRI'#199#195'O :')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          AllowVectorExport = True
          Left = 416.527830000000000000
          Top = 24.236240000000010000
          Width = 94.488249999999990000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DATA EMISS'#195'O:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          AllowVectorExport = True
          Left = 571.827150000000000000
          Top = 5.559059999999988000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'VALOR:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Top = 5.559059999999990000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CONTA:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 2.000000000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Style = fsDouble
          Frame.Typ = [ftTop]
        end
        object Memo21: TfrxMemoView
          AllowVectorExport = True
          Left = 514.575140000000000000
          Top = 24.236240000000010000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataField = 'DATA_EMISSAO_CHEQUE'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          HAlign = haRight
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            '[EMITE_COPIA."DATA_EMISSAO_CHEQUE"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          AllowVectorExport = True
          Left = 416.527830000000000000
          Top = 5.559059999999988000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CHEQUE:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          AllowVectorExport = True
          Left = 475.559370000000000000
          Top = 5.559059999999990000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          DataField = 'NUMERO_CHEQUE'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          HAlign = haRight
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            '[EMITE_COPIA."NUMERO_CHEQUE"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          AllowVectorExport = True
          Left = 572.827150000000000000
          Top = 24.236240000000010000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DATA COMP.:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          AllowVectorExport = True
          Left = 657.638256610000000000
          Top = 24.236240000000010000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataField = 'DATA_COMPENSA_CHEQUE'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          HAlign = haRight
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            '[EMITE_COPIA."DATA_COMPENSA_CHEQUE"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          AllowVectorExport = True
          Left = 79.149660000000000000
          Top = 24.236240000000010000
          Width = 336.378170000000000000
          Height = 15.118110240000000000
          DataField = 'PORTADOR'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            '[EMITE_COPIA."PORTADOR"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          AllowVectorExport = True
          Top = 45.913420000000030000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DOCUMENTO:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          AllowVectorExport = True
          Left = 86.708720000000000000
          Top = 45.913420000000030000
          Width = 139.842610000000000000
          Height = 15.118110240000000000
          DataField = 'NUMERO_DOCUMENTO'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          HAlign = haCenter
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            '[EMITE_COPIA."NUMERO_DOCUMENTO"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          AllowVectorExport = True
          Left = 314.700990000000000000
          Top = 45.913420000000030000
          Width = 400.630180000000000000
          Height = 15.118110240000000000
          DataField = 'DESCRICAO'
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            '[EMITE_COPIA."DESCRICAO"]')
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 70.811070000000030000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Style = fsDouble
          Frame.Typ = [ftTop]
        end
        object Memo34: TfrxMemoView
          AllowVectorExport = True
          Top = 78.149659999999980000
          Width = 113.385900000000000000
          Height = 15.118110240000000000
          DataSet = frxDBDEmiteCopia
          DataSetName = 'EMITE_COPIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            'EMISS'#195'O : [EMITE_COPIA."DATA_EMISSAO_CHEQUE"]')
          ParentFont = False
        end
        object Line6: TfrxLineView
          AllowVectorExport = True
          Left = 154.960730000000000000
          Top = 118.944960000000000000
          Width = 355.275820000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Date1: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 600.945270000000100000
          Top = 78.149659999999980000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'IMPRESSO EM:  : [Date]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 427.086890000000000000
        Width = 718.110700000000000000
        object Line3: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object FDScript1verRANAN: TFDScript
    SQLScripts = <
      item
        Name = 'sqlCheques'
        SQL.Strings = (
          'SELECT  CBC.id_conta_bancaria_cheque,'
          '        cbc.id_organizacao,'
          '        cbc.id_conta_bancaria,'
          '        cbc.id_funcionario,'
          '        cbc.id_tipo_status,'
          '        cbc.numero_cheque,'
          '        cbc.data_registro,'
          '        cbc.data_emissao,'
          '        cbc.data_compensacao,'
          '        cbc.valor,'
          '        cbc.observacao,'
          '        cbc.portador,'
          '        cbc.data_previsao_compensacao,'
          '        cbc.data_estorno,'
          '        cbc.id_usuario,'
          '        cbc.qtd_impressao,'
          '        CB.CONTA,'
          '        CB.titular'
          ''
          'FROM  CONTA_BANCARIA_CHEQUE CBC'
          
            'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CBC' +
            '.ID_CONTA_BANCARIA) AND (CBC.ID_ORGANIZACAO = CB.ID_ORGANIZACAO)'
          '')
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
    Left = 864
    Top = 560
  end
  object QRYgRID2: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 50000
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayTime, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayTime = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT  CBC.id_conta_bancaria_cheque,'
      '        cbc.id_organizacao,'
      '        cbc.id_conta_bancaria,'
      '        cbc.id_funcionario,'
      '        cbc.id_tipo_status,'
      '        cbc.numero_cheque,'
      '        cbc.data_registro,'
      '        cbc.data_emissao,'
      '        cbc.data_compensacao,'
      '        cbc.valor,'
      '        cbc.observacao,'
      '        cbc.portador,'
      '        cbc.data_previsao_compensacao,'
      '        cbc.data_estorno,'
      '        cbc.id_usuario,'
      '        cbc.qtd_impressao,'
      '        CB.CONTA,'
      '        CB.titular'
      ''
      'FROM  CONTA_BANCARIA_CHEQUE CBC'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CBC' +
        '.ID_CONTA_BANCARIA) AND (CBC.ID_ORGANIZACAO = CB.ID_ORGANIZACAO)')
    Left = 240
    Top = 192
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'CHEQUES'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CONTA_BANCARIA_CHEQUE=ID_CONTA_BANCARIA_CHEQUE'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'ID_FUNCIONARIO=ID_FUNCIONARIO'
      'ID_TIPO_STATUS=ID_TIPO_STATUS'
      'NUMERO_CHEQUE=NUMERO_CHEQUE'
      'DATA_REGISTRO=DATA_REGISTRO'
      'DATA_EMISSAO=DATA_EMISSAO'
      'DATA_COMPENSACAO=DATA_COMPENSACAO'
      'VALOR=VALOR'
      'OBSERVACAO=OBSERVACAO'
      'PORTADOR=PORTADOR'
      'DATA_PREVISAO_COMPENSACAO=DATA_PREVISAO_COMPENSACAO'
      'DATA_ESTORNO=DATA_ESTORNO'
      'ID_USUARIO=ID_USUARIO'
      'QTD_IMPRESSAO=QTD_IMPRESSAO'
      'CONTA=CONTA'
      'TITULAR=TITULAR')
    DataSet = fdmCheques
    BCDToCurrency = False
    Left = 300
    Top = 192
  end
end
