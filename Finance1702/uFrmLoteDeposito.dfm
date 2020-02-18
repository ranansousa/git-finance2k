object frmLoteDeposito: TfrmLoteDeposito
  Left = 0
  Top = 0
  Hint = 'Detalhes do lote dep'#243'sito e exclus'#227'o'
  Caption = 'Lote Dep'#243'sito'
  ClientHeight = 556
  ClientWidth = 784
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
    Left = 472
    Top = 309
    Width = 61
    Height = 13
    Caption = 'DOC TITULO'
  end
  object lbl2: TLabel
    Left = 472
    Top = 362
    Width = 78
    Height = 13
    Caption = 'LOTE CONT'#193'BIL'
  end
  object lbl3: TLabel
    Left = 472
    Top = 253
    Width = 59
    Height = 13
    Caption = 'DESCRI'#199#195'O'
  end
  inline frmPeriodo1: TfrmPeriodo
    Left = 21
    Top = 160
    Width = 260
    Height = 57
    TabOrder = 0
    ExplicitLeft = 21
    ExplicitTop = 160
    ExplicitWidth = 260
    ExplicitHeight = 57
    inherited lbl1: TLabel
      Top = 3
      ExplicitTop = 3
    end
    inherited lbl2: TLabel
      Top = 3
      ExplicitTop = 3
    end
    inherited dtpDataInicial: TDateTimePicker
      Top = 27
      ExplicitTop = 27
    end
    inherited dtpDataFinal: TDateTimePicker
      Top = 27
      ExplicitTop = 27
    end
  end
  object btnPesquisar: TBitBtn
    Left = 312
    Top = 183
    Width = 113
    Height = 25
    Caption = 'Pesquisar'
    TabOrder = 1
    OnClick = btnPesquisarClick
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 784
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 2
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Lote dep'#243'sito'
      Groups = <
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
    Left = 40
    Top = 256
    Width = 393
    Height = 233
    DataSource = ds1
    TabOrder = 7
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
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'QTD_CHQ'
        Title.Alignment = taCenter
        Title.Caption = 'CH'
        Width = 30
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONTA'
        Title.Alignment = taCenter
        Title.Caption = 'CONTA BANC.'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TOTAL_DEPOSITO'
        Title.Alignment = taCenter
        Title.Caption = 'VALOR'
        Width = 80
        Visible = True
      end>
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 536
    Width = 784
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 80
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
  end
  object edtDescricao: TEdit
    Left = 472
    Top = 272
    Width = 254
    Height = 21
    Enabled = False
    TabOrder = 4
  end
  object edtTRDOC: TEdit
    Left = 472
    Top = 328
    Width = 254
    Height = 21
    Enabled = False
    TabOrder = 5
  end
  object edtLoteContabil: TEdit
    Left = 472
    Top = 381
    Width = 254
    Height = 21
    Enabled = False
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
      DockedLeft = 0
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
      DockedLeft = 68
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
  end
  object ds1: TDataSource
    DataSet = qryObterLotes
    OnDataChange = ds1DataChange
    Left = 176
    Top = 392
  end
  object qryObterLotes: TFDQuery
    Connection = dmConexao.conn
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
      '       CB.TITULAR,'
      '       LD.TOTAL_DEPOSITO'
      ''
      'FROM LOTE_DEPOSITO LD'
      ''
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = LD.' +
        'ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = LD.ID_ORGANIZACAO)'
      ''
      'WHERE (LD.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      'AND (LD.DATA_REGISTRO BETWEEN :PDATAINICIAL AND :PDATAFINAL)'
      ''
      'ORDER BY LD.DATA_REGISTRO DESC, LD.TOTAL_DEPOSITO ASC'
      ''
      ''
      '')
    Left = 64
    Top = 488
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
    Left = 144
    Top = 488
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
    Left = 240
    Top = 488
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
