object frmDeletaLoteContabil: TfrmDeletaLoteContabil
  Left = 0
  Top = 0
  Caption = '  Deleta Lote Contabil'
  ClientHeight = 734
  ClientWidth = 801
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
  object lbl2: TLabel
    Left = 8
    Top = 141
    Width = 42
    Height = 13
    Caption = 'ID LOTE '
  end
  object lbl3: TLabel
    Left = 8
    Top = 226
    Width = 30
    Height = 13
    Caption = 'DATA '
  end
  object lbl4: TLabel
    Left = 7
    Top = 181
    Width = 24
    Height = 13
    Caption = 'TIPO'
  end
  object lbl5: TLabel
    Left = 243
    Top = 141
    Width = 73
    Height = 13
    Caption = 'VALOR D'#201'BITO'
  end
  object lbl6: TLabel
    Left = 496
    Top = 141
    Width = 81
    Height = 13
    Caption = 'VALOR CR'#201'DITO'
  end
  object edtIdLote: TEdit
    Left = 67
    Top = 138
    Width = 150
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 0
  end
  object edtDataRegistro: TEdit
    Left = 67
    Top = 223
    Width = 85
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 1
  end
  object medtValorDB: TMaskEdit
    Left = 333
    Top = 138
    Width = 140
    Height = 21
    Alignment = taRightJustify
    Color = clMoneyGreen
    Enabled = False
    TabOrder = 3
    Text = ''
  end
  object edtTabela: TEdit
    Left = 67
    Top = 178
    Width = 150
    Height = 21
    Alignment = taCenter
    Enabled = False
    TabOrder = 2
  end
  object medtValorCR: TMaskEdit
    Left = 587
    Top = 138
    Width = 155
    Height = 21
    Alignment = taRightJustify
    Color = 13619199
    Enabled = False
    TabOrder = 4
    Text = ''
  end
  object edtTipoLancamento: TEdit
    Left = 240
    Top = 178
    Width = 81
    Height = 21
    Alignment = taCenter
    Enabled = False
    TabOrder = 5
  end
  object dbgrd1: TDBGrid
    Left = 8
    Top = 277
    Width = 340
    Height = 436
    DataSource = dsMega
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ANO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPRESA'
        Title.Alignment = taCenter
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
        FieldName = 'LOTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
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
        FieldName = 'TOTAL'
        Title.Alignment = taRightJustify
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end>
  end
  object dbgrd2: TDBGrid
    Left = 454
    Top = 277
    Width = 340
    Height = 436
    DataSource = dsFinance
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ANO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPRESA'
        Title.Alignment = taCenter
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
        FieldName = 'LOTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
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
        FieldName = 'TOTAL'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end>
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 714
    Width = 801
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 60
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
    ExplicitTop = 503
    ExplicitWidth = 691
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 801
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 9
    TabStop = False
    ExplicitWidth = 967
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Manuten'#231#227'o de lotes exportados'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar2'
        end
        item
          ToolbarName = 'dxBarCustom'
        end
        item
          ToolbarName = 'dxBarManager1Bar5'
        end>
      Index = 0
    end
  end
  object qryObterLoteID: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    SQL.Strings = (
      ''
      'SELECT  LC.ID_LOTE_CONTABIL,'
      '        LC.ID_ORGANIZACAO,'
      '        LC.LOTE,'
      '        LC.STATUS,'
      '        LC.DATA_REGISTRO,'
      '        LC.DATA_ATUALIZACAO,'
      '        LC.PERIODO_INICIAL,'
      '        LC.PERIODO_FINAL,'
      '        LC.TIPO_TABLE, '
      '        LC.TIPO_LANCAMENTO, '
      '        LC.VALOR_CR, '
      '        LC.VALOR_DB,'
      '        LC.QTD_REGISTROS'
      ''
      ''
      ' FROM LOTE_CONTABIL LC'
      ''
      'WHERE (LC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (LC.ID_LOTE_CONTABIL = :PIDLOTE)'
      '      ')
    Left = 352
    Top = 536
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
  object qryGeneric: TFDQuery
    Connection = dmConexao.conn
    Left = 360
    Top = 600
  end
  object qryAlteraGeneric: TFDQuery
    Connection = dmConexao.conn
    Left = 360
    Top = 288
  end
  object qryAlteraLote: TFDQuery
    Connection = dmConexao.conn
    Left = 352
    Top = 344
  end
  object qryObterTPPROV: TFDQuery
    Connection = dmConexao.conn
    Left = 352
    Top = 408
  end
  object qryDeletaLote: TFDQuery
    Connection = dmConexao.conn
    Left = 352
    Top = 480
  end
  object qryObterLotePorAno: TFDQuery
    Connection = dmConexao.ConnMega
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT DISTINCT CAST( CL.EMPRESA AS VARCHAR(5)) AS ID_EMPRESA,'
      '       CL.ANO,'
      '      CAST( CL.LOTE AS VARCHAR(10)) AS LOTE,'
      '       CL.TOTAL,'
      '       C.NOME AS EMPRESA'
      ''
      'FROM CLOTES CL'
      'LEFT OUTER JOIN cadastro C ON (C.ID = CL.empresa)'
      ''
      'WHERE (CL.empresa = :PIDEMPRESA)'
      'AND   (CL.ano = :PANO)'
      ''
      'ORDER BY CL.LOTE DESC')
    Left = 176
    Top = 368
    ParamData = <
      item
        Name = 'PIDEMPRESA'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PANO'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object dsMega: TDataSource
    AutoEdit = False
    DataSet = qryObterLotePorAno
    Left = 64
    Top = 368
  end
  object qryObterLoteFNC: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT LC.LOTE, LC.TIPO_TABLE as TABELA,'
      '       LC.ID_ORGANIZACAO AS EMPRESA, LC.ID_LOTE_CONTABIL,'
      
        '      CAST(EXTRACT(year FROM LC.PERIODO_INICIAL) AS VARCHAR(4)) ' +
        'AS ANO,'
      '       LC.VALOR_DB AS TOTAL'
      ''
      'FROM LOTE_CONTABIL LC'
      ''
      'WHERE (LC.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      
        'AND   (LC.PERIODO_INICIAL BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) '
      'ORDER BY LC.LOTE DESC')
    Left = 624
    Top = 360
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
      end>
  end
  object dsFinance: TDataSource
    DataSet = qryObterLoteFNC
    Left = 496
    Top = 368
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
    Left = 646
    Top = 64
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
    Left = 736
    Top = 64
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Filtro'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1003
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarcbbAno'
        end
        item
          Visible = True
          ItemName = 'dxBarcbbLoteContabil'
        end>
      OneOnRow = True
      Row = 3
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Lotes'
      CaptionButtons = <>
      DockedLeft = 221
      DockedTop = 0
      FloatLeft = 1003
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnDeletarLote'
        end
        item
          Visible = True
          ItemName = 'dxBarSincronizaLotes'
        end>
      OneOnRow = True
      Row = 2
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarCustom: TdxBar
      Caption = 'Limpar'
      CaptionButtons = <>
      DockedLeft = 357
      DockedTop = 0
      FloatLeft = 1003
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnLimpar'
        end>
      OneOnRow = True
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar5: TdxBar
      Caption = 'Fechar'#13#10
      CaptionButtons = <>
      DockedLeft = 419
      DockedTop = 0
      FloatLeft = 1003
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnSair'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarcbbAno: TdxBarCombo
      Align = iaRight
      Caption = 'Selecione o ano'
      Category = 0
      Hint = 'Selecione o ano'
      Visible = ivAlways
      OnChange = dxBarcbbAnoChange
      Width = 120
      Items.Strings = (
        '>> Selecione o ano << '
        '2020'
        '2019'
        '2018'
        '2017'
        '2016'
        '2015'
        '2014')
      ItemIndex = -1
    end
    object dxBarcbbLoteContabil: TdxBarCombo
      Align = iaRight
      Caption = 'Selecione  lote '
      Category = 0
      Hint = 'Selecione  lote '
      Visible = ivAlways
      OnChange = dxBarcbbLoteContabilChange
      Width = 120
      ItemIndex = -1
    end
    object dxBarBtnSair: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBarBtnSairClick
    end
    object dxBarBtnLimpar: TdxBarLargeButton
      Caption = 'Limpar'
      Category = 0
      Hint = 'Limpar'
      Visible = ivAlways
      OnClick = dxBarBtnLimparClick
    end
    object dxBarBtnDeletarLote: TdxBarLargeButton
      Caption = 'Deletar'
      Category = 0
      Hint = 'Deletar'
      Visible = ivAlways
      OnClick = dxBarBtnDeletarLoteClick
    end
    object dxBarSincronizaLotes: TdxBarLargeButton
      Caption = 'Sincronizar'
      Category = 0
      Hint = 'Sincronizar'
      Visible = ivAlways
      OnClick = dxBarSincronizaLotesClick
    end
  end
end
