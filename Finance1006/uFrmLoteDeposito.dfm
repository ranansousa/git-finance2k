object frmLoteDeposito: TfrmLoteDeposito
  Left = 0
  Top = 0
  Hint = 'Detalhes do lote dep'#243'sito e exclus'#227'o'
  Caption = 'Lote Dep'#243'sito'
  ClientHeight = 734
  ClientWidth = 962
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 325
    Top = 685
    Width = 61
    Height = 13
    Caption = 'DOC TITULO'
  end
  object lbl2: TLabel
    Left = 667
    Top = 685
    Width = 78
    Height = 13
    Caption = 'LOTE CONT'#193'BIL'
  end
  object lbl3: TLabel
    Left = 1
    Top = 689
    Width = 59
    Height = 13
    Caption = 'DESCRI'#199#195'O'
  end
  object edtLoteContabil: TEdit
    Left = 751
    Top = 685
    Width = 201
    Height = 21
    Enabled = False
    TabOrder = 3
  end
  object edtTRDOC: TEdit
    Left = 399
    Top = 685
    Width = 254
    Height = 21
    Enabled = False
    TabOrder = 2
  end
  object edtDescricao: TEdit
    Left = 66
    Top = 685
    Width = 240
    Height = 21
    Enabled = False
    TabOrder = 1
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 962
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 0
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Lote dep'#243'sito'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar3'
        end
        item
          ToolbarName = 'dxBarManager1Bar4'
        end
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar2'
        end>
      Index = 0
    end
  end
  object dbgrdMain: TDBGrid
    Left = 0
    Top = 135
    Width = 962
    Height = 579
    Align = alClient
    DataSource = ds1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATA_REGISTRO'
        Title.Alignment = taCenter
        Title.Caption = 'DATA'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'LOTE'
        Title.Alignment = taCenter
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'STATUS'
        Title.Alignment = taCenter
        Width = 70
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TOTAL_DEPOSITO'
        Title.Alignment = taCenter
        Title.Caption = 'VALOR'
        Width = 120
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'QTD_CHQ'
        Title.Alignment = taCenter
        Title.Caption = 'CH'
        Width = 50
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'AGENCIA'
        Title.Caption = 'AG'#202'NCIA'
        Width = 50
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONTA'
        Title.Alignment = taCenter
        Title.Caption = 'CONTA BANC'#193'RIA'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TITULAR'
        Title.Alignment = taCenter
        Title.Caption = 'TITULAR DA CONTA'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_BANCO'
        Title.Alignment = taCenter
        Title.Caption = 'BANCO'
        Width = 165
        Visible = True
      end>
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 714
    Width = 962
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 300
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 300
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
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
  end
  object Panel1: TPanel
    Left = 0
    Top = 125
    Width = 962
    Height = 10
    Align = alTop
    TabOrder = 6
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
    Left = 696
    Top = 64
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Deletar'
      CaptionButtons = <>
      DockedLeft = 290
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnEstornarLD'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Sair'#13#10
      CaptionButtons = <>
      DockedLeft = 358
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton1'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Per'#237'odo'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 998
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
    object dxBarManager1Bar4: TdxBar
      Caption = 'Pesquisa'
      CaptionButtons = <>
      DockedLeft = 215
      DockedTop = 0
      FloatLeft = 998
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnPesquisa'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarLargeButton1: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBarLargeButton1Click
    end
    object dxBtnEstornarLD: TdxBarLargeButton
      Caption = 'Estornar'
      Category = 0
      Hint = 'Estornar'
      Visible = ivAlways
      OnClick = dxBtnEstornarLDClick
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
    object dxBarBtnPesquisa: TdxBarLargeButton
      Caption = 'Pesquisar'
      Category = 0
      Hint = 'Pesquisar'
      Visible = ivAlways
      OnClick = dxBarBtnPesquisaClick
    end
  end
  object ds1: TDataSource
    DataSet = qryObterLotes
    OnDataChange = ds1DataChange
    Left = 264
    Top = 288
  end
  object qryObterLotes: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT LD.ID_LOTE_DEPOSITO as ID,'
      '       LD.ID_ORGANIZACAO,'
      '       LD.LOTE,'
      '       LD.DATA_REGISTRO,'
      '       LD.DATA_ATUALIZACAO,'
      '       LD.STATUS,'
      '       LD.ID_USUARIO,'
      '       LD.QTD_CHQ,'
      '       LD.ID_CONTA_BANCARIA,'
      '       CB.CONTA,'
      '       CB.AGENCIA,'
      '       CB.TITULAR,'
      '       B.NOME_BANCO,'
      '       LD.TOTAL_DEPOSITO'
      ''
      'FROM LOTE_DEPOSITO LD'
      ''
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = LD.' +
        'ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = LD.ID_ORGANIZACAO)'
      'LEFT OUTER JOIN BANCO B ON (B.ID_BANCO = CB.ID_BANCO)'
      ''
      'WHERE (LD.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      'AND (LD.DATA_REGISTRO BETWEEN :PDATAINICIAL AND :PDATAFINAL)'
      ''
      'ORDER BY LD.DATA_REGISTRO DESC, LD.TOTAL_DEPOSITO ASC'
      ''
      ''
      '')
    Left = 256
    Top = 376
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryObterCBC: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT CBC.ID_CONTA_BANCARIA_CREDITO as ID,'
      '       CBC.ID_ORGANIZACAO,'
      '       CBC.ID_LOTE_CONTABIL,'
      
        '       (LC.LOTE || '#39' EM '#39' || LC.DATA_REGISTRO || '#39' TIPO '#39' || LC.' +
        'TIPO_LANCAMENTO)   AS LOTE_CTB,'
      '       CBC.ID_LOTE_DEPOSITO,'
      '       CBC.OBSERVACAO,'
      '       CBC.DESCRICAO,'
      '       CBC.VALOR,'
      '       CBC.DATA_MOVIMENTO,'
      '       CBC.IDENTIFICACAO'
      ''
      'FROM CONTA_BANCARIA_CREDITO CBC'
      
        'LEFT OUTER JOIN LOTE_CONTABIL LC ON (LC.ID_LOTE_CONTABIL = CBC.I' +
        'D_LOTE_CONTABIL) AND (LC.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO) '
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      'AND   (CBC.ID_LOTE_DEPOSITO = :PIDLOTE)')
    Left = 368
    Top = 376
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDLOTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterTRBC: TFDQuery
    ObjectView = False
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TRBC.ID_TITULO_RECEBER_BAIXA_CHEQUE as ID_CHEQUE,'
      '       TRBC.ID_ORGANIZACAO,'
      '       TRBC.ID_TITULO_RECEBER_BAIXA,'
      '       TRBC.ID_BANCO,'
      '       TRBC.ID_LOTE_DEPOSITO,'
      '       TRBC.ID_TIPO_STATUS,'
      '       TR.NUMERO_DOCUMENTO'
      ''
      'FROM TITULO_RECEBER_BAIXA_CHEQUE TRBC'
      
        'LEFT OUTER JOIN TITULO_RECEBER_BAIXA TRB ON (TRB.ID_TITULO_RECEB' +
        'ER_BAIXA = TRBC.ID_TITULO_RECEBER_BAIXA) AND (TRB.ID_ORGANIZACAO' +
        ' = TRBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN TITULO_RECEBER TR ON (TR.ID_TITULO_RECEBER = TRB' +
        '.ID_TITULO_RECEBER) AND (TR.ID_ORGANIZACAO = TRBC.ID_ORGANIZACAO' +
        ')'
      ''
      'WHERE (TRBC.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      'AND (TRBC.ID_LOTE_DEPOSITO = :PIDLOTE)')
    Left = 352
    Top = 288
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDLOTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
