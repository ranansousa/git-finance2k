object frmTransferenciasBancoCaixa: TfrmTransferenciasBancoCaixa
  Left = 0
  Top = 0
  Caption = 'Transfer'#234'ncias Banco  ->  Tesouraria'
  ClientHeight = 456
  ClientWidth = 884
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
  object dxMain: TdxRibbon
    Left = 0
    Top = 0
    Width = 884
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 0
    TabStop = False
    object dxMainTab1: TdxRibbonTab
      Active = True
      Caption = 'Transfer'#234'ncias'
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
        end
        item
          ToolbarName = 'dxBarManager1Bar5'
        end>
      Index = 0
    end
  end
  object cxpgcntrlPGTRFBCOCAIXA: TcxPageControl
    Left = 0
    Top = 125
    Width = 884
    Height = 331
    Align = alClient
    TabOrder = 1
    Properties.ActivePage = tbTransfereEstorna
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 331
    ClientRectRight = 884
    ClientRectTop = 24
    object tbTransfereCH: TcxTabSheet
      Caption = 'Transferir'
      ImageIndex = 0
      object lblResponsavel: TLabel
        Left = 270
        Top = 23
        Width = 78
        Height = 13
        Caption = 'Data movimento'
      end
      inline frmContaBancaria1: TfrmContaBancaria
        Left = 572
        Top = 19
        Width = 175
        Height = 59
        TabOrder = 2
        ExplicitLeft = 572
        ExplicitTop = 19
        ExplicitWidth = 175
        ExplicitHeight = 59
        inherited lbl1: TLabel
          Left = 40
          ExplicitLeft = 40
        end
        inherited cbbConta: TComboBox
          Left = 43
          Width = 113
          OnChange = frmContaBancaria1cbbContaChange
          ExplicitLeft = 43
          ExplicitWidth = 113
        end
      end
      object cxLabel2: TcxLabel
        Left = 272
        Top = 84
        Caption = 'Tipo opera'#231#227'o banc'#225'ria'
      end
      object edtTipoOperacao: TcxTextEdit
        Left = 272
        Top = 107
        Enabled = False
        TabOrder = 4
        Width = 119
      end
      object cxLabel9: TcxLabel
        Left = 612
        Top = 84
        Caption = 'Conta cont'#225'bil cr'#233'dito'
      end
      object edtContaContabilDB: TcxTextEdit
        Left = 612
        Top = 107
        Enabled = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 6
        Width = 106
      end
      object cbbDataMovimento: TcxDateEdit
        Left = 270
        Top = 42
        Properties.OnChange = cbbDataMovimentoPropertiesChange
        TabOrder = 0
        Width = 121
      end
      object dxStatusTRF: TdxStatusBar
        Left = 0
        Top = 287
        Width = 884
        Height = 20
        Panels = <
          item
            PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
            Width = 90
          end
          item
            PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
            Width = 600
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object cxLabel5: TcxLabel
        Left = 412
        Top = 19
        Caption = 'Valor da opera'#231#227'o'
      end
      object edtValor: TEvNumEdit
        Left = 412
        Top = 42
        Width = 133
        Height = 21
        Glyph.Data = {
          7E050000424D7E0500000000000036000000280000001A0000000D0000000100
          2000000000004805000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF009A6A39009767360093643400906131008C5E2F00895B
          2C0085582A00825527007F522500FF00FF00FF00FF00FF00FF00FF00FF008585
          8500828282007F7F7F007D7D7D007A7A7A007777770075757500727272006F6F
          6F00FF00FF00FF00FF00FF00FF00FF00FF009F6E3C00E3947600DC8B6A00D682
          5E00D07A5300CB724900C66B3F00C66B3F0082552700FF00FF00FF00FF00FF00
          FF00FF00FF0089898900B1B1B100A9A9A900A1A1A10099999900929292008B8B
          8B008B8B8B0072727200FF00FF00FF00FF00FF00FF00FF00FF00A2713E00FFFF
          FF00D0A08000FFFFFF00D0A08000FFFFFF00D0A08000E9D7C30085582A00FF00
          FF00FF00FF00FF00FF00FF00FF008B8B8B00FFFFFF00B7B7B700FFFFFF00B7B7
          B700FFFFFF00B7B7B700E0E0E00075757500FF00FF00FF00FF00FF00FF00FF00
          FF00A5734000E3947600DC8B6A00D6825E00D07A5300CB724900C66B3F00C66B
          3F00895B2C00FF00FF00FF00FF00FF00FF00FF00FF008D8D8D00B1B1B100A9A9
          A900A1A1A10099999900929292008B8B8B008B8B8B0077777700FF00FF00FF00
          FF00FF00FF00FF00FF00A8764200FFFFFF00D0A08000FFFFFF00D0A08000FFFF
          FF00D0A08000E9D7C3008C5E2F00FF00FF00FF00FF00FF00FF00FF00FF008F8F
          8F00FFFFFF00B7B7B700FFFFFF00B7B7B700FFFFFF00B7B7B700E0E0E0007A7A
          7A00FF00FF00FF00FF00FF00FF00FF00FF00AB794400E3947600DC8B6A00D682
          5E00D07A5300CB724900C66B3F00C66B3F0090613100FF00FF00FF00FF00FF00
          FF00FF00FF0092929200B1B1B100A9A9A900A1A1A10099999900929292008B8B
          8B008B8B8B007D7D7D00FF00FF00FF00FF00FF00FF00FF00FF00AE7B4600FFFF
          FF00D0A08000FFFFFF00D0A08000FFFFFF00D0A08000E9D7C30093643400FF00
          FF00FF00FF00FF00FF00FF00FF0093939300FFFFFF00B7B7B700FFFFFF00B7B7
          B700FFFFFF00B7B7B700E0E0E0007F7F7F00FF00FF00FF00FF00FF00FF00FF00
          FF00B17E4800E3947600DC8B6A00D6825E00D07A5300CB724900C66B3F00C66B
          3F0097673600FF00FF00FF00FF00FF00FF00FF00FF0096969600B1B1B100A9A9
          A900A1A1A10099999900929292008B8B8B008B8B8B0082828200FF00FF00FF00
          FF00FF00FF00FF00FF00B4814A00FFF9F900FFF3F300FFEDED00FFE7E700FFDC
          DC00FFD0D000FFD0D0009A6A3900FF00FF00FF00FF00FF00FF00FF00FF009999
          9900FBFBFB00F8F8F800F4F4F400F0F0F000E9E9E900E2E2E200E2E2E2008585
          8500FF00FF00FF00FF00FF00FF00FF00FF00B9854E00FFFFFF00FFF9F900FFF3
          F300FFEDED00FFE7E700FFDCDC00FFDCDC009F6E3C00FF00FF00FF00FF00FF00
          FF00FF00FF009C9C9C00FFFFFF00FBFBFB00F8F8F800F4F4F400F0F0F000E9E9
          E900E9E9E90089898900FF00FF00FF00FF00FF00FF00FF00FF00BC875000B985
          4E00B4814A00B17E4800AE7B4600AB794400A8764200A5734000A2713E00FF00
          FF00FF00FF00FF00FF00FF00FF009E9E9E009C9C9C0099999900969696009393
          9300929292008F8F8F008D8D8D008B8B8B00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00}
        TabOrder = 1
      end
      object cxLabel10: TcxLabel
        Left = 412
        Top = 84
        Caption = 'Conta cont'#225'bil d'#233'bito'
      end
      object edtContaContabilCR: TcxTextEdit
        Left = 412
        Top = 107
        Enabled = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 10
        Width = 106
      end
      object cxLabel1: TcxLabel
        Left = 148
        Top = 19
        Caption = 'Identificador'
      end
      object edtIdentificador: TcxTextEdit
        Left = 148
        Top = 42
        Enabled = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 12
        Width = 107
      end
      inline frameCheque1: TframeCheque
        Left = 752
        Top = 21
        Width = 122
        Height = 45
        TabOrder = 13
        ExplicitLeft = 752
        ExplicitTop = 21
        ExplicitWidth = 122
        ExplicitHeight = 45
        inherited lbl1: TLabel
          Left = 1
          Top = -2
          ExplicitLeft = 1
          ExplicitTop = -2
        end
        inherited cbbCheque: TComboBox
          Left = 1
          Top = 17
          Width = 105
          OnChange = frameCheque1cbbChequeChange
          ExplicitLeft = 1
          ExplicitTop = 17
          ExplicitWidth = 105
        end
      end
      object rgOpcaoTRF: TRadioGroup
        Left = 32
        Top = 21
        Width = 89
        Height = 57
        Caption = 'Tipo'
        Items.Strings = (
          'Cheque'
          'Esp'#233'cie')
        TabOrder = 14
      end
      inline frameResponsavel1: TframeResponsavel
        Left = 24
        Top = 91
        Width = 242
        Height = 88
        TabOrder = 15
        ExplicitLeft = 24
        ExplicitTop = 91
        ExplicitWidth = 242
        inherited lblResponsavel: TLabel
          Left = 10
          Top = -1
          ExplicitLeft = 10
          ExplicitTop = -1
        end
        inherited cbbcombo: TComboBox
          Left = 10
          Top = 18
          Width = 214
          OnChange = frameResponsavel1cbbcomboChange
          ExplicitLeft = 10
          ExplicitTop = 18
          ExplicitWidth = 214
        end
      end
    end
    object tbTransfereEstorna: TcxTabSheet
      Caption = 'Estorna'
      ImageIndex = 2
      OnShow = tbTransfereEstornaShow
      ExplicitLeft = 72
      object dbgrd1: TDBGrid
        Left = 38
        Top = 91
        Width = 483
        Height = 168
        DataSource = ds1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = dbgrd1DblClick
        Columns = <
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'DATA_MOVIMENTO'
            Title.Alignment = taRightJustify
            Title.Caption = 'DATA'
            Width = 80
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'VALOR'
            Title.Alignment = taRightJustify
            Width = 80
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'IDENTIFICACAO'
            Title.Alignment = taRightJustify
            Width = 90
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'CONTA'
            Title.Alignment = taRightJustify
            Width = 80
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'CHEQUE'
            Title.Alignment = taRightJustify
            Width = 80
            Visible = True
          end>
      end
      inline frmPeriodo1: TfrmPeriodo
        Left = 19
        Top = 16
        Width = 257
        Height = 74
        TabOrder = 1
        ExplicitLeft = 19
        ExplicitTop = 16
        ExplicitWidth = 257
        ExplicitHeight = 74
        inherited lbl1: TLabel
          Top = 7
          ExplicitTop = 7
        end
        inherited lbl2: TLabel
          Top = 7
          ExplicitTop = 7
        end
        inherited dtpDataInicial: TDateTimePicker
          Top = 32
          ExplicitTop = 32
        end
        inherited dtpDataFinal: TDateTimePicker
          Top = 32
          ExplicitTop = 32
        end
      end
      object btnPesquisa: TBitBtn
        Left = 312
        Top = 18
        Width = 137
        Height = 25
        Caption = 'Buscar'
        TabOrder = 2
        OnClick = btnPesquisaClick
      end
      object edtLoteContabil: TcxTextEdit
        Left = 728
        Top = 91
        Enabled = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 3
        Width = 145
      end
      object cxLabel3: TcxLabel
        Left = 657
        Top = 95
        Caption = 'Lote cont'#225'bil'
      end
      object edtIdentificaCBD: TcxTextEdit
        Left = 728
        Top = 118
        Enabled = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 5
        Width = 145
      end
      object edtNumCheque: TcxTextEdit
        Left = 728
        Top = 145
        Enabled = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 6
        Width = 145
      end
      object cxLabel4: TcxLabel
        Left = 657
        Top = 122
        Caption = 'Identificador'
      end
      object cxLabel6: TcxLabel
        Left = 681
        Top = 145
        Caption = 'Cheque'
      end
      object edtIdentTC: TcxTextEdit
        Left = 728
        Top = 172
        Enabled = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 9
        Width = 145
      end
      object cxLabel7: TcxLabel
        Left = 677
        Top = 175
        Caption = 'ID Caixa'
      end
      object dxStatusBarEstorna: TdxStatusBar
        Left = 0
        Top = 287
        Width = 884
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
      object btnImprimir: TBitBtn
        Left = 736
        Top = 199
        Width = 137
        Height = 26
        Caption = 'Imprimir'
        Enabled = False
        TabOrder = 12
        Visible = False
        OnClick = btnImprimirClick
      end
      object btnFechar: TBitBtn
        Left = 312
        Top = 49
        Width = 137
        Height = 26
        Caption = 'Fechar'
        TabOrder = 13
        OnClick = btnFecharClick
      end
    end
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
    Left = 752
    Top = 48
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Transferir'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 918
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnTrfConfirma'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Estornar'
      CaptionButtons = <>
      DockedLeft = 79
      DockedTop = 0
      FloatLeft = 918
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnTrfEstorna'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Relat'#243'rio'
      CaptionButtons = <>
      DockedLeft = 147
      DockedTop = 0
      FloatLeft = 918
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxbrlrgbtn3'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'Limpar'
      CaptionButtons = <>
      DockedLeft = 219
      DockedTop = 0
      FloatLeft = 918
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxbrlrgbtn2'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar5: TdxBar
      Caption = 'Cancelar'
      CaptionButtons = <>
      DockedLeft = 281
      DockedTop = 0
      FloatLeft = 918
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxbrlrgbtn1'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxbrlrgbtn1: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxbrlrgbtn1Click
    end
    object dxbrlrgbtn2: TdxBarLargeButton
      Caption = 'Limpar'
      Category = 0
      Hint = 'Limpar'
      Visible = ivAlways
      OnClick = dxbrlrgbtn2Click
    end
    object dxbrlrgbtn3: TdxBarLargeButton
      Caption = 'Relat'#243'rio'
      Category = 0
      Hint = 'Relat'#243'rio'
      Visible = ivAlways
      OnClick = dxbrlrgbtn3Click
    end
    object dxBtnTrfEstorna: TdxBarLargeButton
      Caption = 'Estornar'
      Category = 0
      Hint = 'Estornar'
      Visible = ivAlways
      OnClick = dxBtnTrfEstornaClick
    end
    object dxBtnTrfConfirma: TdxBarLargeButton
      Caption = 'Confirmar'
      Category = 0
      Hint = 'Confirmar transfer'#234'ncia'
      Visible = ivAlways
      OnClick = dxBtnTrfConfirmaClick
    end
    object dxBtnTrfEspecie: TdxBarLargeButton
      Caption = 'Esp'#233'cie'
      Category = 0
      Hint = 'Esp'#233'cie'
      Visible = ivAlways
    end
  end
  object ds1: TDataSource
    DataSet = dmTransfBancoCaixa.qryObterCBD
    OnDataChange = ds1DataChange
    Left = 208
    Top = 317
  end
  object frxRelatorioTRFBCOCX: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43797.367022129630000000
    ReportOptions.LastChange = 43797.367022129630000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 528
    Top = 189
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBCBD'
    CloseDataSource = False
    FieldAliases.Strings = (
      'IDCBD=IDCBD'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'ID_TIPO_OPERACAO_BANCARIA=ID_TIPO_OPERACAO_BANCARIA'
      'ID_RESPONSAVEL=ID_RESPONSAVEL'
      'ID_CONTA_BANCARIA_CHEQUE=ID_CONTA_BANCARIA_CHEQUE'
      'TIPO_LANCAMENTO=TIPO_LANCAMENTO'
      'OBSERVACAO=OBSERVACAO'
      'DESCRICAO=DESCRICAO'
      'VALOR=VALOR'
      'DATA_REGISTRO=DATA_REGISTRO'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'IDENTIFICACAO=IDENTIFICACAO'
      'ID_LOTE_CONTABIL=ID_LOTE_CONTABIL'
      'CONTA=CONTA'
      'CHEQUE=CHEQUE')
    DataSet = dmTransfBancoCaixa.qryObterCBD
    BCDToCurrency = False
    Left = 576
    Top = 245
  end
  object frxDBDataset2: TfrxDBDataset
    UserName = 'frxDBTC'
    CloseDataSource = False
    FieldAliases.Strings = (
      'IDTC=IDTC'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DATA_CONTABIL=DATA_CONTABIL'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'VALOR_NOMINAL=VALOR_NOMINAL'
      'OBSERVACAO=OBSERVACAO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'DESCRICAO=DESCRICAO'
      'TIPO_LANCAMENTO=TIPO_LANCAMENTO'
      'ID_CONTA_BANCARIA_DEBITO=ID_CONTA_BANCARIA_DEBITO')
    DataSet = dmTransfBancoCaixa.qryObterTC
    BCDToCurrency = False
    Left = 592
    Top = 309
  end
  object frxDBDataset3: TfrxDBDataset
    UserName = 'frxDBCheque'
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
      'QTD_IMPRESSAO=QTD_IMPRESSAO')
    DataSet = dmTransfBancoCaixa.qryChequePorID
    BCDToCurrency = False
    Left = 608
    Top = 365
  end
  object EvExtenso1: TEvExtenso
    Currency.Strings = (
      'real'
      'reais'
      'centavo'
      'centavos')
    Left = 712
    Top = 165
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
    Left = 648
    Top = 64
  end
end
