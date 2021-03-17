object frmInfoUpdate: TfrmInfoUpdate
  Left = 0
  Top = 0
  HorzScrollBar.Color = clBtnShadow
  HorzScrollBar.ParentColor = False
  BorderIcons = []
  Caption = 'Atualiza'#231#227'o necess'#225'ria'
  ClientHeight = 512
  ClientWidth = 850
  Color = clBtnFace
  TransparentColorValue = clSilver
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 850
    Height = 512
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 372
    ExplicitHeight = 190
    object img: TImage
      Left = 1
      Top = 1
      Width = 848
      Height = 49
      Align = alTop
      ExplicitWidth = 948
    end
    object lbl1: TLabel
      Left = 105
      Top = 61
      Width = 103
      Height = 13
      Caption = 'URL para o Download'
    end
    object lblStatus: TLabel
      Left = 241
      Top = 61
      Width = 152
      Height = 13
      Caption = 'Baixando ....'
      Visible = False
    end
    object btnFechar: TBitBtn
      Left = 639
      Top = 111
      Width = 161
      Height = 25
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = btnFecharClick
    end
    object btnDown: TBitBtn
      Left = 620
      Top = 371
      Width = 180
      Height = 25
      Caption = 'Download'
      TabOrder = 0
      Visible = False
      OnClick = btnDownClick
    end
    object Memo1: TMemo
      Left = 105
      Top = 163
      Width = 510
      Height = 166
      Lines.Strings = (
        'Pempec Enterprise Finance 2000 - Finance 2K'
        ''
        'Informamos que existe uma nova vers'#227'o dispon'#237'vel.'
        'Acesse o site www.pempec.com.br'
        'Clique no menu Download'
        'Baixe a vers'#227'o de instala'#231#227'o '
        'Execute o instalador'
        'Obs. Execute o arquivo de instala'#231#227'o como Administrador.'
        ''
        'Agradecemos pela prefer'#234'ncia.')
      TabOrder = 2
    end
    object edtUrl: TEdit
      Left = 105
      Top = 80
      Width = 510
      Height = 21
      TabOrder = 3
    end
    object ckbOpcao: TCheckBox
      Left = 105
      Top = 107
      Width = 288
      Height = 17
      Cursor = crHandPoint
      Caption = 'Encerrar o sistema ap'#243's o Download'
      TabOrder = 4
    end
    object pbProgresso: TProgressBar
      Left = 188
      Top = 450
      Width = 510
      Height = 18
      TabOrder = 5
      Visible = False
    end
    object btnCancelar: TBitBtn
      Left = 725
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 6
      OnClick = btnCancelarClick
    end
    object btnBaixar: TBitBtn
      Left = 639
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Baixar'
      TabOrder = 7
      OnClick = btnBaixarClick
    end
    object dxStatusBar: TdxStatusBar
      Left = 1
      Top = 491
      Width = 848
      Height = 20
      Panels = <
        item
          PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
          Width = 200
        end
        item
          PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
          Width = 400
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
  end
  object IdHttp: TIdHTTP
    OnWork = IdHttpWork
    OnWorkBegin = IdHttpWorkBegin
    OnWorkEnd = IdHttpWorkEnd
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
    Left = 704
    Top = 304
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 704
    Top = 264
  end
  object dlgSave: TSaveDialog
    Left = 704
    Top = 208
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
    Left = 32
    Top = 104
  end
end
