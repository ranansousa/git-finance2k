object formEspelhoTR: TformEspelhoTR
  Left = 0
  Top = 0
  Caption = 'Espelho de t'#237'tulo a receber'
  ClientHeight = 286
  ClientWidth = 629
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
  object lblDescricao: TLabel
    Left = 24
    Top = 120
    Width = 67
    Height = 19
    Caption = 'Descricao'
  end
  object lbl1: TLabel
    Left = 328
    Top = 117
    Width = 37
    Height = 19
    Caption = 'Valor'
  end
  object btnBuscar: TBitBtn
    Left = 328
    Top = 8
    Width = 153
    Height = 25
    Caption = 'Buscar'
    TabOrder = 0
    OnClick = btnBuscarClick
  end
  object edtValor: TEvNumEdit
    Left = 328
    Top = 145
    Width = 153
    Height = 27
    Enabled = False
    EnabledBtn = False
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
  object edtDescricao: TEvEditBtn
    Left = 24
    Top = 145
    Width = 281
    Height = 27
    Enabled = False
    EnabledBtn = False
    Glyph.Data = {
      12010000424D120100000000000036000000280000000B000000050000000100
      200000000000DC00000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C0000000000000000000C0C0C0000000000000000000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C0000000000000000000C0C0C000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
    TabOrder = 2
    Text = 'edtDescricao'
  end
  object btnFechar: TBitBtn
    Left = 328
    Top = 77
    Width = 153
    Height = 25
    Caption = 'Fechar'
    TabOrder = 3
    OnClick = btnFecharClick
  end
  object btnImprimir: TBitBtn
    Left = 328
    Top = 43
    Width = 153
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 4
    OnClick = btnImprimirClick
  end
  object statStatusEsp: TStatusBar
    Left = 0
    Top = 267
    Width = 629
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 400
      end>
  end
  inline frameTR1: TframeTR
    Left = 8
    Top = 8
    Width = 297
    Height = 58
    TabOrder = 6
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 297
    inherited redt1: TRichEdit
      Width = 297
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 297
    end
    inherited cbbTR: TComboBox
      Height = 27
      ExplicitHeight = 27
    end
  end
  object qryBusca: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    SQL.Strings = (
      'SELECT TP.ID_TITULO_RECEBER,'
      '       TP.ID_ORGANIZACAO,'
      '       TP.ID_SACADO,'
      '       TP.ID_HISTORICO,'
      '       TP.ID_CENTRO_CUSTO,'
      '       TP.ID_TIPO_STATUS,'
      '       TP.ID_TIPO_COBRANCA,'
      '       TP.ID_RESPONSAVEL,'
      '       TP.ID_LOCAL_PAGAMENTO,'
      '       TP.ID_TITULO_GERADOR,'
      '       TP.ID_LOTE_CONTABIL,'
      '     --  TP.ID_LOTE_PAGAMENTO,'
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
      '       TP.ID_LOTE_TRB,'
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
      'FROM TITULO_RECEBER TP'
      
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
      
        'WHERE ((TP.numero_documento = :PNUMDOC) OR (TP.ID_TITULO_RECEBER' +
        ' = :PIDTR))'
      'AND    (TP.ID_ORGANIZACAO   = :PIDORGANIZACAO);'
      ''
      '')
    Left = 184
    Top = 81
    ParamData = <
      item
        Name = 'PNUMDOC'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end
      item
        Name = 'PIDTR'
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
end
