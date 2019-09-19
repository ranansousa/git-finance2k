object frmPendentes: TfrmPendentes
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Titulos a Receber Pendentes'
  ClientHeight = 556
  ClientWidth = 1848
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FoTOrmShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 1848
    Height = 497
    Align = alTop
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CNPJ'
        Width = 110
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALOR'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALOR_PAGO'
        Title.Caption = 'VALOR PAGO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_VCTO'
        Title.Caption = 'VENCIMENTO'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_PAGTO'
        Title.Caption = 'PAGTO'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_PROTOCOLO'
        Title.Caption = 'PROTOCOLO'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRODUTO'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTA'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SACADO'
        Title.Caption = 'CHAVE SACADO'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HISTORICO'
        Title.Caption = 'CHAVE HISTORICO'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CENTRO_CUSTO'
        Title.Caption = 'CHAVE CENTRO DE CUSTO'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTA_BANCARIA'
        Title.Caption = 'CHAVE CONTA BANCARIA'
        Width = 150
        Visible = True
      end>
  end
  object btnFechar: TBitBtn
    Left = 1752
    Top = 526
    Width = 75
    Height = 25
    Caption = 'Fechar'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 1
  end
  object btnRefresh: TBitBtn
    Left = 624
    Top = 526
    Width = 473
    Height = 25
    Caption = 'Atualizar Base de Dados'
    TabOrder = 2
    OnClick = btnRefreshClick
  end
end
