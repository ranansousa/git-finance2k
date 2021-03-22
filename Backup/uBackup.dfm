object FrmBackup: TFrmBackup
  Left = 549
  Top = 309
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Manuten'#231#227'o do Banco de Dados'
  ClientHeight = 594
  ClientWidth = 1010
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
  object lblAviso: TLabel
    Left = 0
    Top = 556
    Width = 1010
    Height = 19
    Align = alBottom
    Caption = 'lblAviso'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    ExplicitWidth = 64
  end
  object Label1: TLabel
    Left = 8
    Top = 375
    Width = 146
    Height = 14
    Caption = 'Pempec Enterprise Backup'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMoneyGreen
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object SpeedButton1: TSpeedButton
    Left = 368
    Top = 296
    Width = 23
    Height = 22
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1010
    Height = 74
    Align = alTop
    TabOrder = 2
    object lblPrincipal: TLabel
      Left = 169
      Top = 26
      Width = 280
      Height = 19
      Caption = 'REALIZA BACKUP DA BASE DE DADOS'
      Color = clCream
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 575
    Width = 1010
    Height = 19
    Color = clMoneyGreen
    Panels = <
      item
        Text = 'Status : '
        Width = 50
      end
      item
        Width = 300
      end>
  end
  object PageControl1: TPageControl
    Left = -2
    Top = 80
    Width = 979
    Height = 417
    ActivePage = tbAgenda
    Align = alCustom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object tbsBackup: TTabSheet
      Caption = 'Backup'
      OnShow = tbsBackupShow
      DesignSize = (
        971
        389)
      object lblEmailOff: TLabel
        Left = 389
        Top = 160
        Width = 157
        Height = 16
        Caption = 'Envio de Email Desativado.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object btnBackup: TButton
        Left = 538
        Top = 51
        Width = 119
        Height = 31
        Caption = 'Backup'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnBackupClick
      end
      object edtOrigem: TLabeledEdit
        Left = 17
        Top = 56
        Width = 488
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        EditLabel.Width = 89
        EditLabel.Height = 13
        EditLabel.Caption = 'Arquivo de Origem'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object btnOrigem: TBitBtn
        Left = 693
        Top = 51
        Width = 119
        Height = 31
        Anchors = [akTop, akRight]
        Caption = 'Pesquisar Arquivo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnOrigemClick
      end
      object edtDestino: TLabeledEdit
        Left = 17
        Top = 108
        Width = 488
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        EditLabel.Width = 155
        EditLabel.Height = 13
        EditLabel.Caption = 'Pasta de destino do arquivo FBK'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object btnDestino: TBitBtn
        Left = 538
        Top = 103
        Width = 119
        Height = 31
        Caption = 'Destino '
        TabOrder = 4
        OnClick = btnDestinoClick
      end
      object btnSalvar: TBitBtn
        Left = 693
        Top = 103
        Width = 119
        Height = 31
        Caption = 'Salvar'
        TabOrder = 5
        OnClick = btnSalvarClick
      end
      object chkEmail: TCheckBox
        Left = 235
        Top = 148
        Width = 97
        Height = 17
        Caption = 'Enviar Email'
        TabOrder = 6
      end
      object chkZipar: TCheckBox
        Left = 121
        Top = 148
        Width = 97
        Height = 17
        Caption = 'Compactar'
        TabOrder = 7
      end
      object chkFechaApp: TCheckBox
        Left = 18
        Top = 148
        Width = 97
        Height = 17
        Caption = 'Fechar Ap'#243's'
        TabOrder = 8
      end
    end
    object tabExport: TTabSheet
      Caption = 'Exporta'#231#227'o'
      ImageIndex = 4
      OnShow = tabExportShow
      DesignSize = (
        971
        389)
      object lblStatusExport: TLabel
        Left = 17
        Top = 13
        Width = 88
        Height = 13
        Caption = 'Analisando dados.'
      end
      object Label12: TLabel
        Left = 17
        Top = 197
        Width = 37
        Height = 13
        Caption = 'Label12'
      end
      object lblBaseDados: TLabel
        Left = 17
        Top = 224
        Width = 63
        Height = 13
        Caption = 'lblBaseDados'
      end
      object edtFileExport: TLabeledEdit
        Left = 17
        Top = 48
        Width = 659
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        EditLabel.Width = 117
        EditLabel.Height = 13
        EditLabel.Caption = 'Arquivo a ser exportado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object btnLocateExport: TBitBtn
        Left = 709
        Top = 43
        Width = 119
        Height = 31
        Anchors = [akTop, akRight]
        Caption = 'Localizar Arquivo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnOrigemClick
      end
      object Memo1: TMemo
        Left = 17
        Top = 80
        Width = 379
        Height = 47
        Lines.Strings = (
          'Memo1')
        TabOrder = 2
      end
      object btnCheckExport: TBitBtn
        Left = 429
        Top = 86
        Width = 119
        Height = 31
        Caption = 'Analisar'
        TabOrder = 3
        OnClick = btnCheckExportClick
      end
      object btnExportar: TBitBtn
        Left = 429
        Top = 123
        Width = 119
        Height = 31
        Caption = 'Exportar'
        TabOrder = 4
        OnClick = btnExportarClick
      end
      object btnPendentes: TBitBtn
        Left = 429
        Top = 160
        Width = 119
        Height = 31
        Caption = 'Pend'#234'ncias'
        TabOrder = 5
        OnClick = btnPendentesClick
      end
    end
    object tbsRestore: TTabSheet
      Caption = 'Restore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      OnShow = tbsRestoreShow
      DesignSize = (
        971
        389)
      object Label3: TLabel
        Left = 16
        Top = 91
        Width = 251
        Height = 19
        Caption = 'ATEN'#199#195'O: Esta opera'#231#227'o '#233' irrevers'#237'vel.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
      end
      object ledAttachment: TLabeledEdit
        Left = 16
        Top = 64
        Width = 431
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        EditLabel.Width = 117
        EditLabel.Height = 13
        EditLabel.Caption = 'Localizar arquivo backup'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object btnAttachment: TBitBtn
        Left = 473
        Top = 59
        Width = 138
        Height = 31
        Anchors = [akTop, akRight]
        Caption = 'Pesquisar Arquivo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnAttachmentClick
      end
      object btnRestore: TButton
        Left = 473
        Top = 112
        Width = 138
        Height = 31
        Caption = 'Restore'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnRestoreClick
      end
    end
    object tbAgenda: TTabSheet
      Caption = 'Agendamento'
      ImageIndex = 2
      OnShow = tbAgendaShow
      object Label10: TLabel
        Left = 33
        Top = 41
        Width = 32
        Height = 13
        Caption = 'HORA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 85
        Top = 41
        Width = 22
        Height = 13
        Caption = 'MIN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 137
        Top = 41
        Width = 21
        Height = 13
        Caption = 'SEG'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 286
        Top = 41
        Width = 67
        Height = 13
        Caption = 'Agendamento'
      end
      object Label4: TLabel
        Left = 286
        Top = 93
        Width = 51
        Height = 13
        Caption = 'Hora Atual'
      end
      object chkDesliga: TCheckBox
        Left = 33
        Top = 108
        Width = 248
        Height = 17
        Caption = 'Desligar ap'#243's Backup'
        TabOrder = 0
      end
      object spinHora: TSpinEdit
        Left = 33
        Top = 60
        Width = 46
        Height = 26
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clInfoBk
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 23
        MinValue = 1
        ParentFont = False
        TabOrder = 1
        Value = 1
      end
      object spinMin: TSpinEdit
        Left = 85
        Top = 60
        Width = 46
        Height = 26
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clInfoBk
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 60
        MinValue = 0
        ParentFont = False
        TabOrder = 2
        Value = 0
      end
      object spinSeg: TSpinEdit
        Left = 137
        Top = 60
        Width = 46
        Height = 26
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clInfoBk
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 60
        MinValue = 0
        ParentFont = False
        TabOrder = 3
        Value = 0
      end
      object btnAgendar: TButton
        Left = 33
        Top = 148
        Width = 125
        Height = 25
        Caption = 'Agendar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = btnAgendarClick
      end
      object edtHoraAtual: TEdit
        Left = 286
        Top = 112
        Width = 67
        Height = 21
        TabOrder = 5
        Text = 'edtHoraAgendada'
      end
      object edtHrAgendada: TEdit
        Left = 286
        Top = 62
        Width = 67
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Text = 'edtHoraAgendada'
      end
    end
    object tbConfig: TTabSheet
      Caption = 'Config'
      ImageIndex = 3
      OnShow = tbConfigShow
      object Label5: TLabel
        Left = 24
        Top = 19
        Width = 22
        Height = 13
        Caption = 'Host'
      end
      object Label6: TLabel
        Left = 257
        Top = 19
        Width = 36
        Height = 13
        Caption = 'Usu'#225'rio'
      end
      object lbSenha: TLabel
        Left = 257
        Top = 75
        Width = 30
        Height = 13
        Caption = 'Senha'
      end
      object Label7: TLabel
        Left = 24
        Top = 75
        Width = 26
        Height = 13
        Caption = 'Porta'
      end
      object Label11: TLabel
        Left = 24
        Top = 133
        Width = 22
        Height = 13
        Caption = 'Para'
      end
      object edtHost: TEdit
        Left = 24
        Top = 38
        Width = 193
        Height = 21
        CharCase = ecLowerCase
        Enabled = False
        TabOrder = 0
        Text = 'edthost'
      end
      object edtPorta: TEdit
        Left = 24
        Top = 94
        Width = 61
        Height = 21
        TabOrder = 1
        Text = 'Edit1'
      end
      object edtUser: TEdit
        Left = 257
        Top = 38
        Width = 187
        Height = 21
        CharCase = ecLowerCase
        TabOrder = 2
        Text = 'edit1'
      end
      object edtDestinoUm: TEdit
        Left = 24
        Top = 160
        Width = 421
        Height = 21
        TabOrder = 3
        Text = 'edtDestinoUm'
        OnChange = edtDestinoUmChange
      end
      object btnSalvarConfig: TButton
        Left = 504
        Top = 92
        Width = 75
        Height = 25
        Caption = 'Confirmar'
        TabOrder = 4
        OnClick = btnSalvarConfigClick
      end
      object chAutentica: TCheckBox
        Left = 91
        Top = 92
        Width = 126
        Height = 21
        Caption = 'Requer Autentica'#231#227'o'
        TabOrder = 5
      end
      object btnSalvaDestino: TButton
        Left = 504
        Top = 160
        Width = 75
        Height = 25
        Caption = 'Confirmar'
        TabOrder = 6
        OnClick = btnSalvaDestinoClick
      end
      object edtPassword: TMaskEdit
        Left = 258
        Top = 94
        Width = 187
        Height = 21
        PasswordChar = '*'
        TabOrder = 7
        Text = 'edtPassword'
      end
    end
    object tbRelatorios: TTabSheet
      Caption = 'Relat'#243'rios'
      ImageIndex = 5
      OnShow = tbRelatoriosShow
      object btnRelContaPagar: TButton
        Left = 3
        Top = 24
        Width = 273
        Height = 25
        Caption = 'Relat'#243'rio Contas '#224'  Pagar'
        TabOrder = 0
        OnClick = btnRelContaPagarClick
      end
    end
    object tbsImport: TTabSheet
      Caption = 'Importa'#231#227'o'
      ImageIndex = 6
      OnShow = tbsImportShow
      object lblStatusSistemaContabil: TLabel
        Left = 16
        Top = 3
        Width = 79
        Height = 13
        Caption = 'Sistema Cont'#225'bil'
      end
      object Label13: TLabel
        Left = 111
        Top = 37
        Width = 89
        Height = 13
        Caption = 'Mes de Refer'#234'ncia'
      end
      object Label14: TLabel
        Left = 16
        Top = 37
        Width = 89
        Height = 13
        Caption = 'Ano de Refer'#234'ncia'
      end
      object Label15: TLabel
        Left = 222
        Top = 37
        Width = 63
        Height = 13
        Caption = 'Lote Definido'
      end
      object lblGeneratorID: TLabel
        Left = 496
        Top = 31
        Width = 70
        Height = 13
        Caption = 'lblGeneratorID'
      end
      object Label16: TLabel
        Left = 291
        Top = 35
        Width = 53
        Height = 13
        Caption = 'Data Inicial'
      end
      object Label17: TLabel
        Left = 391
        Top = 35
        Width = 48
        Height = 13
        Caption = 'Data Final'
      end
      object imgGreen: TImage
        Left = 572
        Top = 50
        Width = 89
        Height = 27
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000A00000
          00CB0803000000DE22688600000003504C54454DE63368CC1635000000D44944
          415478DAEDCE010D003008C0B0E3DFF4650C925641E72D37754050B00E080AD6
          0141C13A202858070405EB80A0601D1014AC038282754050B00E080AD60141C1
          3A202858070405EB80A0601D1014AC038282754050B00E080AD60141C13A2028
          58070405EB80A0601D1014AC038282754050B00E080AD60141C13A2028580704
          05EB80A0601D1014AC038282754050B00E080AD60141C13A202858070405EB80
          A0601D1014AC038282754050B00E080AD60141C13A202858070405EB80A0601D
          1014AC038282754050B00E080AD681F3C10F60CA00CCD5E7F846000000004945
          4E44AE426082}
        Transparent = True
      end
      object lblStatusExp: TLabel
        Left = 572
        Top = 31
        Width = 89
        Height = 13
        Caption = 'Status Exporta'#231#227'o'
      end
      object imgRed: TImage
        Left = 572
        Top = 83
        Width = 89
        Height = 27
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000A00000
          00CB0806000000E9FC98B4000000017352474200AECE1CE90000000467414D41
          0000B18F0BFC6105000000097048597300000EC400000EC401952B0E1B000002
          014944415478DAEDD231010020100021BF87A3FD9B994163DC021998BBCF5B10
          19012909484A4052029212909480A40424252029014909484A40520292129094
          80A40424252029014909484A4052029212909480A40424252029014909484A40
          52029212909480A40424252029014909484A4052029212909480A40424252029
          014909484A4052029212909480A40424252029014909484A4052029212909480
          A40424252029014909484A4052029212909480A40424252029014909484A4052
          029212909480A40424252029014909484A4052029212909480A4042425202901
          4909484A4052029212909480A40424252029014909484A4052029212909480A4
          0424252029014909484A4052029212909480A40424252029014909484A405202
          9212909480A40424252029014909484A4052029212909480A404242520290149
          09484A4052029212909480A40424252029014909484A4052029212909480A404
          24252029014909484A4052029212909480A40424252029014909484A40520292
          12909480A40424252029014909484A4052029212909480A40424252029014909
          484A4052029212909480A40424252029014909484A4052029212909480A40424
          252029014909484A4052029212909480A40424252029014909484A4052029212
          909480A40424252029014909484A4052029212909480A4042425202901490948
          EA03B53AB9BFA4EB5CCD0000000049454E44AE426082}
        Transparent = True
      end
      object lblIdOrganizacao: TLabel
        Left = 17
        Top = 373
        Width = 172
        Height = 13
        Caption = 'Nenhuma Organiza'#231#227'o Selecionada.'
      end
      object Label18: TLabel
        Left = 128
        Top = 97
        Width = 69
        Height = 13
        Caption = 'Titulo Receber'
      end
      object Label19: TLabel
        Left = 17
        Top = 97
        Width = 57
        Height = 13
        Caption = 'Titulo Pagar'
      end
      object lblHistoricoSemConta: TLabel
        Left = 394
        Top = 3
        Width = 3
        Height = 13
      end
      object btnGeraLote: TButton
        Left = 491
        Top = 50
        Width = 75
        Height = 25
        Caption = 'Confirmar'
        TabOrder = 0
        OnClick = btnGeraLoteClick
      end
      object edtLote: TEdit
        Left = 222
        Top = 56
        Width = 63
        Height = 21
        Hint = 'Digite o n'#250'mero do lote.'
        TabOrder = 1
      end
      object cbxMesLote: TComboBox
        Left = 111
        Top = 56
        Width = 105
        Height = 21
        TabOrder = 2
        OnChange = cbxMesLoteChange
        Items.Strings = (
          'Selecione'
          'Janeiro'
          'Fevereiro'
          'Mar'#231'o'
          'Abril'
          'Maio'
          'Junho'
          'Julho'
          'Agosto'
          'Setembro'
          'Outubro'
          'Novembro'
          'Dezembro')
      end
      object cbxAnoLote: TComboBox
        Left = 17
        Top = 56
        Width = 88
        Height = 21
        TabOrder = 3
        OnClick = cbxAnoLoteClick
        Items.Strings = (
          'Selecione'
          '2018'
          '2017'
          '2016'
          '2015'
          '2014')
      end
      object dtDataInicial: TDateTimePicker
        Left = 291
        Top = 54
        Width = 94
        Height = 21
        Date = 42370.376240046300000000
        Time = 42370.376240046300000000
        TabOrder = 4
      end
      object dtDataFinal: TDateTimePicker
        Left = 391
        Top = 54
        Width = 94
        Height = 21
        Date = 42400.376240046300000000
        Time = 42400.376240046300000000
        TabOrder = 5
      end
      object dbgHistorico: TDBGrid
        Left = 17
        Top = 175
        Width = 89
        Height = 58
        DataSource = dtsHistorico
        TabOrder = 6
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = dbgHistoricoCellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'ID_TITULO_PAGAR'
            Visible = True
          end>
      end
      object dbgTitulo: TDBGrid
        Left = 17
        Top = 116
        Width = 90
        Height = 53
        DataSource = dtsTituloPagar
        TabOrder = 7
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taRightJustify
            Color = clSilver
            Expanded = False
            FieldName = 'ID_TITULO_PAGAR'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Width = 30
            Visible = True
          end>
      end
      object dbgCentroCusto: TDBGrid
        Left = 16
        Top = 239
        Width = 91
        Height = 58
        DataSource = dtsCentroCusto
        TabOrder = 8
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'ID_TITULO_PAGAR'
            Visible = True
          end>
      end
      object btnImprimir: TBitBtn
        Left = 491
        Top = 85
        Width = 75
        Height = 25
        Caption = 'Imprimir'
        TabOrder = 9
        OnClick = btnImprimirClick
      end
      object DBGrid1: TDBGrid
        Left = 128
        Top = 116
        Width = 357
        Height = 65
        DataSource = dtsTituloReceber
        TabOrder = 10
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'ID_TITULO_RECEBER'
            Width = 36
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NUMERO_DOCUMENTO'
            Width = 70
            Visible = True
          end>
      end
      object DBGrid2: TDBGrid
        Left = 128
        Top = 187
        Width = 357
        Height = 65
        DataSource = dtsHistoricoTR
        TabOrder = 11
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'ID_TITULO_RECEBER'
            Width = 36
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Width = 70
            Visible = True
          end>
      end
      object DBGrid3: TDBGrid
        Left = 128
        Top = 258
        Width = 357
        Height = 65
        DataSource = dtsCentroCustoTR
        TabOrder = 12
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'ID_TITULO_RECEBER'
            Width = 36
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Width = 70
            Visible = True
          end>
      end
    end
    object tbsTabRegistros: TTabSheet
      Caption = 'Registros'
      ImageIndex = 7
      OnShow = tbsTabRegistrosShow
      object lblOrgCodinome: TLabel
        Left = 24
        Top = 80
        Width = 47
        Height = 13
        Caption = 'Codinome'
      end
      object lblOrgSerial: TLabel
        Left = 232
        Top = 80
        Width = 26
        Height = 13
        Caption = 'Serial'
      end
      object lblOrgLicenca: TLabel
        Left = 24
        Top = 112
        Width = 63
        Height = 13
        Caption = 'lblOrgLicenca'
      end
      object lblOrgSistema: TLabel
        Left = 232
        Top = 112
        Width = 79
        Height = 13
        Caption = 'Sistema Cont'#225'bil'
      end
      object lblOrgCnpj: TLabel
        Left = 24
        Top = 144
        Width = 22
        Height = 13
        Caption = 'Cnpj'
      end
      object lblOrgIpServerBD: TLabel
        Left = 228
        Top = 144
        Width = 83
        Height = 13
        Caption = 'lblOrgIpServerBD'
      end
      object lblOrgPathMega: TLabel
        Left = 24
        Top = 176
        Width = 76
        Height = 13
        Caption = 'lblOrgPathMega'
      end
      object lblOrgSerialMega: TLabel
        Left = 336
        Top = 176
        Width = 80
        Height = 13
        Caption = 'lblOrgSerialMega'
      end
      object lblOrgPathExeMega: TLabel
        Left = 336
        Top = 208
        Width = 94
        Height = 13
        Caption = 'lblOrgPathExeMega'
      end
      object lblOrgCodigoMega: TLabel
        Left = 24
        Top = 208
        Width = 87
        Height = 13
        Caption = 'lblOrgCodigoMega'
      end
      object btnRegistrar: TButton
        Left = 560
        Top = 280
        Width = 105
        Height = 25
        Caption = 'Registrar'
        TabOrder = 0
        OnClick = btnRegistrarClick
      end
      object cbxOrganizacoes: TComboBox
        Left = 24
        Top = 40
        Width = 457
        Height = 21
        ItemIndex = 0
        TabOrder = 1
        Text = 'Organiza'#231#245'es'
        Items.Strings = (
          'Organiza'#231#245'es')
      end
      object btnSelect: TButton
        Left = 514
        Top = 36
        Width = 87
        Height = 25
        Caption = 'Selecionar'
        TabOrder = 2
        OnClick = btnSelectClick
      end
    end
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 280
    Top = 432
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrHourGlass
    Left = 376
    Top = 432
  end
  object DrvLnk: TFDPhysFBDriverLink
    Left = 208
    Top = 432
  end
  object FinanceBackup: TFDIBBackup
    DriverLink = DrvLnk
    Protocol = ipTCPIP
    Host = '127.0.0.1'
    UserName = 'SYSDBA'
    Password = 'masterkey'
    Left = 592
    Top = 432
  end
  object FinanceRestore: TFDIBRestore
    Left = 672
    Top = 432
  end
  object AttachmentDialog: TOpenDialog
    Left = 24
    Top = 432
  end
  object dlgOrigem: TOpenDialog
    Left = 160
    Top = 432
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 536
    Top = 432
  end
  object VCLZip1: TVCLZip
    ThisReleaseLevel = 'Release'
    Left = 96
    Top = 432
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 872
    Top = 504
  end
  object QueryTPS: TFDQuery
    Connection = dmConexao.Conn
    Left = 536
    Top = 16
  end
  object IdAntiFreeze1: TIdAntiFreeze
    IdleTimeOut = 1000
    Left = 472
    Top = 432
  end
  object dtsTituloPagar: TDataSource
    OnDataChange = dtsTituloPagarDataChange
    Left = 592
    Top = 192
  end
  object dtsHistorico: TDataSource
    Left = 592
    Top = 304
  end
  object dtsCentroCusto: TDataSource
    Left = 592
    Top = 248
  end
  object dtsTituloReceber: TDataSource
    OnDataChange = dtsTituloReceberDataChange
    Left = 480
    Top = 192
  end
  object dtsHistoricoTR: TDataSource
    Left = 480
    Top = 248
  end
  object dtsCentroCustoTR: TDataSource
    Left = 480
    Top = 304
  end
end
