object frmAlteraNumDocTR: TfrmAlteraNumDocTR
  Left = 0
  Top = 0
  Caption = 'Altera N'#250'mero Documento T'#237'tulo Receber'
  ClientHeight = 475
  ClientWidth = 895
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dbgrdTR: TDBGrid
    Left = 12
    Top = 2
    Width = 612
    Height = 473
    DataSource = ds1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMERO_DOCUMENTO'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Width = 350
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_NOMINAL'
        Title.Caption = 'VALOR DO TITULO'
        Visible = True
      end>
  end
  object btnConsulta: TButton
    Left = 658
    Top = 24
    Width = 87
    Height = 25
    Caption = 'Atualizar'
    TabOrder = 1
    OnClick = btnConsultaClick
  end
  object btnFechar: TBitBtn
    Left = 783
    Top = 24
    Width = 87
    Height = 25
    Caption = 'Fechar'
    TabOrder = 2
    OnClick = btnFecharClick
  end
  object qryObterTR: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'dd/mm/yyyy'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TR.NUMERO_DOCUMENTO, TR.DESCRICAO, TR.VALOR_NOMINAL'
      ''
      'FROM TITULO_RECEBER TR'
      ''
      'WHERE (TR.ID_ORGANIZACAO = :PIDORG ) '
      '   AND (TR.ID_TIPO_STATUS <> '#39'EXCLUIDO'#39') '
      ''
      'ORDER BY TR.NUMERO_DOCUMENTO')
    Left = 760
    Top = 136
    ParamData = <
      item
        Name = 'PIDORG'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object ds1: TDataSource
    DataSet = qryObterTR
    Left = 752
    Top = 256
  end
end
