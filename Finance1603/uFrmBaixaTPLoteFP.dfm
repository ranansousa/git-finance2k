object frmBaixaTPLoteFP: TfrmBaixaTPLoteFP
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Baixa de t'#237'tulos a pagar lote'
  ClientHeight = 575
  ClientWidth = 676
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lbl7: TLabel
    Left = 227
    Top = 205
    Width = 59
    Height = 16
    Caption = 'Valor total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl10: TLabel
    Left = 467
    Top = 8
    Width = 94
    Height = 16
    Caption = 'Data pagamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 24
    Top = 205
    Width = 28
    Height = 16
    Caption = 'Lote '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 555
    Width = 676
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 200
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 200
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ExplicitTop = 561
  end
  object edtValorLote: TEvNumEdit
    Left = 306
    Top = 203
    Width = 137
    Height = 21
    Enabled = False
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
    TabOrder = 2
  end
  object dtpPagto: TDateTimePicker
    Left = 467
    Top = 30
    Width = 137
    Height = 21
    Date = 43842.811710069450000000
    Time = 43842.811710069450000000
    TabOrder = 0
  end
  inline frameResponsavel1: TframeResponsavel
    Left = 461
    Top = 72
    Width = 216
    Height = 56
    TabOrder = 3
    ExplicitLeft = 461
    ExplicitTop = 72
    ExplicitWidth = 216
    ExplicitHeight = 56
    inherited lblID: TLabel
      Left = 59
      Top = 38
      ExplicitLeft = 59
      ExplicitTop = 38
    end
    inherited lblResponsavel: TLabel
      Left = 8
      Top = 3
      Width = 71
      Height = 16
      Font.Height = -13
      ParentFont = False
      ExplicitLeft = 8
      ExplicitTop = 3
      ExplicitWidth = 71
      ExplicitHeight = 16
    end
    inherited cbbcombo: TComboBox
      Left = 8
      Top = 25
      Width = 193
      OnChange = frameResponsavel1cbbcomboChange
      ExplicitLeft = 8
      ExplicitTop = 25
      ExplicitWidth = 193
    end
    inherited qryObterPorID: TFDQuery
      Left = 56
      Top = 32
    end
    inherited qryObterTodos: TFDQuery
      Left = 112
      Top = 16
    end
  end
  object cxpgcntrlFP: TcxPageControl
    Left = 0
    Top = 240
    Width = 676
    Height = 315
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
    Properties.ActivePage = tbTransfereFP
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 315
    ClientRectRight = 676
    ClientRectTop = 24
    object tbTransfereFP: TcxTabSheet
      Caption = 'Pagamento'
      ImageIndex = 0
      OnShow = tbTransfereFPShow
      object lbl2: TLabel
        Left = 17
        Top = 12
        Width = 102
        Height = 13
        Caption = 'Forma de pagamento'
      end
      object lbl1: TLabel
        Left = 322
        Top = 12
        Width = 24
        Height = 13
        Caption = 'Valor'
      end
      inline frmFormaPagto1: TfrmFormaPagto
        Left = 16
        Top = 31
        Width = 254
        Height = 35
        TabOrder = 0
        ExplicitLeft = 16
        ExplicitTop = 31
        ExplicitWidth = 254
        inherited cbbcombo: TComboBox
          Width = 200
          ExplicitWidth = 200
        end
      end
      object dbgrdFP: TDBGrid
        Left = 23
        Top = 72
        Width = 444
        Height = 120
        DataSource = dsGridFP
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clGray
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Title.Caption = 'FORMA DE PAGAMENTO'
            Width = 300
            Visible = True
          end
          item
            Color = clMoneyGreen
            Expanded = False
            FieldName = 'VALOR'
            Width = 120
            Visible = True
          end>
      end
      object edtValorPago: TEvNumEdit
        Left = 322
        Top = 31
        Width = 121
        Height = 21
        Enabled = False
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
        TabOrder = 2
      end
      object btnCancelar: TButton
        Left = 473
        Top = 116
        Width = 121
        Height = 21
        Caption = 'Cancelar'
        TabOrder = 3
        OnClick = btnCancelarClick
      end
      object btnCheque: TButton
        Left = 186
        Top = 198
        Width = 100
        Height = 33
        Caption = 'CHEQUE (F7)'
        TabOrder = 4
        OnClick = btnChequeClick
      end
      object btnDin: TButton
        Left = 21
        Top = 198
        Width = 100
        Height = 33
        Caption = 'DIN (F6)'
        TabOrder = 5
        OnClick = btnDinClick
      end
      object btnLimpar: TButton
        Left = 473
        Top = 76
        Width = 121
        Height = 21
        Caption = 'Limpar'
        TabOrder = 6
        OnClick = btnLimparClick
      end
      object btnSelect: TButton
        Left = 473
        Top = 34
        Width = 121
        Height = 21
        Caption = 'Selecionar'
        TabOrder = 7
        OnClick = btnSelectClick
      end
      object btnWEB: TButton
        Left = 363
        Top = 198
        Width = 100
        Height = 33
        Caption = 'BANK LINE (F8)'
        TabOrder = 8
        OnClick = btnWEBClick
      end
      object btnPagamento: TButton
        Left = 0
        Top = 258
        Width = 676
        Height = 33
        Align = alBottom
        Caption = 'PAGAMENTO  (F10)'
        TabOrder = 9
        OnClick = btnPagamentoClick
      end
    end
  end
  object dbgridMain: TDBGrid
    Left = 0
    Top = 0
    Width = 463
    Height = 189
    DataSource = dtTitulos
    Options = [dgTitles, dgIndicator, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgridMainTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_TITULO_PAGAR'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ID_ORGANIZACAO'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'FORNECEDOR'
        Title.Alignment = taCenter
        Width = 200
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'NUMERO_DOCUMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'DOCUMENTO'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALOR_NOMINAL'
        Title.Alignment = taCenter
        Title.Caption = 'VALOR'
        Width = 120
        Visible = True
      end>
  end
  object btnGerarLote: TBitBtn
    Left = 469
    Top = 201
    Width = 192
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 6
    OnClick = btnGerarLoteClick
  end
  object edtLotePagamento: TEdit
    Left = 83
    Top = 203
    Width = 121
    Height = 21
    TabOrder = 7
  end
  object fdmFP: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 608
    Top = 376
  end
  object dsGridFP: TDataSource
    AutoEdit = False
    DataSet = fdmFP
    Left = 608
    Top = 424
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
    Left = 608
    Top = 472
  end
  object dtTitulos: TDataSource
    AutoEdit = False
    DataSet = FDQuery1
    Left = 168
    Top = 88
  end
  object FDQuery1: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TP.ID_TITULO_PAGAR,'
      '       TP.ID_ORGANIZACAO, '
      '       C.NOME as fornecedor,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.VALOR_NOMINAL, '
      '       TP.DATA_VENCIMENTO'
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      '       AND   (TP.ID_TIPO_STATUS = '#39'ABERTO'#39')'
      '       AND   (TP.DATA_VENCIMENTO <= current_date )'
      '       ORDER BY DATA_VENCIMENTO DESC')
    Left = 240
    Top = 88
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
