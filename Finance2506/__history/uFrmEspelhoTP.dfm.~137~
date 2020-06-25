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
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F400000010744558745469746C65005072696E743B5064663BA5B5DD12000006
        7549444154785EC5977F8C1D5515C73FF7BD795DB6DB2E50E96AA5DD26B6585B
        A5A635155310D76D4A34082D54C426F8234663F811FED12018A3B1464A308068
        89D148D244131151346202493521B6DDC61481C006B740B7A50D88B8DDDDB6BB
        EFCDDC7BCFB17B72F366F2B26DB37F7993937BE6CEBCF3FD9EEF396766D7A92A
        FFCF9531CB72CED1B13A0FD83B78F51E551DD4288808511495485445A3104510
        BBD7E9EBDF3EFFEAA14DE72450054E56EB24A22283EFFBE87A03D5109110501F
        88E67BA4722631B6AF870F8D0E029C9F4002DEFDE4737B6AAE36A06842860FAF
        5EC2E4D7B6A131B078E7C3A838FEFBC8034CFF63884B773F8E0AFCE7C19D4C0D
        ED65D9637F46514494D1EB369B0AE727505A4D8581EDD7AF4569E393D51CCF8A
        A0311AF8B1AFDCCCA58F3EC6E9A16D88C0D19BAF67D96FFEC8A9BDCFA2AA8C6E
        B9C69E9528C428CC49011F225121845852C8EA58301F51D4C0DFF9F1FD98E428
        561630D915A5FFC96718BD7610154144E7A480F33EA2A991508762F8762D3EA0
        0A6FDC72A3D55983802A06AC6A2445E17002B786953837024508882A312AA058
        60AD25C0D0069424B10AF43FF117DEBE7707A46BB5DD0C997309F260B2455150
        1209BB2686C091ED5B310222360D87B77E2AD5DB94E3F0A70712B826EB288173
        EEDC0AF84054AC795045C1085DB4E10A86F7EDC58045EC7E4C4022922CF92A68
        54448DFCD386790E055C558122F7964D8862070216E8F2077F025A66A3D5ACEA
        35F61F7C9D6BAE5EFD6E60120880CCF228D9EC2F1DDB1B4057CB7BCB2C950045
        99986CD9AE38142A441455C705F3329EDAF332403750248BC904D06464D56C7F
        F0D0E3CBFAFA96FE887A7DE38B2FEC7B6F57A341280231924A00EA0C30F92529
        70A81A2523ECBDE7CE7B1E3AD2D53D9FB78EBFF996C4706078F8E03D2F1E7866
        1408550209FC89354B972DFFFBEA957D177EF0B2F7B07FFF5F5973E5465E79E9
        685B01031270A90C4002064804818628BE887CE0231B98BFA0976FDDD6BFE4C0
        3F476E78747773D3C707AEDBBCEBBE3B9E27A99014A0D6D37BC98E15FD8B2E5C
        72C9427ABA1B14794EF081C3AF1CE0ABB70E81BA76C6D5A52AA8568B5B3EB376
        FD0AA64E9E62D1A25E2E5F731937DD786DEF6BC79ADF036E4AE5D0B6025174B0
        77C10584F4F298181F67E2C4181F1BF8643BD34EF412D581ABB070D81A1F1BA3
        953711C5E2AE5AB5929163C39F00EAA9D7A4AD4008B1578120362E38154647FE
        459665D4EA1959A36135AED56B34CEF8CED5E85C224A08051A056ACE549C3A3D
        81E83682A8C50921F61881B4B272DE23C1477C16ADE1D6AE59C9732FBC4AD698
        57495CC139AC12988B6A55A0745F6D42C88B26EB3EB4C2E2F914BF2802A54665
        13BA19F0DC47EA59C007E196ED5B39F8FC4E9AD3C154B08C7155DDABC89D4AE0
        7D4E8DC097BFF8598B57F860F1BD8F94A35E51C08740E1235956A30891BEBEC5
        FC62D7F7D9F5B35FF3D2CB238C9D9800012C6BA59C4649F8E91AE55D8B2E62DD
        DA55DC79FB9758B0B0171FA2C53602A1AA002E11480A1481FA0C81422842209B
        D7CDDD77DD4ABDEE70CE95F977E4EEA82C35827851F23C30DDF27435EAB492FC
        214849A0AA8088D22A823559B3F0C61860AAE5AB4028735FA246C6E28BC8EC3D
        10458C65AD1E68B502798865C6257249C69CF2BE4B0CB5FA5C725272E43E9A4F
        C2EC5040288A48BD36A340A008C2233FFF13875E3B7EFECCCFD29EEF5FB9943B
        BEBE851895BC88E47944E46C258862B2D7674A90E4BAF8E2856CBC621DF7DEBD
        859FEE7F879EAE3A75E788AAA8C2C966E4E4B4470011939A93A70A7EF899A5DC
        BFEB69A69A938C1C799B853DDD8C4D4CE1D2F7A24AA056D6490821DA04985CB9
        E773375C6567A2983A3E2AB9578AA0B4BC329547031551DBD50CF3430C6CDEB4
        FE0CA19C53D33979E16D025494B2A54A0212439C98E9D810C46A15A2F0C6BFC7
        199F9C44D540C9BD90C7687BB3B0D14284B64531F0F4EAD533BF3F6113A40AAA
        8EE9A647244E563ECB64C9F16F1E7FFDB6E966F361D42D462148206F3559BEBC
        DF021BB8CF718000AD5C6815D29E7D35600706061223BFFBD553648D2EEA59C3
        ACE6DCD8C489A3DF005A8054BBB10ECC03BA2A93D100E6DFFE9DDF1EDAF1CD2D
        E5B72E5994F2ED635BE5DDACC07777FE815F3EF0850DC069C00321014FA73D54
        3FC7311DFAEA1F28C0E93C6FEEFBF67DBFBF92369EA2556040C5BC74A400F8A2
        35041C4980928C52FE12A8D3AF5E67402359F563E0CEF37B017C996909D839AD
        4E55CFF5DFB12B81CDE8B4B39C6B3221F9B3E100FC0F0F4FF620152A08690000
        000049454E44AE426082}
      OnClick = dxBtnImprimirMultiplosClick
    end
    object dxBarBtnEnviarEmail: TdxBarLargeButton
      Caption = 'Enviar E-mail'
      Category = 0
      Hint = 'Enviar E-mail'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F400000010744558745469746C65004D61696C4D657267653BF2311537000006
        E449444154785EA5976B885DD519869FB5F7B95EE6722699993399C9E46649AD
        6D3156C44A951A6D624A6CAC34D2F4421348134B6D8B88106C7FF45F2BAD604B
        D2C662B4687E84682385107A1133422BA4324991993490C06826B7B99D33E7BA
        CFBEACB53AEEB33D9BCD41E2B42F7CACB5179BF57EEBFDDE6F5F6284108038F5
        CBAF6D1288BB407F1EF4A7057A14C4804667B55275A5D49CE7A969CF93172D57
        4ECC57ACF1277F7FE62CE00212507A097C42C4005AC48FDC198B893DC3B7ACDF
        9D2F0CA7BBF27912E90CA669629849442C8592E4BC6633D7AC56D735CA0BF795
        E7E728CE5C6B1E7D3A79ECCA7CFDD5032F8FBF03384208BD84E5259034C5BFEE
        D8F200BD032BE98407CAC230E224B2E9A5E8A17B681D05E22012A9E1737FDB7D
        76ECE46EA00FF000B51C0504600C7D6ABDBF79143ADC4F29100A084621C190A0
        15A826CA2902240023D8532F4701A3787D86C1756B6994AB243359E2A934B198
        894061180A61689467E3D93676AD46BD5CA25A5CA0347B9DC6FC349839003320
        67B90A8846A54ABABB1B48E0B9925AB94EB356C22ACF6137EA384D0BCF6E229D
        06DA6D826B23A48789209F4D335F71FEE70400844681003396209EC992CEAF42
        4B87DAEC25BC4611BB348D552AE1BA251CAF8E74259A38C24C8000AD34804100
        2104CB2A81D20A002D4077E8A869B95AA0E984D620950CF6C3040C3A21A2E642
        454CB8A2B092D2F5ABF40E6DC08885F42208448B5EB4564262A9585C2CE3352B
        0029201992213AC387046CC06D2B505DACFA325E39FF2EC94C0F896C2F895406
        CF6A20A44468504AE349B0A5C0760D2C4F7221F730EFAFFE068CC04F5ED2134A
        6BD01AE50F1A3428ADD17E108C9A179FB8330FC8B60256AD4E7ED508DD83A338
        5613AB526661EE0AB5E20C76BD82E73A682541265BFA9936535D0FB3F1BE7D9C
        3F7385A71EB9955CD2241D3788C70431536008016834800EFBF28917CE1228D5
        0814C044690490486549750DD05388A3A51B98701EBB384D737116BB5CC5AAD5
        F87776076BEFDDC7439B0678ED9F979112A4D22042037692D35201DDEE98B602
        2D1707750E6F0FAEA3CE792FFD2823F7ECF7C9013C29039382CF1D78E5E3C803
        2A23D20503A3054A37AE92FFD084714114B437535233917D940B93454E9D9BC5
        B26C3CA97CC9DF9A2CB56B0E41CD832CBEF5A5A156FD69B7AC08150073716191
        61A5990E4D48F2431336EBA02402504AE1C8D609F63EB806E981169A98214825
        0CB66F5A413261F8D71D897F441ECC0123D286F54A95BEB6092DAC4A85F9B969
        EAA5599A1F9AD07190D2C3B193E89C26973091718DF8C743A899313C090B125C
        0589C2FDACFEFA9BC1E9094F1E76416709829B88A732A4BAFAE9292440BA5467
        2E61D766B18AD34B314BBD54F63748250D04509D1D63749F26049C7B4EF86447
        DEBCDC26DEF3C06A54BB15232508A01402220F1A7CC378ECBC7A8479B781129A
        97E446409330050066612B170F093C05AE042921B57A2BE093B60881901CDA7E
        0F14D080BD50B5DFFA60F2FCE6D59FB99D443C13BE8C3D8D5C8A9FDDF33887DF
        3D8EE36994DFB2CA777F7ECB49561A063AAC7784B093BCB30412B0DE9B2A1D6C
        FCF9EF958D9317B62D7921D933B08A5C6F2F4EBDE2BB5C29A85A25C6ED189EE7
        E238368FBFB18BE7B7BDCC89F13A3A30A9541A25954FA4944FE6CF7FF0D55BDA
        8940B4040AB00E9EBC781A38FB9D2FCF1F1FEDBFF085EE74ECD64CD21C353583
        F9757AC5F90D53C6504F8C13CD797765E5EDF8CC8D5EDE991E63FFEBBB38B8E3
        287D7D7D18A681D67CFCC9C33154402F4108E10135C03E3A76F92FC058F86221
        33B837FB4DD64F3CBDA63042E62E277EF9DA21BE72FCE728092B0B71F61FDBC5
        A19DAFB062453FEEDBDBB0AF9DC6F1F0C3F6C01CBC9FC1ED7F8D24117A206C57
        19A8E10075C02088D9571ACF4FF44DE59BB70DEDEDEB566CBE7D0385E416FA73
        AB4898099E7BFF303F7E6D0F4776FF0979FD34C37BA35D71E659417F40DEF920
        0AA183005084403BDABAF19BFA01F7BB57A7CC2CDBC7BB1B5F4C8BF354AC32A3
        6BE374353FC7AF77FE8144328935B8954BBF13386EEBF48EDF155B2265511055
        A0F3139AC8C2DA67BBE50707AA8B732F360E0127BEFD8B37FEF3A307FBD971EC
        5E72C5DBF8ED637F64B03084619A64369F2415F47AA4F6846BA848096E0E29DB
        AA58402595EB637878843B0A77F3ABED2F706AD2454D4C23A5C2F39642493CA9
        FC5041573CF5D86783844047BBE0E6987EA682F8A908B2C65068725D5D1CF9DE
        EBBEECDF5F138F9CB6E3E42A987FA44C4481E543A0C18CC5C9E66251C290242A
        3BD1750DFF57029D242179744E643D624440027A3909E8201CA5143F3C3C0E84
        4F3A1D9210AEF92980C21F55300F4CDF00D47215F080DAAB4FDE3D04A48158F8
        2B06C11C404403C21119901701F7932510C82C84D04013703BFF82E0A6D7D12F
        3B1790FF0566AE73525F020E450000000049454E44AE426082}
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
      '       TP.NUMERO_DOCUMENTO, '
      ' case'
      
        '        when (tp.id_tipo_status in ('#39'QUITADO'#39', '#39'PARCIAL'#39')) then ' +
        'TPB.VALOR_PAGO'
      
        '        when (tp.id_tipo_status in ('#39'ABERTO'#39')) then  TP.VALOR_NO' +
        'MINAL'
      '   end as valor_NOMINAL,'
      ''
      '       TP.DESCRICAO as dsc_tp, '
      '       TP.DATA_VENCIMENTO,'
      '       TP.DATA_PAGAMENTO,'
      '       C.NOME as fornecedor,'
      '       H.DESCRICAO as dsc_hst'
      '--       '#39'0'#39' as PAGAR'
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (TP.ID_HISTORICO = H.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.ID_TITULO_PAGAR =' +
        ' TP.ID_TITULO_PAGAR  AND  TPB.ID_ORGANIZACAO = TP.ID_ORGANIZACAO' +
        ')   '
      ''
      
        'WHERE (TP.ID_TITULO_PAGAR = :PID ) OR ( (TP.ID_ORGANIZACAO = :PI' +
        'DORGANIZACAO) '
      '   AND (TP.DATA_VENCIMENTO BETWEEN :DTI AND :DTF) '
      '   AND   (TP.ID_TIPO_STATUS <> '#39'EXCLUIDO'#39') )'
      ''
      '   ORDER BY TP.DATA_PAGAMENTO DESC '
      ''
      '   ')
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
          '       TP.NUMERO_DOCUMENTO,       '
          'case'
          
            '        when (tp.id_tipo_status in ('#39'QUITADO'#39', '#39'PARCIAL'#39')) then ' +
            'TPB.VALOR_PAGO'
          
            '        when (tp.id_tipo_status in ('#39'ABERTO'#39')) then  TP.VALOR_NO' +
            'MINAL'
          '   end as valor_NOMINAL,'
          ''
          '       TP.DESCRICAO as dsc_tp, '
          '       TP.DATA_VENCIMENTO,'
          '       TP.DATA_PAGAMENTO,'
          '       C.NOME as fornecedor,'
          '       H.DESCRICAO as dsc_hst'
          ''
          'FROM TITULO_PAGAR TP'
          
            'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE AND  ' +
            'C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
          
            'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.ID_TITULO_PAGAR =' +
            ' TP.ID_TITULO_PAGAR  AND  TPB.ID_ORGANIZACAO = TP.ID_ORGANIZACAO' +
            ')   '
          
            'LEFT OUTER JOIN HISTORICO H ON (TP.ID_HISTORICO = H.ID_HISTORICO' +
            '  AND H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)')
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
