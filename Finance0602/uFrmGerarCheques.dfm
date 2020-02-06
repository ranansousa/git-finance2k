object frmGerarCheques: TfrmGerarCheques
  Left = 0
  Top = 0
  Caption = 'Gerar cheques por conta banc'#225'ria'
  ClientHeight = 294
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
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 884
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 3
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Gerador de cheques'#13#10
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
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
  object dxstsbrStatus: TdxStatusBar
    Left = 0
    Top = 274
    Width = 884
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.Alignment = taCenter
        Width = 89
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
  inline frmContaBancaria1: TfrmContaBancaria
    Left = 8
    Top = 131
    Width = 243
    Height = 62
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 131
    ExplicitHeight = 62
    inherited cbbConta: TComboBox
      Tag = 1
      OnChange = frmContaBancaria1cbbContaChange
    end
    inherited qryObterTodos: TFDQuery
      Left = 136
      Top = 16
    end
    inherited qryObterContaContabil: TFDQuery
      Top = 8
    end
  end
  object edtContaContabil: TcxTextEdit
    Left = 24
    Top = 219
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
    Width = 227
  end
  object cxLabel10: TcxLabel
    Left = 24
    Top = 196
    Caption = 'Conta cont'#225'bil'
  end
  object edtChequeInicial: TEdit
    Tag = 1
    Left = 288
    Top = 150
    Width = 129
    Height = 21
    TabOrder = 1
    Text = 'edtChequeInicial'
  end
  object cxLabel1: TcxLabel
    Left = 288
    Top = 127
    Caption = 'Cheque Inicial'
  end
  object edtQtd: TEdit
    Tag = 1
    Left = 448
    Top = 150
    Width = 81
    Height = 21
    Hint = 'Digite a quantidade de folhas de cheques a serem geradas.'
    Color = 10930928
    MaxLength = 99
    NumbersOnly = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = 'edtQtd'
  end
  object cxLabel2: TcxLabel
    Left = 448
    Top = 131
    Caption = 'Quantidade'
  end
  inline frameResponsavel1: TframeResponsavel
    Left = 288
    Top = 196
    Width = 249
    Height = 60
    TabOrder = 13
    ExplicitLeft = 288
    ExplicitTop = 196
    ExplicitWidth = 249
    ExplicitHeight = 60
    inherited cbbcombo: TComboBox
      Top = 23
      Width = 238
      OnChange = frameResponsavel1cbbcomboChange
      ExplicitTop = 23
      ExplicitWidth = 238
    end
    inherited qryObterPorID: TFDQuery
      Top = 32
    end
    inherited qryObterTodos: TFDQuery
      Top = 32
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
    Left = 800
    Top = 64
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Gerar'#13#10
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
          ItemName = 'dxBtnGerar'
        end>
      OneOnRow = True
      Row = 2
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Limpar'
      CaptionButtons = <>
      DockedLeft = 53
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
      OneOnRow = True
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Fechar'
      CaptionButtons = <>
      DockedLeft = 115
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
      OneOnRow = True
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
      OnClick = dxBtnGerarClick
    end
  end
end
